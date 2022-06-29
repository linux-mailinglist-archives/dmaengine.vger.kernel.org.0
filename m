Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED7B55F442
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jun 2022 05:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiF2DoM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jun 2022 23:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiF2DoL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jun 2022 23:44:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794A0167E9;
        Tue, 28 Jun 2022 20:44:09 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LXnKw61s2zTgDY;
        Wed, 29 Jun 2022 11:40:36 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 11:44:06 +0800
Received: from [10.67.102.167] (10.67.102.167) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 11:44:06 +0800
Message-ID: <928f9cf6-f6ef-cbf6-2c03-6c852bd76f6c@huawei.com>
Date:   Wed, 29 Jun 2022 11:44:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/8] dmaengine: hisilicon: Add multi-thread support for a
 DMA channel
To:     Vinod Koul <vkoul@kernel.org>
CC:     <wangzhou1@hisilicon.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220625074422.3479591-1-haijie1@huawei.com>
 <20220625074422.3479591-4-haijie1@huawei.com> <YrlMaasl+ORdDJaN@matsya>
From:   Jie Hai <haijie1@huawei.com>
In-Reply-To: <YrlMaasl+ORdDJaN@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.167]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Vkoul,

Thank you very much for your review. For a detailed explanation, see below.

On 27-06-22, 14:21, Vinod Koulwrote:
> On 25-06-22, 15:44, Jie Hai wrote:
>> When we get a DMA channel and try to use it in multiple threads it
>> will cause oops and hanging the system.
>>
>> % echo 100 > /sys/module/dmatest/parameters/threads_per_chan
>> % echo 100 > /sys/module/dmatest/parameters/iterations
>> % echo 1 > /sys/module/dmatest/parameters/run
>> [383493.327077] Unable to handle kernel paging request at virtual
>> 		address dead000000000108
>> [383493.335103] Mem abort info:
>> [383493.335103]   ESR = 0x96000044
>> [383493.335105]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [383493.335107]   SET = 0, FnV = 0
>> [383493.335108]   EA = 0, S1PTW = 0
>> [383493.335109]   FSC = 0x04: level 0 translation fault
>> [383493.335110] Data abort info:
>> [383493.335111]   ISV = 0, ISS = 0x00000044
>> [383493.364739]   CM = 0, WnR = 1
>> [383493.367793] [dead000000000108] address between user and kernel
>> 		address ranges
>> [383493.375021] Internal error: Oops: 96000044 [#1] PREEMPT SMP
>> [383493.437574] CPU: 63 PID: 27895 Comm: dma0chan0-copy2 Kdump:
>> 		loaded Tainted: GO 5.17.0-rc4+ #2
>> [383493.457851] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT
>> 		-SSBS BTYPE=--)
>> [383493.465331] pc : vchan_tx_submit+0x64/0xa0
>> [383493.469957] lr : vchan_tx_submit+0x34/0xa0
>>
>> This happens because of data race. Each thread rewrite channels's
>> descriptor as soon as device_issue_pending is called. It leads to
>> the situation that the driver thinks that it uses the right
>> descriptor in interrupt handler while channels's descriptor has
>> been changed by other thread.
>>
>> With current fixes channels's descriptor changes it's value only
>> when it has been used. A new descriptor is acquired from
>> vc->desc_issued queue that is already filled with descriptors
>> that are ready to be sent. Threads have no direct access to DMA
>> channel descriptor. Now it is just possible to queue a descriptor
>> for further processing.
>>
>> Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
>> Signed-off-by: Jie Hai <haijie1@huawei.com>
>> ---
>>   drivers/dma/hisi_dma.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
>> index 0a0f8a4d168a..0385419be8d5 100644
>> --- a/drivers/dma/hisi_dma.c
>> +++ b/drivers/dma/hisi_dma.c
>> @@ -271,7 +271,6 @@ static void hisi_dma_start_transfer(struct hisi_dma_chan *chan)
>>   
>>   	vd = vchan_next_desc(&chan->vc);
>>   	if (!vd) {
>> -		dev_err(&hdma_dev->pdev->dev, "no issued task!\n");
> 
> how is this a fix?
> 

Consider that only one deccriptor is in progress, and it is submitted to
hardware successfully in hisi_dma_issue_pending. When hisi_dma_irq calls
hisi_dma_start_transfer, vd is absolutely NULL. This also occurs in
multi-descriptor transfers. It's not abnormal that vd is NULL. So it's
reasonable to delete the error reporting.

>>   		chan->desc = NULL;
>>   		return;
>>   	}
>> @@ -303,7 +302,7 @@ static void hisi_dma_issue_pending(struct dma_chan *c)
>>   
>>   	spin_lock_irqsave(&chan->vc.lock, flags);
>>   
>> -	if (vchan_issue_pending(&chan->vc))
>> +	if (vchan_issue_pending(&chan->vc) && !chan->desc)
> 
> This looks good
> 
>>   		hisi_dma_start_transfer(chan);
>>   
>>   	spin_unlock_irqrestore(&chan->vc.lock, flags);
>> @@ -442,11 +441,10 @@ static irqreturn_t hisi_dma_irq(int irq, void *data)
>>   				    chan->qp_num, chan->cq_head);
>>   		if (FIELD_GET(STATUS_MASK, cqe->w0) == STATUS_SUCC) {
>>   			vchan_cookie_complete(&desc->vd);
>> +			hisi_dma_start_transfer(chan);
> 
> Why should this fix the error reported?
> 

With current fix in hisi_dma_issue_pending, if chan->desc is not NULL,
this submission to hardware is invalid and it will try again when
chan->desc is completed, which ensures that all descriptors are submitted
to hardware.

As to the error reported,  it is transfering timeout that causes the error
handling branch in dmatest, then the error reported. The overwritten of
chan->desc in multi-thread lead to that some descriptors are not be
processed by hisi_dma_irq, not to mention their callback. This fixes
timeout problem of hisi_dma and does not enter the error handling branch
of dmatest.

Dmatest uses dmaengine_terminate_sync to handle abnomal situation. It
calles device_terminate_all, most drivers implement this function with
vchan_get_all_descriptors and a temporary list head. It gets all descriptors
the channel holds in lists desc_* and adds them to head, deletions and
releases of these descriptors are performed on head without lock.

In the multi-thread scenario, a descriptor A which has not been submitted
by tx_submit may be in the following situations:
a). desc_A is in the desc_allocated list.
b). desc_A is in the head list of thread t2.
c). desc_A has been deleted from the head list by t2 but has not been freed.
d). desc_A has been deleted from the head list and freed by t2.

If there is a thread t1 attempting to call tx_submit for desc_A
on the preceding conditions, no error will be reported for a) and b), and
d) will cause use-after-free. Now consider c), s2 and c) are all involved
in removing nodes from the list. When a node is deleted from the list by
__list_del_entry, the previous and next node are assigned the constant
pointer LIST_POISON1 and LIST_POISON2, respectively. Accessing the two
addresses will cause an error. Therefore, if you perform __list_del_entry
on a node twice consecutively, an error will report. This is the case of
c). The preceding calltrace is caused by this.

I don't think it's wise for dmatest to use dmaengine_terminate_sync
to handle errors, but we do have problems with our driver. This patch is
to fix hisi_dma.

>>   		} else {
>>   			dev_err(&hdma_dev->pdev->dev, "task error!\n");
>>   		}
>> -
>> -		chan->desc = NULL;
>>   	}
>>   
>>   	spin_unlock(&chan->vc.lock);
>> -- 
>> 2.33.0
> 
Thanks,
Jie Hai.
