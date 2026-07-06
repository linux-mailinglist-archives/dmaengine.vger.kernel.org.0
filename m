Return-Path: <dmaengine+bounces-12053-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7IKQOna4S2rBZAEAu9opvQ
	(envelope-from <dmaengine+bounces-12053-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 16:15:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EDF711D2B
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 16:15:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=j5eCIS2O;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12053-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12053-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04389302ED59
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 12:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E08242E8FC;
	Mon,  6 Jul 2026 12:41:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7450F42A177;
	Mon,  6 Jul 2026 12:41:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341675; cv=fail; b=nEK06RloCOSx9f0m7bnOdG7ucuMT6Is4dRzlwdRkE7yVtllDYwPX7tOH4s1X8VP+aiECNn9TyP/l/QkfHAJzb4uNpO0BM/BIXv1dthqZ/O/ht1v8QKd/64aBkHFN0+BFV+5uKhhSbo7dzgM/Vya8C6XI/kywufCs/svIroGBR1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341675; c=relaxed/simple;
	bh=gAKZLA1ojNmR7y32pwAEMtrfM3LKcL0+jQMQBP8dLmE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gTKXzWCk4+r27ruOljLO8FbZJ6uW/xWURbQaWuTDTJcwuHxc3mtkf/HGgClHVClJ54CzBjDqoQKnS8rpJyRrcUrXNCdepJW2/btdaqjpOim1D8M1r2Tnwc7YoJffdv9cfjgkCVoZSyIYe0Bkpz0s7N5nrvdcY3Vn8xkxiBxeNik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j5eCIS2O; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSUu49sHvxKvtOSLQm3Vmy2VqfkiiemzYyrsU1xAC4eWezyNqpj5GxSMS2jfigoDwklili7JfqsOfh4bFCP8CHpTBTbYXiCNmuEUJOHAmU1gRKENAXl/xMiBd3Wl/Zk1OFyUIBYZWWDh4uUL0RbEoj0Ts/sSyxcJHQLjCfTtJlR9TEbxp6Pl+YAFLgjfOmusfi38Qm4z0sFp+0CtD8LSAvv/nJCVgwevQHOq3pGis5fhb7uhf1kNWOzzQv+hJlU1a/YtcCK7AFCczRwHcaaBrlbvTg3LoA8AYu7FYApbjrVbLVcyLam/lRSp0/KW+6T+tM59d8jPWvn2O/g6cukpYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoQRONhjMUFbTQawc9yNt2opG7S9O+P0mVi7kUqp3Y8=;
 b=EEZDmIwEn3soq5z1SXLavOXhp5T8PZqEPszZWCzcH7sn8MAKjbqEvwYdi1JYQIFzVpEKmTwBF5zYRD5UqEISls19i641XriyVKTZ/qqecKyQoq51nDjlHQ6zN9qXsOP9P3HA0+SyF9GHM/KRZtCQ+DnQ1SV9nS4WB2cdWn9YwP53uRbHyKuz775060WSo0kkdrVVMD1NvIY7Besr5s77nRKlnWrYhv4oPDw5JtOpggakb9BgfTJv9hFM4hH2tdSKCedm6kxI6Qi7jMjj9NTDRt5/CX1e1GEl2HHXh6HkYP2V4OM7uEdCXPliC/wiQbilbQnuVmrJQrogzTMi0/PeLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoQRONhjMUFbTQawc9yNt2opG7S9O+P0mVi7kUqp3Y8=;
 b=j5eCIS2OLHp1bOoK2oUUBMN1241zvVlXZEOKgn7+UPlde7FuxACi5IdIAabVbQfC8kuedO27jssYfjMFqIXFGO2nsA4BOuJrIAMlD3GfR61ZM+QWP1kVCACCSFDVXURoo54MztWIF5KjsLYtrxKJ3v4Sc0py2N2fDtv9niVQ0lw=
Received: from PH8PR22CA0014.namprd22.prod.outlook.com (2603:10b6:510:2d1::29)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.12; Mon, 6 Jul
 2026 12:41:06 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::13) by PH8PR22CA0014.outlook.office365.com
 (2603:10b6:510:2d1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 12:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 12:41:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 07:41:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 05:33:29 -0700
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Mon, 6 Jul 2026 07:33:27 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>,
	<Frank.Li@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <devendra.verma@amd.com>
Subject: [PATCH v6] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Date: Mon, 6 Jul 2026 18:03:26 +0530
Message-ID: <20260706123326.2023088-1-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5b3c75-b5b5-414a-d75c-08dedb5bd90d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Fu+oM5g1Df9Zo18dKUdFufJ7I815bc61dO5TUgjh3VJyZA4tWV2aOstv+or3OTjezEW/mY/d4m4dnpAcZ0cV2v4jIKkBuTJnqwRXihgcFspFXWCc3VeDRRR+p7Po5RU8ZHzsQ10N0HxQb29b+nGV07rJsVIlxknEObBe6wTO7hBfgmTUzbUanHFpa3LfSt+g5Y2iRuS6bCxhF8ZuMCiWatgUgHYt4yT3Lh6g3sB4jzFcpok9scgJMLHO6kprU8XQwukY4VQmWauF0sHuyI1hPCVjqtnjX94+cy9MepGTVPquBxNasyNnfbvJscJmYS0GiBGDvgTOAdYMAxmvYANX45joHyBW8GDJP/1LP05pM06kX48Hy2u2R4pO8CNZr9rz9EhLYL7kJyk39gbF85Uzqm3gaMbhq+Loyi0SPywXW+ikMLCpiJFk1ue/cp3wdkKBVHHwD7LYxgzB4Q28A8Qlt1DubV7mwFJaGf8+sjXsAGsLFFLtq4NWXzQZwrqkrxiGWUjTEGt9JA/pFkwKAxKGG+xhxM7YXh/XMI7VBU8r9jsLATilduZxOkaHjbuHwmOHjf/SloifkhL0AoiO772EhDkjnL8D1d0Niud2lYK2RTPkzEMnk+MV1fUp3/LlMYrkkOgVDTPhtVjEzQNaPIC7IQ/ThLBJqKwJrhAWx1DrrdDGS3oZqoI9b1SL9Q5X+jDI3sPH02DZUC2muOnGpNuz0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8xGvqmjhV1cxeXAsEDgTHeD1uHmDmWnplLeZtp6n2ot8xu2jpnEGm6Cbi8Wcu9ftTWg4OZ07r1vj13SCp64zO7Ee0bgyXeQKOJo9soTLsPo+5O4TS0Az6lA5/kgVU2W6gTa1Ls9NwDnfPaRsz8lZA6cvyGOxpQ3tVTZIr4wcBI+geszlYuXDlYn1+hx2Z1IncdXk+D98aE1EjgHjIdIHEPq1spr4kvVBH7QRxIXo1/dxLphbbzqQMkJIigms/qt/7DhYDLIwzoDv82+OArmxZOm9ZLlWBpm9dt748wPQjMsmkrJVmuazaKufCoWUOQHdepvFByRZ5XQCNoxgPEslJWHT5tjdJLYhFN+0YlMmhDboxF7m7rW4PDjO14mTFPNAo9FBdVwC7Z5bKNfZ2La2GLLhsmnP0zf82R1GGm1ZF5u4XsIKS2npjA4wkWRFblMA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:41:06.2371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5b3c75-b5b5-414a-d75c-08dedb5bd90d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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
	TAGGED_FROM(0.00)[bounces-12053-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,m:devendra.verma@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45EDF711D2B

As per 'Designware Cores PCI Express Controller Databook',
Section 7.1 - Overview, HDMA supports 64 Read and 64 Write
channels. Current controller driver supports up to 8 read and
write channels only. In order to utilize all the channels the
controller driver need to have the channel related structs
and variables as per the number of channels supported by IP.
Following changes are made to enable 64 Read / 64 Write
channel support:

 o Defined HDMA specific macros to reflect the channel count.
 o The count of ll_regions and dt_regions in dw_edma_chip and
   dw_edma_pcie_data shall be in accordance to number of read
   and write channels.
 o In dw_edma_probe() configure the channels as per the channels
   of the IP used.
 o Changed mask types to u64 for higher channel counts.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
Changes in v5:
  o Changed the {wr,rd}_mask type to BITMAP type for eDMA/HDMA
    as per the review comment.
  o Changed the 'mask' var type to pointer to ul.

Changes in v4:
  o Changed 'mask' variable to a bitmap type as per the
    review comment.

Changes in v3:
  o Reverted the FIX for AI reported GET_CH_32() issue, as
    per the recommendation of reviewers, need to create
    separate patch for it.

Changes in v2:
  o Fixed the pre-existing bug related to GET_CH_32
    interchanging the channel direction and id.
    This bug was not caused by any version of this patch.
  o Fixed the issue when using for_each_set_bit() for mask
    of u64 type.

Changes in v1:
  o On review recommendation of sashiko bot, in the function
    dw_hdma_v0_core_off(), the loop iterates over registers
    as per the number of channels enabled and not on total
    number of channels supported.
  o Changed mask types to u64 for higher channel counts.
---
 drivers/dma/dw-edma/dw-edma-core.c    | 19 +++++++++++++------
 drivers/dma/dw-edma/dw-edma-core.h    |  5 +++--
 drivers/dma/dw-edma/dw-edma-pcie.c    |  8 ++++----
 drivers/dma/dw-edma/dw-edma-v0-core.c |  6 +++---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 27 +++++++++++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
 include/linux/dma/edma.h              | 10 ++++++----
 7 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2feb3adc79f..0eb24e707c9c 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -925,9 +925,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		irq = &dw->irq[pos];
 
 		if (chan->dir == EDMA_DIR_WRITE)
-			irq->wr_mask |= BIT(chan->id);
+			bitmap_set(irq->wr_mask, chan->id, 1);
 		else
-			irq->rd_mask |= BIT(chan->id);
+			bitmap_set(irq->rd_mask, chan->id, 1);
 
 		irq->dw = dw;
 		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
@@ -1079,6 +1079,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	struct dw_edma *dw;
 	u32 wr_alloc = 0;
 	u32 rd_alloc = 0;
+	u16 max_wr_cnt;
+	u16 max_rd_cnt;
 	int i, err;
 
 	if (!chip)
@@ -1094,20 +1096,25 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 
 	dw->chip = chip;
 
-	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
+	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
 		dw_hdma_v0_core_register(dw);
-	else
+		max_wr_cnt = HDMA_MAX_WR_CH;
+		max_rd_cnt = HDMA_MAX_RD_CH;
+	} else {
 		dw_edma_v0_core_register(dw);
+		max_wr_cnt = EDMA_MAX_WR_CH;
+		max_rd_cnt = EDMA_MAX_RD_CH;
+	}
 
 	raw_spin_lock_init(&dw->lock);
 
 	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
 			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
-	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
+	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, max_wr_cnt);
 
 	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
 			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
