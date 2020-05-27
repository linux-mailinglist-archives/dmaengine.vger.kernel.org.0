Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880FE1E39AE
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2020 08:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgE0GxU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 May 2020 02:53:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48636 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgE0GxU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 May 2020 02:53:20 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04R6rHsJ060837;
        Wed, 27 May 2020 01:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590562397;
        bh=sQEm0FoRQ8P2PO9yiPvi3ynevxsGHkvnyhANbZ/i3R8=;
        h=From:To:CC:Subject:Date;
        b=pw0af0v0pBe5m8SOqCvZC96QQ4FDCZvHlk3RffpLFk+JGy46HuUCUKXAbX2fB+kZx
         oyeyG9A2UOSZeGL6MlDrQdg8cYtZlouRFJVrevIDn8gKvjQyiUzzXZ/mwKYBQSatn/
         SsWjrelihjODFXf0MhQSOIkASx0e22gat9FU0V/A=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04R6rHnU094528
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 May 2020 01:53:17 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 27
 May 2020 01:53:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 27 May 2020 01:53:17 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04R6rFEk033294;
        Wed, 27 May 2020 01:53:16 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Use correct node to read "ti,udma-atype"
Date:   Wed, 27 May 2020 09:53:57 +0300
Message-ID: <20200527065357.30791-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The "ti,udma-atype" property is expected in the UDMA node and not in the
parent navss node.

Fixes: 0ebcf1a274c5 ("dmaengine: ti: k3-udma: Implement support for atype (for virtualization)")

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c91e2dc1bb72..4bc470eb4143 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3593,7 +3593,7 @@ static int udma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = of_property_read_u32(navss_node, "ti,udma-atype", &ud->atype);
+	ret = of_property_read_u32(dev->of_node, "ti,udma-atype", &ud->atype);
 	if (!ret && ud->atype > 2) {
 		dev_err(dev, "Invalid atype: %u\n", ud->atype);
 		return -EINVAL;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

