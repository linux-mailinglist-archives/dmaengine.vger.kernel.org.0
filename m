Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3616112E9
	for <lists+dmaengine@lfdr.de>; Thu,  2 May 2019 08:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbfEBGB7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 May 2019 02:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbfEBGB6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 May 2019 02:01:58 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D73D92081C;
        Thu,  2 May 2019 06:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556776917;
        bh=xmjxao6gRvI0En8WAcAajp9T9eQuqoeRuLndvm8vViw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boIvWZkbucoiyvNMWxqclmo/Fs0qts4OTUKYY+8APJoiVzsa5XrYJhW7hfk4oebkF
         CdHHpvwXRn3s1XDD/aq29tRuySJU1R8oxQf0SpdnehnAyYdjEtg1UwEg1UlXHf1Shv
         x1KZseE93lglj3m7oCALHkd1hlsTskBQE91BZRiI=
Date:   Thu, 2 May 2019 11:31:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, eric.long@unisoc.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] dmaengine: sprd: Add device validation to support
 multiple controllers
Message-ID: <20190502060148.GH3845@vkoul-mobl.Dlink>
References: <cover.1555330115.git.baolin.wang@linaro.org>
 <d77dca51a14087873627d735a17adcfde5517398.1555330115.git.baolin.wang@linaro.org>
 <20190429115723.GK3845@vkoul-mobl.Dlink>
 <CAMz4kuLf4wgr4Js3xH1aQVc4c2XK1Oq2TnsUq=NSowQUq5ZN5g@mail.gmail.com>
 <20190429140537.GN3845@vkoul-mobl.Dlink>
 <CAMz4ku+ctQrcR+6t1ouakeG3dbgL3qR8fz-Hft4s9FnxtFL1ng@mail.gmail.com>
 <20190430082954.GQ3845@vkoul-mobl.Dlink>
 <CAMz4kuKV3J+aw9sic=QOhmcnr+H_pZ-pmq4pRbLX1R+XAR=phA@mail.gmail.com>
 <CAMz4kuLFyckFdzVgL9FH0xW8036OoAbyjHqfOAVhibPyNssPDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4kuLFyckFdzVgL9FH0xW8036OoAbyjHqfOAVhibPyNssPDA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-04-19, 16:53, Baolin Wang wrote:
> Hi Vinod,
> 
> On Tue, 30 Apr 2019 at 16:34, Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > On Tue, 30 Apr 2019 at 16:30, Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > On 30-04-19, 13:30, Baolin Wang wrote:
> > > > On Mon, 29 Apr 2019 at 22:05, Vinod Koul <vkoul@kernel.org> wrote:
> > > > >
> > > > > On 29-04-19, 20:20, Baolin Wang wrote:
> > > > > > On Mon, 29 Apr 2019 at 19:57, Vinod Koul <vkoul@kernel.org> wrote:
> > > > > > >
> > > > > > > On 15-04-19, 20:14, Baolin Wang wrote:
> > > > > > > > From: Eric Long <eric.long@unisoc.com>
> > > > > > > >
> > > > > > > > Since we can support multiple DMA engine controllers, we should add
> > > > > > > > device validation in filter function to check if the correct controller
> > > > > > > > to be requested.
> > > > > > > >
> > > > > > > > Signed-off-by: Eric Long <eric.long@unisoc.com>
> > > > > > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > > > > > > ---
> > > > > > > >  drivers/dma/sprd-dma.c |    5 +++++
> > > > > > > >  1 file changed, 5 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> > > > > > > > index 0f92e60..9f99d4b 100644
> > > > > > > > --- a/drivers/dma/sprd-dma.c
> > > > > > > > +++ b/drivers/dma/sprd-dma.c
> > > > > > > > @@ -1020,8 +1020,13 @@ static void sprd_dma_free_desc(struct virt_dma_desc *vd)
> > > > > > > >  static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param)
> > > > > > > >  {
> > > > > > > >       struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> > > > > > > > +     struct of_phandle_args *dma_spec =
> > > > > > > > +             container_of(param, struct of_phandle_args, args[0]);
> > > > > > > >       u32 slave_id = *(u32 *)param;
> > > > > > > >
> > > > > > > > +     if (chan->device->dev->of_node != dma_spec->np)
> > > > > > >
> > > > > > > Are you not using of_dma_find_controller() that does this, so this would
> > > > > > > be useless!
> > > > > >
> > > > > > Yes, we can use of_dma_find_controller(), but that will be a little
> > > > > > complicated than current solution. Since we need introduce one
> > > > > > structure to save the node to validate in the filter function like
> > > > > > below, which seems make things complicated. But if you still like to
> > > > > > use of_dma_find_controller(), I can change to use it in next version.
> > > > >
> > > > > Sorry I should have clarified more..
> > > > >
> > > > > of_dma_find_controller() is called by xlate, so you already run this
> > > > > check, so why use this :)
> > > >
> > > > The of_dma_find_controller() can save the requested device node into
> > > > dma_spec, and in the of_dma_simple_xlate() function, it will call
> > > > dma_request_channel() to request one channel, but it did not validate
> > > > the device node to find the corresponding dma device in
> > > > dma_request_channel(). So we should in our filter function to validate
> > > > the device node with the device node specified by the dma_spec. Hope I
> > > > make things clear.
> > >
> > > But dma_request_channel() calls of_dma_request_slave_channel() which
> > > invokes of_dma_find_controller() why is it broken for you if that is the
> > > case..
> >
> > No,the calling process should be:
> > dma_request_slave_channel()
> > --->dma_request_chan()--->of_dma_request_slave_channel()---->of_dma_simple_xlate()
> > ----> dma_request_channel().

The thing is that this is a generic issue, so fix should be in the core
and not in the driver. Agree in you case of_dma_find_controller() is not
invoked, so we should fix that in core

> 
> You can check other drivers, they also will save the device node to
> validate in their filter function.
> For example the imx-sdma driver:
> https://elixir.bootlin.com/linux/v5.1-rc6/source/drivers/dma/imx-sdma.c#L1931

Exactly, more the reason this should be in core :)

-- 
~Vinod
