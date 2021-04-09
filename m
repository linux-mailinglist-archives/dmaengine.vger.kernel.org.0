Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F6A35A50F
	for <lists+dmaengine@lfdr.de>; Fri,  9 Apr 2021 19:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhDIR5v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Apr 2021 13:57:51 -0400
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:30849
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234438AbhDIR5t (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 9 Apr 2021 13:57:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHDtsNJWIO9Q9+PsxGX/RcHfj29wjWLcvCdsUGEhE/DqUr1j7C2cL3ZNgBW2W3dKseUii/tZER8fFVH2S1WNIocVOyqVY6dvF8E+Eg0iaWAhhGGcOVbNAlkzb88LthIHADFDX+zK/yYYp8Vbx1y7F9M93Y7sxZbFU1+Hp44+WHqEf5VPiRef6S7JydmPMlR3XE9rRFXUF+R7rYJXM41r0t0Xxv7zMFuGgDgRX+QBWb1xwEquV8DCk38egU5AvW3LXmWNOFL9TodLvWlpFpaeQv1yAl9yrH04P2H2m5GIvhmr/NDA3LmzcQ2sb2mVfzZfheGTnDvhMX9cJbyXE6edKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5F1MLwi5N5bmVxZQaHev23O3ZH9qNtM6JXmaL24nsA=;
 b=b2nlEogGAFMJm1V3UJHuYK5zWTFuq91NtIifTbCdT1D4swNjc3OhdaxXlS4zvRmcGGpsS+h3IC8VZ6mHI2n3exzCsWDxBFCoT18iXucyRoYGrbsqfguJgXoQfipFxJVzHY8WNwvAUnpBX/dzpiWDXTF5fA7nATEJ3Lpd7fo151bbi4dsAHrypo0KizQvq9/TeMN12jTX8WSznz+k50Zlugk4JCxfgecf+TrKqpB8AKGQC0y68zltB0dHTKIPzHRwM/yCNyCHdA6zE3zghU1EbCq2AGfmXuWcOkcoWpJisnAUjTzxA9keHnWLXiPBZGUUy+FcIHlurEeYukk9Yf4RZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5F1MLwi5N5bmVxZQaHev23O3ZH9qNtM6JXmaL24nsA=;
 b=F9ysMlD/m3JWxbs2Wq1PlSKfkatFk7O0749Ht7mk+ZrOefSi9DRGXRbgULvTd89VR4Br6N5vwQtIfzeb+wc6HjkHbnSbtrPX3jXlZMfUHC9qUtkWBZs3/xkWOdzGF+tyxo7g2G41GbrGuS+WJGYvuEQv7GSNLDcq6BhHG0yi91U=
Received: from SA9PR10CA0003.namprd10.prod.outlook.com (2603:10b6:806:a7::8)
 by MW2PR02MB3867.namprd02.prod.outlook.com (2603:10b6:907:6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 9 Apr
 2021 17:57:35 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:a7:cafe::86) by SA9PR10CA0003.outlook.office365.com
 (2603:10b6:806:a7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Fri, 9 Apr 2021 17:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 17:57:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 10:57:01 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 9 Apr 2021 10:57:01 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 vkoul@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=33299 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1lUvNM-0002y0-7f; Fri, 09 Apr 2021 10:57:00 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 3A60612172A; Fri,  9 Apr 2021 23:26:20 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [RFC v2 PATCH 3/7] dmaengine: xilinx_dma: Pass AXI4-Stream control words to dma client
Date:   Fri, 9 Apr 2021 23:26:01 +0530
Message-ID: <1617990965-35337-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12d4485d-663c-4230-f8f3-08d8fb80f497
X-MS-TrafficTypeDiagnostic: MW2PR02MB3867:
X-Microsoft-Antispam-PRVS: <MW2PR02MB38677281B0D187B61FE9D153C7739@MW2PR02MB3867.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1WCTxN9cfr5a33ZxHFx+u5QXjlXl68WY85QNfuJtx586PblUTxNTHMGYtFQtvjzV4BUubjHebPz01k1cWvsR+u1yDt/DDUEi5D9RqiyEIGkFAHmKBewWm+easSEIudUiruudct2sIGe90FZ+u/qv6034enhaSdWdyUehG0ceq397sBSa7zUeXhsUfndMWDnr7og52U/O2wkKm4QJdBnkPXsSzg/exZKoegznLw/FuesAN6LaTRkxpIJc9qxdNQ8usoJuJTepvLq8q41OX88VHPYAW44ZT+gkB1yi/7yM3gYW1bIhRcrbZu15J7TQRB1y6BZ8BpU9yAq+0shPyaGpEDQXFg8DJ1gUM9JAY3hcaoNOckq0oND65b6uCbQOJBpocWeBv3Xb5ViLlSu6qpbBfRq3/pqeCfpGY6ah11ANgeUJp3LueSgvaJBjAybmkP/3rnOPz1bn3wjCQO7kMwldpe+eI9YOzmRfNwew++KBYePRhFpfmOBUu8oz2osB583HCgMT6pbgw1K8yZs738zt8urHXqwAK2VojNoqu/YGBqLnv1ml4EL1JHtD5ZrtQ89a0dw97DuyNRWgVoTRt1WAG8tjgVk+D6mcTuDy1uR4/KhDvV0ywvm+wO074m+7ItFWYRNRqhqPsRQ2fXkN7WB/nxDhyn4I7QhVmAUZcClRjKZ0/jyqR/7xkg112A+AKhl
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(376002)(136003)(36840700001)(46966006)(478600001)(36860700001)(36756003)(54906003)(6266002)(7636003)(4326008)(6636002)(107886003)(356005)(82310400003)(82740400003)(8936002)(70206006)(426003)(8676002)(186003)(26005)(2616005)(70586007)(316002)(5660300002)(2906002)(110136005)(42186006)(336012)(6666004)(47076005)(36906005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 17:57:35.0081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d4485d-663c-4230-f8f3-08d8fb80f497
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3867
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Read DT property to check if AXI DMA is connected to streaming IP
i.e axiethernet. If connected pass AXI4-Stream control words to
dma client using metadata_ops dmaengine API.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes for v2:
- Use descriptor metadata API to pass control words to dma client.
- Rephrased commit description to be inline with implementation.
---
 drivers/dma/xilinx/xilinx_dma.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 3aded7861fef..14dcfc473e52 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -491,6 +491,7 @@ struct xilinx_dma_config {
  * @s2mm_chan_id: DMA s2mm channel identifier
  * @mm2s_chan_id: DMA mm2s channel identifier
  * @max_buffer_len: Max buffer length
+ * @has_axistream_connected: AXI DMA connected to AXI Stream IP
  */
 struct xilinx_dma_device {
 	void __iomem *regs;
@@ -509,6 +510,7 @@ struct xilinx_dma_device {
 	u32 s2mm_chan_id;
 	u32 mm2s_chan_id;
 	u32 max_buffer_len;
+	bool has_axistream_connected;
 };
 
 /* Macros */
@@ -621,6 +623,29 @@ static inline void xilinx_aximcdma_buf(struct xilinx_dma_chan *chan,
 	}
 }
 
+/**
+ * xilinx_dma_get_metadata_ptr- Populate metadata pointer and payload length
+ * @tx: async transaction descriptor
+ * @payload_len: metadata payload length
+ * @max_len: metadata max length
+ * Return: The app field pointer.
+ */
+static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
+					 size_t *payload_len, size_t *max_len)
+{
+	struct xilinx_dma_tx_descriptor *desc = to_dma_tx_descriptor(tx);
+	struct xilinx_axidma_tx_segment *seg;
+
+	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
+	seg = list_first_entry(&desc->segments,
+			       struct xilinx_axidma_tx_segment, node);
+	return seg->hw.app;
+}
+
+static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
+	.get_ptr = xilinx_dma_get_metadata_ptr,
+};
+
 /* -----------------------------------------------------------------------------
  * Descriptors and segments alloc and free
  */
@@ -2200,6 +2225,9 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 		segment->hw.control |= XILINX_DMA_BD_EOP;
 	}
 
+	if (chan->xdev->has_axistream_connected)
+		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;
+
 	return &desc->async_tx;
 
 error:
@@ -3032,6 +3060,11 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
+		xdev->has_axistream_connected =
+			of_property_read_bool(node, "xlnx,axistream-connected");
+	}
+
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
 		err = of_property_read_u32(node, "xlnx,num-fstores",
 					   &num_frames);
@@ -3057,6 +3090,10 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	else
 		xdev->ext_addr = false;
 
+	/* Set metadata mode */
+	if (xdev->has_axistream_connected)
+		xdev->common.desc_metadata_modes = DESC_METADATA_ENGINE;
+
 	/* Set the dma mask bits */
 	dma_set_mask(xdev->dev, DMA_BIT_MASK(addr_width));
 
-- 
2.7.4

