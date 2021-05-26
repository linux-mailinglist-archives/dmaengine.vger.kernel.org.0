Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE522391BA0
	for <lists+dmaengine@lfdr.de>; Wed, 26 May 2021 17:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhEZPZA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 May 2021 11:25:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57164 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbhEZPY6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 May 2021 11:24:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QFNKSo076748;
        Wed, 26 May 2021 10:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622042600;
        bh=tiiN7makazoom7pCtyD0iCir4iR2Oy+IqqShZdnezTE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=I3O+BFF7WXi1/Usorz2skRjQlEDLzU/xcXlr1fe6iT2SiBznJ+9ppkUW+dCVzK5h4
         l+xn9qiMsUA9v9eFVBmdDDaWaDVe7vUJmO+OJivOYJGU0N1Y3wdlFfCotQzp4LiJCl
         zlTfO+TjALGUe1mMVIA2C0czqvVgY2p5j3g2Srt8=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QFNKUI078202
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 10:23:20 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 10:23:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 10:23:19 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QFN9JZ056314;
        Wed, 26 May 2021 10:23:15 -0500
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
Subject: [PATCH v2 01/18] phy: Distinguish between Rx and Tx for MIPI D-PHY with submodes
Date:   Wed, 26 May 2021 20:52:51 +0530
Message-ID: <20210526152308.16525-2-p.yadav@ti.com>
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

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

As some D-PHY controllers support both Rx and Tx mode, we need a way for
users to explicitly request one or the other. For instance, Rx mode can
be used along with MIPI CSI-2 while Tx mode can be used with MIPI DSI.

Introduce new MIPI D-PHY PHY submodes to use with PHY_MODE_MIPI_DPHY.
The default (zero value) is kept to Tx so only the rkisp1 driver, which
uses D-PHY in Rx mode, needs to be adapted.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---

(no changes since v1)

 include/linux/phy/phy-mipi-dphy.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/phy/phy-mipi-dphy.h b/include/linux/phy/phy-mipi-dphy.h
index a877ffee845d..0f57ef46a8b5 100644
--- a/include/linux/phy/phy-mipi-dphy.h
+++ b/include/linux/phy/phy-mipi-dphy.h
@@ -6,6 +6,19 @@
 #ifndef __PHY_MIPI_DPHY_H_
 #define __PHY_MIPI_DPHY_H_
 
+/**
+ * enum phy_mipi_dphy_submode - MIPI D-PHY sub-mode
+ *
+ * A MIPI D-PHY can be used to transmit or receive data.
+ * Since some controllers can support both, the direction to enable is specified
+ * with the PHY sub-mode. Transmit is assumed by default with phy_set_mode.
+ */
+
+enum phy_mipi_dphy_submode {
+	PHY_MIPI_DPHY_SUBMODE_TX = 0,
+	PHY_MIPI_DPHY_SUBMODE_RX,
+};
+
 /**
  * struct phy_configure_opts_mipi_dphy - MIPI D-PHY configuration set
  *
-- 
2.30.0

