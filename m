Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7277F6915F6
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 01:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjBJA7G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Feb 2023 19:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjBJA6k (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Feb 2023 19:58:40 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0986F8E7;
        Thu,  9 Feb 2023 16:57:28 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id jg8so11853828ejc.6;
        Thu, 09 Feb 2023 16:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJKwv2OsRhMlsOuw5vlHv4NfDj/p6mN4ZJJdnVm1sZE=;
        b=obTc6B7v419GsDU1DL9YxVo46x9jAxui8vYVUyZ5rgtuNchJVFQZO8IDgpQ0V1Lo33
         /nW8+R5Z3//BH02H9ZAxgKS+XBmBFuBv0uc2NWY5Ae4P2c9tyXKuH9FCPbMHChFRle7b
         3LeJn8l+sBboHoHNH0vd92MFl1R3SkPef5ZSSCU4qT6+8QAFrWkoRgi1tKFXCTe2YrOG
         Xqvasa9QJ6Rk05akF18HZWtGMuGfIlO1Ir2I5J8dlVrM1LGAQDA48TN4WQaNJVeAa+27
         Mcov39fG0nWLYrsbBZPLJ16cywaXb8alqhyl5wTk1gQeTNAzLI8b68O4B7RRqmU87QK7
         11qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJKwv2OsRhMlsOuw5vlHv4NfDj/p6mN4ZJJdnVm1sZE=;
        b=L9UueY9jlNt4yb4NkDuNBW1CScPn35kbeb/Tc4Ap61qKuErCAFM4q0I0dkvl0NWXaP
         ChZGcf//OCHcU/KeQDaaW6qfVSUGR24ip40nLFEntTqih84rBBG6/BHV/daXWXoy8V5q
         SUQpE7WNEsHhMsLohMK0SvK3v1dieraYWepxAA2Hx0yc/Rwuva/3T8A3ndzF6U8u1ClB
         zqdwx0x1JoEFtjXzNpsMxSpanizBuOWPGySbyooMQcedzrF8ZP38M/S7DLcF6LcPBM11
         eMDHegE5bgOld5CEWYFaswYCz0m8YluEEeDJnWRw9sEz9TSBUUOxvOzY5oI8nwDJ5kdI
         /DEQ==
X-Gm-Message-State: AO0yUKVyS2l48YNsTG2sZybuqr4qIib/7oBOl7AEIo71LTdT76Q02qsv
        vILl7WZMYIoxPghcOHx3UDo=
X-Google-Smtp-Source: AK7set/8QMVvdNETIhYMY7sUhfjjDS+wSun4/lbnIFIZ1yPwygezfSp+y79KrSn+2hSmXeqY6JrRqQ==
X-Received: by 2002:a17:907:6090:b0:8ae:3380:ff56 with SMTP id ht16-20020a170907609000b008ae3380ff56mr9915046ejc.63.1675990646702;
        Thu, 09 Feb 2023 16:57:26 -0800 (PST)
Received: from mobilestation ([91.193.176.251])
        by smtp.gmail.com with ESMTPSA id b5-20020a170906d10500b008784bc1dd05sm1575371ejz.76.2023.02.09.16.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 16:57:26 -0800 (PST)
Date:   Fri, 10 Feb 2023 03:57:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        caihuoqing <caihuoqing@baidu.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 2/3] dmaengine: dw-edma: Create a new dw_edma_core_ops
 structure to abstract controller operation
Message-ID: <20230210005722.rgzwjihi5aklv4rt@mobilestation>
References: <20220921064859.10328-1-cai.huoqing@linux.dev>
 <20220921064859.10328-3-cai.huoqing@linux.dev>
 <Y2UXXK6C5Q0IWBlo@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2UXXK6C5Q0IWBlo@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Nov 04, 2022 at 07:15:00PM +0530, Vinod Koul wrote:
> On 21-09-22, 14:48, Cai Huoqing wrote:
> > From: caihuoqing <caihuoqing@baidu.com>
> > 
> > The structure dw_edma_core_ops has a set of the pointers
> > abstracting out the DW eDMA vX and DW HDMA Native controllers.
> > And use dw_edma_v0_core_register to set up operation.
> 

