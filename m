Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F3A19593B
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2020 15:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgC0OmV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Mar 2020 10:42:21 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44710 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgC0OmV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Mar 2020 10:42:21 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02REgIcv043205;
        Fri, 27 Mar 2020 09:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585320138;
        bh=zTqa0fKnbxgR26pLnmnxrp9shaf1W5DyosMSNlxAQfA=;
        h=From:To:CC:Subject:Date;
        b=ufULmq4SBKudtr3/jyrTXmB4FMymvJQpovLB2OWrQ6bzr1V9HWiGqp2zn1lP7tsJ/
         2JNfGep5tHzZ9yuBnmVzPBztWcM3p0n1m+e40XcWw3NYhAueNug7CYY+SXz3yuIkBi
         nTc2offWt2lvZWrqAqMR+3tatjp1ZQYldi36yNHo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02REgIcj044117
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Mar 2020 09:42:18 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 27
 Mar 2020 09:42:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 27 Mar 2020 09:42:17 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02REgFuC011518;
        Fri, 27 Mar 2020 09:42:16 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Disable memcopy via MCU NAVSS on am654
Date:   Fri, 27 Mar 2020 16:42:28 +0200
Message-ID: <20200327144228.11101-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Trace of a test for DMA memcpy domains slipped into the glue layer commit.
The memcpy support should be disabled on the MCU UDMAP.

Fixes: d702419134133 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine users")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index a9c0251adf1a..fa53234d8f09 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3187,7 +3187,7 @@ static struct udma_match_data am654_main_data = {
 
 static struct udma_match_data am654_mcu_data = {
 	.psil_base = 0x6000,
-	.enable_memcpy_support = true, /* TEST: DMA domains */
+	.enable_memcpy_support = false,
 	.statictr_z_mask = GENMASK(11, 0),
 	.rchan_oes_offset = 0x2000,
 	.tpl_levels = 2,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

