Return-Path: <dmaengine+bounces-2847-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D4694F2BD
	for <lists+dmaengine@lfdr.de>; Mon, 12 Aug 2024 18:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41102804D9
	for <lists+dmaengine@lfdr.de>; Mon, 12 Aug 2024 16:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E53F187872;
	Mon, 12 Aug 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0pj/Hrl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE4187868;
	Mon, 12 Aug 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478981; cv=none; b=gQj/pf/QmMTyvobkWCgWue7mPUe/gP5S9x3ToJmV9XOnUqVxEK47UkndypAHZyxMJZgHYVIBbRuBiwMmsWGu2xpAHoWthP4Ni5jjKJsclQI3KCYKepcTaJ0m2hcXAU/jBrXKessujK8umigkvwOeBVSxCEe+aGJ89j0AEEOWutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478981; c=relaxed/simple;
	bh=3Svd3WfttCoDPIdU5P1nIEjvO5M5AcTlMkgRnjhK89g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWPSF9dNLJ9Tk55szxVFAEom6cu/a2kluVVTxdUWeooPsmdoR/LiYRpcrE/y3VaTDdLB2pHxvM1d0B+H56Bvw8athvFx7ZJ8aPa4XdOgjSkQtRSiq+8SkwDUIpuFDeWeMRQZRpBup7ouOUcRWa07KnMsPIHe6Sb4EC5UVuTeuak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0pj/Hrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8947FC32782;
	Mon, 12 Aug 2024 16:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723478981;
	bh=3Svd3WfttCoDPIdU5P1nIEjvO5M5AcTlMkgRnjhK89g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0pj/HrlrJovaqTOHnuSxB8GPDImP+gwkOG9tRCjeNlMyv7A3A6uiNpGVX1RuKPQF
	 KaxKa9qMn5vXADHf4fC7KwHBs7zWwICe6r39ewgfkhReNeR9fUSRnPPUcr8gHshRcD
	 Cos8rQOVd0lEvT0enV6Pr3Bcyiy6W2EPS7CwWmncZcAyV10OZXzHIyHfGIi8QzOm+X
	 weT80dz6jwYcTuw5SnwbmRit9P7dkufxmR418fa9rHSfo2Uh52eRhKHgy2Hq+/x0i/
	 pS7+HDZ33H7PNdhq34Xm0yDvVz/j80qDYvOV0r2Je8jVfSbeoyAoY73KJK2pmqfgzJ
	 wlxcHCpxcpdqA==
Date: Mon, 12 Aug 2024 17:09:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 1/3] dt-bindings: dmaengine: Add dma multiplexer for
 CV18XX/SG200X series SoC
Message-ID: <20240812-herbicide-altitude-93ea45b7c79d@spud>
References: <IA1PR20MB495324F3EF7517562CB4CACFBB842@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953C5A099A0F99FA12B98F1BB842@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t1SEqS2W3FwKupq5"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953C5A099A0F99FA12B98F1BB842@IA1PR20MB4953.namprd20.prod.outlook.com>


--t1SEqS2W3FwKupq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 01:16:37PM +0800, Inochi Amaoto wrote:
> The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
> an additional channel remap register located in the top system control
> area. The DMA channel is exclusive to each core.
>=20
> In addition, the DMA multiplexer is a subdevice of system controller,
> so this binding only contains necessary properties for the multiplexer
> itself.
>=20
> Add the dmamux binding for CV18XX/SG200X series SoC.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--t1SEqS2W3FwKupq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrozwAAKCRB4tDGHoIJi
0isCAPwKylWrtHOQHoGnqGn92rLYykjnmDlsYxP3Yxl2EFSwhgEAjjTpA+CzP0xU
wq7RdzhPndaEZkg6RVLpxtxiq8bDrgQ=
=LzEz
-----END PGP SIGNATURE-----

--t1SEqS2W3FwKupq5--

