Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921E7391BBC
	for <lists+dmaengine@lfdr.de>; Wed, 26 May 2021 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbhEZPZb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 May 2021 11:25:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59224 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhEZPZa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 May 2021 11:25:30 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QFNjlc001649;
        Wed, 26 May 2021 10:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622042626;
        bh=04qShFIyM6B9mOQhNt6rswy+lIJPNXqB9tKAFIB3Jjk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rq1kdLiY4CA43vNDcJG2hKHv2REQNl5d3oSNT9Lf5GnLavQ6P96ybQ/8Bz5hWjEEM
         kO8nhgyE5cZdLf+fVSsxKeLHP9kgu8ZgUVPa4v/cGF3L//k1GU8nKme1f6DP6sFKnM
         nYm80XP36+2yU2dAo/noIBu+jA/DP0jXfvcO4rxI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QFNjDl093548
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 10:23:45 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 10:23:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 10:23:45 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QFN9Je056314;
        Wed, 26 May 2021 10:23:40 -0500
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
Subject: [PATCH v2 06/18] media: cadence: csi2rx: Add external DPHY support
Date:   Wed, 26 May 2021 20:52:56 +0530
Message-ID: <20210526152308.16525-7-p.yadav@ti.com>
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

Some platforms like TI's J721E can have the CSI2RX paired with an
external DPHY. Add support to enable and configure the DPHY using the
generic PHY framework.

Get the pixel rate and bpp from the subdev and pass them on to the DPHY
along with the number of lanes. All other settings are left to their
default values.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

---

Changes in v2:
- Use phy_pm_runtime_get_sync() and phy_pm_runtime_put() before making
  calls to set PHY mode, etc. to make sure it is ready.

 drivers/media/platform/cadence/cdns-csi2rx.c | 158 +++++++++++++++++--
 1 file changed, 148 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index c68a3eac62cd..459326de2eff 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -30,6 +30,12 @@
 #define CSI2RX_STATIC_CFG_DLANE_MAP(llane, plane)	((plane) << (16 + (llane) * 4))
 #define CSI2RX_STATIC_CFG_LANES_MASK			GENMASK(11, 8)
 
+#define CSI2RX_DPHY_LANE_CTRL_REG		0x40
+#define CSI2RX_DPHY_CL_RST			BIT(16)
+#define CSI2RX_DPHY_DL_RST(i)			BIT((i) + 12)
+#define CSI2RX_DPHY_CL_EN			BIT(4)
+#define CSI2RX_DPHY_DL_EN(i)			BIT(i)
+
 #define CSI2RX_STREAM_BASE(n)		(((n) + 1) * 0x100)
 
 #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
@@ -54,6 +60,11 @@ enum csi2rx_pads {
 	CSI2RX_PAD_MAX,
 };
 
+struct csi2rx_fmt {
+	u32				code;
+	u8				bpp;
+};
+
 struct csi2rx_priv {
 	struct device			*dev;
 	unsigned int			count;
@@ -85,6 +96,52 @@ struct csi2rx_priv {
 	int				source_pad;
 };
 
+static const struct csi2rx_fmt formats[] = {
+	{
+		.code	= MEDIA_BUS_FMT_YUYV8_2X8,
+		.bpp	= 16,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_UYVY8_2X8,
+		.bpp	= 16,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_YVYU8_2X8,
+		.bpp	= 16,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_VYUY8_2X8,
+		.bpp	= 16,
+	},
+};
+
+static u8 csi2rx_get_bpp(u32 code)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(formats); i++) {
+		if (formats[i].code == code)
+			return formats[i].bpp;
+	}
+
+	return 0;
+}
+
+static s64 csi2rx_get_pixel_rate(struct csi2rx_priv *csi2rx)
+{
+	struct v4l2_ctrl *ctrl;
+
+	ctrl = v4l2_ctrl_find(csi2rx->source_subdev->ctrl_handler,
+			      V4L2_CID_PIXEL_RATE);
+	if (!ctrl) {
+		dev_err(csi2rx->dev, "no pixel rate control in subdev: %s\n",
+			csi2rx->source_subdev->name);
+		return -EINVAL;
+	}
+
+	return v4l2_ctrl_g_ctrl_int64(ctrl);
+}
+
 static inline
 struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
 {
@@ -101,6 +158,66 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
 	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
 }
 
