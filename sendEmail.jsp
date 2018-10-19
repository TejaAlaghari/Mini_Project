<%@ page import = "java.io.*, java.util.*, javax.mail.*"%>
<%@ page import = "javax.mail.internet.*, javax.activation.*"%>
<%@ page import = "javax.servlet.http.*, javax.servlet.*" %>

<%!
	public boolean sendMail(String toAddress, String subject, String content) {

		final String username = "vnr2015cse3@gmail.com";
		final String password = "VNR_cse3";

		try {
			Properties props = new Properties();
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");

			Session mailSession = Session.getInstance(props,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(username, password);
					}
			});

			Message message = new MimeMessage(mailSession);
			
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toAddress));
			
			message.setSubject(subject);
			message.setText(content);

			Transport.send(message);

			return(true);
		}
		catch(Exception e){
			return(false);
		}
	}
%>