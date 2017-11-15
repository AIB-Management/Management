package com.gdaib.service.impl;

import com.gdaib.mapper.AccountMapper;
import com.gdaib.mapper.UsersMapper;
import com.gdaib.pojo.Account;
import com.gdaib.pojo.AccountExample;
import com.gdaib.pojo.MailPojo;
import com.gdaib.service.MailService;
import com.gdaib.util.Utils;
import com.github.pagehelper.PageHelper;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.apache.shiro.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import java.sql.Time;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.UUID;
import java.util.logging.Logger;

/**
 * @Author:马汉真
 * @Date: 17-5-6
 * @role:
 */
public class MailServiceImpl implements MailService {

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private MimeMessage mimeMessage;

    @Autowired
    private UsersMapper usersMapper;

    @Autowired
    private AccountMapper accountMapper;

    @Value("${MAIL_USERNAME}")
    private String MAIL_USERNAME;
    @Value("${MAIL_SUBJECT}")
    private String MAIL_SUBJECT;
    @Value("${MAIL_CONTENT_BEFORE}")
    private String MAIL_CONTENT_BEFORE;
    @Value("${MAIL_CONTENT_AFTER}")
    private String MAIL_CONTENT_AFTER;

    @Value("${LOCAL_BASE_URL}")
    public String LOCAL_BASE_URL;
    @Value("${MODIFY_PASSWORD_URL}")
    public String MODIFY_PASSWORD_URL;


    private static Logger logger = Logger.getLogger("MailServiceImpl.class");

    /**
     * 发送html格式的，带附件的邮件
     */
    @Override
    public void sendAttachMail(String toAddress, String subject, String content) {
        try {
            MimeMessageHelper mailMessage = new MimeMessageHelper(
                    this.mimeMessage, true, "UTF-8");
            // 设置邮件消息的发送者
            mailMessage.setFrom(MAIL_USERNAME);

            // 设置邮件消息的主题 （标题）
            if (org.springframework.util.StringUtils.isEmpty(subject)) {
                mailMessage.setSubject(MAIL_SUBJECT);
            } else {
                mailMessage.setSubject(subject);
            }

            // 设置邮件消息发送的时间
            mailMessage.setSentDate(new Date());

            // 设置邮件正文，true表示以html的格式发送

            StringBuffer sb = new StringBuffer();
            sb.append(MAIL_CONTENT_BEFORE);
            sb.append(content);
            sb.append(MAIL_CONTENT_AFTER);
            mailMessage.setText(sb.toString(), true);

            // 得到要发送的地址数组
            String[] toAddresses = toAddress.split(";");

            for (int i = 0; i < toAddresses.length; i++) {
                mailMessage.setTo(toAddresses[i]);
            /*
            *  for (String fileName : mail.getAttachFileNames()) {
            *   mailMessage.addAttachment(fileName, new File(fileName));
            *  }
            * */

                // 发送邮件
                long time1 = new Date().getTime();
                mailSender.send(mimeMessage);
                Utils.out(new Date().getTime() - time1);

                logger.info("send mail ok=" + toAddresses[i]);
            }

        } catch (Exception e) {
            logger.info(e.toString());
            e.printStackTrace();
        }

    }


    /**
     * 生成UUID和过期时间赋值给用户和url
     */
    public String insertTimeAndUUID(String username) throws Exception {


        //生成uuid
        String uuid = Utils.getUUid();
        Utils.out("uuid >>>>" + uuid);
        //设置30分钟后过期
        Timestamp timestamp = new Timestamp(System.currentTimeMillis() / 1000 * 1000 + 30 * 60 * 1000);

        //把uuid和时间都保存到数据库中
        Account account = new Account();
        account.setValidatacode(uuid);
        account.setOutdate(timestamp);

        AccountExample accountExample = new AccountExample();
        AccountExample.Criteria criteria = accountExample.createCriteria();
        criteria.andUsernameEqualTo(username);


        accountMapper.updateByExampleSelective(account, accountExample);


        // 忽略毫秒数  mySql 取出时间是忽略毫秒数的,之后加上uuid
        String code = timestamp.getTime() + "&" + uuid;

        //生成盐值
        Object salt = ByteSource.Util.bytes(username);
        //生成md5加密
        Object md5 = new SimpleHash("MD5", code, salt, 1024);

        return md5.toString();
    }

    //检查是否超时
    @Override
    public boolean checkIsOutTime(String username) throws Exception {
        //得到系统的超时时间
        Date date = usersMapper.findOutDateByAccount(username);
        //如果用户名不存在，会返回null
        if (date == null) {
            return false;
        }
        Timestamp timestamp = new Timestamp(date.getTime());

        //如果数据库的时间小于现在的时间，表示已经超时了
        if (timestamp.getTime() <= System.currentTimeMillis()) {
            return false;
        }

        return true;
    }

    /**
     * 校验数据
     */
    public String checkValueIsTrue(String username, String Code) throws Exception {

        if (username.equals("") || Code.equals("")) {
            return "参数不完整，请重新申请";
        }
        AccountExample accountExample = new AccountExample();
        AccountExample.Criteria criteria = accountExample.createCriteria();
        criteria.andUsernameEqualTo(username);

        List<Account> accounts = accountMapper.selectByExample(accountExample);
        if (accounts == null) {
            return "用户不存在";
        }
        Account account = accounts.get(0);


        Utils.out(account.getOutdate() + ":" + account.getValidatacode());

        Timestamp timestamp = new Timestamp(account.getOutdate().getTime());

        String MD5code = timestamp.getTime() + "&" + account.getValidatacode();
        Utils.out("MD5code:" + MD5code);
        //生成盐值
        Object salt = ByteSource.Util.bytes(username);
        //生成md5加密
        Object md5 = new SimpleHash("MD5", MD5code, salt, 1024);
        String md5Code = md5.toString();
        if (!(md5Code).equals(Code)) {
            return "链接错误，请重新申请！！！!";
        }


        return null;
    }

    /**
     * 密码输入是否一致
     */
    public boolean checkpwdIsTrue(String pwd, String confirmpwd) throws Exception {
        if (pwd.equals(confirmpwd)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 修改密码
     */
    @Override
    public void ModifyPassword(String username, String pwd) throws Exception {
        Account account = new Account();
        //对账号密码进行加密
        Object salt = ByteSource.Util.bytes(username);

        Object md5 = new SimpleHash("MD5", pwd, salt, 1024);

        account.setPassword(md5.toString());


        AccountExample accountExample = new AccountExample();
        AccountExample.Criteria criteria = accountExample.createCriteria();
        criteria.andUsernameEqualTo(username);
        accountMapper.updateByExampleSelective(account, accountExample);

    }

    //修改UUID
    public void updateUUID(String username) throws Exception {
        //生成uuid
        String uuid = Utils.getUUid();
        Account account = new Account();
        account.setValidatacode(uuid);

        AccountExample accountExample = new AccountExample();
        AccountExample.Criteria criteria = accountExample.createCriteria();
        criteria.andUsernameEqualTo(username);

        accountMapper.updateByExampleSelective(account, accountExample);
    }


    public String getModifyPassWordUrl() {
        return MODIFY_PASSWORD_URL;
    }

    @Override
    public String getLocalBaseUrl() {
        return LOCAL_BASE_URL;
    }

    public JavaMailSender getMailSender() {
        return mailSender;
    }

    public void setMailSender(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public MimeMessage getMimeMessage() {
        return mimeMessage;
    }

    public void setMimeMessage(MimeMessage mimeMessage) {
        this.mimeMessage = mimeMessage;
    }
}