+static int csi2rx_configure_external_dphy(struct csi2rx_priv *csi2rx)
+{
+	union phy_configure_opts opts = { };
+	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
+	struct v4l2_subdev_format sd_fmt;
+	s64 pixel_rate;
+	int ret;
+	u8 bpp;
+	bool got_pm = true;
+
+	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+	sd_fmt.pad = 0;
+
+	ret = v4l2_subdev_call(csi2rx->source_subdev, pad, get_fmt, NULL,
+			       &sd_fmt);
+	if (ret)
+		return ret;
+
+	bpp = csi2rx_get_bpp(sd_fmt.format.code);
+	if (!bpp)
+		return -EINVAL;
+
+	pixel_rate = csi2rx_get_pixel_rate(csi2rx);
+	if (pixel_rate < 0)
+		return pixel_rate;
+
+	ret = phy_mipi_dphy_get_default_config(pixel_rate, bpp,
+					       csi2rx->num_lanes, cfg);
+	if (ret)
+		return ret;
+
+	ret = phy_pm_runtime_get_sync(csi2rx->dphy);
+	if (ret == -ENOTSUPP)
+		got_pm = false;
+	else if (ret)
+		return ret;
+
+	ret = phy_set_mode_ext(csi2rx->dphy, PHY_MODE_MIPI_DPHY,
+			       PHY_MIPI_DPHY_SUBMODE_RX);
+	if (ret)
+		goto out;
+
+	ret = phy_power_on(csi2rx->dphy);
+	if (ret)
+		goto out;
+
+	ret = phy_configure(csi2rx->dphy, &opts);
+	if (ret) {
+		/* Can't do anything if it fails. Ignore the return value. */
+		phy_power_off(csi2rx->dphy);
+		goto out;
+	}
+
+out:
+	if (got_pm)
+		phy_pm_runtime_put(csi2rx->dphy);
+
+	return ret;
+}
+
 static int csi2rx_start(struct csi2rx_priv *csi2rx)
 {
 	unsigned int i;
@@ -139,6 +256,17 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 	if (ret)
 		goto err_disable_pclk;
 
+	/* Enable DPHY clk and data lanes. */
+	if (csi2rx->dphy) {
+		reg = CSI2RX_DPHY_CL_EN | CSI2RX_DPHY_CL_RST;
+		for (i = 0; i < csi2rx->num_lanes; i++) {
+			reg |= CSI2RX_DPHY_DL_EN(csi2rx->lanes[i] - 1);
+			reg |= CSI2RX_DPHY_DL_RST(csi2rx->lanes[i] - 1);
+		}
+
+		writel(reg, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
+	}
+
 	/*
 	 * Create a static mapping between the CSI virtual channels
 	 * and the output stream.
@@ -169,10 +297,21 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 	if (ret)
 		goto err_disable_pixclk;
 
+	if (csi2rx->dphy) {
+		ret = csi2rx_configure_external_dphy(csi2rx);
+		if (ret) {
+			dev_err(csi2rx->dev,
+				"Failed to configure external DPHY: %d\n", ret);
+			goto err_disable_sysclk;
+		}
+	}
+
 	clk_disable_unprepare(csi2rx->p_clk);
 
 	return 0;
 
+err_disable_sysclk:
+	clk_disable_unprepare(csi2rx->sys_clk);
 err_disable_pixclk:
 	for (; i > 0; i--)
 		clk_disable_unprepare(csi2rx->pixel_clk[i - 1]);
@@ -200,6 +339,13 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 
 	if (v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, false))
 		dev_warn(csi2rx->dev, "Couldn't disable our subdev\n");
+
+	if (csi2rx->dphy) {
+		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
+
+		if (phy_power_off(csi2rx->dphy))
+			dev_warn(csi2rx->dev, "Couldn't power off DPHY\n");
+	}
 }
 
 static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
@@ -306,15 +452,6 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
 		return PTR_ERR(csi2rx->dphy);
 	}
 
-	/*
-	 * FIXME: Once we'll have external D-PHY support, the check
-	 * will need to be removed.
-	 */
-	if (csi2rx->dphy) {
-		dev_err(&pdev->dev, "External D-PHY not supported yet\n");
-		return -EINVAL;
-	}
-
 	clk_prepare_enable(csi2rx->p_clk);
 	dev_cfg = readl(csi2rx->base + CSI2RX_DEVICE_CFG_REG);
 	clk_disable_unprepare(csi2rx->p_clk);
@@ -339,7 +476,7 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
 	 * FIXME: Once we'll have internal D-PHY support, the check
 	 * will need to be removed.
 	 */
-	if (csi2rx->has_internal_dphy) {
+	if (!csi2rx->dphy && csi2rx->has_internal_dphy) {
 		dev_err(&pdev->dev, "Internal D-PHY not supported yet\n");
 		return -EINVAL;
 	}
@@ -460,6 +597,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev,
 		 "Probed CSI2RX with %u/%u lanes, %u streams, %s D-PHY\n",
 		 csi2rx->num_lanes, csi2rx->max_lanes, csi2rx->max_streams,
+		 csi2rx->dphy ? "external" :
 		 csi2rx->has_internal_dphy ? "internal" : "no");
 
 	return 0;
-- 
2.30.0

