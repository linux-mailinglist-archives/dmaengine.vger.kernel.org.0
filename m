Return-Path: <dmaengine+bounces-6609-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD303B81CEF
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 22:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29F777BAF16
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 20:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDE02F0C61;
	Wed, 17 Sep 2025 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYVjwLHH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156C8BEE;
	Wed, 17 Sep 2025 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141614; cv=none; b=Azr2TGnuNbQMIea0gSijc4LD2Ar5K3B5PP98yxb2dQG2nsXn90nNLcNL6WuipqJ/+y8w36xajV7vqosXapvE1KXOHXa8bC0Qd7WSufP5Icy7f1GvPdO6bZlk8fPIpr9lLOnZnOpLqMWAj/ftLQqsbfdAYrXD2Re9dOmnP1Quc40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141614; c=relaxed/simple;
	bh=oWRF0e+JL1I2wWRpFWpkjtN2+s+6zaJH3zvzmrp0RGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQGPkDYQrUNMRmI6SuZHDbt5t5sdA5QoL0vO/YRBmojadg8XqURn4fY98au++hSphqoqQZgrb3wYzvvkhTH8up5goNyWffVo7Sl1BvaONd57Mt4ZSyXkGrWUbJym007/drEIJwhAu+o+o/4C8RM5Ee8qx54Q1yPDOlTZXp2x/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYVjwLHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA3BC4CEE7;
	Wed, 17 Sep 2025 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758141613;
	bh=oWRF0e+JL1I2wWRpFWpkjtN2+s+6zaJH3zvzmrp0RGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tYVjwLHHA/7Yhkh2KRc8XzIxzcxuNa8oalYYl6JthoyVK/yU844EsWgorjBU/tHzq
	 Dp3lcKUMJVC4tYDPeJmNLaVEfLZlY+BULrfCYq4HB934D8gfnnpmG9b8hjJCQSorxR
	 8lh3njPOHoKVcAs7Fflntx8gVgzYftF9Q1PQP4dcx8NAHs7GraVvSmD0q+CTO2a4gP
	 YpP60W30bQj6wPvI3n8pK5MorPMhf3LNPhe58LwyfDl+6NtHKPuMLA2g8gH+5orgnD
	 5exL6jNlX4bpNA864glMyxUuLmJf7Yv7pAzorrPVMk3buq24tL2PAFP0eDKjOMhxJ+
	 09kXbsw/EALWA==
Date: Wed, 17 Sep 2025 21:40:06 +0100
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
Subject: Re: [PATCH 09/25] dt-bindings: clock: Add RDA Micro RDA8810PL
 clock/reset controller
Message-ID: <20250917-lividly-bargraph-2d3c036fe469@spud>
References: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
 <20250917-rda8810pl-drivers-v1-9-74866def1fe3@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+GCP3T4o6WO3PNuz"
Content-Disposition: inline
In-Reply-To: <20250917-rda8810pl-drivers-v1-9-74866def1fe3@mainlining.org>


