Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F8134EFB5
	for <lists+dmaengine@lfdr.de>; Tue, 30 Mar 2021 19:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhC3RfS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 13:35:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59756 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbhC3RfK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Mar 2021 13:35:10 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12UHYqev057185;
        Tue, 30 Mar 2021 12:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617125692;
        bh=lbeVUbvAR4oductXBEoruja1yT2y8SvkHXqgYIrrklE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dBY1eZOMB8xhObsTadyWKSE+0DooNzUM5h+IMYv0KkpsU8YIuPLEvFlKKGPnyKlMI
         GVn78U7Hnk5X9pTndkOkUwMMYbnjciJ04HUm8trsH9n2BHYvqBkskyyUP3F+XWQaLD
         j4klMYe8qQZVVJPx+OjqECI5ctEwE1grlwl6rwXE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12UHYqPN032783
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Mar 2021 12:34:52 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 30
 Mar 2021 12:34:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 30 Mar 2021 12:34:52 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12UHXmgq125244;
        Tue, 30 Mar 2021 12:34:46 -0500
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
Subject: [PATCH 09/16] media: cadence: csi2rx: Turn subdev power on before starting stream
Date:   Tue, 30 Mar 2021 23:03:41 +0530
Message-ID: <20210330173348.30135-10-p.yadav@ti.com>
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

The subdevice power needs to be turned on before the stream is started.
Otherwise it might not be in the proper state to stream the data. Turn
it off when stopping the stream.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 7d1ac51e0698..3385e1bc213e 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -256,6 +256,10 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 
 	writel(reg, csi2rx->base + CSI2RX_STATIC_CFG_REG);
 
+	ret = v4l2_subdev_call(csi2rx->source_subdev, core, s_power, true);
+	if (ret && ret != -ENOIOCTLCMD)
+		goto err_disable_pclk;
+
 	ret = v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, true);
 	if (ret)
 		goto err_disable_pclk;
@@ -358,6 +362,10 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 	if (v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, false))
 		dev_warn(csi2rx->dev, "Couldn't disable our subdev\n");
 
+	ret = v4l2_subdev_call(csi2rx->source_subdev, core, s_power, false);
+	if (ret && ret != -ENOIOCTLCMD)
+		dev_warn(csi2rx->dev, "Couldn't power off subdev\n");
+
 	if (csi2rx->dphy) {
 		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
 
-- 
2.30.0

