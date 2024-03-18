Return-Path: <dmaengine+bounces-1418-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEEA87E89E
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 12:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449DA1F22EE0
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 11:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B18364B1;
	Mon, 18 Mar 2024 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwUSOlJQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A4F38382;
	Mon, 18 Mar 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761375; cv=none; b=K6umvjPZ6jk5DvOpBrDuSAHTH9qZC9Z0NnE76SJT4rGhpJrBWtB2+vWtjnSGf7wUiKInQxXVr115Krc8/12zxf77ImYwANwvp2kUAMLYC5MIikQJJEgALHil3zt/8INHySEaAVBpwGKpRoILumBStnUicznPvN1ejRPyFLowg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761375; c=relaxed/simple;
	bh=CXvlbrCMPnb9yef1bDHrNzW1AMGOSDWEgQsKsUa5qHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZTFKPng8sel/b8ksCyi7cIM/hb4BSzgVtcA1c2bworRKA3WFXMo1L0FfA6AqT9l0zSuBVw1gvIP0ll/oIV7aVFSVrY3r+BgibP7JDqIjHVtRlLs4c0ilH0YDOEftU4tcoQB0FG3lJ3jKEIt+5bDHIKrahT1N51e3etG9tlpUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwUSOlJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823B5C433F1;
	Mon, 18 Mar 2024 11:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710761375;
	bh=CXvlbrCMPnb9yef1bDHrNzW1AMGOSDWEgQsKsUa5qHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwUSOlJQToeinOU4wVaJ8RsNNPCwNRTr5UbDj/stk9hf2On2TMRZYI+wZYWkAtAU2
	 iCPiS9vB21HLx1IfjtzL3AJi18eTelDa2vZ07SCm+28NfsyCRB9xSIH/CIAtoTs8Ni
	 LeiIbNbkUwB0eyvK8cbSi5KyL9adJb4XuNDEW2mAmeqX39Czpn9+iqPILYS9ktvpwk
	 98/hEUiYRCrcpuVIWA7KH6Of7Nq9+FXCXHuXpjOqOJuUuSmSqEF3kB1m+AgciRV9Rm
	 /l71F4THAw/n7iaqjj4zXKFRnS8yZxoh9uLPcvCAoBuTVo144iu5P7Va85AEHImcQj
	 01Zh/sQtUkgZQ==
Date: Mon, 18 Mar 2024 11:29:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: dma: Add Loongson-1 DMA
Message-ID: <20240318-value-snide-8733098b9e76@spud>
References: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
 <20240316-loongson1-dma-v6-1-90de2c3cc928@gmail.com>
 <20240317-exorcist-spectator-90f5acb3fe2a@spud>
 <CAJhJPsWOUZsWFvreRrPqQHAjYW7uRT31THHi7CRDN46+nHpL9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RdFJ9jAojuY1Z+9n"
Content-Disposition: inline
In-Reply-To: <CAJhJPsWOUZsWFvreRrPqQHAjYW7uRT31THHi7CRDN46+nHpL9g@mail.gmail.com>


--RdFJ9jAojuY1Z+9n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 02:18:27PM +0800, Keguang Zhang wrote:
> On Sun, Mar 17, 2024 at 10:40=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Sat, Mar 16, 2024 at 07:33:53PM +0800, Keguang Zhang via B4 Relay wr=
ote:
> > > From: Keguang Zhang <keguang.zhang@gmail.com>
> > >
> > > Add devicetree binding document for Loongson-1 DMA.
> > >
> > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > ---
> > > V5 -> V6:
> > >    Change the compatible to the fallback
> > >    Some minor fixes
> > > V4 -> V5:
> > >    A newly added patch
> > > ---
> > >  .../devicetree/bindings/dma/loongson,ls1x-dma.yaml | 66 ++++++++++++=
++++++++++
> > >  1 file changed, 66 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.=
yaml b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> > > new file mode 100644
> > > index 000000000000..06358df725c6
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> > > @@ -0,0 +1,66 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/dma/loongson,ls1x-dma.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Loongson-1 DMA Controller
> > > +
> > > +maintainers:
> > > +  - Keguang Zhang <keguang.zhang@gmail.com>
> > > +
> > > +description:
> > > +  Loongson-1 DMA controller provides 3 independent channels for
> > > +  peripherals such as NAND and AC97.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - const: loongson,ls1b-dma
> > > +      - items:
> > > +          - enum:
> > > +              - loongson,ls1c-dma
> > > +          - const: loongson,ls1b-dma
> >
> > Aren't there several more devices in this family? Do they not have DMA
> > controllers?
> >
> You are right. Loongson1 is a SoC family.
> However, only 1A/1B/1C have DMA controller.

You're missing the 1A then.

>=20
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    description: Each channel has a dedicated interrupt line.
> > > +    minItems: 1
> > > +    maxItems: 3
> >
> > Is this number not fixed for each SoC?
> >
> Yes. Actually, it's fixed for the whole family.

Then why do you have minItems: 1? Are there multiple DMA controllers
on each SoC that only make use of a subset of the possible channels?

> > > +  interrupt-names:
> > > +    minItems: 1
> > > +    items:
> > > +      - pattern: ch0
> > > +      - pattern: ch1
> > > +      - pattern: ch2
> >
> > Why have you made these a pattern? There's no regex being used here at
> > all.
> >
> Will change items to the following regex.
>   interrupt-names:
>     minItems: 1
>     items:
>       - pattern: "^ch[0-2]$"


--RdFJ9jAojuY1Z+9n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfglmwAKCRB4tDGHoIJi
0myiAP9gqCVAPtwBo6/5Xq10Pb546e9hiXfet6M/dCcQh2nfTAD/ZGnnWlZC69Vs
HL/FoR4cgDmA6m1mCAf54NbieojKPwc=
=gd7t
-----END PGP SIGNATURE-----

--RdFJ9jAojuY1Z+9n--

