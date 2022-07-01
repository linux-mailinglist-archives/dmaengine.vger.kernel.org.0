Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6517A563843
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 18:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiGAQrC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 12:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiGAQrB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 12:47:01 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CC443ADB;
        Fri,  1 Jul 2022 09:47:00 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9327D3200786;
        Fri,  1 Jul 2022 12:46:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 01 Jul 2022 12:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656694017; x=
        1656780417; bh=lKAoEPLv3in9dAP9LhiFBugBHoBxwvpmS1dj3WZJBAE=; b=J
        DmrAhCbrhlZVaEy2jdgzmoJImSEpw0GV4qsjT9XJXG/x+4hFbluz7ACGD0qt9Ydj
        KuMT81VjaDPAfmK4fvRRX3QqDY/QKGo82j/igKWA3AW1IzrMkDulj77GAVgA5K6Q
        1WchnFBCuHFWhqqN7io23UPhLvJQn5i2eMZNhwrywwYJre004CBI5Awvveq+4vqw
        LkDXLB/As7lHHUicplGkg2eVyBjpwqvONHUJ0NctEP5seWGEBhqMbYf+vS10v1is
        2Y+7u/7meZ0KE23u8nnd3LfOLFVfEmbgDHO6+7LukM5oZv2j0c7KnsPzd/f2Kh36
        hknZ87rp4pgnudC+ap1jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656694017; x=
        1656780417; bh=lKAoEPLv3in9dAP9LhiFBugBHoBxwvpmS1dj3WZJBAE=; b=l
        tl5CUVFM4YOs2H67CK//sOpCU+/X5gDXlyJJ51qAXPUoVcrb1hIWmPXhJMLrMHBq
        XuITUcbtzeBhzA1KrqSSTf4Rd9yY0VIkaLCO0rf5bFAbmGOdmC+j8cCdkxkYxZ8a
        7Xe1P3Tk8ZrbDuVQcLUv+TM5U7d8pNTyq1IKxE0qvdzc6DMfdffxP/6Mb3RsLS6+
        0a6WIvxqKSvmoisrJ82T1Jwa5oYG4nGUfILbAXilHluZUTyQgKzc6WHwfM/17ANP
        7YnKE+zz+lji4pF3WI/8Tq04VrZHNrG1W8XZ4AhpWnU0joUDybrmdvqvJoOihv5f
        axFW4K7om0tVGpNsaRUjg==
X-ME-Sender: <xms:ACW_YlhqntJVFPOi52YsW1Is3iAICIJzNGz3pGYSzf8it5ZcHjHYUA>
    <xme:ACW_YqBzFKKnNYOkL9IdVSMyjqrhMovBDeyQmdnWVwpblxTUgwcvuR_spPE6leEZL
    lSiofKOOTpEJQia4A>
X-ME-Received: <xmr:ACW_YlFTd7EHKHAYabCl3wi7Gv44XQzbZANFb--DB-e_hpT80tMgcGeCiA90F--MxTOrh37aC97veJohr7CkI33qm_YBsLJF0JcxUOOt97Hkwx5Bo__rSbkaaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehfedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfh
    iedtheduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:ACW_YqSrOBbUN9DJkq6mtaBCGSTlOGhzwYrdkdg4Uko38NbaKI0iDQ>
    <xmx:ACW_Yiwxyg_1ZU6Wo7938qW7aLIuR0Aw-CC-X_AGG3Yx85LTCZ7y9w>
    <xmx:ACW_Yg4Uu15WzIrCm2TqQg642vUgtyR3I4jNCcrLix8qNxu31OgGIA>
    <xmx:ASW_YpkVW5Kcur67wS20PelETKwFLs4vFxm4H9KcL7SkXO23xbJumw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 12:46:55 -0400 (EDT)
Subject: Re: [PATCH] dmaengine: sun4i: Set the maximum segment size
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220621031350.36187-1-samuel@sholland.org>
 <Yr8guz0No80hdgxi@matsya>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <53f2c285-32e2-79cd-1422-ddc828c97d3a@sholland.org>
