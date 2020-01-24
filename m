Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEA61479AB
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 09:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgAXIvM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jan 2020 03:51:12 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59818 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgAXIvL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Jan 2020 03:51:11 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BDBC797D;
        Fri, 24 Jan 2020 09:51:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1579855868;
        bh=l0GOYYBCXIQfudphJpua1V/4F/F78/XS5eWoUCVYDww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NwMCiQm8g3/b6gMppxn1oKdZUWpFlnWm5V0H3vSmGmvTGzleLD6vB4KsKLy14HyvK
         +wTR22BFe3D8hY+LaE5Db/bXVUss7gKTZGEIZhILYRDyp+wV+5crdCDbe4xGDJIlV5
         zbPdKoMgAh3sZh4Izh2rvlg9THH8zMEWE9NOei5c=
Date:   Fri, 24 Jan 2020 10:50:51 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200124085051.GA4842@pendragon.ideasonboard.com>
References: <20200123022939.9739-1-laurent.pinchart@ideasonboard.com>
 <20200123022939.9739-3-laurent.pinchart@ideasonboard.com>
 <2f3a9e9e-9b74-7c2e-de3a-4897ab0e8205@ti.com>
 <20200123084352.GU2841@vkoul-mobl>
 <88aa9920-cdaf-97f0-c36f-66a998860ed2@ti.com>
 <20200123122304.GB13922@pendragon.ideasonboard.com>
 <20200124061047.GE2841@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200124061047.GE2841@vkoul-mobl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 24, 2020 at 11:40:47AM +0530, Vinod Koul wrote:
> On 23-01-20, 14:23, Laurent Pinchart wrote:
> > > >>> @@ -701,6 +702,10 @@ struct dma_filter {
> > > >>>   *	The function takes a buffer of size buf_len. The callback function will
> > > >>>   *	be called after period_len bytes have been transferred.
> > > >>>   * @device_prep_interleaved_dma: Transfer expression in a generic way.
> > > >>> + * @device_prep_interleaved_cyclic: prepares an interleaved cyclic transfer.
> > > >>> + *	This is similar to @device_prep_interleaved_dma, but the transfer is
> > > >>> + *	repeated until a new transfer is issued. This transfer type is meant
> > > >>> + *	for display.
> > > >>
> > > >> I think capture (camera) is another potential beneficiary of this.
> > 
> > Possibly, although in the camera case I'd rather have the hardware stop
> > if there's no more buffer. Requiring a buffer to always be present is
> > annoying from a userspace point of view. For display it's different, if
> > userspace doesn't submit a new frame, the same frame should keep being
> > displayed on the screen.
> > 
> > > >> So you don't need to terminate the running interleaved_cyclic and start
> > > >> a new one, but prepare and issue a new one, which would
> > > >> terminate/replace the currently running cyclic interleaved DMA?
> > 
> > Correct.
> > 
> > > > Why not explicitly terminate the transfer and start when a new one is
> > > > issued. That can be common usage for audio and display..
> > > 
> > > Yes, this is what I'm asking. The cyclic transfer is running and in
> > > order to start the new transfer, the previous should stop. But in cyclic
> > > case it is not going to happen unless it is terminated.
> > > 
> > > When one would want to have different interleaved transfer the display
> > > (or capture )IP needs to be reconfigured as well. The the would need to
> > > be terminated anyways to avoid interpreting data in a wrong way.
> > 
> > The use case here is not to switch to a new configuration, but to switch
> > to a new buffer. If the transfer had to be terminated manually first,
> > the DMA engine would potentially miss a frame, which is not acceptable.
> > We need an atomic way to switch to the next transfer.
> 
> So in this case you have, let's say a cyclic descriptor with N buffers
> and they are cyclically capturing data and providing to client/user..

For the display case it's cyclic over a single buffer that is repeatedly
displayed over and over again until a new one replaces it, when
userspace wants to change the content on the screen. Userspace only has
to provide a new buffer when content changes, otherwise the display has
to keep displaying the same one.

For cameras I don't think cyclic makes too much sense, except when the
DMA engine can't work in single-shot mode and always requires a buffer
to write into. That shouldn't be the norm.

> So why would you like to submit again...? Once whole capture has
> completed you would terminate, right...
> 
> Sorry not able to wrap my head around why new submission is required and
> if that is the case why previous one cant be terminated :)

-- 
Regards,

Laurent Pinchart
