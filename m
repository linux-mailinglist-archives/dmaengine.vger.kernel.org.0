Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032BE56C80C
	for <lists+dmaengine@lfdr.de>; Sat,  9 Jul 2022 10:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiGIIbd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 9 Jul 2022 04:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGIIbd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 9 Jul 2022 04:31:33 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9C4528A1
        for <dmaengine@vger.kernel.org>; Sat,  9 Jul 2022 01:31:32 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fz10so919677pjb.2
        for <dmaengine@vger.kernel.org>; Sat, 09 Jul 2022 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=R138oFD5OXPog61ZjjUULV7qM4LmxY5ZWnBjLCIhJ3A=;
        b=eo6k0oi0O9tY1GVEX+jXGlhjdRjvJ/p3qJNJfLKICJkl1STJbHQr0n8Nm0MNQAif6D
         Bs7A9C3KNCrgmnzbHmIYtH+cU3XEvJzPJSe9/m/XaUY4eu40DX05ocNjVQ2+zhXRGQ2W
         Z1duOXCCRYUZNG5XPufQWwyIk6rjgsZlesO3LesvMvjgRoRvdh1ak4AhUX3XBRBKcV7s
         I/7n9FylgYxV/yK3LIh8W5EH57gKFC1x9TX2/qHahEexU4MD5jNMaLN6VaeLkzNGzx1h
         AOf7X3fEh3lgC0w7ww3tA73W+lrBKxIsPmIpWQvXg005AdBUSGE//nGm8QISRobaprYa
         jZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R138oFD5OXPog61ZjjUULV7qM4LmxY5ZWnBjLCIhJ3A=;
        b=X55mq0wZglcleWoYmg9SMKv8/Ncs5DoPsiDk9p1S1IT36Qg9ocireCnOYedRaDL7T3
         vxFByHPxb9ETBX/SjbXipnF/NrLrnQVbJIn21kio/I9IIiO0+yS7wLJvHodonGIDMlnd
         hOVkJX2yZAWNrAUSC+9xFQt9DORtJqVHpFudQoAw6rbMly8GZZ9+sKcHs426dE3hDSSx
         y/qzeIlDNyLhhUAEKtwQNhOvNLg4cE/GdGFf55Gp/qP7KZ4TKJMlpY2wjdKAfs8VXblW
         +EQw0mcakcHQdYan4MSGxeycGAUXdPuqOcGvpRXuYtxHHmIjTlrJId2rS29rAuOZuDCa
         hgEA==
X-Gm-Message-State: AJIora/PyI5U/kUYc1BAmiVXhAQ2Tt9hkMw4pkoFs7DjawjgIBTSmI7R
        rxHPQqtNYZr2JJgaZysFSGIP
X-Google-Smtp-Source: AGRyM1u6MLWsD3OzMYBdC5Q0lI5mvhbGGTX65Il1VYUH+N1jXPz5K+gmp9+DRdeO2/6t/RcH3rHN9A==
X-Received: by 2002:a17:90a:408f:b0:1e3:23a:2370 with SMTP id l15-20020a17090a408f00b001e3023a2370mr4700263pjg.84.1657355491510;
        Sat, 09 Jul 2022 01:31:31 -0700 (PDT)
Received: from thinkpad ([117.207.26.140])
        by smtp.gmail.com with ESMTPSA id q6-20020aa78426000000b00525714c3e07sm930353pfn.48.2022.07.09.01.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 01:31:31 -0700 (PDT)
Date:   Sat, 9 Jul 2022 14:01:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 22/24] dmaengine: dw-edma: Bypass dma-ranges mapping
 for the local setup
Message-ID: <20220709083122.GQ5063@thinkpad>
References: <20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru>
 <20220610091459.17612-23-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220610091459.17612-23-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 10, 2022 at 12:14:57PM +0300, Serge Semin wrote:
> DW eDMA doesn't perform any translation of the traffic generated on the
> CPU/Application side. It just generates read/write AXI-bus requests with
> the specified addresses. But in case if the dma-ranges DT-property is
> specified for a platform device node, Linux will use it to map the CPU
> memory regions into the DMAable bus ranges. This isn't what we want for
> the eDMA embedded into the locally accessed DW PCIe Root Port and
> End-point. In order to work that around let's set the chan_dma_dev flag
> for each DW eDMA channel thus forcing the client drivers to getting a
> custom dma-ranges-less parental device for the mappings.
> 
> Note it will only work for the client drivers using the
> dmaengine_get_dma_device() method to get the parental DMA device.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> 
> ---
> 
> Changelog v2:
> - Fix the comment a bit to being clearer. (@Manivannan)
> 
> Changelog v3:
> - Conditionally set dchan->dev->device.dma_coherent field since it can
>   be missing on some platforms. (@Manivannan)
> - Remove Manivannan' rb and tb tags since the patch content has been
>   changed.
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 6a8282eaebaf..4f56149dc8d8 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -716,6 +716,26 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
>  	if (chan->status != EDMA_ST_IDLE)
>  		return -EBUSY;
>  
> +	/* Bypass the dma-ranges based memory regions mapping for the eDMA
> +	 * controlled from the CPU/Application side since in that case
> +	 * the local memory address is left untranslated.
> +	 */
> +	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> +		dchan->dev->chan_dma_dev = true;
> +
> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> +		dchan->dev->device.dma_coherent = chan->dw->chip->dev->dma_coherent;
> +#endif
> +
> +		dma_coerce_mask_and_coherent(&dchan->dev->device,
> +					     dma_get_mask(chan->dw->chip->dev));
> +		dchan->dev->device.dma_parms = chan->dw->chip->dev->dma_parms;
> +	} else {
> +		dchan->dev->chan_dma_dev = false;
> +	}
> +
>  	pm_runtime_get(chan->dw->chip->dev);
>  
>  	return 0;
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
