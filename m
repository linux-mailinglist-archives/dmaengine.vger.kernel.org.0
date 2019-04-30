Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5A5BF203
	for <lists+dmaengine@lfdr.de>; Tue, 30 Apr 2019 10:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfD3IaE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Apr 2019 04:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfD3IaE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Apr 2019 04:30:04 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA0212080C;
        Tue, 30 Apr 2019 08:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556613003;
        bh=L44o5mnTaulGd8/A/x404M3tsCXjrGsZL4cOq+2J79A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a19ABJwBx7uM7bDncmxkYDjL+4cW9Ip/BQrprS8FSfQXXRboeP3bVIE7U/mJ7wvQH
         LSOn92WOL65zOTtCmoez8V+TLqEfF7jttCeJsLxHHQ4H94Vy5XrzNSf5NV4yuwfyAA
         bcyUr4NhvaYKPTR0QXQWeLm61SIpN7FfUmFvhlw4=
Date:   Tue, 30 Apr 2019 13:59:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, eric.long@unisoc.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] dmaengine: sprd: Add device validation to support
 multiple controllers
Message-ID: <20190430082954.GQ3845@vkoul-mobl.Dlink>
References: <cover.1555330115.git.baolin.wang@linaro.org>
 <d77dca51a14087873627d735a17adcfde5517398.1555330115.git.baolin.wang@linaro.org>
 <20190429115723.GK3845@vkoul-mobl.Dlink>
 <CAMz4kuLf4wgr4Js3xH1aQVc4c2XK1Oq2TnsUq=NSowQUq5ZN5g@mail.gmail.com>
 <20190429140537.GN3845@vkoul-mobl.Dlink>
 <CAMz4ku+ctQrcR+6t1ouakeG3dbgL3qR8fz-Hft4s9FnxtFL1ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4ku+ctQrcR+6t1ouakeG3dbgL3qR8fz-Hft4s9FnxtFL1ng@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-04-19, 13:30, Baolin Wang wrote:
> On Mon, 29 Apr 2019 at 22:05, Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 29-04-19, 20:20, Baolin Wang wrote:
> > > On Mon, 29 Apr 2019 at 19:57, Vinod Koul <vkoul@kernel.org> wrote:
> > > >
> > > > On 15-04-19, 20:14, Baolin Wang wrote:
> > > > > From: Eric Long <eric.long@unisoc.com>
> > > > >
> > > > > Since we can support multiple DMA engine controllers, we should add
> > > > > device validation in filter function to check if the correct controller
> > > > > to be requested.
> > > > >
> > > > > Signed-off-by: Eric Long <eric.long@unisoc.com>
> > > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > > > ---
> > > > >  drivers/dma/sprd-dma.c |    5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> > > > > index 0f92e60..9f99d4b 100644
> > > > > --- a/drivers/dma/sprd-dma.c
> > > > > +++ b/drivers/dma/sprd-dma.c
> > > > > @@ -1020,8 +1020,13 @@ static void sprd_dma_free_desc(struct virt_dma_desc *vd)
> > > > >  static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param)
> > > > >  {
> > > > >       struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> > > > > +     struct of_phandle_args *dma_spec =
> > > > > +             container_of(param, struct of_phandle_args, args[0]);
> > > > >       u32 slave_id = *(u32 *)param;
> > > > >
> > > > > +     if (chan->device->dev->of_node != dma_spec->np)
> > > >
> > > > Are you not using of_dma_find_controller() that does this, so this would
> > > > be useless!
> > >
> > > Yes, we can use of_dma_find_controller(), but that will be a little
> > > complicated than current solution. Since we need introduce one
> > > structure to save the node to validate in the filter function like
> > > below, which seems make things complicated. But if you still like to
> > > use of_dma_find_controller(), I can change to use it in next version.
> >
> > Sorry I should have clarified more..
> >
> > of_dma_find_controller() is called by xlate, so you already run this
> > check, so why use this :)
> 
> The of_dma_find_controller() can save the requested device node into
> dma_spec, and in the of_dma_simple_xlate() function, it will call
> dma_request_channel() to request one channel, but it did not validate
> the device node to find the corresponding dma device in
> dma_request_channel(). So we should in our filter function to validate
> the device node with the device node specified by the dma_spec. Hope I
> make things clear.

But dma_request_channel() calls of_dma_request_slave_channel() which
invokes of_dma_find_controller() why is it broken for you if that is the
case..

-- 
~Vinod
