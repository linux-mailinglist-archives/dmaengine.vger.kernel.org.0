Return-Path: <dmaengine+bounces-7742-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9841CC6463
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 07:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EA58304F11B
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 06:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F799313545;
	Wed, 17 Dec 2025 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="DJbCZ9JI"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA6311C30;
	Wed, 17 Dec 2025 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765953282; cv=none; b=EBC/YKNm/j6Z2ESbYQjIGe4m7rTDkxU6dplI22tOiUNegGkFRL/B5cHQp6wFxKCzmkU6OS8/jb4NlsL60rFNQCywvTjfJ+0uCLtuuVS/2JnbUD54R9c5cu/lsZFbVT66Vxr+jQLGlvs1Ko1iwn2rLjrKiUvuu6sLC+P5YPT0mLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765953282; c=relaxed/simple;
	bh=FXvzyuor5O93IICa/mEsw7W5vjo1bFaXlXdvxn/LBNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=On43rCZaLCPjdzrsZ6yyzPGBhYusKEcMC0KvC2SxbAYHOJ+o2VtgL3tQDufZMhtuUPt1Zgk8cbn+fY5mkik2FINWrFUMobx24UQvvHinPoGTvyQb3UU0TacQVErY+Ap7w6ohXhoIzybv0PDPDeBEuSnUwbBVyYBSzwyZ9BHoGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=DJbCZ9JI; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19042444B5;
	Wed, 17 Dec 2025 06:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1765953272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZh9dHS8Dtfv8ujCmkwpKZQwtkzHUzvrWD3huUC/4dQ=;
	b=DJbCZ9JIgH9U44U0cyVKOae4zelzA30sA5wo9ssXjDZwQfVA9lp2ELtTponfD54O9v+yl0
	9u1r8PP1CIHawddyl8XSbgG5OBEVO5F/vIalnymzeYNUwjgfW+LD31Gpf8YB4Eu3y/MGII
	h1EsEkWz+189NtG2qlDJlDuZNXAz+TQrcFptz2XDW28z+NrSn8XzQYAPgKFT8wm9dZJYsu
	y7PGVD6p+pmUvVEfUPdk+sbIhGaG9yhJ45hn87CxQ4NVeljqpCOwXrqumSpZU34rT0WOhD
	8eb9m8WuOIpfHoRDbUm8G7+U95Z65lsInn+dlX9NG9ZIoys8HHxDX3qfa4eURw==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.li@nxp.com>,
 Greg Ungerer <gerg@linux-m68k.org>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 2/5] dma: mcf-edma: Add per-channel IRQ naming for debugging
Date: Wed, 17 Dec 2025 07:34:07 +0100
Message-ID: <5064909.31r3eYUQgx@jeanmichel-ms7b89>
In-Reply-To: <aUF8/r6FZcPraINk@lizhi-Precision-Tower-5810>
References:
 <20251126-dma-coldfire-v2-0-5b1e4544d609@yoseli.org> <aUF6CdS6WVZuEP24@vaman>
 <aUF8/r6FZcPraINk@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegudekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomheplfgvrghnqdfoihgthhgvlhcujfgruhhtsghoihhsuceojhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgqeenucggtffrrghtthgvrhhnpeffvefhuddvleduuefgtdeludeuvdfhuedvvefgieeifeeiveetkedttedtieefteenucfkphepvdgrtddumegvtdgrmeduieelmeejudegtdemvdgrgedtmehffegrrgemjedujegvmedufegsvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudeileemjedugedtmedvrgegtdemfhefrggrmeejudejvgemudefsgdvpdhhvghlohepjhgvrghnmhhitghhvghlqdhmshejsgekledrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhqihgupeduledtgedvgeeggeeuhedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepvhhkohhulheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephfhrrghnkhdrlhhisehng
 ihprdgtohhmpdhrtghpthhtohepghgvrhhgsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepughmrggvnhhgihhnvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhg
