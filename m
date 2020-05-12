Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B24A1CF611
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2020 15:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgELNpS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 May 2020 09:45:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35792 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELNpR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 May 2020 09:45:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04CDjBCS039067;
        Tue, 12 May 2020 08:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589291111;
        bh=bQK2OYLVEzag0uurQVuHzfwzSL2nRgRfIJI9xmQC0j4=;
        h=From:To:CC:Subject:Date;
        b=IiaU3vA5uIYonmB4sJTdNVINd7vVOpUkZYtjkZHvXG6t1L9CzA66cPxdVV8SeiFOW
         pdRrPYdXiQVn+dLbcvh4cEESlYlGIR+DrV6ANpW7VVJmC/fNz1IIvcAJGUhVtWKPqB
         XvWmLgmTZbnP/Vrp+vttPrLgy/mKAum4pHbQGn9o=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04CDjBPB059100
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 08:45:11 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 08:45:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 08:45:11 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04CDj92B063557;
        Tue, 12 May 2020 08:45:10 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Add missing dma_sync call for rx flush descriptor
Date:   Tue, 12 May 2020 16:45:44 +0300
Message-ID: <20200512134544.5839-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The TR mode rx flush descriptor did not had a dma_sync_single_for_device()
call to make sure that the DMA see the correct information.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 20b1f94de86c..5afd0fde4706 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3472,6 +3472,9 @@ static int udma_setup_rx_flush(struct udma_dev *ud)
 	tr_req->icnt0 = rx_flush->buffer_size;
 	tr_req->icnt1 = 1;
 
+	dma_sync_single_for_device(dev, hwdesc->cppi5_desc_paddr,
+				   hwdesc->cppi5_desc_size, DMA_TO_DEVICE);
+
 	/* Set up descriptor to be used for packet mode */
 	hwdesc = &rx_flush->hwdescs[1];
 	hwdesc->cppi5_desc_size = ALIGN(sizeof(struct cppi5_host_desc_t) +
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

