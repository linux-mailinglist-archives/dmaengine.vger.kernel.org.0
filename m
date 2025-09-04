Return-Path: <dmaengine+bounces-6382-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1E6B44012
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 17:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8885C7B06E8
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 15:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B3E3126C1;
	Thu,  4 Sep 2025 15:10:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E34311C3D;
	Thu,  4 Sep 2025 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998657; cv=none; b=N4IQf9tnz81dxuhov1T59Hm1rK/M3CDCcTEF9C4Tj1myMMIV/gDBH0H6WvQm5U0VLVc6ybNdRwpDmlrJ5ki7dW4k8k6tRJPOuirqFtgDVgOTgdDz65hm4J5KCNVl5KN9jL8ly/y0F8kkI5Pqzs5+AZlCTV2Cgd9ZVUxwiaa1dUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998657; c=relaxed/simple;
	bh=bhH2AyFUyHikeeMORo6a6QvtJeEJ/W2ZFeXSLE2jsIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkFrzkHNAkvPHiCHDYuPqFsggTfKwyIdhqhJFQIlKJ5nMkmB9YB1Q0CHyUzB1zfCqtoYRWZa+MQotlnBU6O8UbszzVBeVzILrWrKUG/U+c3dWdyUJwdzAFpqKhe8InMhSvi/G3Uc1BASjuPfnTZ/MYdNpBvZ4fFqeOwnTBam9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5290c67854eso805775137.3;
        Thu, 04 Sep 2025 08:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998654; x=1757603454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShVXHKQVye5fMTAxZ5zJX/qsFUcoskhsDFahgVPvGhA=;
        b=kRlq4VUZuI5uJcRSf/f+lUx2+h9wS6gUhRtpEgYy8ItPg4bIsniNAZsiFOy5OG6P5e
         RxY/xRLZJf36BrqpkY8VaqPTRsvbwXrPLKRyLfe9LfNyJNbAIjlAA51B0/ABtjOnpv0K
         dKUwxX5EVJOeMb2eoGiXSRWi7L31vYDh93rAUL1to31grCRoWHcRdDL0O2T3BjcwkVcT
         9lcinOVLRmnYzRdK3zfDo8/qNxbSFO2e5Vc43PQIGFjWOzFLVZEYK9SIj9SllHyjEmgA
         YZnBsYmFF8X8h2RR3SfL1dsJ+MVF8W7NOY4ngDrCrs+8pmBm76uzxEupALYAZWkybwgp
         6Bow==
X-Forwarded-Encrypted: i=1; AJvYcCUwW6lQYIrjGlsXoeFHy72WugGGD/FDrX6/PNDssN/+f9jyhC5EAvdPvbsioFqWBqKtMaVCFrukfX66P2vS@vger.kernel.org, AJvYcCWg/3O83Qht9OPLmlaWedCp8JS6TucRWFJgzk9NvXFJiSBlZIH6QJbRleDWi+Ym4+rXrbps18jJdzD5@vger.kernel.org, AJvYcCWjWlddnqG/99qSrIKnXqt8FNwKeVbOWcKvsTmjXXORsuMSHWKD8UNaFuoy2363MCKn7UjzdSz9wiUBSV7dpebgtwA=@vger.kernel.org, AJvYcCXpVWp+SnqrztxeYHWdIR71gG1CmTmectXuq3sXBhm3UoNeH4emV7tbeJzmTWTKjaO/U5qedzX6cUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPKlrpcTsdIHrSzVdjD9AQdrHU1fpBwvIPQWq24U5wBXLjcO9W
	bOXuEScEhsZP2gLTqI5X8MNzwtkwlTA6oGu/OSRfW7iyeika1Ct7lzkMAE/FOVNW
