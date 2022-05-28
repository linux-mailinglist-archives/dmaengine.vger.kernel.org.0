Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A547536BF1
	for <lists+dmaengine@lfdr.de>; Sat, 28 May 2022 11:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiE1Jcg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 28 May 2022 05:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiE1Jcg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 28 May 2022 05:32:36 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C024AEAD;
        Sat, 28 May 2022 02:32:33 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id g18so63486ljd.0;
        Sat, 28 May 2022 02:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jqsnSDEFUx4RGESxiA8fNaws5K3TFUXqX5aOXhweVqY=;
        b=OXJzUQkhHmNbkMrpV5tlj6Kza7rPOQMVCho+Z1VImTEaS5x5/txUufQg17rsyDQOD/
         n5ZYzcy5DX000GLoVm1QpP4bapXsxgNxFBS/f76in84hozldype6wq95QjmbYUefB1BH
         0yPD77OXeQAt1T55Xs7Upmocu/vgJW4EZheEgn7b7d/FN3R+Hp4mq4AMajztmPK7hdYe
         F6Q17yqz1N5QEqYsi4M/hrwRfLUrSADKR6UT6YOrTFBmcb392XUkS8AYaFrQVzSA0k8X
         9BXAUgkDSepAr4HUq29p+BhFhq4OjNJVI12cT0rzcSWSOLTv3KdTFhkv+MJAkuz30IWj
         1cBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jqsnSDEFUx4RGESxiA8fNaws5K3TFUXqX5aOXhweVqY=;
        b=c20Cc5EHimOCmEZ03CsmcHrrplbDAvWumamhBYlAzjVcaQjX/Foj8riq6opzlwgZEK
         xvU54HIkI3apyEaMjDPnUrj7L8FcLerA6tgB6DDsBjqEzNfXFEGkbYHy9yhTyaMJFyzG
         xJ1hFX93QYhnVlYvyF0XQZR4ivjTbP1uBqO2yzxnyAvHdGOvKHC8IKiA9YElSAYsWf9v
         DKO2uGPar5cDEGMj9+JPQvxUKmocnj19CWHifA7zs7bUGIc3/uw3m5lxusafw2SKOekM
         3B01JwNzq6xsjrW+UzXQGrr5MmUbWj6fZ5lIco4qxvf5hoCAolSy8GltdG79fbGGQ6GY
         R0vQ==
X-Gm-Message-State: AOAM532z/THXoiALcsWLUdL+IhVQIMrZIhW/K/X/Se79mPb0FmKK3UYK
        GdO1cRspGCw3M5wjq+Vwhjw=
X-Google-Smtp-Source: ABdhPJxAcpY15g7jjyskmgu4GUMwaqF1m0VjEIHzsCeONFiO4rt++dRza6i54U8k58ldRmAiN7QnWQ==
X-Received: by 2002:a2e:9b4c:0:b0:253:e2e8:2c10 with SMTP id o12-20020a2e9b4c000000b00253e2e82c10mr20988561ljj.228.1653730352144;
        Sat, 28 May 2022 02:32:32 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id s3-20020a197703000000b004789bfa539fsm1252858lfc.90.2022.05.28.02.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 02:32:31 -0700 (PDT)
Message-ID: <6e750770-fcda-d157-21d1-872a611c3bf2@gmail.com>
Date:   Sat, 28 May 2022 12:33:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dmaengine: ti: Fix a potential under memory allocation
 issue in edma_setup_from_hw()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dan.carpenter@oracle.com, Vinod Koul <vkoul@kernel.org>,
        Joel Fernandes <joelf@ti.com>, Sekhar Nori <nsekhar@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org
References: <8c95c485be294e64457606089a2a56e68e2ebd1a.1653153959.git.christophe.jaillet@wanadoo.fr>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <8c95c485be294e64457606089a2a56e68e2ebd1a.1653153959.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 21/05/2022 20:26, Christophe JAILLET wrote:
> If the 'queue_priority_mapping' is not provided, we need to allocate the
> correct amount of memory. Each entry takes 2 s8, so actually less memory
> than needed is allocated.
> 
> Update the size of each entry when the memory is devm_kcalloc'ed.
> 
> Fixes: 6d10c3950bf4 ("ARM: edma: Get IP configuration from HW (number of channels, tc, etc)")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Note that the devm_kcalloc() in edma_xbar_event_map() looks also spurious.
> However, this looks fine to me because of the 'nelm >>= 1;' before the
> 'for' loop.

This has been deprecated ever since we have moved to dma router to
handle the xbar for various TI platforms, but by the looks it kida looks
bogus in a same way.

> ---
>  drivers/dma/ti/edma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 3ea8ef7f57df..f313e2cf542c 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2121,7 +2121,7 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
>  	 * priority. So Q0 is the highest priority queue and the last queue has
>  	 * the lowest priority.
>  	 */
> -	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8),
> +	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8) * 2,
>  					  GFP_KERNEL);
>  	if (!queue_priority_map)
>  		return -ENOMEM;

-- 
Péter
