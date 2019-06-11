Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6CA3C5F0
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2019 10:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404705AbfFKI2k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jun 2019 04:28:40 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35293 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404559AbfFKI2k (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jun 2019 04:28:40 -0400
X-Originating-IP: 90.88.159.246
Received: from localhost (aaubervilliers-681-1-40-246.w90-88.abo.wanadoo.fr [90.88.159.246])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id AE35CC001B;
        Tue, 11 Jun 2019 08:28:32 +0000 (UTC)
Date:   Tue, 11 Jun 2019 10:28:32 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] arm64: defconfig: enable Allwinner DMA drivers
Message-ID: <20190611082832.lu45xaxyuftmc3et@flea>
References: <20190527201459.20130-1-peron.clem@gmail.com>
 <20190527201459.20130-8-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pmlkumyvjoeoxyoi"
Content-Disposition: inline
In-Reply-To: <20190527201459.20130-8-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--pmlkumyvjoeoxyoi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2019 at 10:14:59PM +0200, Cl=E9ment P=E9ron wrote:
> Allwinner sun6i DMA drivers is used on A64 and H6 boards.
>
> Enable it as a module.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Applied, thanks
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--pmlkumyvjoeoxyoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXP9mMAAKCRDj7w1vZxhR
xbJ1AQDeFPEci2+C/F9JAKMPMRxCGb1crqPrOBHlGm5cOPU5mgD/XrVy7lKljnD3
kRiygPovjYI/8EQCelT+QrOFbBXtSAs=
=2p9T
-----END PGP SIGNATURE-----

--pmlkumyvjoeoxyoi--
