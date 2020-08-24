Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACD224FD1B
	for <lists+dmaengine@lfdr.de>; Mon, 24 Aug 2020 13:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgHXL7r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Aug 2020 07:59:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44140 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgHXL7q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Aug 2020 07:59:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07OBxhUD019416;
        Mon, 24 Aug 2020 06:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598270383;
        bh=U7Kvv059kIH380wsq3I90SnWfNe2ODtyjcrIyUWnGiQ=;
        h=From:To:CC:Subject:Date;
        b=JpHE6czOD3JOr7pfvm8ggkQgwzWdzXg3YXdDrPg8a5pK5F+eCu5XBhUBXpt76bfzA
         uAerVD1vrpvOYu6iv+dX7Isr9IDaG2+DgXc4wJ9yJdcxGXFlyzUvCxnT6khINTJTua
         Ndydf0pfvjhkUaTNjYcZtyTn/6GWpHY12PDemw9o=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07OBxhcZ104612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 06:59:43 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 24
 Aug 2020 06:59:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 24 Aug 2020 06:59:42 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07OBxfjP048178;
        Mon, 24 Aug 2020 06:59:41 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Remove redundant is_slave_direction() checks
Date:   Mon, 24 Aug 2020 15:01:20 +0300
Message-ID: <20200824120120.9270-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The direction has been already validated in the main callback and there is
no need to check it again in the TR mode handlers for slave_sg and cyclic.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 30cb514cee54..989998b6e078 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2024,11 +2024,6 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
 	int num_tr = 0;
 	int tr_idx = 0;
 
-	if (!is_slave_direction(dir)) {
-		dev_err(uc->ud->dev, "Only slave cyclic is supported\n");
-		return NULL;
-	}
-
 	/* estimate the number of TRs we will need */
 	for_each_sg(sgl, sgent, sglen, i) {
 		if (sg_dma_len(sgent) < SZ_64K)
@@ -2400,11 +2395,6 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
 	unsigned int i;
 	int num_tr;
 
-	if (!is_slave_direction(dir)) {
-		dev_err(uc->ud->dev, "Only slave cyclic is supported\n");
-		return NULL;
-	}
-
 	num_tr = udma_get_tr_counters(period_len, __ffs(buf_addr), &tr0_cnt0,
 				      &tr0_cnt1, &tr1_cnt0);
 	if (num_tr < 0) {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

