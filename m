Return-Path: <dmaengine+bounces-3163-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBF297967A
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2024 13:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2566EB225CE
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2024 11:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813F81C4610;
	Sun, 15 Sep 2024 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRGcH3ac"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF94D433AD;
	Sun, 15 Sep 2024 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726400639; cv=none; b=bpfnP/jw+rV4ezwZK0z8lGOxcDd6XmbABfl1MUwhUu5ecMOyHYgF8ElvkTakhuuO6Lu/prYcWtIQrGmxLYBjTnAQYQvQFUEtekGEw9zjNkLOVLaWDsBhMQoTXLC9coGVTvtn1Hs8xUDXqZqOeJfIHytE5WJdnb43PC4M+gq0/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726400639; c=relaxed/simple;
	bh=9gBezfe5utY0cPgQltriDtFHiRidNxdC12YbVydTmLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGYymBiDz6kzq+XVgURgzfFg56VTjxyHx69HmoRu05/kIcEc8SioiYh0Ebm21ynI3CJ5PXZsVtRIQGGc01Trl5U33c727eBOFDEHCdo5SfXbd4nCTjvmfMGKHT2pIVlPSNmWqs8xaCAU0So4zOJ5UvchuiXWm4aTD86re2HqynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRGcH3ac; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so448403966b.2;
        Sun, 15 Sep 2024 04:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726400636; x=1727005436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WabSCqMM6qQfnUzEgHytUCozRhZaEm21IN1ROnMooo=;
        b=nRGcH3acUv1focu5xYadnd+S6/R832TdzxN6XX7GnOHhEGfUiJdyQFgxhLl2V+cj0W
         YuNPz9yciovdhdA9yfN1jRooh9NwnrBYtLOJ8CprsrFis8iGlAUKz3S/jk8A8mbDZ1Zn
         2UxVSAazfmoYVWbBt7yTRSyTwkvflI1dnNzK6W9O6P2Qpxz/V5z7hIKeDs6UMWybKWfp
         X9r4R+WUMtYjg6NgxvHhg+9im6NZtvWYg2LzccN3dK42JM3SYfIsauIMIJBB38wNDToz
         gMn2xBpkgerPNc6puaU5gBmPI/SzBftsdDOo/ao2sFY70lwZm6t85LOYF88h+laFug/K
         YSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726400636; x=1727005436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WabSCqMM6qQfnUzEgHytUCozRhZaEm21IN1ROnMooo=;
        b=QWqyRYUVHFvtwEhn/emKqEVsKvz6+BJFvICTusPpcITwmGfgu5MG0IpsdfAlkqrPaU
         G6wmEpSUoZbh8bS7dhynV/gPos028mgxQIczrATeRFm79xGGsJhGJnFQ/tQr3dveX+GO
         qdjqN3gPBGny1JzftqXEdnGfXTGjNNnOin5/9+uu0yUCX4OD+4OoPTHRBBS6IiEPQyvu
         KU8islTZ/CZCPOGiP2i3l2qeCILiZfOBzR75N3WvlALVeqt2vuJqCvK57OE0/8tXIq5d
         BSElAn0gH23lI2R3wCIAzIw3z4JzAaxqX+hi+dyvizf30PoVZFDvcjbYwz0UE16KAc/A
         j1/w==
X-Forwarded-Encrypted: i=1; AJvYcCUQJyl+LFUkUSNYhNbO0qlsranbRL5e19hZ5gUzQfSr9SvmmDVpp3ItwjO0DkM9MNNYlkljhP7kAu2uytEk@vger.kernel.org, AJvYcCWGOwJobTOVsOd1I3AJlm0ucbzbP+aSXBA3NDXff5Nq2GCUM5gq+CwIbb5pXpla0j4TCdx+c4RYp2j7WBI7@vger.kernel.org, AJvYcCWMt7lZTG+sFn2ZI4D0LXZlKzDylya4zx8gOTxxXSyrHjYOGuXRJ4o077ppscoBDrUNo6s0x84Hs60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYaB9x8R1EHnolJqt3BjjTnyHpbwSX7Mp1PInGfuHU+8DlKJ+4
	zFZslHyE1EkSfkVMBUYB3DT0j7NS5vWHmCMXVFG+r2W09VqJNdfqigaarmmOEIDiJGLYbPgKIc6
	drOL2kzy6hWfffZHksOLLBoPRyKE=
X-Google-Smtp-Source: AGHT+IGE8WRlI9/zBnCunluyxYuf24XXBMOvlw61ulEQ8+gARNO6c+BIyafxB4U5G08/b2soKNiG1JJ72Po4K4tJVv4=
X-Received: by 2002:a17:906:d550:b0:a86:963f:ea8d with SMTP id
 a640c23a62f3a-a9029671944mr1345294466b.64.1726400635613; Sun, 15 Sep 2024
 04:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
 <CAHp75VcnfrOOC610JxAdTwJv8j1i_Abo72E0h1aqRbrYOWRrZw@mail.gmail.com>
 <rsy7z45nhl74nzvq5a2ij4eeqgzu3htje2xpparxgam7jowo6a@6l75wjh2dqll>
 <ZuXbCKUs1iOqFu51@black.fi.intel.com> <hp2n4efzoe5n5zvgaygv4pz4rwip2iwj5nwpaofdwgzv65735b@bp4hn4aqkwrk>
 <jsiriw6kumswijb6wxdcjqnq3tdu524hveh7dezqdzutduvt2d@5xcdjwd6aj3f>
