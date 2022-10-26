Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C1660DEDE
	for <lists+dmaengine@lfdr.de>; Wed, 26 Oct 2022 12:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiJZKa1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Oct 2022 06:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJZKa0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Oct 2022 06:30:26 -0400
X-Greylist: delayed 592 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Oct 2022 03:30:26 PDT
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371D71C923
        for <dmaengine@vger.kernel.org>; Wed, 26 Oct 2022 03:30:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id CE1551863E64;
        Wed, 26 Oct 2022 13:20:30 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yaQttnF6dtwj; Wed, 26 Oct 2022 13:20:30 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 8443A1863E44;
        Wed, 26 Oct 2022 13:20:30 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9cvu4zaxbI_T; Wed, 26 Oct 2022 13:20:30 +0300 (MSK)
Received: from work-laptop.astralinux.ru (unknown [10.177.20.36])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 213401863DE1;
        Wed, 26 Oct 2022 13:20:30 +0300 (MSK)
From:   Andrew Chernyakov <acherniakov@astralinux.ru>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andrew Chernyakov <acherniakov@astralinux.ru>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] dmaengine: fsl-edma: fix potential NULL pointer dereference in fsl_edma_tx_status()
Date:   Wed, 26 Oct 2022 13:18:41 +0300
Message-Id: <20221026101841.35305-1-acherniakov@astralinux.ru>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

fsl_edma_desc_residue() dereferences fsl_chan->edesc, but it is checked
for NULL only in one of two places where fsl_edma_desc_residue() is
called from fsl_edma_tx_status().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrew Chernyakov <acherniakov@astralinux.ru>
---
 drivers/dma/fsl-edma-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.=
c
index a06a1575a2a5..fb712d85d556 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -330,7 +330,7 @@ enum dma_status fsl_edma_tx_status(struct dma_chan *c=
han,
 	if (fsl_chan->edesc && cookie =3D=3D fsl_chan->edesc->vdesc.tx.cookie)
 		txstate->residue =3D
 			fsl_edma_desc_residue(fsl_chan, vdesc, true);
-	else if (vdesc)
+	else if (fsl_chan->edesc && vdesc)
 		txstate->residue =3D
 			fsl_edma_desc_residue(fsl_chan, vdesc, false);
 	else
--=20
2.35.1
