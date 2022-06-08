Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB95A543BB3
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jun 2022 20:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiFHSqM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Jun 2022 14:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiFHSqH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Jun 2022 14:46:07 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E35544F7;
        Wed,  8 Jun 2022 11:46:03 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id v9so23693423lja.12;
        Wed, 08 Jun 2022 11:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=gGnCAeAprc8+7XJKCHpSYZzbdEKjjYjwEVeB/dDQCS4=;
        b=kfnDxkgAnsbiS6mgtZuhu2N1DcqgY6zP8hyQWDUsTrr9FPyh0MZmmxPWmTLxiLO4x/
         9liYv2mn5A7/dDbriOAnF0/s2onaWpSgBDpxT6dekrX81DO9g4VHIzAl+p4sdUgiL4oN
         TvneENMJnFy9FCGx9nYckfwMsKsVp+dHIT7TeLHNLjuxUCa8aBD7smEfea6Qyo40a3VX
         eW0Bm8lw64jYgQefGIZZLnbKzBNrUSLoFsRoPSB7bgj4vWBwSAknyZ7GpnzYtm3BlGn7
         plJGkHsrSzlUcPGIbHF7V8Q4wuvz6ICt+Xoq1ki/WwG9iQc2ysBPdm6Mtz9y6y4ibXMU
         J4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gGnCAeAprc8+7XJKCHpSYZzbdEKjjYjwEVeB/dDQCS4=;
        b=UDhoeHHszPI6hAOhhLQ0rdWq5kDeiG5Ks8hvrE7Gbm7+vY6Y5Z6Oubuiz5fRRQac7h
         KBdvY28wvMwQ7FOoAH4fIdMF3JBPi2qtwFV3WQEd7f/xNGMsHA8cDMdkiopLGG9bp2x3
         nWTxGdveOQ8YDKQcPJCDM4JxCHBwUc01jaEtoA7Jpqyx58Lco25ef5nCV0HaQukg+IZk
         88jNnRHGwNEkpqtwPA3J23yuKfoRIV2TAAFaxZ6b85jirZ+5Jr4iU5uf9NwhBoZ2d7/n
         HGU4hIqF8pTGadFroqygGyfJ8zJQLMQqWMRrog1zrwTEgHqryHaeIEv6MUAmpb4h+H+l
         JBVw==
X-Gm-Message-State: AOAM532dvtUOpS3NkaTumG6KE5oLab94Uxrgoa6HNa1zgm6dLFdPjm0f
        l+9tRir0HQqxc3kPBqtAaIc=
X-Google-Smtp-Source: ABdhPJwiDWTLNMMZWgfy3KVOejVOa3okm04gI4o2Nk9WNbmY56Tpkx3JATBXM5522Uo8zlTsytz2Tg==
X-Received: by 2002:a2e:a552:0:b0:255:a378:72db with SMTP id e18-20020a2ea552000000b00255a37872dbmr7268175ljn.504.1654713962018;
        Wed, 08 Jun 2022 11:46:02 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id x15-20020ac25dcf000000b0047255d210dbsm3847271lfq.10.2022.06.08.11.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 11:46:01 -0700 (PDT)
Message-ID: <df2333e1-fae0-3e9a-2b47-3ac26c583876@gmail.com>
Date:   Wed, 8 Jun 2022 21:47:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/2] dmaengine: ti: Add missing put_device in
 ti_dra7_xbar_route_allocate
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220605042723.17668-1-linmq006@gmail.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220605042723.17668-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 05/06/2022 07:27, Miaoqian Lin wrote:
> of_find_device_by_node() takes reference, we should use put_device()
> to release it when not need anymore.

Thank you for the update!

For both:
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Fixes: a074ae38f859 ("dmaengine: Add driver for TI DMA crossbar on DRA7x")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v3:
> - rebase so it can apply with the other patch
> changes in v2:
> - split v1 into two patches.
> v1 link:
> https://lore.kernel.org/r/20220512051815.11946-1-linmq006@gmail.com
> v2 link:
> https://lore.kernel.org/r/20220601110013.55366-1-linmq006@gmail.com/
> ---
>  drivers/dma/ti/dma-crossbar.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
> index e34cfb50d241..f744ddbbbad7 100644
> --- a/drivers/dma/ti/dma-crossbar.c
> +++ b/drivers/dma/ti/dma-crossbar.c
> @@ -245,6 +245,7 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
>  	if (dma_spec->args[0] >= xbar->xbar_requests) {
>  		dev_err(&pdev->dev, "Invalid XBAR request number: %d\n",
>  			dma_spec->args[0]);
> +		put_device(&pdev->dev);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> @@ -252,12 +253,14 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
>  	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
>  	if (!dma_spec->np) {
>  		dev_err(&pdev->dev, "Can't get DMA master\n");
> +		put_device(&pdev->dev);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
>  	map = kzalloc(sizeof(*map), GFP_KERNEL);
>  	if (!map) {
>  		of_node_put(dma_spec->np);
> +		put_device(&pdev->dev);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> @@ -269,6 +272,7 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
>  		dev_err(&pdev->dev, "Run out of free DMA requests\n");
>  		kfree(map);
>  		of_node_put(dma_spec->np);
> +		put_device(&pdev->dev);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  	set_bit(map->xbar_out, xbar->dma_inuse);

-- 
Péter
