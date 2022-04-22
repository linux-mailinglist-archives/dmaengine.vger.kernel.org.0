Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057FF50BE8E
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 19:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiDVR2L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 13:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiDVR2J (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 13:28:09 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB3362F1;
        Fri, 22 Apr 2022 10:25:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h27so15174820lfj.13;
        Fri, 22 Apr 2022 10:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P6aPr0iwXAzoAL0i3ENsoWR7pUleE0GFnled61n//tY=;
        b=YTFxrgrnL9iFJ9mHdWSmtczLaxcvz0MeoEgGR/o27Y0oMl9U+vvagk0d2P/tNrB/3d
         JzQ7kE5zUhp0ootaaZznhzu/TdJ8RTQHvWDVliwx8cHk9thzEyeOiiuiAgI7x949N+3W
         NpNT3zM876ISrFtXIUmqfCxfz6d2MEc3xxfuQvP31GuixFnCrX+f/Xg8ok4NGWht2YMi
         TisIu/pd/i0MfyugwaCUMY1MZ4AfVh9t/D0UUGVfJ1iIrv56xJIgaNvc81oyG6qEdqqu
         8olKOAjzCm3JzlaOWLQf0EjCK9rT0IvAuSxFbSoJudwoxzeVegIJvW3h7xMDGTTWopTk
         zzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P6aPr0iwXAzoAL0i3ENsoWR7pUleE0GFnled61n//tY=;
        b=I4mdbL4mpV0K2P2QNQH1qqqKEjLbApO2zXH+0rsjazEWwZqHFKiuY5Uim81TEzuydF
         XPD5qnYTJj5NERAOukTR9Mv+VYI+v7F9YYgbZpkghEaoQd2rIT6zP8DT6oiJ1f3x7pF2
         oolzYy3OiUY33YJf/6456VWDVMnJ2oQk/hHx/7DUMWnPpDQKzryDsKd+Wd5Wgrv54qHf
         gMzFWbDf4nUQQdeifBkXF/GEnflHhKJe+7mq2ofmw//9jDQh9VDZPlQQsP0F9F51cFoV
         c2M54f6VO/x5RBnQsLCQF0cbeMPC7SOgn7TLil7J6l/ZfS7N42BPIdiovgG5AP263TWM
         ZzJg==
X-Gm-Message-State: AOAM530dkwAwCCJFsecu0MZ30XKfkvRAs/5JonhU86WgtwH2q6ftvgCA
        uX80ZR0OvqQxaOSz/x2tf8w=
X-Google-Smtp-Source: ABdhPJzMAzYeoc6kMGd8CleGOvpvT9O7RZoNJ9P/0zEflwLK17I89IppDMVOFVFuOTUZ+U1CMw3P2g==
X-Received: by 2002:a05:6512:3441:b0:46d:f73:777a with SMTP id j1-20020a056512344100b0046d0f73777amr3580348lfr.426.1650648221232;
        Fri, 22 Apr 2022 10:23:41 -0700 (PDT)
Received: from mobilestation ([95.79.183.147])
        by smtp.gmail.com with ESMTPSA id a13-20020a19ca0d000000b0046e16f62ca5sm289188lfg.297.2022.04.22.10.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:23:40 -0700 (PDT)
Date:   Fri, 22 Apr 2022 20:23:38 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v9 2/9] dmaengine: dw-edma: Detach the private data and
 chip info structures
Message-ID: <20220422172338.wkznq7vgml7fa4uc@mobilestation>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
 <20220422143643.727871-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422143643.727871-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 22, 2022 at 09:36:36AM -0500, Frank Li wrote:
> "struct dw_edma_chip" contains an internal structure "struct dw_edma" that
> is used by the eDMA core internally. This structure should not be touched
> by the eDMA controller drivers themselves. But currently, the eDMA
> controller drivers like "dw-edma-pci" allocates and populates this
> internal structure then passes it on to eDMA core. The eDMA core further
> populates the structure and uses it. This is wrong!
> 
> Hence, move all the "struct dw_edma" specifics from controller drivers
> to the eDMA core.

