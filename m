Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 725A21825B1
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2020 00:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbgCKXQC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Mar 2020 19:16:02 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57368 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbgCKXQB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Mar 2020 19:16:01 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 449675F;
        Thu, 12 Mar 2020 00:15:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583968559;
        bh=C8WgIfgVT/Y2aqdjyIiZgIEvt1TOHuNE+A40FRwxPcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ij498a36bBskPrsItl/UTYnBnM13S54ZuoxwWMzki5EUUm508kVtt3JyO9ZyH7FKn
         WGr/ABTvJxHQrZxp3i4oHoeAcYEBIGPIlVZc3Bp2IKXIfdBLEB4SIiRWPhdxFYihqp
         /bpm30nQ4FEDXN/yMO+EtuG2cFf0Ffl06zPuxRRQ=
Date:   Thu, 12 Mar 2020 01:15:55 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200311231555.GJ4863@pendragon.ideasonboard.com>
References: <20200226163011.GE4770@pendragon.ideasonboard.com>
 <20200302034735.GD4148@vkoul-mobl>
 <20200302073728.GB9177@pendragon.ideasonboard.com>
 <20200303043254.GN4148@vkoul-mobl>
 <20200303192255.GN11333@pendragon.ideasonboard.com>
 <20200304051301.GS4148@vkoul-mobl>
 <20200304080128.GA4712@pendragon.ideasonboard.com>
 <20200304153718.GU4148@vkoul-mobl>
 <20200304160016.GB4712@pendragon.ideasonboard.com>
 <aa7addf1-f7cf-c89f-9bf8-e937fe84f213@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa7addf1-f7cf-c89f-9bf8-e937fe84f213@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On Fri, Mar 06, 2020 at 04:49:01PM +0200, Peter Ujfalusi wrote:
> On 04/03/2020 18.00, Laurent Pinchart wrote:
> > I still think this is a different API. We'll have
> > 
> > 1. Existing .issue_pending(), queueing the next transfer for non-cyclic
> >    cases, and being a no-op for cyclic cases.
> > 2. New .terminate_cookie(AT_END_OF_TRANSFER), being a no-op for
> >    non-cyclic cases, and moving to the next transfer for cyclic cases.
> > 3. New .terminate_cookie(ABORT_IMMEDIATELY), applicable to both cyclic
> >    and non-cyclic cases.
> > 
> > 3. is an API I don't need, and can't easily test. I agree that it can
> > have use cases (provided the DMA device can abort an ongoing transfer
> > *and* still support DMA_RESIDUE_GRANULARITY_BURST in that case).
> > 
> > I'm troubled by my inability to convince you that 1. and 2. are really
> > the same, with 1. addressing the non-cyclic case and 2. addressing the
> > cyclic case :-) This is why I think they should both be implemeted using
> > .issue_pending() (no other option for 1., that's what it uses today).
> > This wouldn't prevent implementing 3. with a new .terminate_cookie()
> > operation, that wouldn't need to take a flag as it would always operate
> > in ABORT_IMMEDIATELY mode. There would also be no need to report a new
> > capability for 3., as the presence of the .terminate_cookie() handler
> > would be enough to tell clients that the API is supported. Only a new
> > capability for 2. would be needed.
> 
> Let's see the two cases, AT_END_OF_TRANSFER and ABORT_IMMEDIATELY
> against cyclic and slave for simplicity:
> - AT_END_OF_TRANSFER
> ...
> issue_pending(1)
> issue_pending(2)
> terminate_cookie(AT_END_OF_TRANSFER)
> 
> In case of cyclic:
> When cookie1 finishes a tx cookie2 will start.
> 
> Same sequence in case of slave:
> When cookie1 finishes a tx cookie2 will start.
>  Yes, terminate_cookie(AT_END_OF_TRANSFER) is NOP
> 
> - ABORT_IMMEDIATELY
> ...
> issue_pending(1)
> issue_pending(2)
> terminate_cookie(ABORT_IMMEDIATELY)
> 
> In case of cyclic and slave:
> Abort cookie1 right away and start cookie2.
> 
> In case of cyclic:
> When cookie1 finishes a tx cookie2 will start.

Is this paragraph a copy & paste leftover ?

> True, we have NOP operation, but as you can see the semantics of the two
> cases are well defined and consistent among different operations.

I'm not disputing that, but I still think that the semantics for the
proposal based solely on issue_pending() is well-defined too and
consistent among different operations :-) My point is that
terminate_cookie() is only required for the ABORT_IMMEDIATELY case,
which could be implemented on top of my proposal. Anyway, I seem to have
failed in my attempt to convincing Vinod, and he proposed providing the
implementation of terminate_cookie() in the DMA engine core and doc, so
I'll rebase the driver on top of that and submit the two together after
testing.

> Imho the only thing which is not really defined is the
> AT_END_OF_TRANSFER, is it after the current period, or when finishing
> the buffer / after a frame or all frames are consumed in the current tx
> for interleaved.

For 2D interleaved cyclic transfers, there's a single period, so that's
not an issue. For the existing cyclic API it's up to us to decide, and I
don't have enough insight on the expected usage and hardware features to
answer that question.

> >>>> And with this I think it would make sense to also add this to
> >>>> capabilities :)
> >>>
> >>> I'll repeat the comment I made to Peter: you want me to implement a
> >>> feature that you think would be useful, but is completely unrelated to
> >>> my use case, while there's a more natural way to handle my issue with
> >>> the current API, without precluding in any way the addition of your new
> >>> feature in the future. Not fair.
> >>
> >> So from API design pov, I would like this to support both the features.
> >> This helps us to not rework the API again for the immediate abort.
> >>
> >> I am not expecting this to be implemented by you if your hw doesn't
> >> support it. The core changes are pretty minimal and callback in the
> >> driver is the one which does the job and yours wont do this
> > 
> > Xilinx DMA drivers don't support DMA_RESIDUE_GRANULARITY_BURST so I
> > can't test this indeed.
> 
> All TI DMA supports it ;)

Great, so you can implement this feature ;-)

> >>>>>> So, the .terminate_cookie() should be a feature for all type of txn's.
> >>>>>> If for some reason (dont discount what hw designers can do) a controller
> >>>>>> supports this for some specific type(s), then they should return
> >>>>>> -ENOTSUPP for cookies that do not support and let the caller know.
> >>>>>
> >>>>> But then the caller can't know ahead of time, it will only find out when
> >>>>> it's too late, and can't decide not to use the DMA engine if it doesn't
> >>>>> support the feature. I don't think that's a very good option.
> >>>>
> >>>> Agreed so lets go with adding these in caps.
> >>>
> >>> So if there's a need for caps anyway, why not a cap that marks
> >>> .issue_pending() as moving from the current cyclic transfer to the next
> >>> one ? 
> >>
> >> Is the overhead really too much on that :) If you like I can send the
> >> core patches and you would need to implement the driver side?
> > 
> > We can try that as a compromise. One of main concerns with developing
> > the core patches myself is that the .terminate_cookie() API still seems
> > ill-defined to me, so it would be much more efficient if you translate
> > the idea you have in your idea into code than trying to communicate it
> > to me in all details (one of the grey areas is what should
> > .terminate_cookie() do if the cookie passed to the function corresponds
> > to an already terminated or, more tricky from a completion callback
> > point of view, an issued but not-yet-started transfer, or also a
> > submitted but not issued transfer). If you implement the core part, then
> > that problem will go away.
> > 
> > How about the implementation in virt-dma.[ch] by the way ?

-- 
Regards,

Laurent Pinchart
