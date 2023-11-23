Return-Path: <dmaengine+bounces-193-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97367F59BA
	for <lists+dmaengine@lfdr.de>; Thu, 23 Nov 2023 09:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43661B20CA3
	for <lists+dmaengine@lfdr.de>; Thu, 23 Nov 2023 08:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CC918B1F;
	Thu, 23 Nov 2023 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IsXpjCwN"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA0DD;
	Thu, 23 Nov 2023 00:02:20 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AN82B9x072621;
	Thu, 23 Nov 2023 02:02:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1700726531;
	bh=g6wWUN8jjBOlUmxcHtC2+a4xYlrZy6VZVbhcpI/kdKc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=IsXpjCwN3vH4W2iJHM9JbR9qY6yrenq5VJtIDnU7mq0VRCKycw9fSakjTV1m1sNoL
	 GnC25e4+vlSG7KcCbxrm8Cah9rTuKXjSVCMghsfDssJ3GaoLbQzPdmzfgYHglC7Sbq
	 XbyFlbXYxRd0H7PWU5bBL6cLtagoxZ/UN4iOGr+0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AN82B9r099683
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Nov 2023 02:02:11 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 02:02:10 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 02:02:10 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AN829bm039602;
	Thu, 23 Nov 2023 02:02:10 -0600
Date: Thu, 23 Nov 2023 13:32:04 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Ronald Wahl <rwahl@gmx.de>
CC: <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Peter
 Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Ronald Wahl <ronald.wahl@raritan.com>
Subject: Re: [PATCH] dmaengine: ti: k3-psil-am62: Fix SPI PDMA data
Message-ID: <akeklf5f3alqemdlssdgimqqqvkvbtqbbq3pxtsgkykma4fv3o@4op25kcmguja>
References: <20231030190113.16782-1-rwahl@gmx.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gg4vsso4b4udgkiv"
Content-Disposition: inline
In-Reply-To: <20231030190113.16782-1-rwahl@gmx.de>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--gg4vsso4b4udgkiv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

Thanks for the patch.

On Oct 30, 2023 at 20:01:13 +0100, Ronald Wahl wrote:
> AM62x has 3 SPI channels where each channel has 4 TX and 4 RX threads.
> This also fixes the thread numbers.
>=20

Please add the Fixes tag so this gets backported to stable
Fixes: 5ac6bfb58777 ("dmaengine: ti: k3-psil: Add AM62x PSIL and PDMA data")

With that change,

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> ---
>  drivers/dma/ti/k3-psil-am62.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/dma/ti/k3-psil-am62.c b/drivers/dma/ti/k3-psil-am62.c
> index 2b6fd6e37c61..1272b1541f61 100644
> --- a/drivers/dma/ti/k3-psil-am62.c
> +++ b/drivers/dma/ti/k3-psil-am62.c
> @@ -74,7 +74,9 @@ static struct psil_ep am62_src_ep_map[] =3D {
>  	PSIL_SAUL(0x7505, 21, 35, 8, 36, 0),
>  	PSIL_SAUL(0x7506, 22, 43, 8, 43, 0),
>  	PSIL_SAUL(0x7507, 23, 43, 8, 44, 0),
> -	/* PDMA_MAIN0 - SPI0-3 */
> +	/* PDMA_MAIN0 - SPI0-2 */
> +	PSIL_PDMA_XY_PKT(0x4300),
> +	PSIL_PDMA_XY_PKT(0x4301),
>  	PSIL_PDMA_XY_PKT(0x4302),
>  	PSIL_PDMA_XY_PKT(0x4303),
>  	PSIL_PDMA_XY_PKT(0x4304),
> @@ -85,8 +87,6 @@ static struct psil_ep am62_src_ep_map[] =3D {
>  	PSIL_PDMA_XY_PKT(0x4309),
>  	PSIL_PDMA_XY_PKT(0x430a),
>  	PSIL_PDMA_XY_PKT(0x430b),
> -	PSIL_PDMA_XY_PKT(0x430c),
> -	PSIL_PDMA_XY_PKT(0x430d),
>  	/* PDMA_MAIN1 - UART0-6 */
>  	PSIL_PDMA_XY_PKT(0x4400),
>  	PSIL_PDMA_XY_PKT(0x4401),
> @@ -141,7 +141,9 @@ static struct psil_ep am62_dst_ep_map[] =3D {
>  	/* SAUL */
>  	PSIL_SAUL(0xf500, 27, 83, 8, 83, 1),
>  	PSIL_SAUL(0xf501, 28, 91, 8, 91, 1),
> -	/* PDMA_MAIN0 - SPI0-3 */
> +	/* PDMA_MAIN0 - SPI0-2 */
> +	PSIL_PDMA_XY_PKT(0xc300),
> +	PSIL_PDMA_XY_PKT(0xc301),
>  	PSIL_PDMA_XY_PKT(0xc302),
>  	PSIL_PDMA_XY_PKT(0xc303),
>  	PSIL_PDMA_XY_PKT(0xc304),
> @@ -152,8 +154,6 @@ static struct psil_ep am62_dst_ep_map[] =3D {
>  	PSIL_PDMA_XY_PKT(0xc309),
>  	PSIL_PDMA_XY_PKT(0xc30a),
>  	PSIL_PDMA_XY_PKT(0xc30b),
> -	PSIL_PDMA_XY_PKT(0xc30c),
> -	PSIL_PDMA_XY_PKT(0xc30d),
>  	/* PDMA_MAIN1 - UART0-6 */
>  	PSIL_PDMA_XY_PKT(0xc400),
>  	PSIL_PDMA_XY_PKT(0xc401),
> --
> 2.41.0
>=20
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--gg4vsso4b4udgkiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmVfBvcACgkQQ96R+SSa
cUUS+w//RB6GAiJF81otCVYaaLgSajvu6778w/cIdpS5J/cQHUoQaXwb1MZcAhG3
F1YEbargIGsgfN+PXnO+CEz2VvOsxi6ZwnTULm5Iq67V1oqNTpXr0WyqR+7+cR+T
savjw8ygkPlh8++MV9Ywnh3nefb6nKIzq5AgHM11RqXvjVn26P7vE1H+ZVIGTBPm
53+e1R7App3/va/buN+lI4H+1ogji/mDeQcC1Xe0wkJ8q5lj43QJr7FTJ+j4cUaf
JPE46HFoMSkR6fWV6RfP3+QhPSmJXdQ//l1xWNqCZV2lOwK2Sukh91uMuC5jFMFn
EvH1L3PuG5xRlRfwKuAVD6UAy+Y5seiN2gpp8smZYWPDmk14ErCA9G29An4pI9jo
InwDLaMRJpeQ/7nw+svQVjiGpBYdcQSFP5rOhYd5DBOSz6c4HATA5ipk2iUEDPEN
Sqh4kp/FvJoWs1GtUFDVY+ozEsl8g6X3uIrQgfC4yTdorWsq/JLXe0ts9qtfCqbD
IAyKbKIgNm5NwHvcDshysRrsvEkUa/iSCF0yrgF25cytkEpiVBDW1Sxzq/bvEhx+
k3ZJkeVh20xU6thh65004utiLxsZmmNKRkejVyNnUvkaQhM1pTbKfUqsOS+ZPx8O
QmA4wx1yJQTcYYrPJInHVrMpV8Obk7mwivNxiah4XNABSdwcVsA=
=8GWr
-----END PGP SIGNATURE-----

--gg4vsso4b4udgkiv--

