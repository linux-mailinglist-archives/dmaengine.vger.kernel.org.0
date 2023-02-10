Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844836923FB
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 18:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjBJRGa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 12:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjBJRG3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 12:06:29 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3114370720;
        Fri, 10 Feb 2023 09:06:27 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id b16so6937250ljr.11;
        Fri, 10 Feb 2023 09:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9PvvUonYvqfiD6xOO2OD/kmZJZxhZdlIWiS45GaIJhQ=;
        b=OK4i9IX7Cz8bH6mIbXlYJRYAcNQWB+joJdPms9r4vNJ1TgSsNjx9PELVmBLx32AmUr
         AkhrbsZ/KrWbombIHupTuir4TmB0zO7KUGxo+EcbsHe2To0oUuZJ/rzPzfM78PWWd+fy
         vC5IIhib/Yg5Jd0HZBxxfzcOlDDtBUvE0vNFAeRzMfKEndkvJHvR6q7d5uNpGBXqR4PN
         HBRxqc2HRR8X2dcd+OO2rm4rtJ/wBb7sKEyNhKe+RpcnKsK7BMhL/hfuY5qKZ9WJBq0Q
         Z453c7ymmqYlIPci+Z3i9/bshHWQcDLYG3oR2IuO4ntuKlGbCvi+ydI+lpZb/HLBR9t0
         sFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PvvUonYvqfiD6xOO2OD/kmZJZxhZdlIWiS45GaIJhQ=;
        b=DN8ibBR7fnha4BqSAFlxHYk/37v1G8t2NS7T7vCeDl1fnYWU1E4uszOTVmADb9YKPp
         DMy0wszOKfOI4z4vhZ8ZsZV/hPcEbsJq64FG8YD6rbyjuWPEeUu1fV46Ox7sBZeWoBX3
         9yOKfBMIBv81qHnil0LWnuisyK9wBWbcq+/XMWqNDCm23qFVMENbxezn+WLUTKXjRYlR
         QyFAet/NJoFQW62OV0xq71ciftPwb6rv5Mn2hEajGWGHmf8+CLB2CsVJXpy8eIdZMC13
         9g+6gB70CBQWx7iRd0wA99jTjQMG7FzGpzZrlSpq2MIF+OkRV99YxMUk6OcmEyHxg2Tc
         /xsQ==
X-Gm-Message-State: AO0yUKUEmXmEV5ExFmhrP4rVRyqUceBdb3eD2DqjBLOsdPcqLpp6lcf7
        AfE49YBEsLWL8oPf+6tTdKQ=
X-Google-Smtp-Source: AK7set9GVq/HkKoeH7tHK+RGCM8ufPMuE0QTKz1HFeILQjs5NGgbEKMNi1MVLnLVpa27XRrH/VcVIA==
X-Received: by 2002:a2e:94c5:0:b0:27f:c02b:a04b with SMTP id r5-20020a2e94c5000000b0027fc02ba04bmr4175261ljh.42.1676048785284;
        Fri, 10 Feb 2023 09:06:25 -0800 (PST)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id c10-20020ac2530a000000b004d865c781eesm369538lfh.24.2023.02.10.09.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:06:24 -0800 (PST)
Date:   Fri, 10 Feb 2023 20:06:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     caihuoqing <caihuoqing@baidu.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 2/3] dmaengine: dw-edma: Create a new dw_edma_core_ops
 structure to abstract controller operation
Message-ID: <20230210170622.zkzao43343bnpl37@mobilestation.baikal.int>
References: <20220921064859.10328-1-cai.huoqing@linux.dev>
 <20220921064859.10328-3-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921064859.10328-3-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Sep 21, 2022 at 02:48:51PM +0800, Cai Huoqing wrote:
> From: caihuoqing <caihuoqing@baidu.com>
> 
> The structure dw_edma_core_ops has a set of the pointers
> abstracting out the DW eDMA vX and DW HDMA Native controllers.
> And use dw_edma_v0_core_register to set up operation.
> 
> Signed-off-by: caihuoqing <caihuoqing@baidu.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c    | 61 ++++++------------
>  drivers/dma/dw-edma/dw-edma-core.h    | 19 ++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 90 ++++++++++++++++++++++++---
>  drivers/dma/dw-edma/dw-edma-v0-core.h | 14 +----
>  4 files changed, 120 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 5736a537f4c8..a66e4216a5d3 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -187,6 +187,7 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
>  	struct dw_edma_chunk *child;
>  	struct dw_edma_desc *desc;
>  	struct virt_dma_desc *vd;

