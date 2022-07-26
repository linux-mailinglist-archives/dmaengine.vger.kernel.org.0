Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A1558091F
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jul 2022 03:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbiGZBiz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Jul 2022 21:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbiGZBiw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Jul 2022 21:38:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A55C28736;
        Mon, 25 Jul 2022 18:38:51 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LsKHf2NCPz1M8MD;
        Tue, 26 Jul 2022 09:35:58 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 09:38:49 +0800
Received: from [10.67.102.167] (10.67.102.167) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 09:38:49 +0800
Message-ID: <dfa515b1-2322-25b2-7b90-f7dd11b2ff47@huawei.com>
Date:   Tue, 26 Jul 2022 09:38:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/7] dmaengine: hisilicon: Fix CQ head update
To:     Vinod Koul <vkoul@kernel.org>
CC:     <wangzhou1@hisilicon.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220625074422.3479591-1-haijie1@huawei.com>
 <20220629035549.44181-1-haijie1@huawei.com>
 <20220629035549.44181-3-haijie1@huawei.com> <YtlULeGbn+z5AVP+@matsya>
From:   Jie Hai <haijie1@huawei.com>
In-Reply-To: <YtlULeGbn+z5AVP+@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.167]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022/7/21 21:27, Vinod Koul wrote:
> On 29-06-22, 11:55, Jie Hai wrote:
>> After completion of data transfer of one or multiple descriptors,
>> the completion status and the current head pointer to submission
>> queue are written into the CQ and interrupt can be generated to
>> inform the software. In interrupt process CQ is read and cq_head
>> is updated.
>>
>> hisi_dma_irq updates cq_head only when the completion status is
>> success. When an abnormal interrupt reports, cq_head will not update
>> which will cause subsequent interrupt processes read the error CQ
>> and never report the correct status.
>>
>> This patch updates cq_head whenever CQ is accessed.
>>
>> Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Jie Hai <haijie1@huawei.com>
>> ---
>>   drivers/dma/hisi_dma.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
>> index 98bc488893cc..7609e6e7eb37 100644
>> --- a/drivers/dma/hisi_dma.c
>> +++ b/drivers/dma/hisi_dma.c
>> @@ -436,12 +436,12 @@ static irqreturn_t hisi_dma_irq(int irq, void *data)
>>   	desc = chan->desc;
>>   	cqe = chan->cq + chan->cq_head;
>>   	if (desc) {
>> +		chan->cq_head = (chan->cq_head + 1) %
>> +				hdma_dev->chan_depth;
> 
> This can look better with single line
> 
Thanks for your reviewing.
These issues have been fixed in V3.
>> +		hisi_dma_chan_write(hdma_dev->base,
>> +				    HISI_DMA_CQ_HEAD_PTR, chan->qp_num,
>> +				    chan->cq_head);
> 
> maybe two lines?
> 
>>   		if (FIELD_GET(STATUS_MASK, cqe->w0) == STATUS_SUCC) {
>> -			chan->cq_head = (chan->cq_head + 1) %
>> -					hdma_dev->chan_depth;
>> -			hisi_dma_chan_write(hdma_dev->base,
>> -					    HISI_DMA_CQ_HEAD_PTR, chan->qp_num,
>> -					    chan->cq_head);
>>   			vchan_cookie_complete(&desc->vd);
>>   		} else {
>>   			dev_err(&hdma_dev->pdev->dev, "task error!\n");
>> -- 
>> 2.33.0
> 