X-GND-State: clean

Hi Frank,

Le mardi 16 d=C3=A9cembre 2025, 16:38:38 heure normale d=E2=80=99Europe cen=
trale Frank Li a=20
=C3=A9crit :
> On Tue, Dec 16, 2025 at 08:56:01PM +0530, Vinod Koul wrote:
> > On 26-11-25, 11:12, Frank Li wrote:
> > > On Wed, Nov 26, 2025 at 09:36:03AM +0100, Jean-Michel Hautbois via B4=
=20
Relay wrote:
> > > > From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> > > >=20
> > > > Add dynamic per-channel IRQ naming to make DMA interrupt
> > > > identification
> > > > easier in /proc/interrupts and debugging tools.
> > > >=20
> > > > Instead of all channels showing "eDMA", they now show:
> > > > - "eDMA-0" through "eDMA-15" for channels 0-15
> > > > - "eDMA-16" through "eDMA-55" for channels 16-55
> > > > - "eDMA-tx-56" for the shared channel 56-63 interrupt
> > > > - "eDMA-err" for the error interrupt
> > > >=20
> > > > This aids debugging DMA issues by making it clear which channel's
> > > > interrupt is being serviced.
> > > >=20
> > > > Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> > > > ---
> > > >=20
> > > >  drivers/dma/mcf-edma-main.c | 26 ++++++++++++++++++--------
> > > >  1 file changed, 18 insertions(+), 8 deletions(-)
> > > >=20
> > > > diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-mai=
n.c
> > > > index f95114829d80..6a7d88895501 100644
> > > > --- a/drivers/dma/mcf-edma-main.c
> > > > +++ b/drivers/dma/mcf-edma-main.c
> > > > @@ -81,8 +81,14 @@ static int mcf_edma_irq_init(struct platform_dev=
ice
> > > > *pdev,> > >=20
> > > >  	if (!res)
> > > >  =09
> > > >  		return -1;
> > > >=20
> > > > -	for (ret =3D 0, i =3D res->start; i <=3D res->end; ++i)
> > > > -		ret |=3D request_irq(i, mcf_edma_tx_handler, 0, "eDMA",=20
mcf_edma);
> > > > +	for (ret =3D 0, i =3D res->start; i <=3D res->end; ++i) {
> > > > +		char *irq_name =3D devm_kasprintf(&pdev->dev,=20
GFP_KERNEL,
> > > > +						"eDMA-%d",=20
(int)(i - res->start));
> > > > +		if (!irq_name)
> > > > +			return -ENOMEM;
> > > > +
> > > > +		ret |=3D request_irq(i, mcf_edma_tx_handler, 0,=20
irq_name, mcf_edma);
> > > > +	}
> > > >=20
> > > >  	if (ret)
> > > >  =09
> > > >  		return ret;
> > >=20
> > > The existing code have problem, it should use devm_request_irq(). if =
one
> > > irq request failure, return here,  requested irq will not free.
> >=20
> > Why is that an error!
>=20
>         ret =3D fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
>         if (ret)
>                 return ret;
>=20
> if last one of request_irq() failure, mcf_edma_irq_init() return failure.
> probe will return failure also without free irq.
>=20
> So previous irq by request_irq() is never free at this case.

=46rom kernel/irq/manage.c I see in a nutshell:
	request_threaded_irq() {
		action =3D kzalloc(sizeof(struct irqaction), GFP_KERNEL);
		retval =3D __setup_irq(irq, desc, action);
		if (retval) {
			kfree(action->secondary);
			kfree(action);
		}
	}

I don't see an issue with the existing code then ?
Am I wrong ?

Thanks,
JM

>=20
> Frank
>=20
> > > You'd better add patch before this one to change to use
> > > devm_request_irq()
> >=20
> > Not really, devm_ is a not always good option.
> >=20
> > --
> > ~Vinod