> +	struct dw_edma *dw = chan->dw;

Either use the reverse xmas tree order or alternatively you could
directly pass "chan->dw" to the corresponding function (see my
suggestion below).

>  
>  	vd = vchan_next_desc(&chan->vc);
>  	if (!vd)
> @@ -201,7 +202,7 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
>  	if (!child)
>  		return;
>  

> -	dw_edma_v0_core_start(child, !desc->xfer_sz);
> +	dw->core->dw_xdma_core_start(child, !desc->xfer_sz);

Using the naked function pointers isn't that much readable. What about
introducing a set of static inline methods defined in the
dw-edma-core.h file for each op-pointer? For instance in this case the
wrapper would look like this:

static inline
dw_edma_v0_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
{
	dw->core->start(child, first);
} 

>  	desc->xfer_sz += child->ll_region.sz;
>  	dw_edma_free_burst(child);
>  	list_del(&child->list);
> @@ -277,6 +278,7 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
>  static int dw_edma_device_terminate_all(struct dma_chan *dchan)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	struct dw_edma *dw = chan->dw;
>  	int err = 0;
>  
>  	if (!chan->configured) {
> @@ -286,7 +288,7 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
>  		chan->configured = false;
>  	} else if (chan->status == EDMA_ST_IDLE) {
>  		chan->configured = false;
> -	} else if (dw_edma_v0_core_ch_status(chan) == DMA_COMPLETE) {
> +	} else if (dw->core->dw_xdma_core_ch_status(chan) == DMA_COMPLETE) {
>  		/*
>  		 * The channel is in a false BUSY state, probably didn't
>  		 * receive or lost an interrupt
> @@ -593,9 +595,10 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
>  {

>  	struct dw_edma_desc *desc;
>  	struct virt_dma_desc *vd;
> +	struct dw_edma *dw = chan->dw;

ditto

>  	unsigned long flags;
>  
> -	dw_edma_v0_core_clear_done_int(chan);
> +	dw->core->dw_xdma_core_clear_done_int(chan);
>  
>  	spin_lock_irqsave(&chan->vc.lock, flags);
>  	vd = vchan_next_desc(&chan->vc);
> @@ -635,9 +638,10 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
>  static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
>  {

>  	struct virt_dma_desc *vd;
> +	struct dw_edma *dw = chan->dw;

ditto

>  	unsigned long flags;
>  
> -	dw_edma_v0_core_clear_abort_int(chan);
> +	dw->core->dw_xdma_core_clear_abort_int(chan);
>  
>  	spin_lock_irqsave(&chan->vc.lock, flags);
>  	vd = vchan_next_desc(&chan->vc);
> @@ -654,39 +658,10 @@ static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
>  {
>  	struct dw_edma_irq *dw_irq = data;
>  	struct dw_edma *dw = dw_irq->dw;
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

> +	enum dw_edma_dir dir = write ? EDMA_DIR_WRITE : EDMA_DIR_READ;

ditto. Mind using reverse xmas tree vars definition order.

>  
> -		dw_edma_abort_interrupt(chan);
> -	}
> +	dw->core->dw_xdma_core_done_handle(dw_irq, dw_edma_done_interrupt, dir);

> +	dw->core->dw_xdma_core_abort_handle(dw_irq, dw_edma_abort_interrupt, dir);

In addition to the status_done_int() and status_abort_int() global
methods you can get rid from two callbacks in this case:
dw_xdma_core_clear_done_int()
dw_xdma_core_clear_abort_int()
Just call the corresponding functions within the core-specific 
core_done_handle() and core_abort_handle() methods before calling the
callbacks: dw_edma_done_interrupt() and dw_edma_abort_interrupt().

That way the IRQs handling procedure will be simplified a bit.

>  
>  	return IRQ_HANDLED;
>  }
> @@ -832,7 +807,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  
>  		vchan_init(&chan->vc, dma);
>  
> -		dw_edma_v0_core_device_config(chan);
> +		dw->core->dw_xdma_core_ch_config(chan);
>  	}
>  
>  	/* Set DMA channel capabilities */
> @@ -977,14 +952,16 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  
>  	dw->chip = chip;
>  
> +	dw_edma_v0_core_register(dw);
> +
>  	raw_spin_lock_init(&dw->lock);
>  
>  	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> -			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
> +			      dw->core->dw_xdma_core_ch_count(dw, EDMA_DIR_WRITE));
>  	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
>  
>  	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> -			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
> +			      dw->core->dw_xdma_core_ch_count(dw, EDMA_DIR_READ));
>  	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
>  
>  	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
> @@ -1003,7 +980,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  		 dev_name(chip->dev));
>  
>  	/* Disable eDMA, only to establish the ideal initial conditions */
> -	dw_edma_v0_core_off(dw);
> +	dw->core->dw_xdma_core_off(dw);
>  
>  	/* Request IRQs */
>  	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
> @@ -1019,7 +996,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	pm_runtime_enable(dev);
>  
>  	/* Turn debugfs on */
> -	dw_edma_v0_core_debugfs_on(dw);
> +	dw->core->dw_xdma_core_debugfs_on(dw);
>  
>  	chip->dw = dw;
>  
> @@ -1045,7 +1022,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  		return -ENODEV;
>  
>  	/* Disable eDMA */
> -	dw_edma_v0_core_off(dw);
> +	dw->core->dw_xdma_core_off(dw);
>  
>  	/* Free irqs */
>  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 0ab2b6dba880..9b472d3c1596 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -95,6 +95,23 @@ struct dw_edma_irq {
>  	struct dw_edma			*dw;
>  };
>  

