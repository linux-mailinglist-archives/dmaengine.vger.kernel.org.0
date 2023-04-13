Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3116E142E
	for <lists+dmaengine@lfdr.de>; Thu, 13 Apr 2023 20:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDMSey (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Apr 2023 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDMSev (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Apr 2023 14:34:51 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C4376A2
        for <dmaengine@vger.kernel.org>; Thu, 13 Apr 2023 11:34:46 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a686260adcso2644735ad.0
        for <dmaengine@vger.kernel.org>; Thu, 13 Apr 2023 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681410886; x=1684002886;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=toRRnL6FlgLmj4Sec6ebd5mGftrNQ+23d8tZVFbcVDA=;
        b=igkGaM/seYRuinS9hHXucCB+CQCgnIDotdfRDPn0/Kdr2CFo9nVOzvfgTgy+7q3OSb
         IxZV5mvdojlevNtONlctyRc4aAX2gUHkWJStnUt5isFwqoyJRlZlL0jRgVryiyX1O/KV
         HLyDYghHh0GlBDejEzEFvxSH+qYVPzgmVG2BVWzCS6Ly4KLxQzbIiePfniXjKpZYgY0W
         LXLlBO0QtNTrUz9lUqIYmkNnrX6fyVdaDYZHT82uCURC4vk8HivFY4eCovLCoxFaowaI
         1HPMORpIFOyodvRngDAZ/GL1u4VyGlESflmVnWj5K+csoRzhGNRjUPz/vOzKIg9aq006
         Ks4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681410886; x=1684002886;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toRRnL6FlgLmj4Sec6ebd5mGftrNQ+23d8tZVFbcVDA=;
        b=brqsr982wTTlq66YPOTJMMFVIku7JGfOBoUbp+hZW5Onos4tIgPGlJXCsy5wsQ6v68
         0UnlvscC62gupZJitwYw641XIMkqG1Ye3u2OZpCCdKJ0n6m9Fo/Jl1JFLfSIRMZZ9/Ip
         GkkWHdV45dY5AiifqCtngUfjXzP2I18lwCl1kg+SAMZWST/oIql3mjnbVQf8jMtJLnZQ
         lsO8wHK+oZsMB1IqFNYSayZj8GSb20SyYn8cceS1aPT1vIWCE0xgEgD2R4FtafeRttUc
         U1ccUWzQK8xPAxEYzhKVldinL9bsekVwN053LM/OTnBcsWhGlKidmoFqGWUc5GsZcMUT
         39Xg==
X-Gm-Message-State: AAQBX9c1vyZMYaZHbEXKYl7t3+a+VVDFoqDZzO8HkQNVqeAWDSvULKno
        zsUl/RX40GMT5hrGS2IG7/6B
X-Google-Smtp-Source: AKy350bhWcPduAO341whytzxHTTUuFZ+xbrktiYwLpv4YCUXN98kYGuzM82D0dCYc5b3I91P+p7Drw==
X-Received: by 2002:a05:6a00:21cf:b0:63b:1e7f:cf15 with SMTP id t15-20020a056a0021cf00b0063b1e7fcf15mr5081560pfj.3.1681410886143;
        Thu, 13 Apr 2023 11:34:46 -0700 (PDT)
Received: from thinkpad ([59.97.52.67])
        by smtp.gmail.com with ESMTPSA id c15-20020aa781cf000000b005ac419804d3sm1678738pfn.186.2023.04.13.11.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 11:34:45 -0700 (PDT)
Date:   Fri, 14 Apr 2023 00:04:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     fancer.lancer@gmail.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND v9 2/4] dmaengine: dw-edma: Create a new
 dw_edma_core_ops structure to abstract controller operation
Message-ID: <20230413183440.GD13020@thinkpad>
References: <20230413033156.93751-1-cai.huoqing@linux.dev>
 <20230413033156.93751-3-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230413033156.93751-3-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 13, 2023 at 11:31:53AM +0800, Cai Huoqing wrote:
> The structure dw_edma_core_ops has a set of the pointers
> abstracting out the DW eDMA vX and DW HDMA Native controllers.
> And use dw_edma_v0_core_register to set up operation.
> 
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
> v8->v9: No change
> 
> v8 link:
>   https://lore.kernel.org/lkml/20230323034944.78357-3-cai.huoqing@linux.dev/
> 
> 
>  drivers/dma/dw-edma/dw-edma-core.c    | 82 ++++++++------------------
>  drivers/dma/dw-edma/dw-edma-core.h    | 58 ++++++++++++++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 85 +++++++++++++++++++++++----
>  drivers/dma/dw-edma/dw-edma-v0-core.h | 14 +----
>  4 files changed, 157 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 1906a836f0aa..f916f0d84bd6 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -183,6 +183,7 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
>  
>  static int dw_edma_start_transfer(struct dw_edma_chan *chan)
>  {
> +	struct dw_edma *dw = chan->dw;
>  	struct dw_edma_chunk *child;
>  	struct dw_edma_desc *desc;
>  	struct virt_dma_desc *vd;
> @@ -200,7 +201,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
>  	if (!child)
>  		return 0;
>  
> -	dw_edma_v0_core_start(child, !desc->xfer_sz);
> +	dw_edma_core_start(dw, child, !desc->xfer_sz);
>  	desc->xfer_sz += child->ll_region.sz;
>  	dw_edma_free_burst(child);
>  	list_del(&child->list);
> @@ -285,7 +286,7 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
>  		chan->configured = false;
>  	} else if (chan->status == EDMA_ST_IDLE) {
>  		chan->configured = false;
> -	} else if (dw_edma_v0_core_ch_status(chan) == DMA_COMPLETE) {
> +	} else if (dw_edma_core_ch_status(chan) == DMA_COMPLETE) {
>  		/*
>  		 * The channel is in a false BUSY state, probably didn't
>  		 * receive or lost an interrupt
> @@ -594,8 +595,6 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
>  	struct virt_dma_desc *vd;
>  	unsigned long flags;
>  
> -	dw_edma_v0_core_clear_done_int(chan);
> -
>  	spin_lock_irqsave(&chan->vc.lock, flags);
>  	vd = vchan_next_desc(&chan->vc);
>  	if (vd) {
> @@ -636,8 +635,6 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
>  	struct virt_dma_desc *vd;
>  	unsigned long flags;
>  
> -	dw_edma_v0_core_clear_abort_int(chan);
> -
>  	spin_lock_irqsave(&chan->vc.lock, flags);
>  	vd = vchan_next_desc(&chan->vc);
>  	if (vd) {
> @@ -649,63 +646,32 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
>  	chan->status = EDMA_ST_IDLE;
>  }
>  
> -static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
> +static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
>  {
>  	struct dw_edma_irq *dw_irq = data;
> -	struct dw_edma *dw = dw_irq->dw;
> -	unsigned long total, pos, val;
> -	unsigned long off;
> -	u32 mask;
> -
> -	if (write) {
> -		total = dw->wr_ch_cnt;
> -		off = 0;
> -		mask = dw_irq->wr_mask;
> -	} else {
> -		total = dw->rd_ch_cnt;
> -		off = dw->wr_ch_cnt;
> -		mask = dw_irq->rd_mask;
> -	}
> -
> -	val = dw_edma_v0_core_status_done_int(dw, write ?
> -							  EDMA_DIR_WRITE :
> -							  EDMA_DIR_READ);
> -	val &= mask;
> -	for_each_set_bit(pos, &val, total) {
> -		struct dw_edma_chan *chan = &dw->chan[pos + off];
> -
> -		dw_edma_done_interrupt(chan);
> -	}
> -
> -	val = dw_edma_v0_core_status_abort_int(dw, write ?
> -							   EDMA_DIR_WRITE :
> -							   EDMA_DIR_READ);
> -	val &= mask;
> -	for_each_set_bit(pos, &val, total) {
> -		struct dw_edma_chan *chan = &dw->chan[pos + off];
> -
> -		dw_edma_abort_interrupt(chan);
> -	}
> -
> -	return IRQ_HANDLED;
> -}
>  
> -static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
> -{
> -	return dw_edma_interrupt(irq, data, true);
> +	return dw_edma_core_handle_int(dw_irq, EDMA_DIR_WRITE,
> +				       dw_edma_done_interrupt,
> +				       dw_edma_abort_interrupt);
>  }
>  
>  static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
>  {
> -	return dw_edma_interrupt(irq, data, false);
> +	struct dw_edma_irq *dw_irq = data;
> +
> +	return dw_edma_core_handle_int(dw_irq, EDMA_DIR_READ,
> +				       dw_edma_done_interrupt,
> +				       dw_edma_abort_interrupt);
>  }
>  
>  static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
>  {
> -	dw_edma_interrupt(irq, data, true);
> -	dw_edma_interrupt(irq, data, false);
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	ret |= dw_edma_interrupt_write(irq, data);
> +	ret |= dw_edma_interrupt_read(irq, data);
>  
> -	return IRQ_HANDLED;
> +	return ret;
>  }
>  
>  static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
> @@ -806,7 +772,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  
>  		vchan_init(&chan->vc, dma);
>  
> -		dw_edma_v0_core_device_config(chan);
> +		dw_edma_core_ch_config(chan);
>  	}
>  
>  	/* Set DMA channel capabilities */
> @@ -951,14 +917,16 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  
>  	dw->chip = chip;
>  
> +	dw_edma_v0_core_register(dw);
> +
>  	raw_spin_lock_init(&dw->lock);
>  
>  	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> -			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
> +			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
>  	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
>  
>  	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> -			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
> +			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
>  	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
>  
>  	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
> @@ -977,7 +945,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  		 dev_name(chip->dev));
>  
>  	/* Disable eDMA, only to establish the ideal initial conditions */
> -	dw_edma_v0_core_off(dw);
> +	dw_edma_core_off(dw);
>  
>  	/* Request IRQs */
>  	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
> @@ -990,7 +958,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  		goto err_irq_free;
>  
>  	/* Turn debugfs on */
> -	dw_edma_v0_core_debugfs_on(dw);
> +	dw_edma_core_debugfs_on(dw);
>  
>  	chip->dw = dw;
>  
> @@ -1016,7 +984,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  		return -ENODEV;
>  
>  	/* Disable eDMA */
> -	dw_edma_v0_core_off(dw);
> +	dw_edma_core_off(dw);
>  
>  	/* Free irqs */
>  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 0ab2b6dba880..71894b9e0b15 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -111,6 +111,21 @@ struct dw_edma {
>  	raw_spinlock_t			lock;		/* Only for legacy */
>  
>  	struct dw_edma_chip             *chip;
> +
> +	const struct dw_edma_core_ops	*core;
> +};
> +
> +typedef void (*dw_edma_handler_t)(struct dw_edma_chan *);
> +
> +struct dw_edma_core_ops {
> +	void (*off)(struct dw_edma *dw);
> +	u16 (*ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
> +	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
> +	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> +				  dw_edma_handler_t done, dw_edma_handler_t abort);
> +	void (*start)(struct dw_edma_chunk *chunk, bool first);
> +	void (*ch_config)(struct dw_edma_chan *chan);
> +	void (*debugfs_on)(struct dw_edma *dw);
>  };
>  
>  struct dw_edma_sg {
> @@ -148,4 +163,47 @@ struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
>  	return vc2dw_edma_chan(to_virt_chan(dchan));
>  }
>  
> +static inline
> +void dw_edma_core_off(struct dw_edma *dw)
> +{
> +	dw->core->off(dw);
> +}
> +
> +static inline
> +u16 dw_edma_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> +{
> +	return dw->core->ch_count(dw, dir);
> +}
> +
> +static inline
> +enum dma_status dw_edma_core_ch_status(struct dw_edma_chan *chan)
> +{
> +	return chan->dw->core->ch_status(chan);
> +}
> +
> +static inline irqreturn_t
> +dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> +			dw_edma_handler_t done, dw_edma_handler_t abort)
> +{
> +	return dw_irq->dw->core->handle_int(dw_irq, dir, done, abort);
> +}
> +
> +static inline
> +void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
> +{
> +	dw->core->start(chunk, first);
> +}
> +
> +static inline
> +void dw_edma_core_ch_config(struct dw_edma_chan *chan)
> +{
> +	chan->dw->core->ch_config(chan);
> +}
> +
> +static inline
> +void dw_edma_core_debugfs_on(struct dw_edma *dw)
> +{
> +	dw->core->debugfs_on(dw);
> +}
> +
>  #endif /* _DW_EDMA_CORE_H */
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 32f834a3848a..b38786f0ad79 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -7,7 +7,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> -
> +#include <linux/irqreturn.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  
>  #include "dw-edma-core.h"
> @@ -160,7 +160,7 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  	readl_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
>  
>  /* eDMA management callbacks */
> -void dw_edma_v0_core_off(struct dw_edma *dw)
> +static void dw_edma_v0_core_off(struct dw_edma *dw)
>  {
>  	SET_BOTH_32(dw, int_mask,
>  		    EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
> @@ -169,7 +169,7 @@ void dw_edma_v0_core_off(struct dw_edma *dw)
>  	SET_BOTH_32(dw, engine_en, 0);
>  }
>  
> -u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> +static u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  {
>  	u32 num_ch;
>  
> @@ -186,7 +186,7 @@ u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  	return (u16)num_ch;
>  }
>  
> -enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
> +static enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
>  	u32 tmp;
> @@ -202,7 +202,7 @@ enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
>  		return DMA_ERROR;
>  }
>  
> -void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
> +static void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
>  
> @@ -210,7 +210,7 @@ void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
>  		  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
>  }
>  
> -void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
> +static void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
>  
> @@ -218,18 +218,64 @@ void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
>  		  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
>  }
>  
> -u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
> +static u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
>  {
>  	return FIELD_GET(EDMA_V0_DONE_INT_MASK,
>  			 GET_RW_32(dw, dir, int_status));
>  }
>  
> -u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
> +static u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
>  {
>  	return FIELD_GET(EDMA_V0_ABORT_INT_MASK,
>  			 GET_RW_32(dw, dir, int_status));
>  }
>  
> +static irqreturn_t
> +dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> +			   dw_edma_handler_t done, dw_edma_handler_t abort)
> +{
> +	struct dw_edma *dw = dw_irq->dw;
> +	unsigned long total, pos, val;
> +	irqreturn_t ret = IRQ_NONE;
> +	struct dw_edma_chan *chan;
> +	unsigned long off;
> +	u32 mask;
> +
> +	if (dir == EDMA_DIR_WRITE) {
> +		total = dw->wr_ch_cnt;
> +		off = 0;
> +		mask = dw_irq->wr_mask;
> +	} else {
> +		total = dw->rd_ch_cnt;
> +		off = dw->wr_ch_cnt;
> +		mask = dw_irq->rd_mask;
> +	}
> +
> +	val = dw_edma_v0_core_status_done_int(dw, dir);
> +	val &= mask;
> +	for_each_set_bit(pos, &val, total) {
> +		chan = &dw->chan[pos + off];
> +
> +		dw_edma_v0_core_clear_done_int(chan);
> +		done(chan);
> +
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	val = dw_edma_v0_core_status_abort_int(dw, dir);
> +	val &= mask;
> +	for_each_set_bit(pos, &val, total) {
> +		chan = &dw->chan[pos + off];
> +
> +		dw_edma_v0_core_clear_abort_int(chan);
> +		abort(chan);
> +
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	return ret;
> +}
> +
>  static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
>  				     u32 control, u32 size, u64 sar, u64 dar)
>  {
> @@ -300,7 +346,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
>  }
>  
> -void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> +static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
>  	struct dw_edma *dw = chan->dw;
> @@ -371,7 +417,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
>  }
>  
> -int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
> +static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
>  	u32 tmp = 0;
> @@ -438,12 +484,25 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
>  		SET_RW_32(dw, chan->dir, ch67_imwr_data, tmp);
>  		break;
>  	}
> -
> -	return 0;
>  }
>  
>  /* eDMA debugfs callbacks */
> -void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
> +static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
>  {
>  	dw_edma_v0_debugfs_on(dw);
>  }
> +
> +static const struct dw_edma_core_ops dw_edma_v0_core = {
> +	.off = dw_edma_v0_core_off,
> +	.ch_count = dw_edma_v0_core_ch_count,
> +	.ch_status = dw_edma_v0_core_ch_status,
> +	.handle_int = dw_edma_v0_core_handle_int,
> +	.start = dw_edma_v0_core_start,
> +	.ch_config = dw_edma_v0_core_ch_config,
> +	.debugfs_on = dw_edma_v0_core_debugfs_on,
> +};
> +
> +void dw_edma_v0_core_register(struct dw_edma *dw)
> +{
> +	dw->core = &dw_edma_v0_core;
> +}
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
> index ab96a1f48080..04a882222f99 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
> @@ -11,17 +11,7 @@
>  
>  #include <linux/dma/edma.h>
>  
> -/* eDMA management callbacks */
> -void dw_edma_v0_core_off(struct dw_edma *chan);
> -u16 dw_edma_v0_core_ch_count(struct dw_edma *chan, enum dw_edma_dir dir);
> -enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan);
> -void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan);
> -void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan);
> -u32 dw_edma_v0_core_status_done_int(struct dw_edma *chan, enum dw_edma_dir dir);
> -u32 dw_edma_v0_core_status_abort_int(struct dw_edma *chan, enum dw_edma_dir dir);
> -void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
> -int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
> -/* eDMA debug fs callbacks */
> -void dw_edma_v0_core_debugfs_on(struct dw_edma *dw);
> +/* eDMA core register */
> +void dw_edma_v0_core_register(struct dw_edma *dw);
>  
>  #endif /* _DW_EDMA_V0_CORE_H */
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
