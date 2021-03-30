Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E3B34EFC1
	for <lists+dmaengine@lfdr.de>; Tue, 30 Mar 2021 19:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhC3Rfp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 13:35:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59908 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhC3RfW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Mar 2021 13:35:22 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12UHZ5OJ057284;
        Tue, 30 Mar 2021 12:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617125705;
        bh=exPtfFP357uEoI265sBSxQidNZbHwCy+lm1TSU/QwUI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=klAWR/g0XSp2ekS+fjDS4+DVOXI4pDzmUIoimtLc7c0L+6GJkGkI4W5QVV4YyAdYq
         nXuwWpMbVPfG4qZHoQi0QnX2MW9BGKQxHI2xvhdwrPA+r5w7CguUyusI6IMQA+BZGC
         ISZjLeYLrwKpIce8XWLipZvfufACHZndR2k3KpLw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12UHZ5CD041024
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Mar 2021 12:35:05 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 30
 Mar 2021 12:35:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 30 Mar 2021 12:35:05 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12UHXmgs125244;
        Tue, 30 Mar 2021 12:34:59 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Helen Koike <helen.koike@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Peter Chen <peter.chen@nxp.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <dmaengine@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 11/16] dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
Date:   Tue, 30 Mar 2021 23:03:43 +0530
Message-ID: <20210330173348.30135-12-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210330173348.30135-1-p.yadav@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The CSI2RX subsystem uses PSI-L DMA to transfer frames to memory. It can
have up to 32 threads but the current driver only supports using one. So
add an entry for that one thread.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/dma/ti/k3-psil-j721e.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/ti/k3-psil-j721e.c b/drivers/dma/ti/k3-psil-j721e.c
index 7580870ed746..19ffa31e6dc6 100644
--- a/drivers/dma/ti/k3-psil-j721e.c
+++ b/drivers/dma/ti/k3-psil-j721e.c
@@ -58,6 +58,14 @@
 		},					\
 	}
 
+#define PSIL_CSI2RX(x)					\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_NATIVE,	\
+		},					\
+	}
+
 /* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
 static struct psil_ep j721e_src_ep_map[] = {
 	/* SA2UL */
@@ -138,6 +146,8 @@ static struct psil_ep j721e_src_ep_map[] = {
 	PSIL_PDMA_XY_PKT(0x4707),
 	PSIL_PDMA_XY_PKT(0x4708),
 	PSIL_PDMA_XY_PKT(0x4709),
+	/* CSI2RX */
+	PSIL_CSI2RX(0x4940),
 	/* CPSW9 */
 	PSIL_ETHERNET(0x4a00),
 	/* CPSW0 */
-- 
2.30.0

