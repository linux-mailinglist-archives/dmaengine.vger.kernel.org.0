Return-Path: <dmaengine+bounces-5757-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1ECAFFEDE
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jul 2025 12:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15BC642F1C
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jul 2025 10:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370402DE202;
	Thu, 10 Jul 2025 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KItlb1CO"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB882DBF48;
	Thu, 10 Jul 2025 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142375; cv=fail; b=HHhPpaqWR+9TGhee8eZtGySz/l9Qagi+pkGfvaa8ZmWGv71RePPe9jktp1At96TXp0b/JnieMq6GZ0Ubmh2EnBrMtIWlNMVaDCNA40993cWh2WBgUdgiS+WR9OC1zvzxMs/LCvaiXGBMeQwtz9DUWvTK+EewLcLGqzXz7QA899c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142375; c=relaxed/simple;
	bh=AAnnpm+V2v0iN9Kmhr01cpwIk67HbXyF5Uy255DDYMs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKQZUerAN530Dt0SYz6C/1S8Ysj47pxTZ08jjkxrRqpfvoz+F/KWF8zAwvezMRTF7DJfFz5sJq7YQ2gno1WqLH+U1LGOSLbVpmkYVJp1tlHi6I2MW/yyU9dH7e1HInD3uCJoUqWqGuUOqp+5S4ug7/KEaowbJlUaoEhnXepLgtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KItlb1CO; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GupAzM3Il9xk9RBx1MMgO7JtS+nTZm1IyB67xZwOMxT9VzcKvvUIEOZutdolklYzK70DjriHA85KcJW/40WsWn68ijeJyUCMEtk/Ryd2LMtTue4KqdCy6OFyq2HIwq5hOhg8zmPVeox5CPf03xXTBu6Bz1AXx0sT8BHOLlpVAi29ND8uSAry42Rwytnbzbvho2Ab8WzWgU/hi7M0w6SPwud+f6wHsK7HeL2hGJYQ3iCThGjQYhyWaiazRLJu6JIQer2YW8gcxde/iaZzfyQMRbAkgdgXPuUjP9/d79SLNUzujvizYR8LvFAUXyKeFkauPh3gK8kgU0Uh8uP8KF+xRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNMup2IpmOh1s1Pd/gNbiesQVrMnPezYTAGjH4drcnQ=;
 b=OrSe9mD54YupiSiUJCXxI/wM4zumW0xjDpKG7xLgGiuFcRVzouBdNzAHdaAtK/J86Wdq4SzRLa2L3Cb7ZhXtfaXWLPTHHH69mNle5sTgCFi85KAhGef9SpGoBFZlJmDBFuRmC460cXeHryk6pKReyDT4pDAw6RRG1C0nOFhfiMTM0PqnTW3E5l6sew8Zcsp1MKvzf8qG7HuOs3zN5E5EW8JE8v9TaSAkhosBLVN82sFVevSI1x3lnnPCtAq+uDi82K6uYFSvO7uGXDkPdyG+EyQd0FtFdLR3MvsUrmvvQ1H2jh96pwStoFdlT38zUXZ0z9yZSzFCpqLyDX4r06yw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNMup2IpmOh1s1Pd/gNbiesQVrMnPezYTAGjH4drcnQ=;
 b=KItlb1COnfHbLnEEoiHA8UdpdIIBMEB6FgZkqF26QGyPDD2b0AWyCMXt9IDSuoHqXs4Zg+7rI/exIrAN51T3jDX4f7OfpQWHEhyE9i+sCeguB3+iEgp0AdRyq03rep48qIEahr9IG9h5yhvfABJ1qEiUnKlEcUu9rZ1SnPBJN5A=
