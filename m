Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F802AB76E
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 12:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgKILpj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 06:45:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729159AbgKILpj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Nov 2020 06:45:39 -0500
Received: from localhost (unknown [122.171.147.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B028220789;
        Mon,  9 Nov 2020 11:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604922338;
        bh=Sq0xvvrUlIfUwrgwd92TUa8sP2wVyduYHpqVBUexjyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cLqQqk/p1pbkgyb4xv019WYnwbtfrM4irwnMHcsw5NTxs5WOLNWgc31fOIxprnAVz
         SaQ5GKwKM53UGzS3a5TM8BEVpa2YjoO+aoglUHxGw+TqT9uxVtrPOtNdwMxq+SkvYA
         EkjF3VJ8SPvcINWwwSK3G9vpXyvqAqm12IhyulEo=
Date:   Mon, 9 Nov 2020 17:15:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     nm@ti.com, ssantosh@kernel.org, robh+dt@kernel.org,
        vigneshr@ti.com, dan.j.williams@intel.com, t-kristo@ti.com,
        lokeshvutla@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 01/18] dmaengine: of-dma: Add support for optional router
 configuration callback
Message-ID: <20201109114534.GH3171@vkoul-mobl>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-2-peter.ujfalusi@ti.com>
 <20201007054404.GR2968@vkoul-mobl>
 <be615881-1eb4-f8fe-a32d-04fabb6cb27b@ti.com>
 <20201007155533.GZ2968@vkoul-mobl>
 <45adb88b-1ef8-1fbf-08c1-9afc6ea4c6f0@ti.com>
 <20201028055531.GH3550@vkoul-mobl>
 <cf3d3de0-223b-4846-bd9f-b78654ae2d08@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3d3de0-223b-4846-bd9f-b78654ae2d08@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


Hey Peter,

On 28-10-20, 11:56, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 28/10/2020 7.55, Vinod Koul wrote:
> 
> >> To summarize:
> >> In of_dma_route_allocate() the router does not yet know the channel we
> >> are going to get.
> >> In of_dma_xlate() the DMA driver does not yet know if the channel will
> >> use router or not.
> >> I need to tell the router the event number it has to send, which is
> >> based on the channel number I got.
> > 
> > Sounds reasonable, btw why not pass this information in xlate. Router
> > will have a different xlate rather than non router right, or is it same.
> 
> Yes, the router's have their separate xlate, but in that xlate we do not
> yet have a channel. I don't know what is the event I need to send from
> the router to trigger the channel.
> 
> > If this information is anyway available in DT might be better to get it
> > and use from DT
> 
> Without a channel number I can not do anything.
> It is close to a chicken and egg problem.

We get 'channel' in xlate, so wont that help? I think I am still missing
something here :(


-- 
~Vinod
