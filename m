Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1533429DE63
	for <lists+dmaengine@lfdr.de>; Thu, 29 Oct 2020 01:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbgJ1WTL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Oct 2020 18:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731678AbgJ1WRl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:41 -0400
Received: from localhost (unknown [122.171.163.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F32E2087E;
        Wed, 28 Oct 2020 04:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603859607;
        bh=Q1fuRMz6o3fIgYIUyMAQ7thHwst7dv7ORTRK4hLU2U8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opxxgEdsvy8zO9AJCIMgjFtbwwnoAB6xUNfkHXIxNnC1WJ6hG5NcF4KY1ymWGkR3g
         eS6+8c8vcCcqS/boHn6uQCncW1ACybsZC5fVq1eJ6wbVXaP7MV0IYzfo1fYn+gcezt
         ZB9+jD3JjIUVoFg8aHRUQP/e4BOTvMmCJpP8BTh0=
Date:   Wed, 28 Oct 2020 10:03:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH 3/4] dmaengine: move APIs in interface to use peripheral
 term
Message-ID: <20201028043323.GD3550@vkoul-mobl>
References: <20201015073132.3571684-1-vkoul@kernel.org>
 <20201015073132.3571684-4-vkoul@kernel.org>
 <18d27d30-c6c4-51f6-b361-6bf0be1a34b5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18d27d30-c6c4-51f6-b361-6bf0be1a34b5@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-10-20, 12:17, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 15/10/2020 10.31, Vinod Koul wrote:
> > dmaengine history has a non inclusive terminology of dmaengine slave, I
> > feel it is time to replace that.
> > 
> > This moves APIs in dmaengine interface with replacement of slave
> > to peripheral which is an appropriate term for dmaengine peripheral
> > devices
> > 
> > Since the change of name can break users, the new names have been added
> > with old APIs kept as macro define for new names. Once the users have
> > been migrated, these macros will be dropped.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  include/linux/dmaengine.h | 46 +++++++++++++++++++++++++++------------
> >  1 file changed, 32 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index 04b993a5373c..d8dce3cdfdd4 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -923,6 +923,10 @@ struct dma_device {
> >  	struct dma_async_tx_descriptor *(*device_prep_dma_interrupt)(
> >  		struct dma_chan *chan, unsigned long flags);
> >  
> > +	struct dma_async_tx_descriptor *(*device_prep_peripheral_sg)(
> > +		struct dma_chan *chan, struct scatterlist *sgl,
> > +		unsigned int sg_len, enum dma_transfer_direction direction,
> > +		unsigned long flags, void *context);
> >  	struct dma_async_tx_descriptor *(*device_prep_slave_sg)(
> >  		struct dma_chan *chan, struct scatterlist *sgl,
> >  		unsigned int sg_len, enum dma_transfer_direction direction,
> > @@ -959,8 +963,8 @@ struct dma_device {
> >  #endif
> >  };
> >  
> > -static inline int dmaengine_slave_config(struct dma_chan *chan,
> > -					  struct dma_slave_config *config)
> > +static inline int dmaengine_peripheral_config(struct dma_chan *chan,
> > +					  struct dma_peripheral_config *config)
> >  {
> >  	if (chan->device->device_config)
> >  		return chan->device->device_config(chan, config);
> > @@ -968,12 +972,16 @@ static inline int dmaengine_slave_config(struct dma_chan *chan,
> >  	return -ENOSYS;
> >  }
> >  
> > -static inline bool is_slave_direction(enum dma_transfer_direction direction)
> > +#define dmaengine_slave_config dmaengine_peripheral_config
> > +
> > +static inline bool is_peripheral_direction(enum dma_transfer_direction direction)
> >  {
> >  	return (direction == DMA_MEM_TO_DEV) || (direction == DMA_DEV_TO_MEM);
> >  }
> >  
> > -static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
> > +#define is_slave_direction is_peripheral_direction
> > +
> > +static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_single(
> >  	struct dma_chan *chan, dma_addr_t buf, size_t len,
> >  	enum dma_transfer_direction dir, unsigned long flags)
> >  {
> > @@ -989,7 +997,9 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
> >  						  dir, flags, NULL);
> >  }
> >  
> > -static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
> > +#define dmaengine_prep_slave_single dmaengine_prep_peripheral_single
> > +
> > +static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_sg(
> >  	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
> >  	enum dma_transfer_direction dir, unsigned long flags)
> >  {
> > @@ -1000,6 +1010,8 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
> >  						  dir, flags, NULL);
> >  }
> >  
> > +#define dmaengine_prep_slave_sg dmaengine_prep_peripheral_sg
> > +
> 
> If you do similar changes to _single() then DMA drivers can migrate to
> the new device_prep_peripheral_sg in their own pace:

Yes not sure why I missed that, I have updated this for all three APIs
which use .device_prep_slave_sg()

Thanks
-- 
~Vinod
