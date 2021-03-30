Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE1C34EFBE
	for <lists+dmaengine@lfdr.de>; Tue, 30 Mar 2021 19:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhC3Rfo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 13:35:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59888 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhC3RfQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Mar 2021 13:35:16 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12UHYxnK057214;
        Tue, 30 Mar 2021 12:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617125699;
        bh=oyLcX4zTICMuRbzkOD5Koeq3zdkXhldkZIUq9vZlncE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=K3Fnejc+96F4eclc1c3BTPfDLQgBJ9yiRk/DwOasZw7fDdE3p3iyws4MCPoqmXXgb
         Xy9XQ9zCa3hrdxuRW9vfNzD5mEmTrVaXSDDRJLG/UM5c41bvXmHCjk0RYG2tCRLFGh
         DwAnmE8QqoaP8bn+/Nn/6qecf6suPEAdnLiEp3eQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12UHYxEV068748
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Mar 2021 12:34:59 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 30
 Mar 2021 12:34:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 30 Mar 2021 12:34:59 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12UHXmgr125244;
        Tue, 30 Mar 2021 12:34:53 -0500
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
Subject: [PATCH 10/16] media: cadence: csi2rx: Add wrappers for subdev calls
Date:   Tue, 30 Mar 2021 23:03:42 +0530
Message-ID: <20210330173348.30135-11-p.yadav@ti.com>
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

When this bridge driver is being user by another platform driver, it
might want to call subdev operations like getting format, setting
format, enumerating format codes, etc. Add wrapper functions that pass
that call through to the sensor.

Currently wrappers are added only for the ops used by TI's platform
driver. More can be added later as needed.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 77 ++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 3385e1bc213e..2e8bbc53cb8b 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -408,12 +408,89 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
 	return ret;
 }
 
+static int csi2rx_g_frame_interval(struct v4l2_subdev *subdev,
+				   struct v4l2_subdev_frame_interval *fi)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+
+	return v4l2_subdev_call(csi2rx->source_subdev, video, g_frame_interval,
+				fi);
+}
+
+static int csi2rx_s_frame_interval(struct v4l2_subdev *subdev,
+				   struct v4l2_subdev_frame_interval *fi)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+
+	return v4l2_subdev_call(csi2rx->source_subdev, video, s_frame_interval,
+				fi);
+}
+
+static int csi2rx_enum_mbus_code(struct v4l2_subdev *subdev,
+				 struct v4l2_subdev_pad_config *cfg,
+				 struct v4l2_subdev_mbus_code_enum *code)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+
+	return v4l2_subdev_call(csi2rx->source_subdev, pad, enum_mbus_code,
+				cfg, code);
+}
+
+static int csi2rx_get_fmt(struct v4l2_subdev *subdev,
+			  struct v4l2_subdev_pad_config *cfg,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+
+	return v4l2_subdev_call(csi2rx->source_subdev, pad, get_fmt, cfg, fmt);
+}
+
+static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
+			  struct v4l2_subdev_pad_config *cfg,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+
+	return v4l2_subdev_call(csi2rx->source_subdev, pad, set_fmt, cfg, fmt);
+}
+
+static int csi2rx_enum_frame_size(struct v4l2_subdev *subdev,
+				  struct v4l2_subdev_pad_config *cfg,
+				  struct v4l2_subdev_frame_size_enum *fse)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+
+	return v4l2_subdev_call(csi2rx->source_subdev, pad, enum_frame_size,
+				cfg, fse);
+}
+
+static int csi2rx_enum_frame_interval(struct v4l2_subdev *subdev,
+				      struct v4l2_subdev_pad_config *cfg,
+				      struct v4l2_subdev_frame_interval_enum *fie)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+
+	return v4l2_subdev_call(csi2rx->source_subdev, pad, enum_frame_interval,
+				cfg, fie);
+}
+
 static const struct v4l2_subdev_video_ops csi2rx_video_ops = {
 	.s_stream	= csi2rx_s_stream,
+	.g_frame_interval = csi2rx_g_frame_interval,
+	.s_frame_interval = csi2rx_s_frame_interval,
+};
+
+static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {
+	.enum_mbus_code = csi2rx_enum_mbus_code,
+	.get_fmt	= csi2rx_get_fmt,
+	.set_fmt	= csi2rx_set_fmt,
+	.enum_frame_size = csi2rx_enum_frame_size,
+	.enum_frame_interval = csi2rx_enum_frame_interval,
 };
 
 static const struct v4l2_subdev_ops csi2rx_subdev_ops = {
 	.video		= &csi2rx_video_ops,
+	.pad		= &csi2rx_pad_ops,
 };
 
 static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
-- 
2.30.0

