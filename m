Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39177719AA
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 07:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjHGFwz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 01:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjHGFwx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 01:52:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2BB1711;
        Sun,  6 Aug 2023 22:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUImmXVfyxZJOp4knzl/9pqSlqNntqNdTIEbMfvxnDTAFTYo0MAZm4Eo7E0XcQwFsxns76q4r5c+QsX/W0AaeqrDAE4gGTLdCsrsDzyGFwhVQF8+roNW+UKynb1ajavoD85Zuz+C0rmP82sU5Pkx4FBN1VQs1333cP03+inw9f/J80oipbP3ebqHH9Qqu8PEe1SlUKZzCJpQqO0+kbl81SNEGAehGvPNn16EYLH84hgBVD7XqNYVF8PSAg/IF7lv0jrpLNhr45CWhmykr5HEP6s1DMJbDf8cHtAwU9b5yxsh00odCV2Viw/bAY9/BACtzquixWvkkuclMhGMwBhUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maKd0XBrQrtfUNAiqhGM55X9ITlMGpwwevkmoWteh64=;
 b=W8xv/1I6RGvN/2/1ceeMKgJu3AQ7K7w6nPCF8f0dVfIQQcHGDc2BSAxDzEHdnrL7H7a8xXdImf/tKdCJxC8LpnpWX6n6QZHPG2swqKIQ/WfwLkHBg7YJMbzvotog1npLgOMG9g8VZ7t+7FAmosngDC3wMIe666R9aSfp7Qi/lVJaKKuwG5DB0pMQqugm2gDjXYyBhZXhenmWpLCF9728tXtp7dvGumJdcZ46WWCq+hepsakuuyNK2rz2v9q7sp3T8llChNEXQFKJ6iwu5gfwwP9o0rZl0awbC9NajPpRDpO4WTm6/ZLVGROjKrDoLPxIq5BzpZYwnT6RL/mtUd/DPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maKd0XBrQrtfUNAiqhGM55X9ITlMGpwwevkmoWteh64=;
 b=J9VWjqFxVF0nithTwwTOGhiF5hhWgSI/w0W9hsAkxGYq8EV7KB6keIT5lUGOtX3rqnwgEOJGcoQ0VwhM9FVnhWU4IcptyKY7LWtrpqAlgA+nJzTuq6+o7n0VSgNsOGPjNYCbUXsq0K3EUStW3izlKqm4s49IM0mMmQjJAKYItxU=
Received: from CYZPR05CA0009.namprd05.prod.outlook.com (2603:10b6:930:89::26)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 05:52:40 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::76) by CYZPR05CA0009.outlook.office365.com
 (2603:10b6:930:89::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.15 via Frontend
 Transport; Mon, 7 Aug 2023 05:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 05:52:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 00:52:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 00:52:23 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 00:52:19 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux@armlinux.org.uk>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v5 03/10] dmaengine: xilinx_dma: Pass AXI4-Stream control words to dma client
Date:   Mon, 7 Aug 2023 11:21:42 +0530
Message-ID: <1691387509-2113129-4-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ade9099-b0c3-4984-f380-08db970a847f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WaHYWHHwZHk/spKTgxO+c0r/0CWgqF2HJflRstA7riA4KXjBXNXmxfI71eD+VAA2yPCxCxVvfA4FoCvliQvjpQO30/zTqZhluH98beJOtBQLGMgWF6RmQ7nw3p0nM/s0LJ2ILT2/880hUM6cyyV6nyBZXNjq+Ne5ovHv7vS8ZUE1ga1Ryh56S2H66gwqnCDKpV7cIRIsOBKIspK8e99Epjn3CEQ01Vnmgt1ttNl/U7qCztz9B5/b3FIUGkXmqhYkaOkSvmMbnDd112kmHWwl3tVfUgKu4CrwU/UNI/rFXpUtW3Tn9R281xIBQSI119HjSSHZIp8lPfaZalxz87lIm7lkTK6x/Kv1GSD7Gfx7W2TiK3+csglv5CSvl4s5oiJdh+nsdY+uyTuu84SSEroZabPOjRAU+jxqsX+hRllPrIndASyg58IZHU88SSdZDp2WiuawWKAZiqjvM8hk/eJeDQ7n+rg3u4lzwLzQj6/YHdvTn3j2wwfulcRlncW9JVRtgcxL1i34a+GJJ8nt02I320mybFNkaDx5BCy6vD7D28S0aHYvFV17H1Hvp0df1aGHkPThPhxHYinKO5xiV9BpM84D36xz0hvFV2NPQV1dHPmMJy4zD0xUv8kDfPfYMwalcyzQfTAxp9UkFfMNNeeXOQt7kV/8GbkE7IYuMz9QvR0YrFJ9BiKDS99Xi3WggBn/ViTlW1LF94YGGTYh9IvLr7JqpYGmLF+w5M4OmkmbvZRtJiPokLDLvf8GeQNfoYVMa26/T6SplI1lDepJkTsmtrI60u3NgVYqsEwID8RJyBuAhBoEWNtvO59cf6eHuWx
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(186006)(82310400008)(1800799003)(40470700004)(46966006)(36840700001)(40480700001)(336012)(40460700003)(2616005)(36756003)(966005)(4326008)(316002)(86362001)(81166007)(478600001)(921005)(82740400003)(54906003)(110136005)(356005)(70206006)(70586007)(6666004)(41300700001)(26005)(426003)(8676002)(8936002)(47076005)(36860700001)(2906002)(7416002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 05:52:43.0252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ade9099-b0c3-4984-f380-08db970a847f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Read DT property to check if AXI DMA is connected to streaming IP
i.e axiethernet. If connected i.e xlnx,axistream-connected property
is present in the dma node then pass AXI4-Stream control words to dma
client using metadata_ops dmaengine API.

If not connected then driver won't support metadata_ops dmaengine API
and continue to support all legacy usecases.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v5:
- New patch in this series. Just a note that dmaengine series
  was earlier sent as separate series[1] and now it's merged
  with axiethernet series[2].
  [1]: https://lore.kernel.org/all/20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com
  [2]: https://lore.kernel.org/all/20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com
- Modified the commit description to describe driver behavior when
  xlnx,axistream-connected is not present.
- Switch to amd.com email address.
---
 drivers/dma/xilinx/xilinx_dma.c | 37 +++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index ac09f0e5f58d..d526e472b905 100644
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
@@ -2221,6 +2246,9 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 		segment->hw.control |= XILINX_DMA_BD_EOP;
 	}
 
+	if (chan->xdev->has_axistream_connected)
+		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;
+
 	return &desc->async_tx;
 
 error:
@@ -3067,6 +3095,11 @@ static int xilinx_dma_probe(struct platform_device *pdev)
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
@@ -3092,6 +3125,10 @@ static int xilinx_dma_probe(struct platform_device *pdev)
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
2.34.1

