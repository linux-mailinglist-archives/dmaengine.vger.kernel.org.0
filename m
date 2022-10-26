Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163E060E655
	for <lists+dmaengine@lfdr.de>; Wed, 26 Oct 2022 19:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJZRVO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Oct 2022 13:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiJZRVM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Oct 2022 13:21:12 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A90789CFB;
        Wed, 26 Oct 2022 10:21:08 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u11so11098596ljk.6;
        Wed, 26 Oct 2022 10:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qov2Dgocew9BtpnUJ5VUmlVYXRxNX8vQVfGrG02GkcQ=;
        b=X3dzyRxqhsdwAc893GNV5bM99VeFzQr/hfBD2ZXUmtDwa47o6KHKpCU9XL3ZOhpAuz
         L7fkt6pqQ7lkvPQJZWoEhsHzCCFW/zCEh3neh75gsB+DXzy0l/01ZjPZXsF9rKi2KLEg
         sgF68ZldYP8okSWAjX3Ap6hldXl8MmoUpkbkUNSytTbnZ8pyXV/fLJ5qsNStmt7mwqAI
         7N8lB1grfvcrxxx7LCqwOSB7VrrFkW3Hh3vWcm9wiJ9Y+p+duIGI0PuESS8XNm02Gsf5
         RpXHqKR789dRNT8mVDDXgbri3QBUIXEn9iyPnZkOMoUVKT+Iyip3N23joNQ6y2dQ6uSA
         KePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qov2Dgocew9BtpnUJ5VUmlVYXRxNX8vQVfGrG02GkcQ=;
        b=catrZFTtUtMIQ/5dlu6ePVNbX2SopOVBRTZHAj2kef+tQ2HXnng/FWo3EIOTEn2bVe
         eXODbuxTa1iYbqEbg1+A7WpB40sxkkNyv3PFvn0m77/onGhg6hKBGzOQ56Jfcru7+Sx/
         aRm51rc/TpOuz80dg8vim5nEY1O3mglNTdgfYgTJGUGpKwQMGqpU1Q3EFJSUwUXVU4OV
         KmTLBIoKdz6Ckf3TImAVQp7kLrnM6TNpjlidFm1arRZZKWI80BrulBH4MgzJCAtQDAdM
         V+lmxDR3IqcZ0BvD0uu35HIKCYsPVn+rrwXP1dMUfTsJ62Wcalq7mKOHlbvAycZ8cQ10
         SSNQ==
X-Gm-Message-State: ACrzQf0smbL81r/sdXycV9iT6yFV9zPWObWGpPQ6myqsjmd7b0+iU24L
        3sARR/gXL8QmzEEjXrqzviaNnXeZKbFgig==
X-Google-Smtp-Source: AMsMyM7r5UycrzF6zRC7iMfR9iLY/mWsA/sgIm6t5TrSBaJ7e8698VUzdzKpu3A8ciL6PcBQTS0oOA==
X-Received: by 2002:a05:651c:502:b0:26f:de48:7df3 with SMTP id o2-20020a05651c050200b0026fde487df3mr16115621ljp.93.1666804866634;
        Wed, 26 Oct 2022 10:21:06 -0700 (PDT)
Received: from [10.0.0.100] (host-185-69-38-8.kaisa-laajakaista.fi. [185.69.38.8])
        by smtp.gmail.com with ESMTPSA id i5-20020a2ea365000000b0025e00e0116esm1008641ljn.128.2022.10.26.10.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 10:21:05 -0700 (PDT)
Message-ID: <ad965dad-ced7-4f10-13fb-2d30e058f428@gmail.com>
Date:   Wed, 26 Oct 2022 20:21:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] dmaengine: ti: edma: Remove the unused function
 edma_and()
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20221018083820.25297-1-jiapeng.chong@linux.alibaba.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20221018083820.25297-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 18/10/2022 11:38, Jiapeng Chong wrote:
> The function edma_and() is defined in the edma.c file, but not called
> elsewhere, so remove this unused function.
> 
> drivers/dma/ti/edma.c:321:20: warning: unused function 'edma_and'.

0f4c5b29e333 dmaengine: ti: edma: Remove some unused functions
dropped edma_param_and() but left the edma_and() behind...

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2430
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   drivers/dma/ti/edma.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index fa06d7e6d8e3..9ea91c640c32 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -318,14 +318,6 @@ static inline void edma_modify(struct edma_cc *ecc, int offset, unsigned and,
>   	edma_write(ecc, offset, val);
>   }
>   
> -static inline void edma_and(struct edma_cc *ecc, int offset, unsigned and)
> -{
> -	unsigned val = edma_read(ecc, offset);
> -
> -	val &= and;
> -	edma_write(ecc, offset, val);
> -}
> -
>   static inline void edma_or(struct edma_cc *ecc, int offset, unsigned or)
>   {
>   	unsigned val = edma_read(ecc, offset);

-- 
Péter
