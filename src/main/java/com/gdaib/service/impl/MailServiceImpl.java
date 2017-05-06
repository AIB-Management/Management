package com.gdaib.service.impl;

import com.gdaib.pojo.MailPojo;
import com.gdaib.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.internet.MimeMessage;
import java.util.Date;
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
