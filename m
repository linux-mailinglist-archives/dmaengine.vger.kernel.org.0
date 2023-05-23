Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB0770DE6D
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 16:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbjEWOEU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 May 2023 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbjEWOEU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 May 2023 10:04:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AD2C4
        for <dmaengine@vger.kernel.org>; Tue, 23 May 2023 07:04:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30a892c45c4so2020966f8f.3
        for <dmaengine@vger.kernel.org>; Tue, 23 May 2023 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684850657; x=1687442657;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrIEHOXzq9JraARObzFeh9TS5aNcXpmLe7xr6WitOpY=;
        b=bMyGLKK/jL/EZTxM9FJ1NNAKkUBGI84Wtq5M3wed0BnmCpdyJ4hC4OA9jnxhJogCv+
         o8HlrUsv+SY/3iT2/pU9OISiE7MZutRMxsHZKRbdn70z8+pldbyTdmZh+DdRfasKYODO
         TWkwy+IknN6O+F38KaCpK2U5P1Jer0EIZHI1wZhNuyAojXUjDyWq41PTKNn0v/El19zV
         5/PWnc4ruFtVtO8FLNR1ebzupY14LqU5SQVjaFfg51R5MD05Sl4m5zwk8Hc02AAbqwDu
         6JO+7Jo71UNHYBzZtAfEzZ8xOHRr3idKPlEG8DbneTAPfF/2FqTQo7iCVxyOdGjEhMs+
         7OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850657; x=1687442657;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrIEHOXzq9JraARObzFeh9TS5aNcXpmLe7xr6WitOpY=;
        b=QZ6Q77qrKHSx5UE7tES4HHqdKrWL/akhgReuUKI42qnedq+ErtaKg2tgcYxJnK1kGI
         T7ol3c2qppUziQNJ9MpYxFvmRPMBUUSbdu3JVskELQfxvkrPdiSBg0u0egzEmipSjLN4
         l3K+zKSpKNS8xXvdZkbwoBcoBANogfsdnMm8s06yLPc3c9hbhPU/zDwDPLFrwyGqIXJ5
         ALuwasvnVxmxclli/ZqVryHhw7i+z49hUcCZofCn8fqx6xNagd4SEWV2q1N1PxUAqn8Y
         5Ft0wUf2QnLpvXZnh6OQiHdyUaK8G7JGWiOS9dxgjtwF4q9PtNEYIosLVxwNFa3+7Z6V
         V0dQ==
X-Gm-Message-State: AC+VfDyFqDR1ozDq5yzbu21zLhHqbCVfat+9EKw1XMW//Nl6dH06IehI
        uG5lqpGf+DsuIR/CEYtAYGywtRtzYXUjBLbu6JE=
X-Google-Smtp-Source: ACHHUZ5vIEd7CZAK4Rjn0VUCza9sZ5l61gd7AUDLobCg5m0u5B2K6imsda/l7ErsIku521ZdhBy99g==
X-Received: by 2002:adf:e4c5:0:b0:305:e8db:37df with SMTP id v5-20020adfe4c5000000b00305e8db37dfmr10326259wrm.22.1684850656740;
        Tue, 23 May 2023 07:04:16 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c231600b003f421979398sm14907627wmo.26.2023.05.23.07.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 07:04:16 -0700 (PDT)
Message-ID: <c844877e-feec-6de6-3e4d-ecb658ca7e51@linaro.org>
Date:   Tue, 23 May 2023 15:04:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] dmaengine: at_hdmac: Remove unused field values that
 do not fit
Content-Language: en-US
To:     Peter Rosin <peda@axentia.se>, LKML <linux-kernel@vger.kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Vinod Koul <vkoul@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
References: <dc4834cb-fadf-17a5-fbc7-cf500db88f20@axentia.se>
 <5070ac45-2f91-c9d7-de7c-31d38750015e@axentia.se>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <5070ac45-2f91-c9d7-de7c-31d38750015e@axentia.se>
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

Hi, Peter,

On 5/23/23 13:42, Peter Rosin wrote:
> The values are not used, and they do not fit in the intended
> register field (ATC_FC, 2 bits wide). Kill 'em all.
> 
Actually ATC_FC should be set to GENMASK(23, 21) and keep the other
definitions, see:
http://ww1.microchip.com/downloads/en/devicedoc/Atmel-6438-32-bit-ARM926-Embedded-Microprocessor-SAM9G45_Datasheet.pdf

After you update the patch you should also add:
Fixes: d8840a7edcf0 ("dmaengine: at_hdmac: Use bitfield access macros")
Cc: stable@vger.kernel.org
so that it gets backported to Linux-stable.

Feel free to add my R-b tag after addressing the comments:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/dma/at_hdmac.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 6f352160bc3b..51d0a0c7aaf7 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -137,10 +137,6 @@
>  #define ATC_FC_MEM2PER		0x1		/* Mem-to-Periph (DMA) */
>  #define ATC_FC_PER2MEM		0x2		/* Periph-to-Mem (DMA) */
>  #define ATC_FC_PER2PER		0x3		/* Periph-to-Periph (DMA) */
> -#define ATC_FC_PER2MEM_PER	0x4		/* Periph-to-Mem (Peripheral) */
> -#define ATC_FC_MEM2PER_PER	0x5		/* Mem-to-Periph (Peripheral) */
> -#define ATC_FC_PER2PER_SRCPER	0x6		/* Periph-to-Periph (Src Peripheral) */
> -#define ATC_FC_PER2PER_DSTPER	0x7		/* Periph-to-Periph (Dst Peripheral) */
>  #define ATC_SRC_ADDR_MODE	GENMASK(25, 24)
>  #define ATC_SRC_ADDR_MODE_INCR	0x0		/* Incrementing Mode */
>  #define ATC_SRC_ADDR_MODE_DECR	0x1		/* Decrementing Mode */

