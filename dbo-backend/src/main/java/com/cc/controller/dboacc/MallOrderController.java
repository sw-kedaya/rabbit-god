package com.cc.controller.dboacc;

import com.cc.service.dboacc.IMallOrderService;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/mallOrder")
public class MallOrderController {
    @Resource
    private IMallOrderService mallOrderService;

    @GetMapping("/list")
    public Result getMallOrderByUserId(Long id){
        return mallOrderService.getMallOrderByUserId(id);
    }
}
