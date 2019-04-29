Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 726FAE438
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2019 16:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfD2OFp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Apr 2019 10:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbfD2OFp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Apr 2019 10:05:45 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F7F421655;
        Mon, 29 Apr 2019 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556546744;
        bh=qVipqbpF74NslrIJAp2+g2vf/JWQWFLexrajOnRDUME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p3+1k8xq616yFT7vtr8zz46qwCOa5a6V/y261xa0fS2qnBYuLYJyKsbAYmM7hLitL
         fjn8DDIuZaH2gGmzjcNxTjXKiK/x1c4nBCPY41rJshPGlL3B1JbdGz1J2YH18KI2J1
         vZrKmC68zix+9Akq8rvNGJvMTflpDK+LzAw7mcRU=
Date:   Mon, 29 Apr 2019 19:35:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, eric.long@unisoc.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] dmaengine: sprd: Add device validation to support
 multiple controllers
Message-ID: <20190429140537.GN3845@vkoul-mobl.Dlink>
References: <cover.1555330115.git.baolin.wang@linaro.org>
 <d77dca51a14087873627d735a17adcfde5517398.1555330115.git.baolin.wang@linaro.org>
 <20190429115723.GK3845@vkoul-mobl.Dlink>
 <CAMz4kuLf4wgr4Js3xH1aQVc4c2XK1Oq2TnsUq=NSowQUq5ZN5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4kuLf4wgr4Js3xH1aQVc4c2XK1Oq2TnsUq=NSowQUq5ZN5g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-04-19, 20:20, Baolin Wang wrote:
> On Mon, 29 Apr 2019 at 19:57, Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 15-04-19, 20:14, Baolin Wang wrote:
> > > From: Eric Long <eric.long@unisoc.com>
> > >
> > > Since we can support multiple DMA engine controllers, we should add
> > > device validation in filter function to check if the correct controller
> > > to be requested.
> > >
> > > Signed-off-by: Eric Long <eric.long@unisoc.com>
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  drivers/dma/sprd-dma.c |    5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> > > index 0f92e60..9f99d4b 100644
> > > --- a/drivers/dma/sprd-dma.c
> > > +++ b/drivers/dma/sprd-dma.c
> > > @@ -1020,8 +1020,13 @@ static void sprd_dma_free_desc(struct virt_dma_desc *vd)
> > >  static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param)
> > >  {
> > >       struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> > > +     struct of_phandle_args *dma_spec =
> > > +             container_of(param, struct of_phandle_args, args[0]);
> > >       u32 slave_id = *(u32 *)param;
> > >
> > > +     if (chan->device->dev->of_node != dma_spec->np)
> >
> > Are you not using of_dma_find_controller() that does this, so this would
> > be useless!
> 
> Yes, we can use of_dma_find_controller(), but that will be a little
> complicated than current solution. Since we need introduce one
> structure to save the node to validate in the filter function like
> below, which seems make things complicated. But if you still like to
> use of_dma_find_controller(), I can change to use it in next version.

Sorry I should have clarified more..

of_dma_find_controller() is called by xlate, so you already run this
check, so why use this :)

-- 
~Vinod
