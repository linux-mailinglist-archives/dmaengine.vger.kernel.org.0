Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C916357B12B
	for <lists+dmaengine@lfdr.de>; Wed, 20 Jul 2022 08:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiGTGiC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Jul 2022 02:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiGTGiB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Jul 2022 02:38:01 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399A05C9C6
        for <dmaengine@vger.kernel.org>; Tue, 19 Jul 2022 23:38:00 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id p6so19990462ljc.8
        for <dmaengine@vger.kernel.org>; Tue, 19 Jul 2022 23:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=tftu4FrhP/bwM435Qh4R85JnUGfC7rrzMunPlnrs48w=;
        b=U4eLkMJ0JvhFS0RGNjSOGm/BIVrP2IRZXmY+leZ1+prD+ip5tWDh71Bjb4GDesn9fJ
         PoUunqMCdF3d3eHvYnlP5pqOcTqTtdwsHtM9bOfhoGmXaIeRSmnDmtyBtgoulkElPYsk
         AislNeCj9VvBuJMneEHirHazPNQYzm+GwuTYNf2ueYj1eTldIKTKi7KUIaRiNMaM6Ove
         QJ9P/Z3b3GjqybkUPtVDoIQWYSw65D/OOaxP++0RONTyczpms1TZzPGJa2tXjKCFfnAO
         rZCXG9GO6b0pa7HhIE+Ij/Dn8Woh6F2PNiZk5oOqVWdpBTBImhGn73ECdKHQXtDf/O4L
         HTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=tftu4FrhP/bwM435Qh4R85JnUGfC7rrzMunPlnrs48w=;
        b=ho1RQsqIEhZsi0Dn8HAHfAvZrWps7OOg2BcCmMAYSChEQtTK+1N4Nqx6Xx9J8n/xu0
         53NbtXN71sCA8Sj1NFJQRfMsGam7womZJEM5CXvfQEf4IwA4dKxwP+szpAGZSWchBxY4
         UFZhJPhlTmq4GCU/0hx3r/j+IQH8gfEv44ygXWcXDOFOfI8XEETF6reHUpdRc7uVUdoF
         rNrZps1fSWPThE54OGSTJp0GK0oJCIcUaY3+qEK1qCtjFX0/5sz94VkxHjD0M/vPSjFu
         YrQfXNOzgRULsGXOP/oF2jqS6RZfZIsjvYF+uc2jvEXPOlc4IueqzCtdu37WVJo2flGf
         Tv3Q==
X-Gm-Message-State: AJIora+RS3UZs2GzEIwRdLsKG9YtUS10bu6vWDJa3JPeIRfiBCu+QiHj
        hlIAO80dnJ2rhvEnubdqrGv4VVM4Lek=
X-Google-Smtp-Source: AGRyM1tMzOxrGi7g5drwQbjOYiYVt1TiXMxqKvRQgmnIgzBGk8V3ehJ9NQVN2hq+0LQezkwWNIlfqw==
X-Received: by 2002:a2e:9f16:0:b0:25d:48a9:4f2a with SMTP id u22-20020a2e9f16000000b0025d48a94f2amr16522764ljk.454.1658299078375;
        Tue, 19 Jul 2022 23:37:58 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id y17-20020a05651c107100b0025bd022ffebsm3047689ljm.50.2022.07.19.23.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 23:37:57 -0700 (PDT)
Message-ID: <fec32664-3f7a-aaa7-489b-10916544ce33@gmail.com>
Date:   Wed, 20 Jul 2022 09:39:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Liang He <windhl@126.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org
References: <20220716084642.701268-1-windhl@126.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] dmaengine: ti: k3-udma-private: Fix refcount leak bug in
 of_xudma_dev_get()
In-Reply-To: <20220716084642.701268-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8
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

On 16/07/2022 11:46, Liang He wrote:
> We should call of_node_put() for the reference returned by
> of_parse_phandle() in fail path or when it is not used anymore.
> Here we only need to move the of_node_put() before the check.

Thank you for the analysis, yes, this is a bug.

If you add the missing blank line, you can attach my:
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Fixes: d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine users")
> Signed-off-by: Liang He <windhl@126.com>
> ---
> 
> I cannot find the 'k3-udma-private.c' comiple item in drivers/dma/ti/Makefile, 
> I wonder if the author has forgotten the compile item and the
> k3-udma-private.c has not been compiled before.
> 
> I have tried to add k3-udma-private.o in the Makefile, but there are lots of
> compile errors.  
> Please check it carefully and if possbile please teach me how to compile it, thanks.

the k3-udma-private.c is included in to k3-udma.c (see end of file).
When the UDMA stack was introduced we needed to have a glue layer to
service the networking users due to the lack of infrastructure via
DMAengine.
The glue layer needs to tap in to the DMAengine driver, but I did not
wanted to expose low level interfaces, structs, ops in order to be able
to get rid of the glue layer when we have all the needed features in
DMAengine.

The k3-udma-private.c is part of the k3-udma.c but kept as separate file
to make it explicit that it is suppose to go away and to not mix it with
the DMAengine driver.

>  drivers/dma/ti/k3-udma-private.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
> index d4f1e4e9603a..ec274ef7d5ea 100644
> --- a/drivers/dma/ti/k3-udma-private.c
> +++ b/drivers/dma/ti/k3-udma-private.c
> @@ -31,14 +31,13 @@ struct udma_dev *of_xudma_dev_get(struct device_node *np, const char *property)
>  	}
>  
>  	pdev = of_find_device_by_node(udma_node);
> +	if (np != udma_node)
> +		of_node_put(udma_node);

Can you add a blank line here for readability?

>  	if (!pdev) {
>  		pr_debug("UDMA device not found\n");
>  		return ERR_PTR(-EPROBE_DEFER);
>  	}
>  
> -	if (np != udma_node)
> -		of_node_put(udma_node);
> -
>  	ud = platform_get_drvdata(pdev);
>  	if (!ud) {
>  		pr_debug("UDMA has not been probed\n");

-- 
Péter
