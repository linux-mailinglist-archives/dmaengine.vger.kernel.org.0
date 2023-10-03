Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634B27B628E
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 09:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjJCHfU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 03:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjJCHfU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 03:35:20 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4900390
        for <dmaengine@vger.kernel.org>; Tue,  3 Oct 2023 00:35:16 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DE75C3F63B
        for <dmaengine@vger.kernel.org>; Tue,  3 Oct 2023 07:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1696318513;
        bh=C2LI02pllk3xNmgu5C2lERlc5CopHtR66RkR1No21/8=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=O6xOrXc04Bi8JsPoiU5VGG811uj4vlBRHVlRBPeMMU98RqRWYD0GoG5atYH+fk84F
         iAA9i8/IFybmBRdqDgiiYvQWWBGd+ivBUO6WRb6gkzxp5EnK0ONAmMmpAzmw4V4eDh
         A43PswM/I1GC2ZoCrRaUL5oRVXu15PMe+ME2ASybs8hrPECYQcKA83EnTIPJcZCmPT
         LRtdf2+lJ/unkyxIvCCSfxD8xRaJ21Qfme6M9Y6ByrbzMJGNwAgMS1GPWVXJ0Ijsq5
         BvWepw0MtcWnxtvAQmilQHJ/yjGYDNG0sRAnA1PgZ5HZCVU7s425UIm8H43g5+Mft8
         l+e25mIyRybVw==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-419624b11c1so6844721cf.0
        for <dmaengine@vger.kernel.org>; Tue, 03 Oct 2023 00:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696318512; x=1696923312;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2LI02pllk3xNmgu5C2lERlc5CopHtR66RkR1No21/8=;
        b=M11ZUUJL0C0JtC722axKXryOAjsor1P5UJTcQw7LqC6TjCa03e7a2reBdPu3WQLFhO
         UnOcExYiJTJ4KjQ9O6+aZmA0i66ipm3TPiZVYnORkRnbLWPQ5HkqSPd04dstzwGmiYDI
         7kybeGAYyFWOoz9V6HD+HR4HP+/f1jVTSKVu3lcoTH+1zuY2foQ2VsprsOJrZ0p8FdZb
         u0nsDdkIcTjgfXtu6BqPGR1yA4LLY/qp7O37JQ9ET4So9g4iZuERxjlnJuJCQ/fy54JQ
         gQkBZzM+0q90AceEazoPawjdbMO526SitT2TI+qGWV1hsxaqwTN3zRbmDkDO20xd/5si
         8ICw==
X-Gm-Message-State: AOJu0YyaETyk5NIemJNXqZg0dSueiAR+UhgISgXWOJzO3gWpFbSvFI/M
        u+6k8aOxrVFR4d4hO7ehKUom/aMCKdG+x2bb1MUb++WBFrsgRaMP3BV1507EWO4P0LnKXAwyuX8
        KDGCM4OtuEj7y/4uphIVyQ3qoDnbif7SSi7yXQYNNe4pJ4MkzyKKuaQ==
X-Received: by 2002:ac8:5a10:0:b0:417:b269:4689 with SMTP id n16-20020ac85a10000000b00417b2694689mr16769909qta.53.1696318511708;
        Tue, 03 Oct 2023 00:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECydVO6IXDIfn2oX2lhW4fKbeswzVXSFt7PoPPot50XJyzkTu2tv2vXbEDYVXHWTsdZBKJZZQAwniqa+LzXBc=
X-Received: by 2002:ac8:5a10:0:b0:417:b269:4689 with SMTP id
 n16-20020ac85a10000000b00417b2694689mr16769899qta.53.1696318511438; Tue, 03
 Oct 2023 00:35:11 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Oct 2023 00:35:10 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231003042215.142678-4-shravan.chippa@microchip.com>
References: <20231003042215.142678-1-shravan.chippa@microchip.com> <20231003042215.142678-4-shravan.chippa@microchip.com>
Mime-Version: 1.0
Date:   Tue, 3 Oct 2023 00:35:10 -0700
Message-ID: <CAJM55Z8+UtVwFRxOKPcNKmitzkZQ9tyecG46dhTZqiYZgw903Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dmaengine: sf-pdma: add mpfs-pdma compatible name
To:     shravan chippa <shravan.chippa@microchip.com>,
        green.wan@sifive.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nagasuresh.relli@microchip.com, praveen.kumar@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

