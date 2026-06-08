Return-Path: <dmaengine+bounces-11337-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DSYzO9cFJ2oDqQIAu9opvQ
	(envelope-from <dmaengine+bounces-11337-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 20:11:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3D5659912
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 20:11:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ndddILg1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11337-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11337-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6031D3026766
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829073290D5;
	Mon,  8 Jun 2026 17:33:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E42405EB;
	Mon,  8 Jun 2026 17:33:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940017; cv=none; b=YciuPSZPZAo4LUeXSxF22sKqnToDea8FrT+FcU+BHf0E4nF+pVQ3hb+a3gsRVAk66u2TBHK+ZjI0hgQquvcPBC4WtF0tazHatSpiEWQG55lutR1mj4WCIIyO+LkeNfG2vFd1gDBmIL8u22IROftMeFDQz9SnAbVZ+syIu6AUgQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940017; c=relaxed/simple;
	bh=RO6ggq1uRwsFrrB076tcfWBueXi0X/cyLecV3BHAk18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FW7parxvE7fliooCaBhXUPFR/of7K1OAyNacUxOMwi3AnwP7M9ECtMBE4dx8pV/pCZ8TQpUe9JJHqJbkYEDmk7twbueWFLVgBNBarQiIdHToGGrlxy7UdgFElN9zMEzoNNwXC5Ki7BUYyB7ymwKKt5o9FMfbyHtoPRAOE7p6YRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndddILg1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249D71F00893;
	Mon,  8 Jun 2026 17:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940016;
	bh=rz/kHBX65bHwP7+NFX9CSyO/YRkZEFq5Dqp/UQNjVAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ndddILg1yFOlz/auS4UTqqrDE9jWFKioka6dvQL8iY2jSS6dUNobB61dzx6qTLIm0
	 B5rb2RJNxJA40SOe8AmVi8GDOqLYuNQKwtTzOGfrj48YXrlYfjEotZqp4/1ndrIJpS
	 KlCiXY4WF/gkh03icXnLISOcNIiJ9PbpQjEvFirKw8ddaqwXhq5WsJvCqRKG+vXgR/
	 6ZE5zkek5fbsHe3vynGB1pdZitO+QUdbfGBjJtsl4uHxR4nZIT1HxxpD/oJqBGTart
	 fQRqn+oSHheZ38UK1O/iC9omWMDJLHJMjqX8+Zd8D0FFzyve/uO75SO5jcolAcuECo
	 XGC+5xT/hUvnw==
Date: Mon, 8 Jun 2026 18:33:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Guodong Xu <docular.xu@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: Add SpacemiT K1 PDMA request
 numbers
Message-ID: <20260608-dazzling-hacksaw-dbe84766ec76@spud>
References: <20260607-b4-k1-pdma-req-macros-v1-0-5b2a3955007c@gmail.com>
 <20260607-b4-k1-pdma-req-macros-v1-1-5b2a3955007c@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xjVn6sgaP8h5qJrR"
Content-Disposition: inline
In-Reply-To: <20260607-b4-k1-pdma-req-macros-v1-1-5b2a3955007c@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:docular.xu@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:dlan@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:docularxu@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11337-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,spud:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E3D5659912


--xjVn6sgaP8h5qJrR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 07, 2026 at 01:41:30PM -0400, Guodong Xu wrote:
> Add a dt-bindings header that gives symbolic names to the SpacemiT K1
> PDMA request lines of the non-secure peripherals. Device trees can use
> these K1_PDMA_* macros instead of magic numbers.
>=20
> Point the spacemit,k1-pdma binding's #dma-cells description at the new
> header.
>=20
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>
> ---
>  .../devicetree/bindings/dma/spacemit,k1-pdma.yaml  |  4 +-
>  include/dt-bindings/dma/spacemit,k1-pdma.h         | 56 ++++++++++++++++=
++++++
>  2 files changed, 59 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml =
b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
> index ec06235baf5ca..0d4ac9849e27b 100644
> --- a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
> @@ -35,7 +35,9 @@ properties:
>    '#dma-cells':
>      const: 1
>      description:
> -      The DMA request number for the peripheral device.
> +      The single cell is the DMA request number for the peripheral devic=
e.
> +      See <dt-bindings/dma/spacemit,k1-pdma.h> for the list of valid req=
uest
> +      numbers.
> =20
>  required:
>    - compatible
> diff --git a/include/dt-bindings/dma/spacemit,k1-pdma.h b/include/dt-bind=
ings/dma/spacemit,k1-pdma.h

Why does this need to be in a binding when there is no use of this in
the driver? May as well be a header, particularly if these are numbers
with a set meaning that are lifted from the TRM, rather than made up
numbers to make a driver work. The former seems likely, given you're
indexing from 3 not 0.

> new file mode 100644
> index 0000000000000..491976516550a
> --- /dev/null
> +++ b/include/dt-bindings/dma/spacemit,k1-pdma.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * This header provides DMA request number for non-secure peripherals of
> + * SpacemiT K1 PDMA.
> + *
> + * Copyright (c) 2026 Guodong Xu <docular.xu@gmail.com>
> + */
> +
> +#ifndef _DT_BINDINGS_DMA_SPACEMIT_K1_PDMA_H_
> +#define _DT_BINDINGS_DMA_SPACEMIT_K1_PDMA_H_
> +
> +#define K1_PDMA_UART0_TX	3
> +#define K1_PDMA_UART0_RX	4
> +#define K1_PDMA_UART2_TX	5
> +#define K1_PDMA_UART2_RX	6
> +#define K1_PDMA_UART3_TX	7
> +#define K1_PDMA_UART3_RX	8
> +#define K1_PDMA_UART4_TX	9
> +#define K1_PDMA_UART4_RX	10
> +#define K1_PDMA_I2C0_TX		11
> +#define K1_PDMA_I2C0_RX		12
> +#define K1_PDMA_I2C1_TX		13
> +#define K1_PDMA_I2C1_RX		14
> +#define K1_PDMA_I2C2_TX		15
> +#define K1_PDMA_I2C2_RX		16
> +#define K1_PDMA_I2C4_TX		17
> +#define K1_PDMA_I2C4_RX		18
> +#define K1_PDMA_SPI3_TX		19
> +#define K1_PDMA_SPI3_RX		20
> +#define K1_PDMA_I2S0_TX		21
> +#define K1_PDMA_I2S0_RX		22
> +#define K1_PDMA_I2S1_TX		23
> +#define K1_PDMA_I2S1_RX		24
> +#define K1_PDMA_UART5_TX	25
> +#define K1_PDMA_UART5_RX	26
> +#define K1_PDMA_UART6_TX	27
> +#define K1_PDMA_UART6_RX	28
> +#define K1_PDMA_UART7_TX	29
> +#define K1_PDMA_UART7_RX	30
> +#define K1_PDMA_UART8_TX	31
> +#define K1_PDMA_UART8_RX	32
> +#define K1_PDMA_UART9_TX	33
> +#define K1_PDMA_UART9_RX	34
> +#define K1_PDMA_I2C5_TX		35
> +#define K1_PDMA_I2C5_RX		36
> +#define K1_PDMA_I2C6_TX		37
> +#define K1_PDMA_I2C6_RX		38
> +#define K1_PDMA_I2C7_TX		39
> +#define K1_PDMA_I2C7_RX		40
> +#define K1_PDMA_I2C8_TX		41
> +#define K1_PDMA_I2C8_RX		42
> +#define K1_PDMA_CAN0_RX		43
> +#define K1_PDMA_QSPI_RX		44
> +#define K1_PDMA_QSPI_TX		45
> +
> +#endif /* _DT_BINDINGS_DMA_SPACEMIT_K1_PDMA_H_ */
>=20
> --=20
> 2.43.0
>=20

--xjVn6sgaP8h5qJrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaib86wAKCRB4tDGHoIJi
0pgsAQCNGTEM+fPWwgLkbr7pqHDECKqYqXVibCQqXRT0zsqgLQD/X2yJ0LhoUtgO
mfCnn/fGZxot4TnZziQGgygeMKvKLgs=
=XmHc
-----END PGP SIGNATURE-----

--xjVn6sgaP8h5qJrR--

