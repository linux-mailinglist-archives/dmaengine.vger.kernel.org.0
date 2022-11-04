Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE4161985C
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 14:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiKDNpN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 09:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiKDNpI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 09:45:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68273D2E8;
        Fri,  4 Nov 2022 06:45:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C693A621D6;
        Fri,  4 Nov 2022 13:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A11C43148;
        Fri,  4 Nov 2022 13:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667569504;
        bh=eqzbIgNdsvBU+JAwkj6lSiuMcoKkkkjuToC6fTW/2Yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hGdQ4zRDxeyaiFm/c/v5ChwR4MjdBQ8ivZP97BkCs1lWcTcxqUx1VuzA2Rv9HKWk4
         m/ACkL63BJ8IzlteumRMtcP9NtfGlX0zlqksTt33B/hfYUB0VYC3z8l6XG/+mFKOzc
         prsNjxVAstbTApUbskbYa9xXxH9bvyrJxfj9vF6PtOLS3YCNWPTZSIL+cmRRlcDzp1
         iTZ+HaEx6RiiYg1U3yqiJeIjLjkSbMpebtPQD+cUCLlwgZRAJtus9eLHvtstxnRxdu
         inKxsO+RMC4KgrYuosLGFrmvLUaF0qx19nUDcSdH0ovk6JLar38Y3ZRgSrLUKjDmvF
         39kHKowXZ1GKw==
Date:   Fri, 4 Nov 2022 19:15:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     fancer.lancer@gmail.com, caihuoqing <caihuoqing@baidu.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 2/3] dmaengine: dw-edma: Create a new dw_edma_core_ops
 structure to abstract controller operation
Message-ID: <Y2UXXK6C5Q0IWBlo@matsya>
References: <20220921064859.10328-1-cai.huoqing@linux.dev>
 <20220921064859.10328-3-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921064859.10328-3-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-09-22, 14:48, Cai Huoqing wrote:
> From: caihuoqing <caihuoqing@baidu.com>
> 
> The structure dw_edma_core_ops has a set of the pointers
> abstracting out the DW eDMA vX and DW HDMA Native controllers.
> And use dw_edma_v0_core_register to set up operation.

Core can mean different things, why not call it
dw_edma_v0_{controller|cntrl}_regs

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
>  
>  	vd = vchan_next_desc(&chan->vc);
>  	if (!vd)
> @@ -201,7 +202,7 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
>  	if (!child)
>  		return;
>  
> -	dw_edma_v0_core_start(child, !desc->xfer_sz);
> +	dw->core->dw_xdma_core_start(child, !desc->xfer_sz);
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
>  
> -		dw_edma_abort_interrupt(chan);
> -	}
> +	dw->core->dw_xdma_core_done_handle(dw_irq, dw_edma_done_interrupt, dir);
> +	dw->core->dw_xdma_core_abort_handle(dw_irq, dw_edma_abort_interrupt, dir);
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
> +	void (*dw_xdma_core_done_handle)(struct dw_edma_irq *dw_irq,
> +							void (*done_cb)(struct dw_edma_chan *chan),
> +							enum dw_edma_dir dir);
> +	void (*dw_xdma_core_abort_handle)(struct dw_edma_irq *dw_irq,
> +							void (*abort_cb)(struct dw_edma_chan *chan),
> +							enum dw_edma_dir dir);
> +	void (*dw_xdma_core_start)(struct dw_edma_chunk *chunk, bool first);
> +	int (*dw_xdma_core_ch_config)(struct dw_edma_chan *chan);
> +	void (*dw_xdma_core_debugfs_on)(struct dw_edma *dw);
> +};
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
> +		done_cb(&dw->chan[pos + off]);
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
> +		abort_cb(&dw->chan[pos + off]);
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

dw_xdma_ctrl_xxx sounds more right for these

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
> +void dw_edma_v0_core_register(struct dw_edma *dw);
>  
>  #endif /* _DW_EDMA_V0_CORE_H */
> -- 
> 2.25.1

-- 
~Vinod
