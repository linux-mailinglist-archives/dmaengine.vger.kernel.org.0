Return-Path: <dmaengine+bounces-367-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 166008036FF
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 15:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6961F21220
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547E428DDF;
	Mon,  4 Dec 2023 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JcBIWt4Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED9127
	for <dmaengine@vger.kernel.org>; Mon,  4 Dec 2023 06:36:24 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD26420004;
	Mon,  4 Dec 2023 14:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701700583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T0cFMVFKHqxW6z2jR/abnd2rmuLcbjHvEJnsMNfNFJg=;
	b=JcBIWt4YCqhgtrJS//VBX+LWecYREQbKdsO83KNnNkXmh2dha3cPCUzgpLlR8QlWmX/Vac
	EtpvKviUQw7YVKKeqrbWwr2etp4zoDu24Hl8aPFOXV4l0wwzyH72e3eeKopHJyrlUDkRXH
	ckqJ1jv9/7GCUaOK+a2C4ziTvYKTCI9faAG1o1toP+uI8VGFfmHvFmr++mhEMSCeuRwn4b
	zqo+jYinyetWW1QckgVPS/vR0kd68TdPbKgB3TxjW/SOohdks1/o/rxrqBTLoT3LaVxkcl
	pmy3xd31seYnKNBdVd59GnAD4Cx3p5ln0XyM6cU8QL9ubGOxQtL/Am05v7uzFA==
Date: Mon, 4 Dec 2023 15:36:21 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jan Kuliga <jankul@alatek.krakow.pl>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, Raj Kumar
 Rampelli <raj.kumar.rampelli@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Michal Simek
 <monstr@monstr.eu>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dmaengine: xilinx: xdma: Add
 terminate_all/synchronize callbacks
Message-ID: <20231204153621.76f30a8f@xps-13>
In-Reply-To: <5ab105ae-2c10-45db-b5ae-f58e2f9ce8da@alatek.krakow.pl>
References: <20231130111315.729430-1-miquel.raynal@bootlin.com>
	<20231130111315.729430-5-miquel.raynal@bootlin.com>
	<674c7bf3-77dd-9b44-a2cb-8e769a2080df@amd.com>
	<f2192d19-08e6-4f8b-b15c-f8bf44f9058b@alatek.krakow.pl>
	<20231130202339.5feac088@xps-13>
	<d27730fb-1c45-41e6-8cad-da172adf99d0@alatek.krakow.pl>
	<20231204120253.2591eb0b@xps-13>
	<5ab105ae-2c10-45db-b5ae-f58e2f9ce8da@alatek.krakow.pl>
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

jankul@alatek.krakow.pl wrote on Mon, 4 Dec 2023 14:13:13 +0100:

> Hi Miquel,                                                               =
                               =20
>=20
> On 4.12.2023 12:02, Miquel Raynal wrote:
> > Hi Jan,
> >  =20
> >>>>>> +    vchan_synchronize(&xdma_chan->vchan); +} + /** *=20
> >>>>>> xdma_prep_device_sg - prepare a descriptor for a DMA =20
> >> tr =20
> >>>> ansaction =20
> >>>>>> * @chan: DMA channel pointer @@ -1088,6 +1154,8 @@ static=20
> >>>>>> int xdma_probe(struct platform_device * =20
> >> pd =20
> >>>> ev) =20
> >>>>>> xdev->dma_dev.device_prep_slave_sg =3D =20
> >> xdma_prep_device_sg; =20
> >>>>>> xdev->dma_dev.device_config =3D xdma =20
> >> _de =20
> >>>> vice_config; =20
> >>>>>> xdev->dma_dev.device_issue_pending =3D =20
> >> xdma_issue_pending; =20
> >>>>>> +    xdev->dma_dev.device_terminate_all =3D xdma_term =20
> >> in =20
> >>>> ate_all; =20
> >>>>>> +    xdev->dma_dev.device_synchronize =3D xdma_synchr =20
> >> on =20
> >>>> ize; =20
> >>>>>> xdev->dma_dev.filter.map =3D pdata-> =20
> >> dev =20
> >>>> ice_map; =20
> >>>>>> xdev->dma_dev.filter.mapcnt =3D pdat =20
> >> a-> =20
> >>>> device_map_cnt; =20
> >>>>>> xdev->dma_dev.filter.fn =3D xdma_fil =20
> >> ter =20
> >>>> _fn; =20
> >=20
> > Not related, but if you could fix your mailer, it is a bit hard to=20
> > track your answers.
> >  =20
> Thanks for pointing this out, I didn't notice it. From now on it should b=
e okay.
>=20
> >>>>=20
> >>>> I have already prepared a patch with an appropriate fix, which=20
> >>>> I'm goi =20
> >> ng to submit with the whole patch series, once I have interleaved=20
> >> DMA transfers properly sorted out (hopefully soon). Or maybe should
> >> I post this patch with fix, immediately as a reply to the already
> >> sent one? What do y ou prefer? =20
> >>>=20
> >>> I see. Well in the case of cyclic transfers it looks like this
> >>> is enoug =20
> >> h =20
> >>> (I don't have any way to test interleaved/SG transfers) so maybe
> >>>  maintainers can take this now as it is ready and fixes cyclic=20
> >>> transfers, so when the interleaved transfers are ready you can=20
> >>> improve these functions with a series on top of it?
> >>>  =20
> >> So I decided to base my new patchset on my previous one, as I=20
> >> haven't seen any ack from any maintainer yet on both mine and your=20
> >> patchset. I'm going to submit it this week. =20
> >=20
> > Well, the difference between the two approaches is that I am fixing=20
> > something upstream, and you're adding a new feature, which is not=20
> > ready yet. I don't mind about using your patch though, I just want=20
> > upstream to be fixed.
> >  =20
> >> This specific commit of yours (PATCH 4/4) basically does the same=20
> >> thing as mine patch, so there will be no difference in its=20
> >> functionality, i.e. it will also fix cyclic transfers. =20
> >  =20
> Okay, so as far as I understand, you'd like me to submit my patchset base=
d on the top of yours.

That would be ideal, unless my series get postponed for any reason.
I believe the maintainers will soon give their feedback, we'll do what
they prefer.

I believe Lizhi will also give a Tested-by -or not-.

> I guess maintainers will be fine with that (so do I). If so, what is the =
proper way to post my next
> patch series? Should I post it as a reply to your patchset, or as a compl=
etely new thread
> with a information that it is based on this patchset?

You can definitely send an individual patchset and just point out that
it applies on top of the few fixes I sent.

> I don't want to wait with submission
> without getting any feedback until your patches are going to be upstreame=
d.

Of course.

Thanks,
Miqu=C3=A8l

