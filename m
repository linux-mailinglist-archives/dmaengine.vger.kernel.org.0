Return-Path: <dmaengine+bounces-2626-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D9A927C27
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2024 19:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7401C2295C
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2024 17:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07D5146015;
	Thu,  4 Jul 2024 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQahnVdO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7121A145A1D;
	Thu,  4 Jul 2024 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720113850; cv=none; b=PGynsVMspCMX1NKNPf2Scc0I8fUF8hztmLwJ1/nK/QEDxTpl/402utqfRSIhjBcMuhbood5E7B5fsmBz4OGpdiE/Fs6+Wnoy+bWRLIzSGJM/VkZToGpNMNWIMTzOoZdojxiK+daSN2XGPae5YNnTPW4C2k/7Kr4Dx0Kk40tHvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720113850; c=relaxed/simple;
	bh=2fTJHOD0LmlLeFBahSLAZCFIrq9XRHWFq2bL1v5L4qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sP+OkjuGDVEw36Mj0sD3Oc6eJWGXubKspRwPeDd+XaM0fwsDCv6N+U013M0IqUpq4QEIkM19VDzGkp5YULwtaeTphJsmClgUsknxScSZ5pxGI2FGM7nMqdT/riwcNRjjNScZ3fiQa/kpDenw12zy6gyMkQnOKK0SegbzfzAJ1BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQahnVdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899D6C3277B;
	Thu,  4 Jul 2024 17:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720113849;
	bh=2fTJHOD0LmlLeFBahSLAZCFIrq9XRHWFq2bL1v5L4qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQahnVdOL66bv7TOymBsqzQpuyXL705H26noZTrUSW00gz5Ueuv5yMgHTdQkpENou
	 BPmAHXnbd8+gFKYpmbYl2zGXPLjgaE+f8gtDH29r3UWTaQoK1+RMtp5yyfTHEoVUq4
	 HpzFuALk+Sij49DH+8kILF7nDA3gijVZeQnESaPLzDsfepXqXFK9tXhwDF5tJhe06y
	 bCH/VqvNcr0EUp7R8esuTAqZ5bjhFOkt2xAWEGgccUur/+4UVaGvjr2lRlUnQ7FCKh
	 z2/NQxMRoYismnsw3H56uqAOkgYnRx69SK2FwsnKxDQzHczf+vpiXRNvY6E9mH5gZC
	 y57riYTojPU7g==
Date: Thu, 4 Jul 2024 18:24:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: sprd,sc9860-dma: convert to YAML
Message-ID: <20240704-broadways-phoniness-3d494c4ef09b@spud>
References: <Zoa9MfYsAuqgh2Vb@standask-GA-A55M-S2HP>
 <20240704-underuse-preacher-b5bb77f92ebf@spud>
 <ZobXOPW33bLHF+Jv@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uSELkERQuZQ/S7b2"
Content-Disposition: inline
In-Reply-To: <ZobXOPW33bLHF+Jv@standask-GA-A55M-S2HP>


--uSELkERQuZQ/S7b2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 07:09:12PM +0200, Stanislav Jakubek wrote:
> Hi Conor,
> see below.
>=20
> On Thu, Jul 04, 2024 at 05:42:39PM +0100, Conor Dooley wrote:
> > On Thu, Jul 04, 2024 at 05:18:09PM +0200, Stanislav Jakubek wrote:
> > > Convert the Spreadtrum SC9860 DMA bindings to DT schema.
> > >=20
> > > Changes during conversion:
> > >   - rename file to match compatible
> > >   - make interrupts optional, the AGCP DMA controller doesn't need it
> > >   - describe the optional ashb_eb clock for the AGCP DMA controller
> > >=20
> > > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > > ---
> > >  .../bindings/dma/sprd,sc9860-dma.yaml         | 92 +++++++++++++++++=
++
> > >  .../devicetree/bindings/dma/sprd-dma.txt      | 44 ---------
> > >  2 files changed, 92 insertions(+), 44 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/dma/sprd,sc9860=
-dma.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/dma/sprd-dma.txt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/dma/sprd,sc9860-dma.ya=
ml b/Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml
> > > new file mode 100644
> > > index 000000000000..e1639593d26d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml
> > > @@ -0,0 +1,92 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/dma/sprd,sc9860-dma.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Spreadtrum SC9860 DMA controller
> > > +
> > > +description: |
> > > +  There are three DMA controllers: AP DMA, AON DMA and AGCP DMA. For=
 AGCP
> > > +  DMA controller, it can or do not request the IRQ, which will save
> > > +  system power without resuming system by DMA interrupts if AGCP DMA
> > > +  does not request the IRQ.
> > > +
> > > +maintainers:
> > > +  - Orson Zhai <orsonzhai@gmail.com>
> > > +  - Baolin Wang <baolin.wang7@gmail.com>
> > > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: sprd,sc9860-dma
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +
> > > +  clock-names:
> > > +    oneOf:
> > > +      - const: enable
> > > +      # The ashb_eb clock is optional and only for AGCP DMA controll=
er
> > > +      - items:
> > > +          - const: enable
> > > +          - const: ashb_eb
> >=20
> > This is better written as:
> >   clock-names:
> >     minItems: 1
> >     items:
> >       - const: enable
> >       - const: ashb_eb
>=20
> Ok, should I keep the comment?

If you like. Another option would be to define the items for clocks
also, instead of this comment, like:

clocks:
  minItems: 1
  items:
    - main DMA controller clock
    - optional clock for the ashb_eb, only for the AGCP DMA controller


>=20
> >=20
> > > +
> > > +  '#dma-cells':
> > > +    const: 1
> > > +
> > > +  dma-channels:
> > > +    const: 32
> > > +
> > > +  '#dma-channels':
> > > +    const: 32
> > > +    deprecated: true
> >=20
> > If there are no users of this, I'd be inclined to just drop it from the
> > binding.
> >=20
> > Cheers,
> > Conor.
>=20
> It is specified in DT "For backwards compatibility", see e.g. [1]
> I'm not sure if it's still required, I'm not very familiar with this plat=
form.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/arm64/boot/dts/sprd/whale2.dtsi?h=3Dv6.10-rc6#n124

Then keep it, that's a user ;)

Cheers,
Conor.

--uSELkERQuZQ/S7b2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZobatQAKCRB4tDGHoIJi
0s/3AP9dQP+kIFaRv2BtnVP/5AiGxafqK3MQlGNX8jVThom3/QEA5agKbit8A2cO
T7mK3+YdEwuupRUnu373hwbDNDL6cgw=
=VLMy
-----END PGP SIGNATURE-----

--uSELkERQuZQ/S7b2--

