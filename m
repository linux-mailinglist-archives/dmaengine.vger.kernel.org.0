Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF734EFB3
	for <lists+dmaengine@lfdr.de>; Tue, 30 Mar 2021 19:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhC3RfR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 13:35:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53224 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhC3RfE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Mar 2021 13:35:04 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12UHYkW8080852;
        Tue, 30 Mar 2021 12:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617125686;
        bh=nFwFKwKkm2Tg7mXODMtl1Qe24xGGc90Y5vckjfrUM3U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KhFXzFRXlc9hm2zgNKhDPSATD6M36w3Tw5uKUDqwCEwen3r5TN25+K0Wfg+unFRHt
         nJHKE2+HCRYvD6MvL8hy8kE6fnPdFXGFHH6YT0ahOaNEGMSGTZDXy+G46y/iHNIcyz
         okUWWe5uNkl0WNMsHr+GJnAaGdcJLnwow0CUckM8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12UHYkjW026148
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Mar 2021 12:34:46 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 30
 Mar 2021 12:34:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 30 Mar 2021 12:34:46 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12UHXmgp125244;
        Tue, 30 Mar 2021 12:34:40 -0500
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
Subject: [PATCH 08/16] media: cadence: csi2rx: Fix stream data configuration
Date:   Tue, 30 Mar 2021 23:03:40 +0530
Message-ID: <20210330173348.30135-9-p.yadav@ti.com>
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

Firstly, there is no VC_EN bit present in the STREAM_DATA_CFG register.
Bit 31 is part of the VL_SELECT field. Remove it completely.

Secondly, it makes little sense to enable ith virtual channel for ith
stream. Sure, there might be a use-case that demands it. But there might
also be a use case that demands all streams to use the 0th virtual
channel. Prefer this case over the former because it is less arbitrary
and also makes it very clear what the limitations of the current driver
is instead of giving a false impression that multiple virtual channels
are supported.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index eca65b157f59..7d1ac51e0698 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -48,7 +48,6 @@
 #define CSI2RX_STREAM_STATUS_RDY			BIT(31)
 
 #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
-#define CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT		BIT(31)
 #define CSI2RX_STREAM_DATA_CFG_VC_SELECT(n)		BIT((n) + 16)
 
 #define CSI2RX_STREAM_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x00c)
@@ -290,8 +289,11 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 		writel(CSI2RX_STREAM_CFG_FIFO_MODE_LARGE_BUF,
 		       csi2rx->base + CSI2RX_STREAM_CFG_REG(i));
 
-		writel(CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT |
-		       CSI2RX_STREAM_DATA_CFG_VC_SELECT(i),
+		/*
+		 * Enable one virtual channel. When multiple virtual channels
+		 * are supported this will have to be changed.
+		 */
+		writel(CSI2RX_STREAM_DATA_CFG_VC_SELECT(0),
 		       csi2rx->base + CSI2RX_STREAM_DATA_CFG_REG(i));
 
 		writel(CSI2RX_STREAM_CTRL_START,
-- 
2.30.0

