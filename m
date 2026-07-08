Return-Path: <dmaengine+bounces-12116-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C32XMqFVTmqEKwIAu9opvQ
	(envelope-from <dmaengine+bounces-12116-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 15:50:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2636E726F58
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 15:50:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=YEvxBQLn;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12116-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12116-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2064A30379A2
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A988E2F49FD;
	Wed,  8 Jul 2026 13:44:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD037C933;
	Wed,  8 Jul 2026 13:44:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518248; cv=fail; b=AKJYsigIDxozLslol5D9t+blP5eefkcJlRlACK3Jbc+AGzMSeJUboFylbsqGpOL1iqGB+4kAcE0znmv7mwtsKTDtgkl8Eg2zUmYBkz2jr/6EJPIrs4OOINEVSi+R4HIU289Yq94ethQkxaEQLw3Q33eqMkykkEpbCktKYBfNzb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518248; c=relaxed/simple;
	bh=gYKka5KnLFX5UgaYAPU7lN85L+w4m0c+q4VhENeIo0E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sKCKfVCRhZuyqtDnyQ+2QOYC14rg+Hmml7I4PE9expmbRdCCtOzxLoB6FvueN+SiYGUDujfDWELeh8j6hMnagxsEZRAYaVUvAAgp8B8fSJo6O1ReCoorAC79I+bik8AGaWxQ+AI4ZOzC8ztFCmuoWurRp7w7dIS1wT8/9fP1LUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YEvxBQLn; arc=fail smtp.client-ip=52.101.48.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1rMQ0LiN6G578g1zZBsiSTptU0OvH6Axp/PVfe5P3mxeYpT99gH9o8U/j6cYW8oSfFKwJI5AcgHCKgH3es2C5aWB5Tm7iX7KQr8Q6qZSTlww6sidUj8HT6yjYBwY0bfmisgGFhgEG3Hz2oDjgJBQ4AGWugxkIWviqrhZonJW/u7FAo9zpQLwUe8SbKNa8t9MAcJkYCYynMEpb90DSSOECfSjHw0pgJUpQwGP2nZyGuJ2FHKwjg/MiVXM6NK9uZv8yosidgJHsE+1NPhiqOsXaiauh7xZMs8/qWG96ADqdIjQj9BUxroVrFHVMVrKLzumM7LqXJjtZBWbPXnaSABbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rem327/eOeEGrEJTTbDhpCq0OnrEBgHYntGIesDnvAE=;
 b=qx4c3OgG4XTl2GuYMDXN1Uk4WuskeV5iLFAbVvvjYkj2YWqw8cI1QKJLeCXWp41mRIz3bOyggDPGPNI74nb6F5+/RONMtbr6DDeXa6Jd1selHp5hRTm4vExE7Hy9rg424mBSFiPkztZ88q5SBT32i6PPb2m1nnP5NqB06dNIcQPFYTR7498SspbDz2Qr9eqxg66v91VDdQ6KBAlRvOnQmX+A1ps9IHtn7lR43DWWIJ9QxDC1AW8a65IY20sxasvtwkts4NmPin19MvoMNkAJn8/eDNRCkPPgiK+MHPkGXlrfKeD0/uis+rLtUQaeybEU7KU2SeZSo/7QZAR4b/ZPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rem327/eOeEGrEJTTbDhpCq0OnrEBgHYntGIesDnvAE=;
 b=YEvxBQLnZ+DbtrkQropqePPxE6KWH/8CBJyRSvqI67Nkl+4FtfNtnilu7+vUzfJe3GpFukFV1PheT0kThtkQpLvLdku9Qg9QteErgdCM0bn1yTzPi4MaNXkFfkUZxj0bBj3m7AGbGnW4nDDTQ7t96IUKntndipi2paxL4xEi49g=
Received: from BL1PR13CA0398.namprd13.prod.outlook.com (2603:10b6:208:2c2::13)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 13:43:54 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::11) by BL1PR13CA0398.outlook.office365.com
 (2603:10b6:208:2c2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 13:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 13:43:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 08:43:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 08:43:51 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Wed, 8 Jul 2026 08:43:49 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>,
	<Frank.Li@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <devendra.verma@amd.com>
Subject: [PATCH v7] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Date: Wed, 8 Jul 2026 19:13:43 +0530
Message-ID: <20260708134343.3806759-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb3850e-5c43-4fbf-729f-08dedcf6f28f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	gZAgquAzQum9EF5SPlj6/QcyEIWJKgLrM3ieuQ/zBwuP35HZZ/uRM2lOynzaVIFRUepdVCgkiywrLyL0IGJF1Db8TDYB8bBNBbjp+ApoX+FlfmwvE936wipsQojAdwjIrzGI+SrIhBBy9uMfAJfzj5XylO+lZ6dZ442UFyh9gmdOR+k5ImyK2myWc6dP7FLXcTqCSM/MyRzQfMY+PuexYbdqj6Ctw27UE4q6P0dP2IcoDqLR9JnvKQkmaBq9bVH1AorwuUc8B4GFLk+bFftJLH3iL9CIP6qskdw7dgq6/CIXLz2bWh26uwkcM14cqzmslidqF+V7G6J4ZT+sRFfDIFFdH3jEpfgbq1chU1yKEb5GBNGfswfrnzhiXaV65sMgDdCPXKjQNfCS79D/245jatmRdzMsjVuC2qFdpUoe0wNdZzY+T2oOMLNymsDZkraMQGfq6xZyppcTpQwnruxuE3xST0bocTJWd6FTH0zoaJpGOp0rZe9bWVXx2qSrzijIQ4WlUEjhWxHYgDKnFKJyo6eA8xtmAMdHvby403xj4/MvKkdNNJ9npoYWpmK/QAyS3J+dtOkGqZrTCKSETVJBQJA0AY1WfEioynahbHqrH03Ip+UrCquCbKLDzfQgidQQ/XNkwybjskuQfyC9mliZ9O4EUMflsQykLns8GBxSYTBf4GQhEJ4DrTciZzj+UU61Kcm2BYICfy5mTD5f9rlfMw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z31DcODsdRqA37Im7f8Uw+H1Ds3V3rTLaYz6qWogmXFfnVvhVXk0uMGpiEG9v8hwJEQjk7SHU+xtPrK9i+vuiz1vwma310hrRngemsWdwceLg56XDN4IWB4TFdMJVfk92y0yOC/yUdOErKcz4laX1ySMxqD+tM0x++n/0pVP0UxuHVQJqzPShTLA5lNx7m6a1brGG16hfkVuUUskauQ4nNElMeqtBXIRMM7jsWKtNUdDuBfjKjzz0YA1lwniLhGiiFIPyQJo7mikxjuZBYqTB3Lll+2WT8pttgRIXUxfhsECa3vYLxJbyF+/CFcjPhy/p85aR+PaK9u1X2tUAdAiGpa6oVC33r0H6MhC3LnZYpHGHhqaMgoN0ERz8U2Y7PtN4uODvXah2XakbUs4ojLylM3mOAx4IT/VYFsQnBwGYZ0qpqj+BKHjIARfgN79S5zT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 13:43:52.2297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb3850e-5c43-4fbf-729f-08dedcf6f28f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,m:devendra.verma@amd.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-12116-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2636E726F58

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
Changes in v6:
  o In declaring bitmap variables wr/rd_mask, replaced constants
    with the macros defined for max channel count.

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
index 902574b1ba86..25a6e8a958ad 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -91,9 +91,10 @@ struct dw_edma_chan {
 
 struct dw_edma_irq {
 	struct msi_msg                  msi;
-	u32				wr_mask;
-	u32				rd_mask;
 	struct dw_edma			*dw;
+
+	DECLARE_BITMAP(wr_mask, HDMA_MAX_WR_CH);
+	DECLARE_BITMAP(rd_mask, HDMA_MAX_RD_CH);
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


