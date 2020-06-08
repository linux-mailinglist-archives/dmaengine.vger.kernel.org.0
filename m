Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2071F1B0F
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2020 16:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgFHOfC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 Jun 2020 10:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729938AbgFHOfB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 8 Jun 2020 10:35:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A42492053B;
        Mon,  8 Jun 2020 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591626901;
        bh=se07oWpX9Vc9YGWIWXRJxx09yVt7wFgerxA1Los/EJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7mbEcSg+/zhqjXLAyy2REvz73FjXmyY1tuwYpyG0jPt2Up6kIWVbYfu324qSUOx8
         mvtayzWIg2FUQiMANalVpYJNrft4AeJhJb7M2QBEn6Mt7YWWrgsw4GlJ1rbHWXBriy
         Nd25PVMOlWx1aygpW8+3b8YRF88v+H8x2LrVoRZU=
Date:   Mon, 8 Jun 2020 15:34:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, catalin.marinas@arm.com,
        vkoul@kernel.org, will.deacon@arm.com, shawnguo@kernel.org,
        festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: Re: [PATCH v9 RESEND 01/13] spi: imx: add dma_sync_sg_for_device
 after fallback from dma
Message-ID: <20200608143458.GH4593@sirena.org.uk>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
 <1591485677-20533-2-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VkqCAaSJIySsbD6j"
Content-Disposition: inline
In-Reply-To: <1591485677-20533-2-git-send-email-yibin.gong@nxp.com>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--VkqCAaSJIySsbD6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 07, 2020 at 07:21:05AM +0800, Robin Gong wrote:
> In case dma transfer failed and fallback to pio, tx_buf/rx_buf need to be
> taken care cache since they have already been maintained by spi.c

Is this needed as part of this series?  This looks like an independent
fix and it seems better to get this in independently.=20

> Fixes: bcd8e7761ec9("spi: imx: fallback to PIO if dma setup failure")
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Reported-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Link: https://lore.kernel.org/linux-arm-kernel/5d246dd81607bb6e5cb9af86ad=
4e53f7a7a99c50.camel@ew.tq-group.com/

The Link is usually to the patch on the list.

> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1456,6 +1456,13 @@ static int spi_imx_pio_transfer(struct spi_device =
*spi,
>  		return -ETIMEDOUT;
>  	}
> =20
> +	if (transfer->rx_sg.sgl) {
> +		struct device *rx_dev =3D spi->controller->dma_rx->device->dev;
> +
> +		dma_sync_sg_for_device(rx_dev, transfer->rx_sg.sgl,
> +				       transfer->rx_sg.nents, DMA_TO_DEVICE);
> +	}
> +
>  	return transfer->len;
>  }

This is confusing - why are we DMA mapping to the device after doing a
PIO transfer?

--VkqCAaSJIySsbD6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7eTJIACgkQJNaLcl1U
h9AmVQgAgF2rPJqmixW0OscJdAzTqAWK/RzhC/aIQ0M2AWtflewynWvGc7rEB0gU
edNL29WS+Daa76JCcvlaMpJkmrRbylXM8sVNWcnIHwyXvp8sizcvcqcyNl5jE8ls
vfCYPQjBxCwE6vBYG7zaLTooQ/tgT6KDQtijCN7Vg+cqsTba5YU6cQS8LIYxBL0L
c6lvNJBB/eY2dYwWRlNPURlD+8Ur9bwZ464iui3Ivk3Zx3j59QfTYc4/AOGXYRkE
ZdhxXYE7TH9f7eeDWHDZwOc9W+LEp7+6Yj7ON7gPgHndlK/dGrTYNEFa6Q4dPHGp
ng06qs5xaleX4+/qjTTPf+UIkpv6/g==
=0xWQ
-----END PGP SIGNATURE-----

--VkqCAaSJIySsbD6j--
