Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F36E1C6
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2019 14:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfD2MCe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Apr 2019 08:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbfD2MCe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Apr 2019 08:02:34 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD5A620656;
        Mon, 29 Apr 2019 12:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556539353;
        bh=0fAd9AoGr69X9GfL20SKcwdKwfBh6tMYGRr0gGW/6yY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T4ZKXyTNJ7Auyyuee/PNCCGDqOEsBdpwQ2YagiFtiJNUlofMrkNIFDVPBh6vGubfl
         5R8fMqJKKLfihjnSFJDq0dmzDpxG/j/tmEn6bCVwxgie3jolXFSCXR8t4gttm3009g
         7bAoG2A6YhWqRN84gBHqtKVGuTHBybNxlOGWf4iw=
Date:   Mon, 29 Apr 2019 17:32:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, eric.long@unisoc.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] dmaengine: sprd: Fix the possible crash when getting
 engine status
Message-ID: <20190429120221.GM3845@vkoul-mobl.Dlink>
References: <cover.1555330115.git.baolin.wang@linaro.org>
 <2eecd528e85377f03e6fbc5e7d6544b9c9f59cb1.1555330115.git.baolin.wang@linaro.org>
 <20190429113555.GI3845@vkoul-mobl.Dlink>
 <CAMz4kuK0jurdNX3Z+zH5_ErR-64k2-Nuw_1T+X4OjbjURDSnUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4kuK0jurdNX3Z+zH5_ErR-64k2-Nuw_1T+X4OjbjURDSnUA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-04-19, 19:49, Baolin Wang wrote:
> Hi Vinod,
> 
> On Mon, 29 Apr 2019 at 19:36, Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 15-04-19, 20:14, Baolin Wang wrote:
> > > We will get a NULL virtual descriptor by vchan_find_desc() when the descriptor
> > > has been submitted, that will crash the kernel when getting the engine status.
> >
> > No that is wrong, status is for descriptor and not engine!
> 
> Sure, will fix the commit message.
> 
> >
> > > In this case, since the descriptor has been submitted, which means the pointer
> > > 'schan->cur_desc' will point to the current descriptor, then we can use
> > > 'schan->cur_desc' to get the engine status to avoid this issue.
> >
> > Nope, since the descriptor is completed, you return with residue as 0
> > and DMA_COMPLETE status!
> 
> No, the descriptor is not completed now. If it is completed, we will
> return 0 with DMA_COMPLETE status. But now the descriptor is on
> progress, we should get the descriptor to return current residue.
> Sorry for confusing description.

OKay will wait for updated description to understand the fix

> 
> >
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  drivers/dma/sprd-dma.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> > > index 48431e2..e29342a 100644
> > > --- a/drivers/dma/sprd-dma.c
> > > +++ b/drivers/dma/sprd-dma.c
> > > @@ -625,7 +625,7 @@ static enum dma_status sprd_dma_tx_status(struct dma_chan *chan,
> > >               else
> > >                       pos = 0;
> > >       } else if (schan->cur_desc && schan->cur_desc->vd.tx.cookie == cookie) {
> > > -             struct sprd_dma_desc *sdesc = to_sprd_dma_desc(vd);
> > > +             struct sprd_dma_desc *sdesc = schan->cur_desc;
> > >
> > >               if (sdesc->dir == DMA_DEV_TO_MEM)
> > >                       pos = sprd_dma_get_dst_addr(schan);
> > > --
> > > 1.7.9.5
> >
> > --
> > ~Vinod
> 
> 
> 
> -- 
> Baolin Wang
> Best Regards

-- 
~Vinod
