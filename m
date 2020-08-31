Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6A6257373
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 08:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgHaGAU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 02:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaGAT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 02:00:19 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D50AC061573
        for <dmaengine@vger.kernel.org>; Sun, 30 Aug 2020 23:00:19 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e23so4376634otk.7
        for <dmaengine@vger.kernel.org>; Sun, 30 Aug 2020 23:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=plTdrl7JG6lx7NqHoaQdbmpYAvyLHsYJ05zYFCyaG8I=;
        b=l1F/hIhjwfPAORrx7QkDcGG8Pp83s3olyh/rB90zSSoboPqfmO3Aj0A9aeW5vvVXcH
         +dNWXaBAo2JqkLTJhyd+WzedzDNG71iR4bZAgeZJiMiw0ix5NSQHWQo/ubGOpad1q4iI
         sgw7JsJlFJ4wW50dhpsfTckTxLuqcG9BQat2fPyqzcbXl7D/k913Ht5kYQzWrPOO7GE+
         i3IdZIV38rCRFxQe36ksnbpBiK1NYwSJ8MbKT5Kb9X0koOzTDrdF9aoaepicNnIiBrsR
         mwMMwzT3k1IDgaBzFXz2EyUqjcJVlOT+LTJipO2pMuzxE/Nh4l1SpFXVqCkb6lsahGZy
         YyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plTdrl7JG6lx7NqHoaQdbmpYAvyLHsYJ05zYFCyaG8I=;
        b=tTpDTpwaxov9OPiG3a46dZjmIDkV1+oOgwwip8jC5L3na/BRYORQKmOkP3tA9u4uO9
         LG1W+NG1KAzP3cPGBFGu4VdCGTuD+6sl3zDmWzPh3Oy2XMTy67f6PwQhDR+SWdNbgR95
         qsorf2aYF7sKXkIPxFCt14LczPxSPepFDxK5mqDpNcgCmRjr3bRIMdocD8pUNATdfz89
         PCeO6X5A5FV/P2CHccV0URwwCsz6SkMxGN7mgT4LkUlm+HbuQzD2R1tWGWmuJxBVFcyo
         AkeuzbRW9w5yfIBSt2zNml94NBiwsBBjOrKEHF+cHxvbixY8O9bOhZP7DboT37NtPeaF
         VAEA==
X-Gm-Message-State: AOAM531kjoDT3AKJDSfI2e7wfDJfYLOm8pEyKOf5lhAYcjCfEF4H8XFI
        FJg3mg4nG3Btdrbty+etLT7mTIfEZjctMWW03NQ=
X-Google-Smtp-Source: ABdhPJwpCPUENfnRUT1/2cpbqy6ZVeEfiYgSGIuw/RKKpoU93FyftjrVhqHpnMbFGp8f/CseMplpZmNKNeu2ImsiCS0=
X-Received: by 2002:a05:6830:2246:: with SMTP id t6mr63148otd.264.1598853618798;
 Sun, 30 Aug 2020 23:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200818090638.26362-1-allen.lkml@gmail.com> <20200825110331.GG2639@vkoul-mobl>
 <CAOMdWSKvj9Bwt_JpJ072c-LYKRO4aA+vEPyJLZSYgMvuXhTBmQ@mail.gmail.com> <20200826042841.GV2639@vkoul-mobl>
In-Reply-To: <20200826042841.GV2639@vkoul-mobl>
From:   Allen <allen.lkml@gmail.com>
Date:   Mon, 31 Aug 2020 11:30:07 +0530
Message-ID: <CAOMdWS+ZE8hKwVPT=XQVHoZ3uX-Wr7Ao=WxyT8JPzN_4NR2DbA@mail.gmail.com>
Subject: Re: [PATCH 00/35] dma: convert tasklets to use new tasklet_setup()
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod,
> > > > Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
> > > > introduced a new tasklet initialization API. This series converts
> > > > all the dma drivers to use the new tasklet_setup() API
> > > >
> > > > This is based on 5.9-rc1.
> > > >
> > > > Please pick this series, as I missed updating a couple of fixes and marking
> > > > the correct mailing list.
> > >
> > > The patches should have been tagged "dmaengine: ...".
> >
> >  My bad, Will have it fixed.
> >
> > >
> > > What is the status of this API conversion, I think I saw some
> > > discussions on API change, what is the conclusion?
> >
> >  Yes, the updated API should land into Linus's tree shortly.
> > Will send out V2 with the new API soon.
>
> Thanks for update

We weren't successful in getting the new API accepted. We will be
sticking to from_tasklet() unless you as a maintainer object to it.

If there's no objection, please let me know if I can send out V2
with subject line fixed.

Thanks,
 Allen
