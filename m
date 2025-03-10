Return-Path: <dmaengine+bounces-4678-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C36BA59B9B
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 17:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0870B3A87CC
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 16:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98696238149;
	Mon, 10 Mar 2025 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4+/EqRW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68980230BD5;
	Mon, 10 Mar 2025 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625367; cv=none; b=ihAsLN7lw0Mm19x4TkbeAOPyjwekF605Pz4DvG3ErYhm1MUUQ2lbfQTwiI5qWm1t724mlrgEx6qYmXXKkqjgygTcDJR7VLrBRkJdX9Q+i62YVE1/MjVufSp20NWC71uJ6ADpeZVrxdxoA72czL1gokM9bdCN/3O/fny4OdlMjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625367; c=relaxed/simple;
	bh=XUiWyHwI4Vxt1OJNKKDv1Etb8h9Z/vi/oeIFxbkHNkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eav+YBqS6aI576q8bTBNW7kQy6x+EbIFtsODSkMR7SnPUo+Jxn0pujoQQZq4/JYYsem2wVVgXlBk6iAGXKwq0LILDM8sdwloe5eWasFDmTZsv3NInM6cuMfjn2jbPnzsmP7WxaR3IWfLewgVKbM39IsA5i715suAEozALtCFuRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4+/EqRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEF5C4CEE5;
	Mon, 10 Mar 2025 16:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741625366;
	bh=XUiWyHwI4Vxt1OJNKKDv1Etb8h9Z/vi/oeIFxbkHNkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4+/EqRWTbjykk1EFMzcNIRqB+I32bKyVBDmEQtowE1KL82pRRCezE8mg6mZ/feqi
	 fDiHjF0GVntnfRVHVy8dR53O3+FPfaHnfilD0JNcohxr0EKiSGtkm0NvkE4Y4cVqJU
	 FtULpUP4pLHxpLoARU4ol/cAR0bPQ2bYSP4Nw0A3VHQHEtf5QPJJzSxpDm9uoRUwTI
	 Ek00FHbXRQtUHY3CQfa83KODtzrj6QIRgYxye0jizw7rR7wx/b4D9rP5cKot0HGDQp
	 A0Tfu3bxkbHZVbUi0lsnARbLm5Zsn8dg7qYzLwULHrk72rmlx4HUL4S99LnMYDMY3z
	 +uORw6VRge1sg==
Date: Mon, 10 Mar 2025 16:49:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: dma: fsl-mxs-dma: Add compatible string for
 i.MX8 chips
Message-ID: <20250310-either-ambulance-541738a32b2c@spud>
References: <20250307215100.3257649-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="larkxOhmSP7+JbNi"
Content-Disposition: inline
In-Reply-To: <20250307215100.3257649-1-Frank.Li@nxp.com>


--larkxOhmSP7+JbNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 04:50:59PM -0500, Frank Li wrote:
> Add compatible string for all i.MX8 chips, which is backward compatible
> with i.MX28. Set it to fall back to "fsl,imx28-dma-apbh".
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml b/Doc=
umentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
> index a17cf2360dd4a..75a7d9556699c 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
> @@ -31,6 +31,12 @@ properties:
>                - fsl,imx6q-dma-apbh
>                - fsl,imx6sx-dma-apbh
>                - fsl,imx7d-dma-apbh
> +              - fsl,imx8dxl-dma-apbh
> +              - fsl,imx8mm-dma-apbh
> +              - fsl,imx8mn-dma-apbh
> +              - fsl,imx8mp-dma-apbh
> +              - fsl,imx8mq-dma-apbh
> +              - fsl,imx8qm-dma-apbh
>                - fsl,imx8qxp-dma-apbh
>            - const: fsl,imx28-dma-apbh
>        - enum:
> --=20
> 2.34.1
>=20

--larkxOhmSP7+JbNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ88YEQAKCRB4tDGHoIJi
0lKZAQDr225yfRoRFlt+qxcw8GhROf/Qi13nYKV/U8XrDdEYlwD+NChVWxFGNI/W
+sC4s9WDIuQNt0zbNBIMR+pWkiX3AA4=
=+r4I
-----END PGP SIGNATURE-----

--larkxOhmSP7+JbNi--

