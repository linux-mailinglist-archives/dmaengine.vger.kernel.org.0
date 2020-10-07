Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1472862B7
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 17:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgJGPzj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 11:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbgJGPzi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Oct 2020 11:55:38 -0400
Received: from localhost (unknown [122.171.222.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28A1A20789;
        Wed,  7 Oct 2020 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086138;
        bh=BwlW5lM9IzbCgjSoHneqUDGEskMzMU8oFit0dRom6qQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mn22y7qe1QHoIEmqTpxMYG9HpGyBe8aHPMOUHwXhWa4NPtifJ64ZVnq4fOsrMMqr9
         7qarzrTuzl4U9wJ+hHvxIu+OrHmrSRrvaS/Cs/yehGegZAPojCHLw8ixU567cU8QDQ
         7Rk39hq40P2dq69R8WE+Lq01fdYQAYYlQrdWUyYM=
Date:   Wed, 7 Oct 2020 21:25:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     nm@ti.com, ssantosh@kernel.org, robh+dt@kernel.org,
        vigneshr@ti.com, dan.j.williams@intel.com, t-kristo@ti.com,
        lokeshvutla@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 01/18] dmaengine: of-dma: Add support for optional router
 configuration callback
Message-ID: <20201007155533.GZ2968@vkoul-mobl>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-2-peter.ujfalusi@ti.com>
 <20201007054404.GR2968@vkoul-mobl>
 <be615881-1eb4-f8fe-a32d-04fabb6cb27b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be615881-1eb4-f8fe-a32d-04fabb6cb27b@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-10-20, 11:08, Peter Ujfalusi wrote:

> Not really. In DT an event triggered channel can be requested via router
> (when this is used) for example:
> 
> dmas = <&inta_l2g a b c>;
> a - the input number of the DMA request in l2g
> b - edge or level trigger to be selected
> c - ASEL number for the channel for coherency
> 
> The l2g router driver then translate this to:
> <&main_bcdma 1 0 c>
> 1 - Global trigger 0 is used by the DMA
> 0 - ignored
> c - ASEL number.
> 
> The router needs to send an event which is going to be received by the
> channel we have picked up, this event number can only be known when we
> do have the channel.
> 
> So the flow in this case:
> router converts the dma_spec for the DMA, but it does not yet know what
> is the event number it has to use.
> The BCDMA driver will pick an available bchan and notes that the
> transfers will be triggered by global event 0.
> When we have the channel, the core saves the router information and
> calls the device_router_config of BCDMA.
> In there we call back to the router and give the event number it has to
> use to send the trigger for the channel.

Ah that is intresting, so you would call router driver foo_set_event()
and would send the event number, why not call that API from alloc
channel or even xlate? Why do you need new callback?
Or did i miss something..

-- 
~Vinod
