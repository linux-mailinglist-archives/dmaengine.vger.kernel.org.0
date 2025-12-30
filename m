Return-Path: <dmaengine+bounces-7977-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28495CE9C37
	for <lists+dmaengine@lfdr.de>; Tue, 30 Dec 2025 14:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 205723016916
	for <lists+dmaengine@lfdr.de>; Tue, 30 Dec 2025 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9F52066F7;
	Tue, 30 Dec 2025 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="zFolPSmJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82F71F4CBB
	for <dmaengine@vger.kernel.org>; Tue, 30 Dec 2025 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767100759; cv=none; b=A8HTK3nWxVYFcFo7X7IOvzKLl/AgZxBF0dla1Tw6hGygG3idx+FceyAeE08pT4T9kUAxRDnT9r1l4o2EgujSRLgQ1HQre90HgUAay2KyeBX655pUcU7y3kssUiFU1B3JBWALQgsV0+/PYYQc+YvzRd0GS612FpEZ3Jhhe2NvaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767100759; c=relaxed/simple;
	bh=60nzpBoByaz3l7USmNfHjsOcoHPQLtJjqSS2IxjgkYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4ENe24nIuAPbmPfcrUrJ9IBYw5M1A8aE5ZXFd5U0ClbsPPq2m4Q0mhOYk+Rd/ygEqqKKT97Sc9C6pSYVbhWcHXUeWab7I1e+couCJzGiF0T7oEBez+hxuksz5PVVmNxp/yD2TrQ6wW46N3bB98t4oiPtadVCb3GrNmEj5PSB2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=zFolPSmJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so12252996a12.3
        for <dmaengine@vger.kernel.org>; Tue, 30 Dec 2025 05:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767100756; x=1767705556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVg7jxPsCBHGWb7o7CsiEjtqnH/DgSZg+hH6XuxK1WQ=;
        b=zFolPSmJoMqgnCTqu4gM03tcTKAvXsLJ8Hmkp8qvO0p4rQjB2jsm8n6OYv5SUXGJJz
         nkzzsa025JDEo8I/YuzUxrxtcmAQL12xwgIJTYrYiZ3QPweXwXHF5LQAGwbUolbUa+05
         e4XaUHb9KQLQsrcHfUkd+dv/mCR6UkkIpM4GFCD7Bhv2SMF//apKbczG4Wbb7+2+Cv1n
         JxcNAunEXj45dhRrmQvxwOn4/7e6LurqxvcMAh2G0cswJXwC3K0JZKuS9xpufme17ueY
         sUV1m9KCpGcrI59maem3Di0gKZ6cR7WEDzQ5sWoko5Hd8KIa+24AnoVZJB1yCmu+8HMF
         85jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767100756; x=1767705556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVg7jxPsCBHGWb7o7CsiEjtqnH/DgSZg+hH6XuxK1WQ=;
        b=VxIyjggEEX+B4XSeGM1WH0Bxntb0MsnGWUGJkrVpmMG0tkb7VuXlu/xYo0cIAOVVva
         Kre5M3mwk1KRcLc/zfFX/eW9xK6Zd4MKAZgVlhhwsg8UE81OnyXm3qfJABp18dNeJEEr
         T3oXxuL49k72MaCGyhmwEQjGAuujFHWz8HNgYMHHLJz2+eyuJeJ684+Tv7mX3m1H0BJX
         0MbKHxQmvIo6z86dSRga+kJOT97oXEikDIiHveW69TgHoAluLODS2pHo5pg34VL/fE23
         7EijNIVCt/7U77AI4Q5xZNf58wgK4LcV13MvqEm/pStqPSuWr/mZeJZ16a1UZnkcF4K/
         GPZg==
X-Forwarded-Encrypted: i=1; AJvYcCV8xptcrjMNQHqCxfuDOBHnrbJok/f5Ge41EWh66WhHSDkPyaOi6ft72ocbmLqAw/dwGW4Yw1zU44Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyN55debqGncauhGRmZH7hQkh4EkW2mBmr+Lt+ReFUIn12ICp3
	87suULbju+xix74rQ5yZA6lZpRq3js7/77J04U7bTDxSTaPuCFMg41Tay5u7OTn0cA071VnEg/7
	Uw98blBrbtxidjQeiYrMgiPvs76OUj/7krgBPFfuwIA==
X-Gm-Gg: AY/fxX5t/9pBRhzbLFbqI/fe8LLJb0MeP2xpCQiAXEPzDdQNOSBiWf1g3JUjC3DrA/q
	7Ht2H4wlZIzdRDH/7Frxnf/emTAWxsCQNtAAT3rxPVTnKjFJIvfWGKBgqKmtuw+ncgc4If83/0q
	lP0aeV9xflI1EMAvyGDPW7toAQdd8/rq5Kam9o2KgZsZqE2ksjC64yawXl9eLnZ2zbkchmqyVMS
	4cQ9ljPrqQv96RV4e417hCSKYUcr+szDPcBxEXTAmhJg40x+0O7PvUoTv0e7iWmano+zmaqLFlZ
	eHqtscAh5ILBskz+onhLclHznoIkn0OAuztCyZbGuycKkUo6MlBf
