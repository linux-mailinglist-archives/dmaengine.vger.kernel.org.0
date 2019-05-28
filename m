Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29A1D2C527
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2019 13:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfE1LKb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 May 2019 07:10:31 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36235 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfE1LKb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 May 2019 07:10:31 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id E67F8E0004;
        Tue, 28 May 2019 11:10:24 +0000 (UTC)
Date:   Tue, 28 May 2019 13:10:24 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Allwinner H6 DMA support
Message-ID: <20190528111024.gj25jh5vstizze74@flea>
References: <20190527201459.20130-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z7ek7mx2fjvua3lu"
Content-Disposition: inline
In-Reply-To: <20190527201459.20130-1-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--z7ek7mx2fjvua3lu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2019 at 10:14:52PM +0200, Cl=E9ment P=E9ron wrote:
> Hi,
>
> This series has been first proposed by Jernej Skrabec[1].
> As this series is mandatory for SPDIF/I2S support and because he is
> busy on Cedrus stuff. I asked him to make the minor change requested
> and repost it.
> Authorship remains to him.
>
> I have tested this series with SPDIF driver and added a patch to enable
> DMA_SUN6I_CONFIG for arm64.
>
> Original Post:
> "
> DMA engine engine on H6 almost the same as on older SoCs. The biggest
> difference is that it has slightly rearranged bits in registers and
> it needs additional clock, probably due to iommu.
>
> These patches were tested with I2S connected to HDMI. I2S needs
> additional patches which will be sent later.

For the whole series,
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--z7ek7mx2fjvua3lu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXO0XIAAKCRDj7w1vZxhR
xVR3AP9YbutRsxD9Y3rwfBC3bguX4JoBWqgLPRSKHszeGDW36QEA+LVEhKb99jvN
catOGhDyeFdJdmT6r7eRLjjtMuPzCg8=
=pe/c
-----END PGP SIGNATURE-----

--z7ek7mx2fjvua3lu--