> +struct dw_edma_core_ops {
> +	void (*dw_xdma_core_off)(struct dw_edma *dw);
> +	u16 (*dw_xdma_core_ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
> +	enum dma_status (*dw_xdma_core_ch_status)(struct dw_edma_chan *chan);

> +	void (*dw_xdma_core_clear_done_int)(struct dw_edma_chan *chan);
> +	void (*dw_xdma_core_clear_abort_int)(struct dw_edma_chan *chan);

As I said above just call these methods in the IRQ-handle loops within
the core-specific module. Thus you'll be able to drop these pointers.

> +	void (*dw_xdma_core_done_handle)(struct dw_edma_irq *dw_irq,
> +							void (*done_cb)(struct dw_edma_chan *chan),
> +							enum dw_edma_dir dir);
> +	void (*dw_xdma_core_abort_handle)(struct dw_edma_irq *dw_irq,
> +							void (*abort_cb)(struct dw_edma_chan *chan),
> +							enum dw_edma_dir dir);

1. Please fix the indentation so the arguments would be vertically
aligned.
2. "_cb" suffix seems redundant. It's obvious that the function
pointer is a callback.

> +	void (*dw_xdma_core_start)(struct dw_edma_chunk *chunk, bool first);
> +	int (*dw_xdma_core_ch_config)(struct dw_edma_chan *chan);
> +	void (*dw_xdma_core_debugfs_on)(struct dw_edma *dw);
> +};

You can completely drop the "dw_xdma_core_" prefix from the field names.
It's obvious that they refer to the IP-core specific operation.

> +
>  struct dw_edma {
>  	char				name[32];
>  
> @@ -111,6 +128,8 @@ struct dw_edma {
>  	raw_spinlock_t			lock;		/* Only for legacy */
>  
>  	struct dw_edma_chip             *chip;

> +
> +	const struct dw_edma_core_ops *core;
                                     ^
     +-------------------------------+
Use tab in here?

>  };
>  
>  struct dw_edma_sg {
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 51a34b43434c..0c1a74245ecc 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -223,7 +223,7 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  	writeq(value, ll)
>  
>  /* eDMA management callbacks */
> -void dw_edma_v0_core_off(struct dw_edma *dw)
> +static void dw_edma_v0_core_off(struct dw_edma *dw)
>  {
>  	SET_BOTH_32(dw, int_mask,
>  		    EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
> @@ -232,7 +232,7 @@ void dw_edma_v0_core_off(struct dw_edma *dw)
>  	SET_BOTH_32(dw, engine_en, 0);
>  }
>  
> -u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> +static u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  {
>  	u32 num_ch;
>  
> @@ -249,7 +249,7 @@ u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  	return (u16)num_ch;
>  }
>  
> -enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
> +static enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
>  	u32 tmp;
> @@ -265,7 +265,7 @@ enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
>  		return DMA_ERROR;
>  }
>  
> -void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
> +static void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
>  
> @@ -273,7 +273,7 @@ void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
>  		  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
>  }
>  
> -void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
> +static void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
>  
> @@ -281,18 +281,70 @@ void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
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
> +static
> +void dw_edma_v0_core_done_handle(struct dw_edma_irq *dw_irq,
> +							void (*done_cb)(struct dw_edma_chan *chan),
> +							enum dw_edma_dir dir)
> +{
> +	struct dw_edma *dw = dw_irq->dw;
> +	unsigned long total, pos, val;
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
> +	for_each_set_bit(pos, &val, total)
                                              <-+
> +		done_cb(&dw->chan[pos + off]);  |
                                                |
dw_edma_v0_core_clear_done_int()----------------+
?

> +}
> +
> +static
> +void dw_edma_v0_core_abort_handle(struct dw_edma_irq *dw_irq,
> +							void (*abort_cb)(struct dw_edma_chan *chan),
> +							enum dw_edma_dir dir)
> +{
> +	struct dw_edma *dw = dw_irq->dw;
> +	unsigned long total, pos, val;
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
> +	val = dw_edma_v0_core_status_abort_int(dw, dir);
> +	val &= mask;
> +	for_each_set_bit(pos, &val, total)
                                              <-+
> +		abort_cb(&dw->chan[pos + off]); |
                                                |
dw_edma_v0_core_clear_abort_int()---------------+
?

> +}
> +
>  static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  {
>  	struct dw_edma_burst *child;
> @@ -338,7 +390,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	SET_LL_64(&llp->llp.reg, chunk->ll_region.paddr);
>  }
>  
> -void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> +static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
>  	struct dw_edma *dw = chan->dw;
> @@ -409,7 +461,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
>  }
>  
> -int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
> +static int dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
>  	u32 tmp = 0;
> @@ -481,7 +533,25 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
>  }
>  
>  /* eDMA debugfs callbacks */
> -void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
> +static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
>  {
>  	dw_edma_v0_debugfs_on(dw);
>  }
> +

