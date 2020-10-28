Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C4B29DEB4
	for <lists+dmaengine@lfdr.de>; Thu, 29 Oct 2020 01:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbgJ2A4D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Oct 2020 20:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731634AbgJ1WRh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:37 -0400
Received: from localhost (unknown [122.171.163.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3FBF22282;
        Wed, 28 Oct 2020 05:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603864535;
        bh=YL9F7NFEQA3XJe6aApxjZAFjPklCc6E43qzDsNEV6Us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cZShr1UTiyMXegt5DjCd8OdyFwOLfZ7uj1119xrTdQpg00zbJ/qdN5m+DALZoWubx
         IG7UFJG4lkPbaQUQzGo1Jieo3/2ywtlSVrwdsn08lQPeiRo2Xms1azbFsFi6IIsx/8
         t90kptCYKhbLviomI3Q+DAB7wzGQOCC24aQ2eBcw=
Date:   Wed, 28 Oct 2020 11:25:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     nm@ti.com, ssantosh@kernel.org, robh+dt@kernel.org,
        vigneshr@ti.com, dan.j.williams@intel.com, t-kristo@ti.com,
        lokeshvutla@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 01/18] dmaengine: of-dma: Add support for optional router
 configuration callback
Message-ID: <20201028055531.GH3550@vkoul-mobl>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-2-peter.ujfalusi@ti.com>
 <20201007054404.GR2968@vkoul-mobl>
 <be615881-1eb4-f8fe-a32d-04fabb6cb27b@ti.com>
 <20201007155533.GZ2968@vkoul-mobl>
 <45adb88b-1ef8-1fbf-08c1-9afc6ea4c6f0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45adb88b-1ef8-1fbf-08c1-9afc6ea4c6f0@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-10-20, 09:41, Peter Ujfalusi wrote:
> 
> 
> On 07/10/2020 18.55, Vinod Koul wrote:
> > On 07-10-20, 11:08, Peter Ujfalusi wrote:
> > 
> >> Not really. In DT an event triggered channel can be requested via router
> >> (when this is used) for example:
> >>
> >> dmas = <&inta_l2g a b c>;
> >> a - the input number of the DMA request in l2g
> >> b - edge or level trigger to be selected
> >> c - ASEL number for the channel for coherency
> >>
> >> The l2g router driver then translate this to:
> >> <&main_bcdma 1 0 c>
> >> 1 - Global trigger 0 is used by the DMA
> >> 0 - ignored
> >> c - ASEL number.
> >>
> >> The router needs to send an event which is going to be received by the
> >> channel we have picked up, this event number can only be known when we
> >> do have the channel.
> >>
> >> So the flow in this case:
> >> router converts the dma_spec for the DMA, but it does not yet know what
> >> is the event number it has to use.
> >> The BCDMA driver will pick an available bchan and notes that the
> >> transfers will be triggered by global event 0.
> >> When we have the channel, the core saves the router information and
> >> calls the device_router_config of BCDMA.
> >> In there we call back to the router and give the event number it has to
> >> use to send the trigger for the channel.
> > 
> > Ah that is intresting, so you would call router driver foo_set_event()
> > and would send the event number
> 
> Yes, that's correct.
> 
> > why not call that API from alloc
> > channel or even xlate?
> 
> at alloc / xlate time the DMA driver does not have information about
> router. The alloc/xlate will result the channel, but in my case it will
> result a broken setup as the router does not know which event to send.
> 
> > Why do you need new callback?
> 
> When I added the DMA event router support, it was designed in a way that
> the DMA driver itself must not know anything about the router, it has to
> be transparent. One can just add a router on front of any DMA and
> everything will work.
> This is the right thing to do, and it works for existing setups.
> 
> > Or did i miss something..
> 
> The BCDMA triggered channel setup is a chicken-egg setup.
> For this case the channel can be triggered by a global event. A channel
> can receive two global event, but this is not a concern atm.
> The event number depends on the channel we use, for simplicity let's
> say: bchan_id + trigger_offset = bchan_trigger_evt.
> 
> of_dma_router_xlate does this:
> 
> 1. calls the dma router's of_dma_route_allocate callback to allocate a
> route and craft a dma_spec for the DMA to configure a channel.
> 
> 2. using this crafted dma_spec we request a channel via of_dma_xlate
> callback
> 
> 3. if we got the channel, we save the router information, so it can be
> deallocated when the channel is disabled.
> 
> I need a fourth step to do a final configuration since only at this time
> (after it has been allocated) the channel has information about possible
> router.
> 
> In the new optional callback the DMA driver can figure out the event
> number which must be used by the router to send the event to the desired
> global event target of the channel.
> 
> Other DMAs might need something different, but imho if there is going to
> be a need for such post alloc router config, then it is most likely will
> come from the need to feed back some sort of channel information to the
> router. Or take parameter from the router itself for the channel.
> 
> To summarize:
> In of_dma_route_allocate() the router does not yet know the channel we
> are going to get.
> In of_dma_xlate() the DMA driver does not yet know if the channel will
> use router or not.
> I need to tell the router the event number it has to send, which is
> based on the channel number I got.

Sounds reasonable, btw why not pass this information in xlate. Router
will have a different xlate rather than non router right, or is it same.

If this information is anyway available in DT might be better to get it
and use from DT

Thanks

-- 
~Vinod
