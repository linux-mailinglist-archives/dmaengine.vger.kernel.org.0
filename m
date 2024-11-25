Return-Path: <dmaengine+bounces-3793-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6EB9D8C3B
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 19:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E9428493F
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0961B81B2;
	Mon, 25 Nov 2024 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHjScz9a"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9051B3948;
	Mon, 25 Nov 2024 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559504; cv=none; b=fGsEz3QhmpcEqSQP26KhFiXckLNLC7K7oHPxbV7tbm0PjbwMf3nGIBX1SwXy0bkGKZbU18o78mmncoNS5s2YG/QS1tLrEcEVoORvjKTvjkxKBK6xKUrpMk/JbagdnPV6dSdqDMAjW5+64LOjB461r4iBZJsm7pDNZc64WXVNKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559504; c=relaxed/simple;
	bh=Poe+Ou4l+6O6W5GecO5bjPgSMkD4GLn8esqFU0IFep0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQoBHyTxKNHGXgG4FK9byxYmW4Hm+6CcghumOd32j+QfPkwFWvObmM5cw9hgvVPb2YpE/+uxJRWK6/SnWOsBtHrSvK4F6sHY60YcVEX1xmcpey1bahKCg8TXtAydQX7ZURTIo1KHE2wro3/PaxerxQhxHgwWe/pQCD480ntrm10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHjScz9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FE8C4CECE;
	Mon, 25 Nov 2024 18:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732559503;
	bh=Poe+Ou4l+6O6W5GecO5bjPgSMkD4GLn8esqFU0IFep0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHjScz9aVfpCAkTBN/9qcqFS2GM8NcozocB3Ngl4I5WsSxkiYYgT0LE1+75tHpd2+
	 TH52RI5H2/kwNEAnH4tn3z59Mg/ueM7FpdF2AEm6xZAVDi2a0Wo6EbwxdHmq1PruRg
	 Lo/CG25loTPKwEHAPjTNqG50WaUDd/0KfHNS9PrnT1ci2K1zmBxi1j2bfy+pAy7sHt
	 2s+UTR24ODjCd3yY+dNCXFvDCNpXaVbSMPU7EoDCJrZFDf1L9Gj1uIhH0GOiDHlhdt
	 tO3/PI7GhGAzTZzT/iN3VeudKSaqIZsG7ljG89IjKwEpI7kgUA+MwyNE1viXe7ZzrW
	 KtvSbvgQKHpkw==
Date: Mon, 25 Nov 2024 18:31:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Vaishnav Achath <vaishnav.a@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	u-kumar1@ti.com, j-choudhary@ti.com, vigneshr@ti.com
Subject: Re: [PATCH 2/2] dmaengine: ti: k3-udma: Add TX channel data in AM62A
 CSIRX DMSS
Message-ID: <20241125-hardener-jockey-d8d57f6a9430@spud>
References: <20241125083914.2934815-1-vaishnav.a@ti.com>
 <20241125083914.2934815-2-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ONFPeZ2tioFdg7FB"
Content-Disposition: inline
In-Reply-To: <20241125083914.2934815-2-vaishnav.a@ti.com>


--ONFPeZ2tioFdg7FB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 02:09:14PM +0530, Vaishnav Achath wrote:
> J722S/AM67 uses the same BCDMA CSIRX IP as AM62A, but it supports
> TX channels as well in addition to RX.

This doesn't make sense. You say that the am62a doesn't have a tx
channel ("but it supports TX as well") but then modify the struct for
the am62a to add a tx channel. Does that not break things on the am62a?


> Add the BCDMA TCHAN information
> in the am62a_dmss_csi_soc_data so as to support all the platforms in the
> family with same compatible. UDMA_CAP2_TCHAN_CNT indicates the presence
> of TX channels and it will be 0 for platforms without TX support.
>=20
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
>=20
> CSI2RX capture test results on J722S EVM with IMX219:
> https://gist.github.com/vaishnavachath/e2eaed62ee8f53428ee9b830aaa02cc3
>=20
>  drivers/dma/ti/k3-udma.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index b3f27b3f9209..4130f50979d4 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4340,6 +4340,8 @@ static struct udma_match_data j721e_mcu_data =3D {
> =20
>  static struct udma_soc_data am62a_dmss_csi_soc_data =3D {
>  	.oes =3D {
> +		.bcdma_tchan_data =3D 0x800,
> +		.bcdma_tchan_ring =3D 0xa00,
>  		.bcdma_rchan_data =3D 0xe00,
>  		.bcdma_rchan_ring =3D 0x1000,
>  	},
> --=20
> 2.34.1
>=20

--ONFPeZ2tioFdg7FB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0TCiwAKCRB4tDGHoIJi
0gqKAQCe0SNMHmEZbd+OGYhiCx7AYYLgWcuj+9LCVKpPMbWabwEAiFTaZHesxW8J
aUSOcYWESY5yll72kHHkfgMC1TCh/Q4=
=6NNf
-----END PGP SIGNATURE-----

--ONFPeZ2tioFdg7FB--

