Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389BC3E8AED
	for <lists+dmaengine@lfdr.de>; Wed, 11 Aug 2021 09:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhHKHSl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Aug 2021 03:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbhHKHSk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Aug 2021 03:18:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BF6C061765;
        Wed, 11 Aug 2021 00:18:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y34so3616572lfa.8;
        Wed, 11 Aug 2021 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dg6pLnPjVAtzxSVEs294XC4hAdURgggAJsxQwZ1ihAA=;
        b=WiaozDn9hHTeG/WdotFQpHJfhhAXmNQ8JrHA7CTf/Op+uc/qOh9ShFDbEJmDkvdE5K
         KYa5Hb3Rho98p4Wf+atu3+9Th152uhjVGdQBCGguHnX2pxGUhKRtO998MA8YIkndZed+
         F756ljUgA+dncph+CbxShWCDcLgSs3VWziwSrOkQ+DOd5j66AoEHp2Wn6aKc7L3GLqgQ
         r5frmMlbeA1xFJHuBES/6xSTJysq1ujdOGlHXAlcGeqyekjsW5IG3HM2IZ75j18H/Inl
         MEBo4Y7UtIhfhCfaFDyXWCDBrOYIGm+qlV9B91pu1lzRTF1J6KV50z/6ZfFkKV6f6GLm
         pqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dg6pLnPjVAtzxSVEs294XC4hAdURgggAJsxQwZ1ihAA=;
        b=DLX9M/8Fk3jUQt+MWcclWSIzOb6PoauvS7peBqeOW3zIH98DblS7VK4CQyYPhg2yTW
         luPWzS4Zb/NLriUdKX06ToK3+nMRWbcP4p0KZPmIiv0ZwID3sfcg5xbFrEGOPzygZPxU
         xGeY0airwARf52v68JP+w9UXEn+f6YD7lNkx12BwXHUlkIvT86VaNDUXiBN6rML1+8m2
         KRaLvPwh3CUmkaSKt9tn4CyrLWjz1u4fIkqTFtnWbvT69u6ARKVr5VBE0uxJQw3oycvw
         dEvk+DeaiefRIg4nkYYigerkByRphflY49xoN3X7asWqeGP07w4O2OjZVT7MKo8Dm2Wt
         wmOA==
X-Gm-Message-State: AOAM531g/pwR0bbOkmcOjGn+oX4ZXqH4dazH3y3+5vKfqBdjkaWK89TQ
        bQL4a+SGMf0ch4NGjIt79VqOrl/kHzRWa4zpIFs=
X-Google-Smtp-Source: ABdhPJwkDjxicadizT9KbFPV2Tun1I/JQcK9eslZZ4FSv1mNWUQ63syojkl0OMzQSqrPOjepv10eXc54ilfGxIr2ULw=
X-Received: by 2002:a05:6512:3408:: with SMTP id i8mr1495706lfr.525.1628666295694;
 Wed, 11 Aug 2021 00:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210704153314.6995-1-keguang.zhang@gmail.com>
 <YO5yo8v/tRZLGEdo@matsya> <CAJhJPsUNCSK4VYv9Z4ZNDxC03F4CxQoAXCCf+TJmmbdUe4XNNA@mail.gmail.com>
 <YPLrsXEmmHPtbZ+N@matsya> <YPMVyYoBojHYsMbJ@kroah.com> <YPa2+TsdL0PrR3hR@matsya>
 <YPa4IAk3sh7bai15@kroah.com> <YPa/DsO1vWcXKJKd@matsya> <CAJhJPsV211=Y_wrXqaiWz7Tqhvbj-ETwSNWqLcbt8PHi8=JMLA@mail.gmail.com>
In-Reply-To: <CAJhJPsV211=Y_wrXqaiWz7Tqhvbj-ETwSNWqLcbt8PHi8=JMLA@mail.gmail.com>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Wed, 11 Aug 2021 15:18:03 +0800
Message-ID: <CAJhJPsXtm_i5OAtSxZn9mSumAp0X8r5EKJ3VLt1nmC-j-EuOyw@mail.gmail.com>
Subject: Re: [PATCH V5] dmaengine: Loongson1: Add Loongson1 dmaengine driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Kelvin Cheung <keguang.zhang@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:22=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hi Vinod, Greg,
>
> Vinod Koul <vkoul@kernel.org> =E4=BA=8E2021=E5=B9=B47=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=888:18=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On 20-07-21, 13:48, Greg KH wrote:
> > > On Tue, Jul 20, 2021 at 05:13:53PM +0530, Vinod Koul wrote:
> > > > On 17-07-21, 19:39, Greg KH wrote:
> > > > > On Sat, Jul 17, 2021 at 08:09:45PM +0530, Vinod Koul wrote:
> > > > > > On 17-07-21, 18:57, Kelvin Cheung wrote:
> > > > > > > Vinod Koul <vkoul@kernel.org> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8814=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=881:14=E5=86=99=E9=81=93=
=EF=BC=9A
> > > > > > > >
> > > > > > > > On 04-07-21, 23:33, Keguang Zhang wrote:
> > > > > > > >
> > > > > > > > > +static struct platform_driver ls1x_dma_driver =3D {
> > > > > > > > > +     .probe  =3D ls1x_dma_probe,
> > > > > > > > > +     .remove =3D ls1x_dma_remove,
> > > > > > > > > +     .driver =3D {
> > > > > > > > > +             .name   =3D "ls1x-dma",
> > > > > > > > > +     },
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > > +module_platform_driver(ls1x_dma_driver);
> > > > > > > >
> > > > > > > > so my comment was left unanswered, who creates this device!
> > > > > > >
> > > > > > > Sorry!
> > > > > > > This patch will create the device: https://patchwork.kernel.o=
rg/patch/12281691
> > > > > >
> > > > > > Greg, looks like the above patch creates platform devices in mi=
ps, is
> > > > > > that the right way..?
> > > > >
> > > > > I do not understand, what exactly is the question?
> > > >
> > > > So this patch was adding Loongson1 dmaengine driver which is a plat=
form
> > > > device. I asked about the platform device and was told that [1] cre=
ates
> > > > the platform device. I am not sure if that is the recommended way g=
iven
> > > > that you have been asking people to not use platform devices.
> > >
> > > Yes, but this link:
> > >
> > > > [1]: https://patchwork.kernel.org/patch/12281691
> > >
> > > Does look like a "real" platform device in that you have fixed resour=
ces
> > > for the device and no way to discover it on your own.
> > >
> > > But why are you not using DT for this?  That looks like the old platf=
orm
> > > data files.
> >
> > Apparently I was told that this platform does not use DT :( Looking at
> > it it should.. Maybe Kelvin can explain why..
>
> Yes, the DT support of Loongson32 is still on the way.
> Therefore, I have to use the old way to let the driver work.
> I will update this driver once this platform supports DT.
>
Hi Vinod,
Is there anything to be improved?
Perhaps this patch is acceptable now?

Thanks!
> >
> > --
> > ~Vinod
>
>
>
> --
> Best regards,
>
> Kelvin Cheung



--=20
Best regards,

Kelvin Cheung
