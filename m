Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F0C74B47A
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 17:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjGGPlX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 11:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGPlW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 11:41:22 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93346173B;
        Fri,  7 Jul 2023 08:41:21 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C6FF61C0ABB; Fri,  7 Jul 2023 17:41:18 +0200 (CEST)
Date:   Fri, 7 Jul 2023 17:41:18 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hien Huynh <hien.huynh.px@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH v3 1/2] dmaengine: sh: rz-dmac: Improve cleanup order in
 probe()/remove()
Message-ID: <ZKgyHnEAiKrAUAZK@duo.ucw.cz>
References: <20230706112150.198941-1-biju.das.jz@bp.renesas.com>
 <20230706112150.198941-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tp4P7Um4iCQFfl+6"
Content-Disposition: inline
In-Reply-To: <20230706112150.198941-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--tp4P7Um4iCQFfl+6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> We usually do cleanup in reverse order of init. Currently, in the
> case of error, this is not followed in rz_dmac_probe(), and similar
> case for remove().
>=20
> This patch improves error handling in probe() and cleanup in
> reverse order of init in the remove().

Thanks for doing this.

Reviewed-by: Pavel Machek <pavel@denx.de>

BR,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tp4P7Um4iCQFfl+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZKgyHgAKCRAw5/Bqldv6
8rnYAKCwH6i6Z01LDry8yTHDquGS0XKTcQCgj/vTWYNwhD5anF+O/pcDloeIqNM=
=4Nv4
-----END PGP SIGNATURE-----

--tp4P7Um4iCQFfl+6--
