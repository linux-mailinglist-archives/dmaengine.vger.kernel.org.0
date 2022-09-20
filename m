Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CD75BDCB3
	for <lists+dmaengine@lfdr.de>; Tue, 20 Sep 2022 07:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiITFxe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Sep 2022 01:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiITFwm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Sep 2022 01:52:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5805C52DC9;
        Mon, 19 Sep 2022 22:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fy/bOUTMVXK63dFN4vIOiHbiJT0buqiuyVEK4kgH510XJj8QLFKqf3A3nHhaf2s4IAjV/S9aUppC39X9Ah2YUhBiI411oWdO517E8zMS12Hb751hG7tX2LxnOZspkgd3CmXspDCuM/NQwp7mf964hQuJarZL6j4PikO+/3ATOtchlZmSEcMjwPcv8Iu5BRxNDjLe7XfvS4EPI8d+NSewbpEM094KM8FzCtfUDoFFrUjG7bQi5GUu7PXcES1BQM7JUgaoCXM0bFbpLuVWYtVJO636DgXknwtsHVsqbQHHF6fIPrO8rd4He3+P+Hqr6ofn8bK64vU/z9NrE0qwXLHEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5orUK8nBhqdBEDHMBnoAS1sySktbTfLp0NvAF44yLqo=;
 b=j9a4SVAklk4hzCzRHfXbLOwFaBNYhqMO3NttszJlj8JU79Y4723p2yen3LJOyY70rAnlmj0PNV9J8cby5crdNYMWRbiOIRc4kgvVh4I6WNK8T5zcz3ri10nsWK1pXVzhw9jBEFCEffGSsaxYvzCF0iKW8xc8QU4IRfDu5PK2C/1d2i4K+QIg0S7kDOt0rBA3czAq/cF00zsn4rbK4gTAV5PwpqMWcZeQTYxLS22VpGVRHmwYvHwOI93x/9mDMc+w+j02v4jkOUJulodpok+2UoqOBDjIwXQ3Ys4fpcS7TUNdy3M3Lufv4ndO5xK9EfMpACBh/5MMebtV9n6ENzyvIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5orUK8nBhqdBEDHMBnoAS1sySktbTfLp0NvAF44yLqo=;
 b=OBrMi4TC/L6pa0Uej1j1uNEROrJx2B4MG99WgFtsl6SR773aILjrRqhBvpV2eQBoC6pKWjT7YEGlIAGBpy0CHg6ymfMs/adx19FnoKB06m6RvxJ2MFTnYmJhvMIlQnUYEXKEXEsX+UU8EUNHJhwGY8Qa/nYQNU/bvKO2EAgr+9A=
