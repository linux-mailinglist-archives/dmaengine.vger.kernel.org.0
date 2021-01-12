Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36572F32BC
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 15:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbhALOPG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 09:15:06 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34820 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbhALOPG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jan 2021 09:15:06 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10CEEM61083911;
        Tue, 12 Jan 2021 08:14:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610460862;
        bh=esTShs76yvdLhD/D3aKWd2PmXrVE3wDszC9rVv+VngA=;
        h=From:To:CC:Subject:Date;
        b=wY3yeKCLVpMFnix6k6e7c98qQ+uKeLEm+/io0WkUl871wCmeScOE7D4y2fTyrh+00
         o4A3A36A4RzjLc2SrQawy4uCGJcvILfkt3/xB65V4eBweluF7PHg1JuRBCnHOU0EIa
         OwKUjtu0sX2A9b9T/r0lVDVJDsZfbR8BuaPPvbHg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10CEEMMO038587
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jan 2021 08:14:22 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 Jan 2021 08:14:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 Jan 2021 08:14:22 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10CEEJml009102;
        Tue, 12 Jan 2021 08:14:20 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Set rflow count for BCDMA split channels
Date:   Tue, 12 Jan 2021 19:44:03 +0530
Message-ID: <20210112141403.30286-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

BCDMA RX channels have one flow per channel, therefore set the rflow_cnt
to rchan_cnt.

Without this patch, request for BCDMA RX channel allocation fails as
rflow_cnt is 0 thus fails to reserve a rflow for the channel.

Fixes: 8844898028d4 ("dmaengine: ti: k3-udma: Add support for BCDMA channel TPL handling")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/dma/ti/k3-udma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 298460438bb4..a1af59d901be 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4305,6 +4305,7 @@ static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
 		ud->bchan_cnt = BCDMA_CAP2_BCHAN_CNT(cap2);
 		ud->tchan_cnt = BCDMA_CAP2_TCHAN_CNT(cap2);
 		ud->rchan_cnt = BCDMA_CAP2_RCHAN_CNT(cap2);
+		ud->rflow_cnt = ud->rchan_cnt;
 		break;
 	case DMA_TYPE_PKTDMA:
 		cap4 = udma_read(ud->mmrs[MMR_GCFG], 0x30);
-- 
2.30.0

