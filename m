Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D8B1EA314
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2020 13:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgFALtz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Jun 2020 07:49:55 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58386 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgFALtz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 Jun 2020 07:49:55 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 842C7304;
        Mon,  1 Jun 2020 13:49:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591012192;
        bh=JI2IvJkrUigxz6WmMCK9MqhUhApR1OCuMHiZVFHBcyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nimw2+0XwgSFn227LiuiHzCpnlndVGhX/umjojMR37XIYY/dhXSdBN35p+yfYO8xq
         0jhMiRBWvCBNJyw2XHZfOOTuKhCN6PRf7s97xuHhWrRP1EgG8kL57QsIK7+9lU/ueM
         2DHE+oWdU3vX38+oLSMJDWukJM8kRbmRqxYKS73U=
Date:   Mon, 1 Jun 2020 14:49:37 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v4 3/6] dmaengine: Add support for repeating transactions
Message-ID: <20200601114937.GC5886@pendragon.ideasonboard.com>
References: <20200513165943.25120-4-laurent.pinchart@ideasonboard.com>
 <20200514182344.GI14092@vkoul-mobl>
 <20200514200709.GL5955@pendragon.ideasonboard.com>
 <20200515083817.GP333670@vkoul-mobl>
 <20200515141101.GA7186@pendragon.ideasonboard.com>
 <d270d4ca-1928-a11a-3186-bc118c4b8756@ti.com>
 <20200518143208.GD5851@pendragon.ideasonboard.com>
 <872d2f33-cdea-34c3-38b4-601d6dae7c94@ti.com>
 <20200528021006.GG4670@pendragon.ideasonboard.com>
 <23b26252-eb7b-f918-759d-0ccda90586b0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23b26252-eb7b-f918-759d-0ccda90586b0@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On Mon, Jun 01, 2020 at 02:14:03PM +0300, Peter Ujfalusi wrote:
> On 28/05/2020 5.10, Laurent Pinchart wrote:
> >>> As mentioned in the commit message, I plan to extend that, I just didn't
> >>> want to add the checks to all the prepare operation wrappers until an
> >>> agreement on the approach would be reached. I also thought it would be
> >>> good to not allow this API for other transaction types until use cases
> >>> arise, in order to force upstream discussions instead of silently
> >>> abusing the API :-)
> >>
> >> I would not object if slave_sg and memcpy got the same treatment. If the
> >> DMA driver did not set the DMA_REPEAT then clients can not use this
> >> feature anyways.
> > 
> > Would you not object, or would you prefer if it was done in v5 ? :-)
> 
> DMA_REPEAT is a generic flag, not limited to only interleaved, but you
> are going to be the first user of it with interleaved.
> 
> > Overall I think that enabling APIs that have no user isn't necessarily
> > the best idea, as it's prone to design issues, but I don't mind doing so
> > if you think it needs to be done now.
> 
> We would get the support in one go with the same commit. I don't think
> it makes much sense to add slave_sg later, then memcpy another time.
> True, there might be no users for them for some time, but their presents
> might invite users?

My approach to API design is that an API designed without (at least) one
user is very prone to be a bad API. As I said before I don't mind
enabling support for slave_sg and memcpy today already, even if I don't
think it's a good idea. I want to get my use case supported, and I've
given up on what I would consider a good API :-) That's fine,
maintainers are the ones who have to support APIs and the design choices
behind them in the longer term, and I'm not a subsystem maintainer here.
I tried to prevent what I think may become a case of shooting in the
foot, but I could be wrong. Only the future will tell.

> >>> I can extend the flag to all other transaction types
> >>> (except for the cyclic transaction, as it doesn't make sense there).
> >>
> >> Yep, cyclic is a different type of transfer, it is for circular buffers.
> >> It could be seen as a special case of slave_sg. Some drivers actually
> >> create temporary sg_list in case of cyclic and use the same setup
> >> function to set up the transfer for slave_sg/cyclic...
> > 
> > Cyclic is different for historical reasons, but if I had to redesign it
> > today, I'd make it slave_sg + DMA_PREP_REPEAT. We obviously can't, and I
> > have no issue with that.
> 
> Which should be accompanied with a flag to tell that the sg_list is
> covering a circular buffer to save all drivers to check the sg_list that
> it is circular buffer (current cyclic) or really sg.
> Some DMA can only do repeat on circular buffers (omap-dma, tegra, etc).

Isn't DMA_PREP_REPEAT that flag ?

> >> But, DMA drivers might support neither of them, either of them or both.
> >> It is up to the client to pick the preferred method for it's use.
> >> It is not far fetched that the next DMA the client is going to be
> >> serviced will have different capabilities and the client needs to handle
> >> EOT or NOW or it might even need to have fallback to case when neither
> >> is supported.
> >>
> >> I don't like excessive flags either, but based on my experience
> >> under-flagging can bite back sooner than later.
> >>
> >> I'm aware that at the moment it feels like it is too explicit, but never
> >> underestimate the creativity of the design - and in some cases the
> >> constraint the design must fulfill.
> > 
> > I'm still very puzzled by why you think adding DMA_PREP_LOAD_EOT now is
> > a good idea, given that there's no existing and no foreseen use case for
> > not setting it. Creating an API element that is completely disconnected
> > from any known use case doesn't seem like good API design to me,
> > especially for an in-kernel API.
> 
> If we document that DMA_REPEAT covers REPEAT _and_ LOAD_EOT with one
> flag then how would other drivers can implement REPEAT if they can not
> support LOAD_EOT?
> They should do DMA_REPEAT | NOT_LOAD_EOT | LOAD_ASAP?

As stated before, I think a DMA_LOAD_EOT capability is useful. My
concern is about DMA_PREP_LOAD_EOT for which I can't see use cases. I've
added DMA_PREP_LOAD_EOT in the last patch series, and my DMA engine
driver ignores the transaction when DMA_PREP_LOAD_EOT is not set, as
required. It works fine as the my client always sets it.

I'd expect Vinod or you to write the documentation though, as writing
code for an API I don't believe in is one thing, writing documentation
to explain the rationale behind the API design will be more complex when
I don't believe there's any rationale :-)

> LOAD_EOT is a feature the HW can or can not support and it is an
> operation mode that you want to use or do not want to use.

DMA_PREP_REPEAT for the EOT mode, DRM_PREP_REPEAT | DMA_PREP_LOAD_NOW
for the immediate mode would work too, and wouldn't have the drawback of
artificially creating a case (!EOT && !NOW) that would fail.

I'm tired of arguing about this and trying to prevent mistakes from
being made, so could you please review the latest patch series, and tell
me if there's anything missing for the implementation ? Feel free to
provide that feedback as patches on top.

-- 
Regards,

Laurent Pinchart
