package com.gdaib.service.impl;

import com.gdaib.mapper.UsersMapper;
import com.gdaib.pojo.Account;
import com.gdaib.pojo.MailPojo;
import com.gdaib.service.MailService;
import com.github.pagehelper.PageHelper;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.internet.MimeMessage;

import java.sql.Time;
import java.sql.Timestamp;
import java.util.Date;
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

    private static Logger logger = Logger.getLogger("MailServiceImpl.class");

    /**
     * 发送html格式的，带附件的邮件
     */
    @Override
    public void sendAttachMail(MailPojo mail) {
        try {
            MimeMessageHelper mailMessage = new MimeMessageHelper(
                    this.mimeMessage, true, "UTF-8");
            // 设置邮件消息的发送者
            mailMessage.setFrom(mail.getFromAddress());

            // 设置邮件消息的主题 （标题）
            mailMessage.setSubject(mail.getSubject());

            // 设置邮件消息发送的时间
            mailMessage.setSentDate(new Date());

            // 设置邮件正文，true表示以html的格式发送
            mailMessage.setText(mail.getContent(), true);

            // 得到要发送的地址数组
            String[] toAddresses = mail.getToAddresses().split(";");

            for (int i = 0; i < toAddresses.length; i++) {
                mailMessage.setTo(toAddresses[i]);
            /*
            *  for (String fileName : mail.getAttachFileNames()) {
            *   mailMessage.addAttachment(fileName, new File(fileName));
            *  }
            * */

                // 发送邮件
                mailSender.send(mimeMessage);
                logger.info("send mail ok=" + toAddresses[i]);
            }

        } catch (Exception e) {
            logger.info(e.toString());
            e.printStackTrace();
        }

    }

    /**
     *      生成UUID和过期时间赋值给用户和url
     */
    public String insertTimeAndUUID(String username) throws Exception {


        //生成uuid
        String uuid = UUID.randomUUID().toString();
        System.out.println("uuid >>>>" + uuid);
        //设置30分钟后过期
        Timestamp timestamp = new Timestamp(System.currentTimeMillis()/1000*1000 + 30 * 60 * 1000);

        //把uuid和时间都保存到数据库中
        Account account = new Account();
        account.setValidatacode(uuid);
        account.setOutdate(timestamp);
        account.setUsername(username);
        usersMapper.updateCodeAndDate(account);


        // 忽略毫秒数  mySql 取出时间是忽略毫秒数的,之后加上uuid
        String code = timestamp.getTime() + "&" + uuid;

        //生成盐值
        Object salt = ByteSource.Util.bytes(username);
        //生成md5加密
        Object md5 = new SimpleHash("MD5",code,salt,1024);

        return md5.toString();
    }

    //检查是否超时
    @Override
    public boolean checkIsOutTime(String username) throws Exception {
        //得到系统的超时时间
        Date date = usersMapper.findOutDateByAccount(username);
        //如果用户名不存在，会返回null
        if(date == null){
            return false;
        }
        Timestamp timestamp = new Timestamp(date.getTime());

        //如果数据库的时间小于现在的时间，表示已经超时了
        if(timestamp.getTime() <= System.currentTimeMillis()){
            return false;
        }

        return true;
    }

    /**
            校验数据
     *
     */
    public String checkValueIsTrue(String username,String Code)throws Exception{

        if (username.equals("") || Code.equals("")){
            return "参数不完整，请重新申请";
        }
        Account account = usersMapper.selectByUsername(username);
        System.out.println(account.getOutdate() + ":" + account.getValidatacode());

        Timestamp timestamp = new Timestamp(account.getOutdate().getTime());

        String MD5code = timestamp.getTime() + "&" + account.getValidatacode();
        System.out.println("MD5code:" + MD5code);
        //生成盐值
        Object salt = ByteSource.Util.bytes(username);
        //生成md5加密
        Object md5 = new SimpleHash("MD5",MD5code,salt,1024);
        String md5Code = md5.toString();
        if (!(md5Code).equals(Code)){
            return "链接错误，请重新申请！！！!";
        }



        return null;
    }

    /**
            密码输入是否一致
     *
     */
    public boolean checkpwdIsTrue(String pwd,String confirmpwd)throws Exception{
        if (pwd.equals(confirmpwd)){
            return true;
        }else {
            return false;
        }
    }

    /**
     *  修改密码
     */
    @Override
    public void ModifyPassword(String username, String pwd) throws Exception {
        Account account = new Account();
        account.setUsername(username);

        //对账号密码进行加密
        Object salt = ByteSource.Util.bytes(username);

        Object md5 = new SimpleHash("MD5",pwd,salt,1024);

        account.setPassword(md5.toString());

        usersMapper.updatePassword(account);

    }

    //修改UUID
    public void updateUUID(String username)throws Exception{
        //生成uuid
        String uuid = UUID.randomUUID().toString();
        Account account = new Account();
        account.setUsername(username);
        account.setValidatacode(uuid);
        usersMapper.updateCodeAndDate(account);

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
