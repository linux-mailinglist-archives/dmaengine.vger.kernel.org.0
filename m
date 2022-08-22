Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4F159C03B
	for <lists+dmaengine@lfdr.de>; Mon, 22 Aug 2022 15:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiHVNJ7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Aug 2022 09:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiHVNJ6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Aug 2022 09:09:58 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D216C22BEB;
        Mon, 22 Aug 2022 06:09:56 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l21so10563738ljj.2;
        Mon, 22 Aug 2022 06:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=vigYgSEq8XNq0GNKbbIvxMXyahHUCUs5sjRm7+jzlAc=;
        b=NAy+QHjlAUfAF+0E95smBz9TJ7pgnNqV0/+Acohr5RjSf02nCPAGkQ+pFPggURwPeX
         zRyiPUy6gLGtGBvdyFvEpY4i+9kLUc3a9K1mJJW6klXx+dV6iNVBwfdBFfGclLlWsSKc
         wwy5CfuU6Umz8mvsHk5SDTkqkRBI41DgEnEIh3L8fix43WRj6cIBHh6jUwou+rV0cWis
         r0A5lhU/NqD9H1HwQiagH22yBnoNJHG/XsEGUYedXEWD/02Ca2fauPsIGQyj6SURbbAV
         7NXqd4ceJyahjYHtOIFLpbP07hSf6AeFJcFNKS31VgrTkTCDU0j5EEsKpRfhQiNAFdEa
         D7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=vigYgSEq8XNq0GNKbbIvxMXyahHUCUs5sjRm7+jzlAc=;
        b=O+x8LZslJSosZVmTRQrKRpY+LARJW9ouPKJ7wEyCYx4qEWZ9r4vDQnFguF8UZILuLh
         BvRV3PVwrl5nwfBHQhjWJXcwmdu0Zb2MUHyJKnkqwe+sLo9siOJXNBsRiO/3MLEpCGbc
         fNDf32f15gUPqVXY4BI4CzGZ7g8VNXDFFJhz0Mo/BaS5nmig8rFnXl1evCZLjSuqJWjn
         XsoKQpUNNo3rxmLxmgASx8PiLrUkObIDJEi6cl51wwl09f7APZPYw5TchgEyI19xGdoM
         3KUxBMisPg6hCQCnWsxgZxUaU0VioqSxttRDM2aoHIcOEgDl9WQ6a2BGQmXXsziXUcPR
         Crpw==
X-Gm-Message-State: ACgBeo2D+kAH8GEpGbFLyFFyULFVI25bWotQVw23Kiq1EjGPFAq1e+cm
        lil2rkFFSrhNn3ZX4DJd5Z3Ba5rDPOZR/A==
X-Google-Smtp-Source: AA6agR5A55b/w/+RqBS9nJXJtBTCYbFkCFhxVZ/4Z5ZKcrs5fj5l1pPwWXAHQ8XkZjrkmmXNmOa0Rg==
X-Received: by 2002:a2e:92c4:0:b0:25d:9d30:5d61 with SMTP id k4-20020a2e92c4000000b0025d9d305d61mr6134684ljh.202.1661173795023;
        Mon, 22 Aug 2022 06:09:55 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id v11-20020a2ea44b000000b0025e42174f0csm1817832ljn.70.2022.08.22.06.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 06:09:54 -0700 (PDT)
Message-ID: <1d4eb194-aab7-42c7-f33f-4b89e607dc6c@gmail.com>
Date:   Mon, 22 Aug 2022 16:12:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>, vkoul@kernel.org,
        broonie@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     vigneshr@ti.com, kishon@ti.com
References: <20220822091531.27827-1-vaishnav.a@ti.com>
 <20220822091531.27827-2-vaishnav.a@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: ti: k3-udma: Respond TX done if
 DMA_PREP_INTERRUPT is not requested
In-Reply-To: <20220822091531.27827-2-vaishnav.a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 22/08/2022 12:15, Vaishnav Achath wrote:
> When the DMA consumer driver does not expect the callback for TX done,
> There is no need to perform the channel RT byte counter calculations 
> and estimate the completion but return complete on first attempt itself.
> This assumes that the consumer who did not request DMA_PREP_INTERRUPT 
> has its own mechanism for understanding TX completion, example: MCSPI
> EOW interrupt can be used as TX completion signal for a SPI transaction.

The check is in place to make sure that we don't leave stale data in the
DMA fabric.
If you drop the check then it is going to be possible that some TX data
is going to be lost.
Could be one out of 10K transfers or 100K, but if that happens it is not
going to be easy to figure out.
Let's say we go the packet back, but PDMA is still have data to send and
the IP stops transmitting (externally clocked bus, some delay, etc).
Is it going to be OK to disable the channel?

> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 39b330ada200..03d579068453 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -263,6 +263,7 @@ struct udma_chan_config {
>  	enum udma_tp_level channel_tpl; /* Channel Throughput Level */
>  
>  	u32 tr_trigger_type;
> +	unsigned long tx_flags;
>  
>  	/* PKDMA mapped channel */
>  	int mapped_channel_id;
> @@ -1057,7 +1058,7 @@ static bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
>  
>  	/* Only TX towards PDMA is affected */
>  	if (uc->config.ep_type == PSIL_EP_NATIVE ||
> -	    uc->config.dir != DMA_MEM_TO_DEV)
> +	    uc->config.dir != DMA_MEM_TO_DEV || !(uc->config.tx_flags & DMA_PREP_INTERRUPT))
>  		return true;
>  
>  	peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
> @@ -3418,6 +3419,8 @@ udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  	if (!burst)
>  		burst = 1;
>  
> +	uc->config.tx_flags = tx_flags;
> +
>  	if (uc->config.pkt_mode)
>  		d = udma_prep_slave_sg_pkt(uc, sgl, sglen, dir, tx_flags,
>  					   context);

-- 
Péter
