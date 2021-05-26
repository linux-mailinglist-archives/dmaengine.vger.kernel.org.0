Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2E7391BAA
	for <lists+dmaengine@lfdr.de>; Wed, 26 May 2021 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbhEZPZL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 May 2021 11:25:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59196 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhEZPZJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 May 2021 11:25:09 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QFNUZL001547;
        Wed, 26 May 2021 10:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622042610;
        bh=pEYv/cVE8dpSFqbeMd7nSL6UuSjcYO8ph/UZQDKS7+g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bscH4fWQadjdVVcQPI0Aq/PIEhgMbuTtGhCuPdWwCp1Hu3fuhly+Gniw9wXjTgsBz
         gpcoSVRRHuuXWgswp+blEYud8l/qBiIHKpgKXah4xybgeJPHjw8jl0EJ3af1LTDeVc
         kvCOXKMUNwunomPNs7kpPhYI648B0PvwY4h+H/BI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QFNUA5093201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 10:23:30 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 10:23:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 10:23:30 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QFN9Jb056314;
        Wed, 26 May 2021 10:23:25 -0500
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
Subject: [PATCH v2 03/18] phy: cdns-dphy: Allow setting mode
Date:   Wed, 26 May 2021 20:52:53 +0530
Message-ID: <20210526152308.16525-4-p.yadav@ti.com>
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

Allow callers to set the PHY mode. The main mode should always be
PHY_MODE_MIPI_DPHY but the submode can either be
PHY_MIPI_DPHY_SUBMODE_RX or PHY_MIPI_DPHY_SUBMODE_TX. Update the ops
based on the requested submode.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---

(no changes since v1)

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

