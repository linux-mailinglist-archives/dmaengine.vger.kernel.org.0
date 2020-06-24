Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90615206E2B
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 09:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390014AbgFXHtK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 03:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390013AbgFXHtK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Jun 2020 03:49:10 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33646C061573;
        Wed, 24 Jun 2020 00:49:10 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id o5so1106836iow.8;
        Wed, 24 Jun 2020 00:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMLtUyyLaeGE1Rn+RkOTJ2DJsfDwk7l2d3YRRlgm31o=;
        b=GMOEE2Aka1QlX9FIQVJl66QctjiCb0XiJacypZj3tcoGy1G9k9XfYETKKmM1a/oj7o
         xdGpc2tIhuF+bDtUMn9f8Yw/dFmzQ/YFNp3xIurzF3JwwJ0qdhGdgf0H8hOW+DPyzg6K
         7fRNcnLdA5L730dHt0w4xejiidfHS++GxJqx3O1eirdtCZMUXTslm8ddsiHsBiy9deA+
         1gkReav+ZWgFcvQ1bgt3sWUxdR7vjndM71DYbx3YZ+QZj2SADIGwsRmegJNuOHhOsgCg
         aCGoSXZmXE8nsKCgozBPX9phPtcxkDDPjN1vkX+Xsg0uKkEtZfWCmoNv1oHhLayoZkOl
         VfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMLtUyyLaeGE1Rn+RkOTJ2DJsfDwk7l2d3YRRlgm31o=;
        b=To3tb4MlecFyJbjr6Gd6hPgzFs/oGwHyL+QgGaM19Ze0ETbkeel6xyzziTdIVO4/u7
         4MXYNzwKlpCeVOgRQYmI1VlBgzKfJXFxCZz7y4omD2zfE6nngZD6Mjwhr/we4ZZdsU8N
         F/M7IC14U9fIm6CU8kyGbi1SmiFEIBka6ddwANGoU0hGwVrErage5sGCIoJPIfbFT/Kh
         7LdiTvl2g775HytbAvujcSDQ8SE9DLZXJXEE+lKBErOU5/VmPcxtAOB3HfX4fbQwHVuJ
         2OMBgY7LtpcgGzJeu75AwLS4cdO2Mn7Qt6kDwIF88aK/xUsL8KIxJrTIc8B0zW53QaSM
         GZPg==
X-Gm-Message-State: AOAM533SqDx0BAXqStVf9LDXcTPiZF26bI9n9/PePF3gIAByUbdBcAgK
        3HthgsWhMR1heJi9HsGFBAe6MbwWTAIFOAJv8pE=
X-Google-Smtp-Source: ABdhPJxbMiUffQwZWQ2UYDzKfRDx3+8H0TxEgs2Hi4DaFt/LCSVVqMasK98uer8zv/ZRuV7r2kzL7kWtnNEiZIzxaCs=
X-Received: by 2002:a5e:8d15:: with SMTP id m21mr4447306ioj.60.1592984949433;
 Wed, 24 Jun 2020 00:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200603183410.76764-1-navid.emamdoost@gmail.com> <20200624073932.GO2324254@vkoul-mobl>
In-Reply-To: <20200624073932.GO2324254@vkoul-mobl>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Wed, 24 Jun 2020 02:48:58 -0500
Message-ID: <CAEkB2EQ6AquKCexaaauHcsQXP4Y5hsri5FqehKqiw7deex5kQw@mail.gmail.com>
Subject: Re: [PATCH] engine: stm32-dma: call pm_runtime_put if
 pm_runtime_get_sync fails
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On Wed, Jun 24, 2020 at 2:39 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 03-06-20, 13:34, Navid Emamdoost wrote:
> > Calling pm_runtime_get_sync increments the counter even in case of
> > failure, causing incorrect ref count. Call pm_runtime_put if
> > pm_runtime_get_sync fails.
>
> pls fix subsystem name as dmaengine: ...
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  drivers/dma/stm32-dma.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
> > index 0ddbaa4b4f0b..0aab86bd97fe 100644
> > --- a/drivers/dma/stm32-dma.c
> > +++ b/drivers/dma/stm32-dma.c
> > @@ -1169,8 +1169,10 @@ static int stm32_dma_alloc_chan_resources(struct dma_chan *c)
> >       chan->config_init = false;
> >
> >       ret = pm_runtime_get_sync(dmadev->ddev.dev);
> > -     if (ret < 0)
> > +     if (ret < 0) {
> > +             pm_runtime_put(dmadev->ddev.dev);
> >               return ret;
> > +     }
> >
> >       ret = stm32_dma_disable_chan(chan);
> >       if (ret < 0)
> > @@ -1439,8 +1441,10 @@ static int stm32_dma_suspend(struct device *dev)
> >       int id, ret, scr;
> >
> >       ret = pm_runtime_get_sync(dev);
> > -     if (ret < 0)
> > +     if (ret < 0) {
> > +             pm_runtime_put_sync(dev);
>
> why put_sync()

My bad! I will fix it.

> >               return ret;
> > +     }
> >
> >       for (id = 0; id < STM32_DMA_MAX_CHANNELS; id++) {
> >               scr = stm32_dma_read(dmadev, STM32_DMA_SCR(id));
> > --
> > 2.17.1
>
> --
> ~Vinod



-- 
Navid.
