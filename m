Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00550257E0D
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 17:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgHaP4s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 11:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgHaP4s (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 11:56:48 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDE6C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 08:56:48 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u24so1368027oic.7
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxF2IjTfZVY+AHoDumD49+xXIS6vNPRTcVtkAX5CzgM=;
        b=bU/a5xl3E6sOc54PrH1qUfqX7a33zncNFNbhY5KwXib+a0mrXNhClr1arHPd8CoPvD
         dt62VOmJf6iwCOIIl/OcLBbI7m1vQnmrMPXBXXFtPTQfs0v0Vnd0Zk2GIQRJdFChcddl
         qFrExJysPBElKwjS+0xJ6Y7KCD4VeYXmzc343oGL/FKeVIvg5v5MjexUjHE5ASJEWRl0
         ySPjOnnkLlTP+ZqMtbImqJfjBxMHpm/wOJ5oWmFlPSXc7VijDHmeuVipEjGQo016Fhhq
         0Yby0sUUK4IB7uNuVWyZYHUlZMsbkzSS3wcGX+D8Gjx9GK0ZXN7bXVRHZwBmOC4+HMYJ
         cKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxF2IjTfZVY+AHoDumD49+xXIS6vNPRTcVtkAX5CzgM=;
        b=KHWZE5mGCVYN5hy+ZkjBGtLntFaY+S0ceYX6jICoKD4TH9T0cBdjcs1L8ySqfsTGMb
         Fy3S2PIRowptpxpSaVrDvmMULT0WposvUmA1TL84KWxGyNcatRLr8Ih1bMD7UOzfjSUU
         uP3BUNdoiHelg8rSa9t+5k56SoeKn79aigNd9tMCtMNJAd/gmcwgL5T/16wcruYSE6+j
         2v2u484SgS8zr4LqFOiAr9CYuUSjaZmssMP93qh8i5sBPtuy8XWKegZwnFps0tzoC4IO
         qvKeOfFQJ0TOHwcwlswBbUTPrMvKeHgtYqwGwZ+hPrA2Im+OD9xefu6evwg1W9T34fWi
         +fhA==
X-Gm-Message-State: AOAM532IJf2q32zqOUQOb/BG59aMA+4ec7fhPIImzYr7HSY34mwZ6msF
        L29/f5Tkm7GN8lrUQDr3vhMR85gCfZUAWlDsRAs=
X-Google-Smtp-Source: ABdhPJxM8KTyq/9x+ilWs8EcMtU3ll5xBoIM4GrViK4ZyItkxLY+TgyQZZaDguGRzkyG4g5OR9H73kLeqtnAPr5Q+uc=
X-Received: by 2002:aca:6c6:: with SMTP id 189mr36797oig.134.1598889407391;
 Mon, 31 Aug 2020 08:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200831103542.305571-1-allen.lkml@gmail.com> <20200831103542.305571-34-allen.lkml@gmail.com>
 <9368c823-4240-4d86-879c-6dae662a36e4@deltatee.com>
In-Reply-To: <9368c823-4240-4d86-879c-6dae662a36e4@deltatee.com>
From:   Allen <allen.lkml@gmail.com>
Date:   Mon, 31 Aug 2020 21:26:35 +0530
Message-ID: <CAOMdWSLoXJFXNARMzOjx3T58cQnLOWG+VK0xNoY4YpGN0e7Lvg@mail.gmail.com>
Subject: Re: [PATCH v3 33/35] dmaengine: plx_dma: convert tasklets to use new
 tasklet_setup() API
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, agross@kernel.org,
        jorn.andersson@linaro.org, green.wan@sifive.com, baohua@kernel.org,
        mripard@kernel.org, wens@csie.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Logan,
> > In preparation for unconditionally passing the
> > struct tasklet_struct pointer to all tasklet
> > callbacks, switch to using the new tasklet_setup()
> > and from_tasklet() to pass the tasklet pointer explicitly.
> >
> > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> > ---
> >  drivers/dma/plx_dma.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
> > index db4c5fd453a9..f387c5bbc170 100644
> > --- a/drivers/dma/plx_dma.c
> > +++ b/drivers/dma/plx_dma.c
> > @@ -241,9 +241,9 @@ static void plx_dma_stop(struct plx_dma_dev *plxdev)
> >       rcu_read_unlock();
> >  }
> >
> > -static void plx_dma_desc_task(unsigned long data)
> > +static void plx_dma_desc_task(struct tasklet_struct *t)
> >  {
> > -     struct plx_dma_dev *plxdev = (void *)data;
> > +     struct plx_dma_dev *plxdev = from_tasklet(plxdev, t, desc_task);
>
> The discussion I saw on another thread suggested the private macro
> from_tasklet() would be replaced with something generic. So isn't this
> patchset a bit premature?

 Yes, but efforts to replace it with something generic was not well accepted.
We were left with either using a private macro from_tasklet() or use
well known container_of().  I have left it to the maintainers to decide
which one they prefer.

-- 
       - Allen
