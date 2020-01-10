Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCAAF13686F
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2020 08:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgAJHlg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jan 2020 02:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgAJHlg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 Jan 2020 02:41:36 -0500
Received: from localhost (unknown [223.226.110.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CD652080D;
        Fri, 10 Jan 2020 07:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578642095;
        bh=80GVNPHeHLk1cJbeRnbnuFHZskWfNVEPYTrd92O73i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tBNr5Ws6Tw0gPh1xIxdjHg27boLMfswB2QUmzhbp2i2BTpJi4aDul00TmXRxNXR4y
         MRCXWqBZ5nkYtMNUx0apfQxGJnWaQEvj5X8uTQmJ+4ibdXu4MQMjT5/uY2xOrlFm4S
         8AcoFi/iGgXzHNDaFSUbwmM++D52DiL1kfVvm+Sw=
Date:   Fri, 10 Jan 2020 13:11:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Hyun Kwon <hyunk@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v2 2/4] dma: xilinx: dpdma: Add the Xilinx DisplayPort
 DMA engine driver
Message-ID: <20200110074122.GC2818@vkoul-mobl>
References: <20191205163909.GH82508@vkoul-mobl>
 <20191205202746.GA26880@smtp.xilinx.com>
 <20191208160349.GD14311@pendragon.ideasonboard.com>
 <20191220051309.GA19504@pendragon.ideasonboard.com>
 <20191220080127.GI2536@vkoul-mobl>
 <20191220123523.GB4865@pendragon.ideasonboard.com>
 <20191220154059.GR2536@vkoul-mobl>
 <20191220160232.GE4865@pendragon.ideasonboard.com>
 <20200103005918.GO4843@pendragon.ideasonboard.com>
 <20200109155704.GD31792@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109155704.GD31792@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On 09-01-20, 17:57, Laurent Pinchart wrote:
> On Fri, Jan 03, 2020 at 02:59:18AM +0200, Laurent Pinchart wrote:
> > On Fri, Dec 20, 2019 at 06:02:32PM +0200, Laurent Pinchart wrote:
> > > On Fri, Dec 20, 2019 at 09:10:59PM +0530, Vinod Koul wrote:
> > >> On 20-12-19, 14:35, Laurent Pinchart wrote:
> > >>> On Fri, Dec 20, 2019 at 01:31:27PM +0530, Vinod Koul wrote:
> > >>>> On 20-12-19, 07:13, Laurent Pinchart wrote:
> > >>>> 
> > >>>>>> OK, in the light of this information I'll keep the two separate and will
> > >>>>>> switch to vchan as requested by Vinod.
> > >>>>> 
> > >>>>> I've moved forward with this task, but eventually ran into one hack in
> > >>>>> the driver that is more difficult to get rid of than the other ones.
> > >>>>> 
> > >>>>> For display operation, the DPSUB driver needs to submit cyclic
> > >>>>> interleaved transfer requests. There's no such thing (as far as I can
> > >>>>> tell) in the DMA engine API, so the DPDMA drive simply keeps processing
> > >>>> 
> > >>>> we do support interleave, you need to implement
> > >>>> .device_prep_interleaved_dma and use dmaengine_prep_interleaved_dma()
> > >>>> from the client
> > >>> 
> > >>> I mean both interleaved and cyclic at the same time.
> > >>> 
> > >>>>> the same descriptor over and over again until a new one is issued. The
> > >>>>> hardware supports this with the help of hardware-based chaining of
> > >>>>> descriptors, and the DPDMA driver simply sets the next pointer of the
> > >>>>> descriptor to itself.
> > >>>>> 
> > >>>>> How can I solve this in a way that wouldn't abuse the DMA engine API ?
> > >>>> 
> > >>>> Is this not a cyclic case of descriptor?
> > >>> 
> > >>> Exactly my point :-) It's cyclic, but has to be interleaved too as it's
> > >>> a 2D transfer.
> > >> 
> > >> IIRC the interleaved descriptor can be set in such a way that last chunk
> > >> points to the first one..
> > > 
> > > I don't see a way to do this in the existing API, am I missing something
> > > ? And how would the completion handler be called in that case, once per
> > > frame still ? I don't think vchan supports this at the moment
> > > 
> > >> I think Jassi had good ideas for generic interleave API which can do
> > >> all this :)
> > > 
> > > How do I get this driver moving forward in the meantime ? :-)
> > 
> > Happy new year, and gentle ping :-)

Sorry for the delay, I was out for new year and then catching up on
stuff..

> Would it be fine if, in the meantime, I used the vchan helpers by
> hardcoded interleaved descriptors to always be cyclic ? The DPDMA IP is
> tied to the DPSUB in existing platforms, so there's no way to reuse it
> in a generic fashion at the moment anyway. We could then extend this to
> merge interleaved and cyclic modes in a single API, and I would update
> both the DPDMA and the DPSUB driver accordingly.

But wont that cause issues as descriptors wont be assumed cyclic and
expected to be removed?

I guess what we need is cyclic support for interleave API, seeing the
code I think that is easier to do:

-- 8< --

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 4ac77456e830..540506734db7 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1016,7 +1016,12 @@ int dma_async_device_register(struct dma_device *device)
 			"DMA_INTERLEAVE");
 		return -EIO;
 	}
-
+	if (dma_has_cap(DMA_INTERLEAVE_CYCLIC, device->cap_mask) && !device->device_prep_interleaved_cyclic) {
+		dev_err(device->dev,
+			"Device claims capability %s, but op is not defined\n",
+			"DMA_INTERLEAVE_CYCLIC");
+		return -EIO;
+	}
 
 	if (!device->device_tx_status) {
 		dev_err(device->dev, "Device tx_status is not defined\n");
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 7927731e3716..5ae49d6a04f9 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -61,6 +61,7 @@ enum dma_transaction_type {
 	DMA_SLAVE,
 	DMA_CYCLIC,
 	DMA_INTERLEAVE,
+	DMA_INTERLEAVE_CYCLIC,
 /* last transaction type for creation of the capabilities mask */
 	DMA_TX_TYPE_END,
 };
@@ -792,6 +793,9 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_interleaved_dma)(
 		struct dma_chan *chan, struct dma_interleaved_template *xt,
 		unsigned long flags);
+	struct dma_async_tx_descriptor *(*device_prep_interleaved_cyclic)(
+		struct dma_chan *chan, struct dma_interleaved_template *xt,
+		unsigned long flags);
 	struct dma_async_tx_descriptor *(*device_prep_dma_imm_data)(
 		struct dma_chan *chan, dma_addr_t dst, u64 data,
 		unsigned long flags);
@@ -888,6 +892,16 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
 	return chan->device->device_prep_interleaved_dma(chan, xt, flags);
 }
 
+static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_cyclic(
+		struct dma_chan *chan, struct dma_interleaved_template *xt,
+		unsigned long flags)
+{
+	if (!chan || !chan->device || !chan->device->device_prep_interleaved_cyclic)
+		return NULL;
+
+	return chan->device->device_prep_interleaved_cyclic(chan, xt, flags);
+}
+
 static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memset(
 		struct dma_chan *chan, dma_addr_t dest, int value, size_t len,
 		unsigned long flags)

-- 
~Vinod
