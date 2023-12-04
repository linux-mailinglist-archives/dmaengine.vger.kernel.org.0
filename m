Return-Path: <dmaengine+bounces-359-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2376B803131
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 12:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2849280E67
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 11:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F79224DB;
	Mon,  4 Dec 2023 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dijH5USe"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74CBB
	for <dmaengine@vger.kernel.org>; Mon,  4 Dec 2023 03:02:58 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E1296FF811;
	Mon,  4 Dec 2023 11:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701687777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqhmreySahAHLPC1NyaT4nFl1a1Fy8cWGWQKCTHwI0I=;
	b=dijH5USe4gzozkvNXejnd5Zqgsnl9KMwf4/UGWZlajmEnAyGf6Skjy5F7BY59X6V/Vswf4
	uZiDSm6Oew0MYTDshbfQZg1CLSpPXfFJ/NfOcJMbsJ8qK3EbowgF9D4HdVu8/jxt+IqX9q
	Lqw6PWup9AciOdV2BIkDuVeQJTwBM1QrUjufTHqgIql/3GCW+BPhISvuHxXlpFEDx4+FbH
	3036n97sROp3OdnWhA+ByChNOCUQmSbS40U5z3KEyReahWAQxlz13T3Pqmb63fwLHw9eak
	Ya0THsEbk/5XRMcDSkw6s61HiHMuy7Ry3Iuj2YrtD9uCgAOj8i3wuVeUApq8/Q==
Date: Mon, 4 Dec 2023 12:02:53 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jan Kuliga <jankul@alatek.krakow.pl>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, Raj Kumar
 Rampelli <raj.kumar.rampelli@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Michal Simek
 <monstr@monstr.eu>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dmaengine: xilinx: xdma: Add
 terminate_all/synchronize callbacks
Message-ID: <20231204120253.2591eb0b@xps-13>
In-Reply-To: <d27730fb-1c45-41e6-8cad-da172adf99d0@alatek.krakow.pl>
References: <20231130111315.729430-1-miquel.raynal@bootlin.com>
	<20231130111315.729430-5-miquel.raynal@bootlin.com>
	<674c7bf3-77dd-9b44-a2cb-8e769a2080df@amd.com>
	<f2192d19-08e6-4f8b-b15c-f8bf44f9058b@alatek.krakow.pl>
	<20231130202339.5feac088@xps-13>
	<d27730fb-1c45-41e6-8cad-da172adf99d0@alatek.krakow.pl>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Jan,

> >>>> +=C2=A0=C2=A0=C2=A0 vchan_synchronize(&xdma_chan->vchan);
> >>>> +}
> >>>> +
> >>>>  =C2=A0 /**
> >>>>  =C2=A0=C2=A0 * xdma_prep_device_sg - prepare a descriptor for a DMA=
 =20
>  tr
> >> ansaction =20
> >>>>  =C2=A0=C2=A0 * @chan: DMA channel pointer
> >>>> @@ -1088,6 +1154,8 @@ static int xdma_probe(struct platform_device *=
 =20
> pd
> >> ev) =20
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_prep_slave_sg =
=3D =20
>  xdma_prep_device_sg;
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_config =3D xdma=
 =20
> _de
> >> vice_config; =20
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_issue_pending =
=3D =20
>  xdma_issue_pending;
> >>>> +=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_terminate_all =3D xdma_term=
 =20
> in
> >> ate_all; =20
> >>>> +=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_synchronize =3D xdma_synchr=
 =20
> on
> >> ize; =20
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.filter.map =3D pdata->=
 =20
> dev
> >> ice_map; =20
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.filter.mapcnt =3D pdat=
 =20
> a->
> >> device_map_cnt; =20
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.filter.fn =3D xdma_fil=
 =20
> ter
> >> _fn;

Not related, but if you could fix your mailer, it is a bit hard to
track your answers.

> >>
> >> I have already prepared a patch with an appropriate fix, which I'm goi=
 =20
> ng to submit with the whole patch series, once I have interleaved DMA tra
> nsfers properly sorted out (hopefully soon). Or maybe should I post this =
patch with fix, immediately as a reply to the already sent one? What do y
> ou prefer?
> >=20
> > I see. Well in the case of cyclic transfers it looks like this is enoug=
 =20
> h
> > (I don't have any way to test interleaved/SG transfers) so maybe
> > maintainers can take this now as it is ready and fixes cyclic
> > transfers, so when the interleaved transfers are ready you can
> > improve these functions with a series on top of it?
> >  =20
> So I decided to base my new patchset on my previous one, as I haven't see=
n any ack from any maintainer yet on both mine and your patchset. I'm going=
 to submit it this week.

Well, the difference between the two approaches is that I am fixing
something upstream, and you're adding a new feature, which is not
ready yet. I don't mind about using your patch though, I just want
upstream to be fixed.

> This specific commit of yours (PATCH 4/4) basically does the same thing a=
s mine patch, so there will be no difference in its functionality, i.e. it =
will also fix cyclic transfers.

Thanks,
Miqu=C3=A8l

