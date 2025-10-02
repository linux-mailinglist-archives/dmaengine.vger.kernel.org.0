Return-Path: <dmaengine+bounces-6747-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B7BB4E6D
	for <lists+dmaengine@lfdr.de>; Thu, 02 Oct 2025 20:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F5319E2E29
	for <lists+dmaengine@lfdr.de>; Thu,  2 Oct 2025 18:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE9A278754;
	Thu,  2 Oct 2025 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff7hpOaY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925A92571DE;
	Thu,  2 Oct 2025 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430439; cv=none; b=BXH2iW9GEgQzLB76e/S3TNf4QUJweh2Tw0Lcbk8AtDztcxcCVp2CGx6Sv2k6K6OhSPVoQNvfpF69Z+Z1/U+c2PhQ8xmqfZtw3B1p03hVnaeJFB15w1M71/sj8+nT0aaOmVkhCh9r77AWTQzM13R3CdEVbrwNRBSWplFb3GHgcp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430439; c=relaxed/simple;
	bh=fwTtsUPYJVOlpkA66j2uVR8ENFsOOHxB+ZW/L8G0yRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcLjrcg2quQrsRFMYwwB11Wg4VWICHNpf2zMKxiyO3Vh9PLYq5kAwwVCs9ffj7CeXR6syVahb2NvxMr15dBP9YxYIiUV2dfZcGMkP60g/VyTtZtAAFwNE2wvsrTk6/HooBpGb0VW/RPHcFZmuLCTXDddb8SL0v0sDRzv6oaMefA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff7hpOaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F456C4CEF4;
	Thu,  2 Oct 2025 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759430439;
	bh=fwTtsUPYJVOlpkA66j2uVR8ENFsOOHxB+ZW/L8G0yRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ff7hpOaY/xSbPkdVhYs7ci2gDfydT6OFQbngmQHeemRllNX/yfvoN3IH+0++gLtfD
	 PbxtphI1lWdk16+QswHR9jnG+Vef3mrWHasSsAlcvpYbDOx27Y+z/vYrD8p0//2wMT
	 ePv3+lFl2NmIRQ2AsiZN7zldp7aj+Qldfva7WCvz+Mux6Tajk089slqgMStgT0kByk
	 4NiNI/Ej9hM7A6l+M0BOCgeZxlh8Oepw9FQ3hGQAzTkI7LyzMzJmmfdM5l4gqo1sgY
	 /phzLKxRuCLqvfjkYBjTNbZ1UPLvIpnMxax0lhPVxwtl3H87+sNUQ3EDgjXn6BVXEQ
	 xa73bZcOJBb2w==
Date: Thu, 2 Oct 2025 19:40:35 +0100
From: Conor Dooley <conor@kernel.org>
To: CL Wang <cl634@andestech.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, tim609@andestech.com
Subject: Re: [PATCH V1 1/2] dt-bindings: dmaengine: Add support for
 ATCDMAC300 DMA engine
Message-ID: <20251002-absolute-spinning-f899e75b2c4a@spud>
References: <20251002131659.973955-1-cl634@andestech.com>
 <20251002131659.973955-2-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0bZRS7GJG8pMLpnu"
Content-Disposition: inline
In-Reply-To: <20251002131659.973955-2-cl634@andestech.com>


--0bZRS7GJG8pMLpnu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025 at 09:16:58PM +0800, CL Wang wrote:
> Document devicetree bindings for Andes ATCDMAC300 DMA engine
>=20
> Signed-off-by: CL Wang <cl634@andestech.com>
> ---
>  .../bindings/dma/andestech,atcdmac300.yaml    | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/andestech,atcdm=
ac300.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/dma/andestech,atcdmac300.y=
aml b/Documentation/devicetree/bindings/dma/andestech,atcdmac300.yaml
> new file mode 100644
> index 000000000000..769694616517
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/andestech,atcdmac300.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/andestech,atcdmac300.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Andes ATCDMAC300 DMA Controller
> +
> +maintainers:
> +  - CL Wang <cl634@andestech.com>
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: andestech,atcdmac300

"atcdmac300" sounds like the name of an IP block. What platforms are
actually using this? They should have platform-specific compatibles, for
example, "andestech,qilai-dma" if that's the platform where this is
supported.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        dma-controller@f0c00000 {
> +            compatible =3D "andestech,atcdmac300";
> +            reg =3D <0x0 0xf0c00000 0x0 0x1000>;
> +            interrupts =3D <10 IRQ_TYPE_LEVEL_HIGH>;
> +            #dma-cells =3D <1>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..dd3272cdadd6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1778,6 +1778,12 @@ S:	Supported
>  F:	drivers/clk/analogbits/*
>  F:	include/linux/clk/analogbits*
> =20
> +ANDES DMA DRIVER
> +M:	CL Wang <cl634@andestech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/dma/andestech,atcdmac300.yaml
> +F:	drivers/dma/atcdmac300*
> +
>  ANDROID DRIVERS
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Arve Hj=F8nnev=E5g <arve@android.com>
> --=20
> 2.34.1
>=20

--0bZRS7GJG8pMLpnu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaN7HIwAKCRB4tDGHoIJi
0mrkAQDijHe7ck5E0SlBl4zVXZHPxERs696Pe/13Zeoebt64gQD/XPqfv0lxc/Az
rQrWzkaGCDyg6sZHyyw4qJDvlAmxEwk=
=z0RT
-----END PGP SIGNATURE-----

--0bZRS7GJG8pMLpnu--

