Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEE414429
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 06:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfEFEtH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 00:49:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42073 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfEFEtH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 May 2019 00:49:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id k9so8532389oig.9
        for <dmaengine@vger.kernel.org>; Sun, 05 May 2019 21:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GzaHgoeX6HRTRXwU9I5H6cKQKwKQ7SwKMXfF2Gqzjfc=;
        b=QPwyQ3h2uEHwPxv8iaZf6hrszwXTPil84uK8d64fjkCax7hPZu7Le2VNv/hIoCcg30
         KMJzCQm3rouXV//peObIT94XlBSxQsh91n8kAWxkGxmgwVppGJXGYQRXFod4N/A9u6tS
         9+6B2UwXK33scEKkmtgt9CzMCSSGLW10NDv4E1dViftGBsiNLkfgN+FduotdRoEFC8IE
         wjnGk3+2Wfgd9JRtSkqkU0z7lucy4I3ELmbOMj9XHR6w+u1vkw25sJfJuiVCU5P0nSVu
         1jg0wONRtHLRum8M38z3Mftl5XVgtSpUjhFiqJggjYZLJCwitUsKUhxbhA2aOrio2o1C
         ESgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GzaHgoeX6HRTRXwU9I5H6cKQKwKQ7SwKMXfF2Gqzjfc=;
        b=g67EJ2J+KQqUC3GVIDVIOnGz522O1SPZSzHizp2B67vYmptVCK25pnAorhNUwgu+ID
         ZfNXYn3CkaCqQCJzmL35ZYOZyC3J9kw87jg2m/Ksc6ZBXyBux5iQF3M/O8QhS15lB0cm
         baQjyxaW17wlXlOEMZ6FQWrIYntlaZpnkciEiShq4s7xaRsjcUawcK+JCFCfjvd3ynQE
         xQ8r60Fx9QcdQSCmgHbWnxi5FOM7eeRAfWvreU7uV7zLY/izquPKTrJpvlNPj6zeCHfe
         g846pkOyFmLkBrC2gawleJyiOQ9zPWftaG8q4tGrqGfpDn/6B+wb9NYu7ibSDd6kGW0T
         QOQg==
X-Gm-Message-State: APjAAAWjdm5PdPhfxbyGLrCo2R6gdUmI585Zx82z/OtllMhLVd49YqGS
        +lZExAgzVOw7nKdvM9yMzsOL0DlJF7eSXY3cgf5g2w==
X-Google-Smtp-Source: APXvYqwdmhrKDGqSljr1mSaJesF23CESLgd++Xum0FAD3sdqWQS3KgMK0sbiDZqT2hMnnz9C+a1jlWkruqQPG8y93Ec=
X-Received: by 2002:aca:61c3:: with SMTP id v186mr7223512oib.27.1557118146389;
 Sun, 05 May 2019 21:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555330115.git.baolin.wang@linaro.org> <d77dca51a14087873627d735a17adcfde5517398.1555330115.git.baolin.wang@linaro.org>
 <20190429115723.GK3845@vkoul-mobl.Dlink> <CAMz4kuLf4wgr4Js3xH1aQVc4c2XK1Oq2TnsUq=NSowQUq5ZN5g@mail.gmail.com>
 <20190429140537.GN3845@vkoul-mobl.Dlink> <CAMz4ku+ctQrcR+6t1ouakeG3dbgL3qR8fz-Hft4s9FnxtFL1ng@mail.gmail.com>
 <20190430082954.GQ3845@vkoul-mobl.Dlink> <CAMz4kuKV3J+aw9sic=QOhmcnr+H_pZ-pmq4pRbLX1R+XAR=phA@mail.gmail.com>
 <CAMz4kuLFyckFdzVgL9FH0xW8036OoAbyjHqfOAVhibPyNssPDA@mail.gmail.com> <20190502060148.GH3845@vkoul-mobl.Dlink>
