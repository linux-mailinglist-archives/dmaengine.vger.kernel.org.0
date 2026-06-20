Return-Path: <dmaengine+bounces-11680-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4O0JFXv5NmoGHQcAu9opvQ
	(envelope-from <dmaengine+bounces-11680-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 22:35:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB12F6A9B3C
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 22:35:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=gWUTcTqN;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11680-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11680-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F8C63022ABE
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 20:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2303350285;
	Sat, 20 Jun 2026 20:34:31 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B9336923F;
	Sat, 20 Jun 2026 20:34:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781987671; cv=fail; b=W3Lkl/Y5oAdWQyVgS9P2Uv0PSBnhC6RugtMBhsCN78xNkXOF5xkEV7VDeL/X1UuDcnNeG0yrDioKCH55YiX4VS47st/d6Fntaedc8i14DchJmzVhUAFB7v0P8h9mgeXiX4vAVZcUAQLIjCXVUaMu6kcGkrv4Ty31fUUptvN6HCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781987671; c=relaxed/simple;
	bh=speGhR2T3+RqC78AngG+vTeG4hnmx9+/ouTl2awJ6aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1f2z3wS5Lo2Odxrlyce2aXwfgYVDhoD/xMGxtrgZoL6wjbiXjHP/qsZfg33SDtekc+8ih81FTFq77/OUKHFBMFW4Dnleg4gNHtvKUSrb6Omr3sHBu/EpuYgyPSGU5hDHdl9OwCYp5jcGFpbQ2CH8/JSKR5aa0bedXwtyzB7NTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gWUTcTqN; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKNPb4kNf0Y/0dg1ozFTnuTbnj5cQA6su9f7Jpx09wyIaaheJAjxksuSHzdj6P5IA4VdZz9f/KOie43gNnPwCxdMOeCfLu6s36F9jwlCd1R8vdB6QM7Czrfi3xaDlXY3TMjJhwYPcqqo8jsaSjP2KBjxOdKxRPbNQN/HNUXvUXrJpMegjFjVbiQYATxo96dvDi+dEvTDWGZAYy7ecGZY8snpoG56cVEjtgkQ0kyGaOAc0JuO2T6oQLmRri/IDFLNQywBtuxr3KyGSr6+xWgfqGp3KzMpx+15K3gDQQVuLEDIJhQLgsJ8gib+y72qS9qSHTFBgvilgWMjDh75Y+BZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4pSZaYV/M0fwMWmGU2nuvld6ZnO9ml0zG8t/oQy5Yw=;
 b=bgVCJJF2x8u9gGV22MnieQHCNhhJyjPI+D81ZteK0mmXCiwKp1wEJVPRFci+hMUkQnVK3AbFdewVHQj0qnAJLaVXDJT0CG/V6u0xsGAZ0VQ45bDxrA74eHWDCv/BVe4RrFuG8WAvw3s6B6wOiGl+U6X5aDTyhThFMCKuyOgDZDKXieAwalCkkQfVYlqaErmS32uEcWstsVQOqgQ/0tq0/nQnIK0mz+/vOleaFkGqKKHLH1y1A5fv20VFxszK+W8A34wIztVwGbnrM9rxvRBvpYVcY+r1lH+zzMcOesCfqIdz5lzKcszCULOjAs7zkj+ZHG9o8WNlyhxNja//hLc9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4pSZaYV/M0fwMWmGU2nuvld6ZnO9ml0zG8t/oQy5Yw=;
 b=gWUTcTqNM6wlX3FjQS6m59ARmVUSFOyp0fYf53hi3uPen9jGwKVOufb/kAv8LjB9MrIJ3vtsD5IzJm0oPY6lffiV6e0yz7leawg68hYmKsBk+KNxtWwAYZycCsd3o05oQFEclzRh24YBx5Q12a11EgPi51f/GevNaP47WZHWZ80=
Received: from CH2PR07CA0034.namprd07.prod.outlook.com (2603:10b6:610:20::47)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 20:34:26 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:20:cafe::ac) by CH2PR07CA0034.outlook.office365.com
 (2603:10b6:610:20::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.18 via Frontend Transport; Sat,
 20 Jun 2026 20:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.0 via Frontend Transport; Sat, 20 Jun 2026 20:34:26 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 20 Jun
 2026 15:34:25 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 20 Jun 2026 15:34:23 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<linux-kernel@vger.kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srinivas.neeli@amd.com>, <dev@folker-schwesinger.de>
Subject: [PATCH RESEND 2/3] dmaengine: xilinx_dma: Enable transfer chaining for AXIDMA and MCDMA by removing idle restriction
Date: Sun, 21 Jun 2026 02:04:15 +0530
Message-ID: <20260620203417.4000360-3-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260620203417.4000360-1-suraj.gupta2@amd.com>
References: <20260620203417.4000360-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: e67deae4-741f-40bd-3101-08decf0b5229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	5h32iR/UShmqvPo2x7f595B2TRH377/Gqaab2wKf3KQEdWX/l+vY7LjALWPtBYQqZ/FBFxVccrvg7o6Va6J2r+/j8kNCZnx1XO8cMuPXTVBb40UgCWDGIrt97kESK/eLRQNSNWu/pcmaoMId0ur3K/aq4QJB4Ptnr82ei4/XZPj1K0HtQRyvhYypfg6M49zLWENHa2r2JMXmYTcoiVVcMTgfPv2OcGEpcl5U8ZHvINsNvSdcfblSrPT3d6ORuLHCbwVQgjWdkMTsSzt/FjwIBXTunvZ++rH56Nog/MdH5yA94YLdA+4URK92CUBm4j6mOYzn8SAVpBu83cHI+V9khzZe1vM+BDUBr5Vh8S4S/xKt+AmHAUogOK5ShPBG1tovDcQWq1jd7WAL9B0jaWf/glb2/Di/o4Owji092516tRLV3xHMY9gioI6aBmJWen3pmy+mgASCvpKSqvIof2gpS4CTdL5vI4GI8QAkCNjfPol1JK+bv5mCo4Eyu+icbtqKFI4I9+bV/JWV9oFfqfgp234tAYkxMIlGKW4S4NajL8YvNOojPwixCK7/TizM1W9Etb+U4BUNCyR+/bEhYu07X9lxrYx5OixJBbiaqOz5bN34pE9GE5vZBKapczRHPVRotHhEETXXL+jLxa2z1dj2bHMIfLrwQeYK++9TXdbStUuLm8mlRuJimooFFqsOjcomTGVjwzHDzRfSW+8zto0YBg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Pv/JqTv4g5XyP1HRyRLxlWE2RhJ5S70x8B4JXfO41nMT3/AQ1cmkn9ZQK+Z/7qUXXDcLZM9HL2Ub4Nz64LuLHIp4p+qiP/EpKHxZxo5HjddKE+Js4DzFclQZh32M4yoMWudSuker6asBS4K2DxGy76PWPobzzvu9h9avh5Wx64IdUNcG0SuXQFtFPvVJVMCSEIUdXaK9zHNZCntRi2NWCkBjPzji60fwTJRrtHxTZcQUggxS0Hz/X1k9ZgbD/tln7vnl4MGK6jrMC6TsDsLWsUiegYqLshq711M63EG82cdzWjmCUSTOYAy+Uq8Lm3UgT40sF0CLUEg4yaXJqSIj8g/T9IK2FgQb1sSQoIY/KZ6ykHUbNFry4LAGIBXeT3QwaspagSRZCUA4Ax1z18oPJx3SsqpP+CmrQhamATi2auaodNM/FQFc0ECteJdENE0m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 20:34:26.2884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e67deae4-741f-40bd-3101-08decf0b5229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11680-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:srinivas.neeli@amd.com,m:dev@folker-schwesinger.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,folker-schwesinger.de:email];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB12F6A9B3C