X-Gm-Gg: ASbGncs8uqBEKe8DdtLOLvFTsttdu95mAOUDmaPTD5xaJCazxS7kfNXrDou1bDcItfg
	OMXmX8oYC+04mOJSITOajvsr+XiaJWeBnKtvkU3XqLtF84dA73O59Cs+zLF0W7/8avU3InsL812
	wHX1U+dy5mwLDaclc6PlckocZEyZkB4cpxowmeRF0d6x23qkWvQsyrVyFsQgxoyUZayMb3sHBwF
	nm754RdClgCIkwKq2oMvpD36WqM0StBmsMpIb3X+yjjsAsuN5iy5LImfK0mErgr0Yec49rHtZhh
	xdqwmqC5dX3+PyUg49FOXfDKms/yNGLA9LHjGXiCa+c5f2vA4HboduPYvTBk9xyTNmBLVpVLZMj
	OYTNnhNIG3+O5VjnjYS5h24Ws8s2PGgHG8WMKs/C6V0FEf9JJhsHzEoPFGPAd965PuVyJEkg=
X-Google-Smtp-Source: AGHT+IEsxG86HODGDOanb5//d4RWdlKZyyT2m8Le0Xtsonu5Y1+WQrJy0KDp60WK1TN883DRvDu0HA==
X-Received: by 2002:a05:6102:5cc2:b0:525:5f21:caa6 with SMTP id ada2fe7eead31-52b19c6cce0mr6824800137.9.1756998653788;
        Thu, 04 Sep 2025 08:10:53 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-895fba9791dsm5362460241.16.2025.09.04.08.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 08:10:53 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5357f3e2520so955643137.1;
        Thu, 04 Sep 2025 08:10:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5b5/sRIgXRG09YrP8rvPE7UhWQ9Hn9r+L7FHKCY1mzc/eZQ5GSoMwPA4bzvnG+ttwRVkmaeGuKYVTc5wOSSN6st4=@vger.kernel.org, AJvYcCURzy7BRVTjP1wV3bpWoUd3VFL5KJkGkIpkaiKMGJCico8V/93MUe7YeOLlhbbSP0Wqkuk0m8ycMOjaxB6d@vger.kernel.org, AJvYcCUbwkQM3KQK3YTVqLTkiU7bNk8Q58LckSaKRPAjwsjN59PdclMdyHDA5ShGYpaU8KPaupVkAxH1S48/@vger.kernel.org, AJvYcCXdtXdEFqVPl+1/nr7+PrHRv3ANRIkC9FR31eWbNmy+pkE/janWH7/PrULIcUxEVybZVu9Dp+OSEaA=@vger.kernel.org
X-Received: by 2002:a05:6102:2ac9:b0:524:e102:31c7 with SMTP id
 ada2fe7eead31-52b1b6fbde7mr5902911137.19.1756998652710; Thu, 04 Sep 2025
 08:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903082757.115778-1-tommaso.merciai.xr@bp.renesas.com>
 <20250903082757.115778-6-tommaso.merciai.xr@bp.renesas.com>
 <CAMuHMdU8WQsA_tXTpDvv0HQ1j=mawyJ2sMk3nuJJXgJxHOTeoA@mail.gmail.com> <aLmp5ILqhiWYJrw5@tom-desktop>
In-Reply-To: <aLmp5ILqhiWYJrw5@tom-desktop>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 4 Sep 2025 17:10:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVn1NHdD=23wfpXQHaR48kcZwiDzb4xQhuCENqL3X_EDw@mail.gmail.com>
X-Gm-Features: Ac12FXzCFPajoLB2EaIzkwV-YphAQypY6LFRt6AY-eQh1OyA06W4gKsSz-v4crI
Message-ID: <CAMuHMdVn1NHdD=23wfpXQHaR48kcZwiDzb4xQhuCENqL3X_EDw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] dmaengine: sh: rz-dmac: Add runtime PM support
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tommaso,

