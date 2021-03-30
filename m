Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFEB34EFAC
	for <lists+dmaengine@lfdr.de>; Tue, 30 Mar 2021 19:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhC3RfO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 13:35:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53184 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbhC3Rex (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Mar 2021 13:34:53 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12UHYYdR080831;
        Tue, 30 Mar 2021 12:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617125674;
        bh=e0p31IW0rH6YdPTwIarvDVW5qoY2qL7bTzo3pAqOwkc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CetWVJkiPzgFFaHLdUSCdCvyAAgQ8CWmMvx3M/Tqq9z9JIQr+Uomq32d727kSTaKS
         goiAU23mNqq1EBPmtcg7PTbQtLvd1Fptxq28mRLVYQ3VgjQj/jcvlg+lkbwI3XaFdS
         XpkWeaqJp93g9uqvhQ3eBDgYRk2DkoL8YY1I5lf0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12UHYXA5025861
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Mar 2021 12:34:33 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 30
 Mar 2021 12:34:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 30 Mar 2021 12:34:33 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12UHXmgn125244;
        Tue, 30 Mar 2021 12:34:27 -0500
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
Subject: [PATCH 06/16] media: cadence: csi2rx: Soft reset the streams before starting capture
Date:   Tue, 30 Mar 2021 23:03:38 +0530
Message-ID: <20210330173348.30135-7-p.yadav@ti.com>
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

This resets the stream state machines and FIFOs, giving them a clean
slate. On J721E if the streams are not reset before starting the
capture, the captured frame gets wrapped around vertically on every run
after the first.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 31bd80e3f780..b03d2d2e6762 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -39,6 +39,7 @@
 #define CSI2RX_STREAM_BASE(n)		(((n) + 1) * 0x100)
 
 #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
+#define CSI2RX_STREAM_CTRL_SOFT_RST			BIT(4)
 #define CSI2RX_STREAM_CTRL_START			BIT(0)
 
 #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
@@ -150,12 +151,22 @@ struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
 
 static void csi2rx_reset(struct csi2rx_priv *csi2rx)
 {
+	int i;
+
 	writel(CSI2RX_SOFT_RESET_PROTOCOL | CSI2RX_SOFT_RESET_FRONT,
 	       csi2rx->base + CSI2RX_SOFT_RESET_REG);
 
 	udelay(10);
 
 	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
+
+	/* Reset individual streams. */
+	for (i = 0; i < csi2rx->max_streams; i++) {
+		writel(CSI2RX_STREAM_CTRL_SOFT_RST,
+		       csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
+		usleep_range(10, 20);
+		writel(0, csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
+	}
 }
 
 static int csi2rx_configure_external_dphy(struct csi2rx_priv *csi2rx)
-- 
2.30.0

