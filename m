Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF375BDCA3
	for <lists+dmaengine@lfdr.de>; Tue, 20 Sep 2022 07:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiITFwt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Sep 2022 01:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiITFwb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Sep 2022 01:52:31 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00495C36B;
        Mon, 19 Sep 2022 22:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8n3syWT3SYC2x8quXw4pjaFredARrJi5I77VKTUgXLQ4qnZ9i1Uaj3RMakJI0OFKnVkgk4tA9UGB0uy9fBRdTjc7F9JF5qJADgnNPhMgnqKnKCTG1dnvr1rVoa6heKklKbzU6H7/z6cCZ7ElpuDI9ctgf//0OqfayvhSys5qaWDe1JdZs/mYK3H6swLwZ3zFgNReDWn4kQkEAjsjjzR7PboA8NAgxfxA3JdF1AXm6fkqu1tEvVcWYrw61ev4yUqmmI/YcJgsNtSogmriej81D0f+I2H2ZwrL50hiIQ3ZK8MzponNSN6Ri4ZJkhUHov9JopTcP2YsznIAMjXcWQU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsfkHru5jDLTHqTP3k+GMFvfvcpFEaANUHC77uktaTE=;
 b=KXuCLDbP9/2fIt26dEW4ve+9FNirywts/mTVTTWLXtBmt5C9COc4LjveCOAN4NQld+zkz1Pg41ho0PmTPBlj/dOeGMn7SPhyxpGO1I/aFU6hAF+cN4RQblILAbn1U7vxuvmVQr80yMv1tu3btzgYZaB3xo6kPeKk5vgx5JzKulJipnbGdnIB9H4v9LHterpeHGFooC+KQ+XW4cpHo8whKkkcy5dDE/thN+uVYBfnYSKZYD4Ee/+r2+3eyd7S9Bs/FLy+Rby140GUSDkWodsiLqjfvofjyzVgesXItl1N+2iNM1dTo4x1RbdrcOfOEI7lxNmqXftqAsSgPL41l14SMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsfkHru5jDLTHqTP3k+GMFvfvcpFEaANUHC77uktaTE=;
 b=zsNqez/J5ZoVujVSHt3Ol/56dLgfla94qmauYGPwjcSd0PVImN7X+qcc5UJrjEF9ERP/OcteewHqu8x8/YxGpZLDtVaPO6S7EjsBAUEVdVrYVu8cs3A71nWX+De3/KkVlKcYOIJSJOtlzv51Ctp4/vJc2kl4jfX8thN/v+/FdlA=
Received: from DS7PR03CA0168.namprd03.prod.outlook.com (2603:10b6:5:3b2::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 05:52:08 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::ac) by DS7PR03CA0168.outlook.office365.com
 (2603:10b6:5:3b2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 05:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 05:52:08 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 00:52:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 22:52:00 -0700
Received: from xhdswatia40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 20 Sep 2022 00:51:55 -0500
From:   Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <adrianml@alumnos.upm.es>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <radhey.shyam.pandey@amd.com>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>, <sarath.babu.naidu.gaddam@amd.com>,
        <git@xilinx.com>, <git@amd.com>
Subject: [RFC V3 PATCH 3/8] dmaengine: xilinx_dma: Pass AXI4-Stream control words to dma client
Date:   Tue, 20 Sep 2022 11:21:14 +0530
Message-ID: <20220920055119.12634-4-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
References: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|CH2PR12MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6614b6-be3e-4c77-3e73-08da9acc414c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMKWH7UNHDyniNtbwya0GkZCIoAqkf6eKtr9wr/JmnKMROU7Ddtxi9Io4zzVth+gcw7myqkinAwddDx97B/Ijf4fLT755LmlvIOlrc9KbG3kxT6a0nKrmRXmKXuGXZmGx/mk8JiHy2uAkGZkvYowtEjJaZqH+BY4WIgjnbfZ872UUb9e2jmUxK6X92XXsYlOh1FpT7BptsXnJ+TLvK0U9JZ6Phj4CcfNArpxoHcOZT7eIyU409xoRAhJm6OtjeCybYAddfF1B6euKSsuoqzPqA3TcvJyBNXTtufC+nc8X1SnxovQIKYoSQUJAG+pKP46OKI33239J/7XKVwHQetU/qa0+LAbeQes8VDo5StFjFeCkGZ4AkGciYpTh0yZs2miLdNu5Bl+4bKqv8OM0+WxhAXfIpYYi3M8JNFbyq4nN9ncEf6+7i8I6VeqVLfLSC1Ox/JjMujXcSComFp89pZ4gotERv9K8hfCTJU3l1dtK+GiDAHK0zN46/fwn1yoOfZ66fYPVM2eMOJ0P3KF9gngx1d6Rou4kIOD8/924kyabPaDYg9xePZZuLnvgwXb/eb/iccwQpVWjn4J5IsOuXdXYcOM38aqH1ea/bcdWZdp5OCn/vIqI6JU5jTrQ8YqOSj3EaLcbqCUkIPhogpxAo1hFq4OosJQteqFS9azDQRXvLPpceoEj6TdgYQwzvxA9YXgjnFXRFKxZ2lDk0JjEeEvwcUVjBfrs1A3d2RrIIayl0nl34saoCwIG7CLfbMw49zGLfox845F94/ar22BBXYtj8lizUVGTEf1tNc2Zv9sVl4nd3Dbx6mJ21xBslL/MxJ3
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(82740400003)(8936002)(478600001)(6666004)(54906003)(40460700003)(316002)(8676002)(4326008)(103116003)(110136005)(70206006)(86362001)(70586007)(81166007)(356005)(40480700001)(41300700001)(36756003)(2616005)(82310400005)(1076003)(186003)(336012)(426003)(47076005)(36860700001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:52:08.4774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6614b6-be3e-4c77-3e73-08da9acc414c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
---
Changes in V3:
- None.

Changes in V2:
- Use descriptor metadata API to pass control words to dma client.
- Rephrased commit description to be inline with implementation.
---
 drivers/dma/xilinx/xilinx_dma.c | 37 +++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 6276934d4d2b..12b1281b19bf 100644
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
@@ -2326,6 +2351,9 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 		segment->hw.control |= XILINX_DMA_BD_EOP;
 	}
 
+	if (chan->xdev->has_axistream_connected)
+		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;
+
 	return &desc->async_tx;
 
 error:
@@ -3064,6 +3092,11 @@ static int xilinx_dma_probe(struct platform_device *pdev)
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
@@ -3089,6 +3122,10 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	else
 		xdev->ext_addr = false;
 
+	/* Set metadata mode */
+	if (xdev->has_axistream_connected)
+		xdev->common.desc_metadata_modes = DESC_METADATA_ENGINE;
+
 	/* Set the dma mask bits */
 	dma_set_mask_and_coherent(xdev->dev, DMA_BIT_MASK(addr_width));
 
-- 
2.25.1

