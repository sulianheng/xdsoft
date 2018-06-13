package com.xdsoft.mvc.util;

import org.apache.commons.lang3.RandomUtils;

/**
 * @author reyenxu 生成随机数
 */

public class RandomNumUtil implements Runnable {

	public static void main(String[] args) {
		for (int i = 0; i < 100; i++) {
			System.out.println(RandomNum(0, 50));
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

	/**
	 * @author reyenxu
	 * @param int
	 *            min
	 * @param int
	 *            max
	 */
	public static int RandomNum(int min, int max) {
		int average = (int) ((min + max) / 2);
		int min_sqr = min * min;
		int max_sqr = max * max;
		int random = RandomUtils.nextInt(min_sqr, max_sqr);
		int result = (int) Math.sqrt(random);
		result = 2 * average - result;
		if (result > 40) {
			result -= 38;
		} else if (result>20) {
			result -= 8;
		} else if (result <10){
			result += 3 ;
		}
		return result;

	}

	public void run() {
		// TODO Auto-generated method stub

	}

}
