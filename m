Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7F2257441
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 09:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgHaH0J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 03:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgHaH0H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 03:26:07 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7A5C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 00:26:07 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id v13so178870oiv.13
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 00:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LWaaxQd9KS30LOfyAmANaiPJNAAEpHEPDJOfifxUHQw=;
        b=OF8SySja+2+YvB4Uafxq3hGtyWQN5fup0FG+KRyE8pLF39ZIPAEtnyDMKYCUJg4dgo
         Ajqx9MTk4pq2LrrJuuXHQzOIdnm8tYaI/1tu9JwL1tAeLynuXCt/qpPvI0JL7xGuHMQP
         z7/SfUqDoT3BxGs2mpU9JRSq/t6WeQ0GxF6C2nJoUtl1PYsC2dahS4E6Pp7MOnsglorL
         i708DdWMzpice6544wisXBly1eDfN7L5HW0/ALpGMu/UWs/50SdWCJ/TC8+p4d+ijb7s
         NANr6155o7mNEItH8JA2sQhDK5yL4Oa7g4bjV01pY2/JGwVqeXX6u3tafK37JxwXeni3
         mcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWaaxQd9KS30LOfyAmANaiPJNAAEpHEPDJOfifxUHQw=;
        b=DpgqZsa81ZqlRQZz3dj/Q2GtY5oK87EEM1wPdfXoU8kp9AC0xGUVOlutNSCgkDorWu
         lwZvNKCCDliS1QCiMrbWc4EEjUs+oMzFVzX7HMSv9CkPIyDdS18qITo4qaIxskBkjtSs
         XHOdhkBkiTDo188XLKiwxFZZDzhaXOJq5UB31QDSQfCxYlp12b0bcSnS7O+geC7p9oXi
         nREQFYeiibWqjXvu/fShXfhGzpzfMGE8qv9pAyOIhju0MUr/XE8CPDLRIdaMKMM6Y/Tt
         CNX3rcGDH2W/cKnZmhql8ZoautMFOzAR3ZXNjPENxWW+thGhhhbR4KvaiiVGa4/L71jU
         DfeA==
X-Gm-Message-State: AOAM531jsoxaaB4XBOao250tqWcl12KFJ6P+OZ+rnFbmDOlT27LMiXEM
        vIQblR+7IP6HjC5TgisEFTNDF0eFolu0YSXs7pk=
X-Google-Smtp-Source: ABdhPJxZwG0dl31dO2q7l9Lckx047y83axAimvA7OwnuujIemO/swcU9VcwwLRhhL4wjHHTsVCbB4YRdz/tm7VKPVVc=
X-Received: by 2002:a05:6808:c6:: with SMTP id t6mr115104oic.76.1598858766589;
 Mon, 31 Aug 2020 00:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200818090638.26362-1-allen.lkml@gmail.com> <20200825110331.GG2639@vkoul-mobl>
 <CAOMdWSKvj9Bwt_JpJ072c-LYKRO4aA+vEPyJLZSYgMvuXhTBmQ@mail.gmail.com>
 <20200826042841.GV2639@vkoul-mobl> <CAOMdWS+ZE8hKwVPT=XQVHoZ3uX-Wr7Ao=WxyT8JPzN_4NR2DbA@mail.gmail.com>
 <20200831064023.GE2639@vkoul-mobl>
In-Reply-To: <20200831064023.GE2639@vkoul-mobl>
From:   Allen <allen.lkml@gmail.com>
Date:   Mon, 31 Aug 2020 12:55:55 +0530
Message-ID: <CAOMdWSLwC16gs66iGHPaZQtfaYbzQZScJK+oYX2i8KAeq1cwCg@mail.gmail.com>
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

> > > > > > Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
> > > > > > introduced a new tasklet initialization API. This series converts
> > > > > > all the dma drivers to use the new tasklet_setup() API
> > > > > >
> > > > > > This is based on 5.9-rc1.
> > > > > >
> > > > > > Please pick this series, as I missed updating a couple of fixes and marking
> > > > > > the correct mailing list.
> > > > >
> > > > > The patches should have been tagged "dmaengine: ...".
> > > >
> > > >  My bad, Will have it fixed.
> > > >
> > > > >
> > > > > What is the status of this API conversion, I think I saw some
> > > > > discussions on API change, what is the conclusion?
> > > >
> > > >  Yes, the updated API should land into Linus's tree shortly.
> > > > Will send out V2 with the new API soon.
> > >
> > > Thanks for update
> >
> > We weren't successful in getting the new API accepted. We will be
> > sticking to from_tasklet() unless you as a maintainer object to it.
>
>
> Ok, but is the colclusion to keep from_tasklet() or move to something
> else later on. If that is the case, I would like to see the change once
> only

 No, we won't be moving to something else. It's either from_tasklet()
or to use container_of()(which could lead to longer lines).

> > If there's no objection, please let me know if I can send out V2
> > with subject line fixed.
>
> If this wont change, then yes please

Will prep V2 and send it out soon.

Thanks.

-- 
       - Allen
