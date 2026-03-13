Return-Path: <dmaengine+bounces-9420-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCZiLUevs2lYZwAAu9opvQ
	(envelope-from <dmaengine+bounces-9420-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 07:31:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEF627E29B
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 07:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9E35307BE3A
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 06:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0090F366061;
	Fri, 13 Mar 2026 06:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QBQyIg1W"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D433D4E5;
	Fri, 13 Mar 2026 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383171; cv=fail; b=J6qKKUtXvfjZqfMNrnH6mRnc9bM+S4BrPg2yposLvpoJDZQqBa5OzDZitsXX2uRgdewKnVZF5Qjq4mlc+d/KDGv4mePPVQYIE/rrowug9y+e0b0wjoJjQGaWyTrvGdBTAysgRj8WJdAdYoQBIgqRzTBm1KsiM+0vmACMOQm1sHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383171; c=relaxed/simple;
	bh=yL1ghfsDqipCgRD1ct2YQxGN2Psr/awl9psIEdVNkHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9DnalO1eEVK6b3bu6BWkJZ+oYMN/qnB9Hnr4w5tKLXYrH9ciGqn9b1riQoqtOidjQCNBWh8ASATsTLPrFlpQoHv+CGIrfro6JJTwEGNzo1FQ783Go5v9xRRGYwgf2Vxa5PIlU+gTk+Nt9IyV0NoyYhB8t8/XeZlAnLoABsh264=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QBQyIg1W; arc=fail smtp.client-ip=52.101.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+zAZlJM0UlsXqB+REgcwtLcbWLQ6IDfa9mebfGpwth1Eq98zsXfwDtzrFaLGHgpcL2uMZmTa6Mwk+mHlUMtESsRr5vzypgU3WPL/LlaTMSk9+dNcGuOAhwR9txiIhBSkZmcQKZXZOSNWVzlQqn8mZVpKXYLRSAs3Oyh4tY8VADj4R6H8Ew7bh7kdVGYCOd/xVH4Qqpdr2VOfUvrxJ9iCTIPSUqiPm+rGY24OhekLwj0PARafkgidGE8qR+mRLB/uG9zLb88zPmVISPVNIqokmovhR/ak5HkMiXUilxdgQnswi5TDu9wySoJvHWpLuGJNK3D7HvZsZ7qezErxNtSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgbqRhipMDIayaFDocmfzNt0wzgprzN9K19aATD0X/A=;
 b=byEYfYLdbcObb9aI8eFQ/ezUHKqixEOGz/PCcpO/xN8/aIdejO/TIdQsbK75YFLT5/VMCkhfhUEm+g/NZXipGNV8KfivIE46csBFw0I2knHVFdT9hqT0Dn4WDNMKyW7inJVMKsoimqxPrHG54PvQOq1gzfSG4ii8XyMCJQ2BCan3bmGfktTSLv+CBtiApzc9t3jtW7q6zArFJ7fSOHnz9a4pzvKUYCphkZUGxgL7lTq4O4wKcBgqLy/U8gNCbtIp1OQBW9VLtwHtOkg6rICPIuZdiwi/i9yRZb/Ia3Gcrxmw7MSZvsAdnStYEGP9KNsSZM9CVGFKImFAZ+8/3EzUfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgbqRhipMDIayaFDocmfzNt0wzgprzN9K19aATD0X/A=;
 b=QBQyIg1WMIaOiJgvNbffstedRJegcjfWQ66IjSnYIaOkdMmnuImR0gQC34qxFeHFnSPyK1kFFmXSP/JG5FECK8KCmVQgPpkB+8H8WbMOVYKtSkhRmZWrkiW1bjMip8wWmFVj4LdouabtxQL/7yR0VVy8zeLD5SlICS3E7lEtcpA=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by IA0PPF6E99B1BC1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Fri, 13 Mar
 2026 06:26:07 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:59d:cafe::f7) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Fri,
 13 Mar 2026 06:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Fri, 13 Mar 2026 06:26:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 01:26:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 01:26:02 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 13 Mar 2026 01:25:58 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: Vinod Koul <vkoul@kernel.org>, <git@amd.com>, <srinivas.neeli@amd.com>
