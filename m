Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A989E2AB81E
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 13:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgKIMXL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 07:23:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgKIMXL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Nov 2020 07:23:11 -0500
Received: from localhost (unknown [122.171.147.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ECBB206CB;
        Mon,  9 Nov 2020 12:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604924591;
        bh=6QWICF9SNtMXta4oNNi5IL/+AwdM20O9Yx4KTjeGjPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oz7GIA73Mom5tCaB682s6aU1fn1ExwkuyBlwsaFyiYlVSDAVZIN57hqoHmcwhvLYB
         uPTXQ/xkiGeSkWRv4Rq0wqRBieaAyP9CGOLcb1vvEgo38rQN3t+7wEwMxBLiqug2+I
         gjVK9MG9KnpH6iUZ6rRZj+mAYipZ/oQDS3Z3xut0=
Date:   Mon, 9 Nov 2020 17:53:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     nm@ti.com, ssantosh@kernel.org, robh+dt@kernel.org,
        vigneshr@ti.com, dan.j.williams@intel.com, t-kristo@ti.com,
        lokeshvutla@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 01/18] dmaengine: of-dma: Add support for optional router
 configuration callback
Message-ID: <20201109122306.GO3171@vkoul-mobl>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-2-peter.ujfalusi@ti.com>
 <20201007054404.GR2968@vkoul-mobl>
 <be615881-1eb4-f8fe-a32d-04fabb6cb27b@ti.com>
 <20201007155533.GZ2968@vkoul-mobl>
 <45adb88b-1ef8-1fbf-08c1-9afc6ea4c6f0@ti.com>
 <20201028055531.GH3550@vkoul-mobl>
 <cf3d3de0-223b-4846-bd9f-b78654ae2d08@ti.com>
 <20201109114534.GH3171@vkoul-mobl>
 <7a7cb455-dd09-b71f-6ecc-fd6108d37051@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a7cb455-dd09-b71f-6ecc-fd6108d37051@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

HI Peter,

On 09-11-20, 14:09, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 09/11/2020 13.45, Vinod Koul wrote:
> >> Without a channel number I can not do anything.
> >> It is close to a chicken and egg problem.
> > 
> > We get 'channel' in xlate, so wont that help? I think I am still missing
> > something here :(
> 
> Yes, we get channel in xlate, but we get the channel after
> ofdma->of_dma_route_allocate()

That is correct, so you need this info in allocate somehow..


> of_dma_route_allocate() si the place where DMA routers create the
> dmaspec for the DMA controller to get a channel and they up until BCDMA
> did also the HW configuration to get the event routed.
> 
> For a BCDMA channel we can have three triggers:
> Global trigger 0 for the channel
> Global trigger 1 for the channel
> Local trigger for the channel
> 
> Every BCDMA channel have these triggers and for all of them they are the
> same (from the channel's pow).
> bchan0 can be triggered by global trigger 0
> bchan1 can be triggered by global trigger 0
> 
> But these triggers are not the same ones, the real trigger depends on
> the router, which of it's input is converted to send out an event to
> trigger bchan0_trigger0 or to trigger bchan1_trigger0.
> 
> When we got the channel with the dmaspec from the router driver then we
> need to tell the router driver that it needs to send a given event in
> order to trigger the channel that we got.
> 
> We can not have traditional binding for BCDMA either where we would tell
> the bchan index to be used because depending on the resource allocation
> done within sysfw that exact channel might not be even available for us.
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
