Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB2325189F
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 14:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHYMeu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 08:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHYMes (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 08:34:48 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7878AC061574;
        Tue, 25 Aug 2020 05:34:48 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id a6so2654088oog.9;
        Tue, 25 Aug 2020 05:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8STidKdjB3IAsSg9qwMG6/fnbTG9ueb7BIUx1fPaPdM=;
        b=EkXhmIeyqrFX4pTjEOdzP/jGeBGkdRMiIPackjwd0wko0Uj4wDHsnTqJgmE/DUMoOC
         7UM2Ma7p67yIwuDuwdq0mgDsKjxEhDGZMd3UWwWr9xXzO3XiFPdfZsfq+Ybu18CJpCmv
         sXA6HfyteNRB35O6jz+EhrtqehZZxQofMP/ar5YWVagBCdMGwjiqJ6yJ6q1Hp0knCTct
         aFtdRkXwm9KZexzNqUipJ2ymmG0sdCjJldCZKNtdIkR85mQeiCYyMmw5x/pJdFJ1VjcP
         rCPFgsIJBtyhUZXXDg+oIHHSImxO+1/EvkVPy+bXhZ9PRswqPxoROp7rklfG/xgMCD4C
         G+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8STidKdjB3IAsSg9qwMG6/fnbTG9ueb7BIUx1fPaPdM=;
        b=n1cnoctdPTt2h7EUXpW/J0FqOsXO5gJ1amXYZj7qdw8KQaWjkIYn0irRYjbLTV5o2u
         VsMCAw7A1B+UN6Z33RlsBz3wHo8K5JW6irqQlqNoMOYg23QJFcDq8BHQxT9ZpOJ2RVhK
         mDvJRrWtPIsup6lyYvFS8NkvEwBW/zxJpH4RP7m27abAArG0c7Me02xOkMCJUawXAMaS
         ZnQeK6hdhSSlBMYHkPAVvjscdimqIZHbBglGZUtrzb3TgIzNARzqAKuitzoYHBHZa2re
         vFs8X7qNB9HhR3K4AsU9GvAMQn6I0IoRvD0zk/nAb560Ats/NK6gFpHBFxbsL2ykK4H1
         iexA==
X-Gm-Message-State: AOAM530Gu6OVnrEVQX6FV4QZgHiDdKLmk0EHVRVkKZWRADy5rRjUSN+c
        eA/OvCk9m4qpQzZNJOT1t5J5yHziLGRiTp/z2rw=
X-Google-Smtp-Source: ABdhPJyaNv6o4uVnFGumvl1cK7gZdIPeLXqVmwVKwDEiu2FCFHEKUVACuI2WumJhRdItKWAqsIjyLUZJMeK+/egbH10=
X-Received: by 2002:a4a:380b:: with SMTP id c11mr6876012ooa.17.1598358887626;
 Tue, 25 Aug 2020 05:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200819071633.76494-1-alexandru.ardelean@analog.com>
 <20200819071633.76494-2-alexandru.ardelean@analog.com> <20200825112435.GO2639@vkoul-mobl>
In-Reply-To: <20200825112435.GO2639@vkoul-mobl>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 25 Aug 2020 15:34:36 +0300
Message-ID: <CA+U=DspxU+Fo3Ynwr0ST2pyNW8Hrie=r0N2QZGrgiEqMvpicuA@mail.gmail.com>
Subject: Re: [PATCH 2/5] dmaengine: axi-dmac: move clock enable earlier
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Aug 25, 2020 at 2:24 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 19-08-20, 10:16, Alexandru Ardelean wrote:
> > The clock may also be required to read registers from the IP core (if it is
> > provided and the driver needs to control it).
> > So, move it earlier in the probe.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/dma/dma-axi-dmac.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > index 088c79137398..07665c60c21b 100644
> > --- a/drivers/dma/dma-axi-dmac.c
> > +++ b/drivers/dma/dma-axi-dmac.c
> > @@ -850,6 +850,10 @@ static int axi_dmac_probe(struct platform_device *pdev)
> >       if (IS_ERR(dmac->clk))
> >               return PTR_ERR(dmac->clk);
> >
> > +     ret = clk_prepare_enable(dmac->clk);
> > +     if (ret < 0)
> > +             return ret;
> > +
> >       INIT_LIST_HEAD(&dmac->chan.active_descs);
>
> Change is fine, but then you need to jump to err_clk_disable in few
> place below this and not return error

oops;
thanks for catching this;
will send a v2

>
> >
> >       of_channels = of_get_child_by_name(pdev->dev.of_node, "adi,channels");
> > @@ -892,10 +896,6 @@ static int axi_dmac_probe(struct platform_device *pdev)
> >       dmac->chan.vchan.desc_free = axi_dmac_desc_free;
> >       vchan_init(&dmac->chan.vchan, dma_dev);
> >
> > -     ret = clk_prepare_enable(dmac->clk);
> > -     if (ret < 0)
> > -             return ret;
> > -
> >       version = axi_dmac_read(dmac, ADI_AXI_REG_VERSION);
> >
> >       ret = axi_dmac_detect_caps(dmac, version);
> > --
> > 2.17.1
>
> --
> ~Vinod
