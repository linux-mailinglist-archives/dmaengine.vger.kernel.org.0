Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A3F5AC896
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 03:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiIEBwU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Sep 2022 21:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiIEBwU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Sep 2022 21:52:20 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1202612F;
        Sun,  4 Sep 2022 18:52:16 -0700 (PDT)
Date:   Mon, 5 Sep 2022 09:51:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662342734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4nQsa3oiaIk/YUVTcvYYLKtT19SsbfAZHWkL3C6xYrQ=;
        b=gYgq7bv3L/B0qCBV33aRENTZfVRHAcPHQTpihvJ4+cfR61hCpOlPqf1qX9tWvbDnonpJC1
        8Hs6ahHyt6o88zCSHPOeUSFEWHm3Lsuf5wFbXcMSCM2+D/YCuzt0vC/8mS8+YhTn61U8N6
        qh2VCnCLU7V+iVGb6sE4an7qyBfZfRw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <20220905015148.GA8139@chq-T47>
References: <20220824140146.29140-1-cai.huoqing@linux.dev>
 <20220830042422.GA11576@chq-T47>
 <20220902230203.2bkh5zapfi3ae6v2@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220902230203.2bkh5zapfi3ae6v2@mobilestation>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03 9月 22 02:02:03, Serge Semin wrote:
> Hello Cai
> 
> On Tue, Aug 30, 2022 at 12:24:22PM +0800, Cai Huoqing wrote:
> > On 24 8月 22 22:01:44, Cai Huoqing wrote:
> > > Add support for HDMA NATIVE, as long the IP design has set
> > > the compatible register map parameter-HDMA_NATIVE,
> > > which allows compatibility for native HDMA register configuration.
> > > 
> > > The HDMA Hyper-DMA IP is an enhancement of the eDMA embedded-DMA IP.
> > > And the native HDMA registers are different from eDMA,
> > > so this patch add support for HDMA NATIVE mode
> > Just ping this patch
> 
> Thanks for the patchset. I have much doubts the driver maintainer
> will pop up any time soon. My series has been on review for over
> six months now. No messages from Gustavo have been received. I'll have
> a look at your patch on the next week (or after it). Meanwhile could
> you please rebase it on top of another DW eDMA-related series:
> Link: https://lore.kernel.org/linux-pci/20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru/
> and
> Link: https://lore.kernel.org/dmaengine/20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru/
> ?
> The later patchset is at the final stage of review process. So you'll
> need to have your work based on it anyway. After it's done just make
> sure the driver still work and add a note to the patch log that your
> patch is based on that patchset. Don't forget to add me to the Cc list
> of next revision of your patch so I would be notified when you
> resubmit it.
> 
> -Sergey
Hi Sergey, thanks for your reply.
I will rebase my patch and resend it.
For NATIVE HDMA mode, I think it could added to dw-edma(like my patch)
instead of creating a new dma driver, dw-hdma.. do you agree it? 

