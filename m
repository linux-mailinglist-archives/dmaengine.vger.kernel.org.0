Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FECF73987E
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jun 2023 09:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjFVHwi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Jun 2023 03:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjFVHwg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Jun 2023 03:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102C1210E;
        Thu, 22 Jun 2023 00:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C1EC61787;
        Thu, 22 Jun 2023 07:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C66C433C0;
        Thu, 22 Jun 2023 07:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687420343;
        bh=e9NKgW3oClf65wHR4jFOmp3+UsGr7YxDei5mvCWN0/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=kqihgs3ppcJWf2G4dcgyCAVIslHMHejpAq+er43v44mJ58HvXOd/87MuZrMNRSIaJ
         dzZkx9G3J2fMFjvm6JKXjxzR9VSlh894TP6vVMrS0iuxJ6FgejbN1tAOzPbceGORyM
         TQXU33JRziUcUIooDdCkQcCvRRPqpqAIljhsgY0Fmxtaw6qEZk8dMBtIdAHQWsABfL
         Sg1DaKrhV17anw+wcLRzrwC3GIfqaA1+OWXRCQQug5TSP5UDryUi9+1/pSgyTRQ6NI
         Gj4/oyqpS+xezpgHVtaa0SiydAky/D/Q0mRHfSOU0EFH+RR9hSQ1kZ+YB1TrZEITss
         1A67IYbfo2hDA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qCF7F-0000Ev-07; Thu, 22 Jun 2023 09:52:29 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] dmaengine: mediatek: drop bogus pm_runtime_set_active()
Date:   Thu, 22 Jun 2023 09:51:50 +0200
Message-Id: <20230622075150.885-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The runtime PM state must be updated while runtime PM is disabled for
the change to take effect.

Drop the bogus pm_runtime_set_active() which left the PM state set to
suspended (as it should be or the clock would not be enabled when the
device is resumed).

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/dma/mediatek/mtk-uart-apdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index a1517ef1f4a0..92864c9371a3 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -551,7 +551,6 @@ static int mtk_uart_apdma_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
 
 	rc = dma_async_device_register(&mtkd->ddev);
 	if (rc)
-- 
2.39.3

