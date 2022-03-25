Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4144E6F7D
	for <lists+dmaengine@lfdr.de>; Fri, 25 Mar 2022 09:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354543AbiCYIeq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Mar 2022 04:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242070AbiCYIep (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Mar 2022 04:34:45 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9D914029
        for <dmaengine@vger.kernel.org>; Fri, 25 Mar 2022 01:33:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so7676611pjm.0
        for <dmaengine@vger.kernel.org>; Fri, 25 Mar 2022 01:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2vwrQNfNFnmUwYH0dlT3PEmHOLC7uVtwRjd3bwzS04k=;
        b=V8rwhr26dlZa9x4wMUV5jggdmXlskZVpyJshD464GTPpfdwQ/rz6qLWvk5OLpHdQpw
         il7WcwQT+51VCqU/GPvXrd2QP5yIkznMp+MwFKlKpkGxlfRWZA5jHHeGXf7+hVKwH26u
         KxjltpxtpOg9ZsHmoKZq3PxRPH30nQfPWiQcx3P1RadSzuFcTF3ZcKFsSKW9sDRA0VuH
         LXSqAJvSawPP9PmH6Uj1f2tl/648yS7WjeNmOZM94i7Txa4KClNMxctXYsI2cSH++8Bo
         m/vJmTWmxU0kSqURHoVi9b4cPygywW/6Y809OATZUIDAvDgmvEMExVEgJMiv/QmkDEks
         Sz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2vwrQNfNFnmUwYH0dlT3PEmHOLC7uVtwRjd3bwzS04k=;
        b=jzhYbRSMSH8q3GsWKd0uZkayil6oTaNfm5AO79hidP7QdeN7f3EybstAtozrqT4+Mm
         KfwwjVP6QxKyksV1Ydj4/JuhM11jinZrTgUGfdZiJR3Q7FU1N8r96yhNJW0BJiqBXbCX
         GdUNQs/zvVHlS0J25qxhEMGIBF3Z/4Rz9W54QqZZggUtboGcdFfT8wfOs+qtDxJD0pnh
         JmLD/IDam4ZXCkfEALnOuuPLWJG6UEMJcRxDgQB+u3PxMGTsdWpXJlcUlbY1MUAYdq4/
         gfEA+5SsRNmuDmuuftljbB+Z9vYUX7XH/Tz+HJ5/FRZG41UNz2Y/M92eqKUHuF1Ril71
         zvvg==
X-Gm-Message-State: AOAM531obsTGg6bMMLx2rTk1oxFdmO99x5RNvyc7t5auHasAZn+w3FYd
        59ucNKLX7lVKHoCEz6Dg45pC
X-Google-Smtp-Source: ABdhPJyqazmKZeq5C8bGQY4LGvQk1xi6h457kGB/Ke4kT3F22nZtMc4jl/KV3981qsN49JKVGnlLfQ==
X-Received: by 2002:a17:902:d2d1:b0:154:45d2:a05d with SMTP id n17-20020a170902d2d100b0015445d2a05dmr10367179plc.74.1648197191383;
        Fri, 25 Mar 2022 01:33:11 -0700 (PDT)
Received: from thinkpad ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id z23-20020a056a001d9700b004fa8f24702csm5060773pfw.85.2022.03.25.01.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 01:33:11 -0700 (PDT)
Date:   Fri, 25 Mar 2022 14:03:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/25] dmaengine: dw-edma: Drop DT-region allocation
Message-ID: <20220325083305.GI4675@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-22-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-22-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:32AM +0300, Serge Semin wrote:
> There is no point in allocating an additional memory for the data target
> regions passed then to the client drivers. Just use the already available
> structures defined in the dw_edma_chip instance.
> 
> Note these regions are unused in normal circumstances since they are
> specific to the case of eDMA being embedded into the DW PCIe End-point and
> having it's CSRs accessible over a End-point' BAR. This case is only known
> to be implemented as a part of the Synopsys PCIe EndPoint IP prototype
> kit.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index bc530f0a2468..dbe1119fd1d2 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -744,7 +744,6 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
>  static int dw_edma_channel_setup(struct dw_edma_chip *chip, u32 wr_alloc,
>  				 u32 rd_alloc)
>  {
> -	struct dw_edma_region *dt_region;
>  	struct device *dev = chip->dev;
>  	struct dw_edma *dw = chip->dw;
>  	struct dw_edma_chan *chan;
> @@ -761,12 +760,6 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, u32 wr_alloc,
>  	for (i = 0; i < ch_cnt; i++) {
>  		chan = &dw->chan[i];
>  
> -		dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
> -		if (!dt_region)
> -			return -ENOMEM;
> -
> -		chan->vc.chan.private = dt_region;
> -
>  		chan->dw = dw;
>  
>  		if (i < dw->wr_ch_cnt) {
> @@ -814,17 +807,11 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, u32 wr_alloc,
>  			 chan->msi.data);
>  
>  		chan->vc.desc_free = vchan_free_desc;
> -		vchan_init(&chan->vc, dma);
> +		chan->vc.chan.private = chan->dir == EDMA_DIR_WRITE ?
> +					&dw->chip->dt_region_wr[chan->id] :
> +					&dw->chip->dt_region_rd[chan->id];
>  
> -		if (chan->dir == EDMA_DIR_WRITE) {
> -			dt_region->paddr = chip->dt_region_wr[chan->id].paddr;
> -			dt_region->vaddr = chip->dt_region_wr[chan->id].vaddr;
> -			dt_region->sz = chip->dt_region_wr[chan->id].sz;
> -		} else {
> -			dt_region->paddr = chip->dt_region_rd[chan->id].paddr;
> -			dt_region->vaddr = chip->dt_region_rd[chan->id].vaddr;
> -			dt_region->sz = chip->dt_region_rd[chan->id].sz;
> -		}
> +		vchan_init(&chan->vc, dma);
>  
>  		dw_edma_v0_core_device_config(chan);
>  	}
> -- 
> 2.35.1
> 
