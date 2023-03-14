Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460256BA035
	for <lists+dmaengine@lfdr.de>; Tue, 14 Mar 2023 20:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjCNT64 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Mar 2023 15:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCNT6t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Mar 2023 15:58:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3786019130;
        Tue, 14 Mar 2023 12:58:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r27so21502206lfe.10;
        Tue, 14 Mar 2023 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678823922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LGgRX/2BUBwYcike5aUEW/Egn+pesM4WHWNRXI6B9BE=;
        b=hhqAUsRVFCC/gjfPDgDJEsRdPp9QDcC0oERAHoeZpMbQ/josNSNCDGD/mWgNzVv1gd
         JXnj8dSgFA7aa1lHk1DK6Cw/Fmt/74ZnKRm15TOAczptqJbzszSy4lUxlvydYD7+8FBl
         zS88BMACUmO6hcxY2l0dmxJOItcYExC+xLm1+9deLnMMf+f+VSN6Jd5WzcSOFzFbrh6Q
         lS9kCxoFffCaoiBTqqGAfdvxrCvAFnDtufJAbm0v1YIxdznHo8ClwbUYIhY573uJVpQr
         HNfgpmU9Cd5DXSE6ww/Zlf5cUyPsNjzQOk2sdTMrujLnc8FF+HLzOhAEzKU+C/hohVQW
         7Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678823922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGgRX/2BUBwYcike5aUEW/Egn+pesM4WHWNRXI6B9BE=;
        b=oTfpfb5dcIqc9Xu05r5oBv+0SyM+6DIWxytfodfgQbfvLffFne9aFh7xS/kqS8cfHb
         LqMfFbCtk8bz54UzYORq5MkZgTVLVC4O0E99JGUxNsanKWy3joLH06A2wXdZvnqNc+zh
         mdnVASkwbTQJ0UggCdpeVyt01X4JL0ACyZ+tlfcgD5c4QnrQ7haygDZFAGj5BD+X/PQr
         O/Yjcz2p3qD19tv+c7eemyL3THAFCMmmcltU5mWeLkWQiyPBhrNqhHIgrsfKsJk8ULC2
         EN5bNjoET6Ji3ttifeSghURSw9pwt3krXmDjwiOksfu+qOum2V3Ga/5kJDe/GGPBJxOq
         NQkQ==
X-Gm-Message-State: AO0yUKWeweS2cMTV9Sz44n+5QySv0LGcuIXvxS0QsT+UK0GGv+tIO8Jl
        LJb0lTWTJhAyAEvITQbCpeG2y5ajF6/VBQ==
X-Google-Smtp-Source: AK7set9MtwzGDW7oRn6jmNEkZEBR3MNrePLLU6xlo+h9RQ8v5YQSav4Z1FaWwspBMvAwTKW0HjumCw==
X-Received: by 2002:ac2:48b3:0:b0:4dd:a74d:ac46 with SMTP id u19-20020ac248b3000000b004dda74dac46mr1102055lfg.0.1678823922329;
        Tue, 14 Mar 2023 12:58:42 -0700 (PDT)
Received: from [10.0.0.100] (host-213-145-197-218.kaisa-laajakaista.fi. [213.145.197.218])
        by smtp.gmail.com with ESMTPSA id w12-20020a056512098c00b004e8468b92c2sm519072lft.146.2023.03.14.12.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 12:58:41 -0700 (PDT)
Message-ID: <c0a50add-5c76-8e16-f65b-803d4389b36f@gmail.com>
Date:   Tue, 14 Mar 2023 22:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dmaengine: ti: add null check of devm_kasprintf in
 edma_probe and udma_probe
Content-Language: en-US
To:     Kang Chen <void0red@gmail.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230226094038.3227062-1-void0red@gmail.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230226094038.3227062-1-void0red@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 26/02/2023 11:40, Kang Chen wrote:
> devm_kasprintf may fails, irq_name and uc->name might be null and wrong irq
> name will be used in request.

In general, I would have preferred to have separate patches for the two 
drivers to make them easier to backport if one decides.

If you decide to resend, you can add my to them:

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
>   drivers/dma/ti/edma.c    | 8 ++++++++
>   drivers/dma/ti/k3-udma.c | 2 ++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index fa06d7e6d..85cd72b64 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2413,6 +2413,10 @@ static int edma_probe(struct platform_device *pdev)
>   	if (irq >= 0) {
>   		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
>   					  dev_name(dev));
> +		if (!irq_name) {
> +			ret = -ENOMEM;
> +			goto err_disable_pm;
> +		}
>   		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
>   				       ecc);
>   		if (ret) {
> @@ -2429,6 +2433,10 @@ static int edma_probe(struct platform_device *pdev)
>   	if (irq >= 0) {
>   		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
>   					  dev_name(dev));
> +		if (!irq_name) {
> +			ret = -ENOMEM;
> +			goto err_disable_pm;
> +		}
>   		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
>   				       ecc);
>   		if (ret) {
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 7e23a6fde..692d1d25c 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -5494,6 +5494,8 @@ static int udma_probe(struct platform_device *pdev)
>   		uc->config.dir = DMA_MEM_TO_MEM;
>   		uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
>   					  dev_name(dev), i);
> +		if (!uc->name)
> +			return -ENOMEM;
>   
>   		vchan_init(&uc->vc, &ud->ddev);
>   		/* Use custom vchan completion handling */

-- 
Péter
