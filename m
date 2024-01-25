Return-Path: <dmaengine+bounces-825-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1172D83C61D
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jan 2024 16:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC9C287EAB
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jan 2024 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138236EB4A;
	Thu, 25 Jan 2024 15:09:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F243D6E2D1;
	Thu, 25 Jan 2024 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195396; cv=none; b=dQWJ7tyHLzNwS1QIleD3wc5rLf/HN5GqmHVS2G/WL8WZyz2G1ngwBqr7YuNxDSx7xMME9je/aWpPZASdyaAecs30O95ePg75PHCkTo/q0Vjh1QnQbeX9DjIIbyYrOjuOBPM0J70nHI5LIYSUtZoQm8W5IY77o98ygP+Sobtg8Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195396; c=relaxed/simple;
	bh=xkj76bvYfywTRnt3r/48EHdmO24JgVecEXm2TtbqqNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYHt6UOlqfTmf0TiXq4mrHo+88KIwcy00wThnKXkipYPKom8OEigHYjQnQNBfI+t8fEA7dBPV+/YT7dvchf4mUXkbEtnZcBJM0l41Ixzb89oQmeG8S/FDffwGy40BYatN6ncRxHPm+Rv8Nr67UlmlJNPiBEj1GtPlb2ruQvkaAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D12211FB;
	Thu, 25 Jan 2024 07:10:35 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D0A73F5A1;
	Thu, 25 Jan 2024 07:09:49 -0800 (PST)
Date: Thu, 25 Jan 2024 15:09:42 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-sound@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: dma: allwinner,sun50i-a64-dma: Add
 compatible for H616
Message-ID: <20240125150942.2535a228@donnerap.manchester.arm.com>
In-Reply-To: <CAGb2v66UmLuWyLvvULZeW6MKFauM-xAMPAO9W_TPAByXYqKCBg@mail.gmail.com>
References: <20240122170518.3090814-1-wens@kernel.org>
	<20240122170518.3090814-5-wens@kernel.org>
	<20240123004010.59cac5ad@minigeek.lan>
	<CAGb2v66UmLuWyLvvULZeW6MKFauM-xAMPAO9W_TPAByXYqKCBg@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jan 2024 22:37:34 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

Hi,

> On Tue, Jan 23, 2024 at 8:41=E2=80=AFAM Andre Przywara <andre.przywara@ar=
m.com> wrote:
> >
> > On Tue, 23 Jan 2024 01:05:15 +0800
> > Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > Hi,
> > =20
> > > From: Chen-Yu Tsai <wens@csie.org>
> > >
> > > The DMA controllers found on the H616 and H618 are the same as the one
> > > found on the H6. The only difference is the DMA endpoint (DRQ) layout=
. =20
> >
> > That does not seem to be entirely true: The H616 encodes the two lowest
> > bits in DMA_DESC_ADDR_REG differently: on the H6 they must be 0 (word
> > aligned), on the H616 these contain bits [33:32] of the address of the
> > DMA descriptor. The manual doesn't describe the descriptor format in
> > much detail, but ec31c5c59492 suggests that those two bits are put in
> > the "para" word of the descriptor. =20
>=20
> Good catch. So, same as the A100 I believe?

Yes, that's what I got as well.

> > The good thing it that this encoding is backwards compatible, so I
> > think the fallback string still holds: Any driver just implementing the
> > H6 encoding would be able to drive the H616.
> >
> > I think the A100 was mis-described, as mentioned here:
> > https://lore.kernel.org/linux-arm-kernel/29e575b6-14cb-73f1-512d-9f0f93=
4490ea@arm.com/
> > I think we should:
> > - make the A100 use: "allwinner,sun50i-a100-dma", "sun50i-h6-dma"
> > - make the H616 use: "allwinner,sun50i-h616-dma", "allwinner,sun50i-a10=
0-dma", "sun50i-h6-dma"
> >
> > Does that make sense? =20
>=20
> I wouldn't call that exactly backward compatible. Say the driver forgot to
> clear the two bits. It would work fine on the H6, but the accessed address
> could be way off on the A100 and H616.

I don't know the exact boundaries of "compatible" here, but the H6 manual
pretty clearly states "The descriptor address must be word-aligned."
But since the A100 compatible is known and supported for a while, that
doesn't really matter, practically speaking, I guess.

One could check how the H6 DMA controller reacts to those bits not being
0, not sure if I find the time, though.

Cheers,
Andre.

> > Cheers,
> > Andre
> > =20
> > > Since the number of channels and endpoints are described with additio=
nal
> > > generic properties, just add a new H616-specific compatible string and
> > > fallback to the H6 one.
> > >
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > ---
> > >  .../bindings/dma/allwinner,sun50i-a64-dma.yaml    | 15 +++++++++++--=
--
> > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a=
64-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dm=
a.yaml
> > > index ec2d7a789ffe..e5693be378bd 100644
> > > --- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.=
yaml
> > > +++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.=
yaml
> > > @@ -28,6 +28,9 @@ properties:
> > >        - items:
> > >            - const: allwinner,sun8i-r40-dma
> > >            - const: allwinner,sun50i-a64-dma
> > > +      - items:
> > > +          - const: allwinner,sun50i-h616-dma
> > > +          - const: allwinner,sun50i-h6-dma
> > >
> > >    reg:
> > >      maxItems: 1
> > > @@ -59,10 +62,14 @@ required:
> > >  if:
> > >    properties:
> > >      compatible:
> > > -      enum:
> > > -        - allwinner,sun20i-d1-dma
> > > -        - allwinner,sun50i-a100-dma
> > > -        - allwinner,sun50i-h6-dma
> > > +      oneOf:
> > > +        - enum:
> > > +            - allwinner,sun20i-d1-dma
> > > +            - allwinner,sun50i-a100-dma
> > > +            - allwinner,sun50i-h6-dma
> > > +        - items:
> > > +            - const: allwinner,sun50i-h616-dma
> > > +            - const: allwinner,sun50i-h6-dma
> > >
> > >  then:
> > >    properties: =20
> > =20
>=20


