Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2CC2C2E59
	for <lists+dmaengine@lfdr.de>; Tue, 24 Nov 2020 18:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390140AbgKXRV4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Nov 2020 12:21:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731584AbgKXRVz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Nov 2020 12:21:55 -0500
Received: from localhost (unknown [122.167.149.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85412205CA;
        Tue, 24 Nov 2020 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606238514;
        bh=NFLNEtEKkm6DA/BKt8favXBq7vqHdsLR/QUSJ3kM8Pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzFylCtlA+mvCoLZPotT1ZU+Mlljqf4DXuvTCDbBboMynQ4alK/uQmiG8XQv5bP23
         rxDbZDdwMqVNzx5vGvE2I/fJL/WK+WdHhzh6dacNbo9onOOWGvqm5n0Fjhvarh/1Nu
         rCC3kE5c0k8AEOrBt9UTiQGLtgBafLrv7pVylwzc=
Date:   Tue, 24 Nov 2020 22:51:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: Re: [PATCH v9 2/2] Add Intel LGM SoC DMA support.
Message-ID: <20201124172149.GT8403@vkoul-mobl>
References: <cover.1605158930.git.mallikarjunax.reddy@linux.intel.com>
 <67be905aa3bcb9faac424f2a134e88d076700419.1605158930.git.mallikarjunax.reddy@linux.intel.com>
 <20201118173840.GW50232@vkoul-mobl>
 <a4ea240f-b121-5bc9-a046-95bbcff87553@linux.intel.com>
 <20201121121701.GB8403@vkoul-mobl>
 <dc8c5f27-bce6-d276-af0b-93c6e63e85a1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc8c5f27-bce6-d276-af0b-93c6e63e85a1@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-11-20, 00:29, Reddy, MallikarjunaX wrote:
> Hi Vinod,
> 
> Thanks for your valuable review comments. Please see my comments inline.
> 
> On 11/21/2020 8:17 PM, Vinod Koul wrote:
> > On 20-11-20, 19:30, Reddy, MallikarjunaX wrote:
> > > Hi Vinod,
> > > 
> > > Thanks for the review. My comments inline.
> > > 
> > > On 11/19/2020 1:38 AM, Vinod Koul wrote:
> > > > On 12-11-20, 13:38, Amireddy Mallikarjuna reddy wrote:
> > > > > Add DMA controller driver for Lightning Mountain (LGM) family of SoCs.
> > > > > 
> > > > > The main function of the DMA controller is the transfer of data from/to any
> > > > > peripheral to/from the memory. A memory to memory copy capability can also
> > > > > be configured.
> > > > > 
> > > > > This ldma driver is used for configure the device and channnels for data
> > > > > and control paths.
> > > > > 
> > > > > Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
> > > > > ---
> > > > > v1:
> > > > > - Initial version.
> > > > You have a cover letter, use that to keep track of these changes
> > > ok.
> > > > > +++ b/drivers/dma/lgm/Kconfig
> > > > > @@ -0,0 +1,9 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0-only
> > > > > +config INTEL_LDMA
> > > > > +	bool "Lightning Mountain centralized low speed DMA and high speed DMA controllers"
> > > > Do we have any other speeds :D
> > > No other speeds :-)
> > Right, so possibly drop the speed characterization here!
> "Lightning Mountain centralized DMA controller"
> > 
> > > > > +++ b/drivers/dma/lgm/lgm-dma.c
> > > > > @@ -0,0 +1,1742 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Lightning Mountain centralized low speed and high speed DMA controller driver
> > > > > + *
> > > > > + * Copyright (c) 2016 ~ 2020 Intel Corporation.
> > > > I think you mean 2016 - 2020, a dash which refers to duration
> > > ok.
> > > > > +struct dw2_desc {
> > > > > +	struct {
> > > > > +		u32 len		:16;
> > > > > +		u32 res0	:7;
> > > > > +		u32 bofs	:2;
> > > > > +		u32 res1	:3;
> > > > > +		u32 eop		:1;
> > > > > +		u32 sop		:1;
> > > > > +		u32 c		:1;
> > > > > +		u32 own		:1;
> > > > > +	} __packed field;
> > > > Another one, looks like folks adding dmaengine patches love this
> > > > approach, second one for the day..
> > > > 
> > > > Now why do you need the bit fields, why not use register defines and
> > > > helpers in bitfield.h to help configure the fields See FIELD_GET,
> > > > FIELD_PREP etc
> > > Let me check on this...
> > > > > +struct dma_dev_ops {
> > > > > +	int (*device_alloc_chan_resources)(struct dma_chan *chan);
> > > > > +	void (*device_free_chan_resources)(struct dma_chan *chan);
> > > > > +	int (*device_config)(struct dma_chan *chan,
> > > > > +			     struct dma_slave_config *config);
> > > > > +	int (*device_pause)(struct dma_chan *chan);
> > > > > +	int (*device_resume)(struct dma_chan *chan);
> > > > > +	int (*device_terminate_all)(struct dma_chan *chan);
> > > > > +	void (*device_synchronize)(struct dma_chan *chan);
> > > > > +	enum dma_status (*device_tx_status)(struct dma_chan *chan,
> > > > > +					    dma_cookie_t cookie,
> > > > > +					    struct dma_tx_state *txstate);
> > > > > +	struct dma_async_tx_descriptor *(*device_prep_slave_sg)
> > > > > +		(struct dma_chan *chan, struct scatterlist *sgl,
> > > > > +		unsigned int sg_len, enum dma_transfer_direction direction,
> > > > > +		unsigned long flags, void *context);
> > > > > +	void (*device_issue_pending)(struct dma_chan *chan);
> > > > > +};
> > > > Heh! why do you have a copy of dmaengine ops here?
> > > Ok, i will remove the ops and update the code accordingly.
> > > > > +static int ldma_chan_desc_cfg(struct ldma_chan *c, dma_addr_t desc_base,
> > > > > +			      int desc_num)
> > > > > +{
> > > > > +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
> > > > > +
> > > > > +	if (!desc_num) {
> > > > > +		dev_err(d->dev, "Channel %d must allocate descriptor first\n",
> > > > > +			c->nr);
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	if (desc_num > DMA_MAX_DESC_NUM) {
> > > > > +		dev_err(d->dev, "Channel %d descriptor number out of range %d\n",
> > > > > +			c->nr, desc_num);
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	ldma_chan_desc_hw_cfg(c, desc_base, desc_num);
> > > > > +
> > > > > +	c->flags |= DMA_HW_DESC;
> > > > > +	c->desc_cnt = desc_num;
> > > > > +	c->desc_phys = desc_base;
> > > > So you have a custom API which is used to configure this flag, a number
> > > > and an address. The question is why, can you please help explain this?
> > > LDMA used as general purpose dma(ver == DMA_VER22) and also supports DMA
> > > capability for GSWIP in their network packet processing.( ver > DMA_VER22)
> > Whats GSWIP?
> > 
> > > Each Ingress(IGP) & Egress(EGP) ports of CQM use a dma channel.
> > CQM?
> GSWIP stands for  Gigabit Switch IP, and CQM is Central Queue Manager.
> 
> GSWIP & CQM are the clients for the DMA. These are used in networking
> purpose to increase transfer rates for peripheral like the GSWIP LAN switch.

Please do add that when using these terms, folks outside Intel may not
be aware of these terms.

> > 
> > > desc needs to be configure for each dma channel and the remapped address of
> > > the IGP & EGP is desc base adress.
> > Why should this address not passed as src_addr/dst_addr?
> src_addr/dst_addr is the data pointer. Data pointer indicates address
> pointer of data buffer.
> 
> ldma_chan_desc_cfg() carries the descriptor address.
> 
> The descriptor list entry contains the data pointer, which points to the
> data section in the memory.
> 
> So we should not use src_addr/dst_addr as desc base address.

Okay sounds reasonable. why is this using in API here?

> > > CQM client is using ldma_chan_desc_cfg() to configure the descriptior.
> > > > > +static void dma_issue_pending(struct dma_chan *chan)
> > > > > +{
> > > > > +	struct ldma_chan *c = to_ldma_chan(chan);
> > > > > +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
> > > > > +	unsigned long flags;
> > > > > +
> > > > > +	if (d->ver == DMA_VER22) {
> > > > why is this specific to this version?
> > > Only dma0 instance (ver == DMA_VER22) is used as a general purpose slave
> > > DMA. we set both control and datapath here.
> > > Other instances (ver > DMA_VER22) we set only control path. data path is
> > > taken care by dma client(GSWIP).
> > > Only thing needs to do is get the channel, set the descriptor and just 'ON'
> > > the channel.
> > > 
> > > CQM is highly low level register configurable/programmable take care about
> > > the the packet processing through the register configurations.
> > DMAengine fwk take care of channel management for clients and
> > transaction management, if you not going to do transactions then why
> > bother with dmaengine ?
> dma0 instance (ver == DMA_VER22) uses DMAengine framework for both channel
> management and transaction management.
> 
> Other instances (ver > DMA_VER22) uses DMAengine mainly for channel
> management.
> To initiate the transaction client needs to ON the corresponding channel, So
> dmaengine ops are using to 'ON'  and 'OFF' the channels.

Is the addresses for transactions all hardcoded? WHo configures the
transaction in (ver > DMA_VER22)

-- 
~Vinod
