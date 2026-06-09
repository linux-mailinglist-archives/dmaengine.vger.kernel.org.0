Return-Path: <dmaengine+bounces-11380-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yysWEK+dKGpeGwMAu9opvQ
	(envelope-from <dmaengine+bounces-11380-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 01:11:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D660E664BCC
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 01:11:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OQLqyvEX;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11380-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11380-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64A83303CD2E
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 23:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C313F076C;
	Tue,  9 Jun 2026 23:11:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD95301708;
	Tue,  9 Jun 2026 23:11:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046686; cv=none; b=osW2KXCi9X1t9Yoyo2MsjLyoHuF8j8tjGsByZQSzZz0xm2rZAXn4MDTYmHQyJoPgY7Uqxalw+HtTfRlgxLftFfe8XqcJ4fQf7nqmKqxUqoGQ/DC8rlP+NidDg/CDhC90BEpm2CeK3E2lvq8Ke2pOF+kY57sjNFovDyLYx5yFxoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046686; c=relaxed/simple;
	bh=cIUrQfjWhexxtEG3nThdTBHEdFiN5tzrGQ/NU86nAuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzWalfGQutj+tWeYWLrP8XLiiEXUGsecijxyaiIOsa2miYf3DPPXfEYHigcHgMvz1IU9Vovec83ojw45RVwS5EOD2tk/ABszpd2SCLL9jK3g4nZ8hpkyuvStWeo3qiAUxZTZuEs6GDOxzYImgosrXJDTAQGlZ7p43YvjpGCGiUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQLqyvEX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D908C1F00893;
	Tue,  9 Jun 2026 23:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781046684;
	bh=RTQ7Dfa+YIedQNlrk2pBh0acv1cJxf0hqLHt+u/Ia8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OQLqyvEXsQZCwc5mO4VNP1T5EDWq5EHl3fArZI4AsaiVQjoGwHMLSdaYH3feXYArf
	 fA6x7Iqa5b1Vdz7luA+0gDRuJ1XmAEUkt/r7ywxYQMlscO7jIp85Mn7Bt/a3Vkib/K
	 XHkJTs3ngEVXcvWR3YkCRbm7FYaE6fnBJbU/D1fQUNY1YbBiR8reElwFHflN+o5FMC
	 2kGiJh2HfnxFpucnbb1auSIIVjs9G8jtku5/p/NM7tHSgcKrFaYMvunEtSYvxtPMY4
	 VlIIKbCjTFTIquDLJGrYzR9sMbZaVxpIwo4E11M6Qj9dFtBTdmz5wZnGVN4e4fMzNB
	 U3k49y4B9I9PA==
Date: Wed, 10 Jun 2026 00:11:19 +0100
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
Subject: Re: [PATCH v2 1/2] dt-bindings: dmaengine: Add SpacemiT K1 PDMA
 request numbers
Message-ID: <20260610-atrophy-gullible-938789978f76@spud>
References: <20260609-b4-k1-pdma-req-macros-v2-0-5d5d7b997b54@gmail.com>
 <20260609-b4-k1-pdma-req-macros-v2-1-5d5d7b997b54@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mDjp111cseA+tWiA"
Content-Disposition: inline
In-Reply-To: <20260609-b4-k1-pdma-req-macros-v2-1-5d5d7b997b54@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:docular.xu@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:dlan@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:docularxu@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11380-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D660E664BCC


--mDjp111cseA+tWiA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 03:46:38PM -0400, Guodong Xu wrote:
> Add a dt-bindings header that gives symbolic names to the SpacemiT K1
> PDMA request lines of the non-secure peripherals. Device trees can use
> these K1_PDMA_* macros instead of magic numbers.
>=20
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>
> ---
> V2: Drop the #dma-cells description change in spacemit,k1-pdma.yaml; the
>     request numbers are hardware-fixed and unused by the driver.

Worth noting that while this wasn't the change I wanted, I didn't
express myself clearly and Guodong is going to send a v3 after I
clarified:
https://lore.kernel.org/all/6ycdvhpgygnelzp3ot63xtzcnlvac7emngvj7tviiclst4a=
7km@kjq7oqvecnxx/

ta,
Conor.

> ---
>  include/dt-bindings/dma/spacemit,k1-pdma.h | 56 ++++++++++++++++++++++++=
++++++
>  1 file changed, 56 insertions(+)
>=20
> diff --git a/include/dt-bindings/dma/spacemit,k1-pdma.h b/include/dt-bind=
ings/dma/spacemit,k1-pdma.h
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

--mDjp111cseA+tWiA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiidlwAKCRB4tDGHoIJi
0gqdAQDHkJNkld9XKOrvHNTBvPSzUlW9HGCxoEAZz+aOul9PggD/ZoDUW2fCKmZW
bBkaF7fEvO7Fd+9eaehZv6GsOP6twgU=
=vNgE
-----END PGP SIGNATURE-----

--mDjp111cseA+tWiA--

