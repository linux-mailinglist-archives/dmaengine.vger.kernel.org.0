Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41D536BEA
	for <lists+dmaengine@lfdr.de>; Sat, 28 May 2022 11:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiE1J1p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 28 May 2022 05:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiE1J1k (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 28 May 2022 05:27:40 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951DD28721;
        Sat, 28 May 2022 02:27:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id v9so7106691lja.12;
        Sat, 28 May 2022 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xvrSiB4pj3MHmuSBOutVdLdl/gUFdwjp1RjV9E5xjHA=;
        b=LhNdRcsIQVqY4OEOoVjSqa5PExlZc2sT6sti/p7IGZPk7ISRfTN5v69aARBEXOZXnb
         Ekpye5mMo1cW2z7faSztdJqKQx16njUTBGet862Qt7IFt2loNMq28X62SVCUxpVeDpb0
         tjYxBavD8N45YyNjnOsoT8fL85mdO/g7iK1viqHwh+jXdti2BS+vgVYDhMbolanMFKtl
         7xClvJTdPi979NvVvMjg+C/gkJf2Pi8wrFyp+Y7sJ6rLmca0THAbFiiIMdLwapT3NL2R
         PWgm/gVUT/tqeBHRuA2rSWHW8PKk6Hl6n+W8FtGeu++u2D8IsChb5fndngIkW3cH0mBr
         2iWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xvrSiB4pj3MHmuSBOutVdLdl/gUFdwjp1RjV9E5xjHA=;
        b=LQ1N9pIqPlI2f9Nd7kj/uWEHEyrSKidFcriJuwcHHPOnel2Hi3+rA0gqB9AguC8F/2
         K6pFkgAf5uvU9Vk+CGazkTIPMLEWr4+pr3H3A5yfh+of/+z8bOulQsK9qfQlVBKDaGIf
         K0aoI7i9h92Ly6JQQQoKdVnaFjGH8SUhgu9zTtCAZbujpDMKb+ooXE0Ii+iy6tZMUAKH
         nDhL9v++porznhEVi66KtCfJyE9NJwehTpkD5i7OMYsMOhNMaPcO/8o/tmu9Nz5mBJOa
         7tfQspMZ1M8PpV2KnRjfVsQ6HFmSz4RylPrw/df+JiFr+QCgH6M37HZECNMlViWq8wpx
         qsug==
X-Gm-Message-State: AOAM53141TrYFo0XWfB7U19+OgIttE1H3l6udysJcLJJqJkxJMMBAvCR
        8zqxuHxvNQbQj+yvAjZdby8=
X-Google-Smtp-Source: ABdhPJwAZEm4uQgSgG2FHkD4/g4oal0KQxI6Q5xbNJnso+HjYczVMgU+7dozg6xJgHampz1i5qC0kQ==
X-Received: by 2002:a2e:9e11:0:b0:24c:5677:8b20 with SMTP id e17-20020a2e9e11000000b0024c56778b20mr27745577ljk.430.1653730057936;
        Sat, 28 May 2022 02:27:37 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id v10-20020ac2558a000000b0047255d211e1sm1241515lfg.272.2022.05.28.02.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 02:27:37 -0700 (PDT)
Message-ID: <1f7277fc-8634-94ff-0fe6-6fd087d8e588@gmail.com>
Date:   Sat, 28 May 2022 12:28:50 +0300
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

Good catch, obviously this has not been hit for almost a decade :o

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Fixes: 6d10c3950bf4 ("ARM: edma: Get IP configuration from HW (number of channels, tc, etc)")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Note that the devm_kcalloc() in edma_xbar_event_map() looks also spurious.
> However, this looks fine to me because of the 'nelm >>= 1;' before the
> 'for' loop.
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