-	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
+	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, max_rd_cnt);
 
 	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
 		return -EINVAL;
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 902574b1ba86..88c0dc8b8b0d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -91,9 +91,10 @@ struct dw_edma_chan {
 
 struct dw_edma_irq {
 	struct msi_msg                  msi;
-	u32				wr_mask;
-	u32				rd_mask;
 	struct dw_edma			*dw;
+
+	DECLARE_BITMAP(wr_mask, 64);
+	DECLARE_BITMAP(rd_mask, 64);
 };
 
 struct dw_edma {
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 0b30ce138503..79f653da8e0f 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -61,11 +61,11 @@ struct dw_edma_pcie_data {
 	/* eDMA registers location */
 	struct dw_edma_block		rg;
 	/* eDMA memory linked list location */
-	struct dw_edma_block		ll_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_block		ll_rd[EDMA_MAX_RD_CH];
+	struct dw_edma_block		ll_wr[HDMA_MAX_WR_CH];
+	struct dw_edma_block		ll_rd[HDMA_MAX_RD_CH];
 	/* eDMA memory data location */
-	struct dw_edma_block		dt_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_block		dt_rd[EDMA_MAX_RD_CH];
+	struct dw_edma_block		dt_wr[HDMA_MAX_WR_CH];
+	struct dw_edma_block		dt_rd[HDMA_MAX_RD_CH];
 	/* Other */
 	enum dw_edma_map_format		mf;
 	u8				irqs;
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 69e8279adec8..3f4e82516d92 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -239,7 +239,7 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	irqreturn_t ret = IRQ_NONE;
 	struct dw_edma_chan *chan;
 	unsigned long off;
-	u32 mask;
+	unsigned long *mask;
 
 	if (dir == EDMA_DIR_WRITE) {
 		total = dw->wr_ch_cnt;
@@ -252,7 +252,7 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	}
 
 	val = dw_edma_v0_core_status_done_int(dw, dir);
-	val &= mask;
+	val &= *mask;
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
@@ -263,7 +263,7 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	}
 
 	val = dw_edma_v0_core_status_abort_int(dw, dir);
-	val &= mask;
+	val &= *mask;
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 632abb8b481c..0181bd276e22 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -53,13 +53,24 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
 static void dw_hdma_v0_core_off(struct dw_edma *dw)
 {
 	int id;
+	enum dw_edma_dir dir;
+
+	dir = EDMA_DIR_WRITE;
+	for (id = 0; id < dw->wr_ch_cnt; id++) {
+		SET_CH_32(dw, dir, id, int_setup,
+			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+		SET_CH_32(dw, dir, id, int_clear,
+			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+		SET_CH_32(dw, dir, id, ch_en, 0);
+	}
 
-	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
-		SET_BOTH_CH_32(dw, id, int_setup,
-			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
-		SET_BOTH_CH_32(dw, id, int_clear,
-			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
-		SET_BOTH_CH_32(dw, id, ch_en, 0);
+	dir = EDMA_DIR_READ;
+	for (id = 0; id < dw->rd_ch_cnt; id++) {
+		SET_CH_32(dw, dir, id, int_setup,
+			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+		SET_CH_32(dw, dir, id, int_clear,
+			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+		SET_CH_32(dw, dir, id, ch_en, 0);
 	}
 }
 
@@ -118,7 +129,7 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	unsigned long total, pos, val;
 	irqreturn_t ret = IRQ_NONE;
 	struct dw_edma_chan *chan;
-	unsigned long off, mask;
+	unsigned long off, *mask;
 
 	if (dir == EDMA_DIR_WRITE) {
 		total = dw->wr_ch_cnt;
@@ -130,7 +141,7 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 		mask = dw_irq->rd_mask;
 	}
 
-	for_each_set_bit(pos, &mask, total) {
+	for_each_set_bit(pos, mask, total) {
 		chan = &dw->chan[pos + off];
 
 		val = dw_hdma_v0_core_status_int(chan);
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index 7759ba9b4850..48e40efceb2e 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -11,7 +11,7 @@
 
 #include <linux/dmaengine.h>
 
-#define HDMA_V0_MAX_NR_CH			8
+#define HDMA_V0_MAX_NR_CH			64
 #define HDMA_V0_CH_EN				BIT(0)
 #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
 #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 1fafd5b0e315..da7a5cc93ad4 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -14,6 +14,8 @@
 
 #define EDMA_MAX_WR_CH                                  8
 #define EDMA_MAX_RD_CH                                  8
+#define HDMA_MAX_WR_CH                                  64
+#define HDMA_MAX_RD_CH                                  64
 
 struct dw_edma;
 
@@ -89,12 +91,12 @@ struct dw_edma_chip {
 	u16			ll_wr_cnt;
 	u16			ll_rd_cnt;
 	/* link list address */
-	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
+	struct dw_edma_region	ll_region_wr[HDMA_MAX_WR_CH];
+	struct dw_edma_region	ll_region_rd[HDMA_MAX_RD_CH];
 
 	/* data region */
-	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
+	struct dw_edma_region	dt_region_wr[HDMA_MAX_WR_CH];
+	struct dw_edma_region	dt_region_rd[HDMA_MAX_RD_CH];
 
 	/* interrupt emulation */
 	int			db_irq;
-- 
2.43.0


