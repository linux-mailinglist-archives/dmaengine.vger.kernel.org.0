Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECA16327D8
	for <lists+dmaengine@lfdr.de>; Mon, 21 Nov 2022 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiKUPYd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Nov 2022 10:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiKUPX7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Nov 2022 10:23:59 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A45F587
        for <dmaengine@vger.kernel.org>; Mon, 21 Nov 2022 07:23:56 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:4821:1ba5:2638:5c3a])
        by laurent.telenet-ops.be with bizsmtp
        id n3Pv280025WXlCv013Pvs5; Mon, 21 Nov 2022 16:23:55 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox8eI-0019Ch-LD; Mon, 21 Nov 2022 16:23:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox8eI-00BQ2H-5w; Mon, 21 Nov 2022 16:23:54 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
        Zhenfa Qiu <qiuzhenfa@hisilicon.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dmaengine: HISI_DMA should depend on ARCH_HISI
Date:   Mon, 21 Nov 2022 16:23:53 +0100
Message-Id: <363a1816d36cd3cf604d88ec90f97c75f604de64.1669044190.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The HiSilicon DMA Engine is only present on HiSilicon SoCs.  Hence add a
dependency on ARCH_HISI, to prevent asking the user about this driver
when configuring a kernel without HiSilicon SoC support.

Fixes: e9f08b65250d73ab ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index b9d54f20812f794b..67323afe9fcad137 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -245,7 +245,7 @@ config FSL_RAID
 
 config HISI_DMA
 	tristate "HiSilicon DMA Engine support"
-	depends on ARM64 || COMPILE_TEST
+	depends on ARCH_HISI || COMPILE_TEST
 	depends on PCI_MSI
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
-- 
2.25.1

