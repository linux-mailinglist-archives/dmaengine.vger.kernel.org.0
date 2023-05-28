Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6352B713B23
	for <lists+dmaengine@lfdr.de>; Sun, 28 May 2023 19:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjE1RfP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 May 2023 13:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjE1RfO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 May 2023 13:35:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EACBD;
        Sun, 28 May 2023 10:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 760BD60DCB;
        Sun, 28 May 2023 17:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C97C433EF;
        Sun, 28 May 2023 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685295312;
        bh=6Z6VJwI0sWNnucIorQaDakhs3mwRrtOMYLt2wQN/ND8=;
        h=Date:From:To:Cc:Subject:From;
        b=KZbLQWA2A0Wjm+OB+aTfSM18T3lNQCevZOaj0XiiO2ro7LgMQFfooOoYxmrNOTQqM
         0bZLKE3OSAEvfFa40n50uKVb5VuhWm70mk509BvtRrAxC9aVNKPZz+VKMhS8QZECC2
         wmNOI9J62iDGavLu5aBVpkyapDYGUneivEqnMYGuOH2T1GLO9pQhvXjdFnlDJ7uGll
         qALRDbvNdSYKMp4IhQf7cIX5MDxcIXtPEPBkSrtmahxwD/fq9r3+j9yyiZOUxcfQPb
         ZGVl1MrZ7lb4scdoHyxK7gG7j5w+HK/QzkYamTkCqMhkp7wgAHZn9FtjOkwtxykn1U
         TFL1RvlE7GxhQ==
Date:   Sun, 28 May 2023 23:05:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v6.4
Message-ID: <ZHOQzA0H/foJoyN+@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bLxf+Rd2pEyaeh+e"
Content-Disposition: inline
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--bLxf+Rd2pEyaeh+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive fixes for v6.4. This contains driver fixes for
at-hdmac, pl330, TI and IDXD drivers

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.4

for you to fetch changes up to e14fd2af7a1d621c167dad761f729135a7a76ff4:

  dmaengine: at_hdmac: Extend the Flow Controller bitfield to three bits (2=
023-05-24 11:20:28 +0530)

----------------------------------------------------------------
dmaengine fixes for v6.4

- AT HDMAC driver fixes for Flow Controller bitfield, peripheral ID
  handling and potential NULL dereference check
- PL330 function rename to avoid conflicts
- build warning fix for pm function in TI driver
- IDXD driver fix for passing freed memory

----------------------------------------------------------------
Dan Carpenter (1):
      dmaengine: at_xdmac: fix potential Oops in at_xdmac_prep_interleaved()

Harshit Mogalapalli (1):
      dmaengine: idxd: Fix passing freed memory in idxd_cdev_open()

Peter Rosin (2):
      dmaengine: at_hdmac: Repair bitfield macros for peripheral ID handling
      dmaengine: at_hdmac: Extend the Flow Controller bitfield to three bits

Randy Dunlap (1):
      dmaengine: pl330: rename _start to prevent build error

Vinod Koul (1):
      dmaengine: ti: k3-udma: annotate pm function with __maybe_unused

 drivers/dma/at_hdmac.c   | 17 ++++++++++-------
 drivers/dma/at_xdmac.c   |  7 +++++--
 drivers/dma/idxd/cdev.c  |  1 -
 drivers/dma/pl330.c      |  8 ++++----
 drivers/dma/ti/k3-udma.c |  4 ++--
 5 files changed, 21 insertions(+), 16 deletions(-)
--=20
~Vinod

--bLxf+Rd2pEyaeh+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmRzkMwACgkQfBQHDyUj
g0e/VBAAu/0lNeKT2mpwL4yqGWapL/cbMXKBkWv+7huNqAhJy0xH/F0qlclbaRpk
mnbc9VwT9mQzPKJF5aaewXnVNtDNAsmhcY8zKAPW2VrQtctIotomuuAH1Y7bnVHa
67dVoyXwDkjgVNH+DjY7y/sY/HkAmu7P82omvJjv10Zm4rIfrqK4cP81+7Jxtn25
gwLuc+GnMUkKsgjxbIeBDq3NffLDaJ4zxLNI9zO17qxOQd5FXL914wVaQZoI035I
lj5VbIcU4jSi6qh4OKYmWl5gxeNVUUgHtdKLwD5CUSBLPHVsUehGJLbZYqpmBP5r
hzCAmCLGDfSE1eLHY2RhlsJCi2NwQ3joRkNTJar7pZfy97PKjXxavyUney2wbxED
cxcWFyYV44qZpVX46Hh05PcWOoS0PYO/ZWOlsZARJH/OcY8l0Am+pc6KsDgdFk6S
TGAyv+zWHn7XUrZkVzDtLpsm3cXZQKxtf1o5B6BK56oTTJSzxmF6xtOqtYiW7ifL
6psb+TwM0b0Xfw9zuQJ8Qm4eTZy8HlIBkTMeIJ5HLmLtXehlKwkrWjlYAEjgZvFP
MCpoBFJNs4BDPlgzvbkbH6F0iPT0mb6G5n1Yn5AkXzVnqa5Kzljfa2k1mKLl6UMt
n9IldDhm8Z+huzvf/PGMM+NREgkrZ83EMGYrbx4ExeO9le0iY40=
=r69U
-----END PGP SIGNATURE-----

--bLxf+Rd2pEyaeh+e--
