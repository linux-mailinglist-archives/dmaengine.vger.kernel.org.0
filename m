Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECF82BBEDB
	for <lists+dmaengine@lfdr.de>; Sat, 21 Nov 2020 13:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgKUMRH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 21 Nov 2020 07:17:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbgKUMRG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 21 Nov 2020 07:17:06 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC93222226;
        Sat, 21 Nov 2020 12:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605961025;
        bh=CLnmJwu1qyLfSMMDkimhjgKa6ddTmVUxgKHdclcvknA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tpov4aTsM8kVAnl2bn/v7/48hpp/4UO7vVc5z2OOGrpqU8cfRrGxZ1wLfn+2LHN57
         q1kjoD0b1fwmF91i0SisCFZdlumJG+PAyOr+12g7iHcGsKwRpUMNTXG6jb6ES3ygMs
         ulf35z3aKMB87J5IoxXzQghzszEZf7Q6QUmsSdmg=
Date:   Sat, 21 Nov 2020 17:47:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: Re: [PATCH v9 2/2] Add Intel LGM SoC DMA support.
Message-ID: <20201121121701.GB8403@vkoul-mobl>
References: <cover.1605158930.git.mallikarjunax.reddy@linux.intel.com>
 <67be905aa3bcb9faac424f2a134e88d076700419.1605158930.git.mallikarjunax.reddy@linux.intel.com>
 <20201118173840.GW50232@vkoul-mobl>
 <a4ea240f-b121-5bc9-a046-95bbcff87553@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4ea240f-b121-5bc9-a046-95bbcff87553@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-11-20, 19:30, Reddy, MallikarjunaX wrote:
> Hi Vinod,
> 
> Thanks for the review. My comments inline.
> 
> On 11/19/2020 1:38 AM, Vinod Koul wrote:
> > On 12-11-20, 13:38, Amireddy Mallikarjuna reddy wrote:
> > > Add DMA controller driver for Lightning Mountain (LGM) family of SoCs.
> > > 
> > > The main function of the DMA controller is the transfer of data from/to any
> > > peripheral to/from the memory. A memory to memory copy capability can also
> > > be configured.
> > > 
> > > This ldma driver is used for configure the device and channnels for data
> > > and control paths.
> > > 
> > > Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
> > > ---
> > > v1:
> > > - Initial version.
> > You have a cover letter, use that to keep track of these changes
> ok.
> > 
> > > +++ b/drivers/dma/lgm/Kconfig
> > > @@ -0,0 +1,9 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +config INTEL_LDMA
> > > +	bool "Lightning Mountain centralized low speed DMA and high speed DMA controllers"
> > Do we have any other speeds :D
> No other speeds :-)

Right, so possibly drop the speed characterization here!

> > 
> > > +++ b/drivers/dma/lgm/lgm-dma.c
> > > @@ -0,0 +1,1742 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Lightning Mountain centralized low speed and high speed DMA controller driver
> > > + *
> > > + * Copyright (c) 2016 ~ 2020 Intel Corporation.
> > I think you mean 2016 - 2020, a dash which refers to duration
> ok.
> > 
> > > +struct dw2_desc {
> > > +	struct {
> > > +		u32 len		:16;
> > > +		u32 res0	:7;
> > > +		u32 bofs	:2;
> > > +		u32 res1	:3;
> > > +		u32 eop		:1;
> > > +		u32 sop		:1;
> > > +		u32 c		:1;
> > > +		u32 own		:1;
> > > +	} __packed field;
> > Another one, looks like folks adding dmaengine patches love this
> > approach, second one for the day..
> > 
> > Now why do you need the bit fields, why not use register defines and
> > helpers in bitfield.h to help configure the fields See FIELD_GET,
> > FIELD_PREP etc
> Let me check on this...
> > 
> > > +struct dma_dev_ops {
> > > +	int (*device_alloc_chan_resources)(struct dma_chan *chan);
> > > +	void (*device_free_chan_resources)(struct dma_chan *chan);
> > > +	int (*device_config)(struct dma_chan *chan,
> > > +			     struct dma_slave_config *config);
> > > +	int (*device_pause)(struct dma_chan *chan);
> > > +	int (*device_resume)(struct dma_chan *chan);
> > > +	int (*device_terminate_all)(struct dma_chan *chan);
> > > +	void (*device_synchronize)(struct dma_chan *chan);
> > > +	enum dma_status (*device_tx_status)(struct dma_chan *chan,
> > > +					    dma_cookie_t cookie,
> > > +					    struct dma_tx_state *txstate);
> > > +	struct dma_async_tx_descriptor *(*device_prep_slave_sg)
> > > +		(struct dma_chan *chan, struct scatterlist *sgl,
> > > +		unsigned int sg_len, enum dma_transfer_direction direction,
> > > +		unsigned long flags, void *context);
> > > +	void (*device_issue_pending)(struct dma_chan *chan);
> > > +};
> > Heh! why do you have a copy of dmaengine ops here?
> Ok, i will remove the ops and update the code accordingly.
> > 
> > > +static int ldma_chan_desc_cfg(struct ldma_chan *c, dma_addr_t desc_base,
> > > +			      int desc_num)
> > > +{
> > > +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
> > > +
> > > +	if (!desc_num) {
> > > +		dev_err(d->dev, "Channel %d must allocate descriptor first\n",
> > > +			c->nr);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (desc_num > DMA_MAX_DESC_NUM) {
> > > +		dev_err(d->dev, "Channel %d descriptor number out of range %d\n",
> > > +			c->nr, desc_num);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	ldma_chan_desc_hw_cfg(c, desc_base, desc_num);
> > > +
> > > +	c->flags |= DMA_HW_DESC;
> > > +	c->desc_cnt = desc_num;
> > > +	c->desc_phys = desc_base;
> > So you have a custom API which is used to configure this flag, a number
> > and an address. The question is why, can you please help explain this?
> LDMA used as general purpose dma(ver == DMA_VER22) and also supports DMA
> capability for GSWIP in their network packet processing.( ver > DMA_VER22)

Whats GSWIP?

> 
> Each Ingress(IGP) & Egress(EGP) ports of CQM use a dma channel.

CQM?

> desc needs to be configure for each dma channel and the remapped address of
> the IGP & EGP is desc base adress.

Why should this address not passed as src_addr/dst_addr?

> CQM client is using ldma_chan_desc_cfg() to configure the descriptior.
> > 
> > > +static void dma_issue_pending(struct dma_chan *chan)
> > > +{
> > > +	struct ldma_chan *c = to_ldma_chan(chan);
> > > +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
> > > +	unsigned long flags;
> > > +
> > > +	if (d->ver == DMA_VER22) {
> > why is this specific to this version?
> Only dma0 instance (ver == DMA_VER22) is used as a general purpose slave
> DMA. we set both control and datapath here.
> Other instances (ver > DMA_VER22) we set only control path. data path is
> taken care by dma client(GSWIP).
> Only thing needs to do is get the channel, set the descriptor and just 'ON'
> the channel.
> 
> CQM is highly low level register configurable/programmable take care about
> the the packet processing through the register configurations.

DMAengine fwk take care of channel management for clients and
transaction management, if you not going to do transactions then why
bother with dmaengine ?
-- 
~Vinod