> Core can mean different things, why not call it
> dw_edma_v0_{controller|cntrl}_regs

In this case it refers to the DW eDMA and HDMA IP-cores and to the
driver core where their specifics are implemented. In the later
aspects it just reflects the already defined naming conventions:
dw-edma-core.c
dw-edma-v0-core.c
dw_edma_v0_core_off()
dw_edma_v0_core_ch_count()
dw_edma_v0_core_ch_status()
dw_edma_v0_core_clear_done_int()
dw_edma_v0_core_clear_abort_int()
dw_edma_v0_core_status_done_int()
dw_edma_v0_core_status_abort_int()
dw_edma_v0_core_write_chunk()
dw_edma_v0_core_start()
dw_edma_v0_core_device_config()
dw_edma_v0_core_debugfs_on()
dw_edma_v0_core_debugfs_off()
introducing a new name may cause a redundant confusion meanwhile using
the same suffix for all driver core, device implementation specific
callbacks and operations descriptor would give a better readability.
Don't you think?

I also don't think that the "_regs" suffix looks better here.
"_ops" seems more descriptive. Do you think otherwise?

-Serge(y)

> 
> > Signed-off-by: caihuoqing <caihuoqing@baidu.com>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c    | 61 ++++++------------
> >  drivers/dma/dw-edma/dw-edma-core.h    | 19 ++++++
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 90 ++++++++++++++++++++++++---
> >  drivers/dma/dw-edma/dw-edma-v0-core.h | 14 +----
> >  4 files changed, 120 insertions(+), 64 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 5736a537f4c8..a66e4216a5d3 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -187,6 +187,7 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
> >  	struct dw_edma_chunk *child;
> >  	struct dw_edma_desc *desc;
> >  	struct virt_dma_desc *vd;
> > +	struct dw_edma *dw = chan->dw;
> >  
> >  	vd = vchan_next_desc(&chan->vc);
> >  	if (!vd)
> > @@ -201,7 +202,7 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
> >  	if (!child)
> >  		return;
> >  
> > -	dw_edma_v0_core_start(child, !desc->xfer_sz);
> > +	dw->core->dw_xdma_core_start(child, !desc->xfer_sz);
> >  	desc->xfer_sz += child->ll_region.sz;
> >  	dw_edma_free_burst(child);
> >  	list_del(&child->list);
> > @@ -277,6 +278,7 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
> >  static int dw_edma_device_terminate_all(struct dma_chan *dchan)
> >  {
> >  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > +	struct dw_edma *dw = chan->dw;
> >  	int err = 0;
> >  
> >  	if (!chan->configured) {
> > @@ -286,7 +288,7 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
> >  		chan->configured = false;
> >  	} else if (chan->status == EDMA_ST_IDLE) {
> >  		chan->configured = false;
> > -	} else if (dw_edma_v0_core_ch_status(chan) == DMA_COMPLETE) {
> > +	} else if (dw->core->dw_xdma_core_ch_status(chan) == DMA_COMPLETE) {
> >  		/*
> >  		 * The channel is in a false BUSY state, probably didn't
> >  		 * receive or lost an interrupt
> > @@ -593,9 +595,10 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> >  {
> >  	struct dw_edma_desc *desc;
> >  	struct virt_dma_desc *vd;
> > +	struct dw_edma *dw = chan->dw;
> >  	unsigned long flags;
> >  
> > -	dw_edma_v0_core_clear_done_int(chan);
> > +	dw->core->dw_xdma_core_clear_done_int(chan);
> >  
> >  	spin_lock_irqsave(&chan->vc.lock, flags);
> >  	vd = vchan_next_desc(&chan->vc);
> > @@ -635,9 +638,10 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> >  static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
> >  {
> >  	struct virt_dma_desc *vd;
> > +	struct dw_edma *dw = chan->dw;
> >  	unsigned long flags;
> >  
> > -	dw_edma_v0_core_clear_abort_int(chan);
> > +	dw->core->dw_xdma_core_clear_abort_int(chan);
> >  
> >  	spin_lock_irqsave(&chan->vc.lock, flags);
> >  	vd = vchan_next_desc(&chan->vc);
> > @@ -654,39 +658,10 @@ static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
> >  {
> >  	struct dw_edma_irq *dw_irq = data;
> >  	struct dw_edma *dw = dw_irq->dw;
> > -	unsigned long total, pos, val;
> > -	unsigned long off;
> > -	u32 mask;
> > -
> > -	if (write) {
> > -		total = dw->wr_ch_cnt;
> > -		off = 0;
> > -		mask = dw_irq->wr_mask;
> > -	} else {
> > -		total = dw->rd_ch_cnt;
> > -		off = dw->wr_ch_cnt;
> > -		mask = dw_irq->rd_mask;
> > -	}
> > -
> > -	val = dw_edma_v0_core_status_done_int(dw, write ?
> > -							  EDMA_DIR_WRITE :
> > -							  EDMA_DIR_READ);
> > -	val &= mask;
> > -	for_each_set_bit(pos, &val, total) {
> > -		struct dw_edma_chan *chan = &dw->chan[pos + off];
> > -
> > -		dw_edma_done_interrupt(chan);
> > -	}
> > -
> > -	val = dw_edma_v0_core_status_abort_int(dw, write ?
> > -							   EDMA_DIR_WRITE :
> > -							   EDMA_DIR_READ);
> > -	val &= mask;
> > -	for_each_set_bit(pos, &val, total) {
> > -		struct dw_edma_chan *chan = &dw->chan[pos + off];
> > +	enum dw_edma_dir dir = write ? EDMA_DIR_WRITE : EDMA_DIR_READ;
> >  
> > -		dw_edma_abort_interrupt(chan);
> > -	}
> > +	dw->core->dw_xdma_core_done_handle(dw_irq, dw_edma_done_interrupt, dir);
> > +	dw->core->dw_xdma_core_abort_handle(dw_irq, dw_edma_abort_interrupt, dir);
> >  
> >  	return IRQ_HANDLED;
> >  }
> > @@ -832,7 +807,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  
> >  		vchan_init(&chan->vc, dma);
> >  
> > -		dw_edma_v0_core_device_config(chan);
> > +		dw->core->dw_xdma_core_ch_config(chan);
> >  	}
> >  
> >  	/* Set DMA channel capabilities */
> > @@ -977,14 +952,16 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >  
> >  	dw->chip = chip;
> >  
> > +	dw_edma_v0_core_register(dw);
> > +
> >  	raw_spin_lock_init(&dw->lock);
> >  
> >  	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> > -			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
> > +			      dw->core->dw_xdma_core_ch_count(dw, EDMA_DIR_WRITE));
> >  	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> >  
> >  	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> > -			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
> > +			      dw->core->dw_xdma_core_ch_count(dw, EDMA_DIR_READ));
> >  	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> >  
> >  	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
> > @@ -1003,7 +980,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >  		 dev_name(chip->dev));
> >  
> >  	/* Disable eDMA, only to establish the ideal initial conditions */
> > -	dw_edma_v0_core_off(dw);
> > +	dw->core->dw_xdma_core_off(dw);
> >  
> >  	/* Request IRQs */
> >  	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
> > @@ -1019,7 +996,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >  	pm_runtime_enable(dev);
> >  
> >  	/* Turn debugfs on */
> > -	dw_edma_v0_core_debugfs_on(dw);
> > +	dw->core->dw_xdma_core_debugfs_on(dw);
> >  
> >  	chip->dw = dw;
> >  
> > @@ -1045,7 +1022,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> >  		return -ENODEV;
> >  
> >  	/* Disable eDMA */
> > -	dw_edma_v0_core_off(dw);
> > +	dw->core->dw_xdma_core_off(dw);
> >  
> >  	/* Free irqs */
> >  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > index 0ab2b6dba880..9b472d3c1596 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -95,6 +95,23 @@ struct dw_edma_irq {
> >  	struct dw_edma			*dw;
> >  };
> >  
> > +struct dw_edma_core_ops {
> > +	void (*dw_xdma_core_off)(struct dw_edma *dw);
> > +	u16 (*dw_xdma_core_ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
> > +	enum dma_status (*dw_xdma_core_ch_status)(struct dw_edma_chan *chan);
> > +	void (*dw_xdma_core_clear_done_int)(struct dw_edma_chan *chan);
> > +	void (*dw_xdma_core_clear_abort_int)(struct dw_edma_chan *chan);
> > +	void (*dw_xdma_core_done_handle)(struct dw_edma_irq *dw_irq,
> > +							void (*done_cb)(struct dw_edma_chan *chan),
> > +							enum dw_edma_dir dir);
> > +	void (*dw_xdma_core_abort_handle)(struct dw_edma_irq *dw_irq,
> > +							void (*abort_cb)(struct dw_edma_chan *chan),
> > +							enum dw_edma_dir dir);
> > +	void (*dw_xdma_core_start)(struct dw_edma_chunk *chunk, bool first);
> > +	int (*dw_xdma_core_ch_config)(struct dw_edma_chan *chan);
> > +	void (*dw_xdma_core_debugfs_on)(struct dw_edma *dw);
> > +};
> > +
> >  struct dw_edma {
> >  	char				name[32];
> >  
> > @@ -111,6 +128,8 @@ struct dw_edma {
> >  	raw_spinlock_t			lock;		/* Only for legacy */
> >  
> >  	struct dw_edma_chip             *chip;
> > +
> > +	const struct dw_edma_core_ops *core;
> >  };
> >  
> >  struct dw_edma_sg {
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 51a34b43434c..0c1a74245ecc 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -223,7 +223,7 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
> >  	writeq(value, ll)
> >  
> >  /* eDMA management callbacks */
> > -void dw_edma_v0_core_off(struct dw_edma *dw)
> > +static void dw_edma_v0_core_off(struct dw_edma *dw)
> >  {
> >  	SET_BOTH_32(dw, int_mask,
> >  		    EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
> > @@ -232,7 +232,7 @@ void dw_edma_v0_core_off(struct dw_edma *dw)
> >  	SET_BOTH_32(dw, engine_en, 0);
> >  }
> >  
> > -u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> > +static u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> >  {
> >  	u32 num_ch;
> >  
> > @@ -249,7 +249,7 @@ u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> >  	return (u16)num_ch;
> >  }
> >  
> > -enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
> > +static enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
> >  {
> >  	struct dw_edma *dw = chan->dw;
> >  	u32 tmp;
> > @@ -265,7 +265,7 @@ enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
> >  		return DMA_ERROR;
> >  }
> >  
> > -void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
> > +static void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
> >  {
> >  	struct dw_edma *dw = chan->dw;
> >  
> > @@ -273,7 +273,7 @@ void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
> >  		  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
> >  }
> >  
> > -void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
> > +static void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
> >  {
> >  	struct dw_edma *dw = chan->dw;
> >  
> > @@ -281,18 +281,70 @@ void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
> >  		  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
> >  }
> >  
> > -u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
> > +static u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
> >  {
> >  	return FIELD_GET(EDMA_V0_DONE_INT_MASK,
> >  			 GET_RW_32(dw, dir, int_status));
> >  }
> >  
> > -u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
> > +static u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
> >  {
> >  	return FIELD_GET(EDMA_V0_ABORT_INT_MASK,
> >  			 GET_RW_32(dw, dir, int_status));
> >  }
> >  
> > +static
> > +void dw_edma_v0_core_done_handle(struct dw_edma_irq *dw_irq,
> > +							void (*done_cb)(struct dw_edma_chan *chan),
> > +							enum dw_edma_dir dir)
> > +{
> > +	struct dw_edma *dw = dw_irq->dw;
> > +	unsigned long total, pos, val;
> > +	unsigned long off;
> > +	u32 mask;
> > +
> > +	if (dir == EDMA_DIR_WRITE) {
> > +		total = dw->wr_ch_cnt;
> > +		off = 0;
> > +		mask = dw_irq->wr_mask;
> > +	} else {
> > +		total = dw->rd_ch_cnt;
> > +		off = dw->wr_ch_cnt;
> > +		mask = dw_irq->rd_mask;
> > +	}
> > +
> > +	val = dw_edma_v0_core_status_done_int(dw, dir);
> > +	val &= mask;
> > +	for_each_set_bit(pos, &val, total)
> > +		done_cb(&dw->chan[pos + off]);
> > +}
> > +
> > +static
> > +void dw_edma_v0_core_abort_handle(struct dw_edma_irq *dw_irq,
> > +							void (*abort_cb)(struct dw_edma_chan *chan),
> > +							enum dw_edma_dir dir)
> > +{
> > +	struct dw_edma *dw = dw_irq->dw;
> > +	unsigned long total, pos, val;
> > +	unsigned long off;
> > +	u32 mask;
> > +
> > +	if (dir == EDMA_DIR_WRITE) {
> > +		total = dw->wr_ch_cnt;
> > +		off = 0;
> > +		mask = dw_irq->wr_mask;
> > +	} else {
> > +		total = dw->rd_ch_cnt;
> > +		off = dw->wr_ch_cnt;
> > +		mask = dw_irq->rd_mask;
> > +	}
> > +
> > +	val = dw_edma_v0_core_status_abort_int(dw, dir);
> > +	val &= mask;
> > +	for_each_set_bit(pos, &val, total)
> > +		abort_cb(&dw->chan[pos + off]);
> > +}
> > +
> >  static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >  {
> >  	struct dw_edma_burst *child;
> > @@ -338,7 +390,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >  	SET_LL_64(&llp->llp.reg, chunk->ll_region.paddr);
> >  }
> >  
> > -void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > +static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  {
> >  	struct dw_edma_chan *chan = chunk->chan;
> >  	struct dw_edma *dw = chan->dw;
> > @@ -409,7 +461,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
> >  }
> >  
> > -int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
> > +static int dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
> >  {
> >  	struct dw_edma *dw = chan->dw;
> >  	u32 tmp = 0;
> > @@ -481,7 +533,25 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
> >  }
> >  
> >  /* eDMA debugfs callbacks */
> > -void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
> > +static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
> >  {
> >  	dw_edma_v0_debugfs_on(dw);
> >  }
> > +
> > +static const struct dw_edma_core_ops edma_core = {
> > +	.dw_xdma_core_off = dw_edma_v0_core_off,
> > +	.dw_xdma_core_ch_count = dw_edma_v0_core_ch_count,
> > +	.dw_xdma_core_ch_status = dw_edma_v0_core_ch_status,
> > +	.dw_xdma_core_clear_done_int = dw_edma_v0_core_clear_done_int,
> > +	.dw_xdma_core_clear_abort_int = dw_edma_v0_core_clear_abort_int,
> > +	.dw_xdma_core_done_handle = dw_edma_v0_core_done_handle,
> > +	.dw_xdma_core_abort_handle = dw_edma_v0_core_abort_handle,
> > +	.dw_xdma_core_start = dw_edma_v0_core_start,
> > +	.dw_xdma_core_ch_config = dw_edma_v0_core_ch_config,
> > +	.dw_xdma_core_debugfs_on = dw_edma_v0_core_debugfs_on,
> 
> dw_xdma_ctrl_xxx sounds more right for these
> 
> > +};
> > +
> > +void dw_edma_v0_core_register(struct dw_edma *dw)
> > +{
> > +	dw->core = &edma_core;
> > +}
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
> > index ab96a1f48080..972994ecc96f 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
> > @@ -11,17 +11,7 @@
> >  
> >  #include <linux/dma/edma.h>
> >  
> > -/* eDMA management callbacks */
> > -void dw_edma_v0_core_off(struct dw_edma *chan);
> > -u16 dw_edma_v0_core_ch_count(struct dw_edma *chan, enum dw_edma_dir dir);
> > -enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan);
> > -void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan);
> > -void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan);
> > -u32 dw_edma_v0_core_status_done_int(struct dw_edma *chan, enum dw_edma_dir dir);
> > -u32 dw_edma_v0_core_status_abort_int(struct dw_edma *chan, enum dw_edma_dir dir);
> > -void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
> > -int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
> > -/* eDMA debug fs callbacks */
> > -void dw_edma_v0_core_debugfs_on(struct dw_edma *dw);
> > +/* eDMA core operation register*/
> > +void dw_edma_v0_core_register(struct dw_edma *dw);
> >  
> >  #endif /* _DW_EDMA_V0_CORE_H */
> > -- 
> > 2.25.1
> 
> -- 
> ~Vinod
