package com.eyewear.utils;

import java.util.List;

public class Tested {
	public static boolean contains(List<Long> list, Long value) {
        return list != null && list.contains(value);
    }
}
