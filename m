Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B59610991
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 07:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJ1FKF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 01:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJ1FKC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 01:10:02 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CBC2F3AF;
        Thu, 27 Oct 2022 22:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQQRnM+GK8IBAMJynG6fsAr1Tq3dxHuRsAL2ZgeKItYKGj1gbPHGqYrUiv3yF/sbTD8ZvwWMCdELx2yXRloLLLqEnZetUeUBpEW8vcQn3lgSRTondbcmHrTD6q5DZiCZMPO4pUF69gjsCKStW7T8GRpPtPkbstkVTb4BOjVRQOBzfY3Bo6RPmWQsYi70yn42e4KX1D1Wsqx8G4UrVIaDhC13NCXSzbqS8qMZctvOhbVeCd2T4fUrDH7THK4m/uDjEg6biigA6Sdvx67uidF+yeuYSeDgK1aS4NVHSW5mMTN/+VZ648lZlylCViIqD2qPp8iej5qqit0/DHiqZ5+SSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i9nHptZBne6tnAEleZ1X5f0vX6ZgN82WLJyjGTmnmE=;
 b=e0G+bheL6+GVKToGnAffRtcrl9boe1fTc89CEcvABbvnhUvZDCeB3M3QElaEUYbCYJHU98WW43i+dvUC8MW4c42cny/p2/ePh/Me1g3UvbDcrUpH37acHCb9VyCuk9Q1ctf1pSh+9TLYqhc3fVYG2+rJwI6dQU+iclbhsy3rdfeiL75wOKonco2JvuPaHXFpIWdOcE1qUN/hHv5giA1mHzjVWCN3FN65KQwRb/FJuIuVriyOY2X9vs3l33uvrm30xvqNRIfIFS+DENEyB0rMbMuAgCDAeZ3B0DpEe85fRMCsF27U8m9HvBKjIIF1AYXilHEcmHABz8RpHFU7M4BkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i9nHptZBne6tnAEleZ1X5f0vX6ZgN82WLJyjGTmnmE=;
 b=miDAajLr25JAt8nLuMCuYu6u6AJ5I2BBLKLmaz6JRchSFmxyzIwKOOfZ+7juoHQQFLZNovciFVvkaIYS+Ygm7icSbGz2KK1sLftw9qQo2hqiKBIcv3iNKBIeEGirhIHOSjiAx0fl5Kv/vyJrLMVVNBzmFjXXzsz0wTe2BqUDi+E=
Received: from BN8PR03CA0034.namprd03.prod.outlook.com (2603:10b6:408:94::47)
 by CH0PR12MB5268.namprd12.prod.outlook.com (2603:10b6:610:d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 05:09:59 +0000
Received: from BL02EPF0000C403.namprd05.prod.outlook.com
 (2603:10b6:408:94:cafe::29) by BN8PR03CA0034.outlook.office365.com
 (2603:10b6:408:94::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 05:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C403.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 28 Oct 2022 05:09:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 00:09:57 -0500
Received: from xhdpranavis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Fri, 28 Oct 2022 00:09:54 -0500
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
Subject: [PATCH 3/5] dmaengine: xilinx_dma: Pass AXI4-Stream control words to dma client
Date:   Thu, 27 Oct 2022 23:09:38 -0600
Message-ID: <20221028050940.27888-4-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221028050940.27888-1-sarath.babu.naidu.gaddam@amd.com>
References: <20221028050940.27888-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C403:EE_|CH0PR12MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: b5336b17-6f8c-470f-7c8a-08dab8a2a929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: haMwq5ucbDsL5BzCNebNbM6kmtGFz2ssC6Ucl18ipwgYTMnpnNXIBSgWOuU+jcK2NvflZ80ODte/qiv6WhnmkFRwIDAL+ngoqv//H3aOBGMV0yI9ynJGWkKvCuZZaZqiUCLQJf7cviG2WmOVQ6XWbdH4fPKcXRje9YEVoE5FLEcwFeo/vrsEFb1nZua+eJBJ9zD6dMgfzIThTTVuTpxPuea6w7T6GZTbNiPazo699oTrJMntNiCfbxc/R68loz9+O1FSuxPFJ8mKqR2msGl/iqAIeQkuviaNvHL65KwSjTCh+rCwiDVqGf5yonBt/RZX/a5lAeN/dqg8SGdnNJxDMjQp6NesNCdDXjoW6pmSlDQKwqOan9BSfaOpv/0fAB1fdQ7mcPkjNNSH0s9ASAPPMMVPIBYdxddcBiYZP+CLtbLgTv8V4lsmA8a/2XVk+vMQF47sNjednHmsYlPxpDoXZqPTob4qM3OXp2tBarzD2Gv5nYSu3ot+L7d0u2PBIOjD+v+eGogoUJzJE8gW6NfEDAoVi4vDDN437vXCUVFXOfRv53x2Xlif1uiNflkiu+nQRrXDJM2pgp1nYEmytFdCZQX0yHr2cjC0xc9Wz8q+rioaGUaJe+aGhmoOpHGMWxar2p1cZGFOKn7tZ0y6a32Ey+jzFU0HCdjhedcRg5p5MiCV5XV3edYaEp9MIhyI1VFAON0gOHFgu6djOMmlJUl3NMI2r0iEAaOGzsVXiRk05wkvaZIsNLLN1nVEyMi7t2JuQV8h9nHLZSOCd9gTxvHBoHVLrBXKnqbZaaRqLGm+JWmFK9koDekyjZSyu2L1Awoc
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(86362001)(103116003)(36860700001)(426003)(47076005)(336012)(82740400003)(186003)(356005)(81166007)(5660300002)(4326008)(41300700001)(8676002)(8936002)(82310400005)(6666004)(40460700003)(478600001)(2616005)(1076003)(26005)(316002)(54906003)(70586007)(70206006)(110136005)(2906002)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 05:09:58.8159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5336b17-6f8c-470f-7c8a-08dab8a2a929
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C403.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5268
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
 drivers/dma/xilinx/xilinx_dma.c | 37 +++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 8cd4e69dc7b4..b69e0482a50f 100644
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

