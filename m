Return-Path: <dmaengine+bounces-6610-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9614BB81D01
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 22:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E44C1C22AB2
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 20:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EFD23AE9A;
	Wed, 17 Sep 2025 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAI/VxTo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A519478;
	Wed, 17 Sep 2025 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141982; cv=none; b=XUSraW7DTlOJ0Z69vBkunXj3Ogym+Obcmei/AhGVjPjBqWGUisNONgBh0u659zV2gMCEvXEmIq9ccYlaWRYmgFK3ZY5wKvqKSaqJx1ehCyBezLDW7JyObxXX/ZYesx+amURREaQ/hvM4kDmQTaad1cKu7uGIP2wiUzrZ7zyyAck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141982; c=relaxed/simple;
	bh=Q7tEg7j6RoeNTPDbkPDwYQZ4S4HAyyfHpt8dOtQ51LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLwZRMvhvAbhBIJxXDGzwARss65GNZy8ecdYhxNPaYP3na8M+yXKfbtJp/zJKLKrdQkLhoMB28htG0GJtRW+io73Bcp0hWbwDMdwC8iy9J2KadnidO8tkg3VMTrUllGz/CwcOsRQO7w8vD/lo2RZsKPCnLJMZ2BMUC0jTiRllvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAI/VxTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD8CC4CEE7;
	Wed, 17 Sep 2025 20:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758141981;
	bh=Q7tEg7j6RoeNTPDbkPDwYQZ4S4HAyyfHpt8dOtQ51LY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAI/VxToUrsecvVHKVmqk9VbhbcxWqYiBnlN2OtEyK8rG+sf/HpexHmcMevAnavzW
	 bOhKM+dSfNmxXNNrzqi95s1GO5vs0U0soS6PDR+/gFoiosXTTZpt5W0/ebQNHvzuCv
	 +dh+HXKJyB3ADR6IW1ONBsIL/0PM2IyFsUz1u2vQ1Mbk27nVOvksvXRbzIlW1ObpOx
	 9xEs9JUnMfwZI4NjujxGuxxMdeGipn8RdHCkcx5ire3+Rfug/1WWWaDVEwLaonXJXw
	 tEpK3I+ButqFA2LNfe3shW80zhphJHKrUtBYuz9lpGouIKIrbwlcpJJT5ZPDTowq/8
	 IA8hGzyCMY41w==
Date: Wed, 17 Sep 2025 21:46:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Dang Huynh <dang.huynh@mainlining.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 05/25] dt-bindings: rtc: Add RDA Micro RDA8810PL RTC
Message-ID: <20250917-contort-sassy-df07fd7515a0@spud>
References: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
 <20250917-rda8810pl-drivers-v1-5-74866def1fe3@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O1or/w1/nkDw62h6"
Content-Disposition: inline
In-Reply-To: <20250917-rda8810pl-drivers-v1-5-74866def1fe3@mainlining.org>


--O1or/w1/nkDw62h6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 03:07:22AM +0700, Dang Huynh wrote:
> Add documentation describing the RTC found in RDA8810PL SoC.
>=20
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---
>  .../devicetree/bindings/rtc/rda,8810pl-rtc.yaml    | 30 ++++++++++++++++=
++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml b/=
Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..3ceae294921cc3211cd775d9b=
3890393196faf82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/rda,8810pl-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RDA Micro RDA8810PL Real Time Clock
> +
> +maintainers:
> +  - Dang Huynh <dang.huynh@mainlining.org>
> +
> +properties:
> +  compatible:
> +    const: rda,8810pl-rtc
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

Your driver implements functions that turn on an alarm irq, but there is
none mentioned here. What's going on there?

Additionally, there's no clocks property? For an onboard RTC I'd have
expected there to be a clock sourced outside of the block.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rtc@1a06000 {
> +      compatible =3D "rda,8810pl-rtc";
> +      reg =3D <0x1a06000 0x1000>;
> +    };
>=20
> --=20
> 2.51.0

--O1or/w1/nkDw62h6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMseFgAKCRB4tDGHoIJi
0sWyAP9Pj+b7KS94r+iyIUxvze3+ElD0xbnurxdnvk1gDdsMmAEAv1EDMSlyOted
5VPH3fsR8ktajxFUxMY4tUTjDq9tcQM=
=h7MI
-----END PGP SIGNATURE-----

--O1or/w1/nkDw62h6--

