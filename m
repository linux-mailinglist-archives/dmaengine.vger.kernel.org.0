Return-Path: <dmaengine+bounces-12368-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zm7QGEWSVGpYngMAu9opvQ
	(envelope-from <dmaengine+bounces-12368-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 09:22:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A868748081
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 09:22:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=tCSwtgsY;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12368-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12368-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F1FD3013B8D
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 07:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7209A370AE7;
	Mon, 13 Jul 2026 07:22:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E238636F8E8;
	Mon, 13 Jul 2026 07:22:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927334; cv=fail; b=aE5hVKKUB81mL5n+QFBr1jMu4pq17DEqHDdGYJ/M8Tekbg5O7a7KfQTvpCbyg3UB3lXupA0SR0COry3GuBGhCb6AMRA2kwFb8Hqzs6do73WqpSA6FWR2CG3HYbXkBdOxbEcctyUHhKrDCWtp2wFFdaI2uBixVnu7yltLZ7vXwLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927334; c=relaxed/simple;
	bh=KgL18bj92fbCAPoKZJlel4/kCPseTZgcPPD7Jyc/3V0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPthXRm7oFtKYfS6+EvsmrGf+bmEX3O81nSAYB5N9UrnFdzzPW8tKOlzCDbm+51utwu1dkkij5wE2/pmca6OUG4Vjm1yAwcOnwNfzooN/63znWXUZ/2f065DDZSuBMkyFtmnMmMFZgSF+9FQ0bNsTk3X/Pv/kyamtQBaba3yPnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tCSwtgsY; arc=fail smtp.client-ip=52.101.62.10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pW2QMdHp7J33pXiZjlyXhrCS3s+GpFmBuZd4XcGNOek6pn5gocXunzbSSpO6BZjbsI8JfUYyjeigOUedQk90roPF25n1yBPcdNgruuGequsEF1i1voavSSPlALe9dE1wKhsiYg0i8i47vWgwi4mH2+Q7/Q44okuwvk4BKODT952Rqa4U8PMBTbeTdaTeTuHdgRcvEmsrORVZM1VpohVzswpVhKECSKCziE8faDmiUVI7ZyxPCiIiOIZyF6A6YMydx7BTHSySAhTqFIH3TKM29jzMfpq0/7NEJ/4xjygEifPuJOx2LEA869TBiddQfs1r4GHxj32eQxWzs20U8ChYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X/O4NBeT5ZTdS8ik8SCStHIRNCc4cPRH1WbAhSrO9U=;
 b=HDKLhIcJy9Dx8GNa9LMi+zQWlXfxX/OAT6+bCxAfNFSjRZsfb1NGsCs40oFkodep2TIX8Uu/QanH95hNmY6ah8ur8hHMnUxwU3C2o9f9sqVvipGeZmDRdxHsqAuuzDjn+BbngRHTn0rH4acgEJi7DjBTFOpni/Ugwn0B7FaBpN7XB+Mxk97UiwU75Ri5q+bikh9zxkkP74MmrzsTOhVUCoh4FKuwDWUEcUcgsUkB2ZuFi6uS55nmAcJNPn1kIb4nVm6EbarfA4aUtzoMSbI1yC17Qvvl7IFACTR6b/WyxTCamG1qTh93ASnau2ZXuS0HfLxYaWR4vYR23xWnIGCD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X/O4NBeT5ZTdS8ik8SCStHIRNCc4cPRH1WbAhSrO9U=;
 b=tCSwtgsYXgxZwYIZ7YVeF5AVTxEx34pq06cMC9f2+GIn3kmMuL7BCYAo8XILJvOlrTqDKXc3MrYrRiWttSzbHNGPJTDbV60zy44keKxuBP5DXCfbNqpmgknEavOlBkMchw3+SrgoDM2xrVYMrpYyzCVB8kWwMybtra4pNb3IBKQ=
Received: from SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::14)
 by CH1PPF4CBE7339A.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 07:22:05 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::35) by SJ0P220CA0010.outlook.office365.com
 (2603:10b6:a03:41b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 07:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 07:22:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 02:22:02 -0500
Received: from xhdsneeli41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 02:21:58 -0500
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
Subject: [PATCH v4 2/4] dmaengine: xilinx_dma: Move descriptors to done list based on completion bit
Date: Mon, 13 Jul 2026 12:51:44 +0530
Message-ID: <20260713072146.45269-3-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260713072146.45269-1-srinivas.neeli@amd.com>
References: <20260713072146.45269-1-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|CH1PPF4CBE7339A:EE_
X-MS-Office365-Filtering-Correlation-Id: f68cde26-de7e-40e0-980c-08dee0af710c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|23010399003|18002099003|22082099003|5023799004|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	rzSXwuyDJGV+82mQFOU/SII99R6Devt/Hsp3hiDYKfGsntmQZt2iz5BahDJhL36xKbySFv2JWRlBZmo1K+x4o11qj/f9YqmgXeiNs6L7XHbJRw0KP9A+8drb+HNAWHL5rtIo7mOYeXRGUg6+N5YZe47mdGqA3yMh2IoD7HprJc0qDNGsXV2Ft8J796jO06FcWoGufpF8bTPNIp6mTbODuEVGOBdjXqMb2SADKka5/sLtPTdkRwIuJ6wxh5+tkDlugbFD10oJfAJ1/gZNgPdDw7SVop+OzDDFc2CciguZqlMSmAnRHWnOHB1/3pnD8RMjZ6WZ/Qlp9J+GQr1nU/oobGTfgrnN9Eo44AJcL7pkCBbbusKVj6v9Gjaujdma02R+64zB71DNGs3WFSXKejtkIRNy/de8JdLc/CHOrY/W0vF5XecleIHGg5FI4+p20QLjxkdhx/xhrVAaHdJx0mZjPmjlhMz7wmKnVwehqBrnaM/l/mLS0YdijYHbmFqHE9axp17u2ICqiNojOclG9qYScBSbN0PWujjEV1jbiYzQk6Xp/eCKL09zk/i1h78u/apbjQ5ayVGE4qLtE/qxeg5LbGZoJjTRmLlrelQ2PrB7BQIcgw/OPO7vkFRYmIFhLqHJYcoRynQfSphItY+iwuAIrCJ6W07JRjaLnDMr6OfngyaTj90FmUNMaKwYEtU1R6jLk0Wn2SpT5AC4m5vWg9tXcQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(23010399003)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zB44urI8CElqib68gHw5t0LW/uYJsKJmdI6wP+1bfUaY4rfOXr2uv+Dvi886dJ7/9HdOxfAqA4mDgsoD2YbWXLJHhYjCuYHf9I0oYLTaXdW8U64Y4IIQXINgHdsxNg5jOoIMHQKx/Bu4k1RLsd/Jc7MrTvd/SjJ7VH9e9Ik25UY1tyw7/554Isq9g73yAqK4XjzAsPN/Yc2TjWuQ7qfdfvw5Yuffe/INzGdTlebeSTBpnLxh2yQnG9ywgGvH2/5anOUA7YEzt0H7zAxmXfYaX2VM9IIPLUTic6vk2FxlHAdNi3dsk/G4n2db5lrJZZfKnZ6j47lJzbrwo1uTmTsbcNVBmQwDq5dPF6noF7m7k+/nkHujmvYyOv7QArLwLGVLenUNmloRjry5LsKzMVS1CkbHzzOvNEMYn9FOn7WOSZ3fuhRs7LutTv/EF/JJJ6qE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 07:22:05.2963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f68cde26-de7e-40e0-980c-08dee0af710c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF4CBE7339A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-12368-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A868748081

In AXI MCDMA, xilinx_dma_complete_descriptor() walks the channel's
active_list and unconditionally moves every entry to the done_list. The
MCDMA IOC interrupt handler invokes this function on every
interrupt-on-completion, but with interrupt coalescing (IRQThreshold > 1)
an IOC interrupt may fire after only a subset of the queued descriptors
have actually been processed by the hardware. As a result, descriptors
whose completion bit is not yet set in the BD status were being reported
as completed to client drivers.

Add a check for the descriptor completion bit before moving entries from
the active list to the done list, using the appropriate direction-
specific status field (s2mm_status for DMA_DEV_TO_MEM, mm2s_status for
DMA_MEM_TO_DEV).

This mirrors the AXIDMA fix in commit 7bcdaa658102 ("dmaengine:
xilinx_dma: Freeup active list based on descriptor completion bit").

Fixes: 6ccd692bfb7f ("dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support")
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V4:
 - Reworded commit message to reference the AXIDMA fix it mirrors
   (commit 7bcdaa658102).
 - Added Reviewed-by: Radhey Shyam Pandey.

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


