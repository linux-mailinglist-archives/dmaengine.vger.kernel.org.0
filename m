Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46C468CE69
	for <lists+dmaengine@lfdr.de>; Tue,  7 Feb 2023 05:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjBGE6t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Feb 2023 23:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjBGE6s (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Feb 2023 23:58:48 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACBF1CF57;
        Mon,  6 Feb 2023 20:58:47 -0800 (PST)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2B7BE3FE8A;
        Tue,  7 Feb 2023 04:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675745922;
        bh=PUCi1H9hv/sSXZlleZZ5Rb26bUcJ9yd3+X7lYe6SJEw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=oh3iBhgwPV2pXs9Y48EgmlW8x+dlcoun7XxYLrlER/xDhcECDzf7RD0DV9w1pkhHx
         Lr+3NNfTeVa2QrSIQxSCEUmE1OhflkdRTQ0lkJhtaO+h55KzGaMVLW3Vxn+Hw9KN1E
         TVU8u6sekyqSoSa21hWjgi/2pAnzevCyq/QbGtj1PSFoI3Uj8qyM4DiZWvh9d4hRpn
         b7fthwufoNM0J+g/Y61LQw2j2Tlyyi8+zsrVik7hNA5twREF0rQeQGy4IurVfFdeQE
         Hwig/6E4FG5UyLXlYg/s5+XILcHEU3vh1K8I4gbvQTrRjkCOMxAj5RZLiuWF5ywtww
         Bc7p6fmK67tqg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: imx-sdma: Set DMA channel to be private
Date:   Tue,  7 Feb 2023 12:57:45 +0800
Message-Id: <20230207045745.1029959-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If async-tx is loaded before device drivers that requires imx-sdma, the
dmaengine_get() routine from async-tx grabs all non-private channels,
so devices that require DMA fail to work.

So mark imx-sdma with DMA_PRIVATE to avoid such situation.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/dma/imx-sdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index b926abe4fa43a..b86cdab5c2683 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2234,6 +2234,7 @@ static int sdma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
 	dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
 	dma_cap_set(DMA_MEMCPY, sdma->dma_device.cap_mask);
+	dma_cap_set(DMA_PRIVATE, sdma->dma_device.cap_mask);
 
 	INIT_LIST_HEAD(&sdma->dma_device.channels);
 	/* Initialize channel parameters */
-- 
2.34.1

