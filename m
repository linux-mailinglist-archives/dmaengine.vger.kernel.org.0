Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1380E53D88F
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jun 2022 22:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbiFDU5q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 Jun 2022 16:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiFDU5q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 4 Jun 2022 16:57:46 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C711408B;
        Sat,  4 Jun 2022 13:57:44 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y29so11922053ljd.7;
        Sat, 04 Jun 2022 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=Mjaa1gmx+OGviIUuZZFZ8twv+6L+3H6yheyEOcviWp4=;
        b=NCONz+xeNP9xsKjr6JeYhXC+M/FcZ/aCzBLntTyLtwpdKBrweqrDS51emhQX1shQKA
         0E8kkKJRjyxOXmGrkLTdXwynpI4aNrEmhSMvqEEg/T4bflHAu4zpdwGap3wPBBX3GCwg
         nPCssSi/bfiOpk8FURXhBV/w6tvQkHh+XA+YAZB2rR0zeT6dBVveyc8k7M97Kkzdvsbw
         dqGgoXoovhPU+QCutNaJtdxFMYtjE0tVcEUUATRiK5SzTpNTbBSREOxbvOJt+JEi7FkF
         gV+NuQx8/TxprQyLMi3kW83Sm1o/2JbQNr6pxCIbq0noTP/Z0UOIdQ0lEky1va8RDoPU
         IjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=Mjaa1gmx+OGviIUuZZFZ8twv+6L+3H6yheyEOcviWp4=;
        b=Y2AuxQJEqTEn1iQ4TXaGl1fKH6YJ6QPmPziAUVdH3iXGihx5LUVs7d6t2UQ1JrPQag
         20XFSzm28iVLIdOJmaFqQv99H9JDl+9fGLvGV/a2xveNhxUdyjJe9YMpdHR6mjYoiqcl
         q1iF7xlZfjsmpzliUtW5t9pT9Gg8cmJ2Grg+qdxyLbO4VDJwRXYC3u+Bt7D1xCWrxGje
         t3bSf0co77BlA/XG92Xi/5eDZvPy8V8sDaiuQZoahfuSiJSO9XdvMpVfvrFRI3yuVJaK
         aR/xvUvh1OFy9OUQAta6CsBLMfNEE6S3JMBhITyh82lm7lTUZGxImp5aMyBc+6ZDgO5v
         Eaww==
X-Gm-Message-State: AOAM5303HFz363o5oDQvxzltyU9PFwSjwcEJMvmcav5FXV4MXu4HSkyU
        YqK5GCa/y7lWWbYnwP3OqDU=
X-Google-Smtp-Source: ABdhPJw3/kwLRVwOi4fb5ytfXb6Nt+ODldVUt3ffDj0jfNdYm9CGAy5xJ61snt90MKXBO04UoYDUTw==
X-Received: by 2002:a2e:8081:0:b0:253:ce61:3c66 with SMTP id i1-20020a2e8081000000b00253ce613c66mr48707841ljg.98.1654376263155;
        Sat, 04 Jun 2022 13:57:43 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id k18-20020a192d12000000b0047920d89606sm614250lfj.187.2022.06.04.13.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jun 2022 13:57:42 -0700 (PDT)
Message-ID: <a3a99b6a-70c7-5b6b-718f-44c4d957cdda@gmail.com>
Date:   Sat, 4 Jun 2022 23:59:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>, dave.jiang@intel.com,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220601110013.55366-1-linmq006@gmail.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH v2] dmaengine: ti: Add missing put_device in
 ti_dra7_xbar_route_allocate
In-Reply-To: <20220601110013.55366-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 01/06/2022 14:00, Miaoqian Lin wrote:
> of_find_device_by_node() takes reference, we should use put_device()
> to release it when not need anymore.

adding a new label and using goto would be another option or even better?

> Fixes: a074ae38f859 ("dmaengine: Add driver for TI DMA crossbar on DRA7x")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - split v1 into two patches.
> v1 link:
> https://lore.kernel.org/r/20220512051815.11946-1-linmq006@gmail.com
> ---
>  drivers/dma/ti/dma-crossbar.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
> index 71d24fc07c00..06da13b18a7b 100644
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
> @@ -268,6 +271,7 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
>  		mutex_unlock(&xbar->mutex);
>  		dev_err(&pdev->dev, "Run out of free DMA requests\n");
>  		kfree(map);
> +		put_device(&pdev->dev);

this will not apply with the other patch going separately...
Can you send a two patch series?
While there, I would check if labels+goto would look better?

Thanks for finding these and fixing it!

>  		return ERR_PTR(-ENOMEM);
>  	}
>  	set_bit(map->xbar_out, xbar->dma_inuse);

-- 
Péter
