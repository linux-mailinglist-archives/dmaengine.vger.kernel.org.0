Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F4B6200CC
	for <lists+dmaengine@lfdr.de>; Mon,  7 Nov 2022 22:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiKGVPn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Nov 2022 16:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiKGVPW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Nov 2022 16:15:22 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A1660D1;
        Mon,  7 Nov 2022 13:11:39 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f37so18471882lfv.8;
        Mon, 07 Nov 2022 13:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zaHch3W2dHBQ7wKVvRQE27rjvYWFoOJ5zCs8+an7Ey0=;
        b=pZIpX1DA0QwBB6bnAU9YT3pfgjJX/moijyhD143qSf9Mc2rMZ4B5DbxEsXHzQ33yWY
         cn/PZPBARO8xmivefTpKTYSLCRp5YbH17NJtiMyk1QNS0hOdm5xHhXK9tJ0DfaLzmXVR
         4DNIx906025NDHf8ZWYQ53Pd1ClUhRk1vGTLwnawyw+8PE0lSmjzDl6S1DYPWTM3zl9J
         zSyK6VQl+5V2TgGnr1d8mk64R3zKIC7E0xGoPgXBrD22nxR8Vac3V1qURzt7g9bZbtoQ
         pel+Cx8odbbpHEWK0YNU+EVy4UyUUMUOdEkzsnC/iZx+tLxwWnDsQywgFcxqa5AmE/3M
         Mdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaHch3W2dHBQ7wKVvRQE27rjvYWFoOJ5zCs8+an7Ey0=;
        b=nHmsnBTdPxSMEVfYpdbjFC1LjaRHNktI0Fa7CHO60gROkQk7fE/mh9u7KiaTxdwwyr
         GrFwrCbIgSzHpb+SWTaYcngM+v8QHGANs8gMJjP7ep2IpLL5nG+Vd6pm++ZLr91a+DN8
         7tGYqWyHB6Ow/1C/89JWb8Qr5NsAmf2F9R/wrUtfhUq9aPAmlwM/ML+JC1StfnYJjspz
         7Lj4rJi8XYOnRp02GGXtBuVukf6gZXGx2estfBY8MtNX8nPkA8tOBTogzq8mmKL2gblT
         KsTjjuBuzSn+63BZIk4Kk2EdAOOTD9T0WNAquUIuoP/s65lxx6rnCpCyYYyOeWKxEWRo
         lEwQ==
X-Gm-Message-State: ACrzQf0EbP4UoL+Eci4Ijr1T1oOBhI0Uo6pu+gQBgL3GhVeq60915y6v
        HkJZv+Uy1wfSJtnOMmXxqu8=
X-Google-Smtp-Source: AMsMyM71NQA5p8P69QH+EfvJRPphtCKPZH2RmMjrMmlPl5adNf/lbxKBkYi94ri6O4VS0g64E0FWfA==
X-Received: by 2002:a05:6512:2203:b0:4ad:5fbb:a58d with SMTP id h3-20020a056512220300b004ad5fbba58dmr17586460lfu.287.1667855497394;
        Mon, 07 Nov 2022 13:11:37 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id v12-20020a2ea60c000000b0026fb5525ee4sm1407813ljp.116.2022.11.07.13.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:11:37 -0800 (PST)
Date:   Tue, 8 Nov 2022 00:11:34 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>, Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 22/24] dmaengine: dw-edma: Bypass dma-ranges mapping
 for the local setup
Message-ID: <20221107211134.wxaqi2sew6aejxne@mobilestation>
References: <20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru>
 <20221107210438.1515-23-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107210438.1515-23-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Nov 08, 2022 at 12:04:36AM +0300, Serge Semin wrote:
> DW eDMA doesn't perform any translation of the traffic generated on the
> CPU/Application side. It just generates read/write AXI-bus requests with
> the specified addresses. But in case if the dma-ranges DT-property is
> specified for a platform device node, Linux will use it to create a
> mapping the PCIe-bus regions into the CPU memory ranges. This isn't what
> we want for the eDMA embedded into the locally accessed DW PCIe Root Port
> and End-point. In order to work that around let's set the chan_dma_dev
> flag for each DW eDMA channel thus forcing the client drivers to getting a
> custom dma-ranges-less parental device for the mappings.
> 
> Note it will only work for the client drivers using the
> dmaengine_get_dma_device() method to get the parental DMA device.

@Robin, we particularly need you opinion on this patch. I did as you
said: call *_dma_configure() method to initialize the child device and
set the DMA-mask here instead of the platform driver.

@Vinoud, @Manivannan I had to drop your tags from this patch since its
content had been significantly changed.

-Sergey

> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
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
> 
> Changelog v6:
> - Directly call *_dma_configure() method on the child device used for
>   the DMA buffers mapping. (@Robin)
> - Explicitly set the DMA-mask of the child device in the channel
>   allocation proecedure. (@Robin)
> - Drop @Manivannan and @Vinod rb- and ab-tags due to significant patch
>   content change.
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 44 ++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index e3671bfbe186..846518509753 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -6,9 +6,11 @@
>   * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> +#include <linux/of_device.h>
>  #include <linux/dmaengine.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
> @@ -711,10 +713,52 @@ static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
>  static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	struct device *dev = chan->dw->chip->dev;
> +	int ret;
>  
>  	if (chan->status != EDMA_ST_IDLE)
>  		return -EBUSY;
>  
> +	/* Bypass the dma-ranges based memory regions mapping for the eDMA
> +	 * controlled from the CPU/Application side since in that case
> +	 * the local memory address is left untranslated.
> +	 */
> +	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> +		ret = dma_coerce_mask_and_coherent(&dchan->dev->device,
> +						   DMA_BIT_MASK(64));
> +		if (ret) {
> +			ret = dma_coerce_mask_and_coherent(&dchan->dev->device,
> +							   DMA_BIT_MASK(32));
> +			if (ret)
> +				return ret;
> +		}
> +
> +		if (dev_of_node(dev)) {
> +			struct device_node *node = dev_of_node(dev);
> +
> +			ret = of_dma_configure(&dchan->dev->device, node, true);
> +		} else if (has_acpi_companion(dev)) {
> +			struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
> +
> +			ret = acpi_dma_configure(&dchan->dev->device,
> +						 acpi_get_dma_attr(adev));
> +		} else {
> +			ret = -EINVAL;
> +		}
> +
> +		if (ret)
> +			return ret;
> +
> +		if (dchan->dev->device.dma_range_map) {
> +			kfree(dchan->dev->device.dma_range_map);
> +			dchan->dev->device.dma_range_map = NULL;
> +		}
> +
> +		dchan->dev->chan_dma_dev = true;
> +	} else {
> +		dchan->dev->chan_dma_dev = false;
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.38.0
> 
> 