Great! Thanks.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v8 to v9
>  - remove chip->ops check at dw_edma_irq_request()
> Change from v7 to v8
>  - Check chip->ops at probe()
>  - use struct edma_dw at dw_edma_v0_debugfs_on/off()
> 
> Change from v6 to v7
>  - Move nr_irqs and chip->ops check into dw_edma_irq_request()
>  - Move dw->irq devm_kcalloc() into dw_edma_irq_request()
>  - Change dw->nr_irqs after request success
>  - Fix wrong use chip->nr_irqs when remove
> 
> Change from v5 to v6
>  - Don't touch chip->nr_irqs
>  - Don't set chip->dw utill everything is okay
>  - dw_edma_channel_setup() and dw_edma_v0_core_debugfs_on/off() methods take
>    dw_edma structure pointer as a parameter
> 
> Change from v4 to v5
>  - Move chip->nr_irqs before allocate dw_edma
> Change from v3 to v4
>  - Accept most suggestions of Serge Semin
> Change from v2 to v3
>  - none
> Change from v1 to v2
>  - rework commit message
>  - remove duplicate field in struct dw_edma
> 
> 
>  drivers/dma/dw-edma/dw-edma-core.c       | 90 +++++++++++++-----------
>  drivers/dma/dw-edma/dw-edma-core.h       | 31 +-------
>  drivers/dma/dw-edma/dw-edma-pcie.c       | 82 +++++++++------------
>  drivers/dma/dw-edma/dw-edma-v0-core.c    | 32 ++++-----
>  drivers/dma/dw-edma/dw-edma-v0-core.h    |  4 +-
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 18 ++---
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  8 +--
>  include/linux/dma/edma.h                 | 44 ++++++++++++
>  8 files changed, 161 insertions(+), 148 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 53289927dd0d6..58e91fe384282 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -64,8 +64,8 @@ static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
>  
>  static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
>  {
> +	struct dw_edma_chip *chip = desc->chan->dw->chip;
>  	struct dw_edma_chan *chan = desc->chan;
> -	struct dw_edma *dw = chan->chip->dw;
>  	struct dw_edma_chunk *chunk;
>  
>  	chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
> @@ -82,11 +82,11 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
>  	 */
>  	chunk->cb = !(desc->chunks_alloc % 2);
>  	if (chan->dir == EDMA_DIR_WRITE) {
> -		chunk->ll_region.paddr = dw->ll_region_wr[chan->id].paddr;
> -		chunk->ll_region.vaddr = dw->ll_region_wr[chan->id].vaddr;
> +		chunk->ll_region.paddr = chip->ll_region_wr[chan->id].paddr;
> +		chunk->ll_region.vaddr = chip->ll_region_wr[chan->id].vaddr;
>  	} else {
> -		chunk->ll_region.paddr = dw->ll_region_rd[chan->id].paddr;
> -		chunk->ll_region.vaddr = dw->ll_region_rd[chan->id].vaddr;
> +		chunk->ll_region.paddr = chip->ll_region_rd[chan->id].paddr;
> +		chunk->ll_region.vaddr = chip->ll_region_rd[chan->id].vaddr;
>  	}
>  
>  	if (desc->chunk) {
> @@ -664,7 +664,7 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
>  	if (chan->status != EDMA_ST_IDLE)
>  		return -EBUSY;
>  
> -	pm_runtime_get(chan->chip->dev);
> +	pm_runtime_get(chan->dw->chip->dev);
>  
>  	return 0;
>  }
> @@ -686,15 +686,15 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
>  		cpu_relax();
>  	}
>  
> -	pm_runtime_put(chan->chip->dev);
> +	pm_runtime_put(chan->dw->chip->dev);
>  }
>  
> -static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
> +static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
>  				 u32 wr_alloc, u32 rd_alloc)
>  {
> +	struct dw_edma_chip *chip = dw->chip;
>  	struct dw_edma_region *dt_region;
>  	struct device *dev = chip->dev;
> -	struct dw_edma *dw = chip->dw;
>  	struct dw_edma_chan *chan;
>  	struct dw_edma_irq *irq;
>  	struct dma_device *dma;
> @@ -727,7 +727,7 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
>  
>  		chan->vc.chan.private = dt_region;
>  
> -		chan->chip = chip;
> +		chan->dw = dw;
>  		chan->id = j;
>  		chan->dir = write ? EDMA_DIR_WRITE : EDMA_DIR_READ;
>  		chan->configured = false;
> @@ -735,9 +735,9 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
>  		chan->status = EDMA_ST_IDLE;
>  
>  		if (write)
> -			chan->ll_max = (dw->ll_region_wr[j].sz / EDMA_LL_SZ);
> +			chan->ll_max = (chip->ll_region_wr[j].sz / EDMA_LL_SZ);
>  		else
> -			chan->ll_max = (dw->ll_region_rd[j].sz / EDMA_LL_SZ);
> +			chan->ll_max = (chip->ll_region_rd[j].sz / EDMA_LL_SZ);
>  		chan->ll_max -= 1;
>  
>  		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
> @@ -767,13 +767,13 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
>  		vchan_init(&chan->vc, dma);
>  
>  		if (write) {
> -			dt_region->paddr = dw->dt_region_wr[j].paddr;
> -			dt_region->vaddr = dw->dt_region_wr[j].vaddr;
> -			dt_region->sz = dw->dt_region_wr[j].sz;
> +			dt_region->paddr = chip->dt_region_wr[j].paddr;
> +			dt_region->vaddr = chip->dt_region_wr[j].vaddr;
> +			dt_region->sz = chip->dt_region_wr[j].sz;
>  		} else {
> -			dt_region->paddr = dw->dt_region_rd[j].paddr;
> -			dt_region->vaddr = dw->dt_region_rd[j].vaddr;
> -			dt_region->sz = dw->dt_region_rd[j].sz;
> +			dt_region->paddr = chip->dt_region_rd[j].paddr;
> +			dt_region->vaddr = chip->dt_region_rd[j].vaddr;
> +			dt_region->sz = chip->dt_region_rd[j].sz;
>  		}
>  
>  		dw_edma_v0_core_device_config(chan);
> @@ -827,11 +827,11 @@ static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
>  		(*mask)++;
>  }
>  
> -static int dw_edma_irq_request(struct dw_edma_chip *chip,
> +static int dw_edma_irq_request(struct dw_edma *dw,
>  			       u32 *wr_alloc, u32 *rd_alloc)
>  {
> -	struct device *dev = chip->dev;
> -	struct dw_edma *dw = chip->dw;
> +	struct dw_edma_chip *chip = dw->chip;
> +	struct device *dev = dw->chip->dev;
>  	u32 wr_mask = 1;
>  	u32 rd_mask = 1;
>  	int i, err = 0;
> @@ -840,12 +840,16 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
>  
>  	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
>  
> -	if (dw->nr_irqs < 1)
> +	if (chip->nr_irqs < 1 || !chip->ops->irq_vector)
>  		return -EINVAL;
>  
> -	if (dw->nr_irqs == 1) {
> +	dw->irq = devm_kcalloc(dev, chip->nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
> +	if (!dw->irq)
> +		return -ENOMEM;
> +
> +	if (chip->nr_irqs == 1) {
>  		/* Common IRQ shared among all channels */
> -		irq = dw->ops->irq_vector(dev, 0);
> +		irq = chip->ops->irq_vector(dev, 0);
>  		err = request_irq(irq, dw_edma_interrupt_common,
>  				  IRQF_SHARED, dw->name, &dw->irq[0]);
>  		if (err) {
> @@ -855,9 +859,11 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
>  
>  		if (irq_get_msi_desc(irq))
>  			get_cached_msi_msg(irq, &dw->irq[0].msi);
> +
> +		dw->nr_irqs = 1;
>  	} else {
>  		/* Distribute IRQs equally among all channels */
> -		int tmp = dw->nr_irqs;
> +		int tmp = chip->nr_irqs;
>  
>  		while (tmp && (*wr_alloc + *rd_alloc) < ch_cnt) {
>  			dw_edma_dec_irq_alloc(&tmp, wr_alloc, dw->wr_ch_cnt);
> @@ -868,7 +874,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
>  		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
>  
>  		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
> -			irq = dw->ops->irq_vector(dev, i);
> +			irq = chip->ops->irq_vector(dev, i);
>  			err = request_irq(irq,
>  					  i < *wr_alloc ?
>  						dw_edma_interrupt_write :
> @@ -902,20 +908,22 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  		return -EINVAL;
>  
>  	dev = chip->dev;
> -	if (!dev)
> +	if (!dev || !chip->ops)
>  		return -EINVAL;
>  
> -	dw = chip->dw;
> -	if (!dw || !dw->irq || !dw->ops || !dw->ops->irq_vector)
> -		return -EINVAL;
> +	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
> +	if (!dw)
> +		return -ENOMEM;
> +
> +	dw->chip = chip;
>  
>  	raw_spin_lock_init(&dw->lock);
>  
> -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt,
> +	dw->wr_ch_cnt = min_t(u16, chip->wr_ch_cnt,
>  			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
>  	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
>  
> -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt,
> +	dw->rd_ch_cnt = min_t(u16, chip->rd_ch_cnt,
>  			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
>  	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
>  
> @@ -937,17 +945,17 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	dw_edma_v0_core_off(dw);
>  
>  	/* Request IRQs */
> -	err = dw_edma_irq_request(chip, &wr_alloc, &rd_alloc);
> +	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
>  	if (err)
>  		return err;
>  
>  	/* Setup write channels */
> -	err = dw_edma_channel_setup(chip, true, wr_alloc, rd_alloc);
> +	err = dw_edma_channel_setup(dw, true, wr_alloc, rd_alloc);
>  	if (err)
>  		goto err_irq_free;
>  
>  	/* Setup read channels */
> -	err = dw_edma_channel_setup(chip, false, wr_alloc, rd_alloc);
> +	err = dw_edma_channel_setup(dw, false, wr_alloc, rd_alloc);
>  	if (err)
>  		goto err_irq_free;
>  
> @@ -955,15 +963,15 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	pm_runtime_enable(dev);
>  
>  	/* Turn debugfs on */
> -	dw_edma_v0_core_debugfs_on(chip);
> +	dw_edma_v0_core_debugfs_on(dw);
> +
> +	chip->dw = dw;
>  
>  	return 0;
>  
>  err_irq_free:
>  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
> -		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
> -
> -	dw->nr_irqs = 0;
> +		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
>  
>  	return err;
>  }
> @@ -981,7 +989,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  
>  	/* Free irqs */
>  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
> -		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
> +		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
>  
>  	/* Power management */
>  	pm_runtime_disable(dev);
> @@ -1002,7 +1010,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  	}
>  
>  	/* Turn debugfs off */
> -	dw_edma_v0_core_debugfs_off(chip);
> +	dw_edma_v0_core_debugfs_off(dw);
>  
>  	return 0;
>  }
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 60316d408c3e0..85df2d511907b 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -15,20 +15,12 @@
>  #include "../virt-dma.h"
>  
>  #define EDMA_LL_SZ					24
> -#define EDMA_MAX_WR_CH					8
> -#define EDMA_MAX_RD_CH					8
>  
>  enum dw_edma_dir {
>  	EDMA_DIR_WRITE = 0,
>  	EDMA_DIR_READ
>  };
>  
> -enum dw_edma_map_format {
> -	EDMA_MF_EDMA_LEGACY = 0x0,
> -	EDMA_MF_EDMA_UNROLL = 0x1,
> -	EDMA_MF_HDMA_COMPAT = 0x5
> -};
> -
>  enum dw_edma_request {
>  	EDMA_REQ_NONE = 0,
>  	EDMA_REQ_STOP,
> @@ -57,12 +49,6 @@ struct dw_edma_burst {
>  	u32				sz;
>  };
>  
> -struct dw_edma_region {
> -	phys_addr_t			paddr;
> -	void				__iomem *vaddr;
> -	size_t				sz;
> -};
> -
>  struct dw_edma_chunk {
>  	struct list_head		list;
>  	struct dw_edma_chan		*chan;
> @@ -87,7 +73,7 @@ struct dw_edma_desc {
>  
>  struct dw_edma_chan {
>  	struct virt_dma_chan		vc;
> -	struct dw_edma_chip		*chip;
> +	struct dw_edma			*dw;
>  	int				id;
>  	enum dw_edma_dir		dir;
>  
> @@ -109,10 +95,6 @@ struct dw_edma_irq {
>  	struct dw_edma			*dw;
>  };
>  
> -struct dw_edma_core_ops {
> -	int	(*irq_vector)(struct device *dev, unsigned int nr);
> -};
> -
>  struct dw_edma {
>  	char				name[20];
>  
> @@ -122,21 +104,14 @@ struct dw_edma {
>  	struct dma_device		rd_edma;
>  	u16				rd_ch_cnt;
>  
> -	struct dw_edma_region		rg_region;	/* Registers */
> -	struct dw_edma_region		ll_region_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_region		ll_region_rd[EDMA_MAX_RD_CH];
> -	struct dw_edma_region		dt_region_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_region		dt_region_rd[EDMA_MAX_RD_CH];
> -
>  	struct dw_edma_irq		*irq;
>  	int				nr_irqs;
>  
> -	enum dw_edma_map_format		mf;
> -
>  	struct dw_edma_chan		*chan;
> -	const struct dw_edma_core_ops	*ops;
>  
>  	raw_spinlock_t			lock;		/* Only for legacy */
> +
> +	struct dw_edma_chip             *chip;
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry			*debugfs;
>  #endif /* CONFIG_DEBUG_FS */
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index b8f52ca10fa91..2c1c5fa4e9f28 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -148,7 +148,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	struct dw_edma_pcie_data vsec_data;
>  	struct device *dev = &pdev->dev;
>  	struct dw_edma_chip *chip;
> -	struct dw_edma *dw;
>  	int err, nr_irqs;
>  	int i, mask;
>  
> @@ -214,10 +213,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	if (!chip)
>  		return -ENOMEM;
>  
> -	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
> -	if (!dw)
> -		return -ENOMEM;
> -
>  	/* IRQs allocation */
>  	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data.irqs,
>  					PCI_IRQ_MSI | PCI_IRQ_MSIX);
> @@ -228,28 +223,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	}
>  
>  	/* Data structure initialization */
> -	chip->dw = dw;
>  	chip->dev = dev;
>  	chip->id = pdev->devfn;
>  
> -	dw->mf = vsec_data.mf;
> -	dw->nr_irqs = nr_irqs;
> -	dw->ops = &dw_edma_pcie_core_ops;
> -	dw->wr_ch_cnt = vsec_data.wr_ch_cnt;
> -	dw->rd_ch_cnt = vsec_data.rd_ch_cnt;
> +	chip->mf = vsec_data.mf;
> +	chip->nr_irqs = nr_irqs;
> +	chip->ops = &dw_edma_pcie_core_ops;
>  
> -	dw->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
> -	if (!dw->rg_region.vaddr)
> -		return -ENOMEM;
> +	chip->wr_ch_cnt = vsec_data.wr_ch_cnt;
> +	chip->rd_ch_cnt = vsec_data.rd_ch_cnt;
>  
> -	dw->rg_region.vaddr += vsec_data.rg.off;
> -	dw->rg_region.paddr = pdev->resource[vsec_data.rg.bar].start;
> -	dw->rg_region.paddr += vsec_data.rg.off;
> -	dw->rg_region.sz = vsec_data.rg.sz;
> +	chip->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
> +	if (!chip->rg_region.vaddr)
> +		return -ENOMEM;
>  
> -	for (i = 0; i < dw->wr_ch_cnt; i++) {
> -		struct dw_edma_region *ll_region = &dw->ll_region_wr[i];
> -		struct dw_edma_region *dt_region = &dw->dt_region_wr[i];
> +	for (i = 0; i < chip->wr_ch_cnt; i++) {
> +		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
> +		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
>  		struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
>  		struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
>  
> @@ -272,9 +262,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		dt_region->sz = dt_block->sz;
>  	}
>  
> -	for (i = 0; i < dw->rd_ch_cnt; i++) {
> -		struct dw_edma_region *ll_region = &dw->ll_region_rd[i];
> -		struct dw_edma_region *dt_region = &dw->dt_region_rd[i];
> +	for (i = 0; i < chip->rd_ch_cnt; i++) {
> +		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
> +		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
>  		struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
>  		struct dw_edma_block *dt_block = &vsec_data.dt_rd[i];
>  
> @@ -298,45 +288,45 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	}
>  
>  	/* Debug info */
> -	if (dw->mf == EDMA_MF_EDMA_LEGACY)
> -		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", dw->mf);
> -	else if (dw->mf == EDMA_MF_EDMA_UNROLL)
> -		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", dw->mf);
> -	else if (dw->mf == EDMA_MF_HDMA_COMPAT)
> -		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", dw->mf);
> +	if (chip->mf == EDMA_MF_EDMA_LEGACY)
> +		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", chip->mf);
> +	else if (chip->mf == EDMA_MF_EDMA_UNROLL)
> +		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", chip->mf);
> +	else if (chip->mf == EDMA_MF_HDMA_COMPAT)
> +		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", chip->mf);
>  	else
> -		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", dw->mf);
> +		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
>  
> -	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> +	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
>  		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
> -		dw->rg_region.vaddr, &dw->rg_region.paddr);
> +		chip->rg_region.vaddr);
>  
>  
> -	for (i = 0; i < dw->wr_ch_cnt; i++) {
> +	for (i = 0; i < chip->wr_ch_cnt; i++) {
>  		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, vsec_data.ll_wr[i].bar,
> -			vsec_data.ll_wr[i].off, dw->ll_region_wr[i].sz,
> -			dw->ll_region_wr[i].vaddr, &dw->ll_region_wr[i].paddr);
> +			vsec_data.ll_wr[i].off, chip->ll_region_wr[i].sz,
> +			chip->ll_region_wr[i].vaddr, &chip->ll_region_wr[i].paddr);
>  
>  		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, vsec_data.dt_wr[i].bar,
> -			vsec_data.dt_wr[i].off, dw->dt_region_wr[i].sz,
> -			dw->dt_region_wr[i].vaddr, &dw->dt_region_wr[i].paddr);
> +			vsec_data.dt_wr[i].off, chip->dt_region_wr[i].sz,
> +			chip->dt_region_wr[i].vaddr, &chip->dt_region_wr[i].paddr);
>  	}
>  
> -	for (i = 0; i < dw->rd_ch_cnt; i++) {
> +	for (i = 0; i < chip->rd_ch_cnt; i++) {
>  		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, vsec_data.ll_rd[i].bar,
> -			vsec_data.ll_rd[i].off, dw->ll_region_rd[i].sz,
> -			dw->ll_region_rd[i].vaddr, &dw->ll_region_rd[i].paddr);
> +			vsec_data.ll_rd[i].off, chip->ll_region_rd[i].sz,
> +			chip->ll_region_rd[i].vaddr, &chip->ll_region_rd[i].paddr);
>  
>  		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, vsec_data.dt_rd[i].bar,
> -			vsec_data.dt_rd[i].off, dw->dt_region_rd[i].sz,
> -			dw->dt_region_rd[i].vaddr, &dw->dt_region_rd[i].paddr);
> +			vsec_data.dt_rd[i].off, chip->dt_region_rd[i].sz,
> +			chip->dt_region_rd[i].vaddr, &chip->dt_region_rd[i].paddr);
>  	}
>  
> -	pci_dbg(pdev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
> +	pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
>  
>  	/* Validating if PCI interrupts were enabled */
>  	if (!pci_dev_msi_enabled(pdev)) {
> @@ -344,10 +334,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		return -EPERM;
>  	}
>  
> -	dw->irq = devm_kcalloc(dev, nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
> -	if (!dw->irq)
> -		return -ENOMEM;
> -
>  	/* Starting eDMA driver */
>  	err = dw_edma_probe(chip);
>  	if (err) {
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 329fc2e57b703..6cf6c28ce0cc9 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -25,7 +25,7 @@ enum dw_edma_control {
>  
>  static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
>  {
> -	return dw->rg_region.vaddr;
> +	return dw->chip->rg_region.vaddr;
>  }
>  
>  #define SET_32(dw, name, value)				\
> @@ -96,7 +96,7 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
>  static inline struct dw_edma_v0_ch_regs __iomem *
>  __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
>  {
> -	if (dw->mf == EDMA_MF_EDMA_LEGACY)
> +	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY)
>  		return &(__dw_regs(dw)->type.legacy.ch);
>  
>  	if (dir == EDMA_DIR_WRITE)
> @@ -108,7 +108,7 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
>  static inline void writel_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  			     u32 value, void __iomem *addr)
>  {
> -	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
> +	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
>  		u32 viewport_sel;
>  		unsigned long flags;
>  
> @@ -133,7 +133,7 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  {
>  	u32 value;
>  
> -	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
> +	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
>  		u32 viewport_sel;
>  		unsigned long flags;
>  
> @@ -169,7 +169,7 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  			     u64 value, void __iomem *addr)
>  {
> -	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
> +	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
>  		u32 viewport_sel;
>  		unsigned long flags;
>  
> @@ -194,7 +194,7 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  {
>  	u32 value;
>  
> -	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
> +	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
>  		u32 viewport_sel;
>  		unsigned long flags;
>  
> @@ -256,7 +256,7 @@ u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  
>  enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
>  {
> -	struct dw_edma *dw = chan->chip->dw;
> +	struct dw_edma *dw = chan->dw;
>  	u32 tmp;
>  
>  	tmp = FIELD_GET(EDMA_V0_CH_STATUS_MASK,
> @@ -272,7 +272,7 @@ enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
>  
>  void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
>  {
> -	struct dw_edma *dw = chan->chip->dw;
> +	struct dw_edma *dw = chan->dw;
>  
>  	SET_RW_32(dw, chan->dir, int_clear,
>  		  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
> @@ -280,7 +280,7 @@ void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
>  
>  void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
>  {
> -	struct dw_edma *dw = chan->chip->dw;
> +	struct dw_edma *dw = chan->dw;
>  
>  	SET_RW_32(dw, chan->dir, int_clear,
>  		  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
> @@ -357,7 +357,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
> -	struct dw_edma *dw = chan->chip->dw;
> +	struct dw_edma *dw = chan->dw;
>  	u32 tmp;
>  
>  	dw_edma_v0_core_write_chunk(chunk);
> @@ -365,7 +365,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  	if (first) {
>  		/* Enable engine */
>  		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
> -		if (dw->mf == EDMA_MF_HDMA_COMPAT) {
> +		if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
>  			switch (chan->id) {
>  			case 0:
>  				SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en,
> @@ -431,7 +431,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  
>  int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
>  {
> -	struct dw_edma *dw = chan->chip->dw;
> +	struct dw_edma *dw = chan->dw;
>  	u32 tmp = 0;
>  
>  	/* MSI done addr - low, high */
> @@ -501,12 +501,12 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
>  }
>  
>  /* eDMA debugfs callbacks */
> -void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip)
> +void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
>  {
> -	dw_edma_v0_debugfs_on(chip);
> +	dw_edma_v0_debugfs_on(dw);
>  }
>  
> -void dw_edma_v0_core_debugfs_off(struct dw_edma_chip *chip)
> +void dw_edma_v0_core_debugfs_off(struct dw_edma *dw)
>  {
> -	dw_edma_v0_debugfs_off(chip);
> +	dw_edma_v0_debugfs_off(dw);
>  }
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
> index 2afa626b8300c..75aec6d31b210 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
> @@ -22,7 +22,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma *chan, enum dw_edma_dir dir)
>  void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
>  int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
>  /* eDMA debug fs callbacks */
> -void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip);
> -void dw_edma_v0_core_debugfs_off(struct dw_edma_chip *chip);
> +void dw_edma_v0_core_debugfs_on(struct dw_edma *dw);
> +void dw_edma_v0_core_debugfs_off(struct dw_edma *dw);
>  
>  #endif /* _DW_EDMA_V0_CORE_H */
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> index 4b3bcffd15ef1..b765adb969998 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -54,7 +54,7 @@ struct debugfs_entries {
>  static int dw_edma_debugfs_u32_get(void *data, u64 *val)
>  {
>  	void __iomem *reg = (void __force __iomem *)data;
> -	if (dw->mf == EDMA_MF_EDMA_LEGACY &&
> +	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY &&
>  	    reg >= (void __iomem *)&regs->type.legacy.ch) {
>  		void __iomem *ptr = &regs->type.legacy.ch;
>  		u32 viewport_sel = 0;
> @@ -173,7 +173,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
>  	nr_entries = ARRAY_SIZE(debugfs_regs);
>  	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
>  
> -	if (dw->mf == EDMA_MF_HDMA_COMPAT) {
> +	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
>  		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
>  		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
>  					   regs_dir);
> @@ -242,7 +242,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
>  	nr_entries = ARRAY_SIZE(debugfs_regs);
>  	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
>  
> -	if (dw->mf == EDMA_MF_HDMA_COMPAT) {
> +	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
>  		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
>  		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
>  					   regs_dir);
> @@ -282,13 +282,13 @@ static void dw_edma_debugfs_regs(void)
>  	dw_edma_debugfs_regs_rd(regs_dir);
>  }
>  
> -void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
> +void dw_edma_v0_debugfs_on(struct dw_edma *_dw)
>  {
> -	dw = chip->dw;
> +	dw = _dw;
>  	if (!dw)
>  		return;
>  
> -	regs = dw->rg_region.vaddr;
> +	regs = dw->chip->rg_region.vaddr;
>  	if (!regs)
>  		return;
>  
> @@ -296,16 +296,16 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
>  	if (!dw->debugfs)
>  		return;
>  
> -	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->mf);
> +	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->chip->mf);
>  	debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
>  	debugfs_create_u16("rd_ch_cnt", 0444, dw->debugfs, &dw->rd_ch_cnt);
>  
>  	dw_edma_debugfs_regs();
>  }
>  
> -void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip)
> +void dw_edma_v0_debugfs_off(struct dw_edma *_dw)
>  {
> -	dw = chip->dw;
> +	dw = _dw;
>  	if (!dw)
>  		return;
>  
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
> index d0ff25a9ea5c9..3391b86edf5ab 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
> @@ -12,14 +12,14 @@
>  #include <linux/dma/edma.h>
>  
>  #ifdef CONFIG_DEBUG_FS
> -void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip);
> -void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip);
> +void dw_edma_v0_debugfs_on(struct dw_edma *dw);
> +void dw_edma_v0_debugfs_off(struct dw_edma *dw);
>  #else
> -static inline void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
> +static inline void dw_edma_v0_debugfs_on(struct dw_edma *dw)
>  {
>  }
>  
> -static inline void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip)
> +static inline void dw_edma_v0_debugfs_off(struct dw_edma *dw)
>  {
>  }
>  #endif /* CONFIG_DEBUG_FS */
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index d4333e721588d..6fd374cc72c8e 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -12,17 +12,61 @@
>  #include <linux/device.h>
>  #include <linux/dmaengine.h>
>  
> +#define EDMA_MAX_WR_CH                                  8
> +#define EDMA_MAX_RD_CH                                  8
> +
>  struct dw_edma;
>  
> +struct dw_edma_region {
> +	phys_addr_t	paddr;
> +	void __iomem	*vaddr;
> +	size_t		sz;
> +};
> +
> +struct dw_edma_core_ops {
> +	int (*irq_vector)(struct device *dev, unsigned int nr);
> +};
> +
> +enum dw_edma_map_format {
> +	EDMA_MF_EDMA_LEGACY = 0x0,
> +	EDMA_MF_EDMA_UNROLL = 0x1,
> +	EDMA_MF_HDMA_COMPAT = 0x5
> +};
> +
>  /**
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
>   * @id:			 instance ID
> + * @nr_irqs:		 total dma irq number
> + * @ops			 DMA channel to IRQ number mapping
> + * @wr_ch_cnt		 DMA write channel number
> + * @rd_ch_cnt		 DMA read channel number
> + * @rg_region		 DMA register region
> + * @ll_region_wr	 DMA descriptor link list memory for write channel
> + * @ll_region_rd	 DMA descriptor link list memory for read channel
> + * @mf			 DMA register map format
>   * @dw:			 struct dw_edma that is filed by dw_edma_probe()
>   */
>  struct dw_edma_chip {
>  	struct device		*dev;
>  	int			id;
> +	int			nr_irqs;
> +	const struct dw_edma_core_ops   *ops;
> +
> +	struct dw_edma_region	rg_region;
> +
> +	u16			wr_ch_cnt;
> +	u16			rd_ch_cnt;
> +	/* link list address */
> +	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
> +	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
> +
> +	/* data region */
> +	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
> +	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
> +
> +	enum dw_edma_map_format	mf;
> +
>  	struct dw_edma		*dw;
>  };
>  
> -- 
> 2.35.1
> 
