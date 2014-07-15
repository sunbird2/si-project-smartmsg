package com.m.billing;

import java.io.Serializable;

/**
 * Created by medialog on 14. 3. 5.
 */
public class CashVO implements Serializable {

    int idx = 0;
    String user_id = "";
    String account = "";
    int amount = 0;
    String method = "";
    String name = "";
    String timeWrite = "";

    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTimeWrite() {
        return timeWrite;
    }

    public void setTimeWrite(String timeWrite) {
        this.timeWrite = timeWrite;
    }
}
