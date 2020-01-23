Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBD51467D8
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 13:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAWMXX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 07:23:23 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:41670 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWMXX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 07:23:23 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2AC8F2E5;
        Thu, 23 Jan 2020 13:23:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1579782201;
        bh=nqoOyuzteAsp3JCuE6CUyoS3sknJ6Ys+4mWrHCizbvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XiDP0bHMR2IKhhhQzEO5yDQNURys5I7cRmx3RhjgQg2m2hulVRdRmsm8yqabWykSn
         vaodX241eWs1kpKn0XEZdp7JBxrAYFS6XRWriVMxO/DJDJ/yLC7QjUQzoe44ewHAO+
         2yZwpSdleDN1HU1ueJldxNqiHdxY58W5TMrxwD9M=
Date:   Thu, 23 Jan 2020 14:23:04 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200123122304.GB13922@pendragon.ideasonboard.com>
References: <20200123022939.9739-1-laurent.pinchart@ideasonboard.com>
 <20200123022939.9739-3-laurent.pinchart@ideasonboard.com>
 <2f3a9e9e-9b74-7c2e-de3a-4897ab0e8205@ti.com>
 <20200123084352.GU2841@vkoul-mobl>
 <88aa9920-cdaf-97f0-c36f-66a998860ed2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88aa9920-cdaf-97f0-c36f-66a998860ed2@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

On Thu, Jan 23, 2020 at 10:51:42AM +0200, Peter Ujfalusi wrote:
> On 23/01/2020 10.43, Vinod Koul wrote:
> > On 23-01-20, 10:03, Peter Ujfalusi wrote:
> >> On 23/01/2020 4.29, Laurent Pinchart wrote:
> >>> The new interleaved cyclic transaction type combines interleaved and
> >>> cycle transactions. It is designed for DMA engines that back display
> >>> controllers, where the same 2D frame needs to be output to the display
> >>> until a new frame is available.
> >>>
> >>> Suggested-by: Vinod Koul <vkoul@kernel.org>
> >>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>> ---
> >>>  drivers/dma/dmaengine.c   |  8 +++++++-
> >>>  include/linux/dmaengine.h | 18 ++++++++++++++++++
> >>>  2 files changed, 25 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> >>> index 03ac4b96117c..4ffb98a47f31 100644
> >>> --- a/drivers/dma/dmaengine.c
> >>> +++ b/drivers/dma/dmaengine.c
> >>> @@ -981,7 +981,13 @@ int dma_async_device_register(struct dma_device *device)
> >>>  			"DMA_INTERLEAVE");
> >>>  		return -EIO;
> >>>  	}
> >>> -
> >>> +	if (dma_has_cap(DMA_INTERLEAVE_CYCLIC, device->cap_mask) &&
> >>> +	    !device->device_prep_interleaved_cyclic) {
> >>> +		dev_err(device->dev,
> >>> +			"Device claims capability %s, but op is not defined\n",
> >>> +			"DMA_INTERLEAVE_CYCLIC");
> >>> +		return -EIO;
> >>> +	}
> >>>  
> >>>  	if (!device->device_tx_status) {
> >>>  		dev_err(device->dev, "Device tx_status is not defined\n");
> >>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> >>> index 8fcdee1c0cf9..e9af3bf835cb 100644
> >>> --- a/include/linux/dmaengine.h
> >>> +++ b/include/linux/dmaengine.h
> >>> @@ -61,6 +61,7 @@ enum dma_transaction_type {
> >>>  	DMA_SLAVE,
> >>>  	DMA_CYCLIC,
> >>>  	DMA_INTERLEAVE,
> >>> +	DMA_INTERLEAVE_CYCLIC,
> >>>  /* last transaction type for creation of the capabilities mask */
> >>>  	DMA_TX_TYPE_END,
> >>>  };
> >>> @@ -701,6 +702,10 @@ struct dma_filter {
> >>>   *	The function takes a buffer of size buf_len. The callback function will
> >>>   *	be called after period_len bytes have been transferred.
> >>>   * @device_prep_interleaved_dma: Transfer expression in a generic way.
> >>> + * @device_prep_interleaved_cyclic: prepares an interleaved cyclic transfer.
> >>> + *	This is similar to @device_prep_interleaved_dma, but the transfer is
> >>> + *	repeated until a new transfer is issued. This transfer type is meant
> >>> + *	for display.
> >>
> >> I think capture (camera) is another potential beneficiary of this.

Possibly, although in the camera case I'd rather have the hardware stop
if there's no more buffer. Requiring a buffer to always be present is
annoying from a userspace point of view. For display it's different, if
userspace doesn't submit a new frame, the same frame should keep being
displayed on the screen.

> >> So you don't need to terminate the running interleaved_cyclic and start
> >> a new one, but prepare and issue a new one, which would
> >> terminate/replace the currently running cyclic interleaved DMA?

Correct.

> > Why not explicitly terminate the transfer and start when a new one is
> > issued. That can be common usage for audio and display..
> 
> Yes, this is what I'm asking. The cyclic transfer is running and in
> order to start the new transfer, the previous should stop. But in cyclic
> case it is not going to happen unless it is terminated.
> 
> When one would want to have different interleaved transfer the display
> (or capture )IP needs to be reconfigured as well. The the would need to
> be terminated anyways to avoid interpreting data in a wrong way.

The use case here is not to switch to a new configuration, but to switch
to a new buffer. If the transfer had to be terminated manually first,
the DMA engine would potentially miss a frame, which is not acceptable.
We need an atomic way to switch to the next transfer.

-- 
Regards,

Laurent Pinchart
