Return-Path: <dmaengine+bounces-284-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8340F7FCB38
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 01:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7680C1C20D3A
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 00:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81A836E;
	Wed, 29 Nov 2023 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G+YFOkyR"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EED8E
	for <dmaengine@vger.kernel.org>; Tue, 28 Nov 2023 16:13:48 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 94127E0003;
	Wed, 29 Nov 2023 00:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701216827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D74rwPXHEq5ely5oX88C28HJfqSmsj6hY3YMNQsYcek=;
	b=G+YFOkyRWJqwokk6BzXb9JIbUQ1CoNGiOooDG5X25abHCmrZdYxLM7oFmbay7AEFu5Te2I
	5EjTbqUQy2JGFAnArOBTTKHYM6FGoEIgMSzR+q4QQKZGd00OUGQzh2fEpAIznBRaa2PNZg
	AnO6NBcMB0eQZcx6/ggNhYijKMHoy7WiyzGuNO0zXU91JxxGrwQzrTsQAm50pxjFt/1cCL
	KwrFkfPwUamgmTsLNGD/164Aa8oJIo+bsx13KthnflWlOvVxqhD96K/il3vDBgcT3lyNgG
	MpROtLRJw0RGYk5v9NuD/CBww2oeSgah5DQODj1QwRwZIoONGY03wF0WR9AFNQ==
Date: Wed, 29 Nov 2023 01:13:44 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Brian Xu <brian.xu@amd.com>, Raj Kumar
 Rampelli <raj.kumar.rampelli@amd.com>, <dmaengine@vger.kernel.org>, Michal
 Simek <monstr@monstr.eu>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] dmaengine: xilinx: xdma: Fix the count of elapsed
 periods in cyclic mode
Message-ID: <20231129011344.35450ee3@xps-13>
In-Reply-To: <3403ac76-db69-d2c2-0bd1-03e8210d309e@amd.com>
References: <20231124150923.257687-1-miquel.raynal@bootlin.com>
	<20231124150923.257687-2-miquel.raynal@bootlin.com>
	<3403ac76-db69-d2c2-0bd1-03e8210d309e@amd.com>
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

Hi Lizhi,

lizhi.hou@amd.com wrote on Tue, 28 Nov 2023 14:44:35 -0800:

> On 11/24/23 07:09, Miquel Raynal wrote:
> > Xilinx DMA engine is capable of keeping track of the number of elapsed
> > periods and this is an increasing 32-bit counter which is only reset
> > when turning off the engine. No need to add this value to our local
> > counter.
> >
> > Fixes: cd8c732ce1a5 ("dmaengine: xilinx: xdma: Support cyclic transfers=
")
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >
> > Hello, so far all my testing was performed by looping the playback
> > output to the recording input and comparing the files using
> > FFTs. Unfortunately, when the DMA engine suffers from the same issue on
> > both sides, some issues may appear un-noticed, which is likely what
> > happened here as the tooling did not report any issue while analyzing
> > the output until I actually listened to real audio now that I have in my
> > hands the relevant hardware/connectors to do so.
> > ---
> >   drivers/dma/xilinx/xdma.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> > index 84a88029226f..75533e787414 100644
> > --- a/drivers/dma/xilinx/xdma.c
> > +++ b/drivers/dma/xilinx/xdma.c
> > @@ -754,7 +754,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *=
dev_id)
> >   	if (ret)
> >   		goto out; =20
> >   > -	desc->completed_desc_num +=3D complete_desc_num; =20
> > +	desc->completed_desc_num =3D complete_desc_num; =20
>=20
> Based on PG195, completed descriptor count will be reset to 0 on rising e=
dge of Control register Run bit. That means it resets to zero for each tran=
saction.
>=20
> This change breaks our long sg list test.

Ok, so we need act differently depending on the type of transfer (sg or
cyclic). Thanks for the feedback!

>=20
> >   >   	if (desc->cyclic) { =20
> >   		ret =3D regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS, =20

Miqu=C3=A8l

