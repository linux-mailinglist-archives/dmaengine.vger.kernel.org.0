Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7383147875
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 07:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgAXGKx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jan 2020 01:10:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgAXGKx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jan 2020 01:10:53 -0500
Received: from localhost (unknown [106.200.244.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01EEA2072C;
        Fri, 24 Jan 2020 06:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579846251;
        bh=7BODJKPESXKudIiPPYqNSviFVhKL+rucS8GGIDGsp4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xueU7jXzIhNPqzCZnEg7rq4jLU2h1ENQD+UmZgxpA0s79ELI+2McAzeiqAUbN4Gfv
         hmkbl7VWtsG/wO55n4RL87xrrbNqinQ5d3xuh4K0Pdv0FjCzVs0m49DyFOdEvay4dT
         FtvIaaSSQPD7DIcFHO727p2KuN6KeV4k+i9sKMLc=
Date:   Fri, 24 Jan 2020 11:40:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200124061047.GE2841@vkoul-mobl>
References: <20200123022939.9739-1-laurent.pinchart@ideasonboard.com>
 <20200123022939.9739-3-laurent.pinchart@ideasonboard.com>
 <2f3a9e9e-9b74-7c2e-de3a-4897ab0e8205@ti.com>
 <20200123084352.GU2841@vkoul-mobl>
 <88aa9920-cdaf-97f0-c36f-66a998860ed2@ti.com>
 <20200123122304.GB13922@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123122304.GB13922@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On 23-01-20, 14:23, Laurent Pinchart wrote:
> > >>> @@ -701,6 +702,10 @@ struct dma_filter {
> > >>>   *	The function takes a buffer of size buf_len. The callback function will
> > >>>   *	be called after period_len bytes have been transferred.
> > >>>   * @device_prep_interleaved_dma: Transfer expression in a generic way.
> > >>> + * @device_prep_interleaved_cyclic: prepares an interleaved cyclic transfer.
> > >>> + *	This is similar to @device_prep_interleaved_dma, but the transfer is
> > >>> + *	repeated until a new transfer is issued. This transfer type is meant
> > >>> + *	for display.
> > >>
> > >> I think capture (camera) is another potential beneficiary of this.
> 
> Possibly, although in the camera case I'd rather have the hardware stop
> if there's no more buffer. Requiring a buffer to always be present is
> annoying from a userspace point of view. For display it's different, if
> userspace doesn't submit a new frame, the same frame should keep being
> displayed on the screen.
> 
> > >> So you don't need to terminate the running interleaved_cyclic and start
> > >> a new one, but prepare and issue a new one, which would
> > >> terminate/replace the currently running cyclic interleaved DMA?
> 
> Correct.
> 
> > > Why not explicitly terminate the transfer and start when a new one is
> > > issued. That can be common usage for audio and display..
> > 
> > Yes, this is what I'm asking. The cyclic transfer is running and in
> > order to start the new transfer, the previous should stop. But in cyclic
> > case it is not going to happen unless it is terminated.
> > 
> > When one would want to have different interleaved transfer the display
> > (or capture )IP needs to be reconfigured as well. The the would need to
> > be terminated anyways to avoid interpreting data in a wrong way.
> 
> The use case here is not to switch to a new configuration, but to switch
> to a new buffer. If the transfer had to be terminated manually first,
> the DMA engine would potentially miss a frame, which is not acceptable.
> We need an atomic way to switch to the next transfer.

So in this case you have, let's say a cyclic descriptor with N buffers
and they are cyclically capturing data and providing to client/user..

So why would you like to submit again...? Once whole capture has
completed you would terminate, right...

Sorry not able to wrap my head around why new submission is required and
if that is the case why previous one cant be terminated :)

-- 
~Vinod
