Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB41470E039
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 17:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbjEWPR6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 May 2023 11:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbjEWPR3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 May 2023 11:17:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE3318E
        for <dmaengine@vger.kernel.org>; Tue, 23 May 2023 08:17:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30a8fa6e6fcso1919654f8f.1
        for <dmaengine@vger.kernel.org>; Tue, 23 May 2023 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684855041; x=1687447041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14Njiq0FVZkX82TLQ37zxuiOET6tE8wUYy1Gx+sJltM=;
        b=HPXMqt+ftQ9mTQPYy85W+IjqCj+t7mUf/vd+io+75syv/w545t9VnLbPDCUk0b189r
         QLAugXiFJNerH/1vra8TZHCk5C8vi3MoZ+y1IPb9GAUdZSmTaBakAwrqTZpv3LuCqvN7
         B34uXE6A+FdOMla4d68WVe5Jy1qORPSa5X3iIelstf/kr734LiBt0MB+3Q+s5xOC1XiU
         OHxV2ZQaZxi9O6kCkq7SxdBAh/v5mmFptrsbosGhvzk91rZnQ5rLmyIrb9PEZ7z+9L1y
         3d///bYnJBYDqFaidyadJ8hGIk8OfwiidXm0jZFe+s09lQ+TYBPy8CVj53BsYBt2F0et
         stig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684855041; x=1687447041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14Njiq0FVZkX82TLQ37zxuiOET6tE8wUYy1Gx+sJltM=;
        b=XWthD5DZcof5aT6g1m7TSwBwlRnCkcWCfbRThMAcd7WbUD21TJDr+bUV8wB3ZtwKkL
         IlRL+r9Xmwfx1qW0qkcFjljKiTGq8Su9FNxSoHqQkS0AGt6G/mqZMX+lOHZ5s3434qKu
         BQffIMREWKjK9qgtGLS+mMlzc/+yv0zNfMUOGGxHbtohmH6zN0JFaox0W8i6ePFne4Hd
         Kl9R+oZA+udxi2oIfPDwAl4w4Fhn0xLAgOQOmntsvGXB0ptRfvAJ8qMWeOdw/v0syz/b
         20QSx1TwHQvPcEGpSvXUHZdJl5qcHh2j9fJJH0m1m0d65WSyohCbs1+OPSx/WgBF5xd0
         CpRw==
X-Gm-Message-State: AC+VfDw3MvUbnp2344hI2MpyUmuBvXDTXJOdW6gRO+HX+ZjDpdXQ0UON
        ywnxUEWDTQXc8pC9DMPHGA2Ipw==
X-Google-Smtp-Source: ACHHUZ4iI6vqELamkrPcqLLQGCw+0Bd4pr2ms6KiUywqfz6Y7kYM3qHlgKsqxF9PwdX2OD5L0eQvvA==
X-Received: by 2002:adf:db46:0:b0:2fb:87f7:3812 with SMTP id f6-20020adfdb46000000b002fb87f73812mr11298378wrj.1.1684855041363;
        Tue, 23 May 2023 08:17:21 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id w8-20020a5d4b48000000b0030771c6e443sm11442606wrs.42.2023.05.23.08.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 08:17:06 -0700 (PDT)
Message-ID: <4b5feef2-8d6f-20b1-9763-6e9552c4eb1c@linaro.org>
Date:   Tue, 23 May 2023 16:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dmaengine: at_hdmac: Repair bitfield macros for
 peripheral ID handling
Content-Language: en-US
To:     Peter Rosin <peda@axentia.se>, LKML <linux-kernel@vger.kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Vinod Koul <vkoul@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
References: <dc4834cb-fadf-17a5-fbc7-cf500db88f20@axentia.se>
 <68b70631-07b0-f4b2-463c-b8d3c7b9dac3@axentia.se>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <68b70631-07b0-f4b2-463c-b8d3c7b9dac3@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/23/23 13:42, Peter Rosin wrote:
> The MSB part of the peripheral IDs need to go into the ATC_SRC_PER_MSB
> and ATC_DST_PER_MSB fields. Not the LSB part.
> 
> This fixes a severe regression for TSE-850 devices (compatible
> axentia,tse850v3) where output to the audio I2S codec (the main
> purpose of the device) simply do not work.
> 

Indeed, sorry Peter.

> While at it, rewrite the macros as inline functions to evade checkpatch
> warnings about argument reuse.
> 
> Fixes: d8840a7edcf0 ("dmaengine: at_hdmac: Use bitfield access macros")

cc stable please

> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/dma/at_hdmac.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 8858470246e1..6f352160bc3b 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -153,8 +153,6 @@
>  #define ATC_AUTO		BIT(31)		/* Auto multiple buffer tx enable */
>  
>  /* Bitfields in CFG */
> -#define ATC_PER_MSB(h)	((0x30U & (h)) >> 4)	/* Extract most significant bits of a handshaking identifier */
> -
>  #define ATC_SRC_PER		GENMASK(3, 0)	/* Channel src rq associated with periph handshaking ifc h */
>  #define ATC_DST_PER		GENMASK(7, 4)	/* Channel dst rq associated with periph handshaking ifc h */
>  #define ATC_SRC_REP		BIT(8)		/* Source Replay Mod */
> @@ -181,10 +179,7 @@
>  #define ATC_DPIP_HOLE		GENMASK(15, 0)
>  #define ATC_DPIP_BOUNDARY	GENMASK(25, 16)
>  
> -#define ATC_SRC_PER_ID(id)	(FIELD_PREP(ATC_SRC_PER_MSB, (id)) |	\
> -				 FIELD_PREP(ATC_SRC_PER, (id)))
> -#define ATC_DST_PER_ID(id)	(FIELD_PREP(ATC_DST_PER_MSB, (id)) |	\
> -				 FIELD_PREP(ATC_DST_PER, (id)))
> +#define ATC_PER_MSB		GENMASK(5, 4)	/* Extract MSBs of a handshaking identifier */
>  
>  
>  
> @@ -1780,6 +1775,32 @@ static bool at_dma_filter(struct dma_chan *chan, void *slave)
>  	}
>  }
>  
> +/**
> + * atc_src_per_id - prepare the source peripheral fields of the CFG
> + * register for the given peripheral handshaking id.
> + *
> + * @per_id: the peripheral id
> + */
> +static inline u32 atc_src_per_id(unsigned int per_id)
> +{
> +	return FIELD_PREP(ATC_SRC_PER_MSB,
> +			  FIELD_GET(ATC_PER_MSB, per_id)) |
> +		FIELD_PREP(ATC_SRC_PER, per_id);
> +}

I still prefer a macro, would you use the following instead?
+#define ATC_SRC_PER_ID(id)                                            \
+       ({ typeof(id) _id = (id);                                      \
+          FIELD_PREP(ATC_SRC_PER_MSB, FIELD_GET(ATC_PER_MSB, _id)) |  \
+          FIELD_PREP(ATC_SRC_PER, _id); })

Cheers,
ta
