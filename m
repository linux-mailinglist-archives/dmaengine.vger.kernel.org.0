Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486714CBE1D
	for <lists+dmaengine@lfdr.de>; Thu,  3 Mar 2022 13:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiCCMsG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Mar 2022 07:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiCCMsF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Mar 2022 07:48:05 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF14E184B48
        for <dmaengine@vger.kernel.org>; Thu,  3 Mar 2022 04:47:19 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6495:14e6:1343:3ecb])
        by laurent.telenet-ops.be with bizsmtp
        id 1onJ270075ER6nL01onJhh; Thu, 03 Mar 2022 13:47:18 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nPkrV-002XsA-NL; Thu, 03 Mar 2022 13:47:17 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nPkrU-008DDw-Pk; Thu, 03 Mar 2022 13:47:16 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dmaengine: fsl-dpaa2-qdma: Drop comma after SoC match table sentinel
Date:   Thu,  3 Mar 2022 13:47:15 +0100
Message-Id: <0b8ad4dcc185aa7a17655983e0eb5690d8fed460.1646311558.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It does not make sense to have a comma after a sentinel, as any new
elements must be added before the sentinel.

Add a comment to clarify the purpose of the empty element.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
index 7d571849c569cb32..03e2f4e0baca83d2 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
@@ -139,7 +139,7 @@ struct dpaa2_qdma_priv_per_prio {
 
 static struct soc_device_attribute soc_fixup_tuning[] = {
 	{ .family = "QorIQ LX2160A"},
-	{ },
+	{ /* sentinel */ }
 };
 
 /* FD pool size: one FD + 3 Frame list + 2 source/destination descriptor */
-- 
2.25.1

