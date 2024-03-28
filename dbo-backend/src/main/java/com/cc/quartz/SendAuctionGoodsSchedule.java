package com.cc.quartz;

import com.cc.dto.MallOrderDTO;
import com.cc.entity.Auction;
import com.cc.entity.Mall;
import com.cc.mapper.dboacc.AuctionMapper;
import com.cc.mapper.dboacc.AuctionOrderMapper;
import com.cc.mapper.dboacc.MallMapper;
import com.cc.service.dbochar.IMailService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Component
public class SendAuctionGoodsSchedule {
    @Resource
    private AuctionMapper auctionMapper;
    @Resource
    private AuctionOrderMapper auctionOrderMapper;
    @Resource
    private MallMapper mallMapper;
    @Resource
    private IMailService mailService;

    /**
     * 每天0点检查并发放已结束的拍卖商品
     */
    @Transactional("dboAccTransactionManager")
    @Scheduled(cron = "0 0 0 * * ?")
    public void sendGoodsToMail() {
        // 获取已结束且未发放的拍卖商品
        List<Auction> list = auctionMapper.selectAllEndAndUnGrant();
        if (list == null || list.isEmpty()) return;
        for (Auction auction : list) {
            // 若用户id为空则该商品无人拍卖, 跳过
            Long accountID = auction.getAccountID();
            if (accountID == null) continue;
            // 先设置已发放，再发邮件，防止设置失败后重复邮件
            Integer integer = auctionMapper.setGrant(auction.getId());
            // 设置订单状态(先设置所有失败的，最后设置一个成功的)
            Integer failed = auctionOrderMapper.setFailedStatus(auction.getId());
            Integer success = auctionOrderMapper.setSuccessStatus(auction.getId(), accountID);
            if (integer > 0 && failed > 0 && success > 0){
                // 通过商品id获取商品Tblidx和数量Count
                String charName = auction.getCharName();
                Mall mall = mallMapper.selectMallByID(auction.getMallId());
                mailService.generateAuctionMail(charName, mall.getTblidx(), mall.getCount());
            }
        }
    }
}
