Return-Path: <dmaengine+bounces-511-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B41281178B
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 16:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF211C20EFB
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703082F84B;
	Wed, 13 Dec 2023 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rebx+32w"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5345147A9;
	Wed, 13 Dec 2023 07:29:11 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BDFT7UE125058;
	Wed, 13 Dec 2023 09:29:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702481347;
	bh=qG9fVDRrbj/BtpoBAlezZnVtaEVeTj0X3XMa9chEaVs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=rebx+32wMIauXQXCpQqFnMZB/vtnkpAxFAetuW/5Y4dGpaoS0WQOj3njiuODXRxx8
	 hNnUk20Y/EzONlbpsDatRccW9v37n0aX8iV9PMQjYJHUUwqb04BPbGaON8yc7rD18G
	 956JH2z2jKZZ2yhaIhopKQvZbKnFDN3qmOsUZVWs=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BDFT7T3092864
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 13 Dec 2023 09:29:07 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 09:29:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 09:29:07 -0600
Received: from localhost ([10.250.64.83])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BDFT5lr040281;
	Wed, 13 Dec 2023 09:29:06 -0600
Date: Wed, 13 Dec 2023 20:59:05 +0530
From: Jai Luthra <j-luthra@ti.com>
To: "Achath, Vaishnav" <vaishnav.a@ti.com>
CC: "vkoul@kernel.org" <vkoul@kernel.org>,
        "peter.ujfalusi@gmail.com"
	<peter.ujfalusi@gmail.com>,
        "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Brattlof, Bryan" <bb@ti.com>,
        "Raghavendra,
 Vignesh" <vigneshr@ti.com>,
        "Choudhary, Jayesh" <j-choudhary@ti.com>,
        "Kumar,
 Udit" <u-kumar1@ti.com>
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma: Add PSIL threads for AM62P
 and J722S
Message-ID: <divyx7p7s4hzhhl3g4ffqcsma7n5mxzpy2ttghgknfnaim7tso@smxuizahkiuh>
References: <20231213081318.26203-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jjt27m45ffmmgn36"
Content-Disposition: inline
In-Reply-To: <20231213081318.26203-1-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--jjt27m45ffmmgn36
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vaishnav,

Thanks for the patch.

On Dec 13, 2023 at 13:43:18 +0530, Achath, Vaishnav wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
>=20
> Add PSIL thread information and enable UDMA support for AM62P
> and J722S SoC. J722S SoC family is a superset of AM62P, thus
> common PSIL thread ID map is reused for both devices.
>=20
> For those interested, more details about the SoC can be found
> in the Technical Reference Manual here:
> 	AM62P - https://www.ti.com/lit/pdf/spruj83
> 	J722S -	https://www.ti.com/lit/zip/sprujb3
>=20
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> ---
> V1: https://lore.kernel.org/all/20231212203655.3155565-2-bb@ti.com/
> J722S Bootlog with DMA enabled : https://gist.github.com/vaishnavachath/4=
6b56dab34dfea3a171d3ad266160780
>=20
> V1->V2:
> 	* Add J722S support and additional CSI2RX channels
> 	* Update copyright year to 2023 and update commit message.
>=20
>  drivers/dma/ti/Makefile        |   3 +-
>  drivers/dma/ti/k3-psil-am62p.c | 325 +++++++++++++++++++++++++++++++++
>  drivers/dma/ti/k3-psil-priv.h  |   1 +
>  drivers/dma/ti/k3-psil.c       |   2 +
>  drivers/dma/ti/k3-udma.c       |   2 +
>  5 files changed, 332 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/dma/ti/k3-psil-am62p.c

[...]

>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--jjt27m45ffmmgn36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmV5zcAACgkQQ96R+SSa
cUUjIA//Z1liHzE5jSpnUbTIHISEpHvYHFjqdiYUNOkIMmtCbVGX/VY0p9fj8/u4
Xnkv2bOKI8kmbP7k2H0ntkDjP6bgw5vqQH6KtE7JUXx8zPo0QQpAp+Xd/6fmzrmq
XQq5ZxoFirE3AJwcakACr6FNbmHoqR0mB4dSPmEtNO+F0zmYPsiUVCKIUtwo4jS0
OOi/eOOg9yjf6uHuOYpyWP41+0eE34G6Ps2mimeLrcWjWm/q79jc57XT1+qBtAwG
fz7EVQFvmY8aYlcVgishUVakPiBqNQdh/XbOxYDQwycsWM/nu32L8RKdy6aTVDdN
QUI4ylYPU0bdr6bsyIKFzGqSTg/zwdBSkMGMwKRb4Zn7dBEMEwXwN+DR5wLRNx28
Ln7nYeSg+b3An22cbpIYgH0ZiBRGYcxFG8K+5OL7gXxH2ho7nxeS119/hqg/wdgZ
qdLtwHwy2I9gxQ8oe3OekmFpcEgfwEuN3fQTesXSBwlE6TMVUJ6JrzwEVknOAH41
g6xqB0tLZAXJyAwsVIpDUZ/wKJCoIvWoja/edS8jQv3uPZ7tX7iUhJzgo8Fl697X
yMWKnaE9lHxUfHDQRuy21fEdXQPmly5y24bFhciN6G6W6kQkR4aQ1yNm9xiTZkkE
FWm0BARzjeO2FROUx8ELZgnHrECrTrdQPClDW3I6G/B2gAvN6sQ=
=d1gH
-----END PGP SIGNATURE-----

--jjt27m45ffmmgn36--

