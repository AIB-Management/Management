package com.gdaib.controller;

import com.gdaib.pojo.*;
import com.gdaib.service.DepartmentService;
import com.gdaib.service.MailService;
import com.gdaib.service.NavigationServer;
import com.gdaib.service.UsersService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author:马汉真
 * @Date: 17-5-9
 * @role:
 */
@Controller
public class ManageController {
    private static final String ROOTPAGE = "/admin/rootpage.jsp";


    @Autowired
    private UsersService usersService;

    @Autowired
    private DepartmentService departmentService;


    @Autowired
    private NavigationServer navigationServer;

    @Autowired
    private MailService mailService;

    private static final String FROMADDRESS = "18707513901@163.com";


    /**
     * 转发到管理员页面
     */
    @RequestMapping("/admin/rootPage")
    public ModelAndView rootPage() throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName(ROOTPAGE);

        return modelAndView;

    }




    /**
     * 得到所有系
     */
    @RequestMapping("/admin/ajaxGetAllDepartment")
    @ResponseBody
    public Msg ajaxGetAllDepartment() throws Exception {
        List<Department> allDepartment = departmentService.getAllDepartment();
        Msg msg = new Msg(100, "请求成功");
        msg.add("Department", allDepartment);
        return msg;
    }





    /**
     * 得到未审核的数量
     */
    @RequestMapping("/admin/ajaxGetCountIsNotPass")
    @ResponseBody
    public Msg ajaxGetCountIsNotPass() throws Exception {

        int num = usersService.findAccountInfoCountByCharacter( "reviewing");
        Msg msg = new Msg(100,"请求成功");
        msg.add("num",num);

//        return msg;
        return Msg.success().add("num", num);

    }

    /**
     * 得到未验证用户的分页信息，传入当前页数
     */
    @RequestMapping("/admin/ajaxGetAccountInfoIsNotPass")
    @ResponseBody
    public Msg ajaxGetAccountInfoIsNotPass(@RequestParam(value = "pn", defaultValue = "1") Integer pn) throws Exception {
        // 引入PageHelper分页插件
        // 在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn, 5);


        List<AccountInfo> accountInfo = usersService.findAccountInfoByCharacter("reviewing",null);
        PageInfo page = new PageInfo(accountInfo,5);
        return Msg.success().add("page",page);

    }


    /**
     * 得到已验证用户的分页信息，传入当前页数和系Id，如果无系id就是查询所有
     */
    @RequestMapping("/admin/ajaxGetAccountInfoIsPass")
    @ResponseBody
    public Msg ajaxGetAccountInfoIsPass(@RequestParam(value = "pn",defaultValue = "1") Integer pn,String departmentId) throws Exception {



        // 引入PageHelper分页插件
    // 在查询之前只需要调用，传入页码，以及每页的大小
    PageHelper.startPage(pn,5);
    List<AccountInfo>   accountInfo = usersService.findAccountInfoByCharacter("teacher",departmentId);

    PageInfo page = new PageInfo(accountInfo,5);
        return Msg.success().add("page",page);
}


    /**
     *      通过验证,单个多个二合一
     */
    @RequestMapping("/admin/ajaxPassAccount")
    @ResponseBody
    public Msg ajaxPassAccount(String id) throws Exception {
        if(id == null || id.equals("")){
            return Msg.fail();

        }else{
            List<Integer> ids = new ArrayList<Integer>();
            //验证字符串是否带有逗号，有就是多个
            if (id.contains(",")){


                //得到的字符串切割
                String[] split = id.split(",");
                for(String sp : split){
                    ids.add(Integer.parseInt(sp));
                }



            }else{
                ids.add(Integer.parseInt(id));
            }

            usersService.updateBatchAccountByCharacter(ids,"teacher");

        }

        return Msg.success();
    }


    /**

     *      拒绝验证,单个多个二合一


     */
    @RequestMapping("/admin/ajaxRejectAccount")
    @ResponseBody
    public Msg ajaxRejectAccount(String id, String content, HttpServletRequest request) throws Exception {
        if(id == null || id.equals("")){
            return Msg.fail();

        }else{


            MailPojo mailPojo = new MailPojo();
            List<Integer> ids = new ArrayList<Integer>();


            //验证字符串是否带有逗号，有就是多个
            if (id.contains(",")){
                //得到的字符串切割
                String[] split = id.split(",");

                //遍历切割的字符串，把所有id加入list中
                for(String sp : split){
                    ids.add(Integer.parseInt(sp));
                }


                //查询list中所有的用户
                List<AccountInfo> accountInfos = usersService.findAccountInfoForId(ids);
                if(accountInfos.size() != ids.size()){
                        return new Msg(200,"用户不存在");
                }



                //保存接受者的邮箱
                StringBuffer stringBuffer = new StringBuffer();


                //遍历
                for(AccountInfo accountInfo:accountInfos){

                    //查看是否状态为未验证
                    if(!accountInfo.getRole().equals("reviewing")){
                        return new Msg(200,"状态错误，用户不是未审核用户");
                    }

                    stringBuffer.append(accountInfo.getMail() + ";");

                }
                stringBuffer.deleteCharAt(stringBuffer.length()-1);
                mailPojo.setToAddresses(stringBuffer.toString());




            }else {//否则就是单个
                ids.add(Integer.parseInt(id));
                List<AccountInfo> accountInfos = usersService.findAccountInfoForId(ids);


                if(accountInfos.size() == 0){
                    return new Msg(200,"该用户不存在");
                }

                AccountInfo accountInfo = accountInfos.get(0);
                //查看是否状态为未验证
                if(!accountInfo.getRole().equals("reviewing")){
                    return new Msg(200,"状态错误，该用户不是未审核用户");
                }

                //发送的地址
                mailPojo.setToAddresses(accountInfo.getMail());


            }



            //发送的标题
            mailPojo.setSubject("[AIB]您的申请已被拒绝");
            //设置发送人
            mailPojo.setFromAddress(FROMADDRESS);



            //查看有没有附加信息
            if (content == null ||content.equals("") ){
                mailPojo.setContent("尊敬的用户您好，" + "管理员已经拒绝了你的申请！请重新申请。");
            }else {
                mailPojo.setContent("尊敬的用户您好，" + "管理员已经拒绝了你的申请！请重新申请。" + "原因是： "+ content);
            }

            //发送邮件
            mailService.sendAttachMail(mailPojo);

            //批量删除用户
            usersService.deleteAccountById(ids);

            return Msg.success();
        }


    }


    /**
     *      撤回“通过验证”,单个多个二合一
     */
    @RequestMapping("/admin/ajaxWithdrawAccount")
    @ResponseBody
    public Msg ajaxWithdrawAccount(String id,String content) throws Exception {


        if(id == null || id.equals("")){
            return Msg.fail();

        }else{

            MailPojo mailPojo = new MailPojo();
            List<Integer> ids = new ArrayList<Integer>();


            //验证字符串是否带有逗号，有就是多个
            if (id.contains(",")){
                //得到的字符串切割
                String[] split = id.split(",");

                //遍历切割的字符串，把所有id加入list中
                for(String sp : split){
                    ids.add(Integer.parseInt(sp));
                }

                //查询list中所有的用户
                List<AccountInfo> accountInfos = usersService.findAccountInfoForId(ids);
                if(accountInfos.size() != ids.size()){
                    return new Msg(200,"用户不存在");
                }


                //保存接受者的邮箱
                StringBuffer stringBuffer = new StringBuffer();

                //遍历
                for(AccountInfo accountInfo:accountInfos){

                    //查看是否状态为未验证
                    if(!accountInfo.getRole().equals("teacher")){
                        return new Msg(200,"状态错误，用户不是已验证用户");
                    }

                    stringBuffer.append(accountInfo.getMail() + ";");

                }
                stringBuffer.deleteCharAt(stringBuffer.length()-1);
                mailPojo.setToAddresses(stringBuffer.toString());




            }else {//否则就是单个
                ids.add(Integer.parseInt(id));
                List<AccountInfo> accountInfos = usersService.findAccountInfoForId(ids);


                if(accountInfos.size() == 0){
                    return new Msg(200,"该用户不存在");
                }

                AccountInfo accountInfo = accountInfos.get(0);
                //查看是否状态为未验证
                if(!accountInfo.getRole().equals("teacher")){
                    return new Msg(200,"状态错误，用户不是已验证用户");
                }

                //发送的地址
                mailPojo.setToAddresses(accountInfo.getMail());


            }



            //发送的标题
            mailPojo.setSubject("[AIB]您的用户状态已被更改");
            //设置发送人
            mailPojo.setFromAddress(FROMADDRESS);



            //查看有没有附加信息
            if (content == null ||content.equals("") ){
                mailPojo.setContent("尊敬的用户您好，" + "管理员已经将您的状态改为游客状态");
            }else {
                mailPojo.setContent("尊敬的用户您好，" + "管理员已经将您的状态改为游客状态" + "原因是： "+ content);
            }

            //发送邮件
            mailService.sendAttachMail(mailPojo);

            //批量更改状态
            usersService.updateBatchAccountByCharacter(ids,"reviewing");

            return Msg.success();
        }


    }


    /*  //添加导航条
    *
    * path:  http://localhost:8080/Management/admin/ajaxInsertNev.action
    *
    * Param: departmentid   系别ID
    * Param: title          导航名
    * Param: parent         上一级导航的ID 一级导航为0 默认为0
    *
    * return:msg
    * */

    @RequestMapping("/admin/ajaxInsertNev")
    @ResponseBody
    public Msg ajaxInsertNev(Navigation navigation, HttpServletRequest request) throws Exception {
        System.out.println(navigation.getTitle());

        if (navigation == null || navigation.getDepartmentid() == null || navigation.getTitle() == null) {
            return Msg.fail();
        }

        String title = navigation.getTitle();
        if(request.getCharacterEncoding().equals("iso-8859-1")){

           title = toUtf(title);
        }
        System.out.println("转换后" + title);
        navigation.setTitle(title);

        if (navigation.getParent() == null) {
            navigation.setParent(0);
        }
        navigation.setExtend(0);

        System.out.println("charaSet:" + request.getCharacterEncoding() + "navigation:" + navigation.toString());
        int result = 0;
        result = navigationServer.insertNavigation(navigation);

        if (result > 0) {
            return Msg.success();
        }

        return Msg.fail();
    }


     /*         删除导航
    *  PATH:http://localhost:8080/Management/admin/ajaxDeleteByNavId.action
    *       Param :navigationId
    *
    *       SUCCEED:{"code":100,"msg":"处理成功！","extend":{}}
    *       FAIL   :{"code":200,"msg":"处理失败！","extend":{}}
    * */

    //
    @RequestMapping("/admin/ajaxDeleteByNavId")
    @ResponseBody
    public Msg ajaxDeleteByNavId(int navigationId) throws Exception {
        if (navigationId == 0) {
            return Msg.fail();
        }

        int result = navigationServer.deleteNavByPrimaryKey(navigationId);
        System.out.println("result:" + result);
        if (result > 0) {
            return Msg.success();
        }

        return Msg.fail();
    }


    /*      更新导航名
    *      PATH:http://localhost:8080/Management/admin/ajaxUpdateNav.action
    *       Param :title,navigationId
    *
    *       SUCCEED:{"code":100,"msg":"处理成功！","extend":{}}
    *       FAIL   :{"code":200,"msg":"处理失败！","extend":{}}
    * */


    @RequestMapping("/admin/ajaxUpdateNav")
    @ResponseBody
    public Msg ajaxUpdateNav(String title, int navigationId) throws Exception {
        if (title == null || title.equals("")) {
            return Msg.fail();
        }

        if (navigationId == 0) {
            return Msg.fail();
        }
        int result = 0;

        result = navigationServer.updateNavByPrimaryKey(navigationId, toUtf(title));

        if (result > 0) {
            return Msg.success();
        }


        return Msg.fail();
    }

    private String toUtf(String param) throws Exception {
        String utfStr = new String(param.getBytes("iso-8859-1"), "utf-8");
        return utfStr;
    }

}
