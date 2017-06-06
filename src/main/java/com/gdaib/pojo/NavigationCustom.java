package com.gdaib.pojo;

import java.util.List;

public class NavigationCustom {

    private Navigation navigation;

    public Navigation getNavigation() {
        return navigation;
    }

    public void setNavigation(Navigation navigation) {
        this.navigation = navigation;
    }

    private List<NavigationCustom> chiren;



    public void setChiren(List<NavigationCustom> chiren) {
        this.chiren = chiren;
    }


    public List<NavigationCustom> getChiren() {
        return chiren;
    }

}