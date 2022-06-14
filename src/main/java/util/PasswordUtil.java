package util;

import org.apache.commons.codec.digest.DigestUtils;

public class PasswordUtil {

	public static String generateSecretPassword(String userId, String password) {
		String src = password + userId + reverse(password);
		return DigestUtils.sha256Hex(src);
	}
	
	private static String reverse(String password) {
		StringBuilder sb = new StringBuilder();
		for (int index = password.length() - 1; index >= 0; index--) {
			sb.append(password.charAt(index));
		}
		return sb.toString();
	}
	
	public static void main(String[] args) {
		//System.out.println(PasswordUtil.generateSecretPassword("rltjq34", "zxcv1234"));
		//System.out.println(PasswordUtil.generateSecretPassword("kim34", "zxcv1234"));
		//System.out.println(PasswordUtil.generateSecretPassword("kori", "zxcv1234"));
		//System.out.println(PasswordUtil.generateSecretPassword("kori34", "zxcv1234"));
		System.out.println(PasswordUtil.generateSecretPassword("dbskrltjq", "zxcv1234"));
		//System.out.println(PasswordUtil.generateSecretPassword("dbskrltjq34", "zxcv1234"));
		//System.out.println(PasswordUtil.generateSecretPassword("dbsk34", "zxcv1234"));
	}
}
