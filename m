Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7313B3043B4
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 17:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392853AbhAZQW2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 11:22:28 -0500
Received: from www.zeus03.de ([194.117.254.33]:34068 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392859AbhAZQWU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Jan 2021 11:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=69XObF95WtSS8VyhOlUCKP8GNjcj
        eQqS/KWP7VudESk=; b=t1f9Q827OEAaWutJdtDDS0k9EJPHWWoWWr957FRBx637
        zh2HXlDNl8F8RL59/sGp+tfydc8ueHPCo7dEMEaATNB8+g0/YfDTXn9Psh0SyD27
        8iWFvgYqBy0DDW8TIlA/2WYjF+ws0U5VllrqM0luptI0mjAwXj5pF36jhtg7odI=
Received: (qmail 3782982 invoked from network); 26 Jan 2021 17:21:38 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Jan 2021 17:21:38 +0100
X-UD-Smtp-Session: l3s3148p1@G1qEDNC5EOUgAwDPXyX1AEdA8SGgn5QT
Date:   Tue, 26 Jan 2021 17:21:37 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dmaengine: rcar-dmac: Add helpers for clearing
 DMA channel status
Message-ID: <20210126162137.GB928@ninjato>
References: <20210125142431.1049668-1-geert+renesas@glider.be>
 <20210125142431.1049668-4-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <20210125142431.1049668-4-geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2021 at 03:24:30PM +0100, Geert Uytterhoeven wrote:
> Extract the code to clear the status of one or all channels into their
> own helpers, to prepare for the different handling of the R-Car V3U SoC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks good and works fine with I2C + DMA on V3U:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmAQQZEACgkQFA3kzBSg
KbaP4A/+KgYXyUS3zhyOqcl7Xa5VAc9DYaWvoiDNQcspOqmkqPw+NlA9XkuUwJU0
CWU27aTsRbyhYKzPMNxjIH+16ztGPRG0Zkr0OSvYYPMuMerD6DlkW1wLDufKq7+L
u+g2kx//tTP6TaKOGLdIsimkeB2MhghVOctslPOggEk5QBI4D9qf9mHzXOeM0v3K
jBUyefwwzOm3XA/oMiL6HNVRdgPIqT71afaOyO1xBFPKFvjP2iZRoVSPKP0Hfe/i
1ANFt96h5VpQsgvQwLIDkSDdMH/Hp8jHTkAkaEFx3m6C4KlFBqwlLb27VLvaRkXz
Z6NyBwC0uCrKVhxKcpOb2CkBC5MKW4ZtwMlKhlF1Q+WBtWunrO8U4DhNfjfnq+7l
Y0u37r699hJDGFqAGCrq1SWFHDOtWl8mnIlAnxFXQufH0grhSMS/anQYtvbE94m1
NFnd7TeLc3ThvHDuZQ8WJ6ZjknxoSn26SNoUORY+gqIEpbwkoMhlpPYTkes4EzNc
6BjDoIxgBJyRUUPqhzhNN6pY/C0bzEsbuw4gDx5yPpLWOcsZ8FPjxliz4S5mnuhG
KG7LhjvnPToQ7XvGTB3w1i5TmXvlTcOaNp/HRILDJy31c31ef+ZfsX+m9s+DZhjA
3J+JAOJVTV+pYCLvCEL0Z0BjVVGXMZQ335lAWhywcLr7Dq+iPYo=
=y8Ux
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
