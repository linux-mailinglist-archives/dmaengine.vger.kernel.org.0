Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8500C5997E0
	for <lists+dmaengine@lfdr.de>; Fri, 19 Aug 2022 10:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346949AbiHSIkz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Aug 2022 04:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347488AbiHSIk1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 Aug 2022 04:40:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5745E666
        for <dmaengine@vger.kernel.org>; Fri, 19 Aug 2022 01:40:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so4226285pjf.2
        for <dmaengine@vger.kernel.org>; Fri, 19 Aug 2022 01:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=yZ9KEPPp+zyTi17uXLywUGwN8O1r6Yq3WCQgacgN3f8=;
        b=jYLTXXqCvupptFRljjdD9lIX+0ijg34vedLd4a2yQLtjaxIkNuZYa1zT6WhIjsJDF1
         pAQcRljNbdZY1P1ufK1G3i/ctnh/Xn1qx1neAXQXMVkIGHwPjOtnn4gVv5xag3a9gw/h
         iS3HyYYaVqEyWDetM1EtZPSTrfVrx6hqy5MFENIwbGSTBB42yRMWfSaEVM2vQypz9ptz
         QYD/UkZhhawGX8o+quSvMPOq+spr6OQ2mPT9+irn54ANq0HWlI8+WvFX30Bx+Llb+vs8
         tQdwblu05WzuzM+qBTx4u/xINDqSGTPqQUThJsCttlwOzM79CQdguCVOg6ABq5Cwpjzm
         TnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=yZ9KEPPp+zyTi17uXLywUGwN8O1r6Yq3WCQgacgN3f8=;
        b=mXzAmjH9pNq80Neq7WGokhaqWTCflH4hdaIaSI//4dbNW9iZo5gpJ9pzjFkWaJZTP5
         dIcXQaRapaWjFvULBMx2bSF5Xjs4tG6dgLvjOu5hY2Vje726dycuYyP8vNvB23b2rVVu
         kudRpDxAHLgSDBpgSPuW1zFwSjWa15c3ALlY8Jh3q6D8mculokd9ymwE9BXFOWtP69r4
         oRI0zhAVcghgj5h1j5II8kOVO7JhJiyvFIHQ4O8I8YsSwdIPz8KrNoFfuHfpQruGrJTl
         FEreA12xboXLs5a6UGAQBcy69VaSF/kM8abBLLVcKwaniq7x+wIKjTkdp5yOsAXGn7Gu
         fZrw==
X-Gm-Message-State: ACgBeo33uM2rcybgCa+i7T76dNNdqASqPi1vThdI+oBBQrr1vBpHvBre
        f5TT9WAvLsQ6kpwGvwHAHXRR
X-Google-Smtp-Source: AA6agR4Y/iiuIIVJqJPqIKrwLq7nkPyzl3NFCMKqEXV3Tz1SeaAaBxsNZDSaGFlflNxYU6boDbdk1A==
X-Received: by 2002:a17:90a:df02:b0:1fa:ba39:ec49 with SMTP id gp2-20020a17090adf0200b001faba39ec49mr11149307pjb.129.1660898425814;
        Fri, 19 Aug 2022 01:40:25 -0700 (PDT)
Received: from thinkpad ([117.193.212.74])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090a2c4400b001eafa265869sm4781595pjm.56.2022.08.19.01.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:40:25 -0700 (PDT)
Date:   Fri, 19 Aug 2022 14:10:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gustavo.pimentel@synopsys.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH] dmaengine: dw-edma: Remove runtime PM support
Message-ID: <20220819084018.GC215264@thinkpad>
References: <20220512083612.122824-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220512083612.122824-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
> 
> Cc: Serge Semin <fancer.lancer@gmail.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks like this one missed 6.0. Vinod, can you please merge this now?

Thanks,
Mani

> ---
> 
> Note: This patch is made on top of Frank and Serge's edma work, but should
> be applicable independently also.
> 
> [PATCH v10 0/9] Enable designware PCI EP EDMA locally
> [PATCH v2 00/26] dmaengine: dw-edma: Add RP/EP local DMA controllers support
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

-- 
மணிவண்ணன் சதாசிவம்
