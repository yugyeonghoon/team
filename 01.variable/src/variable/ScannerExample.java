package variable;

import java.util.Scanner;

public class ScannerExample {

	public static void main(String[] args) {
		//키보드 입력값을 자바 변수에 저장
		//자바의 스캐너
		Scanner scanner = new Scanner(System.in);
		
		System.out.println("아무 값이나 입력해주세요.");
		//nextLine을 만나면 프로그램 실행을 일시중지하고
		//사용자가 키보드로 값을 입력하기를 기다린다.byte b = 20;	//최대 127
		//값을 입력하고 엔터키를 누르면 사용자가 입력한 값이
		//문자열로 nextLine이 가지고 있게 된다.0
		System.out.println(scanner.nextLine());
		System.out.println("입력이 종료되었습니다.");
		
		int value1 = Integer.parseInt("10");
		
	}

}
