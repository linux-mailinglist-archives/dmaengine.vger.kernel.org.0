Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7CA7026A
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 16:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfGVOgq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 10:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfGVOgq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jul 2019 10:36:46 -0400
Received: from localhost (unknown [223.226.98.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4ED821E70;
        Mon, 22 Jul 2019 14:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563806205;
        bh=rZ3S7qtAJw7MjO8qlaJIqebmCvNMdhxvG0qovndkKSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=npL4rA0oVhUdVsVj6d1PdGVzY8kdu/dXcEmISZlJ+n9RmqaQGoQXiLqeMtsVkku91
         2VAxB5QPcalQTreyws6KFugXy0DRMDs8hx3EG6sfmbR43M9Ii8O0cYq7/DsYHuwxjD
         LcU4ynLLgb4SwaU1FWbblU8sgCpW7GA/KPWhHK3s=
Date:   Mon, 22 Jul 2019 20:05:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/2] [RESEND] dmaengine: omap-dma: make
 omap_dma_filter_fn private
Message-ID: <20190722143533.GX12733@vkoul-mobl.Dlink>
References: <20190722081705.2084961-1-arnd@arndb.de>
 <20190722141240.GT12733@vkoul-mobl.Dlink>
 <CAK8P3a0tHRyjwwHk3tGFA=3dByH4g7R4FobrGC874bW5DJCnNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0tHRyjwwHk3tGFA=3dByH4g7R4FobrGC874bW5DJCnNw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-07-19, 16:22, Arnd Bergmann wrote:
> On Mon, Jul 22, 2019 at 4:13 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 22-07-19, 10:16, Arnd Bergmann wrote:
> > > With the audio driver no longer referring to this function, it
> > > can be made private to the dmaengine driver itself, and the
> > > header file removed.
> > >
> > > Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > Link: https://lore.kernel.org/lkml/20190307151646.1016966-1-arnd@arndb.de/
> >
> > This seems to point to older rev, my script updated it to latest one.
> 
> That was intentional, to see the replies to the last time it got
> posted. I'm not sure if that's the best way to do it, would you
> rather not have that included?

That's a valid point, but should we add both the links or just relevant
one, common sense says former, scripting tends to add so keep both...?

I am thinking of not changing the one submitted and let my
script append. Is that fine?

Thanks
-- 
~Vinod
