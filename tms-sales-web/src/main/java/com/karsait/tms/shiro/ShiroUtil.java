package com.karsait.tms.shiro;

import com.karsait.tms.entity.TicketStore;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Component;

@Component
public class ShiroUtil {

    public TicketStore getCurrentAccount() {
        Subject subject = SecurityUtils.getSubject();
        return (TicketStore) subject.getPrincipal();
    }

}