Received: from DS7PR05CA0019.namprd05.prod.outlook.com (2603:10b6:5:3b9::24)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 05:52:36 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::73) by DS7PR05CA0019.outlook.office365.com
 (2603:10b6:5:3b9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.7 via Frontend
 Transport; Tue, 20 Sep 2022 05:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 05:52:36 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 00:52:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 22:52:35 -0700
Received: from xhdswatia40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 20 Sep 2022 00:52:29 -0500
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
Subject: [RFC V3 PATCH 8/8] dmaengine: xilinx_dma: Add device_config support
Date:   Tue, 20 Sep 2022 11:21:19 +0530
Message-ID: <20220920055119.12634-9-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
References: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d919ff-300a-44b9-d5c3-08da9acc5210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IC7I6Rc1AFhhmzGiUiTSXmFCpGMsH4htFm8YdGK84Gppx7Q6fqk9RDYtj5rEIK8ib5PLXyc+IHNlfT3E+gRUehepvCxC/dCdCYoUs/N69j/dJRmNQvTv50lOHJuTWhS0NKmnrTtWZhbVoM+uJij/T2wvbmw03+cmNtYwsRMf9aITM/9yrPYjys7SKD0hasvHyS8HzJsA4mpQVo52L4j0GSEUPaKg4v72HdysqtBGKzmyzJC10yWuX78fUfkEy4UU6e8jxa53BXmlJBqFp6lchRsolDbxpbUcZ92FHJJgBAD7vQwdk3c+TNijUJtyMdjXZA/uZILPh+AHNb+o9E0m46NzyyZvI0KyIXaDd+Fdz7mTD9t2GTOG6dKGsiIfcm7kBCP3hE/VCE3/9yuo8ArCAh6SDj+JMSqX6ktz3Vkbnf8XQAHUrkc0c4Kc49vlp4/n4UdJHCyAWkZoQA1uM85jx/P0UCzfe7ND1LULATUFpQnZCC7tgMQZ7GWw+aZSeBvdFnPaAC1zmEXsK9/3uzVpL+Y5mGyygxz98IvbieVNlwIe1YjlFCr3JrQlS/4TEz16bLyGM4GCAZFTse1ILTMevxruB8u3TXOs1sl2qX7rf4JPmItUixpEwtiLFQ+CQNtcp/U/T46oWroni4uHtsXu7DqYo2w8sQC+iw/kp85IOxNYLoz/j6FWGLZz13GPfOqeIOkLXnyMU20RTQ6AkAZvhCFNFbF3lkGKU5wqzKwGX7khYQq1PIe9Pml09b9CH/9O24a59HftpdtJmI6zZnaJZGvWQykkItK1ZyOqRgp2+KOx35pRFF+fZ6ruVCkGK0O3
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(426003)(47076005)(186003)(1076003)(336012)(2616005)(82740400003)(81166007)(356005)(36860700001)(5660300002)(2906002)(8936002)(41300700001)(40480700001)(40460700003)(82310400005)(478600001)(26005)(6666004)(316002)(8676002)(70206006)(70586007)(54906003)(110136005)(4326008)(103116003)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:52:36.6093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d919ff-300a-44b9-d5c3-08da9acc5210
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DMA clients (ethernet driver) can use this interface to pass get/set
coalesce information.

Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
---
At present device_config support to program coalesce is only for AXIDMA
and once the RFC is accepted it will extended to other IP variants.

Changes in V3:
- New patch.
---
 drivers/dma/xilinx/xilinx_dma.c | 37 ++++++++++++++++++++++++++++++++-
 include/linux/dma/xilinx_dma.h  | 16 ++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index bd8f09837141..0a994c5f3ae0 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -414,6 +414,7 @@ struct xilinx_dma_tx_descriptor {
  * @tdest: TDEST value for mcdma
  * @has_vflip: S2MM vertical flip
  * @irq_delay: Interrupt delay timeout
+ * @has_static_coalesce: Used to check static/dynamic coalesce selection
  */
 struct xilinx_dma_chan {
 	struct xilinx_dma_device *xdev;
@@ -453,6 +454,7 @@ struct xilinx_dma_chan {
 	u16 tdest;
 	bool has_vflip;
 	u8 irq_delay;
+	u8 has_static_coalesce;
 };
 
 /**
@@ -1555,7 +1557,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 
 	reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
 
-	if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
+	if (!(chan->has_static_coalesce) && chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
 		reg &= ~XILINX_DMA_CR_COALESCE_MAX;
 		reg |= chan->desc_pendingcount <<
 				  XILINX_DMA_CR_COALESCE_SHIFT;
@@ -1696,6 +1698,39 @@ static void xilinx_dma_issue_pending(struct dma_chan *dchan)
 static int xilinx_dma_device_config(struct dma_chan *dchan,
 				    struct dma_slave_config *config)
 {
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+	u32 regval;
+
+	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
+		struct xilinx_peri_config *pconfig = config->peripheral_config;
+
+		if (!pconfig || config->peripheral_size != sizeof(*pconfig))
+			return -EINVAL;
+
+		switch (pconfig->cmd) {
+		case XILINX_DMA_GET_COALESCE:
+			regval = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
+			regval &= XILINX_DMA_CR_COALESCE_MAX;
+			*((int *)pconfig->data) = regval >> XILINX_DMA_CR_COALESCE_SHIFT;
+
+			break;
+		case XILINX_DMA_SET_COALESCE:
+			if ((*(int *)pconfig->data) <= XILINX_DMA_COALESCE_MAX) {
+				regval = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
+				regval &= ~XILINX_DMA_CR_COALESCE_MAX;
+				regval |= ((*(int *)pconfig->data) <<
+						 XILINX_DMA_CR_COALESCE_SHIFT);
+
+				dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, regval);
+				chan->has_static_coalesce = 1;
+			}
+
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/dma/xilinx_dma.h b/include/linux/dma/xilinx_dma.h
index 0dde1a46ab75..ce0267baf5eb 100644
--- a/include/linux/dma/xilinx_dma.h
+++ b/include/linux/dma/xilinx_dma.h
@@ -41,5 +41,21 @@ struct xilinx_vdma_config {
 
 int xilinx_vdma_channel_set_config(struct dma_chan *dchan,
 					struct xilinx_vdma_config *cfg);
+/**
+ * struct xilinx_peri_config -Configuration structure for user
+ * configurable commands and associated data.
+ *cmd:          cmd for passing any slave info. Example: ethtool get/set coalesce
+ *data:         data for cmd argument
+ */
+struct xilinx_peri_config {
+	int cmd;
+	void *data;
+};
+
+/**
+ * XILINX_DMA_GET/SET COALSCE -setting IP coalesce parameters
+ */
+#define XILINX_DMA_GET_COALESCE            1
+#define XILINX_DMA_SET_COALESCE            2
 
 #endif
-- 
2.25.1

