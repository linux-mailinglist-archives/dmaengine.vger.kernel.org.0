Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3EFEFF7
	for <lists+dmaengine@lfdr.de>; Tue, 30 Apr 2019 07:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfD3Fa5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Apr 2019 01:30:57 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45762 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfD3Fa5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Apr 2019 01:30:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id a10so2009911otl.12
        for <dmaengine@vger.kernel.org>; Mon, 29 Apr 2019 22:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRCavcxLPADLPpht8Z6on0LEjWfPk/EUgU06FZDzQBs=;
        b=dkPagJ0eXYSA35T2kaZcmUZXB2OILKj0nMSYyBST4s2xfakoz85Omi7wWR1V27rKqH
         F8ZjntDv2PEYDd5G71kInVhcH+Sasi8brcqjOSI1puC5I+xu4nE5of/YwxdxOHbY1cWO
         C2u2VcCEessMML8+c3A2YJ/mndkHPDai8p6c/w2DDpqipF/Ck73ivkZwOhKwG59PxMl1
         /IeZZycjferMWsS5sXZ5Eofl3ab6/TjgMvCTg1IzSYuOvzxbbppBp1kS5QZgkZsMH6FK
         wIo8m4/2Ha8dlyIBzDDqjcx3xhGQYwO2ftpBY72oKexg3Oc6G0nlfGEb32cy33w7pSkr
         GKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRCavcxLPADLPpht8Z6on0LEjWfPk/EUgU06FZDzQBs=;
        b=SIPtu1mdmw+11Pnk/RSaomeXjOaPBaTlXQVAv1HDylwoJi4m0Ntr+2D8fAMH5BOhSL
         zAABsqz4kVc4F6XkiX8lqh4PAA+Lm2/b79a5wuKrI4sx+bbLe0jT6p2LD2RHGnbe5bfy
         KZ+gKdr8DT2z7buomPntOFp+X56H9oYPnNmO8h2jMbikxs7OXpkawxCbhbFoYVnM+9gB
         4J0KgsIg4Cew31tl4HISe6/ROqrG1k+mzP+3BS3ioFAwy0Gt+q8J9o/AyDKpdYQuMFjj
         gNCmmHca5YrbIn0im2XVmvsR4rNBmHEffPJAm0JEVLGaA6tIEaLth5kXflP8aonEqebx
         JHaA==
X-Gm-Message-State: APjAAAXGMdaD+n2Z1lZbNbqmJ7g8Wgdb8CsS1xcV8etmlJaAAFWx/NPY
        rjxz3eUsqJsXnmnkaZ4svVPOJJ8oFERaCsetkX2J1g==
X-Google-Smtp-Source: APXvYqyBqdmUVb6VbsoihMRU+eubsmilp+PDOhv3PWxHkWGUYXheXD440opXlENKb9i33kPaQEYmTctFj4rsQ3tn0NY=
X-Received: by 2002:a9d:7ad9:: with SMTP id m25mr41338446otn.75.1556602256776;
 Mon, 29 Apr 2019 22:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555330115.git.baolin.wang@linaro.org> <d77dca51a14087873627d735a17adcfde5517398.1555330115.git.baolin.wang@linaro.org>
 <20190429115723.GK3845@vkoul-mobl.Dlink> <CAMz4kuLf4wgr4Js3xH1aQVc4c2XK1Oq2TnsUq=NSowQUq5ZN5g@mail.gmail.com>
 <20190429140537.GN3845@vkoul-mobl.Dlink>
In-Reply-To: <20190429140537.GN3845@vkoul-mobl.Dlink>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 30 Apr 2019 13:30:45 +0800
Message-ID: <CAMz4ku+ctQrcR+6t1ouakeG3dbgL3qR8fz-Hft4s9FnxtFL1ng@mail.gmail.com>
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

On Mon, 29 Apr 2019 at 22:05, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 29-04-19, 20:20, Baolin Wang wrote:
> > On Mon, 29 Apr 2019 at 19:57, Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > On 15-04-19, 20:14, Baolin Wang wrote:
> > > > From: Eric Long <eric.long@unisoc.com>
> > > >
> > > > Since we can support multiple DMA engine controllers, we should add
> > > > device validation in filter function to check if the correct controller
> > > > to be requested.
> > > >
> > > > Signed-off-by: Eric Long <eric.long@unisoc.com>
> > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > > ---
> > > >  drivers/dma/sprd-dma.c |    5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> > > > index 0f92e60..9f99d4b 100644
> > > > --- a/drivers/dma/sprd-dma.c
> > > > +++ b/drivers/dma/sprd-dma.c
> > > > @@ -1020,8 +1020,13 @@ static void sprd_dma_free_desc(struct virt_dma_desc *vd)
> > > >  static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param)
> > > >  {
> > > >       struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> > > > +     struct of_phandle_args *dma_spec =
> > > > +             container_of(param, struct of_phandle_args, args[0]);
> > > >       u32 slave_id = *(u32 *)param;
> > > >
> > > > +     if (chan->device->dev->of_node != dma_spec->np)
> > >
> > > Are you not using of_dma_find_controller() that does this, so this would
> > > be useless!
> >
> > Yes, we can use of_dma_find_controller(), but that will be a little
> > complicated than current solution. Since we need introduce one
> > structure to save the node to validate in the filter function like
> > below, which seems make things complicated. But if you still like to
> > use of_dma_find_controller(), I can change to use it in next version.
>
> Sorry I should have clarified more..
>
> of_dma_find_controller() is called by xlate, so you already run this
> check, so why use this :)

The of_dma_find_controller() can save the requested device node into
dma_spec, and in the of_dma_simple_xlate() function, it will call
dma_request_channel() to request one channel, but it did not validate
the device node to find the corresponding dma device in
dma_request_channel(). So we should in our filter function to validate
the device node with the device node specified by the dma_spec. Hope I
make things clear.

-- 
Baolin Wang
Best Regards
