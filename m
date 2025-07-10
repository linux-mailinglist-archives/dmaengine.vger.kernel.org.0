Return-Path: <dmaengine+bounces-5756-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 397F3AFFEDC
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jul 2025 12:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D602616199C
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jul 2025 10:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898622DA765;
	Thu, 10 Jul 2025 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ntgn95Yt"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3752D979A;
	Thu, 10 Jul 2025 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142372; cv=fail; b=Q7N8jAnGB2+A17dnnTQvf5zORqxiAEIworc8P6Vz4zUPk9T80DitozfmGJjSlKU0Q7FyCTMB2BYFvuvV/5tVH3y4QSw7aQ1dntPfvVyw9KIc9/gPM54dUKtQftnVRzeOfPfnYZqYgokP6oU2edOHcxcFXkiwkTJADLDegUR6APw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142372; c=relaxed/simple;
	bh=n5Rjb210IzzOqQpIruJQrWnyE3g2xDpybINImtI+asI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByJyJQsan2F8O6dyRkAfjB7FWmUB3C0LB3v8EZpkfSlZIv2l6ksy1duVFk0JibHQ1YZe4rh0tkZpdjxT6cMlbFAbQ2o3uU1EJbiMVFz8WdFNomFLOnLxINeR4ywDdGvQCezuljLacVzbOq70EOKMTR6WDt8+ZiBSEF9yxamrWKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ntgn95Yt; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJRPhI5BWMr9REwqbVxwA2Q9sGkqP+TFA7K/eFxHmr72sQrXyiHmWX4g6B+fJrwileKvVa1dS82moTA2KfAWniwUZeyCXDDPjPbo2H1tDtBUPVi5rlTqE1qe5VLfKfzUi6TXQR3jhJ3MhnpLRFyHwoGPKM2P5JN5P5Xkykt+XnwrFsAw0MGB2KCY9JokqkvfhcxWPUVJ9/V8lGz1diyETjQiC/+zJpNzm2ErK0RDVAhQsPdnM12PysplK/a4Lv8yCyB3nqNvgSSM9D7ZY6FTuWAfT/YDwi9kFeIl9Ebp6HAWqag9q20Pm7AB6Yt3QPk8uPOwPKoGJzfLRuMtHiqTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MayYYorEOPidrpNpZ7HVSjeXvwK8L5FUQg45RMjgMUE=;
 b=X7R03pSWLVd8qG77/p7tBMb+8x3p/pOZ5cNqFt5jnSv19MQw+fm1du7K0Wl+uz0Iy4GnrSdpbtZD+M4KYubtZIbc606a9Ptiq05cr54Ust1mSOQyaHaFEdz0eMm63gCg/fNv54XXb6u1GXzOci9A9fbBU1YNYD8ufK468o474psHUoSuI4IVsFkkBZHBi7yf6/SzpZrC45LKTXKSDDwTaXi8FlZap+dBlIAyDOD5xN2oGvlXgWPEPWnGi9euLduo8xox2JMuxSEVgMpccvcQSfuHTcR8dVRKzFNKPkIi4CaWloUpk9NFfiRZqdiYZ5EEgEf9xkuul3xQhmHEgD9g7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MayYYorEOPidrpNpZ7HVSjeXvwK8L5FUQg45RMjgMUE=;
 b=ntgn95Ytd1KVxwW3JPzErINgxvHx2O785fnOqVKo1773yLT/ZQRMDtl6kXlhw4hJQgejLMH37mQUrX9Fso5+yPESmbDYrhd/If3oCjVVAGCXjYpvHsaSe7sVc1sCCkcvyJDHPJfqodBES+y06hasJZzJODqlsG0dAFD5JwLma+w=