--+GCP3T4o6WO3PNuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 03:07:26AM +0700, Dang Huynh wrote:
> Add documentation describing the RDA8810PL Clock and Reset
> controller.
>=20
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---
>  .../bindings/clock/rda,8810pl-apsyscon.yaml        | 44 ++++++++++++
>  include/dt-bindings/clock/rda,8810pl-apclk.h       | 79 ++++++++++++++++=
++++++
>  2 files changed, 123 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/rda,8810pl-apsyscon.=
yaml b/Documentation/devicetree/bindings/clock/rda,8810pl-apsyscon.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..988b609403a96abc4964ab366=
daa6fec0514595c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rda,8810pl-apsyscon.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rda,8810pl-apsyscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RDA Micro RDA8810PL AP Clock Controller
> +
> +maintainers:
> +  - Dang Huynh <dang.huynh@mainlining.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: rda,8810pl-apsyscon
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rda,8810pl-apclk.h>
> +
> +    ap_syscon: syscon@0 {

Drop the ap_syscon label, since it is unused.

> +      compatible =3D "rda,8810pl-apsyscon", "syscon";
> +      reg =3D <0x0 0x1000>;
> +      #clock-cells =3D <1>;
> +      #reset-cells =3D <1>;
> +    };
> diff --git a/include/dt-bindings/clock/rda,8810pl-apclk.h b/include/dt-bi=
ndings/clock/rda,8810pl-apclk.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..372358e72436a28c0775519f4=
9626c9c5f4c6046
> --- /dev/null
> +++ b/include/dt-bindings/clock/rda,8810pl-apclk.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
> +
> +#ifndef _DT_BINDINGS_CLK_RDA8810_H_
> +#define _DT_BINDINGS_CLK_RDA8810_H_
> +
> +/* soc clocks */
> +#define CLK_CPU 0
> +#define CLK_BUS 1
> +#define CLK_MEM 2
> +
> +#define CLK_USB 3
> +#define CLK_AXI 4
> +#define CLK_GCG 5
> +#define CLK_AHB1 6
> +#define CLK_APB1 7
> +#define CLK_APB2 8
> +
> +#define CLK_GPU 9
> +#define CLK_VPU 10
> +#define CLK_VOC 11
> +#define CLK_SFLSH 12
> +
> +#define CLK_UART1 13
> +#define CLK_UART2 14
> +#define CLK_UART3 15
> +
> +#define CLK_VOC2 16
> +#define CLK_EMMC 17
> +

> +#define CLK_COUNT (CLK_EMMC + 1)

This is not permitted, if you need this define please add it to
the driver directly.

> +
> +/* resets */
> +#define RST_CPU 0
> +
> +#define RST_AXI_VOC 1
> +#define RST_AXI_DMA 2
> +#define RST_AXI_CONNECT 3
> +#define RST_AXI_VPU 4
> +
> +#define RST_GCG_GOUDA 5
> +#define RST_GCG_CAMERA 6
> +#define RST_GCG_LCDC 7
> +
> +#define RST_AHB1_USBC 8
> +#define RST_AHB1_SPIFLASH 9
> +
> +#define RST_APB1_TIMER 10
> +#define RST_APB1_KEYPAD 11
> +#define RST_APB1_GPIO 12
> +#define RST_APB1_PWM 13
> +#define RST_APB1_AIF 14
> +#define RST_APB1_AUIFC 15
> +#define RST_APB1_I2C1 16
> +#define RST_APB1_I2C2 17
> +#define RST_APB1_I2C3 18
> +#define RST_APB1_COMREGS 19
> +#define RST_APB1_DMC 20
> +#define RST_APB1_DDRPHY_P 21
> +
> +#define RST_APB2_IFC 22
> +#define RST_APB2_UART1 23
> +#define RST_APB2_UART2 24
> +#define RST_APB2_UART3 25
> +#define RST_APB2_SPI1 26
> +#define RST_APB2_SPI2 27
> +#define RST_APB2_SPI3 28
> +#define RST_APB2_SDMMC1 29
> +#define RST_APB2_SDMMC2 30
> +#define RST_APB2_SDMMC3 31
> +#define RST_APB2_NAND 32
> +
> +#define RST_MEM_GPU 33
> +#define RST_MEM_VPU 34
> +#define RST_MEM_DMC 35
> +#define RST_MEM_DDRPHY_P 36
> +

> +#define RST_COUNT (RST_MEM_DDRPHY_P + 1)

Ditto here.

--+GCP3T4o6WO3PNuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMscpgAKCRB4tDGHoIJi
0ps/AP4piHliUCDvEEUik0FH/7MzvmR63WJQrrnsPFPC3yOkfQD/Qx91k9Cbmdnw
BKNMCt5IYsh65uJuh73HEVehqhuQzgA=
=v+w9
-----END PGP SIGNATURE-----

--+GCP3T4o6WO3PNuz--

