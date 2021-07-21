Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046C63D0EC5
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jul 2021 14:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbhGULlt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Jul 2021 07:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhGULls (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 21 Jul 2021 07:41:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F94C061574;
        Wed, 21 Jul 2021 05:22:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id v6so2848678lfp.6;
        Wed, 21 Jul 2021 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pg7bD+390UpqjI+zQBvxj/TSzQC4X2004JklWBEs0bY=;
        b=LUib2WexrgHs6dHS2ImFFSKnys6Z4IfUNURmd3L3rcrbu/qM2k/pxZk6isFvvjjtO9
         Rx6VnzE7dnFUW6klXr879NaXvYj98sDikoJPMv3vKcslqo7FjDHw0l0jkfzjKRruIcXY
         JC5TGQa3SEby+2Wzl98tK8rfo71NEu9livn5zu8+5h7YUqeg8hXgYc99TOsBGPVCA7Ev
         yYYmXOzcp7Ifr30MYgAKAYIdALKMyYliOaGMGo4IWC9BiFhQuxqq+PeUdG9bxLq6WV/v
         CQB//583m0ixI9tuMz29LCRx5NkppMsfr0+mbwBzT/Pyy+8GYv01TSnWsD1Z2EJOG46r
         F/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pg7bD+390UpqjI+zQBvxj/TSzQC4X2004JklWBEs0bY=;
        b=pGZ3F25F45EuaxHb50MItReJkV0Db5mFtkaczvPaNxwhaRMaU1IfxxQnUDiRYtRU6x
         vWegiGz0UOZAk58KaOM6EqX1IVC5bLDtbmBTJO5t1HALx5TX6n88oOivQ0NPFiAFc8By
         t78+FE9IeGSVp7fxTyzpv8wZg/QLuSaLi69P6Km/nTJq+atnnvl7wowf6tr1xqYH3DG3
         7idnKDubhuIxKmkXOvvI2ZDa0nxhtoZJKRL/x6+wvP51Wsz9l/g/NGQpMZCZyXKZ11Ns
         GCeEz2febfXjyNowLJF/ZbnEaZtk2a2boimgGcDD6JO+rTKy1d7RWv1agdo0dMkpuXsD
         bnSg==
X-Gm-Message-State: AOAM530TN/+zTMiuJL5zz9Wsw01aQD+soqRZ+4Oe7w3CiVtioHM8TzXr
        JxmN9hbePMrpFBQmWgelLQPchr1tvNMWpXT9anQ=
X-Google-Smtp-Source: ABdhPJx4EF5xnEFx9vKv2ALcD1ZOdgQU3l5QRL1R03YNWeU5AazWr4HjIsELUaOh9e+0QKlMJBe3lnzqtYx9BFb/ulE=
X-Received: by 2002:a05:6512:33af:: with SMTP id i15mr26072779lfg.25.1626870142549;
 Wed, 21 Jul 2021 05:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210704153314.6995-1-keguang.zhang@gmail.com>
 <YO5yo8v/tRZLGEdo@matsya> <CAJhJPsUNCSK4VYv9Z4ZNDxC03F4CxQoAXCCf+TJmmbdUe4XNNA@mail.gmail.com>
 <YPLrsXEmmHPtbZ+N@matsya> <YPMVyYoBojHYsMbJ@kroah.com> <YPa2+TsdL0PrR3hR@matsya>
 <YPa4IAk3sh7bai15@kroah.com> <YPa/DsO1vWcXKJKd@matsya>
In-Reply-To: <YPa/DsO1vWcXKJKd@matsya>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Wed, 21 Jul 2021 20:22:10 +0800
Message-ID: <CAJhJPsV211=Y_wrXqaiWz7Tqhvbj-ETwSNWqLcbt8PHi8=JMLA@mail.gmail.com>
Subject: Re: [PATCH V5] dmaengine: Loongson1: Add Loongson1 dmaengine driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod, Greg,

Vinod Koul <vkoul@kernel.org> =E4=BA=8E2021=E5=B9=B47=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=888:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On 20-07-21, 13:48, Greg KH wrote:
> > On Tue, Jul 20, 2021 at 05:13:53PM +0530, Vinod Koul wrote:
> > > On 17-07-21, 19:39, Greg KH wrote:
> > > > On Sat, Jul 17, 2021 at 08:09:45PM +0530, Vinod Koul wrote:
> > > > > On 17-07-21, 18:57, Kelvin Cheung wrote:
> > > > > > Vinod Koul <vkoul@kernel.org> =E4=BA=8E2021=E5=B9=B47=E6=9C=881=
4=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=881:14=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > > > >
> > > > > > > On 04-07-21, 23:33, Keguang Zhang wrote:
> > > > > > >
> > > > > > > > +static struct platform_driver ls1x_dma_driver =3D {
> > > > > > > > +     .probe  =3D ls1x_dma_probe,
> > > > > > > > +     .remove =3D ls1x_dma_remove,
> > > > > > > > +     .driver =3D {
> > > > > > > > +             .name   =3D "ls1x-dma",
> > > > > > > > +     },
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +module_platform_driver(ls1x_dma_driver);
> > > > > > >
> > > > > > > so my comment was left unanswered, who creates this device!
> > > > > >
> > > > > > Sorry!
> > > > > > This patch will create the device: https://patchwork.kernel.org=
/patch/12281691
> > > > >
> > > > > Greg, looks like the above patch creates platform devices in mips=
, is
> > > > > that the right way..?
> > > >
> > > > I do not understand, what exactly is the question?
> > >
> > > So this patch was adding Loongson1 dmaengine driver which is a platfo=
rm
> > > device. I asked about the platform device and was told that [1] creat=
es
> > > the platform device. I am not sure if that is the recommended way giv=
en
> > > that you have been asking people to not use platform devices.
> >
> > Yes, but this link:
> >
> > > [1]: https://patchwork.kernel.org/patch/12281691
> >
> > Does look like a "real" platform device in that you have fixed resource=
s
> > for the device and no way to discover it on your own.
> >
> > But why are you not using DT for this?  That looks like the old platfor=
m
> > data files.
>
> Apparently I was told that this platform does not use DT :( Looking at
> it it should.. Maybe Kelvin can explain why..

Yes, the DT support of Loongson32 is still on the way.
Therefore, I have to use the old way to let the driver work.
I will update this driver once this platform supports DT.

>
> --
> ~Vinod



--=20
Best regards,

Kelvin Cheung
