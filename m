Return-Path: <dmaengine+bounces-11729-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kKAzFYVlOWpkrgcAu9opvQ
	(envelope-from <dmaengine+bounces-11729-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 18:40:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DF66B130C
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 18:40:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cNvqn2cN;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11729-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11729-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7517301A39C
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E7F33122A;
	Mon, 22 Jun 2026 16:40:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0A232ED5C;
	Mon, 22 Jun 2026 16:40:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146415; cv=none; b=O2ETiQrRFyUdDvEC/XzPFYBGWghRkFkAO9xPdnak48Z0127bqlzpYdks+ZTraVbwQZRyb/86WfhQt2jNkTaXAOfshsZ/JQtFRA7BcMOHkEGghjNxp7bYg7/3BzCrezFbAk1VkCCv084gFthkVE6bIR/kyB4UwS/Ds1lu2V9Pzsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146415; c=relaxed/simple;
	bh=MY/8mbWFHP+8yXJF48rWBM8I7VF6Z27gjQ3kJeAP/h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcAEc3KsXqPpvOzV92tzVtG+vpeAjmLfEUyBEwpl/GQtCN1Xa8swh8uExrj4vqsFUhPSGytEsjoBfATJuRLBmtsU3Vm3xSjoxoQk/VpA4t4iOQYT3ljwJVTUsXuA2YfIkFSvMlgH42mAB4HNPBnMZBJJBfZvS5nAfAuyISl3lYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNvqn2cN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F231F000E9;
	Mon, 22 Jun 2026 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782146413;
	bh=bvrGjOsOyYiO8Clk6NrgCA8nDYfTVLwfisZMYZVp4a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cNvqn2cN1OGqKHwHNgAnP5XbvIsvUZFjCA0iQ4+0TcsYHMsLI4FNAmWppNU0sBYqf
	 saSzjwPKiD5FuKEE8lcpfl/YMkifbITpzJRMvxRb+l5CIZetZwOJTuWeYmSYUuRGJu
	 kk594NMS1QVUIdeX49LZjn+a9zsU2MoxZDvckfRNlVOKIQjWXsS16eh+Oe5kGcJ3ym
	 7bAtcs1nDJdRm0WvyFifrABX33YK/YykmKE8jpRFmR2Lxnrp1PO0oWvKKL9jeR2UZl
	 mIAEV2RUvbC9eczCBrAn+/Ia/8zLtixbl7cbO//4KaK5/uhTpn8yy+yVkdbwAQL9CB
	 H7QgB0fylZ6wg==
Date: Mon, 22 Jun 2026 17:40:10 +0100
From: Conor Dooley <conor@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Yuanshen Cao <alex.caoys@gmail.com>, linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org,
	robh@kernel.org, dmaengine@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: dma: sun50i-a64-dma: Add
 allwinner,sun60i-a733-dma compatible string
Message-ID: <20260622-sloppily-macaw-6f45bcd465c0@spud>
References: <20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com>
 <20260621-sun60i-a733-dma-v2-4-340f205891cc@gmail.com>
 <20260621215235.13FF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WW65d7u0/5myjBch"
Content-Disposition: inline
In-Reply-To: <20260621215235.13FF01F000E9@smtp.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-11729-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:alex.caoys@gmail.com,m:linux-sunxi@lists.linux.dev,m:devicetree@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:robh@kernel.org,m:dmaengine@vger.kernel.org,m:conor+dt@kernel.org,m:alexcaoys@gmail.com,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0DF66B130C


--WW65d7u0/5myjBch
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2026 at 09:52:34PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] The IRQ handler loop skips trailing DMA channels if the total nu=
mber of physical channels is not an exact multiple of the channels per regi=
ster.
> --
>=20
> commit 1a8550cc9da2ef939f555f682f0d5ea9606e1907
> Author: Yuanshen Cao <alex.caoys@gmail.com>
>=20
> dt-bindings: dma: sun50i-a64-dma: Add allwinner,sun60i-a733-dma compatibl=
e string
>=20
> Add `allwinner,sun60i-a733-dma` to the list of compatible strings for the
> `sun50i-a64-dma` dtbinding documentation.
>=20
> >     While the A733 DMA controller shares many similarities with the sun=
50i-a64
> >     DMA controller, it requires a specific configuration due to differe=
nces in:
> >     - Interrupt register layout and mapping.
> >     - Number of channels per interrupt register.
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but could this truncating
> integer division skip trailing DMA channels if the total number of physic=
al
> channels is not an exact multiple of the channels per register?

What has this got to do with the binding?

>=20
> In drivers/dma/sun6i-dma.c:sun6i_dma_interrupt(), the loop condition
> determines which interrupt registers to poll:
>=20
>     for (i =3D 0; i < sdev->num_pchans / sdev->cfg->num_channels_per_reg;=
 i++) {
>=20
> For a controller with 12 physical channels (e.g., sun8i_h3_dma_cfg sets
> nr_max_channels =3D 12) and 8 channels per register, 12 / 8 evaluates to =
1.
>=20
> Consequently, the loop only iterates once (for i=3D0), checking interrupts
> for the first 8 channels and completely ignoring the remaining 4 channels.
> Any DMA transfers on channels 8-11 will never have their completion
> interrupts handled, leading to system hangs or driver timeouts.
>=20
> Could this be updated to use DIV_ROUND_UP() to ensure all applicable
> interrupt registers are processed?
>=20
> >     - Support for higher (32G) address widths in LLI parameters.
> >    =20
> >     Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260621-sun60i-a733=
-dma-v2-0-340f205891cc@gmail.com?part=3D4

--WW65d7u0/5myjBch
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajllagAKCRB4tDGHoIJi
0s5UAP9S1slw41rYwFBisf7bL7QUmOBKaElvp2GJ/DahUbQYVQD8CMfMpVRjCikN
ViWBxm1pLtH925QwNMOycGoJD+dfngg=
=FlOT
-----END PGP SIGNATURE-----

--WW65d7u0/5myjBch--