X-Google-Smtp-Source: AGHT+IEmR/sUysOjbEHwlCYRZf3GAy62DmeIroQ8rAQLTd36sLOMpKr0juQStEhaH7R4NFBMQh1Bj3mg4pQKMCaWdh0=
X-Received: by 2002:a05:6402:42d0:b0:64e:f6e1:e519 with SMTP id
 4fb4d7f45d1cf-64ef6e1e772mr4128289a12.19.1767100756030; Tue, 30 Dec 2025
 05:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203121208.1269487-1-robert.marko@sartura.hr> <aUF4OS4DsmRlQQt3@vaman>
In-Reply-To: <aUF4OS4DsmRlQQt3@vaman>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 30 Dec 2025 14:19:05 +0100
X-Gm-Features: AQt7F2qe8u7JIqD_s36UvUenlFX1mMzbx3PprH-BCcOTY8WkqWfY72IF1X03T8I
Message-ID: <CA+HBbNGv1YzZhBfAO7JvossJeM46CFcPmUtDmYaK4Fm8iB9stg@mail.gmail.com>
Subject: Re: [PATCH RESEND] dmaengine: at_xdmac: get the number of DMA
 channels from device tree
To: Vinod Koul <vkoul@kernel.org>
Cc: ludovic.desroches@microchip.com, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daniel.machon@microchip.com, luka.perkov@sartura.hr, 
	Tony Han <tony.han@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 4:18=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrote=
:
>
> On 03-12-25, 13:11, Robert Marko wrote:
> > From: Tony Han <tony.han@microchip.com>
> >
> > In case of kernel runs in non-secure mode, the number of DMA channels c=
an
> > be got from device tree since the value read from GTYPE register is "0"=
 as
> > it's always secured.
> >
> > As the number of channels can never be negative, update them to the typ=
e
> > "unsigned".
> >
> > This is required for LAN969x.
>
> You updated the changelog, but tagged it as resend. It should be v2!

Hi,
Sorry for this, I sent the wrong patch and though quickly resending
the right one would be better.

>
> >
> > Signed-off-by: Tony Han <tony.han@microchip.com>
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  drivers/dma/at_xdmac.c | 26 +++++++++++++++++++++++---
> >  1 file changed, 23 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> > index 3fbc74710a13..acabf82e293c 100644
> > --- a/drivers/dma/at_xdmac.c
> > +++ b/drivers/dma/at_xdmac.c
> > @@ -2257,12 +2257,29 @@ static int __maybe_unused atmel_xdmac_runtime_r=
esume(struct device *dev)
> >       return clk_enable(atxdmac->clk);
> >  }
> >
> > +static inline int at_xdmac_get_channel_number(struct platform_device *=
pdev,
> > +                                           u32 reg, u32 *pchannels)
> > +{
> > +     int     ret;
> > +
> > +     if (reg) {
> > +             *pchannels =3D AT_XDMAC_NB_CH(reg);
> > +             return 0;
> > +     }
> > +
> > +     ret =3D of_property_read_u32(pdev->dev.of_node, "dma-channels", p=
channels);
> > +     if (ret)
> > +             dev_err(&pdev->dev, "can't get number of channels\n");
>
> Do we need to log error, I thought the API did that...

I dont think API helps here, we would just be left with the error
code, which can be hard
to trace back but I am flexible.

Regards,
Robert
>
> > +
> > +     return ret;
> > +}
> > +
> >  static int at_xdmac_probe(struct platform_device *pdev)
> >  {
> >       struct at_xdmac *atxdmac;
> > -     int             irq, nr_channels, i, ret;
> > +     int             irq, ret;
> >       void __iomem    *base;
> > -     u32             reg;
> > +     u32             nr_channels, i, reg;
> >
> >       irq =3D platform_get_irq(pdev, 0);
> >       if (irq < 0)
> > @@ -2278,7 +2295,10 @@ static int at_xdmac_probe(struct platform_device=
 *pdev)
> >        * of channels to do the allocation.
> >        */
> >       reg =3D readl_relaxed(base + AT_XDMAC_GTYPE);
> > -     nr_channels =3D AT_XDMAC_NB_CH(reg);
> > +     ret =3D at_xdmac_get_channel_number(pdev, reg, &nr_channels);
> > +     if (ret)
> > +             return ret;
> > +
> >       if (nr_channels > AT_XDMAC_MAX_CHAN) {
> >               dev_err(&pdev->dev, "invalid number of channels (%u)\n",
> >                       nr_channels);
> > --
> > 2.52.0
>
> --
> ~Vinod



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

