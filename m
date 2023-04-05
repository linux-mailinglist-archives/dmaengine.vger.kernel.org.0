Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E805F6D72BE
	for <lists+dmaengine@lfdr.de>; Wed,  5 Apr 2023 05:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjDEDrn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Apr 2023 23:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbjDEDrm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Apr 2023 23:47:42 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCD040EE;
        Tue,  4 Apr 2023 20:47:40 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3353lMXp010792;
        Tue, 4 Apr 2023 22:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680666442;
        bh=y44nt0ItQDarQ9AjTKqSbkNYAqch2DWGsz0GPcW0/mY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=kROhY+MGo9kCDirICM4+x6Lt72ZFF9k/jiOwqWhSTqHtHDuR6UPefaVDkC7aai0EW
         q9kMUJTBl3NirENAJu81J9BLp++aAxYqQu7H95Pfafr7+WVc/cI02TT5+BbelUYw6v
         2+WFVX6hnPxpZtceUxvc/spyWIjIuVv/bY57JyB0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3353lM6i035713
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Apr 2023 22:47:22 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 4
 Apr 2023 22:47:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 4 Apr 2023 22:47:21 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3353lHJu128455;
        Tue, 4 Apr 2023 22:47:17 -0500
Message-ID: <c1930df0-3806-c8fb-a100-17da60b6024f@ti.com>
Date:   Wed, 5 Apr 2023 09:17:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: do not create glue dma
 devices for udma channels
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vkoul@kernel.org>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
References: <20230404081158.1266530-1-s-vadapalli@ti.com>
 <c3c6c922-4ab0-eef6-be87-fe5c015b2440@gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <c3c6c922-4ab0-eef6-be87-fe5c015b2440@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 05/04/23 01:53, Péter Ujfalusi wrote:
> 
> 
> On 04/04/2023 11:11, Siddharth Vadapalli wrote:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> In case K3 DMA glue layer is using UDMA channels (AM65/J721E/J7200) it
>> doesn't need to create own DMA devices per RX/TX channels as they are
>> never
>> used and just waste resources. The UDMA based platforms are coherent and
>> UDMA device iteslf is used for DMA memory management.
>>
>> Hence, update K3 DMA glue layer to create K3 DMA glue DMA devices per
>> RX/TX
>> channels only in case of PKTDMA (AM64) where coherency configurable
>> per DMA
>> channel.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>   drivers/dma/ti/k3-udma-glue.c | 70 +++++++++++++++++------------------
>>   1 file changed, 34 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma-glue.c
>> b/drivers/dma/ti/k3-udma-glue.c
>> index 789193ed0386..b0c9572b0d02 100644
>> --- a/drivers/dma/ti/k3-udma-glue.c
>> +++ b/drivers/dma/ti/k3-udma-glue.c
>> @@ -293,19 +293,18 @@ struct k3_udma_glue_tx_channel
>> *k3_udma_glue_request_tx_chn(struct device *dev,
>>       }
>>       tx_chn->udma_tchan_id = xudma_tchan_get_id(tx_chn->udma_tchanx);
>>   -    tx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
>> -    tx_chn->common.chan_dev.parent =
>> xudma_get_device(tx_chn->common.udmax);
>> -    dev_set_name(&tx_chn->common.chan_dev, "tchan%d-0x%04x",
>> -             tx_chn->udma_tchan_id, tx_chn->common.dst_thread);
>> -    ret = device_register(&tx_chn->common.chan_dev);
>> -    if (ret) {
>> -        dev_err(dev, "Channel Device registration failed %d\n", ret);
>> -        put_device(&tx_chn->common.chan_dev);
>> -        tx_chn->common.chan_dev.parent = NULL;
>> -        goto err;
>> -    }
>> -
>>       if (xudma_is_pktdma(tx_chn->common.udmax)) {
> 
> it might be possible to narrow it down to include a test for atype_asel
> 14 or 15, but then I would move that test to a helper (passing common as
> parameter) and re-use it in other places to avoid getting out o sync
> overtime.
> Might not worth the effort, just an observation.

Irrespective, we should at least add check for atype_asel == 14/15 along
with xudma_is_pktdma().

Refractoring these checks to separate function can be patch of its own

> 
>> +        tx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
>> +        tx_chn->common.chan_dev.parent =
>> xudma_get_device(tx_chn->common.udmax);
>> +        dev_set_name(&tx_chn->common.chan_dev, "tchan%d-0x%04x",
>> +                 tx_chn->udma_tchan_id, tx_chn->common.dst_thread);
>> +        ret = device_register(&tx_chn->common.chan_dev);
>> +        if (ret) {
>> +            dev_err(dev, "Channel Device registration failed %d\n",
>> ret);
> 
> my guess is that the put_device() is still needed, no?

Agree

> 
>> +            tx_chn->common.chan_dev.parent = NULL;
>> +            goto err;
>> +        }
>> +
>>           /* prepare the channel device as coherent */

[...]

-- 
Regards
Vignesh
