Return-Path: <dmaengine+bounces-3792-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A05889D8C37
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 19:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440A4168A58
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 18:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC41B87ED;
	Mon, 25 Nov 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEC/Q0dG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F91B3943;
	Mon, 25 Nov 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559385; cv=none; b=cMur7CtcI2RK1pC30MbQL3knWbh2+9Q2rbEegJp6NiunXW1FSVwLl03vEF6L8ih5QeTYkjVleafgmNm5Vwdx1pyi9YEJlZwAhdyOg309g1jNk1e/5H3PqB2833mgSAzWd2qNrGVbL1XEycJTxZos/ag0Nr8mo3w8rS9BKNL9Ob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559385; c=relaxed/simple;
	bh=vU5QgSKROjsSIusJm2RkljCDXeSsUUbnT0gUOPAZnIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELaK7FcicIjKTe66qBrAxNG8RsxWg2SUsFnOdC24j7d8cJInoeWCzXPx2Gj92TpQZNc6QASkvyTRotLxjfYnfHh2lvTllz1EW6V9Xj8wmawwV6tBSsIooOjx46XRySIS9aoQVfVR84yWhjg6dYPEFqZlzizPDKrPv/zZcMtLnAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEC/Q0dG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6A1C4CECE;
	Mon, 25 Nov 2024 18:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732559385;
	bh=vU5QgSKROjsSIusJm2RkljCDXeSsUUbnT0gUOPAZnIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEC/Q0dGXWC9D5cg2KiqUxytDze1vYmohD8cwfPplRB5JBFbGQTRkrdZEFj+ib8rj
	 LT3Z5CzNmoQC2NiUQERzVedpOvdYHoVNZH3UrbHKJaBvzMLaVf4x6nGTDT81jLHv49
	 FzAlpXhxb41XfURN4ob1sb71HKdsVlTvOv/IsXoVeU/qlkrRm34G/PdX5q4sQLBs/k
	 J3ICnQeGhLrF8nrD7tD3Yd+xeupyIAa6WWadJi3bmK6I2pXWz3H04rRbCF5vynIyPh
	 9DqWpLg7rKdxuqB2v94SuM8ZmH/UEYjDtkIfslnWxZ0Ec/WkOzECc7Bic7TKRMRxhE
	 eXR2uHcuRG55Q==
Date: Mon, 25 Nov 2024 18:29:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Vaishnav Achath <vaishnav.a@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	u-kumar1@ti.com, j-choudhary@ti.com, vigneshr@ti.com
Subject: Re: [PATCH 1/2] dt-bindings: dma: ti: k3-bcdma: Add TX channel for
 AM62A CSIRX BCDMA
Message-ID: <20241125-entwine-goes-8cabcb6af19f@spud>
References: <20241125083914.2934815-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W+erTNXz00zr18Bm"
Content-Disposition: inline
In-Reply-To: <20241125083914.2934815-1-vaishnav.a@ti.com>


--W+erTNXz00zr18Bm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 02:09:13PM +0530, Vaishnav Achath wrote:
> J722S CSIRX BCDMA is based on AM62A BCDMA and supports CSI TX channels

There's no specific compatible in this file for a j722s, you should add
one.

> in addition to currently supported RX channels. Add TX channel
> properties as optional properties in the list so that the same
> compatible can be reused. K3 UDMA makes use of TCHAN_CNT
> capabilities register to identify whether platform supports
> TX channels.
>=20
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
>  Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Doc=
umentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> index 27b8e1636560..c748f78b313e 100644
> --- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> @@ -138,19 +138,22 @@ allOf:
>      then:
>        properties:
>          ti,sci-rm-range-bchan: false
> -        ti,sci-rm-range-tchan: false
> =20
>          reg:
> +          minItems: 3

You need to then constrain maxItems to 3 for all !j722s devices in an
if/then/else to avoid allowing 4 reg entries where it is not valid.

Thanks,
Conor.

>            items:
>              - description: BCDMA Control /Status Registers region
>              - description: RX Channel Realtime Registers region
>              - description: Ring Realtime Registers region
> +            - description: TX Channel Realtime Registers region
> =20
>          reg-names:
> +          minItems: 3
>            items:
>              - const: gcfg
>              - const: rchanrt
>              - const: ringrt
> +            - const: tchanrt
> =20
>        required:
>          - power-domains
> --=20
> 2.34.1
>=20

--W+erTNXz00zr18Bm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0TCFAAKCRB4tDGHoIJi
0sNHAP4gMM58Qcm1zoCOPMM0CqCfv6Jno8rjO9eXhwXNeDbrZQEA1SGdpfSqFDMT
WpcQwIKGt66BMkWnjtje8/+73CqpOgs=
=7xcm
-----END PGP SIGNATURE-----

--W+erTNXz00zr18Bm--

