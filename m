Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5167B1274F4
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 06:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbfLTFNZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 00:13:25 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45724 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfLTFNZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Dec 2019 00:13:25 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6FC9097D;
        Fri, 20 Dec 2019 06:13:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1576818802;
        bh=jUxPI9/TlF4r0uQyHJCHioTj3W7kFpDKawsjRVwOA6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qihWKS80RfbA9/K8JJLx1ozpcjiaZa5uuYZnpeFRXY6TKnwy9yttktYSH8gyt38A8
         domwGOOheFi6jwnP923Zx+duIq4ko2+NWZRqkf0SbebFMbL8yeoCdyOJa5ZtD0yGa4
         l/Tc+We+nAEJMbmWkUmdUh36pZ47zf/UQs4RnR7s=
Date:   Fri, 20 Dec 2019 07:13:09 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hyun Kwon <hyun.kwon@xilinx.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Hyun Kwon <hyunk@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v2 2/4] dma: xilinx: dpdma: Add the Xilinx DisplayPort
 DMA engine driver
Message-ID: <20191220051309.GA19504@pendragon.ideasonboard.com>
References: <20191107021400.16474-1-laurent.pinchart@ideasonboard.com>
 <20191107021400.16474-3-laurent.pinchart@ideasonboard.com>
 <20191109175908.GI952516@vkoul-mobl>
 <20191205150407.GL4734@pendragon.ideasonboard.com>
 <20191205163909.GH82508@vkoul-mobl>
 <20191205202746.GA26880@smtp.xilinx.com>
 <20191208160349.GD14311@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191208160349.GD14311@pendragon.ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Hyun and Vinod,

On Sun, Dec 08, 2019 at 06:03:49PM +0200, Laurent Pinchart wrote:
> On Thu, Dec 05, 2019 at 12:27:47PM -0800, Hyun Kwon wrote:
> > On Thu, 2019-12-05 at 08:39:09 -0800, Vinod Koul wrote:
> >> On 05-12-19, 17:04, Laurent Pinchart wrote:
> >>>>> +/*
> >>>>> + * DPDMA descriptor placement
> >>>>> + * --------------------------
> >>>>> + * DPDMA descritpor life time is described with following placements:
> >>>>> + *
> >>>>> + * allocated_desc -> submitted_desc -> pending_desc -> active_desc -> done_list
> >>>>> + *
> >>>>> + * Transition is triggered as following:
> >>>>> + *
> >>>>> + * -> allocated_desc : a descriptor allocation
> >>>>> + * allocated_desc -> submitted_desc: a descriptor submission
> >>>>> + * submitted_desc -> pending_desc: request to issue pending a descriptor
> >>>>> + * pending_desc -> active_desc: VSYNC intr when a desc is scheduled to DPDMA
> >>>>> + * active_desc -> done_list: VSYNC intr when DPDMA switches to a new desc
> >>>> 
> >>>> Well this tells me driver is not using vchan infrastructure, the
> >>>> drivers/dma/virt-dma.c is common infra which does pretty decent list
> >>>> management and drivers do not need to open code this.
> >>>> 
> >>>> Please convert the driver to use virt-dma
> >>> 
> >>> As noted in the cover letter,
> >>> 
> >>> "There is one review comment that is still pending: switching to
> >>> virt-dma. I started investigating this, and it quickly appeared that
> >>> this would result in an almost complete rewrite of the driver's logic.
> >>> While the end result may be better, I wonder if this is worth it, given
> >>> that the DPDMA is tied to the DisplayPort subsystem and can't be used
> >>> with other DMA slaves. The DPDMA is thus used with very specific usage
> >>> patterns, which don't need the genericity of descriptor handling
> >>> provided by virt-dma. Vinod, what's your opinion on this ? Is virt-dma
> >>> usage a blocker to merge this driver, could we switch to it later, or is
> >>> it just overkill in this case ?"
> >>> 
> >>> I'd like to ask an additional question : is the dmaengine API the best
> >>> solution for this ? The DPDMA is a separate IP core, but it is tied with
> >>> the DP subsystem. I'm tempted to just fold it in the display driver. The
> >>> only reason why I'm hesitant on this is that the DPDMA also handles
> >>> audio channels, that are also part of the DP subsystem, but that could
> >>> be handled by a separate ALSA driver. Still, handling display, audio and
> >>> DMA in drivers that we pretend are independent and generic would be a
> >>> bit of a lie.
> >> 
> >> Yeah if it is _only_ going to be used in display and no other client
> >> using it, then I really do not see any advantage of this being a
> >> dmaengine driver. That is pretty much we have been telling folks over
> >> the years.
> > 
> > In the development cycles, the IP blocks came in pieces. The DP tx driver
> > was developed first as one driver, with dmaengine driver other than DPDMA.
> > Then the ZynqMP block was added along with this DPDMA driver. Hence,
> > the reverse is possible, meaning some can decide to take a part of it
> > and harden with other blocks in next generation SoC. So there was and will
> > be benefit of keeping drivers modular at block level in my opinion, and
> > I'm not sure if it needs to put in a monolithic format, when it's already
> > modular.
> 
> OK, in the light of this information I'll keep the two separate and will
> switch to vchan as requested by Vinod.

I've moved forward with this task, but eventually ran into one hack in
the driver that is more difficult to get rid of than the other ones.

For display operation, the DPSUB driver needs to submit cyclic
interleaved transfer requests. There's no such thing (as far as I can
tell) in the DMA engine API, so the DPDMA drive simply keeps processing
the same descriptor over and over again until a new one is issued. The
hardware supports this with the help of hardware-based chaining of
descriptors, and the DPDMA driver simply sets the next pointer of the
descriptor to itself.

How can I solve this in a way that wouldn't abuse the DMA engine API ?

> >> Btw since this is xilinx and I guess everything is an IP how difficult
> >> would it be to put this on a non display core :)
> >> 
> >> If you decide to use dmaengine I would prefer it use virt-dma that mean
> >> rewrite yes but helps you term
> > 
> > I made changes using vchan[1], but it was a while ago. So it might have
> > been outdated, and details are vague in my head. Not sure if it was at
> > fully functional stage. Still, just in case it may be helpful.
> > 
> > [1] https://github.com/starhwk/linux-xlnx/commits/hyunk/upstreaming?after=0b0002113e7381d8a5f3119d064676af4d0953f4+34
> 
> Thank you, I will use that as a starting point.

-- 
Regards,

Laurent Pinchart