> +static const struct dw_edma_core_ops edma_core = {

Please use dw_edma_core name for the structure instance in order to
maintain the driver naming convention.

> +	.dw_xdma_core_off = dw_edma_v0_core_off,
> +	.dw_xdma_core_ch_count = dw_edma_v0_core_ch_count,
> +	.dw_xdma_core_ch_status = dw_edma_v0_core_ch_status,
> +	.dw_xdma_core_clear_done_int = dw_edma_v0_core_clear_done_int,
> +	.dw_xdma_core_clear_abort_int = dw_edma_v0_core_clear_abort_int,
> +	.dw_xdma_core_done_handle = dw_edma_v0_core_done_handle,
> +	.dw_xdma_core_abort_handle = dw_edma_v0_core_abort_handle,
> +	.dw_xdma_core_start = dw_edma_v0_core_start,
> +	.dw_xdma_core_ch_config = dw_edma_v0_core_ch_config,
> +	.dw_xdma_core_debugfs_on = dw_edma_v0_core_debugfs_on,
> +};
> +
> +void dw_edma_v0_core_register(struct dw_edma *dw)
> +{
> +	dw->core = &edma_core;
> +}
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
> index ab96a1f48080..972994ecc96f 100644
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

> +/* eDMA core operation register*/

"eDMA core register"?

-Serge(y)

> +void dw_edma_v0_core_register(struct dw_edma *dw);
>  
>  #endif /* _DW_EDMA_V0_CORE_H */
> -- 
> 2.25.1
> 
