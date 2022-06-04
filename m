Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471FD53D887
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jun 2022 22:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbiFDUsS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 Jun 2022 16:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241131AbiFDUsR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 4 Jun 2022 16:48:17 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F12128E00;
        Sat,  4 Jun 2022 13:48:16 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 1so11918646ljp.8;
        Sat, 04 Jun 2022 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=T2AlePpmVJKryWFICiGoqGtnMHiCvzRvJMnyAaH0SZs=;
        b=WyRI0B3ZKrotgayJkSKlHqSiAGBmp4UbKK7TgNBinPYcZsw4kHmEwlvmaPMJ6Tjnno
         dkjSNnDmS3/TI9jwD+udGLyl2QcE0g47hCAZxfn7ierVmLRXu+k+cxlBzC70C4CIXPIZ
         f9c7rcbDo7PBnEoW6oXRj7Cx8DHumqqE27j48u/OrgFh9CZQAF0Jb5aS3qwaZrGWSLu/
         aPFM/xPonuErUfRqs8JqmJCSXykNOEUgk+iYGTn7tT3Lp0OMV/m4vhIYg01KVBTAxTrZ
         FRD1mzgC4GYntlZGQelH0XyFyMyOwE3LXdQVhznpMQufBv454nC6hgjoJgXDQtBFZL+Z
         oeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T2AlePpmVJKryWFICiGoqGtnMHiCvzRvJMnyAaH0SZs=;
        b=JN94famca1fRWH1/NN5o7io95wF0QgJi09gRCPWaOD1opcSvOx4aB92cdmlwXYViJ6
         6K/h2YG02+jUSgu+cIpKLOWLHkbrDUosOX//N6W9uOMnPI1lphMn+IocP7ajDTusxCxN
         5rXdq5WA8bnDFmEEvN324j9KPmAGONXI7Ulau8lTD68x0P639UQ57/8mS4lGJgN8jc19
         p3twFeaSR542VyWLszAMZHUjE7FC/SjHUzkpSNniIoLXhJt7enNJGCAKV30R6FI1bmJE
         N4AqusHgE3zOTYJzY2DawGWJYStddpxMTgshJnr8uuHmORGJSrIdZl8k92CUi6DeVy+f
         RxBw==
X-Gm-Message-State: AOAM531FELQmrlQlGUGqAY+1b5sKeddhucttsN21WV2DfLSiV8Gn/fp+
        D9vFG9ViNnw9BbO8/CXN71s=
X-Google-Smtp-Source: ABdhPJw+IA0ZUPXlym07jPgpV3ExuXyLQnyrbO+QsJdbsp63ZNvWOe9hxhhyWHOH2UBFkpf6u5N2gg==
X-Received: by 2002:a2e:9e88:0:b0:250:654a:847c with SMTP id f8-20020a2e9e88000000b00250654a847cmr47329620ljk.214.1654375694526;
        Sat, 04 Jun 2022 13:48:14 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id a25-20020a05651c031900b0024f3d1daea0sm1949376ljp.40.2022.06.04.13.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jun 2022 13:48:13 -0700 (PDT)
Message-ID: <b43ae2ad-4eb7-5376-6e3a-0a8310acc34a@gmail.com>
Date:   Sat, 4 Jun 2022 23:49:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] dmaengine: ti: Fix refcount leak in
 ti_dra7_xbar_route_allocate
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>, dave.jiang@intel.com,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220601105546.53068-1-linmq006@gmail.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220601105546.53068-1-linmq006@gmail.com>
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



On 01/06/2022 13:55, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not needed anymore.
> 
> Add missing of_node_put() in to fix this.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Fixes: ec9bfa1e1a79 ("dmaengine: ti-dma-crossbar: dra7: Use bitops instead of idr")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> - split v1 into two patches.
> v1 link: https://lore.kernel.org/r/20220512051815.11946-1-linmq006@gmail.com
> ---
>  drivers/dma/ti/dma-crossbar.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
> index 71d24fc07c00..e34cfb50d241 100644
> --- a/drivers/dma/ti/dma-crossbar.c
> +++ b/drivers/dma/ti/dma-crossbar.c
> @@ -268,6 +268,7 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
>  		mutex_unlock(&xbar->mutex);
>  		dev_err(&pdev->dev, "Run out of free DMA requests\n");
>  		kfree(map);
> +		of_node_put(dma_spec->np);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  	set_bit(map->xbar_out, xbar->dma_inuse);

-- 
Péter