shravan chippa wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
>
> Sifive platform dma does not allow out-of-order transfers,
> Add a PolarFire SoC specific compatible and code to support
> for out-of-order dma transfers
>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 27 ++++++++++++++++++++++++---
>  drivers/dma/sf-pdma/sf-pdma.h |  6 ++++++
>  2 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index 06a0912a12a1..a9ff319d4ca3 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -21,6 +21,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/of.h>
>  #include <linux/of_dma.h>
> +#include <linux/of_device.h>
>  #include <linux/slab.h>
>
>  #include "sf-pdma.h"
> @@ -66,7 +67,7 @@ static struct sf_pdma_desc *sf_pdma_alloc_desc(struct sf_pdma_chan *chan)
>  static void sf_pdma_fill_desc(struct sf_pdma_desc *desc,
>  			      u64 dst, u64 src, u64 size)
>  {
> -	desc->xfer_type = PDMA_FULL_SPEED;
> +	desc->xfer_type =  desc->chan->pdma->transfer_type;

Two spaces.

>  	desc->xfer_size = size;
>  	desc->dst_addr = dst;
>  	desc->src_addr = src;
> @@ -520,6 +521,7 @@ static struct dma_chan *sf_pdma_of_xlate(struct of_phandle_args *dma_spec,
>
>  static int sf_pdma_probe(struct platform_device *pdev)
>  {
> +	const struct sf_pdma_driver_platdata *ddata;
>  	struct sf_pdma *pdma;
>  	int ret, n_chans;
>  	const enum dma_slave_buswidth widths =
> @@ -545,6 +547,14 @@ static int sf_pdma_probe(struct platform_device *pdev)
>
>  	pdma->n_chans = n_chans;
>
> +	pdma->transfer_type = PDMA_FULL_SPEED;
> +
> +	ddata  = of_device_get_match_data(&pdev->dev);
> +	if (ddata) {
> +		if (ddata->quirks & NO_STRICT_ORDERING)
> +			pdma->transfer_type &= ~(NO_STRICT_ORDERING);
> +	}
> +

The commit message says "Sifive platform dma does not allow out-of-order
transfers" so you want strict ordering by default and then allow
out-of-order transfers if the match data allows it, right?

But here bit 3 is set by default and cleared if the quirk is set, so it looks
like bit 3 actually means "strict ordering" and not "no strict ordering" as
you've named it.

The confusion here probably stems using the same define for the quirk and the
xfer_type. Unless I'm mistaken above I'd find something like this a lot easier
to read:

sf_pdma.h:
#define PDMA_FULL_SPEED		0xFF000000
#define PDMA_STRICT_ORDERING	BIT(3)

sf_pdma.c:
#define PDMA_QUIRK_NO_STRICT_ORDERING	BIT(0)

dma->transfer_type = PDMA_FULL_SPEED | PDMA_STRICT_ORDERING;
...
if (ddata->quirks & PDMA_QUIRK_NO_STRICT_ORDERING)
	pdma->transfer_type &= ~PDMA_STRICT_ORDERING;

>  	pdma->membase = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pdma->membase))
>  		return PTR_ERR(pdma->membase);
> @@ -632,11 +642,22 @@ static int sf_pdma_remove(struct platform_device *pdev)
>  	return 0;
>  }
>
> +static const struct sf_pdma_driver_platdata mpfs_pdma = {
> +	.quirks = NO_STRICT_ORDERING,
> +};
> +
>  static const struct of_device_id sf_pdma_dt_ids[] = {
> -	{ .compatible = "sifive,fu540-c000-pdma" },
> -	{ .compatible = "sifive,pdma0" },
> +	{
> +		.compatible = "sifive,fu540-c000-pdma",
> +	}, {
> +		.compatible = "sifive,pdma0",
> +	}, {
> +		.compatible = "microchip,mpfs-pdma",
> +		.data	    = &mpfs_pdma,
> +	},
>  	{},
>  };
> +
>  MODULE_DEVICE_TABLE(of, sf_pdma_dt_ids);
>
>  static struct platform_driver sf_pdma_driver = {
> diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> index 5c398a83b491..3b16db4daa0b 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.h
> +++ b/drivers/dma/sf-pdma/sf-pdma.h
> @@ -49,6 +49,7 @@
>
>  /* Transfer Type */
>  #define PDMA_FULL_SPEED					0xFF000008
> +#define NO_STRICT_ORDERING				BIT(3)
>
>  /* Error Recovery */
>  #define MAX_RETRY					1
> @@ -112,8 +113,13 @@ struct sf_pdma {
>  	struct dma_device       dma_dev;
>  	void __iomem            *membase;
>  	void __iomem            *mappedbase;
> +	u32			transfer_type;
>  	u32			n_chans;
>  	struct sf_pdma_chan	chans[];
>  };
>
> +struct sf_pdma_driver_platdata {
> +	u32 quirks;
> +};
> +
>  #endif /* _SF_PDMA_H */
> --
> 2.34.1
