package cn.test;

import sun.applet.Main;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by znho on 2017/4/22.
 */
public class test {

    public static void main(String[] arge){
        String check = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
        Pattern regex = Pattern.compile(check);
        Matcher matcher = regex.matcher("dffdfdf@qq.com");
        boolean isMatched = matcher.matches();

        System.out.println(isMatched);

    }


}