CC: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Suraj Gupta <suraj.gupta2@amd.com>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>, Thomas Gessler
	<thomas.gessler@brueckmann-gmbh.de>, Folker Schwesinger
	<dev@folker-schwesinger.de>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Kees Cook <kees@kernel.org>, Abin Joseph
	<abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 5/5] dmaengine: xilinx_dma: Add support for reporting transfer size to AXI DMA / MCDMA client when app fields are unavailable
Date: Fri, 13 Mar 2026 11:55:33 +0530
Message-ID: <20260313062533.421249-6-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313062533.421249-1-srinivas.neeli@amd.com>
References: <20260313062533.421249-1-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: 58494e2e-b0b1-495a-c236-08de80c96893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	g66BXdbgrgwR1ZAUOWxopkTcD5tvwSM4zwuHCReZcCDx9dgFsp2RT0qK6NKSGQeQ+JrkkNooAx1PmIT8nZ5hzM23cVO8mhZ1qqe1i7Mg8AKH0Pf1J2WSy84ryO3Fl5ep0HkAIcPMWZqoRCQLgEfk1LcEI+Skn6DLCkQvv4QsaZ04z3HYvP8VuQb1WqM49IhTxE3O1Omm40RXzTHNHa+TZENcRd0yi61+7EIELmwWCPDoOua7qFfAzgA43T2tca/SMMQKE1pwxAXyRvJBiSdMcWA0g5oyb2Lqk8QC1nURPlrUsXMQlwrbAng7YoraS4Dj/zj5WlhhPvtRXQF2VBaDJAKi4gId4outzfVqBrKvrTlP5tfXnfFbskhJiMoLqNaYCLpFsoTTwrZjczDQl0xsEbkDrJ/H7TgOw01887GXT8T2UGWNScmzuLPM85byRD4Y/AyT0FvL44t/RaIH1yuk+OF+s5Ynm/Z8E3/BXpRtG2mnyFY9ALVpzbGEIp9UbJa9Tk4+c4afF2U4BIrD0CsaqrJj8l2Atu9rKTmXtzJApzrW1m/yflUrLXg8CUBu+L3mMUD9rDWz3VvCRoaBVqX9cUGAHjuKiX+HmC7TT+Q7gL+fgbNHuwjv5VkbCGuhnQOohRGoS1WEl+Cj54bMbnpBQmyw9+YXA8B1FgAYdYK0nhjugDWddZhZobvCP+OMXytN6CmR9N7niX6afFVm1f2NWNVybrpYHK6iVqhMOmdM9es8BDL61sVFP2vEAzn4DoT7qjE+E0bPGbH8vi2dZxHBRA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N/gjkjgmWcGlLPV0dXES7G8tDXZrHRSHpv7QvO0qmDzpC3eEcP9Vr1634+zrXTY/xef6Zr8yHZEE0PKiUxAXQKIDaYUhmoN9rcvpxjNgpbQD8+u5R0N5BWagRPXRXvS21p04IhWGB0awixlTnKuUxkE1QWPDAhWha0ohkB+FkmjmSY9VuUIyKD3IbqzZAkPLTTafj/jY/Css0TxTP8H5magyfZRusiV6/VlT1gAU/8qDqPrMeVrjU1LakPVBvqDMpfgQRf+5UWAKg3eaivoKOKaMTH7fucaoMKzwaBD6oVb4Mx4ZjBAEAt0IFWEFIG8d4iXI2DVv0AqJOpvSVrvNZMOjArhDs1XS8pdputes1FFq+iSGCagkHp5qrdcqC3LvzM6Oz8vAw9KsfUiz5c/kNiLGgy3ytCcznt5pGRnYRkh4zLiUEufjF5Gz/BNgYDhX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 06:26:06.3386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58494e2e-b0b1-495a-c236-08de80c96893
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9420-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7AEF627E29B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Suraj Gupta <suraj.gupta2@amd.com>

The AXI4-stream status and control interface is optional in the AXI DMA /
MCDMA IP design; when it is not present, app fields are not available in
DMA descriptor. In such cases, the transferred byte count can be
communicated to the client using the status field (bits 0-25) of
AXI DMA / MCDMA descriptor.

Add a xferred_bytes field to struct xilinx_dma_tx_descriptor to record the
number of bytes transferred for each transaction. The value is calculated
using the existing xilinx_dma_get_residue() function, which traverses all
hardware descriptors associated with the async transaction descriptor,
avoiding redundant traversal.

