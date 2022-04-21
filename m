Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AD3509FF4
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 14:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385577AbiDUMuI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 08:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385569AbiDUMuH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 08:50:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E2D32059;
        Thu, 21 Apr 2022 05:47:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAFAEB82293;
        Thu, 21 Apr 2022 12:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E266EC385A5;
        Thu, 21 Apr 2022 12:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650545235;
        bh=UcQO2s3LFwB24HB203UWRaa916KVKDAPA2bum0jrpc4=;
        h=Date:From:To:Cc:Subject:From;
        b=R7beJJ2o0zop79DQR1f+UbtCD11yR8gBGKvpCJLoJE/nMNl0GlhnVeDWDeonVDuOF
         yke27azpRE3Ub9kmnzUxrZAjKBUoLEgWILu/wgXgOW3ND0+0MUe6YEBrvWxQ09kP1u
         q8tr63py9kKxJTOXaR19kT+7WhpTyRfxDBzEkFxyZiMRez3tMqmA8Mh6Q2u9VNRECv
         IOkCQdSvairDgghDeGbgwKCilr5T1vICYdH/0716vfI7kftADKY9D3EpLEswKEvv4B
         3ORpcMSvMM2lZ/WZF48+hN4CKg5RJDcArz1Njk+SDAfQJ/cj8zgyuVRQtD1QwyujhM
         DvZytEy+g7c8Q==
Date:   Thu, 21 Apr 2022 18:17:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v5.18
Message-ID: <YmFST5F0AdoaM7om@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j9vAgKPCw9M1b6nK"
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--j9vAgKPCw9M1b6nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive the dmanegine fixes for v5.18. This contains
bunch of driver fixes.

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-5.18

for you to fetch changes up to 7495a5bbf89f68c8880757c112fd0994f5dba309:

  dt-bindings: dmaengine: qcom: gpi: Add minItems for interrupts (2022-04-2=
0 18:11:20 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.17

Bunch of driver fixes for:
 - idxd device RO checks and device cleanup
 - dw-edma unaligned access and alignment
 - qcom: missing minItems in binding
 - mediatek pm usage fix
 - imx init script

----------------------------------------------------------------
Dave Jiang (6):
      dmaengine: idxd: fix device cleanup on disable
      dmaengine: idxd: match type for retries var in idxd_enqcmds()
      dmaengine: idxd: fix retry value to be constant for duration of funct=
ion call
      dmaengine: idxd: add RO check for wq max_batch_size write
      dmaengine: idxd: add RO check for wq max_transfer_size write
      dmaengine: idxd: skip clearing device context when device is read-only

Herve Codina (1):
      dmaengine: dw-edma: Fix unaligned 64bit access

Jiapeng Chong (1):
      dmaengine: dw-edma: Fix inconsistent indenting

Kevin Groeneveld (1):
      dmaengine: imx-sdma: fix init of uart scripts

Miaoqian Lin (1):
      dmaengine: imx-sdma: Fix error checking in sdma_event_remap

Vinod Koul (1):
      dt-bindings: dmaengine: qcom: gpi: Add minItems for interrupts

Xiaomeng Tong (1):
      dma: at_xdmac: fix a missing check on list iterator

zhangqilong (1):
      dmaengine: mediatek:Fix PM usage reference leak of mtk_uart_apdma_all=
oc_chan_resources

 .../devicetree/bindings/dma/qcom,gpi.yaml          |  1 +
 drivers/dma/at_xdmac.c                             | 12 ++++----
 drivers/dma/dw-edma/dw-edma-v0-core.c              | 16 +++++++----
 drivers/dma/idxd/device.c                          |  6 ++--
 drivers/dma/idxd/submit.c                          |  5 ++--
 drivers/dma/idxd/sysfs.c                           |  6 ++++
 drivers/dma/imx-sdma.c                             | 32 +++++++++++-------=
----
 drivers/dma/mediatek/mtk-uart-apdma.c              |  9 ++++--
 8 files changed, 53 insertions(+), 34 deletions(-)

--=20
~Vinod

--j9vAgKPCw9M1b6nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmJhUk4ACgkQfBQHDyUj
g0ejww//Z7azCwLVGY4hQ8uzjaD+T3SBidzeVMyNBzVarx61OUycGfb6c4Jikno9
HaE6vWKfDz7fVEYqHUFVn3N4ic59dCJ1VZtAYGfDb2W8wHVVJNmYkR/YyQglHTgt
3sdrh45nGlzS788ygXczFSUxQI2tIyOVsG0pDMLcdqDZD4ttI+TY/xVVvXP2kfe6
0ZmlYkckJFAErnHwB2VFzv+tdNuCz7QIXXPo1iySl84IoIZOuhyctp0+Qsgxw7RT
GV99Dge55WB+ro7nqtvi02IA4KVRQ230Libbxxr2yALo4Lsnt60TTVfHCY9uuzLi
2Sp2EsDVRtTDGY0h56rf/T2dR0Uaf+jrJl8fZ7MGu5iz76ZfIzUAGBJ3w4P0bHdL
0qA5pDa/q6i8YnTWMn2uD3wI/z6L+gRRmVMZpqT12BenDPRuk6DAnfW5cq+QuDEV
jWPzzaIbU9dEycAmJrGuEwCKHdGfahd+P66QMHk/jrTpAVxXWQUiFipSU+VuVYD0
ZQ9VeaE5RmubDBDff1SUAn/B+UDmo0GxZPQrfF9ACaXDfrx1rmrfMNcmu/ARJdAv
PK+TmVhoaU/r94pJcu0/IwyUETlR1d0BNKXrqzz1hiBuIy0kEewGT69fkHYKxyzl
YEb8rR6440aIRE6Srbo4bqO5JQbzGaHbp+/4oirNMV8ATMWF5Wc=
=1GRt
-----END PGP SIGNATURE-----

--j9vAgKPCw9M1b6nK--
