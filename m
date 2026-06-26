Return-Path: <dmaengine+bounces-11807-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zISWBfZFPmrACQkAu9opvQ
	(envelope-from <dmaengine+bounces-11807-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 11:27:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF996CBAF2
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 11:27:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=GcnA3oEC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11807-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11807-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE27F3012771
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 09:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9133DC4B6;
	Fri, 26 Jun 2026 09:27:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFFA3E5A11;
	Fri, 26 Jun 2026 09:27:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466029; cv=fail; b=UdoyTPR/MZaSJpfSRvy+9awBcwz8KxrDgCULzJSRZAAIiKRvTLamazy0bACOWAAvTWe78GZc71n9VI8aD+GhuT6zgDHR0doZPy6cov8lYv5tp4JWLZoyJkxwWe4K8gVu18MLLPq6zGeoH0KTSVBSkhZbPcge1pR4rqL67pd3/Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466029; c=relaxed/simple;
	bh=wahnEbHhgemF7cbtvRTITTg7nP6aIgnfy874BQ6ZfTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/bBlIRtye27JX7op/ve/nwJrpt3q7lFW81symvsMwUk9zB7mtMAVl2+v06KLS6hGqtSSuEe5kzNxsUSF9b9oe1pc5VOUGDFBv1AgPwUU4ui1z4NbMc1ALZJPb7a2A2guy02F9aEzNq6xvTsPUs0iYsQs5DVTod9NWkMFHsaoEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GcnA3oEC; arc=fail smtp.client-ip=52.101.61.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daMfekNrMJOXqR7xW6M4W7dcTtOqlc4zzj/8j37Sa9ynyYIB4rbxTgRaYQHokk1tZlDFkTo50nDXQ6jfAbtRJGAMwQYa4ndpS+J87o8NHUM+tvJuZTAXSTqrtnQWS1De4mNncOTUPjVDOpgcFdMD9lAUWmDRtxihbqdeiqPeTFqAA3PjnhEknpXm3ql2jUhsOHzEggU/5+QlPamQchKMS0zk1Wa81c6hP5LmE/MgwIGP53xQ9gG2qQA13ucRU8siq2QBkvuWvFvClVXbWdSE0CTqkMzy49F2u/X4Ws0ECSzMqGu4txiCUYkr8vwdBoSzy0wxIqPxu1VsuAHzdpIvQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YSvYYLablmT+P+33Hr4uOR2zsdvwef23p6CSityVls=;
 b=p2wPvFuvDP1kMC18ciiEKkrQ+P+T5zotRGcRJBNpNZUL3jpv0xrViEvYcCnssC1T8NheKgnHTxiDWbbRXcApqrAUN0O2WsbMhqZPBGSXlvwHnZr8Sk4pumAZ83fXmIqxPD1xaLi00oXrCynw3Af0vUY2WAlZ+MtfgLANx2S6DJzIrhH5qb3DX5CZ7H9/SvCKdflxW+N64Jl132y4HxIckv0QVB9m0M9HLhB76ro9z1GsVEROcrvNsRSk690oOT2hiFB7Ucu1Eas8FgzGXlofMtvb6b9cKemwj+Zw9w3xdB09Ct+TnYnKt9x7JDzicXwq3EVEIqkn8PkR7T6iGH+3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YSvYYLablmT+P+33Hr4uOR2zsdvwef23p6CSityVls=;
 b=GcnA3oECSw0TootdPDyhPYv1t2dVaEptYHX2+FZQCbRKu67S1KTfV3HDacQA9yclz26umT7M4YeJAUo7zHnQtsnlT4gYs/ixaQd2xheGgQ8wXJIkCQn1qrie1XEBWpqBuQfnfScRgyWBzAatp8lVKox3QJXzsU9/NWiTSNDnw8c=
Received: from CY8P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:46::24)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Fri, 26 Jun
 2026 09:27:02 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:46:cafe::a) by CY8P220CA0006.outlook.office365.com
 (2603:10b6:930:46::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Fri,
 26 Jun 2026 09:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 09:27:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 04:27:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 04:27:01 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 26 Jun 2026 04:26:59 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<dev@folker-schwesinger.de>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] dmaengine: xilinx_dma: Fix channel idle state management in AXIDMA and MCDMA interrupt handlers