Received: from SJ0PR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:33b::33)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Thu, 10 Jul
 2025 10:12:46 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::8f) by SJ0PR05CA0028.outlook.office365.com
 (2603:10b6:a03:33b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.5 via Frontend Transport; Thu,
 10 Jul 2025 10:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 10:12:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 05:12:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 05:12:43 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 05:12:40 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <vkoul@kernel.org>,
	<radhey.shyam.pandey@amd.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<harini.katakam@amd.com>
Subject: [PATCH V2 3/4] dmaengine: xilinx_dma: Add support to configure/report coalesce parameters from/to client using AXI DMA
Date: Thu, 10 Jul 2025 15:42:28 +0530
Message-ID: <20250710101229.804183-4-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250710101229.804183-1-suraj.gupta2@amd.com>
References: <20250710101229.804183-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c3cc99-70dc-49be-d27c-08ddbf9a5069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+GalhR80w8vlprD/GAoCSS+VvIFXKt1ytb7qaPLaVBLsOFErK9E7ZpQX9nKp?=
 =?us-ascii?Q?7vzpzjV7Z/SLxOzlGLiPojf/q69ZJdCrd7yFNaUsfQusU61QE6NJWtys1N1z?=
 =?us-ascii?Q?rupR9ZtZbeNXm+GkjuORdhh0mpVqjO7KFdEBpCKZeP0tFGMhVEziP6rPktXF?=
 =?us-ascii?Q?cBKOO9sMMReUM7W2pAz+Yijg9Z6sdhgXkIvE61VF4ia6PKMr+xpz9ycs5INx?=
 =?us-ascii?Q?ETdOHaDCXWCmeMKdQv2najq4VFTNVTQ8dUuDaj/mGmy2LhR+WG7ZKxpRYit0?=
 =?us-ascii?Q?b11503/GXzuy2hguXZdr6CxIJFsAcRuvuV2zTB6NKP1eQtJnw+tf+nNc2j30?=
 =?us-ascii?Q?cL8ev7zBaAd2vacj9xHln+ABVDwyLNEoM30I9i3a9hkXxYIZRu59MPicodUd?=
 =?us-ascii?Q?vfWkL6VnJXxc3iU3a+7sK6gvbwwFigUwmjPOc6Tupsx+glnhGwQTnBHg4gUx?=
 =?us-ascii?Q?lD8zKQnpsh0S9Eys714AeQe0MNvwJh4MLrqON+R33IqHzoA9NT72cezB6yNx?=
 =?us-ascii?Q?J9q8yG/xIjIWwFeuvo4UF3mUDzRRc+6QmPkJydO/O72DV4tHWLOffRVWC3jz?=
 =?us-ascii?Q?6F7wsk39fGur4iS+1ebDqfLuUucMrSixpz5jnBkd/Ai3Frim6tI0baK1zciP?=
 =?us-ascii?Q?AesYIhO4IToY/Sd3sVQ1UFe6ui62bMou94NRAfSTJWvY9PJWRO/mmCFL6PCy?=
 =?us-ascii?Q?8egiJknhlFEUcbNINKsW7Ov0Vns+D/VK+spEMtKoSAX+3X1bNX80BBhGQk2k?=
 =?us-ascii?Q?WkTHZ/VON8VSvhncUd8nxNhCtBJifwKcyrXN8D7C5DQkoP5Ocehi+j0k0n49?=
 =?us-ascii?Q?UHwKm2R0TAdSGbZe1th+Xwucrw7/VfHZlKgxdOYlCf84wZyY6Wo9yr34LnAy?=
 =?us-ascii?Q?5GqvuCrKDBD6GMeDZpggM91EEcW1a16TwQoI5S/AynhtoMETw7YrfAZx2OVX?=
 =?us-ascii?Q?kDZADDZ1pB0UwQsofHalzStadGx9tQgPEMxDqx82SOmSKU8G1odyFGMsdcys?=
 =?us-ascii?Q?WAHQ3W6iZbApQmdIBFQSqR7c5tT3Q51qH6AF8yTxQHhzG7PmmeRUqPpezj3T?=
 =?us-ascii?Q?C3Nl7Qko5lOwOF5gE+K2ILnVrVgCKaKA1h8kgfPRAIZeC/Yx/KqxLZO/0+18?=
 =?us-ascii?Q?/4HrZY38yhImR7eLISZcwbUsrXajtEmzcAwVqZBZh1AcSGlzKZcGk56Fyh3+?=
 =?us-ascii?Q?2KtdpRY51Yb8Vl4afjKxoU6mHOJ7gKr94sWae3skDLjNDNX/COJWKiyN2xCM?=
 =?us-ascii?Q?evSMYNPG5Xr0FD0ZXX9tJ6hFLkClPchDgtQNo84yigacr0+I0Tb2HMy00EiM?=
 =?us-ascii?Q?/+5rBCKIA028zpD4HHsLrzdjoVXIPBV54mAVMlhyJe0T3WrIis84hI2x4GU5?=
 =?us-ascii?Q?8XmWL3+VaKE3CQhspRIzHelGsc1hajgNf2EV3VgJZRXk9WMrHJbX8sbaqlMQ?=
 =?us-ascii?Q?qO13UaHv43EnvkDsYTL3dlR6lpiyXxQlqveUqn0A6X4PZ1+FwXjSvts+d4xB?=
 =?us-ascii?Q?y/mMom9IVx5v4wKY+3KQmKpJQDaafNILqlgd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 10:12:45.0173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c3cc99-70dc-49be-d27c-08ddbf9a5069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341

AXI DMA supports interrupt coalescing. Client can fine-tune coalesce
parameters based on transaction load. Add support to configure/
report coalesce parameters.
Change delay setting to scale with SG clock rate rather than being a
fixed number of clock cycles (Referred from AXI ethernet driver).
Increase Buffer Descriptors ring size from 512 to 1024 to allow
sufficient space in BD ring during max coalesce count of 255.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 73 +++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 187749b7b8a6..26f328cd3e10 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -33,6 +33,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/dmapool.h>
 #include <linux/dma/xilinx_dma.h>
@@ -159,6 +160,9 @@
 		 XILINX_DMA_DMASR_SOF_EARLY_ERR | \
 		 XILINX_DMA_DMASR_DMA_INT_ERR)
 
