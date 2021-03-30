Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AA934EF99
	for <lists+dmaengine@lfdr.de>; Tue, 30 Mar 2021 19:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhC3Rem (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 13:34:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59616 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhC3Red (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Mar 2021 13:34:33 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12UHYEB8057026;
        Tue, 30 Mar 2021 12:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617125654;
        bh=1pR43CdbgvQt4BcjIFxp/YBsY0FByo4R7bLIiRN2yqQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IixW8RHl+OxFGXLIFDSqgn/T5bdagn3IUcv678zOw27hTEkj1CPbRVpzy+dEce+Kt
         zmwOcyIyYoUCvaGu9iac+i47FuJpW2YTJAY0qVeLz6uY591y7WNzWV8kz1FBltUJVA
         ovsLBjhZGJS/l1O7ZDsB/1IZNdplMwmKOuo8GOuE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12UHYEv8039233
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Mar 2021 12:34:14 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 30
 Mar 2021 12:34:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 30 Mar 2021 12:34:14 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12UHXmgk125244;
        Tue, 30 Mar 2021 12:34:08 -0500
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
Subject: [PATCH 03/16] phy: cdns-dphy: Allow setting mode
Date:   Tue, 30 Mar 2021 23:03:35 +0530
Message-ID: <20210330173348.30135-4-p.yadav@ti.com>
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

Allow callers to set the PHY mode. The main mode should always be
PHY_MODE_MIPI_DPHY but the submode can either be
PHY_MIPI_DPHY_SUBMODE_RX or PHY_MIPI_DPHY_SUBMODE_TX. Update the ops
based on the requested submode.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/phy/cadence/cdns-dphy.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index 8656f2102a91..7d5f7b333893 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -365,11 +365,41 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	return 0;
 }
 
+static int cdns_dphy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct cdns_dphy *dphy = phy_get_drvdata(phy);
+	const struct cdns_dphy_driver_data *ddata;
+
+	ddata = of_device_get_match_data(dphy->dev);
+	if (!ddata)
+		return -EINVAL;
+
+	if (mode != PHY_MODE_MIPI_DPHY)
+		return -EINVAL;
+
+	if (submode == PHY_MIPI_DPHY_SUBMODE_TX) {
+		if (!ddata->tx)
+			return -EOPNOTSUPP;
+
+		dphy->ops = ddata->tx;
+	} else if (submode == PHY_MIPI_DPHY_SUBMODE_RX) {
+		if (!ddata->rx)
+			return -EOPNOTSUPP;
+
+		dphy->ops = ddata->rx;
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static const struct phy_ops cdns_dphy_ops = {
 	.configure	= cdns_dphy_configure,
 	.validate	= cdns_dphy_validate,
 	.power_on	= cdns_dphy_power_on,
 	.power_off	= cdns_dphy_power_off,
+	.set_mode	= cdns_dphy_set_mode,
 };
 
 static int cdns_dphy_probe(struct platform_device *pdev)
-- 
2.30.0