On Thu, 4 Sept 2025 at 17:02, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> On Wed, Sep 03, 2025 at 02:17:53PM +0200, Geert Uytterhoeven wrote:
> > On Wed, 3 Sept 2025 at 10:28, Tommaso Merciai
> > <tommaso.merciai.xr@bp.renesas.com> wrote:
> > > Enable runtime power management in the rz-dmac driver by adding suspend and
> > > resume callbacks. This ensures the driver can correctly assert and deassert
> >
> > This is not really what this patch does: the Runtime PM-related changes
> > just hide^Wmove reset handling into the runtime callbacks.
>
> Agreed.
>
> > > the reset control and manage power state transitions during suspend and
> > > resume. Adding runtime PM support allows the DMA controller to reduce power
> >
> > (I assume) This patch does fix resuming from _system_ suspend.
> >
> > > consumption when idle and maintain correct operation across system sleep
> > > states, addressing the previous lack of dynamic power management in the
> > > driver.
> >
> > The driver still does not do dynamic power management: you still call
> > pm_runtime_resume_and_get() from the driver's probe() .callback, and
> > call pm_runtime_put() only from the .remove() callback, so the device
> > is powered all the time.
> > To implement dynamic power management, you have to change that,
> > and call pm_runtime_resume_and_get() and pm_runtime_put() from the
> > .device_alloc_chan_resources() resp. .device_free_chan_resources()
> > callbacks (see e.g. drivers/dma/sh/rcar-dmac.c).
>
> Thanks for the hints!
> So following your hints we need to:
>
>  - call pm_runtime_get_sync() from rz_dmac_alloc_chan_resources()
>  - call pm_runtime_put() from rz_dmac_free_chan_resources()
>
> With that then we can remove pm_runtime_put() from the remove function
> and add this at the end of the probe function.
>
> > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> >
> > > --- a/drivers/dma/sh/rz-dmac.c
> > > +++ b/drivers/dma/sh/rz-dmac.c
> > > @@ -437,6 +437,17 @@ static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
> > >   * DMA engine operations
> > >   */
> > >
> > > +static void rz_dmac_chan_init_all(struct rz_dmac *dmac)
> > > +{
> > > +       unsigned int i;
> > > +
> > > +       rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
> > > +       rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
> > > +
> > > +       for (i = 0; i < dmac->n_channels; i++)
> > > +               rz_dmac_ch_writel(&dmac->channels[i], CHCTRL_DEFAULT, CHCTRL, 1);
> > > +}
> > > +
> > >  static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
> > >  {
> > >         struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> > > @@ -970,10 +981,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
> > >                 goto err_pm_disable;
> > >         }
> > >
> > > -       ret = reset_control_deassert(dmac->rstc);
> > > -       if (ret)
> > > -               goto err_pm_runtime_put;
> > > -
> > >         for (i = 0; i < dmac->n_channels; i++) {
> > >                 ret = rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
> > >                 if (ret < 0)
> > > @@ -1028,8 +1035,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
> > >                                   channel->lmdesc.base_dma);
> > >         }
> > >
> > > -       reset_control_assert(dmac->rstc);
> > > -err_pm_runtime_put:
> > >         pm_runtime_put(&pdev->dev);
> > >  err_pm_disable:
> > >         pm_runtime_disable(&pdev->dev);
> > > @@ -1052,13 +1057,50 @@ static void rz_dmac_remove(struct platform_device *pdev)
> > >                                   channel->lmdesc.base,
> > >                                   channel->lmdesc.base_dma);
> > >         }
> > > -       reset_control_assert(dmac->rstc);
> > >         pm_runtime_put(&pdev->dev);
> > >         pm_runtime_disable(&pdev->dev);
> > >
> > >         platform_device_put(dmac->icu.pdev);
> > >  }
> > >
> > > +static int rz_dmac_runtime_suspend(struct device *dev)
> > > +{
> > > +       struct rz_dmac *dmac = dev_get_drvdata(dev);
> > > +
> > > +       return reset_control_assert(dmac->rstc);
> >
> > Do you really want to reset the device (and thus loose register state)
> > each and every time the device is runtime-suspended?  For now it doesn't
> > matter much, but once you implement real dynamic power management,
> > it does.
> > I think the reset handling should be moved to the system suspend/resume
> > callbacks.
>
> Agreed. With above changes maybe we can move all into
> NOIRQ_SYSTEM_SLEEP_PM_OPS(rz_dmac_suspend, rz_dmac_resume)
> With your suggested changes I'm not sure if pm_runtime_ops are really needed.

After these changes, you indeed no longer need any pm_runtime_ops.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

