package com.karsait.tms.controller;

import com.karsait.tms.entity.Account;
import com.karsait.tms.service.AccountService;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.util.SavedRequest;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * 首页及登录、登出的控制器
 *
 * @author fankay
 */
@Controller
public class HomeController {

    @Autowired
    private AccountService accountService;

    /**
     * 系统登录页面
     *
     * @return
     */
    @GetMapping("/")
    public String index() {
        Subject subject = SecurityUtils.getSubject();

        System.out.println("isAuthenticated()?" + subject.isAuthenticated());
        System.out.println("isRemembered()?" + subject.isRemembered());

        //判断当前是否有已经认证的账号，如果有，则退出该账号
        if (subject.isAuthenticated()) {
            subject.logout();
        }

        if (subject.isRemembered()) {
            //如果当前为被记住（通过rememberMe认证），则直接跳转到登录成功页面 home
            return "redirect:/home";
        }


        return "index";
    }

    /**
     * 系统登录
     *
     * @return
     */
    @PostMapping("/")
    public String login(String accountMobile,
                        String password,
                        String rememberMe,
                        HttpServletRequest request,
                        RedirectAttributes redirectAttributes) {

        // 创建Subject对象
        Subject subject = SecurityUtils.getSubject();
        // 根据账号和密码进行登录
        String requestIp = request.getRemoteAddr();
        String passwordMD5 = DigestUtils.md5Hex(password);
        UsernamePasswordToken usernamePasswordToken =
                new UsernamePasswordToken(accountMobile, passwordMD5, rememberMe != null, requestIp);

        try {
            subject.login(usernamePasswordToken);

            //将登录成功的对象放入session（没必要）
            Account account = accountService.findByMobile(accountMobile);
            Session session = subject.getSession();
            session.setAttribute("curr_account", account);

            //登录后跳转目标的判断
            SavedRequest savedRequest = WebUtils.getSavedRequest(request);
            String url = "/home";
            if (savedRequest != null) {
                url = savedRequest.getRequestUrl();
            }

            return "redirect:" + url;
        } catch (UnknownAccountException | IncorrectCredentialsException ex) {
            ex.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "账号或密码错误");
        } catch (LockedAccountException ex) {
            ex.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "账号被锁定");
        } catch (AuthenticationException ex) {
            ex.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "账号或密码错误");
        }
        return "redirect:/";
    }

    /**
     * 登录后的首页
     *
     * @return
     */
    @GetMapping("/home")
    public String home() {
        return "home";
    }

    /**
     * 安全退出
     *
     * @return
     */
    /*@GetMapping("/logout")
    public String logout(RedirectAttributes redirectAttributes) {
        Subject subject = SecurityUtils.getSubject();
        subject.logout();

        redirectAttributes.addFlashAttribute("message","你已安全退出系统");
        return "redirect:/";
    }*/
    @GetMapping("/401")
    public String unauthorizedUrl() {
        return "error/401";
    }

}
