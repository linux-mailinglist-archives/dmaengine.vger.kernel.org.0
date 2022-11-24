Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B129637670
	for <lists+dmaengine@lfdr.de>; Thu, 24 Nov 2022 11:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiKXK3a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Nov 2022 05:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiKXK32 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Nov 2022 05:29:28 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50662CFBA6;
        Thu, 24 Nov 2022 02:29:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJWl6rEP49kG+CUjlbQmh0SKB0dj5qME7FqAndbBxyGz9o/2V3CZpww16nKd65wz0w11SNyMs4oRRwHahpndUFYLQPuokerD196kJeunE+e1tLRzFceeq/kYGR7nSkwf1HDF/Puh1x4KHXw8m6gWc5BFIp4PMELwTHh3pC+VXbsjKHP88MFjHsSfYmuMaHhXWfYyxPp1IU4o1y/UTMTcrxiWLTKue/ZXgNPfz27LN6XEyNC3SK0eqg8HDzSRS0mvePNZuI3baIo6kUEAfAG1dSfoRHXCWuZ/hdwVrAp0+WzHs/78klVqZGNSX4sExW7Nc8ZDwsY2bTK4NXNTKNe5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORokADxLb+Twd43s8TyPeB+RiT/3+LpaH6vE7t1P/lM=;
 b=fnWNbabPvb6fBcU3pXYjUBndmq24XZQPVp5ZwB8rWpOp+8k+Qi18qvxdHM7PBOgyHUbL5+pjLohDuXCid3daHsyaRiC2VmE1hAsm4EniwJzpw4wofuFkmWoYoom+Kl/v38qYWAQk7J40AYEm6xLvXlTZEPMMD4OXJIMO2BOxgXL28y9GBhsBQPldpg4aPBoHMpB3FTiC7btafW2yZyPuX5tr2guLYVCagUBgBGMnAHabm/r9mkkEGBb44I/2uw9v3AJH8souedZ+a3a7ycjlIj1VFx5O6+SjQk06Q26h/SBEYOPAvBMPFFsEjodUAixJc11XyMU+AjhJ82Tc9fN7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORokADxLb+Twd43s8TyPeB+RiT/3+LpaH6vE7t1P/lM=;
 b=phEmM3/YY/V8qQzk0K+R0f21PN7UapxiamFWmFScncX6BwXOVFcrbaJXPi1WTrx2GZ/bdntqC4tyAMaDZBnzkLCYLL2wLr3h8mbmYtWt4a8ZiFwMdxch4j0g23DZi7TNSrvhqpbbVN6b8WRyGP9oJxX3sSzDy/WBFlQmEnqf8A0=
Received: from BN9PR03CA0902.namprd03.prod.outlook.com (2603:10b6:408:107::7)
 by MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 10:29:23 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::53) by BN9PR03CA0902.outlook.office365.com
 (2603:10b6:408:107::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 10:29:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Thu, 24 Nov 2022 10:29:23 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 04:28:56 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 02:28:35 -0800
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 24 Nov 2022 04:28:31 -0600
From:   Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <adrianml@alumnos.upm.es>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <radhey.shyam.pandey@amd.com>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>, <sarath.babu.naidu.gaddam@amd.com>,
        <git@amd.com>
Subject: [PATCH V2 3/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words to dma client
Date:   Thu, 24 Nov 2022 15:57:42 +0530
Message-ID: <20221124102745.2620370-4-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
References: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|MN0PR12MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a92aac0-fdf2-41b8-d4ba-08dace06c132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcQySStW7FZzEt6BQqTqiznbGqA0Mw4erMghOAfnibxsJeS7IaP6KEqvpJ9aIWhO+c2XHhAilTXyokKv/EZIR783Fwi1bQp4ZUp/OyaI9RYlLLL08tk3Z7M4RFpYsoyxqNcUCkMIHE0IKEFuZfYOASJr9HgdkAL1vdh3WD9EkT0s0r5qbwCIXVT8XFNGV2Ny7f5VwwmbxSLh6xzaRLyfXD3/HijnFe98PrgS5BFcKcSWTNfVucBL1Ragd1tGBhgUgoMqq3s0LIsf71qfJlpq6r+MNw3CuRsq3JnjI6CwZnu2vw0/RgtkDCSi++jqbtnJ1tFb7jbEzMsTojZhHPnsZRKbIvCZZq0hKeB+QErtnaU1CfQPXne/CH6dMQz5bQmN+Zh1/ZG4Lr4Re93fupAozcKJporIBYzd10hhly8hj5fUEVNnlwffreuo2bOPOvV5CRaoYkBRmmglQ9eqGnJa8h5xmZmH1THKJfdXRVIA8yu53SI+ijRr3LCJamp2q7JM31ht21s33RPeGWzF00zE8ES2CUp/UKxxqKGa4rPvkbERu4zTMgygmCcDxxaFLHm9HhU2zFIKSdy7pI1R2/ZiOy2lovI/W58GTiVv4ngjPze7Um22C+tvF5yduyxHlhWccGkxg/tQs+RYK+go6UpF0yC3huYX1CYMZiYPAO8ejJ1GlZ4PZlZ9HbfUo47lz3ky+5OgCm9BRqDe3q1K/vTGOdpMaoimO7HgUce6ZAanwAo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(86362001)(316002)(54906003)(110136005)(41300700001)(8936002)(36756003)(103116003)(356005)(81166007)(70206006)(4326008)(70586007)(8676002)(1076003)(186003)(336012)(426003)(36860700001)(47076005)(2616005)(82740400003)(40460700003)(478600001)(82310400005)(40480700001)(26005)(6666004)(2906002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 10:29:23.1556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a92aac0-fdf2-41b8-d4ba-08dace06c132
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

Read DT property to check if AXI DMA is connected to streaming IP
i.e axiethernet. If connected pass AXI4-Stream control words to
dma client using metadata_ops dmaengine API.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 37 +++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 8cd4e69dc7b4..f783ba86cb09 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -493,6 +493,7 @@ struct xilinx_dma_config {
  * @s2mm_chan_id: DMA s2mm channel identifier
  * @mm2s_chan_id: DMA mm2s channel identifier
  * @max_buffer_len: Max buffer length
+ * @has_axistream_connected: AXI DMA connected to AXI Stream IP
  */
 struct xilinx_dma_device {
 	void __iomem *regs;
@@ -511,6 +512,7 @@ struct xilinx_dma_device {
 	u32 s2mm_chan_id;
 	u32 mm2s_chan_id;
 	u32 max_buffer_len;
+	bool has_axistream_connected;
 };
 
 /* Macros */
@@ -623,6 +625,29 @@ static inline void xilinx_aximcdma_buf(struct xilinx_dma_chan *chan,
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
@@ -2219,6 +2244,9 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 		segment->hw.control |= XILINX_DMA_BD_EOP;
 	}
 
+	if (chan->xdev->has_axistream_connected)
+		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;
+
 	return &desc->async_tx;
 
 error:
@@ -3065,6 +3093,11 @@ static int xilinx_dma_probe(struct platform_device *pdev)
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
@@ -3090,6 +3123,10 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	else
 		xdev->ext_addr = false;
 
+	/* Set metadata mode */
+	if (xdev->has_axistream_connected)
+		xdev->common.desc_metadata_modes = DESC_METADATA_ENGINE;
+
 	/* Set the dma mask bits */
 	err = dma_set_mask_and_coherent(xdev->dev, DMA_BIT_MASK(addr_width));
 	if (err < 0) {
-- 
2.25.1

