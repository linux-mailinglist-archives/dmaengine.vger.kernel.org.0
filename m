Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20B49ADDA7
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2019 18:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391243AbfIIQ5L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Sep 2019 12:57:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38972 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389693AbfIIQ5L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Sep 2019 12:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JeapzLONknbsIsXMBwRpGup1Gfl8/DRFGoBUaLJxCH4=; b=vxrTBVmoeFH7R7ls/WxzSinc0
        CmFtoaXKVc2Uf2ltaFFJudjpL17FBGLwCZAj+gVnBbdi8KJ7/kZoUsJmYjaw3oJdNsXoW/B6W2san
        6lKFWp6PFhTUf2DGPTK2WuSDoeIxUeRkzmjG9+DS9xYny1f1B+/GV9lAtXi4y03zup97o=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7MyF-00039w-VW; Mon, 09 Sep 2019 16:56:56 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 4A1A8D02D3E; Mon,  9 Sep 2019 17:56:55 +0100 (BST)
Date:   Mon, 9 Sep 2019 17:56:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Kauer <florian.kauer@koalo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Vinod Koul <vkoul@kernel.org>, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 00/10] Raspberry Pi SPI speedups
Message-ID: <20190909165655.GK2036@sirena.org.uk>
References: <cover.1564825752.git.lukas@wunner.de>
 <20190907090637.macdahajrzjepluc@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8jNwmpfkpox/fiJK"
Content-Disposition: inline
In-Reply-To: <20190907090637.macdahajrzjepluc@wunner.de>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--8jNwmpfkpox/fiJK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 07, 2019 at 11:06:37AM +0200, Lukas Wunner wrote:

> Just a gentle ping, this patch set was posted to the list 5 weeks ago,
> has all necessary acks and has been tested successfully by 2 people
> besides myself.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--8jNwmpfkpox/fiJK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl12hFQACgkQJNaLcl1U
h9AZAgf9HF8aiqKbT5IOAlR/2xEzTkcyzKvE3+zhPqm66Hxe168PWgGEEC5HVlSO
8bh2BYYDcdOby4OH46Z76DiQVK+WejzbnmK1Yh7NPeA1YrXQx2c6f6hWzL0NefLi
FciD1hOvUu9D69GQlbymHkFfioMiSCebi0qzvqjZHJ2FCKLQerB49PilwOAPBnvV
9XcOlsmPGUcXs6obLXUjtvcvzUA278s6SQ91/diATUNiSwkvxxVBJeb2cTx+T48l
SPVb8zTgEw5at6TF+p7MMsms2NJinkIT+mGjlSuyM/ZmEqu4xxQ1ps6KV4teaN7t
pg8xLVKBXypqLNryNpDnmf5zeAwRgw==
=WEZW
-----END PGP SIGNATURE-----

--8jNwmpfkpox/fiJK--
