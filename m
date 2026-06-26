Return-Path: <dmaengine+bounces-11817-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4J6xHRJ9Pmq/GwkAu9opvQ
	(envelope-from <dmaengine+bounces-11817-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 15:22:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1BB6CD652
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 15:22:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=GZ+9AIe4;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11817-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11817-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FDB4300BBAB
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEC13E1CF8;
	Fri, 26 Jun 2026 13:22:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A39A3BB118;
	Fri, 26 Jun 2026 13:22:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480133; cv=fail; b=QJnZjXcZ2sByH3VjOEz0RLDpO2OZsIaMdIW9+mfc8wTmgkVDg9wDtn0QjQlb7Vr2UR4OpKkFGUTtkDDGT1Wl0wjJjBp/eg/gr6k7d/LPNaEJvwRGDiSSnUQ8g7MUh8rSlJ32pLAH+oVgp/JgJps0D4hXvaeKZR5V3S4EmbzsNEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480133; c=relaxed/simple;
	bh=+Orq2kF2ssd/UlrTcFN9RjlZLQwAECorIEm4/K3Jo+0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GSrd/2GlgeWXPJKohCGIz8F52A4wU2aj1GW8AH2SWLo+zDbHiD8mU7P2u6vgeiUkVjZi+JLim1+KpOMr21w12SHBYkL+IH5pGjvgcFkzVAsFz3zwwgYQuN8S7Wlxgam0TsPHq0oJppfm9+9Z4tcQ51Md0NvjVtAORIMWrdhUzto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GZ+9AIe4; arc=fail smtp.client-ip=40.107.209.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFTfIAlxElLr1VnpTjXR2SrX82HYyOln8+7/KqxkgDSwXT5YRsBIXyK13zZPTdHgQB+Kx648W6s8NXij/X/5VtbmFQ/NionX88MzHq76JouPstQ0BV3YQYDQ87xSz4YhLvvJvHkQtMr9ldgNa49zPNZDOED51AULreO3bmCDIO8WUNneUJi1SXCTQgu2CtUbSqiAS4Vfvg0zUE8hp2PKQ3KyOIfalH2uvuuzBVwyt0MbOXD+WlN5hT6711Wg8stS/UzTUNKHsj1N75lDPKjhBSv1OkhepjrfhdBY45qMmmxs854RCsuU1gWOJLey5wre9o4Y11Gi34j6RmUooJenGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M52TyjCJ0Ukt+S63pn/17jAPLL7z1YnI8pBgwF3SAwU=;
 b=TGiuiFiBnLnCSECo3z5FTzQSpw2PT10tGZYg0rjgGz7Y3CUiwnzrhF1ffavboXYA/e2ZsGALrrlgCeoB5NdbU0J+zQABJX60NTz42cfM0Zq+P5SJ6qhF0snuu6Fhzh8whQFMlffCwD/Nt45n9mSWaXygzx7N+2AQXhcHnoiuHneLdR9lJvUy33U2cWrbwOfBDt6cZMmQ0qdc3j5Isora95yiKYilBHqlJr8XQWlGD02Q2e65h6oXaVpGoph9Z824LziVK4MhGsQaYRdX0V00DConSnh1qwvD1FHlTNkpjsw9LkhweLpsGbudov+1Qi4NOXC/aWxRxbD6E/+vPeSPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M52TyjCJ0Ukt+S63pn/17jAPLL7z1YnI8pBgwF3SAwU=;
 b=GZ+9AIe4LgfqJacMrqXsWU2gykNAQoFBCIJkXC20vR1GI9EwE6CAD8WaXRo/ClLwhyINdn7ny8VFbZhJBUQ6VboscBZ21MEeMZQXJP3DHa7Fxbuh+C5mb/mT11iu2Mwu5Jd4IH1XEmOWH6ebW6RiC4c0Zw0YMtfdMgLn2PtWXks=
Received: from BN9PR03CA0649.namprd03.prod.outlook.com (2603:10b6:408:13b::24)
 by DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Fri, 26 Jun
 2026 13:22:00 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::3d) by BN9PR03CA0649.outlook.office365.com
 (2603:10b6:408:13b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Fri,
 26 Jun 2026 13:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 13:21:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 08:21:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 08:21:59 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Fri, 26 Jun 2026 08:21:57 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>,
	<Frank.Li@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <devendra.verma@amd.com>
Subject: [PATCH v5] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Date: Fri, 26 Jun 2026 18:51:51 +0530
Message-ID: <20260626132151.1875965-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DM4PR12MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b2c7ed-96c9-47e5-0558-08ded385e737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	gcZi9TpH9/UhEvfPuhdYVHOmsYgkrZheySzJyZlexC8FI7KPP77AkNnUvW0+irw419qNP/EScJMGAe3Z/Ox1Le6G3TkFwlGl0QBLUS4vBTYw/4CdiC5Nj2FK3+zXpH2mcqYnYWR/AuJSeY0TzCzZA6jmPna00Tj8duYM2RNmFoBpsiEAr4L88/2YvvonrGL+QVLmy1W5M9eEgozLuMTTigILWktBFDbiugUKhwKMa1jM2+bhugBQ6IxvFoeMwcAwOfBCKeSbVKASKYFDF/xsGX1dfVWjjE5CkeOQLCLPlxzdJT8RRK8dWvKCOR7pI4OqempkFYnRhC61N8kbZ5AJnpG+5SHdEIykyTyXnilopRHYwy80BMV0ZE94P9qAAUwHqmFL2g1RpPgH5agBZ0FV2WlrpH1icy70sSYaYYfhPfU9HuC3/nkaaBzlokT8spCAijt/D9ttEePT+WAd72zuLu50pG8t3AwROVbw6d6LMWEH/nsZ9wlnnsZwRRqKxR5k/DOz1i2Gv2v/kO6XAjJoji+L2smdiAHFzGv4EDnpD+EMWmEIcHHNvm47O65RN6QtrV/UYajn3vVejovBHpdv1N6zjVFSgktrN8MVUnhbDeJ9A/xJKInpfZxVYtbZyYNh3rqiGIUcP83+Ns9ICYbk6lvCykG7Xewi1ME8z6vp7+uzqPag2/Xz/BiB1oqwFS7JEU+V1L0lt+zuLn5iXr2p+A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5rPxZfmuHXNUdD4kO/VB380CI9v6OUwqdrLEoGEtZ1Xxks3EZc046VUZ8hZg4Ll4fGo/iL0pQ7qS2XGoPYb6joMajxA3xRluaIUDz6LSX6Lw03opcWSMueQR040zjTr7XbETh63vZbzZXQ7BraCO8LyVenmR21k8L7VvgFqhrP+OY//QjscZmag2c+bFQUdCe+iheslcVSrXHjDvTLJ8trTfD02FTNrMzMwfOtkEupyDdtX60iyAeZut/GjYxBs2STkejL8Rmbea6EWubbwxCFq69XkPymYHU1n280cU1s3mH9gTLERhg/iqDmT7eUqeoauYfBbQNXfdLuhCpq2Kz85wZhaXEPhgS1RXmUvonTSfgEfhjiE3NreGrzwRmGuGqzkfbWzDk0nGq1i1rTlDGr31gAgFWBHSURw0OTAu5B0Rh2ytbwE6jT9xpwQsf2vM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 13:21:59.6018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b2c7ed-96c9-47e5-0558-08ded385e737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589
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
	TAGGED_FROM(0.00)[bounces-11817-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A1BB6CD652

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
 drivers/dma/dw-edma/dw-edma-core.c    | 19 +++++++++++-----
 drivers/dma/dw-edma/dw-edma-core.h    |  4 ++--
 drivers/dma/dw-edma/dw-edma-pcie.c    |  8 +++----
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 32 ++++++++++++++++++---------
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
 include/linux/dma/edma.h              | 10 +++++----
 6 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2feb3adc79f..adf1b3939f96 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -925,9 +925,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		irq = &dw->irq[pos];
 
 		if (chan->dir == EDMA_DIR_WRITE)
-			irq->wr_mask |= BIT(chan->id);
+			irq->wr_mask |= BIT_ULL(chan->id);
 		else
-			irq->rd_mask |= BIT(chan->id);
+			irq->rd_mask |= BIT_ULL(chan->id);
 
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
index 902574b1ba86..d12fefbf3952 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -91,8 +91,8 @@ struct dw_edma_chan {
 
 struct dw_edma_irq {
 	struct msi_msg                  msi;
-	u32				wr_mask;
-	u32				rd_mask;
+	u64				wr_mask;
+	u64				rd_mask;
 	struct dw_edma			*dw;
 };
 
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
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 632abb8b481c..61064de293b8 100644
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
 
@@ -118,19 +129,20 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	unsigned long total, pos, val;
 	irqreturn_t ret = IRQ_NONE;
 	struct dw_edma_chan *chan;
-	unsigned long off, mask;
+	DECLARE_BITMAP(mask, 64);
+	unsigned long off;
 
 	if (dir == EDMA_DIR_WRITE) {
 		total = dw->wr_ch_cnt;
 		off = 0;
-		mask = dw_irq->wr_mask;
+		bitmap_from_u64(mask, dw_irq->wr_mask);
 	} else {
 		total = dw->rd_ch_cnt;
 		off = dw->wr_ch_cnt;
-		mask = dw_irq->rd_mask;
+		bitmap_from_u64(mask, dw_irq->rd_mask);
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


