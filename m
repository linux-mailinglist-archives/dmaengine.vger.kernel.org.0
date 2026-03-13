Return-Path: <dmaengine+bounces-9417-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OXKN7eys2lYZwAAu9opvQ
	(envelope-from <dmaengine+bounces-9417-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 07:46:15 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE227E4C0
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 07:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07E6A303BCDB
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 06:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1A8351C30;
	Fri, 13 Mar 2026 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W9wR5GPj"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050DB34DB57;
	Fri, 13 Mar 2026 06:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383156; cv=fail; b=cIywrLSRzOZEuyWoAwPOTypArcVu2XQtctrsbJZv0NnFAyUnqzJz02cDnRFpjvd1I4uwDIHhRfoe8Ccp8jvC1gej2Rs6ZdY4DVeJRul8lu4j+zTLth68DBumhK98eitd7VO6HPKhBkGtknAIe1SG8ayqE1l3VbFpuB7tUbgyKJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383156; c=relaxed/simple;
	bh=XR0af+SWBa92tLKFvpNM9weRmH0luECF8s/FgLepkqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVKLRDtLa6bOCMIDLCVVECIfISLMjdSkYfYMY2hUHJhD+hiFYML2RvVsHE92APIAvfWRhYsqIKk+L6ftvxNaW20Eh3Zf/DoSE3fPAX36ccHxHV0w1eY7wNe2O+AADBDZFCKtQrc2ZyDl7CEGLgupd6luCH8svGdn8vZBsK6W3Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W9wR5GPj; arc=fail smtp.client-ip=52.101.52.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EB+I3NPD1D7C5YW8gS1uzPZ++55l01VQXEwZoUfD619torKZ4eQnskucWeUZ0SUxHNcGWajIAWRd7YCfTsA6v3sL2AQHCZ6uoZDPGRphOcEBw++JfUXorhq1qwN0MksGU3OkSap3N+y2u3m85H2MODVsr+a1PeaAN+xLLEChPxAD27rddkaYl+ST9oeKBpicXM1fz+LmnAT0b04lAru8GlDaAThPG1WcWUNwwoCUi2su/FT1cwm42C8dY/2Hn5U22hIPy05rX/Rm4YtlDXgk91yVkmGe1QVycarfcxOykRZcyGUvSAy9m132aELdDZc5/siaDTrK97jtcs/Iy0qJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qa038Vk4jk979t+QVTamnRblrqeFhpY0JuSphPBf7yc=;
 b=S7fMAKrc77lS9D1Y+yEtPyHYgEMOl7AjuydpCPI4DMj6srN9sBtSqvlxym+VS3p6P+fyRrKDSLDZM37Z2J1FneczGFT6zQCdpVtKgr2NCyFbgTYTzb6kp8Pwgm/cKXMdlsnzIR1HIB3qtbTHEq1CJsKdssbOuyIxPksJLq8xw5a9E7mvWqSdauZiStpKzI3o+TnCZdFn9CpL4uc0OooSnlwZXqxE6D5zZyyxLCZ7por3kCF/nNkFAzwPPycyAM0FVQ2G0U29PYKJVytUbPc0KVS0dBoGhJ1pkRp8nkbsBz/sXLVeCj7oat4i6glczVmnIMlEOtb3WtU4DjFIhkdWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa038Vk4jk979t+QVTamnRblrqeFhpY0JuSphPBf7yc=;
 b=W9wR5GPjdYkIjoIcJwzDVAZ1Eduwe2VUp2YzAmQyPZx5gRlCeLvlEo8vK0Mw1NhTXU6waojE04xVW81I05j4WMnzklYb98MsSxKoWi1eNQe0XpFvguzhVAPQM7kN+633sMndaHcOuU4y5h4rRu/db76Y9d/nGnm5zeqMjkUiy8c=
Received: from SJ0PR03CA0060.namprd03.prod.outlook.com (2603:10b6:a03:33e::35)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 06:25:50 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:33e:cafe::3a) by SJ0PR03CA0060.outlook.office365.com
 (2603:10b6:a03:33e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Fri,
 13 Mar 2026 06:25:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Fri, 13 Mar 2026 06:25:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 01:25:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 01:25:48 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 13 Mar 2026 01:25:44 -0500
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
Subject: [PATCH V2 2/5] dmaengine: xilinx_dma: Move descriptors to done list based on completion bit
Date: Fri, 13 Mar 2026 11:55:30 +0530
Message-ID: <20260313062533.421249-3-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 732da20a-1bf3-4fd4-ae94-08de80c95ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1CNRTcrf0TPWdr470GDNgB4yCHhRTInHsQEnj4GpxXsbv6mMumnHVdxog9jRArazdIeTuj2buijylsX/uRQqerSEpS0EhAWpdqxt3TdK/8CrI+BOeHgtQrhHlDn/p2cuQ/hP8O35CYdCVyR3XyLZ2yfNkPFFwRZSwOrt95cn7FFXgkjJnSbZKbF35B4+Ssg12F8Gi4ZEZBnsBuhxECgXYSKUf4UtqUIPQtv67jrQWC2ue/UTqdV8bfRt/roriFX7rLDB4BrYLetWuHNLBIAHIHYc66ivxaDtjEls5DJLv7ALhoByJ1DVS0QVIgPKZdQ97Q7ukyYnUA5Ps1+wtf1VH0LsYUksy2CvO9b/OFaMPs4CsI/N57qhcuTjIv5a3Oop1k5o7ojozrHC/xUNlMM7BLxW6uytNCVkLz1Khf6FwOoDlfUN38E2UNLAdM7Z41IXkDvn3lP+eWUnhMO13N0WapcylVNzXkQxxotssIpEqPQxJU0BvKnztLK+wOMgDvDCckxy2mb336WBo50c4GjnF6krYUaBx6+MBkw/zUgwXbXGoM8/dzc0tXxIZeRGxijL3i4fnl5kz2EGXOaW7xtHOwDkZlVevoUtz4SUEmLftIzpyWftLYnUz3ocgdM6EtmSnqxTHb7BJZsifhdxaQKjfsgTE7guXoRqbKlSV4wWEPjz9znRikHD29OxmQSXx/V0ImKYoyE0iybnH4oglPp031JaFBdgDKIlAqk3+CCVRIbmjxhUG07OFEg/hYQFgUxKx/+dLG3bhT0fu5YgWMRTkw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LDbfELgskV8y2CJcBkhj2DVuPnNEKaWmDZJFQFB50Q2NCqVBBTtlwrO3zU25qsLB9ygB2aPBmw0czeEU94dCMWAnrIdaHYLX9Y+v9+2PALd3GzEZ8udEf5AXhl1QP2GJlZALT5lUPoQmOHC1SgmffkSlG17eKtPDE9+fycqE9YaL5qPlE/pwkZN4Ahtu5L9hzq1GGoOf9FZpNDFuaAaUGesU1+lmD+0J6cxeOSTVpfGvDgTUvh/0PjjW48F8yysnAVYIJxUnamVYoKO4+QR46uAuGLDB5m9d9AXo+IpLDX+ePv+OFbth9F3GvGuMjMxpR1KyWbsAxuOfAozTNz13Ug2rtYg5VicCjlWtDvjQTpmg4rA6TzhbyAz6pGryWfauFGl5ezSvRqo7rjvazE886bC0ffW5XcfoycF9j71WKXlHHEePgou+7RTRaGjgsbs4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 06:25:50.1923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 732da20a-1bf3-4fd4-ae94-08de80c95ef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9417-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DEFE227E4C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In AXIMCDMA scatter-gather mode, the hardware sets the completion bit when
a transfer finishes. The driver now checks this bit to free descriptors
from the active list and move them to the done list.
This is required when interrupt delay timeout Dly_IrqEn is enabled,
as interrupts may be triggered before the configured threshold is reached,
even if not all descriptors have completed.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 4a83492f2435..00200b4c2372 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1762,6 +1762,18 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
 					      struct xilinx_axidma_tx_segment, node);
 			if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
 				break;
+		} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
+			struct xilinx_aximcdma_tx_segment *seg;
+			bool completed;
+
+			seg = list_last_entry(&desc->segments,
+					      struct xilinx_aximcdma_tx_segment,
+					      node);
+			completed = (chan->direction == DMA_DEV_TO_MEM) ?
+				(seg->hw.s2mm_status & XILINX_DMA_BD_COMP_MASK) :
+				(seg->hw.mm2s_status & XILINX_DMA_BD_COMP_MASK);
+			if (!completed)
+				break;
 		}
 		if (chan->has_sg && chan->xdev->dma_config->dmatype !=
 		    XDMA_TYPE_VDMA)
-- 
2.43.0


