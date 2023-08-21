Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF289783339
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 22:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjHUUJG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 16:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjHUUJF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 16:09:05 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFA3E3;
        Mon, 21 Aug 2023 13:09:03 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so58364911fa.3;
        Mon, 21 Aug 2023 13:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692648542; x=1693253342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qmNfcmfr6YABHu3I1M4Yg1pkGn6Jrsu5qKJTkl5Si0E=;
        b=hMzYXynzP0IR68siSju+3X7YZg8hIeyGq0Cr43C+lYdCeuQuRt8wox+tQeItL0UDGi
         Ccp7sGhSNdA1iL6kNuCcZCyyjz0OF5hM3FTAIZnJe2CWSHkJj2ccqmYd9uCZd9DiX2Vl
         GPwwSyz+d+A/pSqu22JDzj1rVy5/bXrfnm50jGTfazNAZ0yhvGPhzT60keIE+JzzNWGO
         Pb544MtrBk/auqvTeiNdcz/Cq0E9Ry6OrakK6QZbzG2HY64o9w5gFLvvKXf7lTgae/zN
         ZNHaMDkf9kkipldj/JrwLDd0GSZ1zyPteL2O2wHZOfO95GJlW0IaXWuCZBZqsKHyJYso
         5xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692648542; x=1693253342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmNfcmfr6YABHu3I1M4Yg1pkGn6Jrsu5qKJTkl5Si0E=;
        b=Ohd4gNJkKVwTPIbZru/cfCk9E+nUfcq7bG/5AhJMAHPyzf3bmB17b2lnnRO8JX4tS7
         kLYeXyiILnonS3vv+vgKgom5BJEN2YuT8kMuTQElLLLrKD4sjZDBxfAmyQQIAvV/+MT8
         tqJVlMcqBFx7uig1Kqp/6Va9sKtpZdS6buXoUTu4ZORP8wZmCBkKO9/S0FAQ4kKIlLiY
         8lGmrWWCOyeLUBS32xUUFypkQO7dVFqIcjR+pFcUYh/18JkTD3hLF+LD4bXEtT9q2qWp
         0WWKD8eC/bWFsxhJjHu1RV1h86KBQu/2K+JZRgZlpP4ZHPS0iFD+lnH8lUINCn4/ll71
         Ik9g==
X-Gm-Message-State: AOJu0YzxPhA//E2QlymZW33AvhSKVXoxBGtNY3dRT2D6n85fRABJLsb0
        Ihpgc2ZFDhJ3nto+yGaVlS8=
X-Google-Smtp-Source: AGHT+IEXOCSz2Mr/vnuXjc7e61R6XGT4SfYq3W8jN1y4Cik73Pi3NAxAgKZ2Oyvgs3CBu73nq/vnbg==
X-Received: by 2002:a2e:8283:0:b0:2bb:94e4:49f with SMTP id y3-20020a2e8283000000b002bb94e4049fmr4803988ljg.32.1692648541424;
        Mon, 21 Aug 2023 13:09:01 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id f7-20020a2e9187000000b002b96a3a87d5sm2440446ljg.98.2023.08.21.13.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 13:09:01 -0700 (PDT)
Message-ID: <dd782f70-8340-4301-9f0f-175128da1ff4@gmail.com>
Date:   Mon, 21 Aug 2023 23:09:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix teardown timeout for cyclic
 mode
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j-luthra@ti.com,
        j-choudhary@ti.com, francesco@dolcini.it
References: <20230821104003.3001021-1-vigneshr@ti.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230821104003.3001021-1-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 21/08/2023 13:40, Vignesh Raghavendra wrote:
> In cyclic mode, last descriptor needs to have EOP flag set so that
> teardown flushes data towards PDMA in case of MEM_TO_DMA.  Else,

MEM_TO_DEV ?

> operation will not complete successfully leading to spurious timeout on
> channel terminate.
> 
> Without this terminating aplay cmd outputs false error msg like:
> [116.402800] ti-bcdma 485c0100.dma-controller: chan1 teardown timeout!
> 
> This doesn't seem to be problem with UDMA-P on J7xx devices (although is
> a requirement as per spec) but shows up easily on BCDMA + McASP. Fix
> this by setting the appropriate flag

If I recall the teardown flow was in case of TR mode (does not matter if
cyclic or not) is when the TD bit is set the currently executed TR is
finished at the next iteration boundary.
The EOP and tdown (and SOP) is sent to the destination in a zero length
data package as part of the teardown sequence.

In cyclic TR mode EOP is a strange concept as it is a stream w/o
packetization..

> 
> Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
> Suggested-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> 
> This complete reimplementation based on learning of HW behavior for problems
> reported at
> https://lore.kernel.org/linux-arm-kernel/20220215044112.161634-1-vigneshr@ti.com/
> 
>  drivers/dma/ti/k3-udma.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 30fd2f386f36..02aac7be8d28 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -3476,6 +3476,10 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
>  	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
>  	unsigned int i;
>  	int num_tr;
> +	u32 period_csf = 0;
> +
> +	if (uc->config.ep_type == PSIL_EP_PDMA_XY && dir == DMA_MEM_TO_DEV)
> +		period_csf = CPPI5_TR_CSF_EOP;
>  
>  	num_tr = udma_get_tr_counters(period_len, __ffs(buf_addr), &tr0_cnt0,
>  				      &tr0_cnt1, &tr1_cnt0);
> @@ -3525,8 +3529,10 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
>  		}
>  
>  		if (!(flags & DMA_PREP_INTERRUPT))
> -			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
> -					 CPPI5_TR_CSF_SUPR_EVT);
> +			period_csf |= CPPI5_TR_CSF_SUPR_EVT;
> +
> +		if (period_csf)
> +			cppi5_tr_csf_set(&tr_req[tr_idx].flags, period_csf);

This is not what the commit message was saying...
You set EOP (End Of Packet) for each period, if the period size is <
SZ_64K then you set the EOP for each descriptor, otherwise to every
second one.

>  
>  		period_addr += period_len;
>  	}

-- 
Péter
