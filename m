Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65457AAFDC
	for <lists+dmaengine@lfdr.de>; Fri, 22 Sep 2023 12:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjIVKqM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Sep 2023 06:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjIVKqL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Sep 2023 06:46:11 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE770C2
        for <dmaengine@vger.kernel.org>; Fri, 22 Sep 2023 03:46:05 -0700 (PDT)
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1569741DC9
        for <dmaengine@vger.kernel.org>; Fri, 22 Sep 2023 10:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695379564;
        bh=t+yfri1GJX2TAqcf+QwODASIE2sxjrbU+UlJZ8d2HDM=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=W9atVzRnraNce/rhT4QaiY3HpJqg5wCOf5wA2XDqgTYjcSKNX+Zx+ol08sgAb4VwO
         2BmyJWmxxgjMWMFhfFjApkw7gEm5ITqYjfIiTCzGY4tQddE+oEeQBrKGbxFq0triJX
         4cLTqkQotMjgZL3uWmgnFFNaShznWSRSFI6otNR+Pes7RQXHW/k0nxlXEV2KLG3Mkz
         qL6Ako6jQoGqbDf1mCVUqb0he15N06+x+J77du/ln7X6MXIZkspF+dBpgSw7k2Xi7b
         im+gOAnoR5kRjy8l0ilMQOAC/nWtOHJrOGBaNSj0rAdLTwmPgdn0Hy1UKICR9DiVOj
         Gg0+G7JKsAV+Q==
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76dbec0d84eso221240885a.3
        for <dmaengine@vger.kernel.org>; Fri, 22 Sep 2023 03:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695379562; x=1695984362;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+yfri1GJX2TAqcf+QwODASIE2sxjrbU+UlJZ8d2HDM=;
        b=JBmPjo9ylUx3P2dYhzpFjnYbHOMivRkGdVY9j+HYnyui0sj+3CGfDyKtb2SMDuhQma
         8MdVJP0HKBedlse6yLSJBK+Kl4Jq0cRj9dv/RqCJOPWAVbMluXpIEVMTOy6NykZD18i1
         DkLk7vw9WJV/vtWrl87NLJomQy0+/dHfMnt9WLAYgk8e1+fwCDs+z6/rLBlG8adb6aeW
         ODXXd8m9Q2BzcjzkniWBFOLU2ay6Z3WsirO4ArGEu+EeKMcmTiPpBx24v9+49QscMPue
         3GcuNKIp4gbVUyg7Sr9x8K6LNZptVljH4ebcGzIF0W6A6WrJ/mBsSWm16eicstHDLwZX
         c+Vw==
X-Gm-Message-State: AOJu0YyZb9Tx1X9JA0cjfHR7z7bAw7fOuNa8SXVnD9XUc1cKxgZlISZu
        Q6P9bVi2nw7ENvZog/3UzrmgdbnPxnkzLrZ9QvvRn9w6TtOiLvcbxm1Kab59jNgsTBUFVChOKBT
        5HQ4zPPfCM3trLX7e/xIWIgc/lxRGzTGWeK+xhqHaRftStdT1lNgYfxaf5bnVmA==
X-Received: by 2002:a05:620a:2ac7:b0:76c:ad46:2683 with SMTP id bn7-20020a05620a2ac700b0076cad462683mr6971763qkb.16.1695379562236;
        Fri, 22 Sep 2023 03:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsox++PPWys6ngzHVyCF3Eihkl1gwpI0tFPIgNbTUyaezen3cYl9nj+cZZ23a8Pw9GmdY7EyJwq7TGifvy6yc=
X-Received: by 2002:a05:620a:2ac7:b0:76c:ad46:2683 with SMTP id
 bn7-20020a05620a2ac700b0076cad462683mr6971744qkb.16.1695379561942; Fri, 22
 Sep 2023 03:46:01 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Sep 2023 03:46:01 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230922095039.74878-2-shravan.chippa@microchip.com>
References: <20230922095039.74878-1-shravan.chippa@microchip.com> <20230922095039.74878-2-shravan.chippa@microchip.com>
Mime-Version: 1.0
Date:   Fri, 22 Sep 2023 03:46:01 -0700
Message-ID: <CAJM55Z-NUwzo9SKtmV_5OegznDjSQEG9DVK7=5x4qnxUkk399A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dmaengine: sf-pdma: Support of_dma_controller_register()
To:     shravan chippa <shravan.chippa@microchip.com>,
        green.wan@sifive.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor+dt@kernel.org, palmer@sifive.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nagasuresh.relli@microchip.com, praveen.kumar@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

shravan chippa wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
>
> Update sf-pdma driver to adopt generic DMA device tree bindings.
> It calls of_dma_controller_register() with sf-pdma specific
> of_dma_xlate to get the generic DMA device tree helper support
> and the DMA clients can look up the sf-pdma controller using
> standard APIs.
>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 41 +++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index d1c6956af452..c7558c9f9ac3 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -20,6 +20,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/of.h>
> +#include <linux/of_dma.h>
>  #include <linux/slab.h>
>
>  #include "sf-pdma.h"
> @@ -490,6 +491,33 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
>  	}
>  }
>
> +static struct dma_chan *sf_pdma_of_xlate(struct of_phandle_args *dma_spec,
> +					 struct of_dma *ofdma)
> +{
> +	struct sf_pdma *pdma = ofdma->of_dma_data;
> +	struct device *dev = pdma->dma_dev.dev;
> +	struct sf_pdma_chan  *chan;
> +	struct dma_chan *c;
> +	u32 channel_id;
> +
> +	if (dma_spec->args_count != 1) {
> +		dev_err(dev, "Bad number of cells\n");
> +		return NULL;
> +	}
> +
> +	channel_id = dma_spec->args[0];
> +
> +	chan = &pdma->chans[channel_id];
> +
> +	c = dma_get_slave_channel(&chan->vchan.chan);
> +	if (!c) {
> +		dev_err(dev, "No more channels available\n");
> +		return NULL;
> +	}
> +
> +	return c;
> +}
> +
>  static int sf_pdma_probe(struct platform_device *pdev)
>  {
>  	struct sf_pdma *pdma;
> @@ -563,7 +591,20 @@ static int sf_pdma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> +	ret = of_dma_controller_register(pdev->dev.of_node,
> +					 sf_pdma_of_xlate, pdma);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Can't register SiFive Platform OF_DMA. (%d)\n", ret);
> +		goto err_unregister;
> +	}
> +

Hi Shrivan,

Doesn't this need a matching unregister/free call in the
sf_pdma_remove function?

/Emil

>  	return 0;
> +
> +err_unregister:
> +	dma_async_device_unregister(&pdma->dma_dev);
> +
> +	return ret;
>  }
>
>  static int sf_pdma_remove(struct platform_device *pdev)
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
