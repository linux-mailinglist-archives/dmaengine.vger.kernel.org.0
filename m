Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 104AD89AC7
	for <lists+dmaengine@lfdr.de>; Mon, 12 Aug 2019 12:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfHLKGN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Aug 2019 06:06:13 -0400
Received: from ozlabs.org ([203.11.71.1]:57991 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbfHLKGM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Aug 2019 06:06:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 466WhK6QxWz9sN1;
        Mon, 12 Aug 2019 20:06:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565604370;
        bh=iqB1LVYeaEpnmcXmOoPdhBF8HxreRVomAaxJjtwya2E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mQwxLC2HNy7DVGPJkkE/aOR73lZKPaOSCqqoERPfR42rl+P9XQcbouR2puhm1Fqey
         sW3vGdRuOvcOf0nqFH0NvSLvVDG8g+2vjrclHGwmsOogqRSSyxALjBqJBOTIoCKy6P
         2+nswUn3rpjGU6o+nXTbiXorDcPTy4yAxXZUGyxVnsWXCvY/FuV7Yhq+LTnbyTNFIw
         Wk56BA+uquL+8v9i8FjY5mt9J9VWsAELGeiSBo0j98ubRb0enrI6/ummMRI4M8WN+w
         siizPG6tqj30bw1pAu6u+q48ZIeP0GDXdos8q517z4q0yXJy6989xGqCUbvRh5LBL3
         5KZC66ef1pZSA==
Date:   Mon, 12 Aug 2019 20:06:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: ti: unexport filter functions
Message-ID: <20190812200607.6ac1ab09@canb.auug.org.au>
In-Reply-To: <20190812093623.992757-1-arnd@arndb.de>
References: <20190812093623.992757-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0CO=r8YnSAbj=0kxeaVWCKS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--Sig_/0CO=r8YnSAbj=0kxeaVWCKS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Just a nit.

On Mon, 12 Aug 2019 11:36:03 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> The two filter functions are now marked stable, but still exported,
                                          ^^^^^^
static ...

--=20
Cheers,
Stephen Rothwell

--Sig_/0CO=r8YnSAbj=0kxeaVWCKS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1ROg8ACgkQAVBC80lX
0Gz1xwf9GGNXlG54PTj7UkR/zWsjuxUMRGFmp0x/w490cWeQK+q1uyRqR9/etbqm
/yjR8pq/AzUAW3pxQWimCOZzZhbSEVy2cDr5uJEM/DYinYoU4aK63i8YPP4ZCcvM
lVwIdgqfL+01TpT7QEV0io5NWvGUVTgNb58Mprb3f7CyE7Idp6N1K7Ib2k29GIkw
PvsxGCGEkY0XSjEKU1jfapRf6cbck4U9icWtAinJUjR3n7mi2YCk7MWe3XHnFkcj
rpR6EeF+HKJAQ0rO87clq0ICB+1y5+QFSPiyRMeIKN6T6Izy+3d4fh/lOmu53sVb
TImghilme58cxoToyDEvVugFktiUyA==
=KUm0
-----END PGP SIGNATURE-----

--Sig_/0CO=r8YnSAbj=0kxeaVWCKS--
