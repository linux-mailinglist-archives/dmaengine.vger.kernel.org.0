Return-Path: <dmaengine+bounces-11679-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4JI8Clj5Nmr9HAcAu9opvQ
	(envelope-from <dmaengine+bounces-11679-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 22:34:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A90536A9B29
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 22:34:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=UiT3yqQz;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11679-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11679-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E05DA30058FD
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 20:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB59368D7C;
	Sat, 20 Jun 2026 20:34:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22857245012;
	Sat, 20 Jun 2026 20:34:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781987670; cv=fail; b=AuggTWl+qQSrwzVpj8r/I8LX0EQupSUQTprryigvFo2tJ2Ap2y1/YyvCMpEHOIqH6wSwXtvy5meqgOofZVBqpjrbAkXgKA8PlOSgx0+6XFJp2GAauUsZQXrYE924sz7vEgZpRpBnYpucVIOWEqUYrAaKa1BedwLt2jvRpxmOIcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781987670; c=relaxed/simple;
	bh=wahnEbHhgemF7cbtvRTITTg7nP6aIgnfy874BQ6ZfTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QG6By2c0NXiq+2g/DtqsxOg4Bg2FHI9vF3oHP4Um2qoAh1hnGRjEGeqaLcvlMYqu1ZhSpT4isXKemCqzYw/WWiTBOlVcsudJ8RzByz75APTqWb1pSE1bnAFQjz4Bvb/5NH5Gg2/ojjyt7hVxgQKVMgJgsgc9BDN1rIhCSZPxFPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UiT3yqQz; arc=fail smtp.client-ip=52.101.85.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+VI3R/BgEJoMkgx/DZ1DU43/+HP6CK14ZY6+FOb8dctGQ1tE6qgWr3+3Q3orwlZ/0oY6DkxE7pENRG58jOneSItFH9xFsHUnQBbS4oSqaRYv47aNzN6R2r4ltw1eRHUFiPTqH2ITUYavy9fHvGPSw8FMQ41x2JICe7ic92BpfKwQx6OAPYVuQBHcUdfu3dY38f1D4dEja0MGxfyTItqH+5mYSoN1tVZhBFbjiAgUpjRv6+EvCHgCSBPh3kf410UN20jkpsfikEg13upezvAYO+czxbc0XuTJib8zbzX9yN0p8FCH+a7XcTvU6vDNBErr90zUpUzd8oDnZ3rg5jkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YSvYYLablmT+P+33Hr4uOR2zsdvwef23p6CSityVls=;
 b=DmvFrtqf3qfYX+XNbmMwPDQqnMm/GVhSelGkf2QUexF79DDbCMWe/0GkuOKB08T+r/DkKPJyqB9EvfeBqiLIGANCW86guHKgkIJp4JMVNYO0denLz1ZSyXtxzdWoUVvF7vguqrRqPstKqfWJ4NteS6lNe59WTiAMXkrbEdJP0PPqgxuP53S/+UpmBgXwneKxpgTN8NEwW4vy/pC7Q/9+mX4cmrrDxAEb4JYi34J4A4XQYm8xLZ2vzzWiRRaDpzm35ZT9SpjhyZLF8S+6dvnnz3TqTksYH3UXR7E6vyMgAFjnXfJekpBkI4K8bLjcvuqh69JV4lOqdCFNpk/HNGnqNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YSvYYLablmT+P+33Hr4uOR2zsdvwef23p6CSityVls=;
 b=UiT3yqQzDcRltgiNzDqWR2g0mv5NXaRwkphelh5YeDBP19+YbTjyKthm83s9yz9xwZuC+jHw9R6uP/WzuNJcgRpksviBcYcsYfYot/HG2FSX/zAZAVEHLSN7xt96rPv7IlMU6N0/NMc3YBoYkUXOs2d5P84KWDSrvJWXt2BTSWY=
Received: from CH2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:610:5a::35)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 20:34:23 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:5a:cafe::4f) by CH2PR08CA0025.outlook.office365.com
 (2603:10b6:610:5a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.16 via Frontend Transport; Sat,
 20 Jun 2026 20:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.0 via Frontend Transport; Sat, 20 Jun 2026 20:34:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 20 Jun
 2026 15:34:22 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 20 Jun 2026 15:34:20 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<linux-kernel@vger.kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srinivas.neeli@amd.com>, <dev@folker-schwesinger.de>
Subject: [PATCH RESEND 1/3] dmaengine: xilinx_dma: Fix channel idle state management in AXIDMA and MCDMA interrupt handlers
Date: Sun, 21 Jun 2026 02:04:14 +0530
Message-ID: <20260620203417.4000360-2-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: eba0a202-fdd6-4922-8814-08decf0b5078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	iX/v2V15QM7rgpcIFL6SsENNAzvkr8eOC4w+G8YYvM+olXoIAq6mzp8+VOHB+9+3NIrZ6HL+5CmP74+wTXozp0dZ3jeC8OAavtlqSqscVAF4aBsvzRgQimJC8xBBm1aCZr3abbXya5rUTuEC6HxthkYGM/KPCZ99OUCyo+Kn0XZvH12YJEfwdpA4eXp25+cKe2ioETOAnnTN5H5eKA3EpWW2VR688dA451R4vQziT2s5bX33vPbqUWLAIKYJ3LKYiiKegaPlDJsqyDNtyuFNIIJs0IeJlOxCpp+cSGqT5NPt0j7uW8xu8CILLiICcen9VLzzmCbBrWSrELBJqeXLYn8jwDw4MTMhza4N6x+u7IzSxcBAnqeGMmaLP4xVacoCtkSTfzMPrz+4+8+orCxKIKSAjlijh+FmaVqto8ycj2+tB/jMlSUblaXXxQphy29AeHIUn6R2X3rhwQ5vIYe9K7XSvMJl8qB+pCoVEm2QzBhEcM3lNzcR9Z0w9e1WjDyfvEhQTA6fqs4jJdyjmm33CS2YM+VQfEB7pQy/SCgP0EgzfTWpU2KgnjoYsoUdw6WTCgijZCE2TWa4fLxN+72y0KxMBJNdSczoa0BTAPW6a8UDnU1KQeb6dKo0YHYoSsBubrXYup4lPs99438h4nF2pWuN3HeF2nwbN/MHFq+0F7KjTa2xEGRpWSU4I3xvRAscnA4SlN91xNfKq1P0ci3HHw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PLUgc0uje8J3g/n4XNJC/3l5IkmZNmj8yJjEelgOiOL/Vz7ds37dIWWTZkfaYIG/4IqR3tCdV5v2qjbKVIA6YCgFu3VkcHZ+zMVhc6qqWCUQvtostrVjVzxQMMljkC0BejmYpoH7e2iR6X3o0F4mhFwUF1Y5BPfUQr02cKVF7augLxGyjUrvMlHE6nyrKDAnx5t7tUDrN+qLRaHVwCOM6XX1K+nSw+nVElrnrdH+2ZtnFWPUFgXE0LLEwVELiHsY9eS2/er+fi+pMopkMOB+8Pzki+KddTJ31RrYx7u9WPO1+hViD3aWqIF8fAuRM3jL2ANklfrXTEYK6HHg3FtL9lVlR/mwEivZ1o54OL2lrkxJucYDZtg1VP5YWd9yky6JtzzmooZ3olFz2XfFuQoJv/s4H6uvcDmockA2JO0IM+SyuntnHC67Am0l+ap/CfcC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 20:34:23.4533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba0a202-fdd6-4922-8814-08decf0b5078
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11679-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,folker-schwesinger.de:email];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A90536A9B29

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


