Return-Path: <dmaengine+bounces-717-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD4F82A51C
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 00:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6F6B21D49
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jan 2024 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD844F89C;
	Wed, 10 Jan 2024 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YnPSb/DR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D0022063
	for <dmaengine@vger.kernel.org>; Wed, 10 Jan 2024 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9b1589a75so2360055b3a.3
        for <dmaengine@vger.kernel.org>; Wed, 10 Jan 2024 15:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704931099; x=1705535899; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hRtOehh8h5mmIfnUBPPWvn4/oVyBLE/rm2Y8lVByjVU=;
        b=YnPSb/DR6HN646/sa64ezlsYwMQ0cdu5aDq4ROCOySZUAOuyi074zA4dmrVypjJi8d
         BN3VzRRqb1VIDii74DqVfdmTMpkQk5RMAsKB0SWfj2HCZ3F1qtW7Zvb42nP1ifpM5SPz
         G/TNFgRNkm5J1SHLCW7OFpREGie+Qh3gpnbig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704931099; x=1705535899;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRtOehh8h5mmIfnUBPPWvn4/oVyBLE/rm2Y8lVByjVU=;
        b=miF+cRA8HuNAMDF4vdhGb80HvaVS3H+ln5GVtUQwlObKkjWPmAGnwvQb9TccklcrFt
         xg0MvD7y5XL5chdKud/DAqMZT+V+1tl/5cs6qzR3rWl3n04NSvQInS6dTr5M0kFJevlO
         pb9QoFoRsO0eXEkEtZTGmCaEQaTzasDXy3J5Y2VTyIrfPK1OKZUy2tWYKVB7mLywUqMR
         hSsJLx1JWUw+FogRFg1z/KdXjDGVFFXrlHmdTP/KMFpYZfgwxgpuufK8CyOp1awEhpSe
         SaOvbkjKay6AVWObt/ATpAZo6Hy/jg6CNewQZ2FqsjTadEt02V8/+SdrnciXFoHoKNBG
         C+3w==
X-Gm-Message-State: AOJu0Yxa7vxOcoIKGjvCXAhsXle3VA498dJURi69VY1fkqK1ZBvFy+G7
	+8fm4kRKJEHB1qY+vmgNY9HsxTM+fe4CoqrttJBhkDmfXhld
X-Google-Smtp-Source: AGHT+IExuDQJz9CNiQXMhpiwSk9OMFiOklkcYaCJCUkMgtC7Uww1FJWERM8qFnA5HFH3jEDw2TES5g==
X-Received: by 2002:a17:903:24f:b0:1d4:47d4:82b4 with SMTP id j15-20020a170903024f00b001d447d482b4mr323485plh.15.1704931099623;
        Wed, 10 Jan 2024 15:58:19 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jw17-20020a170903279100b001d0ca40158dsm4211771plb.280.2024.01.10.15.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 15:58:19 -0800 (PST)
Date: Wed, 10 Jan 2024 15:58:18 -0800
From: Kees Cook <keescook@chromium.org>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dmaengine: usb-dmac: Avoid format-overflow warning
Message-ID: <202401101557.87634A6A@keescook>
References: <20240110222210.193479-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <202401101437.48C52CF6@keescook>
 <CA+V-a8tdmD7PB1Rp5K9doXKGzSLwhbSAXD1=UisQebUrug507A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+V-a8tdmD7PB1Rp5K9doXKGzSLwhbSAXD1=UisQebUrug507A@mail.gmail.com>

On Wed, Jan 10, 2024 at 10:46:02PM +0000, Lad, Prabhakar wrote:
> Hi Kees,
> 
> Thank you for the review.
> 
> On Wed, Jan 10, 2024 at 10:41 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Jan 10, 2024 at 10:22:10PM +0000, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > gcc points out that the fix-byte buffer might be too small:
> > > drivers/dma/sh/usb-dmac.c: In function 'usb_dmac_probe':
> > > drivers/dma/sh/usb-dmac.c:720:34: warning: '%u' directive writing between 1 and 10 bytes into a region of size 3 [-Wformat-overflow=]
> > >   720 |         sprintf(pdev_irqname, "ch%u", index);
> > >       |                                  ^~
> > > In function 'usb_dmac_chan_probe',
> > >     inlined from 'usb_dmac_probe' at drivers/dma/sh/usb-dmac.c:814:9:
> > > drivers/dma/sh/usb-dmac.c:720:31: note: directive argument in the range [0, 4294967294]
> > >   720 |         sprintf(pdev_irqname, "ch%u", index);
> > >       |                               ^~~~~~
> > > drivers/dma/sh/usb-dmac.c:720:9: note: 'sprintf' output between 4 and 13 bytes into a destination of size 5
> > >   720 |         sprintf(pdev_irqname, "ch%u", index);
> > >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Maximum number of channels for USB-DMAC as per the driver is 1-99 so use
> > > u8 instead of unsigned int/int for DMAC channel indexing and make the
> > > pdev_irqname string long enough to avoid the warning.
> > >
> > > While at it use scnprintf() instead of sprintf() to make the code more
> > > robust.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > This looks like good fixes; thanks! I see n_channels is sanity checked
> > during the probe in usb_dmac_chan_probe(), so this looks good.
> >
> > (Is there a reason not to also change n_channels to a u8?)
> >
> Good point, I oversighted it by just looking at the loop indices. I
> will send a v2 with that change.

I think you'll need a bounce variable in usb_dmac_chan_probe() since it
looks like it's reading a 32-bit value from DT, but otherwise, it should
be okay.

-Kees

-- 
Kees Cook

