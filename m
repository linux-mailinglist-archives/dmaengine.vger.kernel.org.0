Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D372ABA2
	for <lists+dmaengine@lfdr.de>; Sun, 26 May 2019 20:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfEZSec (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 26 May 2019 14:34:32 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:46797 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfEZSeb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 26 May 2019 14:34:31 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 7E4EC200006;
        Sun, 26 May 2019 18:34:26 +0000 (UTC)
Date:   Sun, 26 May 2019 20:34:25 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v2 5/7] dmaengine: sun6i: Add support for H6 DMA
Message-ID: <20190526183425.nbhrk5pa264p7tdy@flea>
References: <20190525163819.21055-1-peron.clem@gmail.com>
 <20190525163819.21055-6-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="geomrocia5ckksq4"
Content-Disposition: inline
In-Reply-To: <20190525163819.21055-6-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--geomrocia5ckksq4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2019 at 06:38:17PM +0200, Cl=E9ment P=E9ron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>
> H6 DMA has more than 32 supported DRQs, which means that configuration
> register is slightly rearranged. It also needs additional clock to be
> enabled.
>
> Add support for it.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  drivers/dma/sun6i-dma.c | 44 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index f5cb5e89bf7b..8d44ddae926a 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -69,14 +69,19 @@
>
>  #define DMA_CHAN_CUR_CFG	0x0c
>  #define DMA_CHAN_MAX_DRQ_A31		0x1f
> +#define DMA_CHAN_MAX_DRQ_H6		0x3f
>  #define DMA_CHAN_CFG_SRC_DRQ_A31(x)	((x) & DMA_CHAN_MAX_DRQ_A31)
> +#define DMA_CHAN_CFG_SRC_DRQ_H6(x)	((x) & DMA_CHAN_MAX_DRQ_H6)
>  #define DMA_CHAN_CFG_SRC_MODE_A31(x)	(((x) & 0x1) << 5)
> +#define DMA_CHAN_CFG_SRC_MODE_H6(x)	(((x) & 0x1) << 8)
>  #define DMA_CHAN_CFG_SRC_BURST_A31(x)	(((x) & 0x3) << 7)
>  #define DMA_CHAN_CFG_SRC_BURST_H3(x)	(((x) & 0x3) << 6)
>  #define DMA_CHAN_CFG_SRC_WIDTH(x)	(((x) & 0x3) << 9)
>
>  #define DMA_CHAN_CFG_DST_DRQ_A31(x)	(DMA_CHAN_CFG_SRC_DRQ_A31(x) << 16)
> +#define DMA_CHAN_CFG_DST_DRQ_H6(x)	(DMA_CHAN_CFG_SRC_DRQ_H6(x) << 16)
>  #define DMA_CHAN_CFG_DST_MODE_A31(x)	(DMA_CHAN_CFG_SRC_MODE_A31(x) << 16)
> +#define DMA_CHAN_CFG_DST_MODE_H6(x)	(DMA_CHAN_CFG_SRC_MODE_H6(x) << 16)
>  #define DMA_CHAN_CFG_DST_BURST_A31(x)	(DMA_CHAN_CFG_SRC_BURST_A31(x) << =
16)
>  #define DMA_CHAN_CFG_DST_BURST_H3(x)	(DMA_CHAN_CFG_SRC_BURST_H3(x) << 16)
>  #define DMA_CHAN_CFG_DST_WIDTH(x)	(DMA_CHAN_CFG_SRC_WIDTH(x) << 16)
> @@ -319,12 +324,24 @@ static void sun6i_set_drq_a31(u32 *p_cfg, s8 src_dr=
q, s8 dst_drq)
>  		  DMA_CHAN_CFG_DST_DRQ_A31(dst_drq);
>  }
>
> +static void sun6i_set_drq_h6(u32 *p_cfg, s8 src_drq, s8 dst_drq)
> +{
> +	*p_cfg |=3D DMA_CHAN_CFG_SRC_DRQ_H6(src_drq) |
> +		  DMA_CHAN_CFG_DST_DRQ_H6(dst_drq);
> +}
> +
>  static void sun6i_set_mode_a31(u32 *p_cfg, s8 src_mode, s8 dst_mode)
>  {
>  	*p_cfg |=3D DMA_CHAN_CFG_SRC_MODE_A31(src_mode) |
>  		  DMA_CHAN_CFG_DST_MODE_A31(dst_mode);
>  }
>
> +static void sun6i_set_mode_h6(u32 *p_cfg, s8 src_mode, s8 dst_mode)
> +{
> +	*p_cfg |=3D DMA_CHAN_CFG_SRC_MODE_H6(src_mode) |
> +		  DMA_CHAN_CFG_DST_MODE_H6(dst_mode);
> +}
> +
>  static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
>  {
>  	struct sun6i_desc *txd =3D pchan->desc;
> @@ -1160,6 +1177,28 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg =
=3D {
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
>  };
>
> +/*
> + * The H6 binding uses the number of dma channels from the
> + * device tree node.
> + */
> +static struct sun6i_dma_config sun50i_h6_dma_cfg =3D {
> +	.clock_autogate_enable =3D sun6i_enable_clock_autogate_h3,
> +	.set_burst_length =3D sun6i_set_burst_length_h3,
> +	.set_drq          =3D sun6i_set_drq_h6,
> +	.set_mode         =3D sun6i_set_mode_h6,
> +	.src_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
> +	.dst_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
> +	.src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> +	.dst_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> +	.has_mbus_clk =3D true,
> +};
> +
>  /*
>   * The V3s have only 8 physical channels, a maximum DRQ port id of 23,
>   * and a total of 24 usable source and destination endpoints.
> @@ -1190,6 +1229,7 @@ static const struct of_device_id sun6i_dma_match[] =
=3D {
>  	{ .compatible =3D "allwinner,sun8i-h3-dma", .data =3D &sun8i_h3_dma_cfg=
 },
>  	{ .compatible =3D "allwinner,sun8i-v3s-dma", .data =3D &sun8i_v3s_dma_c=
fg },
>  	{ .compatible =3D "allwinner,sun50i-a64-dma", .data =3D &sun50i_a64_dma=
_cfg },
> +	{ .compatible =3D "allwinner,sun50i-h6-dma", .data =3D &sun50i_h6_dma_c=
fg },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sun6i_dma_match);
> @@ -1288,8 +1328,8 @@ static int sun6i_dma_probe(struct platform_device *=
pdev)
>  	ret =3D of_property_read_u32(np, "dma-requests", &sdc->max_request);
>  	if (ret && !sdc->max_request) {
>  		dev_info(&pdev->dev, "Missing dma-requests, using %u.\n",
> -			 DMA_CHAN_MAX_DRQ_A31);
> -		sdc->max_request =3D DMA_CHAN_MAX_DRQ_A31;
> +			 DMA_CHAN_MAX_DRQ_H6);
> +		sdc->max_request =3D DMA_CHAN_MAX_DRQ_H6;

This is changing the binding though, since we're changing the
default. This should be reflected in the binding, and we should keep
the same default in the device tree binding.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--geomrocia5ckksq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOrcMQAKCRDj7w1vZxhR
xTmGAQDZGYjzPAjokaPobd60xQy1t549hb1zwKRPlrxEnYyWgwEA8bqUI9dAqgRj
Fyp08DKygJ7yRMfzdfmURUm9kIVtRQ8=
=gZ3v
-----END PGP SIGNATURE-----

--geomrocia5ckksq4--
