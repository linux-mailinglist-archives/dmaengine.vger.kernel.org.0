Return-Path: <dmaengine+bounces-12111-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6pzKHNkjTmrCDwIAu9opvQ
	(envelope-from <dmaengine+bounces-12111-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 12:18:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D3272428A
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 12:18:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=mY8c7nsp;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12111-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12111-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D009B306DAB1
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA5F38E8AB;
	Wed,  8 Jul 2026 10:09:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012009.outbound.protection.outlook.com [40.107.200.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C538B148;
	Wed,  8 Jul 2026 10:09:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505374; cv=fail; b=cTUYlsCbi7uywRrYK6CI+Je12mxXIi+ldN1sgdS7IcPv9v0d5rJqflER47oQ9aHrNuP4nKuhmVlEf5hUHndGoCt8c5T3USqnyXivShvnob2byH0rYmfK3hTDqpjsmDM9cZz3euYKJUtOTIlI1vEtz4FoGzmTvBZ+2x9IDySVsL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505374; c=relaxed/simple;
	bh=iBYahiTjcGkUftCG/C9uCBbrpRtk3YhnZ6TftwwukaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/OHOhOEf5gcrwrwmCeL7/4hk9/fpnHjp7OTGQ16JXYNk6Ajh+1/mcgH5zJf62u90WmVRvhkkAZqLpLGuQbu3XDuY7WohZ2LvofU/6nHlUxE61PREe0ZRCcV+MoR52xu1MpOo1G6RAi5Rus9L7H2gIMEMlE4OMvwrhr7OjDA/qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mY8c7nsp; arc=fail smtp.client-ip=40.107.200.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SV2ZyLMwt0yKFqHNPy0CJsXRL8K+vjfo7KllWwbqrmPJKG3EavFFtb+zvlXqDC3E1wgXMXeRMCUK/xrBu37gc00aINhCy2+qmxfFFp/H6YJch8D9cBR/ouWZTjNb/3tDrQBPpjv5XAnbU4hFT6KGlrKz4yjCFWCrk0GJsnYEH+t6VSrM9zc1/tvepYkHVRYcaPnjfmbk4ki8ZVvA0ekXs+Yu7vXfmYVC5gEkH9WGvUPq93LAGA/OGpdjV64v3Kan9gg9IQMdsSL3R74rWyGBQD1DBPgbnJuaHtObRM87YNYrnoRVX6UExa5uGcoUbeWjP6KrxQfi0BiAKhOVG2rV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WMoS/ovH5R70sG6+36NfWfL8o7Nc/Ugk8e+ZCTFUiQ=;
 b=DOo66ui/cFlvR/qqTtTRnBQCi/waGZ057H9U6yAdno9bA8N09z07heBAsuR+18N/c5KHDg4QOKWINCwe0TwOV1gCyPdZ3HUaFZcmHJIRn61zBnKMITEgMXO2WeEfA3C3jmAlev/od3J6slIUCzdNafGnJGZOyxDAFDtLWUQVzFU+33LL6hp9847cUY9G7e024cp7jg4kL97J+wCyfkvAQofwu8c+WpWIzbDijTCGVTj20AZHTPepGiF3wGlSq9/X9LUKdzoUl+5SqZQ3UFiBM86gg/R+T8Bf8HLf0xT/PnJLtc8k23ZojFOncO5w+d+s1HxK21dEBGrRo6ifnQC/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WMoS/ovH5R70sG6+36NfWfL8o7Nc/Ugk8e+ZCTFUiQ=;
 b=mY8c7nspkDMSYZ19SMXkQKEu55zGRawQAJPzR0IetIJcjfIlV3wv8xLIY9HtzQZ7itrbvWQVfgTn/2j+Zk3fcRgb+2FIN3G10BZka33OD+dItiORXjiEMpHvS4/fSMJvVlHMVCR2YFDFKMtIvoafbsoOVrTU5CPgTwWXsxqe0no=
Received: from BN9PR03CA0464.namprd03.prod.outlook.com (2603:10b6:408:139::19)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 10:09:24 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::4a) by BN9PR03CA0464.outlook.office365.com
 (2603:10b6:408:139::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 10:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 10:09:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 05:09:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 03:09:23 -0700
Received: from xhdsneeli41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 8 Jul 2026 05:09:18 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
CC: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Suraj Gupta
	<suraj.gupta2@amd.com>, Marek Vasut <marex@nabladev.com>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Alex Bereza <alex@bereza.email>, "Folker
 Schwesinger" <dev@folker-schwesinger.de>, <dmaengine@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH V3 2/4] dmaengine: xilinx_dma: Move descriptors to done list based on completion bit
Date: Wed, 8 Jul 2026 15:36:50 +0530
Message-ID: <20260708100652.603074-3-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260708100652.603074-1-srinivas.neeli@amd.com>
References: <20260708100652.603074-1-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbbca9c-bc06-4e24-7a71-08dedcd8fca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|23010399003|56012099006|6133799003|5023799004|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	CBofmeMnVE2FkWGYJUnUL07eHPwbqEZfDcTjYLgM0NrNeUgqSGQSAJIRxcOTrdWyxz+RBl62LbNjRFueQV6vjALVOT+t0y7UY+qewjeTZvkp3c8Cm99pHzDERAkE2uNMmJCRYUoQckjOiq88DxyRLck2btAIlW0vd4HMK8rV3xNSZub6AOQ0oYc7KlrH3670AabgbiLWbDT+ElYe0iSVyAeP7n9t5v5/7hmGPlBMb9XEgUFCyK69j9MKilovjXNBt8SLpjh8uEJ+i/ZZOUOzkFArJQIFsX3MfPxjDG15DySSeitAyeTZbFjNNAlB1rUI3IwPn3h0ekJEY6TS4U2c0+yVertjYf3rJEJa0bgCtEfJzx7qAhG/nygFuOVR58bMobS/yXFBFy387TEFeEvSCM/A5DKJSDe7XPIln99ml/V1U+4m1bHBHuth2+KGVXJBCE3NnvWg7X8p1FbmJopPGBFVnahpG4gNMquiRknXd+8Gwd9JmiM5wOZ4e//JZhqO+lrv4RGNPD/qFw8F+hfdS3gCw0gv18rWKJ1lfVEs+EvjVAZ+X7l06XFx+pKWP9tpuqM2wgeIZ3zYAKbSKhEDuSUxgiPCcs6OOFeZFROoIcaJ5jNbbNQzRBtz2EhUGv03XSouBlXR2/EuoQ8GeNdFNWX2h+7+1J6jmsS45Hru4lFVk7LAphTOBIuJlqxd63aqdeMVaOIe0zZbZkYm+8jz0w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(23010399003)(56012099006)(6133799003)(5023799004)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H3yiQ5socwUdQ9owVs4u1ZuMgMdrOCoCb9zNuRjhkXUFiE4vofWdj2SVv+4yI0H9WrkBBxoloOP4F+6nMG6G2xqLAiEpYP6YdKbB0rB6kcnVXT687Sd1qZFCxKN6rH+bnu7ec2IxFOscwsxEUz57TCJrJ+2Knb2poBPv8/XwvyIdk74HBELpUN0V4oob3NqBLkQXVlKuv8aT/SZWuvs/y0TRigygZz/Oxd10nzMNEkUlrVZsgp5VAB6JK2ACI7s1T7NiGGSjriGVpOQC6ZXbgD8VSgHHs1N2qNioRGPekAl/UcGCXXm8WjRgi5k2DXTE3M9AzwZGMdfPCdfTlpV73qKNUvHVvEqTFCsbw7b2aaZ3YqSvMd7/ubukoMzO7UOPacA36l3pmwKG1JhwBiuwOMmYxEHJRYhxMzgRZnsjeWliWMglnFUmn1uY873TVV5C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:09:24.2603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbbca9c-bc06-4e24-7a71-08dedcd8fca6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-12111-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:radhey.shyam.pandey@amd.com,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:suraj.gupta2@amd.com,m:marex@nabladev.com,m:tomi.valkeinen@ideasonboard.com,m:alex@bereza.email,m:dev@folker-schwesinger.de,m:dmaengine@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:git@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3D3272428A

In AXI MCDMA scatter-gather mode, xilinx_dma_complete_descriptor() walks
the channel's active_list and unconditionally moves every entry to the
done_list. The MCDMA IOC interrupt handler invokes this function on
every interrupt-on-completion, but with interrupt coalescing
(IRQThreshold > 1) an IOC interrupt may fire after only a subset of the
queued descriptors have actually been processed by the hardware. As a
result, descriptors whose completion bit is not yet set in the BD status
were being reported as completed to client drivers.

Add a check for the descriptor completion bit before moving entries from
the active list to the done list, using the appropriate direction-
specific status field (s2mm_status for DMA_DEV_TO_MEM, mm2s_status for
DMA_MEM_TO_DEV).

The MCDMA completion check is intentionally not guarded by chan->has_sg,
unlike the AXIDMA branch above. AXI MCDMA only operates in scatter-gather
mode (has_sg is always true), so the guard would always pass and is
omitted. The completion bit is therefore checked unconditionally.

Fixes: 6ccd692bfb7f ("dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support")
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V3:
 - Added Fixes tag.
 - Expanded commit message to explain the interrupt coalescing scenario
   and why the has_sg guard is omitted for MCDMA.
 - Changed local variable from 'bool completed' to 'u32 status' for
   cleaner status field access.
 - Simplified completion check logic.

Changes in V2:
 - No change.
---
 drivers/dma/xilinx/xilinx_dma.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index ff5b29a808e9..1b5b00f08c5f 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1784,6 +1784,17 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
 					      struct xilinx_axidma_tx_segment, node);
 			if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
 				break;
+		} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
+			struct xilinx_aximcdma_tx_segment *seg;
+			u32 status;
+
+			seg = list_last_entry(&desc->segments,
+					      struct xilinx_aximcdma_tx_segment,
+					      node);
+			status = (chan->direction == DMA_DEV_TO_MEM) ?
+				seg->hw.s2mm_status : seg->hw.mm2s_status;
+			if (!(status & XILINX_DMA_BD_COMP_MASK))
+				break;
 		}
 		if (chan->has_sg && chan->xdev->dma_config->dmatype !=
 		    XDMA_TYPE_VDMA)
-- 
2.25.1