In-Reply-To: <jsiriw6kumswijb6wxdcjqnq3tdu524hveh7dezqdzutduvt2d@5xcdjwd6aj3f>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 15 Sep 2024 14:43:19 +0300
Message-ID: <CAHp75VfQP6Ta=TVLCCPyPxnVrh7jwmWPUTcOYaRf3kdVJPR_rA@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 0/6] dmaengine: dw: Fix src/dst addr width misconfig
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Ferry Toth <ftoth@exalondelft.nl>, Viresh Kumar <vireshk@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 10:08=E2=80=AFPM Serge Semin <fancer.lancer@gmail.c=
om> wrote:
>
> On Sat, Sep 14, 2024 at 10:06:16PM +0300, Serge Semin wrote:
> > Hi Andy
> >
> > On Sat, Sep 14, 2024 at 09:50:48PM +0300, Andy Shevchenko wrote:
> > > On Mon, Aug 05, 2024 at 03:25:35PM +0300, Serge Semin wrote:
> > > > On Sat, Aug 03, 2024 at 09:29:54PM +0200, Andy Shevchenko wrote:
> > > > > On Fri, Aug 2, 2024 at 9:51=E2=80=AFAM Serge Semin <fancer.lancer=
@gmail.com> wrote:
> > > > > >
> > > > > > The main goal of this series is to fix the data disappearance i=
n case of
> > > > > > the DW UART handled by the DW AHB DMA engine. The problem happe=
ns on a
> > > > > > portion of the data received when the pre-initialized DEV_TO_ME=
M
> > > > > > DMA-transfer is paused and then disabled. The data just hangs u=
p in the
> > > > > > DMA-engine FIFO and isn't flushed out to the memory on the DMA-=
channel
> > > > > > suspension (see the second commit log for details). On a way to=
 find the
> > > > > > denoted problem fix it was discovered that the driver doesn't v=
erify the
> > > > > > peripheral device address width specified by a client driver, w=
hich in its
> > > > > > turn if unsupported or undefined value passed may cause DMA-tra=
nsfer being
> > > > > > misconfigured. It's fixed in the first patch of the series.
> > > > > >
> > > > > > In addition to that three cleanup patches follow the fixes desc=
ribed above
> > > > > > in order to make the DWC-engine configuration procedure more co=
herent.
> > > > > > First one simplifies the CTL_LO register setup methods. Second =
and third
> > > > > > patches simplify the max-burst calculation procedure and unify =
it with the
> > > > > > rest of the verification methods. Please see the patches log fo=
r more
> > > > > > details.
> > > > > >
> > > > > > Final patch is another cleanup which unifies the status variabl=
es naming
> > > > > > in the driver.
> > > > >
> > > > > Acked-by: Andy Shevchenko <andy@kernel.org>
> > > >
> > > > Awesome! Thanks.
> > >
> > > Not really :-)
> > > This series broke iDMA32 + SPI PXA2xx on Intel Merrifield.
> >
> > Damn. Sorry to hear that.(
> >
> > > I haven't
> > > had time to investigate further, but rolling back all patches helps.
> > >
> > > +Cc: Ferry who might also test and maybe investigate as he reported t=
he
> > > issue to me initially.
> >
> > Ferry, could you please roll back the series patch-by-patch to find
> > out the particular commit to blame?
>
> Plus to that it would be nice to have some log/info/details/etc about
> what exactly is happening.

For me with patch

spitest -l -s1000000 -b128 /dev/spidev5.1
SPI: [mode 0x20, bits_per_word 8, speed 1000000 Hz]
[  164.525604] pxa2xx_spi_pci 0000:00:07.1: DMA slave config failed
[  164.536105] pxa2xx_spi_pci 0000:00:07.1: failed to get DMA TX descriptor
[  164.543213] spidev spi-SPT0001:00: SPI transfer failed: -16
[  164.550140] spi_master spi5: failed to transfer one message from queue
[  164.557126] spi_master spi5: noqueue transfer failed
spitest: SPI transfer failed in iteration #0: Device or resource busy

Without

spitest -s 1000000 -b 128 -l /dev/spidev5.1
SPI: [mode 0x20, bits_per_word 8, speed 1000000 Hz]
SEND: [00000000] ff 97 d0 54 d5 69 85 6e ca e7 b3 e1 a1 e5 1a 9d
...
RECV: [00000000] ff 97 d0 54 d5 69 85 6e ca e7 b3 e1 a1 e5 1a 9d
...

`spitest` is our internal tool, so what it does there is:
1) opens SPI device for speed 1MHz in loopback mode
2) generates 128 byte of random data
3) tries to send and receive them
4) compares

I believe the similar behaviour can be achieved with the one that is
in the kernel tree.

--=20
With Best Regards,
Andy Shevchenko

