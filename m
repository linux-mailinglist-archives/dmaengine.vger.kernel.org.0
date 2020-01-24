Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDBF71479E3
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 09:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgAXI7F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jan 2020 03:59:05 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:60746 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgAXI7E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Jan 2020 03:59:04 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CD26C97D;
        Fri, 24 Jan 2020 09:59:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1579856343;
        bh=dtaRUjy+CoQXjQReFbKF/TBrVzb+32ycu2UZgQkhjxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSiiQ59HLPwNx0JmZVzaU6tZzpZkR0Ot+2DgeRqKAYAcIHBHhLxyNbmbzPcAh6GPz
         kC2xGVo26PIJRWXfR0whFlOguR2XUpUWq1frXzweNErlutQlnDb08bMuXe8ZDt4emN
         a+lG3ZGFUGzIzmUyUxFLV6lb3cTTdh4EWlSi13yI=
Date:   Fri, 24 Jan 2020 10:58:46 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200124085846.GC4842@pendragon.ideasonboard.com>
References: <20200123022939.9739-1-laurent.pinchart@ideasonboard.com>
 <20200123022939.9739-3-laurent.pinchart@ideasonboard.com>
 <2f3a9e9e-9b74-7c2e-de3a-4897ab0e8205@ti.com>
 <20200123084352.GU2841@vkoul-mobl>
 <88aa9920-cdaf-97f0-c36f-66a998860ed2@ti.com>
 <20200123122304.GB13922@pendragon.ideasonboard.com>
 <ded9c051-11f3-e61a-e0de-1cd54a8c85d5@ti.com>
 <7216460c-799f-efc7-c8be-9dd9b9829d10@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7216460c-799f-efc7-c8be-9dd9b9829d10@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On Fri, Jan 24, 2020 at 09:38:50AM +0200, Peter Ujfalusi wrote:
> On 24/01/2020 9.20, Peter Ujfalusi wrote:
> > On 23/01/2020 14.23, Laurent Pinchart wrote:
> >>>>> I think capture (camera) is another potential beneficiary of this.
> >>
> >> Possibly, although in the camera case I'd rather have the hardware stop
> >> if there's no more buffer. Requiring a buffer to always be present is
> >> annoying from a userspace point of view. For display it's different, if
> >> userspace doesn't submit a new frame, the same frame should keep being
> >> displayed on the screen.
> >>
> >>>>> So you don't need to terminate the running interleaved_cyclic and start
> >>>>> a new one, but prepare and issue a new one, which would
> >>>>> terminate/replace the currently running cyclic interleaved DMA?
> >>
> >> Correct.
> >>
> >>>> Why not explicitly terminate the transfer and start when a new one is
> >>>> issued. That can be common usage for audio and display..
> >>>
> >>> Yes, this is what I'm asking. The cyclic transfer is running and in
> >>> order to start the new transfer, the previous should stop. But in cyclic
> >>> case it is not going to happen unless it is terminated.
> >>>
> >>> When one would want to have different interleaved transfer the display
> >>> (or capture )IP needs to be reconfigured as well. The the would need to
> >>> be terminated anyways to avoid interpreting data in a wrong way.
> >>
> >> The use case here is not to switch to a new configuration, but to switch
> >> to a new buffer. If the transfer had to be terminated manually first,
> >> the DMA engine would potentially miss a frame, which is not acceptable.
> >> We need an atomic way to switch to the next transfer.
> > 
> > You have a special hardware in hand, most DMAs can not just replace a
> > cyclic transfer in-flight and it also kind of violates the DMAengine
> > principles.
> 
> Is there any specific reason why you need DMAengine driver for a display
> DMA? Usually the drm drivers handle their DMA internally.

Because it's a separate IP core that can be reused in different FPGAs
for different purposes. It happens that in my case it's a hard IP
connected to a display controller, but it could be used for non-cyclic
use cases in a different chip.

> > If cyclic transfer is started then it is expected to run forever until
> > it is terminated. Preparing and issuing a new transfer will not get
> > executed when there is already a cyclic transfer in flight as your only
> > option is to terminate_all, which will kill the running cyclic _and_
> > will discard the issued and pending transfers.
> > 
> > So the use case is page flip when you have multiple framebuffers and you
> > switch them to show the updated one, right?
> > 
> > There are things missing in DMAengine in API level for sure to do this,
> > imho.
> > The issue is that cyclic transfers will never complete, they run until
> > terminated, but you want to replace the currently executing one with a
> > another cyclic transfer without actually terminating the other.
> > 
> > It is like pause the 1st cyclic and continue with the 2nd one. Then at
> > some point you pause the 2nd one and restart the 1st one.
> > It is also crucial that the pause /switch happens when the executing one
> > finished the interleaved round and not in the middle somewhere, right?
> > 
> > If you:
> > desc_1 = dmaengine_prep_interleaved_cyclic(chan, );
> > cookie_1 = dmaengine_submit(desc_1);
> > desc_2 = dmaengine_prep_interleaved_cyclic(chan, );
> > cookie_2 = dmaengine_submit(desc_1);
> > 
> > /* cookie_1/desc_1 is started */
> > dma_async_issue_pending(chan);
> > 
> > /* When need to switch to cookie_2 */
> > dmaengine_cyclic_set_active_cookie(chan, cookie_2);
> > /*
> >  * cookie_1 execution is suspended after it finished the running
> >  * dma_interleaved_template or buffer in normal cyclic and cookie_2
> >  * is replacing it.
> >  */
> > 
> > /* Switch back to cookie_1 */
> > dmaengine_cyclic_set_active_cookie(chan, cookie_1);
> > /*
> >  * cookie_2 execution is suspended after it finished the running
> >  * dma_interleaved_template or buffer in normal cyclic and cookie_1
> >  * is replacing it.
> >  */
> > 
> > There should be a (yet another) capabilities flag got
> > cyclic_set_active_cookie and the documentation should be strict on what
> > is the expected behavior.
> > 
> > You can kill everything with terminate_all.
> > There is another thing which is missing imho from DMAengine: to
> > terminate a specific cookie, not the entire channel, which might be a
> > good addition as you might spawn framebuffers and then delete them and
> > you might want to release the corresponding cookie/descriptor as well.
> 
> This is a bit trickier as DMAengine's cookie is s32 and internally
> treated as a running number and cookie status is checked against s32
> numbers with < >, I think this will not like when someone kills a cookie
> in the middle.

I would require a major redesign, yes. Not looking forward to that,
especially as I think we don't need it.

> > What do you think?

-- 
Regards,

Laurent Pinchart
