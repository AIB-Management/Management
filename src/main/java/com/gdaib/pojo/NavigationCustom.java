package com.gdaib.pojo;

import java.util.List;

public class NavigationCustom extends Navigation{

    private Integer count;

    private List<NavigationCustom> chiren;

    private Navigation navigation;

    public Navigation getNavigation() {
        return navigation;
    }

    public void setNavigation(Navigation navigation) {
        this.navigation = navigation;
    }


    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public void setChiren(List<NavigationCustom> chiren) {
        this.chiren = chiren;
    }


    public List<NavigationCustom> getChiren() {
        return chiren;
    }

}