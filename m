Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C353F179C
	for <lists+dmaengine@lfdr.de>; Thu, 19 Aug 2021 13:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbhHSLBt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Aug 2021 07:01:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43694 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbhHSLBs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Aug 2021 07:01:48 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17JB19lK127769;
        Thu, 19 Aug 2021 06:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629370869;
        bh=GYwL4KMn9MwNzBaNPtVm7kwbuDADlm8h+rKdpDKQ7Y4=;
        h=From:To:CC:Subject:Date;
        b=BYyKLDFs1PU+DDBDLEiZ7CvgjJMGQjbejL5jkLng0ET0kY4cN+3iW0brys0GXgs8k
         8HhblVSmeWK9a7tBtr1EwDVbnpWbwdhWCzyqzW84pDzxjJLLD2+TfDyNLzz8uVT+aH
         lUBTNnvG6U4VG0MhMLdNb9Dvs3rjzgzi7CD4CSI0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17JB19Np071686
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Aug 2021 06:01:09 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 19
 Aug 2021 06:01:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 19 Aug 2021 06:01:09 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17JB169u012836;
        Thu, 19 Aug 2021 06:01:07 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Pratyush Yadav <p.yadav@ti.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
Date:   Thu, 19 Aug 2021 16:31:05 +0530
Message-ID: <20210819110106.31409-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The CSI2RX subsystem on J721E is serviced by UDMA via PSI-L to transfer
frames to memory. It can have up to 32 threads per instance. J721E has
two instances of the subsystem, so there are 64 threads total. Add them
to the endpoint map.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Acked-by: Peter Ujfalusi <peter.ujflausi@gmail.com>

---
This patch has been split off from [0] to facilitate easier merging. I
have still kept the version number to maintain continuity with the
previous patches.

[0] https://patchwork.linuxtv.org/project/linux-media/list/?series=5526&state=%2A&archive=both

Changes in v4:
- Update commit message with Peter's suggested changes.
- Add Peter's Ack.

Changes in v3:
- Update commit message to mention that all 64 threads are being added.

Changes in v2:
- Add all 64 threads, instead of having only the one thread being
  currently used by the driver.

 drivers/dma/ti/k3-psil-j721e.c | 73 ++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/dma/ti/k3-psil-j721e.c b/drivers/dma/ti/k3-psil-j721e.c
index 7580870ed746..34e3fc565a37 100644
--- a/drivers/dma/ti/k3-psil-j721e.c
+++ b/drivers/dma/ti/k3-psil-j721e.c
@@ -58,6 +58,14 @@
 		},					\
 	}
 
+#define PSIL_CSI2RX(x)					\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_NATIVE,	\
+		},					\
+	}
+
 /* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
 static struct psil_ep j721e_src_ep_map[] = {
 	/* SA2UL */
@@ -138,6 +146,71 @@ static struct psil_ep j721e_src_ep_map[] = {
 	PSIL_PDMA_XY_PKT(0x4707),
 	PSIL_PDMA_XY_PKT(0x4708),
 	PSIL_PDMA_XY_PKT(0x4709),
+	/* CSI2RX */
+	PSIL_CSI2RX(0x4940),
+	PSIL_CSI2RX(0x4941),
+	PSIL_CSI2RX(0x4942),
+	PSIL_CSI2RX(0x4943),
+	PSIL_CSI2RX(0x4944),
+	PSIL_CSI2RX(0x4945),
+	PSIL_CSI2RX(0x4946),
+	PSIL_CSI2RX(0x4947),
+	PSIL_CSI2RX(0x4948),
+	PSIL_CSI2RX(0x4949),
+	PSIL_CSI2RX(0x494a),
+	PSIL_CSI2RX(0x494b),
+	PSIL_CSI2RX(0x494c),
+	PSIL_CSI2RX(0x494d),
+	PSIL_CSI2RX(0x494e),
+	PSIL_CSI2RX(0x494f),
+	PSIL_CSI2RX(0x4950),
+	PSIL_CSI2RX(0x4951),
+	PSIL_CSI2RX(0x4952),
+	PSIL_CSI2RX(0x4953),
+	PSIL_CSI2RX(0x4954),
+	PSIL_CSI2RX(0x4955),
+	PSIL_CSI2RX(0x4956),
+	PSIL_CSI2RX(0x4957),
+	PSIL_CSI2RX(0x4958),
+	PSIL_CSI2RX(0x4959),
+	PSIL_CSI2RX(0x495a),
+	PSIL_CSI2RX(0x495b),
+	PSIL_CSI2RX(0x495c),
+	PSIL_CSI2RX(0x495d),
+	PSIL_CSI2RX(0x495e),
+	PSIL_CSI2RX(0x495f),
+	PSIL_CSI2RX(0x4960),
+	PSIL_CSI2RX(0x4961),
+	PSIL_CSI2RX(0x4962),
+	PSIL_CSI2RX(0x4963),
+	PSIL_CSI2RX(0x4964),
+	PSIL_CSI2RX(0x4965),
+	PSIL_CSI2RX(0x4966),
+	PSIL_CSI2RX(0x4967),
+	PSIL_CSI2RX(0x4968),
+	PSIL_CSI2RX(0x4969),
+	PSIL_CSI2RX(0x496a),
+	PSIL_CSI2RX(0x496b),
+	PSIL_CSI2RX(0x496c),
+	PSIL_CSI2RX(0x496d),
+	PSIL_CSI2RX(0x496e),
+	PSIL_CSI2RX(0x496f),
+	PSIL_CSI2RX(0x4970),
+	PSIL_CSI2RX(0x4971),
+	PSIL_CSI2RX(0x4972),
+	PSIL_CSI2RX(0x4973),
+	PSIL_CSI2RX(0x4974),
+	PSIL_CSI2RX(0x4975),
+	PSIL_CSI2RX(0x4976),
+	PSIL_CSI2RX(0x4977),
+	PSIL_CSI2RX(0x4978),
+	PSIL_CSI2RX(0x4979),
+	PSIL_CSI2RX(0x497a),
+	PSIL_CSI2RX(0x497b),
+	PSIL_CSI2RX(0x497c),
+	PSIL_CSI2RX(0x497d),
+	PSIL_CSI2RX(0x497e),
+	PSIL_CSI2RX(0x497f),
 	/* CPSW9 */
 	PSIL_ETHERNET(0x4a00),
 	/* CPSW0 */
-- 
2.30.0

