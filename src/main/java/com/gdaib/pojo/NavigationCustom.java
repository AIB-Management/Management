package com.gdaib.pojo;

import java.util.List;

public class NavigationCustom extends Navigation{


    private List<NavigationCustom> chiren;


    @Override
    public String toString() {
        String s = super.toString();
        return s + "NavigationCustom{" +
                "chiren=" + chiren +
                '}';
    }

    public void setChiren(List<NavigationCustom> chiren) {
        this.chiren = chiren;
    }


    public List<NavigationCustom> getChiren() {
        return chiren;
    }

}