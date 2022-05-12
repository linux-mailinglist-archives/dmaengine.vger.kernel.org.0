Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D20524B32
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 13:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353050AbiELLPM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 07:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353115AbiELLOX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 07:14:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C4F2375C6;
        Thu, 12 May 2022 04:13:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y32so8409524lfa.6;
        Thu, 12 May 2022 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KCB0ImVpAY7B2JF+x0CS8IN4OXseCO+dC93CiOsDqZE=;
        b=Ao5tBKQv/NTxFJJRHfQ4U2dYpVn9IvZxgC6LSELXpi8DUWLN9gBTdA/DgrcQh5nvu0
         PulKh13h1oX2KFeb4biM1/XAANhAxdvsJBCQaQE4NiDVdF9sJ4PUnbZk+44oTBtCdaKi
         plRdSuPe1chh4pUv6jpqcEQz2mT1w1lK9L6/EXZnNiFOqRnUmeBo7ObHwEGWDWZUp5/E
         iRIUA/6S9S4J/pCVN5Ftv/nkuzmtGbd1THrwZpPNOooEpgQdhz6Jb5yvPhclfeKGbzfy
         Mfs6Fe9Kr94DBh4Ly7wT6AaFHqoP9Bwk8o1dFzsH77VfseTI0wzEMwLJDZGJyIH/EUOQ
         dMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KCB0ImVpAY7B2JF+x0CS8IN4OXseCO+dC93CiOsDqZE=;
        b=F+371TM+igYY2acMsdrvzDZdwaapNj/u8k26AdnC5SeWzmT1tNnKOMrIaDA1hXJv0c
         uiVC8iiTBBpeWX0E1ErD/K0nMqk2ORc8uYvitCe0AeFORRE3qw5c1WGuu0UuHLKkwlvH
         Ow6c9cC1P+bDPy+Egpgo03lkYSmtL/Hnnk1X5Cz1wPcvHL9/7CnfEipYcvTme5HH+yqk
         +1R0VEpYVzplrQTaBKC/dPp6GBVtWxrVxzUWs1K2JkEv4DC1/nbk0pfMRsfXhqEVOmTm
         I6gdT2zoTlVPpSu51EsMbLqyO2Yaq0qaOVzwrolzXA2VSx/BPzIMuBOPvG9LCHxuo6Kw
         0USQ==
X-Gm-Message-State: AOAM532hVqGhW/xccIZMkXhMzbiDKtds9UyOhl8AmHs73oLUoh37hlz9
        vQYxp5seE+qS7MtdbgOJbaU=
X-Google-Smtp-Source: ABdhPJwzB6axamuqFYigSaMUEWNNHcGwfaA6RyUv9ueDx2XJE3a62ISJaxdkKmsQr0AKgKO+dcDjpA==
X-Received: by 2002:a05:6512:b90:b0:473:9e03:c4f3 with SMTP id b16-20020a0565120b9000b004739e03c4f3mr24399865lfv.494.1652354016062;
        Thu, 12 May 2022 04:13:36 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id l5-20020ac25545000000b004742009e038sm738867lfk.126.2022.05.12.04.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 04:13:35 -0700 (PDT)
Date:   Thu, 12 May 2022 14:13:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH] dmaengine: dw-edma: Remove runtime PM support
Message-ID: <20220512111333.4dx44nru6rqdcbqp@mobilestation>
References: <20220512083612.122824-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512083612.122824-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 12, 2022 at 02:06:12PM +0530, Manivannan Sadhasivam wrote:
> Currently, the dw-edma driver enables the runtime_pm for parent device
> (chip->dev) and increments/decrements the refcount during alloc/free
> chan resources callbacks.
> 
> This leads to a problem when the eDMA driver has been probed, but the
> channels were not used. This scenario can happen when the DW PCIe driver
> probes eDMA driver successfully, but the PCI EPF driver decides not to
> use eDMA channels and use iATU instead for PCI transfers.
> 
> In this case, the underlying device would be runtime suspended due to
> pm_runtime_enable() in dw_edma_probe() and the PCI EPF driver would have
> no knowledge of it.
> 
> Ideally, the eDMA driver should not be the one doing the runtime PM of
> the parent device. The responsibility should instead belong to the client
> drivers like PCI EPF.
> 
> So let's remove the runtime PM support from eDMA driver.

Right. Especially seeing the runtime PM has already been configured
for the PCIe peripheral devices in pci_pm_init(). It is relevant for the remote
eDMA setup. Meanwhile the local eDMA-enabled platforms (DW PCIe hosts
and CPU-side of the DW PCIe End-points) need to manually handle
the PM policy in the platform drivers the way it is done for instance in
drivers/pci/controller/dwc/{pci-dra7xx.c, pci-keystone.c, pcie-qcom.c,
pcie-tegra194.c}. So feel free to add:

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

> 
> Cc: Serge Semin <fancer.lancer@gmail.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 

> Note: This patch is made on top of Frank and Serge's edma work, but should
> be applicable independently also.
> 

To be clearer regarding what patchsets Manivannan is talking about:

> [PATCH v10 0/9] Enable designware PCI EP EDMA locally

Link: https://lore.kernel.org/linux-pci/20220503005801.1714345-1-Frank.Li@nxp.com/

> [PATCH v2 00/26] dmaengine: dw-edma: Add RP/EP local DMA controllers support

Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/

Anyway I would suggest to merge this patch on top of or before ahead
the Frank's work since my series enables the eDMA support for the
currently available platforms, which unlikely (the eDMA driver must be
explicitly enabled and the DT-part needs to be fixed) but may get some
runtime-PM conflicts denoted in the patch log.

-Sergey

> 
>  drivers/dma/dw-edma/dw-edma-core.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 561686b51915..b2b5077d380b 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -9,7 +9,6 @@
>  #include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/dmaengine.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
> @@ -731,15 +730,12 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
>  		dchan->dev->chan_dma_dev = false;
>  	}
>  
> -	pm_runtime_get(chan->dw->chip->dev);
> -
>  	return 0;
>  }
>  
>  static void dw_edma_free_chan_resources(struct dma_chan *dchan)
>  {
>  	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
> -	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>  	int ret;
>  
>  	while (time_before(jiffies, timeout)) {
> @@ -752,8 +748,6 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
>  
>  		cpu_relax();
>  	}
> -
> -	pm_runtime_put(chan->dw->chip->dev);
>  }
>  
>  static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> @@ -1010,9 +1004,6 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	if (err)
>  		goto err_irq_free;
>  
> -	/* Power management */
> -	pm_runtime_enable(dev);
> -
>  	/* Turn debugfs on */
>  	dw_edma_v0_core_debugfs_on(dw);
>  
> @@ -1046,9 +1037,6 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
>  		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
>  
> -	/* Power management */
> -	pm_runtime_disable(dev);
> -
>  	/* Deregister eDMA device */
>  	dma_async_device_unregister(&dw->dma);
>  	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
> -- 
> 2.25.1
> 
