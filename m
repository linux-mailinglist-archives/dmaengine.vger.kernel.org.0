Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C12E7C967F
	for <lists+dmaengine@lfdr.de>; Sat, 14 Oct 2023 23:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjJNVRn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 14 Oct 2023 17:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjJNVRm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 14 Oct 2023 17:17:42 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC63CC
        for <dmaengine@vger.kernel.org>; Sat, 14 Oct 2023 14:17:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrm0l-0000TD-B3; Sat, 14 Oct 2023 23:17:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrm0i-001hon-FU; Sat, 14 Oct 2023 23:17:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrm0i-00GRLc-62; Sat, 14 Oct 2023 23:17:24 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>,
        Liu Shixin <liushixin2@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, "Simek, Michal" <michal.simek@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Subject: [PATCH] dmaengine: xilinx: xilinx_dma: Fix kernel doc about xilinx_dma_remove()
Date:   Sat, 14 Oct 2023 23:16:57 +0200
Message-ID: <20231014211656.1512016-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=E6kemoD588QU/owfzY4+Nq8vQhomgHowx5bXIc9aiz4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKwVJ06T6bAi892MRyKw4+DQBt2aYs2GBkqzwf 3493OjuIViJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSsFSQAKCRCPgPtYfRL+ TgEtCAC2ORfHlaxUKTLvim/3klDFLvUNH+ErrSB3LLScdjO5ArdSu5W9GIOc83Z6SGehkU9M8Ve tfvXb3ZJh/wjhBCXHOqBnlvaWeXpc7VKfe70PmTGnZxKz8LCdDrH9gvLJRw4uDVBmu3YmTiL28E +nLFSK0ehG+nIiwlECvYoTKOiRqox1tw/cpgux2aMwObWJK72a4+aU/FgvU5mCe79gfkZ28ojq6 PVyEkx/K4eD+VYwPnDR4Dh2X7P8rb8WWUaYLg4Qu+uMqO6r6oLs2DdDj/eyWSc2no3lPTfnr0tx 87rL7XJfJz2Anxf2CEjxx9qqVTOE/XjbQybJ4bdARSN8sYre
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since commit cc99582d46b4 ("dmaengine: xilinx: xilinx_dma: Convert to
platform remove callback returning void") xilinx_dma_remove() doesn't
return zero any more. As the function has no return value any more, just
drop the statement about the return value.

Reported-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

the wrong kernel doc comment was pointed out by Radhey Shyam Pandey
during review of the patch that became cc99582d46b4. Vinod Koul still
picked up the patch unmodified and asked for a follow up patch
(https://lore.kernel.org/all/ZRUvjz7oO6iK1HTm@matsya). Here it is.

Best regards
Uwe

 drivers/dma/xilinx/xilinx_dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 0c363a1ed853..e40696f6f864 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3242,8 +3242,6 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 /**
  * xilinx_dma_remove - Driver remove function
  * @pdev: Pointer to the platform_device structure
- *
- * Return: Always '0'
  */
 static void xilinx_dma_remove(struct platform_device *pdev)
 {

base-commit: cc99582d46b428ba4c2cb7ecd05df4569b02d1f4
-- 
2.42.0

