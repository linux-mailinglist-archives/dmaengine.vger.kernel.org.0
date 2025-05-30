Return-Path: <dmaengine+bounces-5287-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E44AC9280
	for <lists+dmaengine@lfdr.de>; Fri, 30 May 2025 17:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146DB1C07E73
	for <lists+dmaengine@lfdr.de>; Fri, 30 May 2025 15:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07B5235042;
	Fri, 30 May 2025 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lx1wEBIO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4ED22D9E5;
	Fri, 30 May 2025 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748618698; cv=none; b=Z4RHaIDgDMlx5KC07wrt9qmu58lbYsLJ+ung4XWu/QPlFFUNiNDI7YTlgLolftodJqHL8BbY+VxSAhdXgkSN3HM/0gThQFNssYnwYg/TX661802JwypBKnsKTzNEYrK6fC4PNQHaiD8y1gq7iGWOnNhVgK69UsUC3Zc5zZXjgxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748618698; c=relaxed/simple;
	bh=xIG3Sui9OiCFTTQa85qTNyKEQhSn2TC454W39iD5xaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9oQ3MICvjbi99ztQ6d0CfrSiAasEkw0kJymYpXLXkfcsQ4Ry04Ey2FF6ef7H+/2tahWD/2BIZdnaViPUtrie1OcyFiMXjSCdRJdvbYWkuhYd9/+4JStZg59oUuaFUKjq5ZnZxCchcl44nVhhoz5SLzkY1qfE12C59aWBSaN+0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lx1wEBIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A933C4CEE9;
	Fri, 30 May 2025 15:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748618697;
	bh=xIG3Sui9OiCFTTQa85qTNyKEQhSn2TC454W39iD5xaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lx1wEBIOAO63u8ZhQUuPgC/vyo7g9uGJ185gwTnofX4yt8gS1kQ0dD2Hs55EVw6Js
	 6rMXqUT7xEXk32NpYu9bDFTOztCkfkq95GNiFvfPE3XL0eI8ZoMebv3T/vQZ1wlxcA
	 M9xoeOVk/a4fvAtUyPtfCx/XGclH6hNLTDQteCaMEWjSL78OhFUUNE4DZzqBGpCtwu
	 wvOP/opjCXJ9otQwldSPYgrlgnpnVPYLHagBjqkF7/FX2gSA2PaX+2coNEHIocN+5t
	 xUhqjinEP68tg6DqstERqqk5Q0DqgPpd0sQjATvv4W2vEQsY/QyGwzEWChc79yWWvf
	 rfG7gBj60pqlg==
Date: Fri, 30 May 2025 16:24:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
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
Subject: Re: [PATCH 1/1] dt-bindings: dma: fsl-mxs-dma: allow interrupt-names
 for fsl,imx23-dma-apbx
Message-ID: <20250530-those-frequency-f8106275769f@spud>
References: <20250523213252.582366-1-Frank.Li@nxp.com>
 <20250526-plural-nifty-b43938d9f180@spud>
 <aDcw0sgN1ZX0kCCZ@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Aj1tJsIztP5dXenP"
Content-Disposition: inline
In-Reply-To: <aDcw0sgN1ZX0kCCZ@lizhi-Precision-Tower-5810>


--Aj1tJsIztP5dXenP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 11:50:42AM -0400, Frank Li wrote:
> On Mon, May 26, 2025 at 04:28:07PM +0100, Conor Dooley wrote:
> > On Fri, May 23, 2025 at 05:32:52PM -0400, Frank Li wrote:
> > > Allow interrupt-names for fsl,imx23-dma-apbx and keep the same restri=
ction
> > > for others.
> >
> > The content of the patch seems okay, but why are you doing this? What is
> > the value on this particular platform but not the others?
>=20
> Actually it is not used in dma driver, i.MX23 is quite old chips (over 10=
year).

If they provide no value, why not just delete them?

> Just to match existed dts to reduce warnings.

You should mention this in your commit message.

--Aj1tJsIztP5dXenP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDnNwwAKCRB4tDGHoIJi
0plVAP9xUhFgW9G3H70h10nX3DElaVl3XrEFf30bWGpPQbwUvQEAyjrFGC6Voo7o
aa/qdRMjImiKKvS4eMDSOBxpXBeWAA8=
=RMOT
-----END PGP SIGNATURE-----

--Aj1tJsIztP5dXenP--

