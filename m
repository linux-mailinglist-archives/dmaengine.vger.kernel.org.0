Return-Path: <dmaengine+bounces-3235-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3606298A5CF
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 15:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD08281CBE
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 13:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6375B18F2CF;
	Mon, 30 Sep 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2cyVsTN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF91EA91;
	Mon, 30 Sep 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704105; cv=none; b=SOe5HSmcxSe7USxRoOb826cZLhrFkWXmVW9RO0kFogoMFEiU4SmFayrrRaDG+FC0Sv+3jZw3GXVYgaQl9Bx+jJFTaF43tGXbWh0RzDJX5yBFf+aLJ8kxerwyecAoukdeFTJd77vjCOA5ti13lUSZ6KlnjpCtto2QU4Mgft5kHJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704105; c=relaxed/simple;
	bh=WktLtpIrIbL+8YQi45Eu421zppugfrAet1EeAKU5Yek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfubR0whLyVBKrRiQNX9hcSLd7cZx9mhJ2bASyEZQE3jzF+HgZ7+zCapNSX9PCRiGjmJwSxF/4v/abxzwdSivUES3PIAm3Psi/FamkbvRChuILw3smfA+9b+lruIzUJEwJf/S3mako5dT5uAWD4aLkDolpz1Wnyksis5ehoulAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2cyVsTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E9AC4CEC7;
	Mon, 30 Sep 2024 13:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704105;
	bh=WktLtpIrIbL+8YQi45Eu421zppugfrAet1EeAKU5Yek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2cyVsTNf4bbUUD18lBqL3KujTz48JtFWJHEqtKTtGkfCid+6N/bTN/kFdnx1cqh0
	 Ugd0tHZaz5dYUs3FB4SfqDfW5p+/pyeb2WLgSXmybF3eHyFD4joBmRKnjxOGDw9oyx
	 Zr91TvNGJRU5sU8P97Dxmk7le3N1Mkvk4ZbZrgCISBpw/ubfFfBLRaTp7lxPfwYjVw
	 ENQbIqCb2udkvnBXjMqr0cbhCMgAtAL0+++wNBcBB8z/fnjEq+UkERh841oNvJCBk/
	 kYViHx9Uz0VBs//snbktFr04trOnr0s38BJU93Yjjrg5ONhfaPqjNBKt3bbYcdQszW
	 QleBtjmL4EiwA==
Date: Mon, 30 Sep 2024 14:48:20 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Green Wan <green.wan@sifive.com>,
	Palmer Debbelt <palmer@sifive.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 09/20] dt-bindings: dma: sifive pdma: Add
 PIC64GX to compatibles
Message-ID: <20240930-mammogram-prison-d87615f0d05a@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-10-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kqrZppaxEGOPTo9H"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-10-pierre-henry.moussay@microchip.com>


--kqrZppaxEGOPTo9H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:38AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX is compatible as out of order DMA capable, just like the MPFS
> version, therefore we add it with microchip,mpfs-pdma as a fallback
>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  .../bindings/dma/sifive,fu540-c000-pdma.yaml      | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma=
=2Eyaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> index 3b22183a1a37..609e38901434 100644
> --- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> @@ -27,11 +27,16 @@ allOf:
> =20
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - microchip,mpfs-pdma
> -          - sifive,fu540-c000-pdma
> -      - const: sifive,pdma0
> +    oneOf:
> +      - items:
> +          - const: microchip,pic64gx-pdma
> +          - const: microchip,mpfs-pdma
> +          - const: sifive,pdma0
> +      - items:
> +          - enum:
> +              - microchip,mpfs-pdma
> +              - sifive,fu540-c000-pdma
> +          - const: sifive,pdma0
>      description:
>        Should be "sifive,<chip>-pdma" and "sifive,pdma<version>".
>        Supported compatible strings are -
> --=20
> 2.30.2
>=20

--kqrZppaxEGOPTo9H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvqsJAAKCRB4tDGHoIJi
0q4lAQDZPsQK4xWA8TDpp1IyybDgTSbASEUfhv0mp/GHVtbjPgEAs01gUWp4evXk
RGUyGxzDcN6h/L65uyGvteqNXGG5lwM=
=6KCM
-----END PGP SIGNATURE-----

--kqrZppaxEGOPTo9H--

