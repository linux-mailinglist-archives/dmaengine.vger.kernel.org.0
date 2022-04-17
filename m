Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017AA5047F4
	for <lists+dmaengine@lfdr.de>; Sun, 17 Apr 2022 15:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiDQN4G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 17 Apr 2022 09:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQN4E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 17 Apr 2022 09:56:04 -0400
Received: from mail-m17657.qiye.163.com (mail-m17657.qiye.163.com [59.111.176.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327481EEC4;
        Sun, 17 Apr 2022 06:53:27 -0700 (PDT)
Received: from [192.168.3.48] (unknown [58.22.0.235])
        by mail-m17657.qiye.163.com (Hmail) with ESMTPA id EBE122800B9;
        Sun, 17 Apr 2022 21:53:23 +0800 (CST)
Message-ID: <5f13aa47-92cd-6c71-66f5-c5513a36b277@rock-chips.com>
Date:   Sun, 17 Apr 2022 21:53:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] dmaengine: pl330: Fix unbalanced runtime PM
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Huibin Hong <huibin.hong@rock-chips.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1648296988-45745-1-git-send-email-sugar.zhang@rock-chips.com>
 <YlQxy0e/39M4xTdL@matsya>
From:   sugar zhang <sugar.zhang@rock-chips.com>
In-Reply-To: <YlQxy0e/39M4xTdL@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRkfQ0xWTxoZTU9LGENOTU
        5NVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MC46GSo5ND0wLjcyPCkBSSwR
        HhMKCRlVSlVKTU5LSUtITUtPSEpDVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
        WRILWUFZTkNVSUlVS1VJSE5ZV1kIAVlBT0xPSDcG
X-HM-Tid: 0a8037ccb48bda03kuwsebe122800b9
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

在 2022/4/11 21:48, Vinod Koul 写道:
> On 26-03-22, 20:16, Sugar Zhang wrote:
>> This driver use runtime PM autosuspend mechanism to manager clk.
>>
>>    pm_runtime_use_autosuspend(&adev->dev);
>>    pm_runtime_set_autosuspend_delay(&adev->dev, PL330_AUTOSUSPEND_DELAY);
>>
>> So, after ref count reached to zero, it will enter suspend
>> after the delay time elapsed.
>>
>> The unbalanced PM:
>>
>> * May cause dmac the next start failed.
>> * May cause dmac read unexpected state.
>> * May cause dmac stall if power down happen at the middle of the transfer.
>>    e.g. may lose ack from AXI bus and stall.
>>
>> Considering the following situation:
>>
>>        DMA TERMINATE               TASKLET ROUTINE
>>              |                            |
>>              |                       issue_pending
>>              |                            |
>>              |                     pch->active = true
>>              |                       pm_runtime_get
>>    pm_runtime_put(if active)              |
>>      pch->active = false                  |
>>              |                      work_list empty
>>              |                            |
>>              |                     pm_runtime_put(force)
> maybe unconditional is a better word than force here?
okay, will do in v2.
>
>>              |                            |
>>
>> At this point, it's unbalanced(1 get / 2 put).
>>
>> After this patch:
>>
>>        DMA TERMINATE               TASKLET ROUTINE
>>              |                            |
>>              |                       issue_pending
>>              |                            |
>>              |                     pch->active = true
>>              |                       pm_runtime_get
>>    pm_runtime_put(if active)              |
>>      pch->active = false                  |
>>              |                      work_list empty
>>              |                            |
>>              |                   pm_runtime_put(if active)
>>              |                            |
>>
>> Now, it's balanced(1 get / 1 put).
>>
>> Fixes:
>> commit 5c9e6c2b2ba3 ("dmaengine: pl330: Fix runtime PM support for terminated transfers")
>> commit ae43b3289186 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12")
> That is not the right way for Fixes tag

like this?

Fixes: 5c9e6c2b2ba3 ("dmaengine: pl330: Fix runtime PM support for terminated transfers")
Fixes: ae43b3289186 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12")

>> Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
>> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
>> ---
>>
>>   drivers/dma/pl330.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
>> index 858400e..ccd430e 100644
>> --- a/drivers/dma/pl330.c
>> +++ b/drivers/dma/pl330.c
>> @@ -2084,7 +2084,7 @@ static void pl330_tasklet(struct tasklet_struct *t)
>>   		spin_lock(&pch->thread->dmac->lock);
>>   		_stop(pch->thread);
>>   		spin_unlock(&pch->thread->dmac->lock);
>> -		power_down = true;
>> +		power_down = pch->active;
>>   		pch->active = false;
>>   	} else {
>>   		/* Make sure the PL330 Channel thread is active */
>> -- 
>> 2.7.4

-- 
Best Regards!
张学广/Sugar
瑞芯微电子股份有限公司
Rockchip Electronics Co., Ltd.

