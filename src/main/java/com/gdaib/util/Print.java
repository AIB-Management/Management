package com.gdaib.util;

/**
 * Created by tom on 17-5-1.
 */
public class Print {
    public static final Integer PRINT_CODE =1;

    public static void out(String print){
        if(PRINT_CODE ==1){
            System.out.print(print);
        }
    }
}
