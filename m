Return-Path: <dmaengine+bounces-11747-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U6PkF6xsOmr58gcAu9opvQ
	(envelope-from <dmaengine+bounces-11747-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 13:23:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFCF6B6AA5
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 13:23:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=BaOAl8ZV;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11747-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11747-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40A2F303FAA9
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 11:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DB137C0FE;
	Tue, 23 Jun 2026 11:23:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F335201B;
	Tue, 23 Jun 2026 11:23:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213801; cv=fail; b=BGppblFWWEWzwOQonw5uCSWBAnbGracHrp3njbo04kVnt/jwRulyb6Fv5toxfpGVC1O6i+v4nrw9vPlH09lR7kZzXc3FqvxP6YHw2RYrO9dSBkjOrQnuD8eBoK9pIStTwtwWy9NyYHW9JnqGsf9+cSGKvOizyLKeDAjYYTJOFVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213801; c=relaxed/simple;
	bh=HpqTxWiv6yInQhxFh70jo8CHANJ735fw8ZBzMCcP2Hk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wl3Lx97QxcIt1isU4dRMSSC8nG05F7kyOXDsJFZhSSObwNfT686AOhXn0rsS18Mzd8OuXVhp3mzCnP9b89XXR1iFOXpgUZ0AwR2k2Q/1YW90akILXfsrtTGJumTSpzzGxbCobFpTMQbLwIbwPSxvCV/tA9KrzGSyJVsab4VHYEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BaOAl8ZV; arc=fail smtp.client-ip=52.101.62.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcX9SyMLBofZLprKaL4OAXCbGEx6tzITIvCQuhQza1x7JYpFZaKc3JkDCF8dIRiOT5xrSX1ZcC2WUHgzTwd0MeDsHzQgPzXwUcn48IsOEWJKdOVWRrM8mlpndDbuGGXPIV69a7qlXI/uhxIS42IghPbGq1TgPNu7A/Afm1WSglF2Hu6QaXzf84LArWxbppzDUiwpkBD0Q8fBP4pm8oOh1etEuHJ5rIRSA/Vg0OWsyony7CubLQ3pQAPbYowXaFdC5zoGlPXxXkZeNxMMMWH74Da44l+IB9CWlA5EFt0swVqqYlzbsL9SeaY0/JDBmKI0BUBvEgsbeafSHkxAEAsSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nN1bCksciro7JWVSrhAmOctTDvHltJgX+7NBPKRg1U=;
 b=sNYAdMimbSQ5OQf8THHAvd3BM7v1qFEslcSYJ0uKHU1Giba1eGYN1rR0+jUmabKSjfby8FoguhfPsvJftaRSNKf4GcYKpjSwEjVtNNno3RdduxTMRRw2HNoyJ6W2NjHLYOI97IELciRSTFsfRDmmpm0ormkJgH+JEsisewHCLW7P+ERiXUrQ6Ilty5igGVQWLAe0gLLBin0C3Gvyu7wlFCi6StjfGpGjFCh3sGB751eTTtge/KxlLknuqJ63IqyHYGPz0wM2i2zp2cc2hqiCUCLt8lPNo24/KNoqErWuTM97qay7r+eN+aVxCIHEPob5IyadLHkIdvOlsLQwxeEXFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nN1bCksciro7JWVSrhAmOctTDvHltJgX+7NBPKRg1U=;
 b=BaOAl8ZVgUQnzyRjcdDTbkyRIg9qCckE6Mgq6BeCT3U7/EuajtH3G2FY4+EaPr9rMguE4VcaB6Ko4IYf+x+qfFZa0Tl57JU14o+NMqzYgQl27ExK6Pj3ejmknQfp3mnOOfQIrfUQOBTtrUbhRwIJ1MsRaJBBcIfL0bLlerkzt/I=
Received: from IA1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::14)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 11:23:13 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:461:cafe::ad) by IA1P220CA0008.outlook.office365.com
 (2603:10b6:208:461::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 11:23:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 11:23:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 06:23:11 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 23 Jun 2026 06:23:09 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>,
	<Frank.Li@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <devendra.verma@amd.com>
Subject: [PATCH RESEND v4] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Date: Tue, 23 Jun 2026 16:53:08 +0530
Message-ID: <20260623112308.3377168-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5d9d70-3bdb-4a37-7e8d-08ded119d081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	otF6StaUtvmROYtPuSogHqVFvpeh9p+8aRbq/8kJCaKYYhAmHprSnpyY68KC7KATC+61UYnMpVNp3kW1nP2NjsVUAeYg6lmre4qPHqPhGN0YSvSLhl5eEf2qUE3n22MhNQtaLzGl4hF+e9C4WdqZTLVeDiBZAP274/9uLk+gZGe+PoYap1SUgAcnXaVAhSneVa2udByt7H4DbXt8HEUEKSHw3HdkIYGhUw/jEmzgjFom2S8hEDKLwxUu6EJ2PDGxAMpK8SBe2t8+nmZ3jo5rshYTV1BOFYe80sj39POvYAwkWC5pwuZ7fD002onmTKn1HchlCxFSbiAm2qmH9rfGzmTLRl3hXvFVk1bqGWQhknFARI25mQ0Vv4079vzmbjlOaWyl2rhnWY1IuYXvu3XkICibJlCLiI82nfdoL7ZV4EyCVGU0pIFc7pl7kYCQPWJp3frmcHXstrnUWN6DqQxwKlOfNnD+2CAyblVklS3Q0pJ9rGe6hnFTj5ZtEOuJ6Gvb7jhQ+KAb848PhLRreBpdSPmi1Vgr7B1X5jR0QwDtIxewzyEtH0sA6nEm/xsg5fA/ADbbng4vevmZtjIXGkz0VyXeAlM7hMiT3DmchC6EWDoeoMuY3d724n1p3ULhD3fhzKBpvbq//gcX6L5GrzLZxxOnA+r+PisWA2onc4IK5qoD3WWYcZ6h4XY84jlc0EDV7j3neiKQDpUCd9AziDVZLQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PT30JPTG60AsXb6jQm7MXWVdhlfGIiM6uQziM2vAoHg3Iesp8jdkf1zCWY1aYl0yOAuQ7Ij3Lffs5RR83N32Tt8mU74r2GtjRXh/zV9x3nBGlZxfr1HIXl9QA7l/+GpkmSoCL+xqtN7eTykG5/Pv1+je+/HgmKoVdW1yFBq+2+che//abLDtirG6wlPjWIIuHk8ZYe6qT30Ho3I6BercFciS9j3jGQ0kjV7WJ+qSeKOENONZvMv66NSp+OR+QkF7PqK1OdSgz5RNAWhIHWFs2Yt1O6X6MReR0tRKnvwZ5qdk/UGlVPn1dvvPUpRagJMBWN31JPg7vBWG73Iavx5RzmF+K6M2DgvObVR/9XXGlh/6VfeX+CUV0PYx+CfR+z95viecwMjWs1QehvE/D0r84VjKqkr7JqGWeN2vFqkr2maaHlX3LIMp2BBpzhrHFb8k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:23:13.5310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5d9d70-3bdb-4a37-7e8d-08ded119d081
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11747-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAFCF6B6AA5

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
 drivers/dma/dw-edma/dw-edma-core.c    | 19 ++++++++++-----
 drivers/dma/dw-edma/dw-edma-core.h    |  4 ++--
 drivers/dma/dw-edma/dw-edma-pcie.c    |  8 +++----
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 33 ++++++++++++++++++++-------
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
 include/linux/dma/edma.h              | 10 ++++----
 6 files changed, 51 insertions(+), 25 deletions(-)

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
index 632abb8b481c..84b0076f78bf 100644
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
 
@@ -118,7 +129,8 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	unsigned long total, pos, val;
 	irqreturn_t ret = IRQ_NONE;
 	struct dw_edma_chan *chan;
-	unsigned long off, mask;
+	unsigned long off;
+	u64 mask;
 
 	if (dir == EDMA_DIR_WRITE) {
 		total = dw->wr_ch_cnt;
@@ -130,7 +142,11 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 		mask = dw_irq->rd_mask;
 	}
 
-	for_each_set_bit(pos, &mask, total) {
+	while (mask) {
+		pos = __ffs64(mask);
+		if (pos >= total)
+			break;
+
 		chan = &dw->chan[pos + off];
 
 		val = dw_hdma_v0_core_status_int(chan);
@@ -147,6 +163,7 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 
 			ret = IRQ_HANDLED;
 		}
+		mask &= mask - 1;
 	}
 
 	return ret;
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


