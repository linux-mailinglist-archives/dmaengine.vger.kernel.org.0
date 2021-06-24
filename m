Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6073B3599
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jun 2021 20:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhFXS1O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Jun 2021 14:27:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33762 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXS1O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Jun 2021 14:27:14 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15OIOqVh068351;
        Thu, 24 Jun 2021 13:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624559092;
        bh=8KRZ/rQJoyKTVZLM1HkAYTd5DyUGX7sHeS6CvLIljlc=;
        h=From:To:CC:Subject:Date;
        b=rxcRu2KXKalvdz/9QExEmBKE6RvGzPRxAoDCyp8T6bsnp26UCr9RgEW5mUAqsqg/6
         4vndrbmlJScmbrRjyVD2e9Xl/t15VuaM25pUpOsjRR70xUzXCS6ZTg3oTpS3dz2it9
         J8eIlZWUD2MfoFRFHDsvlsIaUJmsReTstpDWuQK4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15OIOqni085788
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jun 2021 13:24:52 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 24
 Jun 2021 13:24:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 24 Jun 2021 13:24:52 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15OIOosR011847;
        Thu, 24 Jun 2021 13:24:51 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, Vinod Koul <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
Date:   Thu, 24 Jun 2021 23:54:49 +0530
Message-ID: <20210624182449.31164-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The CSI2RX subsystem uses PSI-L DMA to transfer frames to memory. It can
have up to 32 threads per instance. J721E has two instances of the
subsystem, so there are 64 threads total. Add them to the endpoint map.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

---
This patch has been split off from [0] to facilitate easier merging. I
have still kept it as v3 to maintain continuity with the previous patches.

[0] https://patchwork.linuxtv.org/project/linux-media/list/?series=5526&state=%2A&archive=both

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

