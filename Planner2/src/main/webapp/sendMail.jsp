<%@page import="jakarta.mail.MessagingException"%>
<%@page import="jakarta.mail.internet.AddressException"%>
<%@page import="jakarta.mail.Transport"%>
<%@page import="jakarta.mail.Message"%>
<%@page import="jakarta.mail.internet.InternetAddress"%>
<%@page import="jakarta.mail.internet.MimeMessage"%>
<%@page import="jakarta.mail.PasswordAuthentication"%>
<%@page import="jakarta.mail.Authenticator"%>
<%@page import="jakarta.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//signup.jsp에서 회원가입 하고자 하는 사용자가 이메일 입력창에 입력한 
	//메일 주소를 받는다.
	String to = request.getParameter("mail");

//이메일 인증 코드 생성
		//이메일 인증코드를 생성할 때 사용할 문자들
		String code = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
		String mailCode = "";
		
		//이메일 인증코드를 반복문을 동작하면서 생성
		//6자리의 인증코드를 생성
		for(int i = 0; i < 6; i ++) {
			//code 문자열이 가질 수 있는 인덱스 내에서 랜덤한 정수를 뽑는다.
			int random = (int)(Math.random() * code.length());
			//이메일 인증코드를 생성할 때 사용한 문자들 중 하나씩 랜덤하게 뽑는다.
			char text = code.charAt(random);
			mailCode += text;
		}
		
		//1. 네이버 이메일로 메일 발송
		
		//네이버 smtp 서버 주소
		String host = "smtp.naver.com";
		
		//네이버 메일 주소(발송자)1
		String user = "yuh3295@naver.com";
		
		//네이버 계정 비밀번호(2차 인증번호)
		String password = "HPNQ8QZM2QZR";
		
		//수신자 메일 주소
		//String to = "yuh3295@naver.com";
		
		//메일 제목
		String title = "이메일 테스트";
		
		//메일 본문
		String body = "";
		body += "<div>";
		body += "	<span>이메일 인증 번호는 </span>";
		body += "	<span style='color:red;'>"+mailCode+"</span>";
		body += "</div>";
				
		
		//메일 전송 정보를 담는 객체 생성
		Properties props = new Properties();
		
		//stmp서버 정보를 담기
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		
		
		//메일 전송객체 생성
		Session mailSession = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
		
		//메일 발송 
		MimeMessage message = new MimeMessage(mailSession);
				
		try {
			//발송자 정보
			message.setFrom(new InternetAddress(user));
			
			//수신자 정보
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			
			//메일 제목
			message.setSubject(title);
			
			//메일 내용
			message.setContent(body, "text/html; charset=utf-8");
			
			//전송
			Transport.send(message);
			out.print(mailCode);
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			out.print("fail");
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			out.print("fail");
		}
%>