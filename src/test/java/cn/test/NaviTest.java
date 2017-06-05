package cn.test;

import com.gdaib.mapper.NavigationMapper;
import com.gdaib.pojo.*;
import com.gdaib.service.RunasService;
import com.gdaib.service.UsersService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by znho on 2017/5/29.
 */
//使用Spring的测试
@RunWith(SpringJUnit4ClassRunner.class)
//得到webapplication的ioc容器
@WebAppConfiguration
//加入mvc和spring的配置文件
@ContextConfiguration(locations = {"classpath:config/spring/application-*.xml", "classpath:config/spring/Springmvc.xml"})

public class NaviTest {

    @Autowired
    public NavigationMapper navigationMapper;
    public List<Navigation> returnList = new ArrayList<Navigation>();


    List<NavigationCustom> navigationCustomList = new ArrayList<NavigationCustom>();
    @Test
    public void NavTest(){
//        NavigationExample navigationExample = new NavigationExample();
//        NavigationExample.Criteria criteria = navigationExample.createCriteria();
//        criteria.andDepartmentidEqualTo(100);
//        criteria.andParentEqualTo(1);
//
//        List<Navigation> navigations = navigationMapper.selectByExample(navigationExample);
//
//        //转换为NavigationCustom的list
//        List<NavigationCustom> navigationCustoms = toCustom(navigations);
//
//
//
//        System.out.println(navigationCustoms);
//
//        //遍历二级导航，查找出是否存在自导航
//        for(NavigationCustom navigationCustom: navigationCustoms){
//            //如果有子导航
//            if(navigationCustom.getUrl() == null || navigationCustom.getUrl().equals("")){
//                //传入系Id和父导航id
//                List<NavigationCustom> childNav = getChildNav(100, navigationCustom.getId());
//                navigationCustom.setChiren(childNav);
//                navigationCustomList.add(navigationCustom);
//            }else {//如果没有子导航
//                //加入list中
//                navigationCustomList.add(navigationCustom);
//            }
//
//        }
//        System.out.println("最终：" + navigationCustomList);

        List<NavigationCustom> childNav = getChildNav(100, 1);
        System.out.println(childNav);


    }

    @Test
    public void test2(){
        getChildNav(100,2);
    }

    //找到子导航
    private List<NavigationCustom> getChildNav(Integer DepartmentId, Integer ParentId) {

        //根据两个参数查找对应的子导航
        NavigationExample navigationExample = new NavigationExample();
        NavigationExample.Criteria criteria = navigationExample.createCriteria();
        criteria.andDepartmentidEqualTo(DepartmentId);
        criteria.andParentEqualTo(ParentId);

        List<Navigation> navigations = navigationMapper.selectByExample(navigationExample);

        //转换为NavigationCustom的list
        List<NavigationCustom> navigationCustoms = toCustom(navigations);

        List<NavigationCustom> childNavigationCustoms = new ArrayList<NavigationCustom>();

        //遍历导航，查找出是否存在子导航
        for(NavigationCustom navigationCustom: navigationCustoms){
            //如果有子导航
            if(navigationCustom.getUrl() == null || navigationCustom.getUrl().equals("")){
                //传入系Id和父导航id
                List<NavigationCustom> childNav = getChildNav(100, navigationCustom.getId());
                navigationCustom.setChiren(childNav);

                childNavigationCustoms.add(navigationCustom);
                System.out.print("");
            }else {//如果没有子导航
                //加入list中
                childNavigationCustoms.add(navigationCustom);
            }

        }
        System.out.println(childNavigationCustoms);

        return childNavigationCustoms;

    }

    private List<NavigationCustom> toCustom(List<Navigation> navigations) {
        List<NavigationCustom> navigationCustoms = new ArrayList<NavigationCustom>();
        for(Navigation navigation : navigations){
            NavigationCustom navigationCustom = new NavigationCustom();
            //将父类转换为子类
            fatherToChild(navigation,navigationCustom);

            navigationCustoms.add(navigationCustom);
        }

        return  navigationCustoms;

    }

    @Test
    public void Test(){
        Navigation navigation = new Navigation();
        navigation.setId(1);
        navigation.setDepartmentid(232);

        NavigationCustom navigationCustom = new NavigationCustom();
        fatherToChild(navigation,navigationCustom);
        System.out.println(navigationCustom);
    }


    //反射方法，将父类转换为子类
    public static void fatherToChild (Object father,Object child){
        if(!(child.getClass().getSuperclass()==father.getClass())){
            System.err.println("child不是father的子类");
        }
        Class fatherClass= father.getClass();
        Field ff[]= fatherClass.getDeclaredFields();
        for(int i=0;i<ff.length;i++){
            Field f=ff[i];//取出每一个属性，如deleteDate
            Class type=f.getType();
            try {
                Method m = fatherClass.getMethod("get"+upperHeadChar(f.getName()));//方法getDeleteDate
                f.setAccessible(true);
                Object obj=m.invoke(father);//取出属性值
                f.set(child,obj);
            } catch (SecurityException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (IllegalArgumentException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (NoSuchMethodException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }
    /**
     * 首字母大写，in:deleteDate，out:DeleteDate
     */
    public static String upperHeadChar(String in){
        String head=in.substring(0,1);
        String out=head.toUpperCase()+in.substring(1,in.length());
        return out;
    }


    @Autowired
    public UsersService usersService;
    @Autowired
    public RunasService runasService;

    
    
    @Test
    public void test3() throws Exception {
        runasService.grant("lalalala","5edbf5edbf");
    }






}