In-Reply-To: <20190502060148.GH3845@vkoul-mobl.Dlink>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 6 May 2019 12:48:54 +0800
Message-ID: <CAMz4ku+ayStr4qvpX-ZO_WnrhESp5NrDFbVjC9W7QXiqyx14wA@mail.gmail.com>
Subject: Re: [PATCH 4/7] dmaengine: sprd: Add device validation to support
 multiple controllers
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, eric.long@unisoc.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Thu, 2 May 2019 at 14:01, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 30-04-19, 16:53, Baolin Wang wrote:
> > Hi Vinod,
> >
> > On Tue, 30 Apr 2019 at 16:34, Baolin Wang <baolin.wang@linaro.org> wrote:
> > >
> > > On Tue, 30 Apr 2019 at 16:30, Vinod Koul <vkoul@kernel.org> wrote:
> > > >
> > > > On 30-04-19, 13:30, Baolin Wang wrote:
> > > > > On Mon, 29 Apr 2019 at 22:05, Vinod Koul <vkoul@kernel.org> wrote:
> > > > > >
> > > > > > On 29-04-19, 20:20, Baolin Wang wrote:
> > > > > > > On Mon, 29 Apr 2019 at 19:57, Vinod Koul <vkoul@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On 15-04-19, 20:14, Baolin Wang wrote:
> > > > > > > > > From: Eric Long <eric.long@unisoc.com>
> > > > > > > > >
> > > > > > > > > Since we can support multiple DMA engine controllers, we should add
> > > > > > > > > device validation in filter function to check if the correct controller
> > > > > > > > > to be requested.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Eric Long <eric.long@unisoc.com>
> > > > > > > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > > > > > > > ---
> > > > > > > > >  drivers/dma/sprd-dma.c |    5 +++++
> > > > > > > > >  1 file changed, 5 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> > > > > > > > > index 0f92e60..9f99d4b 100644
> > > > > > > > > --- a/drivers/dma/sprd-dma.c
> > > > > > > > > +++ b/drivers/dma/sprd-dma.c
> > > > > > > > > @@ -1020,8 +1020,13 @@ static void sprd_dma_free_desc(struct virt_dma_desc *vd)
> > > > > > > > >  static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param)
> > > > > > > > >  {
> > > > > > > > >       struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> > > > > > > > > +     struct of_phandle_args *dma_spec =
> > > > > > > > > +             container_of(param, struct of_phandle_args, args[0]);
> > > > > > > > >       u32 slave_id = *(u32 *)param;
> > > > > > > > >
> > > > > > > > > +     if (chan->device->dev->of_node != dma_spec->np)
> > > > > > > >
> > > > > > > > Are you not using of_dma_find_controller() that does this, so this would
> > > > > > > > be useless!
> > > > > > >
> > > > > > > Yes, we can use of_dma_find_controller(), but that will be a little
> > > > > > > complicated than current solution. Since we need introduce one
> > > > > > > structure to save the node to validate in the filter function like
> > > > > > > below, which seems make things complicated. But if you still like to
> > > > > > > use of_dma_find_controller(), I can change to use it in next version.
> > > > > >
> > > > > > Sorry I should have clarified more..
> > > > > >
> > > > > > of_dma_find_controller() is called by xlate, so you already run this
> > > > > > check, so why use this :)
> > > > >
> > > > > The of_dma_find_controller() can save the requested device node into
> > > > > dma_spec, and in the of_dma_simple_xlate() function, it will call
> > > > > dma_request_channel() to request one channel, but it did not validate
> > > > > the device node to find the corresponding dma device in
> > > > > dma_request_channel(). So we should in our filter function to validate
> > > > > the device node with the device node specified by the dma_spec. Hope I
> > > > > make things clear.
> > > >
> > > > But dma_request_channel() calls of_dma_request_slave_channel() which
> > > > invokes of_dma_find_controller() why is it broken for you if that is the
> > > > case..
> > >
> > > No,the calling process should be:
> > > dma_request_slave_channel()
> > > --->dma_request_chan()--->of_dma_request_slave_channel()---->of_dma_simple_xlate()
> > > ----> dma_request_channel().
>
> The thing is that this is a generic issue, so fix should be in the core
> and not in the driver. Agree in you case of_dma_find_controller() is not
> invoked, so we should fix that in core
>
> >
> > You can check other drivers, they also will save the device node to
> > validate in their filter function.
> > For example the imx-sdma driver:
> > https://elixir.bootlin.com/linux/v5.1-rc6/source/drivers/dma/imx-sdma.c#L1931
>
> Exactly, more the reason this should be in core :)

Sorry for late reply due to my holiday.

OK, I can move the fix into the core. So I think I will drop this
patch from my patchset, and I will create another patch set to fix the
device node validation issue with converting other drivers which did
the similar things. Thanks.

-- 
Baolin Wang
Best Regards
