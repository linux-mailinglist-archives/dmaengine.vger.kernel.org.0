Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F71A2D26F7
	for <lists+dmaengine@lfdr.de>; Tue,  8 Dec 2020 10:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgLHJFn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 04:05:43 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34354 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgLHJFl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Dec 2020 04:05:41 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B8941Qa002716;
        Tue, 8 Dec 2020 03:04:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607418241;
        bh=+pQy6U0jkrzMEECAhiPKxnJMhuVzQZnB8OzJ2+mEmWk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oz8ug/p50XF1+1ucVzpgJDjbDmFxfN8p2k2MGay2e6sVD9yAfO0t5J2v152OBKw7P
         1LXW7doRe/ltZUuSv3rubMLd8ndML9hI1Yagvqtmappe7Tx/ow/r9twnfLOMPi08iH
         KaNKF+TPRBN0p/Pxdm4gYaruWB2Wl5+lmJSD4qyo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B8941Zq043746
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 03:04:01 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 03:04:01 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 03:04:01 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B893dcA120112;
        Tue, 8 Dec 2020 03:03:57 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v3 05/20] dmaengine: ti: k3-udma-glue: Get the ringacc from udma_dev
Date:   Tue, 8 Dec 2020 11:04:25 +0200
Message-ID: <20201208090440.31792-6-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208090440.31792-1-peter.ujfalusi@ti.com>
References: <20201208090440.31792-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If of_xudma_dev_get() returns with the valid udma_dev then the driver
already got the ringacc, there is no need to execute
of_k3_ringacc_get_by_phandle() for each channel via the glue layer.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c    | 6 +-----
 drivers/dma/ti/k3-udma-private.c | 6 ++++++
 drivers/dma/ti/k3-udma.h         | 1 +
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 29d1524d1916..8a8988be4175 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -86,15 +86,11 @@ struct k3_udma_glue_rx_channel {
 static int of_k3_udma_glue_parse(struct device_node *udmax_np,
 				 struct k3_udma_glue_common *common)
 {
-	common->ringacc = of_k3_ringacc_get_by_phandle(udmax_np,
-						       "ti,ringacc");
-	if (IS_ERR(common->ringacc))
-		return PTR_ERR(common->ringacc);
-
 	common->udmax = of_xudma_dev_get(udmax_np, NULL);
 	if (IS_ERR(common->udmax))
 		return PTR_ERR(common->udmax);
 
+	common->ringacc = xudma_get_ringacc(common->udmax);
 	common->tisci_rm = xudma_dev_get_tisci_rm(common->udmax);
 
 	return 0;
diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index c9fb1d832581..0856721d0b04 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -56,6 +56,12 @@ struct device *xudma_get_device(struct udma_dev *ud)
 }
 EXPORT_SYMBOL(xudma_get_device);
 
+struct k3_ringacc *xudma_get_ringacc(struct udma_dev *ud)
+{
+	return ud->ringacc;
+}
+EXPORT_SYMBOL(xudma_get_ringacc);
+
 u32 xudma_dev_get_psil_base(struct udma_dev *ud)
 {
 	return ud->psil_base;
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index d1cace0cb43b..b4334b1b7b14 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -113,6 +113,7 @@ int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
 
 struct udma_dev *of_xudma_dev_get(struct device_node *np, const char *property);
 struct device *xudma_get_device(struct udma_dev *ud);
+struct k3_ringacc *xudma_get_ringacc(struct udma_dev *ud);
 void xudma_dev_put(struct udma_dev *ud);
 u32 xudma_dev_get_psil_base(struct udma_dev *ud);
 struct udma_tisci_rm *xudma_dev_get_tisci_rm(struct udma_dev *ud);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