+/* Constant to convert delay counts to microseconds */
+#define XILINX_DMA_DELAY_SCALE		(125ULL * USEC_PER_SEC)
+
 /* Axi VDMA Flush on Fsync bits */
 #define XILINX_DMA_FLUSH_S2MM		3
 #define XILINX_DMA_FLUSH_MM2S		2
@@ -184,7 +188,7 @@
 #define XILINX_DMA_BD_EOP		BIT(26)
 #define XILINX_DMA_BD_COMP_MASK		BIT(31)
 #define XILINX_DMA_COALESCE_MAX		255
-#define XILINX_DMA_NUM_DESCS		512
+#define XILINX_DMA_NUM_DESCS		1024
 #define XILINX_DMA_NUM_APP_WORDS	5
 
 /* AXI CDMA Specific Registers/Offsets */
@@ -403,6 +407,7 @@ struct xilinx_dma_tx_descriptor {
  * @terminating: Check for channel being synchronized by user
  * @tasklet: Cleanup work after irq
  * @config: Device configuration info
+ * @slave_cfg: Device configuration info from Dmaengine
  * @flush_on_fsync: Flush on Frame sync
  * @desc_pendingcount: Descriptor pending count
  * @ext_addr: Indicates 64 bit addressing is supported by dma channel
@@ -442,6 +447,7 @@ struct xilinx_dma_chan {
 	bool terminating;
 	struct tasklet_struct tasklet;
 	struct xilinx_vdma_config config;
+	struct dma_slave_config slave_cfg;
 	bool flush_on_fsync;
 	u32 desc_pendingcount;
 	bool ext_addr;
@@ -1540,7 +1546,9 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 {
 	struct xilinx_dma_tx_descriptor *head_desc, *tail_desc;
 	struct xilinx_axidma_tx_segment *tail_segment;
-	u32 reg;
+	struct dma_slave_config *slave_cfg = &chan->slave_cfg;
+	u64 clk_rate;
+	u32 reg, usec, timer;
 
 	if (chan->err)
 		return;
@@ -1561,14 +1569,32 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 
 	reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
 
-	if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
-		reg &= ~XILINX_DMA_CR_COALESCE_MAX;
+	reg &= ~XILINX_DMA_CR_COALESCE_MAX;
+	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
+
+	/* Use dma_slave_config if it has valid values */
+	if (slave_cfg->coalesce_cnt &&
+	    slave_cfg->coalesce_cnt <= XILINX_DMA_COALESCE_MAX)
+		reg |= slave_cfg->coalesce_cnt <<
+			XILINX_DMA_CR_COALESCE_SHIFT;
+	else if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX)
 		reg |= chan->desc_pendingcount <<
 				  XILINX_DMA_CR_COALESCE_SHIFT;
-	}
 
-	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
-	reg  |= chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
+	if (slave_cfg->coalesce_usecs <= XILINX_DMA_DMACR_DELAY_MAX)
+		usec = slave_cfg->coalesce_usecs;
+	else
+		usec = chan->irq_delay;
+
+	/* Scale with SG clock rate rather than being a fixed number of
+	 * clock cycles.
+	 * 1 Timeout Interval = 125 * (clock period of SG clock)
+	 */
+	clk_rate = clk_get_rate(chan->xdev->rx_clk);
+	timer = DIV64_U64_ROUND_CLOSEST((u64)usec * clk_rate,
+					XILINX_DMA_DELAY_SCALE);
+	timer = min(timer, FIELD_MAX(XILINX_DMA_DMACR_DELAY_MASK));
+	reg |= timer << XILINX_DMA_CR_DELAY_SHIFT;
 	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
 	if (chan->idle)
@@ -1701,9 +1727,41 @@ static void xilinx_dma_issue_pending(struct dma_chan *dchan)
 static int xilinx_dma_device_config(struct dma_chan *dchan,
 				    struct dma_slave_config *config)
 {
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+
+	if (chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIDMA)
+		return 0;
+
+	if (!config->coalesce_cnt ||
+	    config->coalesce_cnt > XILINX_DMA_DMACR_FRAME_COUNT_MAX ||
+	    config->coalesce_usecs > XILINX_DMA_DMACR_DELAY_MAX)
+		return -EINVAL;
+
+	chan->slave_cfg.coalesce_cnt = config->coalesce_cnt;
+	chan->slave_cfg.coalesce_usecs = config->coalesce_usecs;
+
 	return 0;
 }
 
+static void xilinx_dma_device_caps(struct dma_chan *dchan,
+				   struct dma_slave_caps *caps)
+{
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+	u64 clk_rate, timer;
+	u32 reg;
+
+	if (chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIDMA)
+		return;
+
+	reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
+	caps->coalesce_cnt = FIELD_GET(XILINX_DMA_CR_COALESCE_MAX, reg);
+
+	clk_rate = clk_get_rate(chan->xdev->rx_clk);
+	timer = FIELD_GET(XILINX_DMA_CR_DELAY_MAX, reg);
+	caps->coalesce_usecs = DIV64_U64_ROUND_CLOSEST(timer * XILINX_DMA_DELAY_SCALE,
+						       clk_rate);
+}
+
 /**
  * xilinx_dma_complete_descriptor - Mark the active descriptor as complete
  * @chan : xilinx DMA channel
@@ -3178,6 +3236,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	xdev->common.device_tx_status = xilinx_dma_tx_status;
 	xdev->common.device_issue_pending = xilinx_dma_issue_pending;
 	xdev->common.device_config = xilinx_dma_device_config;
+	xdev->common.device_caps = xilinx_dma_device_caps;
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		dma_cap_set(DMA_CYCLIC, xdev->common.cap_mask);
 		xdev->common.device_prep_slave_sg = xilinx_dma_prep_slave_sg;
-- 
2.25.1


