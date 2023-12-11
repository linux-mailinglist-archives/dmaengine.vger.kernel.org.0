Return-Path: <dmaengine+bounces-442-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994A380C93E
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 13:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BEB281CD2
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 12:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CD93AC02;
	Mon, 11 Dec 2023 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="APV739V1"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2C2F3;
	Mon, 11 Dec 2023 04:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1702296940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L7kf+hcbV1aunzsc1VgHXPmGkTxyrjAbnWlUqmjpkTo=;
	b=APV739V1DwujHZ/HRZTNPFrxBD2Tls1tzP0FkljoQUKl2aBbwAs9PFWm7i5M+3AjOeEj6s
	GkMR+tAVdKzPn2t4Irv0rSPjQsIeG0XB1V+D+SOgtCg9zTH391azMl5da0b0xSebMXpC33
	9T1rd6FRM76yNCLrA2YNUAZfVgL69vk=
Message-ID: <3da88ffe37e1fa20918848fdef8f80e5ae49743a.camel@crapouillou.net>
Subject: Re: [PATCH 1/4] dmaengine: axi-dmac: Small code cleanup
From: Paul Cercueil <paul@crapouillou.net>
To: Vinod Koul <vkoul@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Nuno =?ISO-8859-1?Q?S=E1?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 11 Dec 2023 13:15:38 +0100
In-Reply-To: <ZXb5IhaNiKJufH/k@matsya>
References: <20231204140352.30420-1-paul@crapouillou.net>
	 <20231204140352.30420-2-paul@crapouillou.net> <ZXb5IhaNiKJufH/k@matsya>
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

Le lundi 11 d=C3=A9cembre 2023 =C3=A0 17:27 +0530, Vinod Koul a =C3=A9crit=
=C2=A0:
> On 04-12-23, 15:03, Paul Cercueil wrote:
> > Use a for() loop instead of a while() loop in
> > axi_dmac_fill_linear_sg().
>=20
> Why?

Simplicity? Code quality?

-Paul

>=20
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> > =C2=A0drivers/dma/dma-axi-dmac.c | 5 +----
> > =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-
> > dmac.c
> > index 2457a420c13d..760940b21eab 100644
> > --- a/drivers/dma/dma-axi-dmac.c
> > +++ b/drivers/dma/dma-axi-dmac.c
> > @@ -508,16 +508,13 @@ static struct axi_dmac_sg
> > *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
> > =C2=A0	segment_size =3D ((segment_size - 1) | chan-
> > >length_align_mask) + 1;
> > =C2=A0
> > =C2=A0	for (i =3D 0; i < num_periods; i++) {
> > -		len =3D period_len;
> > -
> > -		while (len > segment_size) {
> > +		for (len =3D period_len; len > segment_size; sg++) {
> > =C2=A0			if (direction =3D=3D DMA_DEV_TO_MEM)
> > =C2=A0				sg->dest_addr =3D addr;
> > =C2=A0			else
> > =C2=A0				sg->src_addr =3D addr;
> > =C2=A0			sg->x_len =3D segment_size;
> > =C2=A0			sg->y_len =3D 1;
> > -			sg++;
> > =C2=A0			addr +=3D segment_size;
> > =C2=A0			len -=3D segment_size;
> > =C2=A0		}
> > --=20
> > 2.42.0
> >=20
>=20


