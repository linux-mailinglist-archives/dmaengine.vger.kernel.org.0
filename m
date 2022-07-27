Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC1B5828E5
	for <lists+dmaengine@lfdr.de>; Wed, 27 Jul 2022 16:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiG0Oq7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Jul 2022 10:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiG0Oqz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Jul 2022 10:46:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC607B864;
        Wed, 27 Jul 2022 07:46:52 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26REkloG060208;
        Wed, 27 Jul 2022 09:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1658933207;
        bh=HH6/A4QoVI8XrsWuyUxunANjj1kmDchZTOuwiRXvt28=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=C1SmbkDzzwGA99K2o2okRLj5ajVawdFRhYCdCepWsYspmqgfOFAiz/T9DtlSouHYg
         g/q7use3savg0toOu4QdSTzTUproUv7wDv3DRkvZ3uC5PQ0rmrUd3phzMCmWBwspR0
         jmT7nNYXUZfyqj49CS/8v0SkB79HWKnHEyF9QXvg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26REkl60069165
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jul 2022 09:46:47 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Jul 2022 09:46:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Jul 2022 09:46:47 -0500
Received: from [10.24.69.12] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26REkfdN035172;
        Wed, 27 Jul 2022 09:46:42 -0500
Message-ID: <df8b6249-93af-a323-3518-a1e0106b5c03@ti.com>
Date:   Wed, 27 Jul 2022 20:16:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dma: ti: k3-udma: Reset UDMA_CHAN_RT byte counters to
 prevent overflow
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <p.yadav@ti.com>,
        <j-keerthy@ti.com>, <m-khayami@ti.com>, <stanley_liu@ti.com>
References: <20220704111325.636-1-vaishnav.a@ti.com>
 <ad6dcdb8-8d4d-6f8b-38de-be2756a39028@gmail.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <ad6dcdb8-8d4d-6f8b-38de-be2756a39028@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter, Vinod,

On 09/07/22 11:50, Péter Ujfalusi wrote:
> 
> 
> On 7/4/22 14:13, Vaishnav Achath wrote:
>> UDMA_CHAN_RT_*BCNT_REG stores the real-time channel bytecount statistics.
>> These registers are 32-bit hardware counters and the driver uses these
>> counters to monitor the operational progress status for a channel, when
>> transferring more than 4GB of data it was observed that these counters
>> overflow and completion calculation of a operation gets affected and the
>> transfer hangs indefinitely.
>>
>> This commit adds changes to decrease the byte count for every complete
>> transaction so that these registers never overflow and the proper byte
>> count statistics is maintained for ongoing transaction by the RT counters.
>>
>> Earlier uc->bcnt used to maintain a count of the completed bytes at driver
>> side, since the RT counters maintain the statistics of current transaction
>> now, the maintenance of uc->bcnt is not necessary.
> 
> Thanks for the patch,
> 
>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>> ---
>>   drivers/dma/ti/k3-udma.c | 27 +++++++++++++++++++--------
>>   1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 2f0d2c68c93c..0f91a3e47c19 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -300,8 +300,6 @@ struct udma_chan {
>>   
>>   	struct udma_tx_drain tx_drain;
>>   
>> -	u32 bcnt; /* number of bytes completed since the start of the channel */
>> -
>>   	/* Channel configuration parameters */
>>   	struct udma_chan_config config;
>>   
>> @@ -757,6 +755,22 @@ static void udma_reset_rings(struct udma_chan *uc)
>>   	}
>>   }
>>   
>> +static void udma_decrement_byte_counters(struct udma_chan *uc, u32 val)
>> +{
>> +	if (uc->tchan) {
>> +		udma_tchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
>> +		udma_tchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
>> +		if (!uc->bchan)
>> +			udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
>> +	}
>> +
>> +	if (uc->rchan) {
>> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
>> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
>> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
>> +	}
> 
> In case of MEM_TO_MEM (or the not implemented DEV_TO_DEV) we use the
> tchan's counter for position tracking, but we have the pair anyways (UDMA).
> if ((uc->desc->dir == DMA_DEV_TO_MEM)
> 	rchan bcnt reset
> else
> 	tchan bcnt reset
> 
>> +}
>> +
>>   static void udma_reset_counters(struct udma_chan *uc)
>>   {
>>   	u32 val;
>> @@ -790,8 +804,6 @@ static void udma_reset_counters(struct udma_chan *uc)
>>   		val = udma_rchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
>>   		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
>>   	}
>> -
>> -	uc->bcnt = 0;
>>   }
>>   
>>   static int udma_reset_chan(struct udma_chan *uc, bool hard)
>> @@ -1115,8 +1127,8 @@ static void udma_check_tx_completion(struct work_struct *work)
>>   		if (uc->desc) {
>>   			struct udma_desc *d = uc->desc;
>>   
>> -			uc->bcnt += d->residue;
>>   			udma_start(uc);
>> +			udma_decrement_byte_counters(uc, d->residue);
> 
> Why not before udma_start()?
Thank you for your review and feedback, I have updated the addressed items in
V2, Sorry for the delay in responding.
V2: https://patchwork.kernel.org/project/linux-dmaengine/patch/20220727140837.25877-1-vaishnav.a@ti.com/
> 
>>   			vchan_cookie_complete(&d->vd);
>>   			break;
>>   		}
>> @@ -1168,8 +1180,8 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
>>   				vchan_cyclic_callback(&d->vd);
>>   			} else {
>>   				if (udma_is_desc_really_done(uc, d)) {
>> -					uc->bcnt += d->residue;
>>   					udma_start(uc);
>> +					udma_decrement_byte_counters(uc, d->residue);
>>   					vchan_cookie_complete(&d->vd);
>>   				} else {
>>   					schedule_delayed_work(&uc->tx_drain.work,
>> @@ -1204,7 +1216,7 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
>>   			vchan_cyclic_callback(&d->vd);
>>   		} else {
>>   			/* TODO: figure out the real amount of data */
>> -			uc->bcnt += d->residue;
>> +			udma_decrement_byte_counters(uc, d->residue);
>>   			udma_start(uc);
>>   			vchan_cookie_complete(&d->vd);
>>   		}
>> @@ -3809,7 +3821,6 @@ static enum dma_status udma_tx_status(struct dma_chan *chan,
>>   			bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
>>   		}
>>   
>> -		bcnt -= uc->bcnt;
>>   		if (bcnt && !(bcnt % uc->desc->residue))
>>   			residue = 0;
>>   		else
> 

-- 
Thanks and Regards,
Vaishnav
