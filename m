Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1D46C106E
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 12:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCTLM7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 07:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjCTLMh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 07:12:37 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099BB14212;
        Mon, 20 Mar 2023 04:09:32 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id z42so11628688ljq.13;
        Mon, 20 Mar 2023 04:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679310571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEDNvx7fg0sHf1rjjv9Vrk8TqJMY3Iv4eGigpDNwJNg=;
        b=oJuI7bkXcyVQjzCuA3pGVYF/gM8tM2CY218DkvJkq7JPqoAedan95jL8/FXGiLBgLZ
         QnubzxtwetBimepVKyTX6mu7xH/ThxqTsX38EEcKFXx3g1mQaah0gRuu8Bqd/TH3Q+aP
         PQflzXJTpWZel5T9QSsmOk0wLYDXG+AjiprxPMquvDZq7uTfL2w77zJYokTxVs91BfvE
         55MAXHV9ly4lpHUZTUAk00+UBJ1vjl67Ofb8PzIGtlYmQq012sQNmNh5sfREufzyknuF
         BpAdDtgkPkhQ0OZJYq3o5i7Dv3F0j3ebX5qnO5DFbw3TS/c3f1Zhy1qbMUzwHOZc1+mn
         gSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679310571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEDNvx7fg0sHf1rjjv9Vrk8TqJMY3Iv4eGigpDNwJNg=;
        b=TIUzfIsYE+xYSbE1LBo/VpHB4eBTHe6bJ7KAVYPZzef5TSvwWtRFRQVPA5rrCroNDe
         c21aITHSdLfguvL3vuGd3yOusAv3D22xWz9MtoVtaAGioQzyUYxrbaPdXEjfqhaq0dK3
         +lYr5bAk9eKW3teoCIDkaJZWzA1aoX7ZfNjsNE2ndJ603+K4jUEjoi2EzDrcoCFjbUWa
         VRKAux1LqIZ5v4Xj36rragCQX3Xope8iWP8ITy4f3zyhf8++A8keZTPRGLExIqL4CDfV
         K5vW1QrGi8H4FCkXO0v9GLYkwu4Ksg84LP+fgRTaCGNo55cfNbfCIMp/dEPAZZeEhyNV
         mY5g==
X-Gm-Message-State: AO0yUKVOEc6UJzrl301aKm/MgNWVH635eKIYN7GAgKoBQhGRz9MAn5HM
        C+3F5exvGiEAL0dTCb0DDww=
X-Google-Smtp-Source: AK7set/5PnvPqNyy/vOsgMwaFSjKxxuBULU/Y7HOZA2IGF8+TnMEIccQTPKG6NQXJcVNsV+ZhNfR2Q==
X-Received: by 2002:a05:651c:2213:b0:295:941d:9557 with SMTP id y19-20020a05651c221300b00295941d9557mr7221543ljq.51.1679310570584;
        Mon, 20 Mar 2023 04:09:30 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id p15-20020a2ea40f000000b00295a8d1ecc7sm1697449ljn.18.2023.03.20.04.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:09:30 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:09:28 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 2/5] dmaengine: dw-edma: Create a new dw_edma_core_ops
 structure to abstract controller operation
Message-ID: <20230320110928.znzlrmomlkmy5mw7@mobilestation>
References: <20230315012840.6986-1-cai.huoqing@linux.dev>
 <20230315012840.6986-3-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315012840.6986-3-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 15, 2023 at 09:28:33AM +0800, Cai Huoqing wrote:
> From: Cai huoqing <cai.huoqing@linux.dev>
> 
> The structure dw_edma_core_ops has a set of the pointers
> abstracting out the DW eDMA vX and DW HDMA Native controllers.
> And use dw_edma_v0_core_register to set up operation.
> 
> Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>

LGTM. Thanks.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
> v6->v7:
>   1.Revert dw_edma_core_handle_int back to dw-edma-core.h.
>   2.Fix code style.
> 
> v6 link:
>   https://lore.kernel.org/lkml/20230310032342.17395-3-cai.huoqing@linux.dev/
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
>  static void dw_edma_start_transfer(struct dw_edma_chan *chan)
>  {
> +	struct dw_edma *dw = chan->dw;
>  	struct dw_edma_chunk *child;
>  	struct dw_edma_desc *desc;
>  	struct virt_dma_desc *vd;
> @@ -200,7 +201,7 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
>  	if (!child)
>  		return;
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
> index 72e79a0c0a4e..16c48197d3c6 100644
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
> @@ -216,7 +216,7 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  	readq_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
>  
>  /* eDMA management callbacks */
> -void dw_edma_v0_core_off(struct dw_edma *dw)
> +static void dw_edma_v0_core_off(struct dw_edma *dw)
>  {
>  	SET_BOTH_32(dw, int_mask,
>  		    EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
> @@ -225,7 +225,7 @@ void dw_edma_v0_core_off(struct dw_edma *dw)
>  	SET_BOTH_32(dw, engine_en, 0);
>  }
>  
> -u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> +static u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  {
>  	u32 num_ch;
>  
> @@ -242,7 +242,7 @@ u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  	return (u16)num_ch;
>  }
>  
> -enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
> +static enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
>  	u32 tmp;
> @@ -258,7 +258,7 @@ enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
>  		return DMA_ERROR;
>  }
>  
> -void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
> +static void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
>  
> @@ -266,7 +266,7 @@ void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
>  		  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
>  }
>  
> -void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
> +static void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
>  
> @@ -274,18 +274,64 @@ void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
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
> @@ -356,7 +402,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
>  }
>  
> -void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> +static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
>  	struct dw_edma *dw = chan->dw;
> @@ -427,7 +473,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
>  }
>  
> -int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
> +static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
>  	u32 tmp = 0;
> @@ -494,12 +540,25 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
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