Thanks 
Cai
> 
> > > 
> > > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> > > ---
> > >  drivers/dma/dw-edma/Makefile             |   4 +-
> > >  drivers/dma/dw-edma/dw-edma-core.c       | 116 ++++++++---
> > >  drivers/dma/dw-edma/dw-edma-pcie.c       |   5 +-
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c    |   3 +
> > >  drivers/dma/dw-edma/dw-hdma-v0-core.c    | 236 +++++++++++++++++++++++
> > >  drivers/dma/dw-edma/dw-hdma-v0-core.h    |  27 +++
> > >  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 167 ++++++++++++++++
> > >  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h |  25 +++
> > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h    |  94 +++++++++
> > >  include/linux/dma/edma.h                 |   3 +-
> > >  10 files changed, 646 insertions(+), 34 deletions(-)
> > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
> > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
> > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > 
> > > diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
> > > index 8d45c0d5689d..95c5ae760a64 100644
> > > --- a/drivers/dma/dw-edma/Makefile
> > > +++ b/drivers/dma/dw-edma/Makefile
> > > @@ -1,7 +1,9 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  
> > >  obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
> > > -dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o
> > > +dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o \
> > > +							   dw-hdma-v0-debugfs.o
> > >  dw-edma-objs			:= dw-edma-core.o \
> > > +						   dw-hdma-v0-core.o \
> > >  					dw-edma-v0-core.o $(dw-edma-y)
> > >  obj-$(CONFIG_DW_EDMA_PCIE)	+= dw-edma-pcie.o
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > index 07f756479663..f0e44cb810d0 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -19,6 +19,7 @@
> > >  
> > >  #include "dw-edma-core.h"
> > >  #include "dw-edma-v0-core.h"
> > > +#include "dw-hdma-v0-core.h"
> > >  #include "../dmaengine.h"
> > >  #include "../virt-dma.h"
> > >  
> > > @@ -176,6 +177,7 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
> > >  	struct dw_edma_chunk *child;
> > >  	struct dw_edma_desc *desc;
> > >  	struct virt_dma_desc *vd;
> > > +	struct dw_edma *dw = chan->dw;
> > >  
> > >  	vd = vchan_next_desc(&chan->vc);
> > >  	if (!vd)
> > > @@ -190,7 +192,11 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
> > >  	if (!child)
> > >  		return;
> > >  
> > > -	dw_edma_v0_core_start(child, !desc->xfer_sz);
> > > +	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> > > +		dw_hdma_v0_core_start(child, !desc->xfer_sz);
> > > +	else
> > > +		dw_edma_v0_core_start(child, !desc->xfer_sz);
> > > +
> > >  	desc->xfer_sz += child->ll_region.sz;
> > >  	dw_edma_free_burst(child);
> > >  	list_del(&child->list);
> > > @@ -248,8 +254,15 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
> > >  static int dw_edma_device_terminate_all(struct dma_chan *dchan)
> > >  {
> > >  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > +	struct dw_edma *dw = chan->dw;
> > > +	enum dma_status status;
> > >  	int err = 0;
> > >  
> > > +	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> > > +		status = dw_hdma_v0_core_ch_status(chan);
> > > +	else
> > > +		status = dw_edma_v0_core_ch_status(chan);
> > > +
> > >  	if (!chan->configured) {
> > >  		/* Do nothing */
> > >  	} else if (chan->status == EDMA_ST_PAUSE) {
> > > @@ -257,7 +270,7 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
> > >  		chan->configured = false;
> > >  	} else if (chan->status == EDMA_ST_IDLE) {
> > >  		chan->configured = false;
> > > -	} else if (dw_edma_v0_core_ch_status(chan) == DMA_COMPLETE) {
> > > +	} else if (status == DMA_COMPLETE) {
> > >  		/*
> > >  		 * The channel is in a false BUSY state, probably didn't
> > >  		 * receive or lost an interrupt
> > > @@ -557,11 +570,15 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
> > >  
> > >  static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> > >  {
> > > +	struct dw_edma *dw = chan->dw;
> > >  	struct dw_edma_desc *desc;
> > >  	struct virt_dma_desc *vd;
> > >  	unsigned long flags;
> > >  
> > > -	dw_edma_v0_core_clear_done_int(chan);
> > > +	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> > > +		dw_hdma_v0_core_clear_done_int(chan);
> > > +	else
> > > +		dw_edma_v0_core_clear_done_int(chan);
> > >  
> > >  	spin_lock_irqsave(&chan->vc.lock, flags);
> > >  	vd = vchan_next_desc(&chan->vc);
> > > @@ -601,9 +618,13 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> > >  static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
> > >  {
> > >  	struct virt_dma_desc *vd;
> > > +	struct dw_edma *dw = chan->dw;
> > >  	unsigned long flags;
> > >  
> > > -	dw_edma_v0_core_clear_abort_int(chan);
> > > +	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> > > +		dw_hdma_v0_core_clear_abort_int(chan);
> > > +	else
> > > +		dw_edma_v0_core_clear_abort_int(chan);
> > >  
> > >  	spin_lock_irqsave(&chan->vc.lock, flags);
> > >  	vd = vchan_next_desc(&chan->vc);
> > > @@ -620,9 +641,8 @@ static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
> > >  {
> > >  	struct dw_edma_irq *dw_irq = data;
> > >  	struct dw_edma *dw = dw_irq->dw;
> > > -	unsigned long total, pos, val;
> > > +	unsigned long total, pos, val, mask;
> > >  	unsigned long off;
> > > -	u32 mask;
> > >  
> > >  	if (write) {
> > >  		total = dw->wr_ch_cnt;
> > > @@ -634,24 +654,36 @@ static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
> > >  		mask = dw_irq->rd_mask;
> > >  	}
> > >  
> > > -	val = dw_edma_v0_core_status_done_int(dw, write ?
> > > -							  EDMA_DIR_WRITE :
> > > -							  EDMA_DIR_READ);
> > > -	val &= mask;
> > > -	for_each_set_bit(pos, &val, total) {
> > > -		struct dw_edma_chan *chan = &dw->chan[pos + off];
> > > +	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
> > > +		for_each_set_bit(pos, &mask, total) {
> > > +			struct dw_edma_chan *chan = &dw->chan[pos + off];
> > >  
> > > -		dw_edma_done_interrupt(chan);
> > > -	}
> > > +			val = dw_hdma_v0_core_status_int(chan);
> > > +			if (dw_hdma_v0_core_check_done_int(val))
> > > +				dw_edma_done_interrupt(chan);
> > > +			if (dw_hdma_v0_core_check_abort_int(val))
> > > +				dw_edma_abort_interrupt(chan);
> > > +		}
> > > +	} else {
> > > +		val = dw_edma_v0_core_status_done_int(dw, write ?
> > > +								EDMA_DIR_WRITE :
> > > +								EDMA_DIR_READ);
> > > +		val &= mask;
> > > +		for_each_set_bit(pos, &val, total) {
> > > +			struct dw_edma_chan *chan = &dw->chan[pos + off];
> > > +
> > > +			dw_edma_done_interrupt(chan);
> > > +		}
> > >  
> > > -	val = dw_edma_v0_core_status_abort_int(dw, write ?
> > > -							   EDMA_DIR_WRITE :
> > > -							   EDMA_DIR_READ);
> > > -	val &= mask;
> > > -	for_each_set_bit(pos, &val, total) {
> > > -		struct dw_edma_chan *chan = &dw->chan[pos + off];
> > > +		val = dw_edma_v0_core_status_abort_int(dw, write ?
> > > +								EDMA_DIR_WRITE :
> > > +								EDMA_DIR_READ);
> > > +		val &= mask;
> > > +		for_each_set_bit(pos, &val, total) {
> > > +			struct dw_edma_chan *chan = &dw->chan[pos + off];
> > >  
> > > -		dw_edma_abort_interrupt(chan);
> > > +			dw_edma_abort_interrupt(chan);
> > > +		}
> > >  	}
> > >  
> > >  	return IRQ_HANDLED;
> > > @@ -794,7 +826,10 @@ static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
> > >  			dt_region->sz = chip->dt_region_rd[j].sz;
> > >  		}
> > >  
> > > -		dw_edma_v0_core_device_config(chan);
> > > +		if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> > > +			dw_hdma_v0_core_device_config(chan);
> > > +		else
> > > +			dw_edma_v0_core_device_config(chan);
> > >  	}
> > >  
> > >  	/* Set DMA channel capabilities */
> > > @@ -937,13 +972,23 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> > >  
> > >  	raw_spin_lock_init(&dw->lock);
> > >  
> > > -	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> > > -			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
> > > -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> > > +	if (chip->mf == EDMA_MF_HDMA_NATIVE) {
> > > +		dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> > > +					dw_hdma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
> > > +		dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> > >  
> > > -	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> > > -			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
> > > -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> > > +		dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> > > +					dw_hdma_v0_core_ch_count(dw, EDMA_DIR_READ));
> > > +		dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> > > +	} else {
> > > +		dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> > > +					dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
> > > +		dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> > > +
> > > +		dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> > > +					dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
> > > +		dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> > > +	}
> > >  
> > >  	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
> > >  		return -EINVAL;
> > > @@ -960,7 +1005,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> > >  	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%d", chip->id);
> > >  
> > >  	/* Disable eDMA, only to establish the ideal initial conditions */
> > > -	dw_edma_v0_core_off(dw);
> > > +	if (chip->mf == EDMA_MF_HDMA_NATIVE)
> > > +		dw_hdma_v0_core_off(dw);
> > > +	else
> > > +		dw_edma_v0_core_off(dw);
> > >  
> > >  	/* Request IRQs */
> > >  	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
> > > @@ -981,7 +1029,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> > >  	pm_runtime_enable(dev);
> > >  
> > >  	/* Turn debugfs on */
> > > -	dw_edma_v0_core_debugfs_on(dw);
> > > +	if (chip->mf == EDMA_MF_HDMA_NATIVE)
> > > +		dw_hdma_v0_core_debugfs_on(dw);
> > > +	else
> > > +		dw_edma_v0_core_debugfs_on(dw);
> > >  
> > >  	chip->dw = dw;
> > >  
> > > @@ -1028,7 +1079,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> > >  	}
> > >  
> > >  	/* Turn debugfs off */
> > > -	dw_edma_v0_core_debugfs_off(dw);
> > > +	if (chip->mf == EDMA_MF_HDMA_NATIVE)
> > > +		dw_hdma_v0_core_debugfs_off(dw);
> > > +	else
> > > +		dw_edma_v0_core_debugfs_off(dw);
> > >  
> > >  	return 0;
> > >  }
> > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > index d6b5e2463884..7cd2e045325d 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > @@ -121,7 +121,8 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > >  	map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
> > >  	if (map != EDMA_MF_EDMA_LEGACY &&
> > >  	    map != EDMA_MF_EDMA_UNROLL &&
> > > -	    map != EDMA_MF_HDMA_COMPAT)
> > > +	    map != EDMA_MF_HDMA_COMPAT &&
> > > +		map != EDMA_MF_HDMA_NATIVE)
> > >  		return;
> > >  
> > >  	pdata->mf = map;
> > > @@ -277,6 +278,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >  		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", chip->mf);
> > >  	else if (chip->mf == EDMA_MF_HDMA_COMPAT)
> > >  		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", chip->mf);
> > > +	else if (chip->mf == EDMA_MF_HDMA_NATIVE)
> > > +		pci_dbg(pdev, "Version:\tHDMA Native (0x%x)\n", chip->mf);
> > >  	else
> > >  		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
> > >  
> > > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > index 77e6cfe52e0a..167a2c4144dd 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > @@ -12,6 +12,9 @@
> > >  #include "dw-edma-v0-core.h"
> > >  #include "dw-edma-v0-regs.h"
> > >  #include "dw-edma-v0-debugfs.h"
> > > +#include "dw-hdma-v0-core.h"
> > > +#include "dw-hdma-v0-regs.h"
> > > +#include "dw-hdma-v0-debugfs.h"
> > >  
> > >  enum dw_edma_control {
> > >  	DW_EDMA_V0_CB					= BIT(0),
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > new file mode 100644
> > > index 000000000000..cd4746d98839
> > > --- /dev/null
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > @@ -0,0 +1,236 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2022 Cai Huoqing
> > > + * Synopsys DesignWare HDMA v0 core
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +
> > > +#include "dw-edma-core.h"
> > > +#include "dw-edma-v0-core.h"
> > > +#include "dw-edma-v0-regs.h"
> > > +#include "dw-hdma-v0-core.h"
> > > +#include "dw-hdma-v0-regs.h"
> > > +#include "dw-hdma-v0-debugfs.h"
> > > +
> > > +enum dw_hdma_control {
> > > +	DW_HDMA_V0_CB					= BIT(0),
> > > +	DW_HDMA_V0_TCB					= BIT(1),
> > > +	DW_HDMA_V0_LLP					= BIT(2),
> > > +	DW_HDMA_V0_LIE					= BIT(3),
> > > +	DW_HDMA_V0_RIE					= BIT(4),
> > > +	DW_HDMA_V0_CCS					= BIT(8),
> > > +	DW_HDMA_V0_LLE					= BIT(9),
> > > +};
> > > +static inline struct dw_hdma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
> > > +{
> > > +	return dw->chip->reg_base;
> > > +}
> > > +
> > > +static inline struct dw_hdma_v0_ch_regs __iomem *
> > > +__dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
> > > +{
> > > +
> > > +	if (dir == EDMA_DIR_WRITE)
> > > +		return &(__dw_regs(dw)->ch[ch].wr);
> > > +	else
> > > +		return &(__dw_regs(dw)->ch[ch].rd);
> > > +}
> > > +
> > > +#define SET_CH_32(dw, dir, ch, name, value) \
> > > +	writel(value, &(__dw_ch_regs(dw, dir, ch)->name))
> > > +
> > > +#define GET_CH_32(dw, dir, ch, name) \
> > > +	readl(&(__dw_ch_regs(dw, dir, ch)->name))
> > > +
> > > +#define SET_BOTH_CH_32(dw, ch, name, value) \
> > > +	do {					\
> > > +		writel(value, &(__dw_ch_regs(dw, EDMA_DIR_WRITE, ch)->name));		\
> > > +		writel(value, &(__dw_ch_regs(dw, EDMA_DIR_READ, ch)->name));	\
> > > +	} while (0)
> > > +
> > > +#define SET_LL_32(ll, value) \
> > > +	writel(value, ll)
> > > +
> > > +/* HDMA management callbacks */
> > > +void dw_hdma_v0_core_off(struct dw_edma *dw)
> > > +{
> > > +	int id;
> > > +
> > > +	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
> > > +		SET_BOTH_CH_32(dw, id, int_setup,
> > > +				HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> > > +		SET_BOTH_CH_32(dw, id, int_clear,
> > > +				HDMA_V0_STOP_INT_MASK & HDMA_V0_ABORT_INT_MASK);
> > > +		SET_BOTH_CH_32(dw, id, ch_en, 0);
> > > +	}
> > > +}
> > > +
> > > +u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> > > +{
> > > +	u32 num_ch = 0;
> > > +	int id;
> > > +
> > > +	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
> > > +		if (GET_CH_32(dw, id, dir, ch_en) & BIT(0))
> > > +			num_ch++;
> > > +	}
> > > +
> > > +	if (num_ch > HDMA_V0_MAX_NR_CH)
> > > +		num_ch = HDMA_V0_MAX_NR_CH;
> > > +
> > > +	return (u16)num_ch;
> > > +}
> > > +
> > > +enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
> > > +{
> > > +	struct dw_edma *dw = chan->dw;
> > > +	u32 tmp;
> > > +
> > > +	tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
> > > +			GET_CH_32(dw, chan->id, chan->dir, ch_stat));
> > > +
> > > +	if (tmp == 1)
> > > +		return DMA_IN_PROGRESS;
> > > +	else if (tmp == 3)
> > > +		return DMA_COMPLETE;
> > > +	else
> > > +		return DMA_ERROR;
> > > +}
> > > +
> > > +void dw_hdma_v0_core_clear_done_int(struct dw_edma_chan *chan)
> > > +{
> > > +	struct dw_edma *dw = chan->dw;
> > > +
> > > +	SET_CH_32(dw, chan->dir, chan->id, int_clear, HDMA_V0_STOP_INT_MASK);
> > > +}
> > > +
> > > +void dw_hdma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
> > > +{
> > > +	struct dw_edma *dw = chan->dw;
> > > +
> > > +	SET_CH_32(dw, chan->dir, chan->id, int_clear, HDMA_V0_ABORT_INT_MASK);
> > > +}
> > > +
> > > +u32 dw_hdma_v0_core_status_int(struct dw_edma_chan *chan)
> > > +{
> > > +	struct dw_edma *dw = chan->dw;
> > > +
> > > +	return GET_CH_32(dw, chan->dir, chan->id, int_stat);
> > > +}
> > > +
> > > +u32 dw_hdma_v0_core_check_done_int(u32 val)
> > > +{
> > > +	return (FIELD_GET(HDMA_V0_STOP_INT_MASK, val) == BIT(0));
> > > +}
> > > +
> > > +u32 dw_hdma_v0_core_check_abort_int(u32 val)
> > > +{
> > > +	return (FIELD_GET(HDMA_V0_ABORT_INT_MASK, val) == BIT(0));
> > > +}
> > > +
> > > +static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> > > +{
> > > +	struct dw_edma_burst *child;
> > > +	struct dw_edma_chan *chan = chunk->chan;
> > > +	struct dw_edma_v0_lli __iomem *lli;
> > > +	struct dw_edma_v0_llp __iomem *llp;
> > > +	u32 control = 0, i = 0;
> > > +	int j;
> > > +
> > > +	lli = chunk->ll_region.vaddr;
> > > +
> > > +	if (chunk->cb)
> > > +		control = DW_HDMA_V0_CB;
> > > +
> > > +	j = chunk->bursts_alloc;
> > > +	list_for_each_entry(child, &chunk->burst->list, list) {
> > > +		j--;
> > > +		if (!j) {
> > > +			control |= DW_HDMA_V0_LIE;
> > > +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > +				control |= DW_HDMA_V0_RIE;
> > > +		}
> > > +		/* Channel control */
> > > +		SET_LL_32(&lli[i].control, control);
> > > +		/* Transfer size */
> > > +		SET_LL_32(&lli[i].transfer_size, child->sz);
> > > +		/* SAR */
> > > +		SET_LL_32(&lli[i].sar.lsb, lower_32_bits(child->sar));
> > > +		SET_LL_32(&lli[i].sar.msb, upper_32_bits(child->sar));
> > > +		/* DAR */
> > > +		SET_LL_32(&lli[i].dar.lsb, lower_32_bits(child->dar));
> > > +		SET_LL_32(&lli[i].dar.msb, upper_32_bits(child->dar));
> > > +		i++;
> > > +	}
> > > +
> > > +	llp = (void __iomem *)&lli[i];
> > > +	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
> > > +	if (!chunk->cb)
> > > +		control |= DW_HDMA_V0_CB;
> > > +
> > > +	/* Channel control */
> > > +	SET_LL_32(&llp->control, control);
> > > +	/* Linked list */
> > > +	SET_LL_32(&llp->llp.lsb, lower_32_bits(chunk->ll_region.paddr));
> > > +	SET_LL_32(&llp->llp.msb, upper_32_bits(chunk->ll_region.paddr));
> > > +}
> > > +
> > > +void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > > +{
> > > +	struct dw_edma_chan *chan = chunk->chan;
> > > +	struct dw_edma *dw = chan->dw;
> > > +	u32 tmp;
> > > +
> > > +	dw_hdma_v0_core_write_chunk(chunk);
> > > +
> > > +	if (first) {
> > > +		/* Enable engine */
> > > +		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
> > > +		/* Interrupt enable&unmask - done, abort */
> > > +		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
> > > +		tmp |= HDMA_V0_STOP_INT_MASK;
> > > +		tmp |= HDMA_V0_ABORT_INT_MASK;
> > > +		tmp |= HDMA_V0_LOCAL_ABORT_INT_EN;
> > > +		tmp |= HDMA_V0_LOCAL_STOP_INT_EN;
> > > +		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
> > > +		/* Channel control */
> > > +		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
> > > +		/* Linked list */
> > > +		/* llp is not aligned on 64bit -> keep 32bit accesses */
> > > +		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
> > > +			  lower_32_bits(chunk->ll_region.paddr));
> > > +		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
> > > +			  upper_32_bits(chunk->ll_region.paddr));
> > > +	}
> > > +	/* Doorbell */
> > > +	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
> > > +}
> > > +
> > > +int dw_hdma_v0_core_device_config(struct dw_edma_chan *chan)
> > > +{
> > > +	struct dw_edma *dw = chan->dw;
> > > +
> > > +	/* MSI done addr - low, high */
> > > +	SET_CH_32(dw, chan->dir, chan->id, msi_stop.lsb, chan->msi.address_lo);
> > > +	SET_CH_32(dw, chan->dir, chan->id, msi_stop.msb, chan->msi.address_hi);
> > > +	/* MSI abort addr - low, high */
> > > +	SET_CH_32(dw, chan->dir, chan->id, msi_abort.lsb, chan->msi.address_lo);
> > > +	SET_CH_32(dw, chan->dir, chan->id, msi_abort.msb, chan->msi.address_hi);
> > > +	SET_CH_32(dw, chan->dir, chan->id, msi_abort.msb, chan->msi.address_hi);
> > > +	/* config MSI data */
> > > +	SET_CH_32(dw, chan->dir, chan->id, msi_msgdata, chan->msi.data);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/* eDMA debugfs callbacks */
> > > +void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
> > > +{
> > > +	dw_hdma_v0_debugfs_on(dw);
> > > +}
> > > +
> > > +void dw_hdma_v0_core_debugfs_off(struct dw_edma *dw)
> > > +{
> > > +	dw_hdma_v0_debugfs_off(dw);
> > > +}
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.h b/drivers/dma/dw-edma/dw-hdma-v0-core.h
> > > new file mode 100644
> > > index 000000000000..61d3a6d9d024
> > > --- /dev/null
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.h
> > > @@ -0,0 +1,27 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (c) 2022 Cai Huoqing
> > > + * Synopsys DesignWare eDMA v0 core
> > > + */
> > > +
> > > +#ifndef _DW_HDMA_V0_CORE_H
> > > +#define _DW_HDMA_V0_CORE_H
> > > +
> > > +#include <linux/dma/edma.h>
> > > +
> > > +/* HDMA management callbacks */
> > > +void dw_hdma_v0_core_off(struct dw_edma *chan);
> > > +u16 dw_hdma_v0_core_ch_count(struct dw_edma *chan, enum dw_edma_dir dir);
> > > +enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan);
> > > +void dw_hdma_v0_core_clear_done_int(struct dw_edma_chan *chan);
> > > +void dw_hdma_v0_core_clear_abort_int(struct dw_edma_chan *chan);
> > > +u32 dw_hdma_v0_core_status_int(struct dw_edma_chan *chan);
> > > +u32 dw_hdma_v0_core_check_done_int(u32 val);
> > > +u32 dw_hdma_v0_core_check_abort_int(u32 val);
> > > +void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
> > > +int dw_hdma_v0_core_device_config(struct dw_edma_chan *chan);
> > > +/* HDMA debug fs callbacks */
> > > +void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw);
> > > +void dw_hdma_v0_core_debugfs_off(struct dw_edma *dw);
> > > +
> > > +#endif /* _DW_HDMA_V0_CORE_H */
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> > > new file mode 100644
> > > index 000000000000..2f1ddac9513b
> > > --- /dev/null
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> > > @@ -0,0 +1,167 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2022 Cai Huoqing
> > > + * Synopsys DesignWare HDMA v0 debugfs
> > > + */
> > > +
> > > +#include <linux/debugfs.h>
> > > +#include <linux/bitfield.h>
> > > +
> > > +#include "dw-hdma-v0-debugfs.h"
> > > +#include "dw-hdma-v0-regs.h"
> > > +#include "dw-edma-core.h"
> > > +
> > > +#define REGS_ADDR(name) \
> > > +	((void __force *)&regs->name)
> > > +
> > > +#define REGISTER(name) \
> > > +	{ #name, REGS_ADDR(name) }
> > > +
> > > +#define WRITE_STR				"write"
> > > +#define READ_STR				"read"
> > > +#define CHANNEL_STR				"channel"
> > > +#define REGISTERS_STR				"registers"
> > > +
> > > +static struct dw_edma				*dw;
> > > +static struct dw_hdma_v0_regs			__iomem *regs;
> > > +struct debugfs_entries {
> > > +	const char				*name;
> > > +	dma_addr_t				*reg;
> > > +};
> > > +
> > > +static int dw_hdma_debugfs_u32_get(void *data, u64 *val)
> > > +{
> > > +	void __iomem *reg = (void __force __iomem *)data;
> > > +	*val = readl(reg);
> > > +
> > > +	return 0;
> > > +}
> > > +DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_hdma_debugfs_u32_get, NULL, "0x%08llx\n");
> > > +
> > > +static void dw_hdma_debugfs_create_x32(const struct debugfs_entries entries[],
> > > +				       int nr_entries, struct dentry *dir)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < nr_entries; i++) {
> > > +		if (!debugfs_create_file_unsafe(entries[i].name, 0444, dir,
> > > +						entries[i].reg,	&fops_x32))
> > > +			break;
> > > +	}
> > > +}
> > > +
> > > +static void dw_hdma_debugfs_regs_ch(struct dw_hdma_v0_ch_regs __iomem *regs,
> > > +				    struct dentry *dir)
> > > +{
> > > +	int nr_entries;
> > > +	const struct debugfs_entries debugfs_regs[] = {
> > > +		REGISTER(ch_en),
> > > +		REGISTER(doorbell),
> > > +		REGISTER(llp.lsb),
> > > +		REGISTER(llp.msb),
> > > +		REGISTER(cycle_sync),
> > > +		REGISTER(transfer_size),
> > > +		REGISTER(sar.lsb),
> > > +		REGISTER(sar.msb),
> > > +		REGISTER(dar.lsb),
> > > +		REGISTER(dar.msb),
> > > +		REGISTER(control1),
> > > +		REGISTER(ch_stat),
> > > +		REGISTER(int_stat),
> > > +		REGISTER(int_setup),
> > > +		REGISTER(int_clear),
> > > +		REGISTER(msi_stop.lsb),
> > > +		REGISTER(msi_stop.msb),
> > > +		REGISTER(msi_abort.lsb),
> > > +		REGISTER(msi_abort.msb),
> > > +		REGISTER(msi_msgdata),
> > > +	};
> > > +
> > > +	nr_entries = ARRAY_SIZE(debugfs_regs);
> > > +	dw_hdma_debugfs_create_x32(debugfs_regs, nr_entries, dir);
> > > +}
> > > +
> > > +static void dw_hdma_debugfs_regs_wr(struct dentry *dir)
> > > +{
> > > +	struct dentry *regs_dir, *ch_dir;
> > > +	int i;
> > > +	char name[16];
> > > +
> > > +	regs_dir = debugfs_create_dir(WRITE_STR, dir);
> > > +	if (!regs_dir)
> > > +		return;
> > > +
> > > +	for (i = 0; i < dw->wr_ch_cnt; i++) {
> > > +		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
> > > +
> > > +		ch_dir = debugfs_create_dir(name, regs_dir);
> > > +		if (!ch_dir)
> > > +			return;
> > > +
> > > +		dw_hdma_debugfs_regs_ch(&regs->ch[i].wr, ch_dir);
> > > +	}
> > > +}
> > > +
> > > +static void dw_hdma_debugfs_regs_rd(struct dentry *dir)
> > > +{
> > > +	struct dentry *regs_dir, *ch_dir;
> > > +	int i;
> > > +	char name[16];
> > > +
> > > +	regs_dir = debugfs_create_dir(READ_STR, dir);
> > > +	if (!regs_dir)
> > > +		return;
> > > +
> > > +	for (i = 0; i < dw->rd_ch_cnt; i++) {
> > > +		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
> > > +
> > > +		ch_dir = debugfs_create_dir(name, regs_dir);
> > > +		if (!ch_dir)
> > > +			return;
> > > +
> > > +		dw_hdma_debugfs_regs_ch(&regs->ch[i].rd, ch_dir);
> > > +	}
> > > +}
> > > +
> > > +static void dw_hdma_debugfs_regs(void)
> > > +{
> > > +	struct dentry *regs_dir;
> > > +
> > > +	regs_dir = debugfs_create_dir(REGISTERS_STR, dw->debugfs);
> > > +	if (!regs_dir)
> > > +		return;
> > > +
> > > +	dw_hdma_debugfs_regs_wr(regs_dir);
> > > +	dw_hdma_debugfs_regs_rd(regs_dir);
> > > +}
> > > +
> > > +void dw_hdma_v0_debugfs_on(struct dw_edma *_dw)
> > > +{
> > > +	dw = _dw;
> > > +	if (!dw)
> > > +		return;
> > > +
> > > +	regs = dw->chip->reg_base;
> > > +	if (!regs)
> > > +		return;
> > > +
> > > +	dw->debugfs = debugfs_create_dir(dw->name, NULL);
> > > +	if (!dw->debugfs)
> > > +		return;
> > > +
> > > +	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->chip->mf);
> > > +	debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
> > > +	debugfs_create_u16("rd_ch_cnt", 0444, dw->debugfs, &dw->rd_ch_cnt);
> > > +
> > > +	dw_hdma_debugfs_regs();
> > > +}
> > > +
> > > +void dw_hdma_v0_debugfs_off(struct dw_edma *_dw)
> > > +{
> > > +	dw = _dw;
> > > +	if (!dw)
> > > +		return;
> > > +
> > > +	debugfs_remove_recursive(dw->debugfs);
> > > +	dw->debugfs = NULL;
> > > +}
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.h b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> > > new file mode 100644
> > > index 000000000000..53bc7e93f4a0
> > > --- /dev/null
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> > > @@ -0,0 +1,25 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (c) 2022 Cai Huoqing
> > > + * Synopsys DesignWare HDMA v0 debugfs
> > > + */
> > > +
> > > +#ifndef _DW_HDMA_V0_DEBUG_FS_H
> > > +#define _DW_HDMA_V0_DEBUG_FS_H
> > > +
> > > +#include <linux/dma/edma.h>
> > > +
> > > +#ifdef CONFIG_DEBUG_FS
> > > +void dw_hdma_v0_debugfs_on(struct dw_edma *dw);
> > > +void dw_hdma_v0_debugfs_off(struct dw_edma *dw);
> > > +#else
> > > +static inline void dw_hdma_v0_debugfs_on(struct dw_edma *dw)
> > > +{
> > > +}
> > > +
> > > +static inline void dw_hdma_v0_debugfs_off(struct dw_edma *dw)
> > > +{
> > > +}
> > > +#endif /* CONFIG_DEBUG_FS */
> > > +
> > > +#endif /* _DW_HDMA_V0_DEBUG_FS_H */
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > new file mode 100644
> > > index 000000000000..2a2a3620d809
> > > --- /dev/null
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > @@ -0,0 +1,94 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (c) 2022 Cai Huoqing
> > > + * Synopsys DesignWare HDMA v0 reg
> > > + */
> > > +
> > > +#ifndef _DW_HDMA_V0_REGS_H
> > > +#define _DW_HDMA_V0_REGS_H
> > > +
> > > +#include <linux/dmaengine.h>
> > > +
> > > +#define HDMA_V0_MAX_NR_CH					8
> > > +#define HDMA_V0_LOCAL_ABORT_INT_EN			BIT(6)
> > > +#define HDMA_V0_REMOTE_ABORT_INT_EN			BIT(5)
> > > +#define HDMA_V0_LOCAL_STOP_INT_EN			BIT(4)
> > > +#define HDMA_V0_REMOTEL_STOP_INT_EN			BIT(3)
> > > +#define HDMA_V0_ABORT_INT_MASK				BIT(2)
> > > +#define HDMA_V0_STOP_INT_MASK				BIT(0)
> > > +#define HDMA_V0_LINKLIST_EN					BIT(0)
> > > +#define HDMA_V0_DOORBELL_START				BIT(0)
> > > +#define HDMA_V0_CH_STATUS_MASK				GENMASK(1, 0)
> > > +
> > > +struct dw_hdma_v0_ch_regs {
> > > +	u32 ch_en;					/* 0x0000 */
> > > +	u32 doorbell;				/* 0x0004 */
> > > +	u32 prefetch;				/* 0x0008 */
> > > +	u32 handshake;				/* 0x000c */
> > > +	union {
> > > +		u64 reg;				/* 0x0010..0x0014 */
> > > +		struct {
> > > +			u32 lsb;			/* 0x0010 */
> > > +			u32 msb;			/* 0x0014 */
> > > +		};
> > > +	} llp;
> > > +	u32 cycle_sync;				/* 0x0018 */
> > > +	u32 transfer_size;			/* 0x001c */
> > > +	union {
> > > +		u64 reg;				/* 0x0020..0x0024 */
> > > +		struct {
> > > +			u32 lsb;			/* 0x0020 */
> > > +			u32 msb;			/* 0x0024 */
> > > +		};
> > > +	} sar;
> > > +	union {
> > > +		u64 reg;				/* 0x0028..0x002c */
> > > +		struct {
> > > +			u32 lsb;			/* 0x0028 */
> > > +			u32 msb;			/* 0x002c */
> > > +		};
> > > +	} dar;
> > > +
> > > +	u32 watermark_en;			/* 0x0030 */
> > > +	u32	control1;				/* 0x0034 */
> > > +	u32	func_num;				/* 0x0038 */
> > > +	u32	qos;					/* 0x003c */
> > > +	u32	reserved;				/* 0x0040..0x007c */
> > > +	u32 ch_stat;				/* 0x0080 */
> > > +	u32 int_stat;				/* 0x0084 */
> > > +	u32 int_setup;				/* 0x0088 */
> > > +	u32 int_clear;				/* 0x008c */
> > > +	union {
> > > +		u64 reg;				/* 0x0090..0x0094 */
> > > +		struct {
> > > +			u32 lsb;			/* 0x0090 */
> > > +			u32 msb;			/* 0x0094 */
> > > +		};
> > > +	} msi_stop;
> > > +	union {
> > > +		u64 reg;				/* 0x0098..0x009c */
> > > +		struct {
> > > +			u32 lsb;			/* 0x0098 */
> > > +			u32 msb;			/* 0x009c */
> > > +		};
> > > +	} msi_watermark;
> > > +	union {
> > > +		u64 reg;				/* 0x00a0..0x00a4 */
> > > +		struct {
> > > +			u32 lsb;			/* 0x00a0 */
> > > +			u32 msb;			/* 0x00a4 */
> > > +		};
> > > +	} msi_abort;
> > > +	u32	msi_msgdata;			/* 0x00a8 */
> > > +} __packed;
> > > +
> > > +struct dw_hdma_v0_ch {
> > > +	struct dw_hdma_v0_ch_regs wr;			/* 0x0000 */
> > > +	struct dw_hdma_v0_ch_regs rd;			/* 0x0100 */
> > > +} __packed;
> > > +
> > > +struct dw_hdma_v0_regs {
> > > +	struct dw_hdma_v0_ch ch[HDMA_V0_MAX_NR_CH]; /* 0x0000..0x0fa8 */
> > > +} __packed;
> > > +
> > > +#endif /* _DW_HDMA_V0_REGS_H */
> > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > index 7d8062e9c544..a379b599c7fa 100644
> > > --- a/include/linux/dma/edma.h
> > > +++ b/include/linux/dma/edma.h
> > > @@ -30,7 +30,8 @@ struct dw_edma_core_ops {
> > >  enum dw_edma_map_format {
> > >  	EDMA_MF_EDMA_LEGACY = 0x0,
> > >  	EDMA_MF_EDMA_UNROLL = 0x1,
> > > -	EDMA_MF_HDMA_COMPAT = 0x5
> > > +	EDMA_MF_HDMA_COMPAT = 0x5,
> > > +	EDMA_MF_HDMA_NATIVE = 0x7
> > >  };
> > >  
> > >  /**
> > > -- 
> > > 2.25.1
> > > 
