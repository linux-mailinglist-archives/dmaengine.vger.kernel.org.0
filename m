Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A2C391BE2
	for <lists+dmaengine@lfdr.de>; Wed, 26 May 2021 17:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhEZP0k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 May 2021 11:26:40 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59298 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbhEZP0T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 May 2021 11:26:19 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QFOBEt001745;
        Wed, 26 May 2021 10:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622042651;
        bh=BMdz5PIJ0bDUzRjPQ3h1Ef4Vn0+hXXShPYDakbVNwWY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LKyZ1j1jo5rtIHOGp+W2Y09byBc3lfx05EF4zJS7YJIbAfGP6NBpjQqRsSPEXDZNj
         vZpv13I3KS/chm0DPrdYI2k3Rdzs8nY4SWzcBHUHkhnd18wFymedxaefQVTd0LXPW5
         X95OJkP55aYdSXQlbNSbGmOtTnlsOw71Ibd9Xd/k=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QFOB2t101445
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 10:24:11 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 10:24:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 10:24:11 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QFN9Jj056314;
        Wed, 26 May 2021 10:24:06 -0500
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
Subject: [PATCH v2 11/18] dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
Date:   Wed, 26 May 2021 20:53:01 +0530
Message-ID: <20210526152308.16525-12-p.yadav@ti.com>
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

The CSI2RX subsystem uses PSI-L DMA to transfer frames to memory. It can
have up to 32 threads but the current driver only supports using one. So
add an entry for that one thread.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

---

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

