package com.eyewear.services.impl;

import com.eyewear.services.EmailService;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl implements EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${app.baseUrl}")
    private String baseUrl;

    @Override
    public void sendResetPasswordEmail(String to, String token) throws MessagingException {
        String resetUrl = baseUrl + "/reset-password?token=" + token;

        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

        helper.setTo(to);
        helper.setSubject("Reset Your Password");

        String htmlContent = String.format("""
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px;">
                <h2 style="color: #2C3E50; text-align: center;">Reset Your Password</h2>
                <div style="background-color: #f8f9fa; padding: 20px; border-radius: 5px; margin: 20px 0;">
                    <p style="color: #636363; line-height: 1.5;">
                        We received a request to reset your password. Click the button below to create a new password:
                    </p>
                    <div style="text-align: center; margin: 30px 0;">
                        <a href="%s" 
                           style="background-color: #007bff; 
                                  color: white; 
                                  padding: 12px 30px; 
                                  text-decoration: none; 
                                  border-radius: 5px; 
                                  font-weight: bold;">
                            Reset Password
                        </a>
                    </div>
                    <p style="color: #636363; font-size: 14px;">
                        If you didn't request a password reset, please ignore this email.
                        This link is valid for 5 minutes.
                    </p>
                </div>
                <div style="text-align: center; color: #636363; font-size: 12px;">
                    <p>© 2024 Eyewear Company. All rights reserved.</p>
                </div>
            </div>
        """, resetUrl);

        helper.setText(htmlContent, true);
        mailSender.send(mimeMessage);
    }
}