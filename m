Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C757A1463B7
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 09:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgAWIoA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 03:44:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAWIoA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Jan 2020 03:44:00 -0500
Received: from localhost (unknown [106.200.244.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66A552073A;
        Thu, 23 Jan 2020 08:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579769039;
        bh=zx3RA/KOQ5edAPPX0jSdGxIU3cKkSPtsilaixS2cNN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vrnUWpveP+Yvc3NhZkQThGhLjuRaG93UVipcsaiNgvC1yJBHFZAO69LCeYbDS3l5y
         loRtwLoF76PKmBfy+pKAXwGsi1Z6MBKgRKLhSAU7Q270PkHXpqNBckgFMOke2oSCD7
         wmPWNt66sVvjZzcdNNlbTs3ScoeXp2JmylEiYTo0=
Date:   Thu, 23 Jan 2020 14:13:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200123084352.GU2841@vkoul-mobl>
References: <20200123022939.9739-1-laurent.pinchart@ideasonboard.com>
 <20200123022939.9739-3-laurent.pinchart@ideasonboard.com>
 <2f3a9e9e-9b74-7c2e-de3a-4897ab0e8205@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f3a9e9e-9b74-7c2e-de3a-4897ab0e8205@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-01-20, 10:03, Peter Ujfalusi wrote:
> Hi Laurent,
> 
> On 23/01/2020 4.29, Laurent Pinchart wrote:
> > The new interleaved cyclic transaction type combines interleaved and
> > cycle transactions. It is designed for DMA engines that back display
> > controllers, where the same 2D frame needs to be output to the display
> > until a new frame is available.
> > 
> > Suggested-by: Vinod Koul <vkoul@kernel.org>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >  drivers/dma/dmaengine.c   |  8 +++++++-
> >  include/linux/dmaengine.h | 18 ++++++++++++++++++
> >  2 files changed, 25 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > index 03ac4b96117c..4ffb98a47f31 100644
> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> > @@ -981,7 +981,13 @@ int dma_async_device_register(struct dma_device *device)
> >  			"DMA_INTERLEAVE");
> >  		return -EIO;
> >  	}
> > -
> > +	if (dma_has_cap(DMA_INTERLEAVE_CYCLIC, device->cap_mask) &&
> > +	    !device->device_prep_interleaved_cyclic) {
> > +		dev_err(device->dev,
> > +			"Device claims capability %s, but op is not defined\n",
> > +			"DMA_INTERLEAVE_CYCLIC");
> > +		return -EIO;
> > +	}
> >  
> >  	if (!device->device_tx_status) {
> >  		dev_err(device->dev, "Device tx_status is not defined\n");
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index 8fcdee1c0cf9..e9af3bf835cb 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -61,6 +61,7 @@ enum dma_transaction_type {
> >  	DMA_SLAVE,
> >  	DMA_CYCLIC,
> >  	DMA_INTERLEAVE,
> > +	DMA_INTERLEAVE_CYCLIC,
> >  /* last transaction type for creation of the capabilities mask */
> >  	DMA_TX_TYPE_END,
> >  };
> > @@ -701,6 +702,10 @@ struct dma_filter {
> >   *	The function takes a buffer of size buf_len. The callback function will
> >   *	be called after period_len bytes have been transferred.
> >   * @device_prep_interleaved_dma: Transfer expression in a generic way.
> > + * @device_prep_interleaved_cyclic: prepares an interleaved cyclic transfer.
> > + *	This is similar to @device_prep_interleaved_dma, but the transfer is
> > + *	repeated until a new transfer is issued. This transfer type is meant
> > + *	for display.
> 
> I think capture (camera) is another potential beneficiary of this.
> 
> So you don't need to terminate the running interleaved_cyclic and start
> a new one, but prepare and issue a new one, which would
> terminate/replace the currently running cyclic interleaved DMA?

Why not explicitly terminate the transfer and start when a new one is
issued. That can be common usage for audio and display..

-- 
~Vinod