Remove the restrictive idle check in xilinx_dma_start_transfer() and
xilinx_mcdma_start_transfer() that prevented new transfers from being
queued when the channel was busy.
Additionally, only update the CURDESC register when the channel is
running in scatter-gather mode and active list is empty to avoid
interfering with transfers already in progress. When the active list
contains transfers, the hardware tail pointer extension mechanism
handles chaining automatically.

Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index ca396b709742..35b553ee3205 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1580,9 +1580,6 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 		return;
 	}
 
-	if (!chan->idle)
-		return;
-
 	head_desc = list_first_entry(&chan->pending_list,
 				     struct xilinx_dma_tx_descriptor, node);
 	tail_desc = list_last_entry(&chan->pending_list,
@@ -1599,7 +1596,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 	}
 
-	if (chan->has_sg)
+	if (chan->has_sg && list_empty(&chan->active_list))
 		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
 			     head_desc->async_tx.phys);
 	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
@@ -1660,9 +1657,6 @@ static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->err)
 		return;
 
-	if (!chan->idle)
-		return;
-
 	if (list_empty(&chan->pending_list))
 		return;
 
@@ -1685,8 +1679,9 @@ static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
 	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
 
 	/* Program current descriptor */
-	xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
-		     head_desc->async_tx.phys);
+	if (chan->has_sg && list_empty(&chan->active_list))
+		xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
+			     head_desc->async_tx.phys);
 
 	/* Program channel enable register */
 	reg = dma_ctrl_read(chan, XILINX_MCDMA_CHEN_OFFSET);
-- 
2.25.1


