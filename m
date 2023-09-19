Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA887A6A70
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 20:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjISSJT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 14:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjISSJR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 14:09:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6E890;
        Tue, 19 Sep 2023 11:09:11 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-503056c8195so5663620e87.1;
        Tue, 19 Sep 2023 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695146949; x=1695751749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0XlOW3FqVXIEND6K8vcbJAOT3ReGThUKI6YJBY51K+I=;
        b=Nc8y/WygTIQ1G2nvGTSYq5Te8j208Jcu3RLFvXhCWlRtVfmq5PYfZsQkUPkxHQy4cB
         tTZNaxEss5yUyqA8eVjPX6s6ybgxUjDuXz6Oo5Spl/iAkdHZwxaljRKSzcSpOsQ98Dz+
         VYTykdOGoyHrLz6XzE2TfEJuSlg7J/tMPyax8geeUvDAJHyOvCZ/P3LvkVd6Db21Bcxh
         AMTsU+fv3BiaA9d0/R1EnVLWf+8ApcZiqIwbXrgolyJrbN/swGiUfYsPk7vf+BfT7zYR
         gvBncwYAfby7K+c0Nh4Qb1r0hVeAjjKvggjxB2h2+xtGpTr5mO/Fdz78XLxPgyLMZ4ya
         +SPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695146949; x=1695751749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XlOW3FqVXIEND6K8vcbJAOT3ReGThUKI6YJBY51K+I=;
        b=XP7roe0cvSMf62p7VhHTe+KLaTWjEwCmAqAaJQ0ZbCYPsopYDNrBX3BATHdXdqpMUu
         56HxyD5GOkEx0WxkDenO7k8pHIMAlArLC+Ap1fGtzgEPOsiWuCnyawMUnnEY+mYA4bh2
         c2IaWwp6o+DacehKVZH0+oaFpgpRTeX6vVlMe74TlNMWG8nqJRrzHyvbp2mZxii3h4iw
         sNWmliTHKuDIa8HpwvuohBjG/6kagl45Pe2wBiivw2pXh45kb3k7GbhY5BZHBF+NqYNy
         UGY4GMdojNQiMny7zjL52fWlBS8V4p+Ae/mTX9t/lUicjYdC6WFrVgqqZKpRc/Rby9xw
         9Wng==
X-Gm-Message-State: AOJu0Yw6sEGsMkN8LkwGxpLAZF0Y2F+f07laG6ypYqlCze/pwHURBW+F
        JUVAUvIRcNApMFkJv0wnb+g=
X-Google-Smtp-Source: AGHT+IEZhlA0qpMdwNFTV5hwdM4rt1b7hmfpwTHcB6yWMVe/97tcVSSO50VgYAmwVP1/MPWFSqEmrA==
X-Received: by 2002:a05:6512:10c4:b0:500:7f71:e46b with SMTP id k4-20020a05651210c400b005007f71e46bmr488562lfg.1.1695146949278;
        Tue, 19 Sep 2023 11:09:09 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id k8-20020ac24568000000b00502ae6b8ebcsm137289lfm.304.2023.09.19.11.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 11:09:08 -0700 (PDT)
Message-ID: <7715e403-87ef-4e09-8c87-6e4f0119a921@gmail.com>
Date:   Tue, 19 Sep 2023 21:09:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: edma: handle irq_of_parse_and_map() errors
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Tony Lindgren <tony@atomide.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <f15cb6a7-8449-4f79-98b6-34072f04edbc@moroto.mountain>
Content-Language: en-US
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <f15cb6a7-8449-4f79-98b6-34072f04edbc@moroto.mountain>
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



On 9/15/23 15:59, Dan Carpenter wrote:
> Zero is not a valid IRQ for in-kernel code and the irq_of_parse_and_map()
> function returns zero on error.  So this check for valid IRQs should only
> accept values > 0.
> 
> Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> ---
>  drivers/dma/ti/edma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index aa8e2e8ac260..33d6d931b33b 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2401,7 +2401,7 @@ static int edma_probe(struct platform_device *pdev)
>  	if (irq < 0 && node)
>  		irq = irq_of_parse_and_map(node, 0);
>  
> -	if (irq >= 0) {
> +	if (irq > 0) {
>  		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
>  					  dev_name(dev));
>  		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
> @@ -2417,7 +2417,7 @@ static int edma_probe(struct platform_device *pdev)
>  	if (irq < 0 && node)
>  		irq = irq_of_parse_and_map(node, 2);
>  
> -	if (irq >= 0) {
> +	if (irq > 0) {
>  		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
>  					  dev_name(dev));
>  		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,

-- 
Péter
