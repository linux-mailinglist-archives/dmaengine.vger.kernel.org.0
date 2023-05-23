Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD9670E36E
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 19:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjEWRZ2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 May 2023 13:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbjEWRZZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 May 2023 13:25:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698EA129
        for <dmaengine@vger.kernel.org>; Tue, 23 May 2023 10:25:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-513fea21228so222512a12.3
        for <dmaengine@vger.kernel.org>; Tue, 23 May 2023 10:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684862696; x=1687454696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEQuDajhaZ5cNizdu4KdcsUEK1KvsZFvK+NmAK64xCc=;
        b=zqS4hmYdmyTgTuFuZBatzvy1P5XCncyzyB/SHx+DytMTt0EAR55RzyQyB7rzM5D/kD
         729VdVKEtBqRWmDahNbOGMZXb+sHAr0PUit3bMCuqInzrlSwjmCzZOUVoClLI48qQKKj
         pm55Cs3s7LC8YMF5xw6awXiGIirF5BJLgNppgroTrM8BwPwiC5rHsIxp6FTBdIo1VJJ2
         Ffy41yHZJONUhAvnPhnCwBxGiPVFRv0dCa1zOo7PUHD//U+uuMoDarw1Z6TkpE0+acVT
         qkWDpcBaLF8myHmvyEA0nrjKk8OK9ZaimM3xCNndN+sbG4UOarr7c+vxPViPgWwSJbwt
         9Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862696; x=1687454696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEQuDajhaZ5cNizdu4KdcsUEK1KvsZFvK+NmAK64xCc=;
        b=AFV5amz1BYpJZgB1Si45Tmi0b5lIOw/Fndu33G6lsjQdTfhZAuGAhgvyXJRGwInw5b
         xhWFPeU8nMqWbWvglGs+kajVGNu8k4FYsZ3l9o/zP1rkYym2R7CpQdjvWsjNJE0ym4hk
         jwCryv6kUPAj3PQ+0UWEQYo+AvLTRrtkn1wcJq5NnGhLQdmvEnwNVDOzL2Ypz7gk6gkn
         2m8TedSopDCckUg3u1WgbjXqMxp6pBq5/Q3MZjFem9gF+9fOM3ZcSY8CxKjvZP50uDBO
         M8kQooGjEamqIJrHCbMPwKtSmgbaoT8MC58EnSZMoDCSnLkZQFsT/9Lm7x66s8H3Q9Eq
         uUPQ==
X-Gm-Message-State: AC+VfDz+3A8O/L/vlxOuaofApTgsnHxegx6vk4WsOh6KbFidgGis07s5
        EwAS1Yw5LCVaC1+J4X8+mA6hyg==
X-Google-Smtp-Source: ACHHUZ7hnAw8R6Rbp5a00MNSddIWqxi/0dPWaeG+2dd9cCNPdaO3LBC1H/D/J5DZ01kSz/JGCwiPAw==
X-Received: by 2002:a17:907:7f09:b0:94f:8aff:c8b3 with SMTP id qf9-20020a1709077f0900b0094f8affc8b3mr13313466ejc.28.1684862695996;
        Tue, 23 May 2023 10:24:55 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906950700b0096f71ace804sm4638374ejx.99.2023.05.23.10.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 10:24:54 -0700 (PDT)
Message-ID: <06d53c3d-d300-dca1-6877-b8745e0673e8@linaro.org>
Date:   Tue, 23 May 2023 18:24:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] dmaengine: at_hdmac: Repair bitfield macros for
 peripheral ID handling
Content-Language: en-US
To:     Peter Rosin <peda@axentia.se>, LKML <linux-kernel@vger.kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Vinod Koul <vkoul@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <221d19e2-6b92-7f38-7d8a-a730f54c33ea@axentia.se>
 <01e5dae1-d4b0-cf31-516b-423b11b077f1@axentia.se>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <01e5dae1-d4b0-cf31-516b-423b11b077f1@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/23/23 18:20, Peter Rosin wrote:
> The MSB part of the peripheral IDs need to go into the ATC_SRC_PER_MSB
> and ATC_DST_PER_MSB fields. Not the LSB part.
> 
> This fixes a severe regression for TSE-850 devices (compatible
> axentia,tse850v3) where output to the audio I2S codec (the main
> purpose of the device) simply do not work.
> 
> Fixes: d8840a7edcf0 ("dmaengine: at_hdmac: Use bitfield access macros")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/dma/at_hdmac.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 8858470246e1..6362013b90df 100644
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
> @@ -181,10 +179,15 @@
>  #define ATC_DPIP_HOLE		GENMASK(15, 0)
>  #define ATC_DPIP_BOUNDARY	GENMASK(25, 16)
>  
> -#define ATC_SRC_PER_ID(id)	(FIELD_PREP(ATC_SRC_PER_MSB, (id)) |	\
> -				 FIELD_PREP(ATC_SRC_PER, (id)))
> -#define ATC_DST_PER_ID(id)	(FIELD_PREP(ATC_DST_PER_MSB, (id)) |	\
> -				 FIELD_PREP(ATC_DST_PER, (id)))
> +#define ATC_PER_MSB		GENMASK(5, 4)	/* Extract MSBs of a handshaking identifier */
> +#define ATC_SRC_PER_ID(id)					       \
> +	({ typeof(id) _id = (id);				       \
> +	   FIELD_PREP(ATC_SRC_PER_MSB, FIELD_GET(ATC_PER_MSB, _id)) |  \
> +	   FIELD_PREP(ATC_SRC_PER, _id); })
> +#define ATC_DST_PER_ID(id)					       \
> +	({ typeof(id) _id = (id);				       \
> +	   FIELD_PREP(ATC_DST_PER_MSB, FIELD_GET(ATC_PER_MSB, _id)) |  \
> +	   FIELD_PREP(ATC_DST_PER, _id); })
>  
>  
>  
