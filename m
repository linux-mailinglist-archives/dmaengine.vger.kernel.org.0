Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE206DFBF1
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 18:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjDLQ4O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 12:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjDLQ4N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 12:56:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF78A729D;
        Wed, 12 Apr 2023 09:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA9D6631EE;
        Wed, 12 Apr 2023 16:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CDAC433EF;
        Wed, 12 Apr 2023 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681318501;
        bh=ut+9zKLRjX+MsVAyakcnRhLhXAlTYjnQGu1Y4AZSi7c=;
        h=Date:From:To:Cc:Subject:From;
        b=Nsa2K5wTsw+L5kWNkQxzBrt77qVWU/FH19fHyIGSf2xQkkeEPvf119Ie50/AsIap3
         XtagNJwD5B0jmanvO6FqgYgpj2ynchDg4XOjdrEFAKgW+imDV4mshYXZoSIXKWuFsn
         XOZnw3I43EFkFPVE0WD82GQL4NCAY3xD5z6h58x3sz3DKjuQnkVHZ+Dt2PGweQmMcn
         aElWx7deAB50EbRwFpnsrQbZxjrI2WbxENejqOSl6MzdrUY1eumReDC7jP3W4pZWJS
         ojxxLsJoDCixFdnMOCo1PZzBjuEmahErdj/c0tMQLtq6tmZYYx6PexXbPkV0BhmmU4
         MXrF06eUfL3Eg==
Date:   Wed, 12 Apr 2023 22:24:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v6.3
Message-ID: <ZDbiYVOQFNzdnq24@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="15JBCVxE94na5Eta"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--15JBCVxE94na5Eta
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus

Please pull couple of fixes in apple driver, core and kernedoc fix for
dmaengine subsystem for v6.3

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.3

for you to fetch changes up to d9503be5a100c553731c0e8a82c7b4201e8a970c:

  dmaengine: apple-admac: Fix 'current_tx' not getting freed (2023-03-31 18=
:17:21 +0530)

----------------------------------------------------------------
dmaengine fixes for v6.3

- apple admac driver fixes for current_tx, src_addr_widths and global'
  interrupt flags handling
- xdma kerneldoc fix
- core fix for use of devm_add_action_or_reset

----------------------------------------------------------------
Andy Shevchenko (1):
      dmaengine: Actually use devm_add_action_or_reset()

Martin Povi=C5=A1er (3):
      dmaengine: apple-admac: Handle 'global' interrupt flags
      dmaengine: apple-admac: Set src_addr_widths capability
      dmaengine: apple-admac: Fix 'current_tx' not getting freed

Yang Li (1):
      dmaengine: xilinx: xdma: Fix some kernel-doc comments

 drivers/dma/apple-admac.c | 20 +++++++++++++++++---
 drivers/dma/dmaengine.c   |  2 +-
 drivers/dma/xilinx/xdma.c |  2 +-
 3 files changed, 19 insertions(+), 5 deletions(-)

--=20
~Vinod

--15JBCVxE94na5Eta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmQ24mAACgkQfBQHDyUj
g0dLbhAAkZIGIihQhXrP3aquxAkAhs7uQ3138boXX5bfipVxcKfVgiFZRBnjx5Z4
XRzVqzmk4xTqZkwMwtIpGt76UsmLC7KqRIrJ3/gZbZUhS1CMSnLlgSpZSnRNN0Wl
BEO/L1NA4QBdIqzss5EjA/H5yH5f4ghIRzvvdWghIqFuXNw7IChjMOvff/AmD+Ra
0OXhfoQeKo70mpjvtVYIcgZXW6lDQhusIH7rhMoBn54N/9VQUHCO3EiewexqW0+1
xke9sJTKOuQqeh1ykceyhdTkYxaBKwHMGCa3AupWGr2qgmp2mm7pL7NgA4TOkPzD
/g31L6gNOjUMMtZQLBfe1/3YGnHNsuMJr8NnuDXXYGfdYFUyvZ/nF7iDLY8RyUMW
q80UC4PAltw2ytiwy2RXvsd/+qEJma1cjdhXSWgbUfOLF6hhpVB1diyt85LxIYIh
poWBNHoe5LVW1rTY1Vyg9RDsaD9v0Ny7R6XTROg5mrbJagDklBdvZON7jzfuoXX1
X+Vl8QNT1keqiLP7zv9ESgB3f+MFu4EXL2FgSQCuBAfdh7Pxmt3AqE/aB2iS6gM/
cGz1os7LOCKbINUkHBtYtVsov0Fwztd5Y/ZCQSJW8EfXBVQPTE8dBTmNQbJNOn5E
tAksjmUdw8vrAPYlvEIG1kBYCiAxZo4+CEJthSAuhjSBlKzPlqk=
=YQNT
-----END PGP SIGNATURE-----

--15JBCVxE94na5Eta--
