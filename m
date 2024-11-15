Return-Path: <dmaengine+bounces-3742-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FA99CF268
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 18:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95AA28B2BA
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77EB1D5170;
	Fri, 15 Nov 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Eyr50KZ1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96230136341
	for <dmaengine@vger.kernel.org>; Fri, 15 Nov 2024 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690539; cv=none; b=Ev+gwjx+YOfCJHKXCxQPPTF+HwCnYx7VfYJSIJTleUp8PYBjwGTo5nNzuP4SEPCGJYWcT+Cu/pObBTtfvfmFJNQC9PX7dwlaTAGbo+RBprCaVltnpA7a/Xiu3ZMKf65NtZdJSyX33OqmRo2evmSSs6o/VJc5gBtJ/KQGLShVad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690539; c=relaxed/simple;
	bh=gXheXom3MTvMR7dRmavCkGXyuj5o+8DezuAbzhc2XQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXbmkoXwi/IRtbDLcPrl8MLracdUSB6AMwE1UvX9cgrzCoNFSr1S63Tk10KaBAqbv9mn9e6oeVcSWqAQSh0R4ImRgQB+W4N+h6e21WemujZPzO2evVSiSSyGEbkQi8BPlgMUYiNZyhYuc/ozoTKSa6obqD8Jb4y+og3shJW7tUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Eyr50KZ1; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=fs0U
	diqmqoDl0sN2GiNwSsP7adCI+uMwSrUXF0IDfzs=; b=Eyr50KZ1P6dzmj5eebaV
	Yl/EJbYP38WxEUQeA74gpAiE/AA55vyqI1Pm4sCcIiNacn0JHTbv6rhSh7kpQaph
	7gYQF7zdMT0Cg4jcOBo8vIXgECB0Vin0XwxuR74tqAhKUGhyA8PG6djc2HesG7Wp
	0D80FbO2+kI6YB/DiLJmcXhFI1+S8zWZVxYBVMvgBJoTfJO1ctBswcFkcAR6Pn0k
	DmMfHeVCtkZXBl5xn+Z3VGgBaFVw1Y9tX+CQ+eQJDbW3WdEvJXKziNmqO3vcplVY
	1QSBLV+Gwclwdvxl7qd5ghCvjNEXTP6ZkFyGcdmJf7w9iAjalOf6O27wqkwpIgL0
	EA==
Received: (qmail 3569722 invoked from network); 15 Nov 2024 18:08:49 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Nov 2024 18:08:49 +0100
X-UD-Smtp-Session: l3s3148p1@13fjnvYmSo9ehhtH
Date: Fri, 15 Nov 2024 18:08:49 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Linux MMC List <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] dmaengine: sh: rz-dmac: add r7s72100 support
Message-ID: <ZzeAIQe1zdoNYkyO@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Linux MMC List <linux-mmc@vger.kernel.org>
References: <20241001124310.2336-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdW5PhRT0B+ua=MyTeTZF+BOFEzQ8XyWtBGOiU+YKbathg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NUj8klQLcYeDFea7"
Content-Disposition: inline
In-Reply-To: <CAMuHMdW5PhRT0B+ua=MyTeTZF+BOFEzQ8XyWtBGOiU+YKbathg@mail.gmail.com>


--NUj8klQLcYeDFea7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I am not sure if the SDHI driver or the RZ-DMAC driver (or virt-dma)
> should be fixed, as the documentation[1] states:
>=20
>      Note that callbacks will always be invoked from the DMA
>      engines tasklet, never from interrupt context.

Back then, I had the impression that we can rework the SDHI SYSDMAC part
to not use a completion like the internal DMAC version does. But it has
been a while and I got completely side-tracked meanwhile.


--NUj8klQLcYeDFea7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmc3gB4ACgkQFA3kzBSg
KbZYaRAAgONEcRq91VrdR3VgzobqOiHsEOIQmPZ7pHtK3vS8EsSlPw+R94rm9oSs
IYz4PLJ/R4Px56+2ALFomogLQGTBcHivFXDrdIB3su6BEbStcqFu+SvfiFj1UxkT
DOdelDfLr5HmwInis2zzLHY8Xik99IMKd6Q0955UE9A6wGuPdOaUuhK1Cg2oAxZV
CUy8V3a/AJRDYoVqYvb1us6pDGTvzypB7FVDUu8Cj8A24tVrNf1Br5XbnDTE16pW
qaZQFxtKDp4aRR6lQaj0JsPPh/1UHxl0czRpnCAm7fDGPfZEEyi/F5XU+N3CFFZT
yIuYytLltEIuXBUwZlVfzSUMdnpRi/StVwZQoqLFyCVhIcZNFUjPkXxhbj/P/GaM
GjmoPNkO/EAx6d7WlTUXFyt8x4a8mdM2nFv5I6OiXFh/Hef+JPMp/3/v3DE2qyM/
MSeMa73n6JA9E+74iyuS6bUM3Th61vfOREBngSaDrcXAuZO/+Ehw0tcxs5dr+Ou4
wJjJav01NIPjep0KCTW4PDTytkT2A2iP7Vqz1ob6KtBs81EBAbK7mkzwWHLvkxOg
tcbUf3+m8ISi3P+B2uAAeTEvOHV+i1nBGrTspL5AzYLF2AJ9CMciRXxv4WaNshfA
E4hzI8WhlmtfXS1QeTxMSZ0VorR9Do2pzNCV7D9MPVc+k+sczGw=
=IqKm
-----END PGP SIGNATURE-----

--NUj8klQLcYeDFea7--

