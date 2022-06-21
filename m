Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD85552896
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jun 2022 02:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiFUAUV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jun 2022 20:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbiFUAUT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jun 2022 20:20:19 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282DB1BE9B;
        Mon, 20 Jun 2022 17:20:18 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5CAA33200993;
        Mon, 20 Jun 2022 20:20:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 20 Jun 2022 20:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1655770813; x=
        1655857213; bh=vW0Q8UBusbFNOQTYDIkgMBtPXU57mzxz1Jy7DV8VqXM=; b=g
        Z2v+FeIl/R179S49hPK7ezv0qkGxo3x3g384vICa8jdyY9vOI80guXH3QQp8LCDz
        BuSo/Ysh6LmttnTMgJx9zHC0Gz54BK8Arnw0fzsSr1dSZSp2VjAJyp9xgOivqVHB
        ygbqtTyMtCtMReVxfwhHCWaSIZHhQX1uu2P3caDPd2CTamt2ZgYqBhC2Wlk3oYzZ
        UrbpBEeHWS1Slt2I8d+1pvUQ2iHrzpRQ2xHkPSk6AtKB1IOFBBeDGp/v+VkK/3KW
        UlELy2kMfpyNoTmnpTn8vjOn/1m+nReKunJLyLzVOGNYmWimViLYI8AsWzD6BckZ
        eOa6jLyaqC3c6ZMT8vkPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655770813; x=
        1655857213; bh=vW0Q8UBusbFNOQTYDIkgMBtPXU57mzxz1Jy7DV8VqXM=; b=Y
        d5bj5fN3EcyKCmlXVADWmtgdl3X9bx4bkapdJXL6bNBmoKT8D7NEQM2bnZOMbQeP
        gsqic+8V7GKvrWzU/Zn3yrWTU5WmdYkmCa/a7mBNlQxvbzsXwg7M89Hd+36ZHAZE
        Vm0nGl66m/r0C+3+OjCFNrpPOweCvzEhJ1+8FFAUln/a3gH+0qUCvQh9F/GqHxas
        zh3UD3K2263CgBRL/mhadQcUwgDm69kMYVLNWVQjpbU0QeCNQ9owwGmKFn/ZEnD1
        03/9P7ADqCTab0IldtFdUXZlH3a91h7p9xSxhJOxNXgL4mXSu4C7NrCHUCv12jGl
        l9oIEyGlmhHGP8Y7WF9sQ==
X-ME-Sender: <xms:vA6xYk0lZZmfDyoDRcHlLobupJgD2IChFPbtqoeWN0Z-_bMQ5-UCLQ>
    <xme:vA6xYvErhqCs88Q-1Cz3v9amsjPo1fZs9XxYv6BhrcwxItPJNbODoMmMaq0BmOVLI
    MD0GWWLsAonTF1StA>
X-ME-Received: <xmr:vA6xYs6TJ1wruMeVPxSs3YLzc4AGbHtHrYGm2PQ59Yf8b5Ht5e8q5LhHS_o4sSfmQYVc6UXwBypRok50cY8jT1uEe4t03sv1j2KkO503BzfmRAHDFfd-w3QBSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefvddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvefhheehgfdvkeetffeludeuudehudeuvddtveelleekvedv
    uedviefhkeeuheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:vQ6xYt1ucPZEn-qArIj4S5h5zMu_p2I5OKEaRrOR5zYWOOfPhugSow>
    <xmx:vQ6xYnGGeQdxmqeSCZWt_hKhFiPJ7RZMSgcPZx8Zhg3LBsZ7bVvgTQ>
    <xmx:vQ6xYm9gmszPTGtrWP2TbWT8N5hQKjPUNw3NJOvuBkb_CYneWiSpIQ>
    <xmx:vQ6xYoM5iBdf-o23s6zlNO1FWPDNuf5SpLKpfBH9zp-zKTBQVes2UQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jun 2022 20:20:12 -0400 (EDT)
Subject: Re: [PATCH] dmaengine: sun6i: Set the maximum segment size
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20220617034209.57337-1-samuel@sholland.org>
 <3494277.R56niFO833@kista>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <c0c27494-99ea-969d-ff6c-a21f110ed3e8@sholland.org>
Date:   Mon, 20 Jun 2022 19:20:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3494277.R56niFO833@kista>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jernej,

On 6/20/22 1:28 PM, Jernej Škrabec wrote:
> Dne petek, 17. junij 2022 ob 05:42:09 CEST je Samuel Holland napisal(a):
>> The sun6i DMA engine supports segment sizes up to 2^25-1 bytes. This is
>> explicitly stated in newer SoC documentation (H6, D1), and it is implied
>> in older documentation by the 25-bit width of the "bytes left in the
>> current segment" register field.
> 
> At least A10 user manual says 128k max in description for Byte Counter 
> register (0x100+N*0x20+0xC), although field size is defined as 23:0, but that's 
> still less than 2^25-1. A20 supports only 128k too according to manual. New 
> quirk should be introduced for this.

Thanks for checking this. A10 and A20 use a separate driver (sun4i-dma). That
driver will also benefit from setting the max segment size, so I will send a
patch for it.

I think all of the variants supported by sun6i-dma have the same segment size
capability, so no quirk is needed here.

Regards,
Samuel

>>
>> Exposing the real segment size limit (instead of the 64k default)
>> reduces the number of SG list segments needed for a transaction.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>> Tested on A64, verified that the maximum ALSA PCM period increased, and
>> that audio playback still worked.
>>
>>  drivers/dma/sun6i-dma.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
>> index b7557f437936..1425f87d97b7 100644
>> --- a/drivers/dma/sun6i-dma.c
>> +++ b/drivers/dma/sun6i-dma.c
>> @@ -9,6 +9,7 @@
>>  
>>  #include <linux/clk.h>
>>  #include <linux/delay.h>
>> +#include <linux/dma-mapping.h>
>>  #include <linux/dmaengine.h>
>>  #include <linux/dmapool.h>
>>  #include <linux/interrupt.h>
>> @@ -1334,6 +1335,8 @@ static int sun6i_dma_probe(struct platform_device 
> *pdev)
>>  	INIT_LIST_HEAD(&sdc->pending);
>>  	spin_lock_init(&sdc->lock);
>>  
>> +	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(25));
>> +
>>  	dma_cap_set(DMA_PRIVATE, sdc->slave.cap_mask);
>>  	dma_cap_set(DMA_MEMCPY, sdc->slave.cap_mask);
>>  	dma_cap_set(DMA_SLAVE, sdc->slave.cap_mask);
>> -- 
>> 2.35.1
>>
>>
> 
> 

