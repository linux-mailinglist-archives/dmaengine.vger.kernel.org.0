Return-Path: <dmaengine+bounces-4232-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2C3A22DC0
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 14:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C01188522F
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 13:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6361E500C;
	Thu, 30 Jan 2025 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WECUUaVM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7C1BCA0C;
	Thu, 30 Jan 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738243743; cv=none; b=OSDW236fmYewPGSOmu1yk+46xaHfkeYCjkPzLDiK5uefXrvU8B0OR6bovpRdmUffUXMIcW/XjbAQmacLXtW3gWTaAhh1x2HX0BNj3Q0+a1uth4m2nZjkD4308wV3G6cjFa8IIilnWKWQIsRrfHh9x1TM9dvlM4tyxRu8n2div44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738243743; c=relaxed/simple;
	bh=SzL+0ECLZhbMXBiNpxvhWK0pVhnz1sd91qYL9DClqgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pry2kgYnREUJXeAxfO5beZ7dnwsJLcWd1i0xjOC3oBX5EyKQAgPnHN8gv38BbH+lVLPRczPpPX4+KcHbPQyiXNk662h6gWmjD9WMBBbmpspYIw2K6r7u4YwuVreb6Oor8iLQ90CSMyAu6t1076+tAi21NSNiUeD+sKObyFvCVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WECUUaVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2243C4CEE0;
	Thu, 30 Jan 2025 13:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738243742;
	bh=SzL+0ECLZhbMXBiNpxvhWK0pVhnz1sd91qYL9DClqgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WECUUaVMInqFHMFwEGhbamsuAJkqp8L1NgIs5r8eaLytvmVkM94f3iOFQ0V8wiZah
	 s6MTIhHnm1Ws1dq3R4zMdLL/5JuLl/vi90+PsRsK7dHwtj9aRxOOC5WYoDGBIJrJLu
	 4pUKyhI7WFCKj0kjsyDtb7XV1ctGhun4+H1ciLLpRQh8VnagZbY1ezED7b8a9WOJuX
	 jRF77ATie3d4fYpEckR58GXo2APy/MesYmtoYDr+yONY4qqo1DEbmfKnS5GOIjXOdd
	 00zp0ifUehqpMff0Y3vdGvcBnRsdUDJ2XUYN3Wv5+hTGMa7zz3GSC1z1a7YIy6wFrN
	 XJhSoqRZISXYA==
Date: Thu, 30 Jan 2025 14:28:59 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Florent Tomasin <florent.tomasin@arm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Yong Wu <yong.wu@mediatek.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, nd@arm.com, 
	Akash Goel <akash.goel@arm.com>
Subject: Re: [RFC PATCH 1/5] dt-bindings: dma: Add CMA Heap bindings
Message-ID: <ats2unrml5a7vbpdrqrzowodrsfj44bnubpbujg2igk3imeklx@nrpmg5oeq3gz>
References: <cover.1738228114.git.florent.tomasin@arm.com>
 <771534be8dfa2a3bdc3876502752f518224b9298.1738228114.git.florent.tomasin@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="bmhdmohxtvk6vpli"
Content-Disposition: inline
In-Reply-To: <771534be8dfa2a3bdc3876502752f518224b9298.1738228114.git.florent.tomasin@arm.com>


--bmhdmohxtvk6vpli
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 1/5] dt-bindings: dma: Add CMA Heap bindings
MIME-Version: 1.0

Hi,

On Thu, Jan 30, 2025 at 01:08:57PM +0000, Florent Tomasin wrote:
> Introduce a CMA Heap dt-binding allowing custom
> CMA heap registrations.
>=20
> * Note to the reviewers:
> The patch was used for the development of the protected mode
> feature in Panthor CSF kernel driver and is not initially thought
> to land in the Linux kernel. It is mostly relevant if someone
> wants to reproduce the environment of testing. Please, raise
> interest if you think the patch has value in the Linux kernel.
>=20
> Signed-off-by: Florent Tomasin <florent.tomasin@arm.com>
> ---
>  .../devicetree/bindings/dma/linux,cma.yml     | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/linux,cma.yml
>=20
> diff --git a/Documentation/devicetree/bindings/dma/linux,cma.yml b/Docume=
ntation/devicetree/bindings/dma/linux,cma.yml
> new file mode 100644
> index 000000000000..c532e016bbe5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/linux,cma.yml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/linux-cma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Custom Linux CMA heap
> +
> +description:
> +  The custom Linux CMA heap device tree node allows registering
> +  of multiple CMA heaps.
> +
> +  The CMA heap name will match the node name of the "memory-region".
> +
> +properties:
> +  compatible:
> +    enum:
> +      - linux,cma
> +
> +  memory-region:
> +    maxItems: 1
> +    description: |
> +      Phandle to the reserved memory node associated with the CMA Heap.
> +      The reserved memory node must follow this binding convention:
> +       - Documentation/devicetree/bindings/reserved-memory/reserved-memo=
ry.txt
> +
> +examples:
> +  - |
> +    reserved-memory {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +
> +      custom_cma_heap: custom-cma-heap {
> +        compatible =3D "shared-dma-pool";
> +        reg =3D <0x0 0x90600000 0x0 0x1000000>;
> +        reusable;
> +      };
> +    };
> +
> +    device_cma_heap: device-cma-heap {
> +      compatible =3D "linux,cma";
> +      memory-region =3D <&custom_cma_heap>;
> +    };

Isn't it redundant with the linux,cma-default shared-dma-pool property
already?

Maxime

--bmhdmohxtvk6vpli
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ5t+lgAKCRAnX84Zoj2+
donhAX9x/cTFDmyFuCnkSVtxn7cvuf3F9KhUXKz36q10FjqdD7EC8VQn3wUym/Z7
8wtTJXcBfiiGdCFDdeUNdXAechjJXITJhWsytboK18cCIe6R1dyzOx/J+Wvt4WIW
SACe2NmJ9Q==
=VxzG
-----END PGP SIGNATURE-----

--bmhdmohxtvk6vpli--

