Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435E37132B4
	for <lists+dmaengine@lfdr.de>; Sat, 27 May 2023 07:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjE0F5S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 May 2023 01:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjE0F5R (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 27 May 2023 01:57:17 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910329E
        for <dmaengine@vger.kernel.org>; Fri, 26 May 2023 22:57:16 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af318fa2b8so14674871fa.0
        for <dmaengine@vger.kernel.org>; Fri, 26 May 2023 22:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685167035; x=1687759035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ayOo1S1mN2iwDY+ZtD5MoU8WfCFytv2x0lNGGVjAY3M=;
        b=ZTRznvjOlAJ/NF2obWATQTv/CbZVzxm636XV1eVCnZl2IHl7HE00ke1vTxa35kiDYO
         OHHDk8tUxt2O1weS0d1matMQjl9XnGhbeieNrMpccUNPoOrKdl+N9ibaIT+ewgWe9bOt
         01kGX99Dt1+xSonCZ40SxZcYDxMfBbxL9E0idB5nDtHqPsqwstTIwZvwXoTCKrI2I/zW
         48b5t4hltRNZeTbI8TJEYpc2BiiuYzsYWLIL5re5EED9F5MjnGJP/K1WZxwSsZXKuoTf
         nI2TU2RaDkZYONCNojyIhZQ8P7d+8uVCaZj9rOzJcStDEvZUvWZVL3T3BGDwFb2w9uMl
         YG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685167035; x=1687759035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayOo1S1mN2iwDY+ZtD5MoU8WfCFytv2x0lNGGVjAY3M=;
        b=M1HAE7ziHZnTmQ5NBANOmISBw7RUuX00o+VZ0GGva6+M3FUQ6Ee2FxYKqfW75qmST4
         SaKyW+TqpNN3mcl+xSZcMQNLrCJv6t2RYfbDKo359Af3s1mv2EG8PBIcUbY6SpFvXR/n
         N+V8kn20gazvamHPFSXU2QXgmdoYv5rPw/a2ckXmeSJtqE5kxnz8cb4S2ecHEIs1NNh4
         0zQ4Z4nnWT9cSi1tXfalWCg3KuhCakThNlw98s28bvuNsM5njbfnXEWGPK4ebwppXeNJ
         OMdJOCU7du8TOufn/t0FovKYuTt/1V3LmuMBnZsLarq+iw233E5073xpNkXmlGGX6jBI
         VVDQ==
X-Gm-Message-State: AC+VfDxRj12oxcCavYtlHuOqm1jnt4mmfWdj4JLAyq7Cfq/wkS/5yi8P
        Gj+2Jw7CR8PO0+OB/fXowe7w160+EnG1cw==
X-Google-Smtp-Source: ACHHUZ4Wb/fcuuBUV6JYnqDpnz5iNbQNC3y9HOKl2e0wStHCSm6OnmqmB7Hc76wHOLpd5Hwup6gbPA==
X-Received: by 2002:a2e:9d54:0:b0:2ad:8f18:c7d8 with SMTP id y20-20020a2e9d54000000b002ad8f18c7d8mr1507771ljj.10.1685167034454;
        Fri, 26 May 2023 22:57:14 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id y14-20020a2e978e000000b002ad93c4c4e7sm1172733lji.83.2023.05.26.22.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 22:57:13 -0700 (PDT)
Message-ID: <fc662545-0912-49db-323b-ea90b3172851@gmail.com>
Date:   Sat, 27 May 2023 08:58:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH] dmaengine: ti: k3-udma: annotate pm function with
 __maybe_unused
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>
References: <20230516174311.117264-1-vkoul@kernel.org>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230516174311.117264-1-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/16/23 20:43, Vinod Koul wrote:
> We get a warning when PM is not set:
> 
> ../drivers/dma/ti/k3-udma.c:5552:12: warning: 'udma_pm_resume' defined but not used [-Wunused-function]
>  5552 | static int udma_pm_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~
> ../drivers/dma/ti/k3-udma.c:5530:12: warning: 'udma_pm_suspend' defined but not used [-Wunused-function]
>  5530 | static int udma_pm_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~
> 
> Fix this by annotating pm function with __maybe_unused

Sorry Vinod for missing the report and not reacting.

Thanks for the fix!

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Fixes: fbe05149e40b ("dmaengine: ti: k3-udma: Add system suspend/resume support")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/dma/ti/k3-udma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index fc3a2a05ab7b..b8329a23728d 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -5527,7 +5527,7 @@ static int udma_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int udma_pm_suspend(struct device *dev)
> +static int __maybe_unused udma_pm_suspend(struct device *dev)
>  {
>  	struct udma_dev *ud = dev_get_drvdata(dev);
>  	struct dma_device *dma_dev = &ud->ddev;
> @@ -5549,7 +5549,7 @@ static int udma_pm_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int udma_pm_resume(struct device *dev)
> +static int __maybe_unused udma_pm_resume(struct device *dev)
>  {
>  	struct udma_dev *ud = dev_get_drvdata(dev);
>  	struct dma_device *dma_dev = &ud->ddev;

-- 
Péter
