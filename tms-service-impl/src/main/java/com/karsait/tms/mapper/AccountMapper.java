package com.karsait.tms.mapper;

import com.karsait.tms.entity.Account;
import com.karsait.tms.entity.AccountExample;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface AccountMapper {
    long countByExample(AccountExample example);

    int deleteByExample(AccountExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Account record);

    int insertSelective(Account record);

    List<Account> selectByExample(AccountExample example);

    Account selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Account record, @Param("example") AccountExample example);

    int updateByExample(@Param("record") Account record, @Param("example") AccountExample example);

    int updateByPrimaryKeySelective(Account record);

    int updateByPrimaryKey(Account record);

    List<Account> findAllWithRoles();

    List<Account> findAllWithRolesByQueryParam(Map<String, Object> requestParam);

}