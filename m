Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C23C15C8DF
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2020 17:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgBMQxL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Feb 2020 11:53:11 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:52766 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgBMQxL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Feb 2020 11:53:11 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 36982504;
        Thu, 13 Feb 2020 17:53:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1581612789;
        bh=xw+ZhmvTjf73b+T3lgM5QsVSseZSQSFG9QD4WaQUl28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R0w/ud8mWlmGKSjtmY7exu6ttZdxpHYsPPL4VuNS7Y59jg0z39k1mSziJqON00cEh
         TE2zg+koTluL9kYKnGmheS7FS8wfSdTHCb8iiXJoja4+A55i896u1lXbmPAqFBYCaz
         3GRk5EwygWFUEIOQNfhr1cgWX+XYeQZCfxeGGTcc=
Date:   Thu, 13 Feb 2020 18:52:49 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200213165249.GH29760@pendragon.ideasonboard.com>
References: <20200123084352.GU2841@vkoul-mobl>
 <88aa9920-cdaf-97f0-c36f-66a998860ed2@ti.com>
 <20200123122304.GB13922@pendragon.ideasonboard.com>
 <20200124061047.GE2841@vkoul-mobl>
 <20200124085051.GA4842@pendragon.ideasonboard.com>
 <20200210140618.GA4727@pendragon.ideasonboard.com>
 <20200213132938.GF2618@vkoul-mobl>
 <20200213134843.GG4833@pendragon.ideasonboard.com>
 <20200213140709.GH2618@vkoul-mobl>
 <736038ef-e8b2-5542-5cda-d8923e3a4826@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <736038ef-e8b2-5542-5cda-d8923e3a4826@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod and Peter,

On Thu, Feb 13, 2020 at 04:15:38PM +0200, Peter Ujfalusi wrote:
> On 13/02/2020 16.07, Vinod Koul wrote:
> > On 13-02-20, 15:48, Laurent Pinchart wrote:
> >> On Thu, Feb 13, 2020 at 06:59:38PM +0530, Vinod Koul wrote:
> >>> On 10-02-20, 16:06, Laurent Pinchart wrote:
> >>>
> >>>>>>> The use case here is not to switch to a new configuration, but to switch
> >>>>>>> to a new buffer. If the transfer had to be terminated manually first,
> >>>>>>> the DMA engine would potentially miss a frame, which is not acceptable.
> >>>>>>> We need an atomic way to switch to the next transfer.
> >>>>>>
> >>>>>> So in this case you have, let's say a cyclic descriptor with N buffers
> >>>>>> and they are cyclically capturing data and providing to client/user..
> >>>>>
> >>>>> For the display case it's cyclic over a single buffer that is repeatedly
> >>>>> displayed over and over again until a new one replaces it, when
> >>>>> userspace wants to change the content on the screen. Userspace only has
> >>>>> to provide a new buffer when content changes, otherwise the display has
> >>>>> to keep displaying the same one.
> >>>>
> >>>> Is the use case clear enough, or do you need more information ? Are you
> >>>> fine with the API for this kind of use case ?
> >>>
> >>> So we *know* when a new buffer is being used?
> >>
> >> The user of the DMA engine (the DRM DPSUB driver in this case) knows
> >> when a new buffer needs to be used, as it receives it from userspace. In
> >> response, it prepares a new interleaved cyclic transaction and queues
> >> it. At the next IRQ, the DMA engine driver switches to the new
> >> transaction (the implementation is slightly more complex to handle race
> >> conditions, but that's the idea).
> >>
> >>> IOW would it be possible for display (rather a dmaengine facing
> >>> display wrapper) to detect that we are reusing an old buffer and keep
> >>> the cyclic and once detected prepare a new descriptor, submit a new
> >>> one and then terminate old one which should trigger next transaction
> >>> to be submitted
> >>
> >> I'm not sure to follow you. Do you mean that the display driver should
> >> submit a non-cyclic transaction for every frame, reusing the same buffer
> >> for every transaction, until a new buffer is available ? The issue with
> >> this is that if the CPU load gets high, we may miss a frame, and the
> >> display will break. The DPDMA hardware implements cyclic support for
> >> this reason, and we want to use that feature to comply with the real
> >> time requirements.
> > 
> > Sorry to cause confusion :) I mean cyclic
> > 
> > So, DRM DPSUB get first buffer
> > A.1 Prepare cyclic interleave txn
> > A.2 Submit the txn (it doesn't start here)
> > A.3 Invoke issue_pending (that starts the txn)

I assume that, at this point, the transfer is started, and repeated
forever until step B below, right ?

> > DRM DPSUB gets next buffer:
> > B.1 Prepare cyclic interleave txn
> > B.2 Submit the txn
> > B.3 Call terminate for current cyclic txn (we need an updated terminate
> > which terminates the current txn, right now we have terminate_all which
> > is a sledge hammer approach)
> > B.4 Next txn would start once current one is started

Do you mean "once current one is completed" ?

> > Does this help and make sense in your case

It does, but I really wonder why we need a new terminate operation that
would terminate a single transfer. If we call issue_pending at step B.3,
when the new txn submitted, we can terminate the current transfer at the
point. It changes the semantics of issue_pending, but only for cyclic
transfers (this whole discussions it only about cyclic transfers). As a
cyclic transfer will be repeated forever until terminated, there's no
use case for issuing a new transfer without terminating the one in
progress. I thus don't think we need a new terminate operation: the only
thing that makes sense to do when submitting a new cyclic transfer is to
terminate the current one and switch to the new one, and we already have
all the APIs we need to enable this behaviour.

> That would be a clean way to handle it. We were missing this API for a
> long time to be able to cancel the ongoing transfer (whether it is
> cyclic or slave_sg, or memcpy) and move to the next one if there is one
> pending.

Note that this new terminate API wouldn't terminate the ongoing transfer
immediately, it would complete first, until the end of the cycle for
cyclic transfers, and until the end of the whole transfer otherwise.
This new operation would thus essentially be a no-op for non-cyclic
transfers. I don't see how it would help :-) Do you have any particular
use case in mind ?

> +1 from me if it counts ;)

-- 
Regards,

Laurent Pinchart
