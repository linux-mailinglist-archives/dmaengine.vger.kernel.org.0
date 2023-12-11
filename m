Return-Path: <dmaengine+bounces-443-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99CF80C97F
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 13:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859D42811FC
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 12:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EFC3B1B8;
	Mon, 11 Dec 2023 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="bd8pBHIj"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687F51BB;
	Mon, 11 Dec 2023 04:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1702297239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5PUQntp9MfQXMF/o3JsAZeuDX9zDVymP5JQbOOqzVG4=;
	b=bd8pBHIjpQVk2PjI7aE3jVxZcuLys8R+uLcu3rQchIbm/IdNmt5nlLLRgl8xF0E9dDFzGw
	kwg4ZlRmQQawLkzU600RwEOTMeU++hpAbTnGd1vGdMKvsE8gHhQFoYBPKdKnsJi5lyZZht
	dPlqzjsWQI5uZ6nhpA/mA+raoK/Xcwg=
Message-ID: <381267f0a20d162f87b83c0af6949a9f997ea83e.camel@crapouillou.net>
Subject: Re: [PATCH 4/4] dmaengine: axi-dmac: Use only EOT interrupts when
 doing scatter-gather
From: Paul Cercueil <paul@crapouillou.net>
To: Vinod Koul <vkoul@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Nuno =?ISO-8859-1?Q?S=E1?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 11 Dec 2023 13:20:38 +0100
In-Reply-To: <ZXb6FE5Z1zcmRFKO@matsya>
References: <20231204140352.30420-1-paul@crapouillou.net>
	 <20231204140352.30420-5-paul@crapouillou.net> <ZXb6FE5Z1zcmRFKO@matsya>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZMLQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5UzFZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtNz8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe+rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIPdlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7Urf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KFlBwgAhlGy6nqP7O3u7q23hRW5AQ0EXQqFwQEIAMo+MgvYHsyjX3Ja4Oolg1Txzm8woj30ch2nACFCqaO0R/1kLj2VVeLrDyQUOlXx9PD6IQI4M8wy8m0sR4wV2p/g/paw7k65cjzYYLh+FdLNyO7IW
	YXndJO+wDPi3aK/YKUYepqlP+QsmaHNYNdXEQDRKqNfJg8t0f5rfzp9ryxd1tCnbV+tG8VHQWiZXNqN7062DygSNXFUfQ0vZ3J2D4oAcIAEXTymRQ2+hr3Hf7I61KMHWeSkCvCG2decTYsHlw5Erix/jYWqVOtX0roOOLqWkqpQQJWtU+biWrAksmFmCp5fXIg1Nlg39v21xCXBGxJkxyTYuhdWyu1yDQ+LSIUAEQEAAYkBNgQYAQoAIBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsMAAoJEHPua9InSr1B4wsH/Az767YCT0FSsMNt1jkkdLCBi7nY0GTW+PLP1a4zvVqFMo/vD6uz1ZflVTUAEvcTi3VHYZrlgjcxmcGu239oruqUS8Qy/xgZBp9KF0NTWQSl1iBfVbIU5VV1vHS6r77W5x0qXgfvAUWOH4gmN3MnF01SH2zMcLiaUGF+mcwl15rHbjnT3Nu2399aSE6cep86igfCAyFUOXjYEGlJy+c6UyT+DUylpjQg0nl8MlZ/7Whg2fAU9+FALIbQYQzGlT4c71SibR9T741jnegHhlmV4WXXUD6roFt54t0MSAFSVxzG8mLcSjR2cLUJ3NIPXixYUSEn3tQhfZj07xIIjWxAYZo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Vinod,

Le lundi 11 d=C3=A9cembre 2023 =C3=A0 17:31 +0530, Vinod Koul a =C3=A9crit=
=C2=A0:
> On 04-12-23, 15:03, Paul Cercueil wrote:
> > Instead of notifying userspace in the end-of-transfer (EOT)
> > interrupt
> > and program the hardware in the start-of-transfer (SOT) interrupt,
> > we
> > can do both things in the EOT, allowing us to mask the SOT, and
> > halve
> > the number of interrupts sent by the HDL core.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> > =C2=A0drivers/dma/dma-axi-dmac.c | 7 ++++++-
> > =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-
> > dmac.c
> > index 5109530b66de..beed91a8238c 100644
> > --- a/drivers/dma/dma-axi-dmac.c
> > +++ b/drivers/dma/dma-axi-dmac.c
> > @@ -415,6 +415,7 @@ static bool axi_dmac_transfer_done(struct
> > axi_dmac_chan *chan,
> > =C2=A0			list_del(&active->vdesc.node);
> > =C2=A0			vchan_cookie_complete(&active->vdesc);
> > =C2=A0			active =3D axi_dmac_active_desc(chan);
> > +			start_next =3D !!active;
>=20
> Should this be in current patch, sounds like this should be a
> different
> patch?

It belongs here. This line is what allows a new transfer to be
programmed from the EOT. Since we disable the SOT interrupt, if we
remove that line, the driver won't work.

Cheers,
-Paul

>=20
> > =C2=A0		}
> > =C2=A0	} else {
> > =C2=A0		do {
> > @@ -1000,6 +1001,7 @@ static int axi_dmac_probe(struct
> > platform_device *pdev)
> > =C2=A0	struct axi_dmac *dmac;
> > =C2=A0	struct regmap *regmap;
> > =C2=A0	unsigned int version;
> > +	u32 irq_mask =3D 0;
> > =C2=A0	int ret;
> > =C2=A0
> > =C2=A0	dmac =3D devm_kzalloc(&pdev->dev, sizeof(*dmac),
> > GFP_KERNEL);
> > @@ -1067,7 +1069,10 @@ static int axi_dmac_probe(struct
> > platform_device *pdev)
> > =C2=A0
> > =C2=A0	dma_dev->copy_align =3D (dmac->chan.address_align_mask + 1);
> > =C2=A0
> > -	axi_dmac_write(dmac, AXI_DMAC_REG_IRQ_MASK, 0x00);
> > +	if (dmac->chan.hw_sg)
> > +		irq_mask |=3D AXI_DMAC_IRQ_SOT;
> > +
> > +	axi_dmac_write(dmac, AXI_DMAC_REG_IRQ_MASK, irq_mask);
> > =C2=A0
> > =C2=A0	if (of_dma_is_coherent(pdev->dev.of_node)) {
> > =C2=A0		ret =3D axi_dmac_read(dmac,
> > AXI_DMAC_REG_COHERENCY_DESC);
> > --=20
> > 2.42.0
> >=20
>=20


