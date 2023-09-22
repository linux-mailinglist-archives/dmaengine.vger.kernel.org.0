Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B15C7AAF11
	for <lists+dmaengine@lfdr.de>; Fri, 22 Sep 2023 12:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjIVKEL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Sep 2023 06:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjIVKEK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Sep 2023 06:04:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82508CE;
        Fri, 22 Sep 2023 03:04:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B70C433C8;
        Fri, 22 Sep 2023 10:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695377044;
        bh=00l4c9MLUEW+59kbg7YWsJXOKjOKnRp0XSr7Fn0HoCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lA/pYDrRDHZSfmNX4Ei7dU7ZtbAmkYCwTJa2VK7mI5YtE+ojVthciYIvrkXN0N/2m
         /nnDuuGVMaofuKrunhKg4XU6hN84+nWXYDUHiUQByppufv0VoNTmkq0BNMxl0k/Ss2
         exoENwUQtXdwkx/aHqJ+tB5tlFnumLXp+PNrSdVd79x07JZq62iMu2YUJO/2kG7T2N
         TSBVt/DESKrfrKj+ojtkwmvyxx4thBcEvG0dZHMJNiSiFmdpZhMR0+9ve6beB7nt9d
         rWTL2JgHvklRIwhtmRu1PeH3ke9j5pFtbxCsconN/Ynv8B/jhWqqsUDxPpi2/ddtVG
         XYz4UZeDwxBog==
Date:   Fri, 22 Sep 2023 11:03:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     shravan chippa <shravan.chippa@microchip.com>
Cc:     green.wan@sifive.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor+dt@kernel.org, palmer@sifive.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nagasuresh.relli@microchip.com, praveen.kumar@microchip.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v1 3/3] dmaengine: sf-pdma: add mpfs-pdma compatible name
Message-ID: <20230922-sappy-huddle-1484d64b27f3@spud>
References: <20230922095039.74878-1-shravan.chippa@microchip.com>
 <20230922095039.74878-4-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="afMx8rXFETmT0Tex"
Content-Disposition: inline
In-Reply-To: <20230922095039.74878-4-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--afMx8rXFETmT0Tex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Shravan,

On Fri, Sep 22, 2023 at 03:20:39PM +0530, shravan chippa wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
>=20
> Sifive platform dma does not allow out-of-order transfers,

Can you remind me why we determined that this was the case?
IOW, why could we not enable the out-of-order transfers and get a
performance benefit for everyone? It's been a year or so (I think) and I
have forgotten.

Cheers,
Conor.

> buf out-of-order dma has a significant performance advantage.
> Add a PolarFire SoC specific compatible and code to support
> for out-of-order dma transfers
>=20
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 27 ++++++++++++++++++++++++---
>  drivers/dma/sf-pdma/sf-pdma.h |  6 ++++++
>  2 files changed, 30 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index c7558c9f9ac3..992a804166d5 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -21,6 +21,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/of.h>
>  #include <linux/of_dma.h>
> +#include <linux/of_device.h>
>  #include <linux/slab.h>
> =20
>  #include "sf-pdma.h"
> @@ -66,7 +67,7 @@ static struct sf_pdma_desc *sf_pdma_alloc_desc(struct s=
f_pdma_chan *chan)
>  static void sf_pdma_fill_desc(struct sf_pdma_desc *desc,
>  			      u64 dst, u64 src, u64 size)
>  {
> -	desc->xfer_type =3D PDMA_FULL_SPEED;
> +	desc->xfer_type =3D  desc->chan->pdma->transfer_type;
>  	desc->xfer_size =3D size;
>  	desc->dst_addr =3D dst;
>  	desc->src_addr =3D src;
> @@ -520,6 +521,7 @@ static struct dma_chan *sf_pdma_of_xlate(struct of_ph=
andle_args *dma_spec,
> =20
>  static int sf_pdma_probe(struct platform_device *pdev)
>  {
> +	const struct sf_pdma_driver_platdata *ddata;
>  	struct sf_pdma *pdma;
>  	int ret, n_chans;
>  	const enum dma_slave_buswidth widths =3D
> @@ -545,6 +547,14 @@ static int sf_pdma_probe(struct platform_device *pde=
v)
> =20
>  	pdma->n_chans =3D n_chans;
> =20
> +	pdma->transfer_type =3D PDMA_FULL_SPEED;
> +
> +	ddata  =3D of_device_get_match_data(&pdev->dev);
> +	if (ddata) {
> +		if (ddata->quirks & NO_STRICT_ORDERING)
> +			pdma->transfer_type &=3D ~(NO_STRICT_ORDERING);
> +	}
> +
>  	pdma->membase =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pdma->membase))
>  		return PTR_ERR(pdma->membase);
> @@ -629,11 +639,22 @@ static int sf_pdma_remove(struct platform_device *p=
dev)
>  	return 0;
>  }
> =20
> +static const struct sf_pdma_driver_platdata mpfs_pdma =3D {
> +	.quirks =3D NO_STRICT_ORDERING,
> +};
> +
>  static const struct of_device_id sf_pdma_dt_ids[] =3D {
> -	{ .compatible =3D "sifive,fu540-c000-pdma" },
> -	{ .compatible =3D "sifive,pdma0" },
> +	{
> +		.compatible =3D "sifive,fu540-c000-pdma",
> +	}, {
> +		.compatible =3D "sifive,pdma0",
> +	}, {
> +		.compatible =3D "microchip,mpfs-pdma",
> +		.data	    =3D &mpfs_pdma,
> +	},
>  	{},
>  };
> +
>  MODULE_DEVICE_TABLE(of, sf_pdma_dt_ids);
> =20
>  static struct platform_driver sf_pdma_driver =3D {
> diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> index 5c398a83b491..3b16db4daa0b 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.h
> +++ b/drivers/dma/sf-pdma/sf-pdma.h
> @@ -49,6 +49,7 @@
> =20
>  /* Transfer Type */
>  #define PDMA_FULL_SPEED					0xFF000008
> +#define NO_STRICT_ORDERING				BIT(3)
> =20
>  /* Error Recovery */
>  #define MAX_RETRY					1
> @@ -112,8 +113,13 @@ struct sf_pdma {
>  	struct dma_device       dma_dev;
>  	void __iomem            *membase;
>  	void __iomem            *mappedbase;
> +	u32			transfer_type;
>  	u32			n_chans;
>  	struct sf_pdma_chan	chans[];
>  };
> =20
> +struct sf_pdma_driver_platdata {
> +	u32 quirks;
> +};
> +
>  #endif /* _SF_PDMA_H */
> --=20
> 2.34.1
>=20

--afMx8rXFETmT0Tex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ1mjgAKCRB4tDGHoIJi
0v6AAQCQTGk6YdjvTBFnqNLC+TAUoVw03aK0hhSVZVJEqKEw3AD/ad9DjcZmYXma
irUTJYGdDxiZ+ExA2hDsSKe1j8MOtws=
=1YnB
-----END PGP SIGNATURE-----

--afMx8rXFETmT0Tex--