Date: Fri, 26 Jun 2026 14:56:54 +0530
Message-ID: <20260626092656.1563871-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260626092656.1563871-1-suraj.gupta2@amd.com>
References: <20260626092656.1563871-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: dca0a7a0-7484-4dba-13e6-08ded365144f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uAa+Es0mKz9KZErdonAulxlTmmLBKj4qsXiIfc0xKlu5lYmWQidH7Ju+SoH1174TUV7vu5pLChMSAB6NENTO06i6G38Ie4nQavV9PTzZKVDJHropJ5AxrIYi9xsNwHq3olpQSY9yDqrgLK7/MvSbiSDqsyPOmc9wWBDtfB10zdtDpXGbFQXLOeOXFB1XsJIQVgBQ1phj2z0pmKIuOpvlXkugt0OIH4fi+5ljAIUbse3hM2xstEk1UbQdXe6YNjSqnWyMYocZBIJdKaoHttydHr03OQUX7OaU4YiweImi3yVBCS/LiEa+1/Mxc8v+eJMdkJkWneMnpqO96KcSA6iCf/i541acE4Y4DnlCmJQtD4x36e4/V5c5Hay7yJJF+GBtlHD5sj2QsUfAY/nINN47Mimz+Xhe+FUZ9jxGeZWzwaWYoqOM7THg7ubuBlYz2RF1AW4GVVtn7FJg+Wu68ycME1klUfblb/bxr2XaCOiAIVHUHqKyVR2O1MnwPT4qMjiBNzZumypBVw4AhCAjUGNBCg9wbW5EgZIdKgMXoQIeym697dnxilWGToLNcl1lqOBKcOpbhGrQCENGofRA6iz3qX+dzjtnDzx7IdACdxW+Til8OpSI86lueZ/BUAgvFDjxDjFGnBW3czglhk5JrjY7arj9kwIDD/IaD7RxYBLVMyvl169XOadIdRMhbWYlPt7euVjRMDFaxVpAqkuRGfCnfQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZIAYb19i44EusF/S2K/P7mJXq1fsa9V1+ChyFk1PoOl0zu3wqJ4cY2KgyJWMpGUMjgzrFp/14jUTlrrQEAAqkooC/VCKfigTrVfGM9QMWY/1EU+MgllIf58lE78NbsOCNP1x3P8zyAaq3DiyMsuq3kwfmlKCfk3xT5lCM4fh5O1XigC+XLMztu3guYsmTP42CTPP8Te6+mIDN0j/9EbimSms2VRb+gsu4K4jV33Ii4m6fAxF7J1LBRZlyWgaN2QPIRUpt9GJl8qrTc9AY8WXmiJS9kAa96LPgVm5LwGvskiEISGqy3Hp1KkPgNwEjc8eBZMsBULWyU8P5a8nS4v+FDEpBRCXXNEgVhvCUDPjto02a76ePiXa7RKt4OQ9GM2bVm2e1LjhPEPoM7UGhIN8mb+2rn1XKUFuVRVIJnbqo8cI2mc3CunuFDVKRBmCwRWz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:27:01.8203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dca0a7a0-7484-4dba-13e6-08ded365144f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11807-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:dev@folker-schwesinger.de,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BF996CBAF2

Fix a race condition in AXIDMA and MCDMA irq handlers where the channel
could be incorrectly marked as idle and attempt spurious transfers when
descriptors are still being processed.

The issue occurs when:
1. Multiple descriptors are queued and active.
2. An interrupt fires after completing some descriptors.
3. xilinx_dma_complete_descriptor() moves completed descriptors to
done_list.
4. Channel is marked idle and start_transfer() is called even though
   active_list still contains unprocessed descriptors.
5. This leads to premature transfer attempts and potential descriptor
   corruption or missed completions.

Only mark the channel as idle and start new transfers when the active list
is actually empty, ensuring proper channel state management and avoiding
spurious transfer attempts.

Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx AXI Direct Memory Access Engine")
Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 404235c17353..ca396b709742 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1893,8 +1893,10 @@ static irqreturn_t xilinx_mcdma_irq_handler(int irq, void *data)
 	if (status & XILINX_MCDMA_IRQ_IOC_MASK) {
 		spin_lock(&chan->lock);
 		xilinx_dma_complete_descriptor(chan);
-		chan->idle = true;
-		chan->start_transfer(chan);
+		if (list_empty(&chan->active_list)) {
+			chan->idle = true;
+			chan->start_transfer(chan);
+		}
 		spin_unlock(&chan->lock);
 	}
 
@@ -1950,8 +1952,10 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
 		      XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
 		spin_lock(&chan->lock);
 		xilinx_dma_complete_descriptor(chan);
-		chan->idle = true;
-		chan->start_transfer(chan);
+		if (list_empty(&chan->active_list)) {
+			chan->idle = true;
+			chan->start_transfer(chan);
+		}
 		spin_unlock(&chan->lock);
 	}
 
-- 
2.25.1


