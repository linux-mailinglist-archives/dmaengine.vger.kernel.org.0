Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0966350B14
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 14:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfFXMtE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 08:49:04 -0400
Received: from sauhun.de ([88.99.104.3]:33262 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfFXMtD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Jun 2019 08:49:03 -0400
Received: from localhost (p54B33083.dip0.t-ipconnect.de [84.179.48.131])
        by pokefinder.org (Postfix) with ESMTPSA id 948572C0398;
        Mon, 24 Jun 2019 14:49:01 +0200 (CEST)
Date:   Mon, 24 Jun 2019 14:49:01 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: rcar-dmac: Reject zero-length slave DMA
 requests
Message-ID: <20190624124900.GA4778@kunai>
References: <20190624123818.20919-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20190624123818.20919-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Although requesting a zero-length DMA request is a driver bug, rejecting
> it early eases debugging.

True. I wonder, though, if we then should turn the message into a WARN,
so the call stack will point to the faulty driver?


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0QxrgACgkQFA3kzBSg
Kbb9yg//ZJlEi27/SzgGtHV3PffmaGQyZZPihMYeiTCdI3w16xR48GgUPRa8S3Wp
urt7Ug4j6JcW2vxXJ1xLZtHxzkYMwj9PIJOrTyOLUv+foNFZylbSXK/HxhqUNxnX
OUlklDl0IxfD2iZ0WjkLiPkl0OSiHEPWU7ljp3wb4/YhJNO5JtTHjh7C+M5NVwQi
7X1VORJ6gzZYY69hAm+3e/jQ+yuRqhijKBw8Fw0dWHJXIb5iIdqXRAza4A/+P9eT
/QTt6zzbFAqJNgeAByJSWSQk8QWUoyi3bNPNhB4Pj2kvz2us3W7K/pkFDwAGp/qv
EISeDJwv3O+DJu7pr2BNCyKV/S8GwYADkJTaEFfIZ/OyaSiKpdxR9abw16gUaKIt
Z4ctfdFOUvAL48MpkyjK3slIg0BLCCQn5jOU8zRY5LZQDzZ1DtgU0fjfgC5922Fa
BY+SeuuV/RJVRE1WyLRQ4tjM8unFw7297tFG6giU5oXZ14XJ3GjsE+sJc/vUAbFk
TcCytIpYNTOMjgnUiJCzIfeDyFjkJScntwig42D5L7fJP+xY42SlwpbgUnSzplu+
krAsXZuWG+7sn5rQiU+u5s/tz3okubGCjea8bL84jal9XndrjBvw/lSn4qS7PI+N
JdapeYhx9fKv8SDoc9ZGlXt4e0pTKNzhxvmjHYeAgUbieGpS8uo=
=SzB/
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
