Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DA15AC8F0
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 05:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiIEDDG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Sep 2022 23:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiIEDDC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Sep 2022 23:03:02 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D107B25EBC;
        Sun,  4 Sep 2022 20:03:00 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28532nB8099767;
        Sun, 4 Sep 2022 22:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662346969;
        bh=JhT2S9EfNW5iVlcN1uvv+SIM5JSkRZnuNcDBBSGekcs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cUFeyrPCIpLeYwQzJxQw7u7C170Us/gJbAltIuPBDEkvoDDFAMMyON/RmDY9p52a3
         Jb/BmUNqdpaJVOfYuUqNl2szgl7WspbBfPM9V4jae0YPTzCyBPwAbOLsMPN4BRIwMb
         1c2v7AVQz0TvGLDHmNOC9Vxji+Z+h3gGO9gokKEU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28532nq6019441
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 4 Sep 2022 22:02:49 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Sun, 4 Sep
 2022 22:02:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Sun, 4 Sep 2022 22:02:49 -0500
Received: from [10.24.69.110] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28532kYC115634;
        Sun, 4 Sep 2022 22:02:46 -0500
Message-ID: <a30e917d-e031-3829-36fb-b897e971825f@ti.com>
Date:   Mon, 5 Sep 2022 08:32:45 +0530
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
CC:     <vigneshr@ti.com>, <kishon@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>
References: <20220822091531.27827-1-vaishnav.a@ti.com>
 <20220822091531.27827-2-vaishnav.a@ti.com>
 <1d4eb194-aab7-42c7-f33f-4b89e607dc6c@gmail.com>
 <37d51cde-de15-0cee-cd4b-ecaf5511fd2b@ti.com>
 <7dae9f3f-88eb-d996-3cb3-89402ea9e31f@gmail.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <7dae9f3f-88eb-d996-3cb3-89402ea9e31f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 02/09/22 19:50, Péter Ujfalusi wrote:
> Hi Achath,
> 
> On 23/08/2022 09:57, Vaishnav Achath wrote:
>> Hi Peter,
>>
>> On 22/08/22 18:42, Péter Ujfalusi wrote:
>>>
>>>
>>> On 22/08/2022 12:15, Vaishnav Achath wrote:
>>>> When the DMA consumer driver does not expect the callback for TX done,
>>>> There is no need to perform the channel RT byte counter calculations
>>>> and estimate the completion but return complete on first attempt itself.
>>>> This assumes that the consumer who did not request DMA_PREP_INTERRUPT
>>>> has its own mechanism for understanding TX completion, example: MCSPI
>>>> EOW interrupt can be used as TX completion signal for a SPI transaction.
>>>
>>> The check is in place to make sure that we don't leave stale data in the
>>> DMA fabric.
>>> If you drop the check then it is going to be possible that some TX data
>>> is going to be lost.
>>> Could be one out of 10K transfers or 100K, but if that happens it is not
>>> going to be easy to figure out.
>>> Let's say we go the packet back, but PDMA is still have data to send and
>>> the IP stops transmitting (externally clocked bus, some delay, etc).
>>> Is it going to be OK to disable the channel?
>>>
>> Thanks for the feedback, yes the check is necessary for most of the cases
>> but there needs to be  a way to disable the check for consumers which can
>> identify the end of transaction using some other internal mechanism/interrupt.
>>
>> For example the MCSPI controller has an End of Word(EOW) interrupt when the
>> said number of bytes has been clocked out, in this case the EOW interrupt
>> being raised guarantees that there is no stale data in DMA fabric.Using
>> the EOW interrupt to identify the completion of a transaction significantly
>> improves the transaction speed since we need not now wait for the slower DMA
>> TX completion calculation.
>>
>> This commit tries to bypass the check only if the consumer did not request
>> it by not passing the DMA_PREP_INTERRUPT flag, in other cases the check
>> should not be bypassed.
> 
> Let me think about over the weekend... Do you have performance numbers for this
> change?
> 
Thank you, yes we tested mainly for the SPI cases(Master and Slave mode), there
we saw a peak delay of 400ms for transaction completion and this varied with CPU
load, after adding the patch to not wait for DMA TX completion and use EOW
interrupt the peak latency reduced to 2ms.
> If we make sure that this is only affecting non cyclic transfers with a in code
> comment to explain the expectations from the user I think this can be safe.
> \
Sure I will add this in the next revision.
>>
>>>>
>>>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>>>> ---
>>>>   drivers/dma/ti/k3-udma.c | 5 ++++-
>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>>>> index 39b330ada200..03d579068453 100644
>>>> --- a/drivers/dma/ti/k3-udma.c
>>>> +++ b/drivers/dma/ti/k3-udma.c
>>>> @@ -263,6 +263,7 @@ struct udma_chan_config {
>>>>       enum udma_tp_level channel_tpl; /* Channel Throughput Level */
>>>>         u32 tr_trigger_type;
>>>> +    unsigned long tx_flags;
>>>>         /* PKDMA mapped channel */
>>>>       int mapped_channel_id;
>>>> @@ -1057,7 +1058,7 @@ static bool udma_is_desc_really_done(struct udma_chan
>>>> *uc, struct udma_desc *d)
>>>>         /* Only TX towards PDMA is affected */
>>>>       if (uc->config.ep_type == PSIL_EP_NATIVE ||
>>>> -        uc->config.dir != DMA_MEM_TO_DEV)
>>>> +        uc->config.dir != DMA_MEM_TO_DEV || !(uc->config.tx_flags &
>>>> DMA_PREP_INTERRUPT))
>>>>           return true;
>>>>         peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
>>>> @@ -3418,6 +3419,8 @@ udma_prep_slave_sg(struct dma_chan *chan, struct
>>>> scatterlist *sgl,
>>>>       if (!burst)
>>>>           burst = 1;
>>>>   +    uc->config.tx_flags = tx_flags;
>>>> +
>>>>       if (uc->config.pkt_mode)
>>>>           d = udma_prep_slave_sg_pkt(uc, sgl, sglen, dir, tx_flags,
>>>>                          context);
>>>
>>
> 

-- 
Regards,
Vaishnav