Received: from DM6PR02CA0164.namprd02.prod.outlook.com (2603:10b6:5:332::31)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 10:12:48 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::c9) by DM6PR02CA0164.outlook.office365.com
 (2603:10b6:5:332::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 10:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 10:12:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 05:12:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 05:12:46 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 05:12:43 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <vkoul@kernel.org>,
	<radhey.shyam.pandey@amd.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<harini.katakam@amd.com>
Subject: [PATCH V2 4/4] net: xilinx: axienet: Add ethtool support to configure/report irq coalescing parameters in DMAengine flow
Date: Thu, 10 Jul 2025 15:42:29 +0530
Message-ID: <20250710101229.804183-5-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|MW3PR12MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f2f611-7859-4141-1cad-08ddbf9a5205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DGzJPcGE60HZTK3KxGb4uWdGG/GtfRZJSaxvx+lfxlJVbjd5/Ilgcf6O1Y0O?=
 =?us-ascii?Q?T/D4yb8nZu/ltStLeNJzm9ZF//xLlkIm0sX7rkO46KgxNf92j1KI8uo4FcNN?=
 =?us-ascii?Q?9eQz7ftlOBgdugv1fdA/iaC1wA0j1BKJ/gNNxAIwRXohwKTsbXB+OKfHtIp7?=
 =?us-ascii?Q?JP9PVbSw2Cf7dAk2/okQEIZDAp6Zvu2+EF9wE5ky4qHtQQ4NJTmH87Z+sLCu?=
 =?us-ascii?Q?g+PjtIhZXLwg5NXUM/Die3f2cVtKHdsxR+6YE/XnsgkaqqoS/zit1XCImcjB?=
 =?us-ascii?Q?17ruwp3BdvLnNCA4pVAXXE4HusW9+PyHIxODoZvB1hYgOdaoN+E8pw6UlQqq?=
 =?us-ascii?Q?LSIbcyGC7XnrHSh+4LEsdah92LTQf0MzLW9+5jQDvrSbuovYG8dH7Dc1D7Sl?=
 =?us-ascii?Q?bMRkLDfYo/Eo1QGUDotEGf65yzdh955nA9qUQOK68ClAIzjsbOUOzWYD4j+D?=
 =?us-ascii?Q?TIKjWvX1YUPkm7HQOFYNE8vXjQE06isS3yj+KzyVBCl5fpRUmmnVYzEWrk5Z?=
 =?us-ascii?Q?gZ/mB24iU2EcnWqFaexvCpHHmle3SZOx1rk8GX20yQihj3FZ6yZj1NGlWo4Y?=
 =?us-ascii?Q?qzTvI/57beo+OiWxP60lwE6ka8Mr3yTyBmYxtMlpcvEaOoMVC3zebU/nRasr?=
 =?us-ascii?Q?jmqQ6nTCnD5yP7zLUqR4opDHC3BT4tGoN6paDGBwcsDzzeIKzCzjFe9NBN40?=
 =?us-ascii?Q?vF0aEECLor6B8ne9WWuKHpSx+KK3giHKeYy9u6SujveAMD/+1VeWLRRjT2F0?=
 =?us-ascii?Q?Jbg3yjjEaxmVC4OYtDwJkcp5OUcm1aa8DzVvvmWWbMBpK26AUr/xQgxvANyO?=
 =?us-ascii?Q?4UG6CSNGy8QVLFfHYPdhnEl/nBTUWulqIdbSUxz7PPK7bYMUSCL87c0UE6Yv?=
 =?us-ascii?Q?flGKa6rbhIfDyYWoLCdwHVEx/yIQx5KLQTp8wtxhvLHT9uSs774javpq7QHo?=
 =?us-ascii?Q?5a42sKX4fD9QFZDicvNiX989YZmF6uDKrMXHDBwjltAkHh7H6D/AT2Y7h85N?=
 =?us-ascii?Q?H+mgt952wcnph3yjph6obWjp93fIDXTLociq8TfH/BnRIzpJVSDdJ8sxRivB?=
 =?us-ascii?Q?qZUw7IxDx08L5cNQ6SFeDKCgKMOA+Z+7A8YXjhAZGNj9WqwSZCFeA5/AtjdT?=
 =?us-ascii?Q?w4Ww639BxVSHlcsGtK9W5B2x8CiEfQY6KwNDXAYQm8TAReAkb7H/NloSPCe5?=
 =?us-ascii?Q?WriDTqx3LoKHSrIPkqyagTUsoDL5YLv+l1LseXgZNuQtV0EjEL2LU4Rs+2sX?=
 =?us-ascii?Q?SGzteyfOjpnoXM/icf/C1JYqj5Fi0cTWooG/YiYt3T5jLWYr8WE8q0LXLpXA?=
 =?us-ascii?Q?I9mo+52CvhWrQyoCm/rrHnE4hswH1+GIOfaxxUHFT1ppRGFjjFB8hLPgkv9B?=
 =?us-ascii?Q?UzakjusQYrVaGNeqYjxkvyWsZzuR6PqbFYTUNOKwAjg2ToF3eR4AfE7nu2PI?=
 =?us-ascii?Q?en3BL9xH2xSS2JNRXkoVDxIaaeFd8MvrawhpJ7KRLtV1vw4MjU7mzOCffBvX?=
 =?us-ascii?Q?5afIATT20lMStkZLJFdlnOoetBXk0QpLz3BY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 10:12:47.7714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f2f611-7859-4141-1cad-08ddbf9a5205
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394

Add support to configure and report interrupt coalesce count and delay
via ethtool in DMAEngine flow.
Enable Tx and Rx adaptive irq coalescing with DIM to allow runtime
configuration of coalesce count based on load. CQE profiles same as
legacy (non-dmaengine) flow are used.
Increase Rx skb ring size from 128 as maximum coalesce packets are 255.

Netperf numbers and CPU usage after DIM:
TCP Tx:	885 Mb/s, 27.02%
TCP Rx:	640 Mb/s, 27.73%
UDP Tx: 857 Mb/s, 25.00%
UDP Rx:	730 Mb/s, 23.94%

Above numbers are observed with 4x Cortex-a53.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  13 +-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 190 +++++++++++++++++-
 2 files changed, 190 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 5ff742103beb..747efde9a05f 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -126,6 +126,9 @@
 #define XAXIDMA_DFT_TX_USEC		50
 #define XAXIDMA_DFT_RX_USEC		16
 
+/* Default TX delay timer value for SGDMA mode with DMAEngine */
+#define XAXIDMAENGINE_DFT_TX_USEC	16
+
 #define XAXIDMA_BD_CTRL_TXSOF_MASK	0x08000000 /* First tx packet */
 #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet */
 #define XAXIDMA_BD_CTRL_ALL_MASK	0x0C000000 /* All control bits */
@@ -485,8 +488,11 @@ struct skbuf_dma_descriptor {
  * @dma_regs:	Base address for the axidma device address space
  * @napi_rx:	NAPI RX control structure
  * @rx_dim:     DIM state for the receive queue
- * @rx_dim_enabled: Whether DIM is enabled or not
- * @rx_irqs:    Number of interrupts
+ * @tx_dim:     DIM state for the transmit queue
+ * @rx_dim_enabled: Whether Rx DIM is enabled or not
+ * @tx_dim_enabled: Whether Tx DIM is enabled or not
+ * @rx_irqs:    Number of Rx interrupts
+ * @tx_irqs:    Number of Tx interrupts
  * @rx_cr_lock: Lock protecting @rx_dma_cr, its register, and @rx_dma_started
  * @rx_dma_cr:  Nominal content of RX DMA control register
  * @rx_dma_started: Set when RX DMA is started
@@ -570,8 +576,11 @@ struct axienet_local {
 
 	struct napi_struct napi_rx;
 	struct dim rx_dim;
+	struct dim tx_dim;
 	bool rx_dim_enabled;
+	bool tx_dim_enabled;
 	u16 rx_irqs;
+	u16 tx_irqs;
 	spinlock_t rx_cr_lock;
 	u32 rx_dma_cr;
 	bool rx_dma_started;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 6011d7eae0c7..2c7cc092fbe8 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -54,7 +54,7 @@
 #define RX_BD_NUM_MAX			4096
 #define DMA_NUM_APP_WORDS		5
 #define LEN_APP				4
-#define RX_BUF_NUM_DEFAULT		128
+#define RX_BUF_NUM_DEFAULT		512
 
 /* Must be shorter than length of ethtool_drvinfo.driver field to fit */
 #define DRIVER_NAME		"xaxienet"
@@ -869,6 +869,7 @@ static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
 	struct netdev_queue *txq;
 	int len;
 
+	WRITE_ONCE(lp->tx_irqs, READ_ONCE(lp->tx_irqs) + 1);
 	skbuf_dma = axienet_get_tx_desc(lp, lp->tx_ring_tail++);
 	len = skbuf_dma->skb->len;
 	txq = skb_get_tx_queue(lp->ndev, skbuf_dma->skb);
@@ -881,6 +882,17 @@ static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
 	netif_txq_completed_wake(txq, 1, len,
 				 CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),
 				 2);
+
+	if (READ_ONCE(lp->tx_dim_enabled)) {
+		struct dim_sample sample = {
+			.time = ktime_get(),
+			.pkt_ctr = u64_stats_read(&lp->tx_packets),
+			.byte_ctr = u64_stats_read(&lp->tx_bytes),
+			.event_ctr = READ_ONCE(lp->tx_irqs),
+		};
+
+		net_dim(&lp->tx_dim, &sample);
+	}
 }
 
 /**
@@ -1161,6 +1173,7 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	struct sk_buff *skb;
 	u32 *app_metadata;
 
+	WRITE_ONCE(lp->rx_irqs, READ_ONCE(lp->rx_irqs) + 1);
 	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
 	skb = skbuf_dma->skb;
 	app_metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc, &meta_len,
@@ -1179,7 +1192,18 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	u64_stats_add(&lp->rx_bytes, rx_len);
 	u64_stats_update_end(&lp->rx_stat_sync);
 	axienet_rx_submit_desc(lp->ndev);
+
 	dma_async_issue_pending(lp->rx_chan);
+	if (READ_ONCE(lp->rx_dim_enabled)) {
+		struct dim_sample sample = {
+			.time = ktime_get(),
+			.pkt_ctr = u64_stats_read(&lp->rx_packets),
+			.byte_ctr = u64_stats_read(&lp->rx_bytes),
+			.event_ctr = READ_ONCE(lp->rx_irqs),
+		};
+
+		net_dim(&lp->rx_dim, &sample);
+	}
 }
 
 /**
@@ -1492,6 +1516,9 @@ static void axienet_rx_submit_desc(struct net_device *ndev)
 	dev_kfree_skb(skb);
 }
 
+static u32 axienet_dim_coalesce_count_rx(struct axienet_local *lp);
+static u32 axienet_dim_coalesce_count_tx(struct axienet_local *lp);
+
 /**
  * axienet_init_dmaengine - init the dmaengine code.
  * @ndev:       Pointer to net_device structure
@@ -1505,6 +1532,7 @@ static int axienet_init_dmaengine(struct net_device *ndev)
 {
 	struct axienet_local *lp = netdev_priv(ndev);
 	struct skbuf_dma_descriptor *skbuf_dma;
+	struct dma_slave_config tx_config, rx_config;
 	int i, ret;
 
 	lp->tx_chan = dma_request_chan(lp->dev, "tx_chan0");
@@ -1520,6 +1548,22 @@ static int axienet_init_dmaengine(struct net_device *ndev)
 		goto err_dma_release_tx;
 	}
 
+	tx_config.coalesce_cnt = axienet_dim_coalesce_count_tx(lp);
+	tx_config.coalesce_usecs = XAXIDMAENGINE_DFT_TX_USEC;
+	rx_config.coalesce_cnt = axienet_dim_coalesce_count_rx(lp);
+	rx_config.coalesce_usecs =  XAXIDMA_DFT_RX_USEC;
+
+	ret = dmaengine_slave_config(lp->tx_chan, &tx_config);
+	if (ret) {
+		dev_err(lp->dev, "Failed to configure Tx coalesce parameters\n");
+		goto err_dma_release_tx;
+	}
+	ret = dmaengine_slave_config(lp->rx_chan, &rx_config);
+	if (ret) {
+		dev_err(lp->dev, "Failed to configure Rx coalesce parameters\n");
+		goto err_dma_release_tx;
+	}
+
 	lp->tx_ring_tail = 0;
 	lp->tx_ring_head = 0;
 	lp->rx_ring_tail = 0;
@@ -1692,6 +1736,7 @@ static int axienet_open(struct net_device *ndev)
 		free_irq(lp->eth_irq, ndev);
 err_phy:
 	cancel_work_sync(&lp->rx_dim.work);
+	cancel_work_sync(&lp->tx_dim.work);
 	cancel_delayed_work_sync(&lp->stats_work);
 	phylink_stop(lp->phylink);
 	phylink_disconnect_phy(lp->phylink);
@@ -1722,6 +1767,7 @@ static int axienet_stop(struct net_device *ndev)
 	}
 
 	cancel_work_sync(&lp->rx_dim.work);
+	cancel_work_sync(&lp->tx_dim.work);
 	cancel_delayed_work_sync(&lp->stats_work);
 
 	phylink_stop(lp->phylink);
@@ -2104,6 +2150,15 @@ static u32 axienet_dim_coalesce_count_rx(struct axienet_local *lp)
 	return min(1 << (lp->rx_dim.profile_ix << 1), 255);
 }
 
+/**
+ * axienet_dim_coalesce_count_tx() - TX coalesce count for DIM
+ * @lp: Device private data
+ */
+static u32 axienet_dim_coalesce_count_tx(struct axienet_local *lp)
+{
+	return min(1 << (lp->tx_dim.profile_ix << 1), 255);
+}
+
 /**
  * axienet_rx_dim_work() - Adjust RX DIM settings
  * @work: The work struct
@@ -2120,6 +2175,40 @@ static void axienet_rx_dim_work(struct work_struct *work)
 	lp->rx_dim.state = DIM_START_MEASURE;
 }
 
+/**
+ * axienet_rx_dim_work_dmaengine() - Adjust RX DIM settings in dmaengine
+ * @work: The work struct
+ */
+static void axienet_rx_dim_work_dmaengine(struct work_struct *work)
+{
+	struct axienet_local *lp =
+		container_of(work, struct axienet_local, rx_dim.work);
+	struct dma_slave_config cfg = {
+		.coalesce_cnt	= axienet_dim_coalesce_count_rx(lp),
+		.coalesce_usecs	= 16,
+	};
+
+	dmaengine_slave_config(lp->rx_chan, &cfg);
+	lp->rx_dim.state = DIM_START_MEASURE;
+}
+
+/**
+ * axienet_tx_dim_work_dmaengine() - Adjust RX DIM settings in dmaengine
+ * @work: The work struct
+ */
+static void axienet_tx_dim_work_dmaengine(struct work_struct *work)
+{
+	struct axienet_local *lp =
+		container_of(work, struct axienet_local, tx_dim.work);
+	struct dma_slave_config cfg = {
+		.coalesce_cnt	= axienet_dim_coalesce_count_tx(lp),
+		.coalesce_usecs	= 16,
+	};
+
+	dmaengine_slave_config(lp->tx_chan, &cfg);
+	lp->tx_dim.state = DIM_START_MEASURE;
+}
+
 /**
  * axienet_update_coalesce_tx() - Set TX CR
  * @lp: Device private data
@@ -2171,6 +2260,20 @@ axienet_ethtools_get_coalesce(struct net_device *ndev,
 	u32 cr;
 
 	ecoalesce->use_adaptive_rx_coalesce = lp->rx_dim_enabled;
+	ecoalesce->use_adaptive_tx_coalesce = lp->tx_dim_enabled;
+
+	if (lp->use_dmaengine) {
+		struct dma_slave_caps tx_caps, rx_caps;
+
+		dma_get_slave_caps(lp->tx_chan, &tx_caps);
+		dma_get_slave_caps(lp->rx_chan, &rx_caps);
+
+		ecoalesce->tx_max_coalesced_frames = tx_caps.coalesce_cnt;
+		ecoalesce->tx_coalesce_usecs = tx_caps.coalesce_usecs;
+		ecoalesce->rx_max_coalesced_frames = rx_caps.coalesce_cnt;
+		ecoalesce->rx_coalesce_usecs = rx_caps.coalesce_usecs;
+		return 0;
+	}
 
 	spin_lock_irq(&lp->rx_cr_lock);
 	cr = lp->rx_dma_cr;
@@ -2208,8 +2311,10 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 			      struct netlink_ext_ack *extack)
 {
 	struct axienet_local *lp = netdev_priv(ndev);
-	bool new_dim = ecoalesce->use_adaptive_rx_coalesce;
-	bool old_dim = lp->rx_dim_enabled;
+	bool new_rxdim = ecoalesce->use_adaptive_rx_coalesce;
+	bool new_txdim = ecoalesce->use_adaptive_tx_coalesce;
+	bool old_rxdim = lp->rx_dim_enabled;
+	bool old_txdim = lp->tx_dim_enabled;
 	u32 cr, mask = ~XAXIDMA_CR_RUNSTOP_MASK;
 
 	if (ecoalesce->rx_max_coalesced_frames > 255 ||
@@ -2224,20 +2329,76 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 		return -EINVAL;
 	}
 
-	if (((ecoalesce->rx_max_coalesced_frames > 1 || new_dim) &&
+	if (((ecoalesce->rx_max_coalesced_frames > 1 || new_rxdim) &&
 	     !ecoalesce->rx_coalesce_usecs) ||
-	    (ecoalesce->tx_max_coalesced_frames > 1 &&
+	    ((ecoalesce->tx_max_coalesced_frames > 1 || new_txdim) &&
 	     !ecoalesce->tx_coalesce_usecs)) {
 		NL_SET_ERR_MSG(extack,
 			       "usecs must be non-zero when frames is greater than one");
 		return -EINVAL;
 	}
 
-	if (new_dim && !old_dim) {
+	if (lp->use_dmaengine)	{
+		struct dma_slave_config tx_cfg, rx_cfg;
+		int ret;
+
+		if (new_rxdim && !old_rxdim) {
+			rx_cfg.coalesce_cnt = axienet_dim_coalesce_count_rx(lp);
+			rx_cfg.coalesce_usecs = ecoalesce->rx_coalesce_usecs;
+		} else if (!new_rxdim) {
+			if (old_rxdim) {
+				WRITE_ONCE(lp->rx_dim_enabled, false);
+				flush_work(&lp->rx_dim.work);
+			}
+
+			rx_cfg.coalesce_cnt = ecoalesce->rx_max_coalesced_frames;
+			rx_cfg.coalesce_usecs = ecoalesce->rx_coalesce_usecs;
+		} else {
+			rx_cfg.coalesce_cnt = ecoalesce->rx_max_coalesced_frames;
+			rx_cfg.coalesce_usecs = ecoalesce->rx_coalesce_usecs;
+		}
+
+		if (new_txdim && !old_txdim) {
+			tx_cfg.coalesce_cnt = axienet_dim_coalesce_count_tx(lp);
+			tx_cfg.coalesce_usecs = ecoalesce->tx_coalesce_usecs;
+		} else if (!new_txdim) {
+			if (old_txdim) {
+				WRITE_ONCE(lp->tx_dim_enabled, false);
+				flush_work(&lp->tx_dim.work);
+			}
+
+			tx_cfg.coalesce_cnt = ecoalesce->tx_max_coalesced_frames;
+			tx_cfg.coalesce_usecs = ecoalesce->tx_coalesce_usecs;
+		} else {
+			tx_cfg.coalesce_cnt = ecoalesce->tx_max_coalesced_frames;
+			tx_cfg.coalesce_usecs = ecoalesce->tx_coalesce_usecs;
+		}
+
+		ret = dmaengine_slave_config(lp->rx_chan, &rx_cfg);
+		if (ret) {
+			NL_SET_ERR_MSG(extack, "failed to set rx coalesce parameters");
+			return ret;
+		}
+
+		if (new_rxdim && !old_rxdim)
+			WRITE_ONCE(lp->rx_dim_enabled, true);
+
+		ret = dmaengine_slave_config(lp->tx_chan, &tx_cfg);
+		if (ret) {
+			NL_SET_ERR_MSG(extack, "failed to set tx coalesce parameters");
+			return ret;
+		}
+		if (new_txdim && !old_txdim)
+			WRITE_ONCE(lp->tx_dim_enabled, true);
+
+		return 0;
+	}
+
+	if (new_rxdim && !old_rxdim) {
 		cr = axienet_calc_cr(lp, axienet_dim_coalesce_count_rx(lp),
 				     ecoalesce->rx_coalesce_usecs);
-	} else if (!new_dim) {
-		if (old_dim) {
+	} else if (!new_rxdim) {
+		if (old_rxdim) {
 			WRITE_ONCE(lp->rx_dim_enabled, false);
 			napi_synchronize(&lp->napi_rx);
 			flush_work(&lp->rx_dim.work);
@@ -2252,7 +2413,7 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 	}
 
 	axienet_update_coalesce_rx(lp, cr, mask);
-	if (new_dim && !old_dim)
+	if (new_rxdim && !old_rxdim)
 		WRITE_ONCE(lp->rx_dim_enabled, true);
 
 	cr = axienet_calc_cr(lp, ecoalesce->tx_max_coalesced_frames,
@@ -2496,7 +2657,7 @@ axienet_ethtool_get_rmon_stats(struct net_device *dev,
 static const struct ethtool_ops axienet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+				     ETHTOOL_COALESCE_USE_ADAPTIVE,
 	.get_drvinfo    = axienet_ethtools_get_drvinfo,
 	.get_regs_len   = axienet_ethtools_get_regs_len,
 	.get_regs       = axienet_ethtools_get_regs,
@@ -3041,7 +3202,14 @@ static int axienet_probe(struct platform_device *pdev)
 
 	spin_lock_init(&lp->rx_cr_lock);
 	spin_lock_init(&lp->tx_cr_lock);
-	INIT_WORK(&lp->rx_dim.work, axienet_rx_dim_work);
+	if (lp->use_dmaengine) {
+		INIT_WORK(&lp->rx_dim.work, axienet_rx_dim_work_dmaengine);
+		INIT_WORK(&lp->tx_dim.work, axienet_tx_dim_work_dmaengine);
+		lp->tx_dim_enabled = true;
+		lp->tx_dim.profile_ix = 1;
+	} else {
+		INIT_WORK(&lp->rx_dim.work, axienet_rx_dim_work);
+	}
 	lp->rx_dim_enabled = true;
 	lp->rx_dim.profile_ix = 1;
 	lp->rx_dma_cr = axienet_calc_cr(lp, axienet_dim_coalesce_count_rx(lp),
-- 
2.25.1