The driver uses the xlnx,include-stscntrl-strm device tree property to
determine if the status/control stream interface is present and selects the
appropriate metadata source accordingly.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 52203d44e7a4..f5ef03a1297c 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -380,6 +380,8 @@ struct xilinx_cdma_tx_segment {
  * @cyclic: Check for cyclic transfers.
  * @err: Whether the descriptor has an error.
  * @residue: Residue of the completed descriptor
+ * @xferred_bytes: Number of bytes transferred by this transaction
+ *                 descriptor.
  */
 struct xilinx_dma_tx_descriptor {
 	struct xilinx_dma_chan *chan;
@@ -389,6 +391,7 @@ struct xilinx_dma_tx_descriptor {
 	bool cyclic;
 	bool err;
 	u32 residue;
+	u32 xferred_bytes;
 };
 
 /**
@@ -515,6 +518,7 @@ struct xilinx_dma_config {
  * @mm2s_chan_id: DMA mm2s channel identifier
  * @max_buffer_len: Max buffer length
  * @has_axistream_connected: AXI DMA connected to AXI Stream IP
+ * @has_stsctrl_stream: AXI4-stream status and control interface is enabled
  */
 struct xilinx_dma_device {
 	void __iomem *regs;
@@ -534,6 +538,7 @@ struct xilinx_dma_device {
 	u32 mm2s_chan_id;
 	u32 max_buffer_len;
 	bool has_axistream_connected;
+	bool has_stsctrl_stream;
 };
 
 /* Macros */
@@ -672,8 +677,12 @@ static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
 				       struct xilinx_axidma_tx_segment, node);
 		metadata_ptr = seg->hw.app;
 	}
-	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
-	return metadata_ptr;
+	if (desc->chan->xdev->has_stsctrl_stream) {
+		*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
+		return metadata_ptr;
+	}
+	*max_len = *payload_len = sizeof(desc->xferred_bytes);
+	return (void *)&desc->xferred_bytes;
 }
 
 static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
@@ -864,6 +873,7 @@ xilinx_dma_alloc_tx_descriptor(struct xilinx_dma_chan *chan)
 		return NULL;
 
 	desc->chan = chan;
+	desc->xferred_bytes = 0;
 	INIT_LIST_HEAD(&desc->segments);
 
 	return desc;
@@ -1014,6 +1024,7 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
 	struct xilinx_aximcdma_desc_hw *aximcdma_hw;
 	struct list_head *entry;
 	u32 residue = 0;
+	u32 xferred = 0;
 
 	list_for_each(entry, &desc->segments) {
 		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
@@ -1031,25 +1042,32 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
 			axidma_hw = &axidma_seg->hw;
 			residue += (axidma_hw->control - axidma_hw->status) &
 				   chan->xdev->max_buffer_len;
+			xferred += axidma_hw->status & chan->xdev->max_buffer_len;
 		} else {
 			aximcdma_seg =
 				list_entry(entry,
 					   struct xilinx_aximcdma_tx_segment,
 					   node);
 			aximcdma_hw = &aximcdma_seg->hw;
-			if (chan->direction == DMA_DEV_TO_MEM)
+			if (chan->direction == DMA_DEV_TO_MEM) {
 				residue +=
 					(aximcdma_hw->control -
 					 aximcdma_hw->s2mm_status) &
 					chan->xdev->max_buffer_len;
-			else
+				xferred += aximcdma_hw->s2mm_status &
+					chan->xdev->max_buffer_len;
+			} else {
 				residue +=
 					(aximcdma_hw->control -
 					 aximcdma_hw->mm2s_status) &
 					chan->xdev->max_buffer_len;
+				xferred += aximcdma_hw->mm2s_status &
+					chan->xdev->max_buffer_len;
+			}
 		}
 	}
 
+	desc->xferred_bytes = xferred;
 	return residue;
 }
 
@@ -3284,6 +3302,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	    xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
 		xdev->has_axistream_connected =
 			of_property_read_bool(node, "xlnx,axistream-connected");
+		xdev->has_stsctrl_stream =
+			of_property_read_bool(node, "xlnx,include-stscntrl-strm");
 	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
-- 
2.43.0


