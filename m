Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C155391BBF
	for <lists+dmaengine@lfdr.de>; Wed, 26 May 2021 17:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhEZPZo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 May 2021 11:25:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59266 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbhEZPZg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 May 2021 11:25:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QFNunq001704;
        Wed, 26 May 2021 10:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622042636;
        bh=MFL5nY0y6CtYd/l61tkEPdZ0D1+8IVPL7aElz6EnMA4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Uj9INjn22b1rqgbeLtJpFsN1fLD8onrYCL+xdViu8Y89oX1UqIFUW4pTq7faeiWpc
         MyladMF6n1mHhI4REQhWxCv0mHyqLNFxIXtVcK0+tJB/6eWHb9tpGA8kcrPGBgqTm9
         M0mC68JYwqIZnSAzQFtkfe8DlSW+CkgOClH08gnE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QFNu5J115312
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 10:23:56 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 10:23:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 10:23:55 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QFN9Jg056314;
        Wed, 26 May 2021 10:23:51 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <dmaengine@vger.kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 08/18] media: cadence: csi2rx: Set the STOP bit when stopping a stream
Date:   Wed, 26 May 2021 20:52:58 +0530
Message-ID: <20210526152308.16525-9-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210526152308.16525-1-p.yadav@ti.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The stream stop procedure says that the STOP bit should be set when the
stream is to be stopped, and then the ready bit in stream status
register polled to make sure the STOP operation is finished.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---

(no changes since v1)

 drivers/media/platform/cadence/cdns-csi2rx.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 80a50284e525..ecc43a618c34 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
@@ -40,8 +41,12 @@
 
 #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
 #define CSI2RX_STREAM_CTRL_SOFT_RST			BIT(4)
+#define CSI2RX_STREAM_CTRL_STOP				BIT(1)
 #define CSI2RX_STREAM_CTRL_START			BIT(0)
 
+#define CSI2RX_STREAM_STATUS_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x004)
+#define CSI2RX_STREAM_STATUS_RDY			BIT(31)
+
 #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
 #define CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT		BIT(31)
 #define CSI2RX_STREAM_DATA_CFG_VC_SELECT(n)		BIT((n) + 16)
@@ -336,12 +341,23 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 {
 	unsigned int i;
+	u32 val;
+	int ret;
 
 	clk_prepare_enable(csi2rx->p_clk);
 	clk_disable_unprepare(csi2rx->sys_clk);
 
 	for (i = 0; i < csi2rx->max_streams; i++) {
-		writel(0, csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
+		writel(CSI2RX_STREAM_CTRL_STOP,
+		       csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
+
+		ret = readl_relaxed_poll_timeout(csi2rx->base +
+						 CSI2RX_STREAM_STATUS_REG(i),
+						 val,
+						 (val & CSI2RX_STREAM_STATUS_RDY),
+						 10, 10000);
+		if (ret)
+			dev_warn(csi2rx->dev, "Failed to stop stream%d\n", i);
 
 		clk_disable_unprepare(csi2rx->pixel_clk[i]);
 	}
-- 
2.30.0

