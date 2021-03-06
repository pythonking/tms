package com.karsait.tms.util.shiro;

import com.karsait.tms.entity.Account;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Component;

@Component
public class ShiroUtil {

    public Account getCurrentAccount() {
        Subject subject = SecurityUtils.getSubject();
        return (Account) subject.getPrincipal();
    }

}