Date:   Fri, 1 Jul 2022 11:46:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <Yr8guz0No80hdgxi@matsya>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 7/1/22 11:28 AM, Vinod Koul wrote:
> On 20-06-22, 22:13, Samuel Holland wrote:
>> The sun4i DMA engine supports transfer sizes up to 128k for normal DMA
>> and 16M for dedicated DMA, as documented in the A10 and A20 manuals.
>>
>> Since this is larger than the default segment size limit (64k), exposing
>> the real limit reduces the number of transfers needed for a transaction.
>> However, because the device can only report one segment size limit, we
>> have to expose the smaller limit from normal DMA.
>>
>> One complication is that the driver combines pairs of periodic transfers
>> to reduce programming overhead. This only works when the period size is
>> at most half of the maximum transfer size. With the default 64k segment
>> size limit, this was always the case, but for normal DMA it is no longer
>> guaranteed. Skip the optimization if the period is too long; even
>> without it, the overhead is less than before.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>> I don't have any A10 or A20 boards I can test this on.
>>
>>  drivers/dma/sun4i-dma.c | 32 +++++++++++++++++++++++++++-----
>>  1 file changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
>> index 93f1645ae928..f291b1b4db32 100644
>> --- a/drivers/dma/sun4i-dma.c
>> +++ b/drivers/dma/sun4i-dma.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/bitmap.h>
>>  #include <linux/bitops.h>
>>  #include <linux/clk.h>
>> +#include <linux/dma-mapping.h>
>>  #include <linux/dmaengine.h>
>>  #include <linux/dmapool.h>
>>  #include <linux/interrupt.h>
>> @@ -122,6 +123,15 @@
>>  	 SUN4I_DDMA_PARA_DST_WAIT_CYCLES(2) |				\
>>  	 SUN4I_DDMA_PARA_SRC_WAIT_CYCLES(2))
>>  
>> +/*
>> + * Normal DMA supports individual transfers (segments) up to 128k.
>> + * Dedicated DMA supports transfers up to 16M. We can only report
>> + * one size limit, so we have to use the smaller value.
>> + */
>> +#define SUN4I_NDMA_MAX_SEG_SIZE		SZ_128K
>> +#define SUN4I_DDMA_MAX_SEG_SIZE		SZ_16M
> 
> This new define is not used, so why add?

This documents the "much larger" claim below. I could have written:

max_period = vchan->is_dedicated ?
	SUN4I_DDMA_MAX_SEG_SIZE : SUN4I_NDMA_MAX_SEG_SIZE;
if (period_len <= max_period / 2) {
	...

But the check against SUN4I_DDMA_MAX_SEG_SIZE would be a waste of cycles,
because we already know that the period length is at most 128K.

>> +#define SUN4I_DMA_MAX_SEG_SIZE		SUN4I_NDMA_MAX_SEG_SIZE
>> +
>>  struct sun4i_dma_pchan {
>>  	/* Register base of channel */
>>  	void __iomem			*base;
>> @@ -155,7 +165,8 @@ struct sun4i_dma_contract {
>>  	struct virt_dma_desc		vd;
>>  	struct list_head		demands;
>>  	struct list_head		completed_demands;
>> -	int				is_cyclic;
>> +	bool				is_cyclic : 1;
>> +	bool				use_half_int : 1;
>>  };
>>  
>>  struct sun4i_dma_dev {
>> @@ -372,7 +383,7 @@ static int __execute_vchan_pending(struct sun4i_dma_dev *priv,
>>  	if (promise) {
>>  		vchan->contract = contract;
>>  		vchan->pchan = pchan;
>> -		set_pchan_interrupt(priv, pchan, contract->is_cyclic, 1);
>> +		set_pchan_interrupt(priv, pchan, contract->use_half_int, 1);
> 
> not interrupt when cyclic?

The hardware has two interrupts: "transfer done" and "half done". The "transfer
done" interrupt is always enabled (by the last parameter). But the "half done"
interrupt is only enabled when the transfer size has been doubled by the code in
the diff below.

Regards,
Samuel

>>  		configure_pchan(pchan, promise);
>>  	}
>>  
>> @@ -735,12 +746,21 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
>>  	 *
>>  	 * Which requires half the engine programming for the same
>>  	 * functionality.
>> +	 *
>> +	 * This only works if two periods fit in a single promise. That will
>> +	 * always be the case for dedicated DMA, where the hardware has a much
>> +	 * larger maximum transfer size than advertised to clients.
>>  	 */
>> -	nr_periods = DIV_ROUND_UP(len / period_len, 2);
>> +	if (vchan->is_dedicated || period_len <= SUN4I_NDMA_MAX_SEG_SIZE / 2) {
>> +		period_len *= 2;
>> +		contract->use_half_int = 1;
>> +	}
>> +
>> +	nr_periods = DIV_ROUND_UP(len, period_len);
>>  	for (i = 0; i < nr_periods; i++) {
>>  		/* Calculate the offset in the buffer and the length needed */
>> -		offset = i * period_len * 2;
>> -		plength = min((len - offset), (period_len * 2));
>> +		offset = i * period_len;
>> +		plength = min((len - offset), period_len);
>>  		if (dir == DMA_MEM_TO_DEV)
>>  			src = buf + offset;
>>  		else
>> @@ -1149,6 +1169,8 @@ static int sun4i_dma_probe(struct platform_device *pdev)
>>  	platform_set_drvdata(pdev, priv);
>>  	spin_lock_init(&priv->lock);
>>  
>> +	dma_set_max_seg_size(&pdev->dev, SUN4I_DMA_MAX_SEG_SIZE);
>> +
>>  	dma_cap_zero(priv->slave.cap_mask);
>>  	dma_cap_set(DMA_PRIVATE, priv->slave.cap_mask);
>>  	dma_cap_set(DMA_MEMCPY, priv->slave.cap_mask);
>> -- 
>> 2.35.1
> 

