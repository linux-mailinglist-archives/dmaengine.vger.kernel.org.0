Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5300C59D19D
	for <lists+dmaengine@lfdr.de>; Tue, 23 Aug 2022 09:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbiHWG5u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Aug 2022 02:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbiHWG5t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Aug 2022 02:57:49 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0254A6113D;
        Mon, 22 Aug 2022 23:57:47 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27N6viHF067494;
        Tue, 23 Aug 2022 01:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661237864;
        bh=dww6ybNh2ktK8HAtihY/bzHQ/GiXtuUJ9I3lU38Akdk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=r5wzivJhu0RDdA0NTVucWmyzFdEpvg9q249J4nMz8pKle9UmEpb5kxtNibRia2d9z
         1XcGF/L9G46geao406qKSfw9FyIZEcaqQF+DoCJxwp4w5KZxCqq6tIOrvBeNjd0kkh
         dSJOfePVr0Q8hsf3+HrpeXTp6xlA3TqLnUr9kGHo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27N6vits115017
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Aug 2022 01:57:44 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 23
 Aug 2022 01:57:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 23 Aug 2022 01:57:43 -0500
Received: from [192.168.0.110] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27N6veiJ087676;
        Tue, 23 Aug 2022 01:57:41 -0500
Message-ID: <37d51cde-de15-0cee-cd4b-ecaf5511fd2b@ti.com>
Date:   Tue, 23 Aug 2022 12:27:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dmaengine: ti: k3-udma: Respond TX done if
 DMA_PREP_INTERRUPT is not requested
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        <vkoul@kernel.org>, <broonie@kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     <vigneshr@ti.com>, <kishon@ti.com>
References: <20220822091531.27827-1-vaishnav.a@ti.com>
 <20220822091531.27827-2-vaishnav.a@ti.com>
 <1d4eb194-aab7-42c7-f33f-4b89e607dc6c@gmail.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <1d4eb194-aab7-42c7-f33f-4b89e607dc6c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 22/08/22 18:42, Péter Ujfalusi wrote:
> 
> 
> On 22/08/2022 12:15, Vaishnav Achath wrote:
>> When the DMA consumer driver does not expect the callback for TX done,
>> There is no need to perform the channel RT byte counter calculations 
>> and estimate the completion but return complete on first attempt itself.
>> This assumes that the consumer who did not request DMA_PREP_INTERRUPT 
>> has its own mechanism for understanding TX completion, example: MCSPI
>> EOW interrupt can be used as TX completion signal for a SPI transaction.
> 
> The check is in place to make sure that we don't leave stale data in the
> DMA fabric.
> If you drop the check then it is going to be possible that some TX data
> is going to be lost.
> Could be one out of 10K transfers or 100K, but if that happens it is not
> going to be easy to figure out.
> Let's say we go the packet back, but PDMA is still have data to send and
> the IP stops transmitting (externally clocked bus, some delay, etc).
> Is it going to be OK to disable the channel?
> 
Thanks for the feedback, yes the check is necessary for most of the cases
but there needs to be  a way to disable the check for consumers which can
identify the end of transaction using some other internal mechanism/interrupt.

For example the MCSPI controller has an End of Word(EOW) interrupt when the
said number of bytes has been clocked out, in this case the EOW interrupt
being raised guarantees that there is no stale data in DMA fabric.Using
the EOW interrupt to identify the completion of a transaction significantly
improves the transaction speed since we need not now wait for the slower DMA
TX completion calculation.

This commit tries to bypass the check only if the consumer did not request
it by not passing the DMA_PREP_INTERRUPT flag, in other cases the check
should not be bypassed.

>>
>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>> ---
>>  drivers/dma/ti/k3-udma.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 39b330ada200..03d579068453 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -263,6 +263,7 @@ struct udma_chan_config {
>>  	enum udma_tp_level channel_tpl; /* Channel Throughput Level */
>>  
>>  	u32 tr_trigger_type;
>> +	unsigned long tx_flags;
>>  
>>  	/* PKDMA mapped channel */
>>  	int mapped_channel_id;
>> @@ -1057,7 +1058,7 @@ static bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
>>  
>>  	/* Only TX towards PDMA is affected */
>>  	if (uc->config.ep_type == PSIL_EP_NATIVE ||
>> -	    uc->config.dir != DMA_MEM_TO_DEV)
>> +	    uc->config.dir != DMA_MEM_TO_DEV || !(uc->config.tx_flags & DMA_PREP_INTERRUPT))
>>  		return true;
>>  
>>  	peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
>> @@ -3418,6 +3419,8 @@ udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>>  	if (!burst)
>>  		burst = 1;
>>  
>> +	uc->config.tx_flags = tx_flags;
>> +
>>  	if (uc->config.pkt_mode)
>>  		d = udma_prep_slave_sg_pkt(uc, sgl, sglen, dir, tx_flags,
>>  					   context);
> 

-- 
Regards,
Vaishnav
