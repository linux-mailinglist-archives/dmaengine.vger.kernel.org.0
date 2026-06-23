Return-Path: <dmaengine+bounces-11748-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JINJB6RtOmpU8wcAu9opvQ
	(envelope-from <dmaengine+bounces-11748-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 13:27:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4B96B6B4B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 13:27:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=iYsa0CCE;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11748-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11748-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 132A23023305
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 11:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7A63D3D07;
	Tue, 23 Jun 2026 11:26:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D632826AE5;
	Tue, 23 Jun 2026 11:26:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214018; cv=fail; b=j+7O8zb9Cz5Pp6DDmpxHMNDFWHq9XT8ZhFb6Ham+z+apjGnoZ1964x3G5TJZPcQH3aLtJJyvKzjo1VjEyTfc2953u0otV6bgLYjKjO6BzlQQy32/dMJKknCYouLB3z6PBvk3V9cwlhtooE7id5TVaMhtd/+yuqhqo8jcbdns+2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214018; c=relaxed/simple;
	bh=S/1D4kUpyQXS/MrTcUOl43MDxHJ9X7jYHiiRKZzPjg4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j0fbkvIU5J+OM3I1Nfsy8JE4zqZDG/if5MifIHgrjIqjJKXEtU3i8JuQ0z/eglSv3R08tM602XTGyXsTqYCXFwBxcp4wOfKqhU4+QNXGIBdIM+komcFATKtrg+ZZbhwQNF+5nfkJuonm+/fU1uxMWjMeaMbZ4uLqOA+UgmniTgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iYsa0CCE; arc=fail smtp.client-ip=40.93.194.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XW7YS4oH/CfwEOZ8UthORfAk2veYD7uW+IzzmrznaFqUIH0BGyq63SW8MZRY0mVFB+RgzW+zw2tWVdyKBfKF+yycpQ0KBQdzgVBr4E/vPgkaoIUk/QVxcyo70ec4IK/289jiL8nmLAMg3X8f132OxVtnyO+mvmrMlCoHR0ZtUench4YYDrZzV7dKpVMFJwFmwYyZ+oVVyLfB6PZquJ1WCveccwQ1ktVFFa5qIqdxqQpHcjdSr5Yw84T5VwdjYUesBQuOD7gZqSeFnsEIn10g1u3IiCO94ozTPTneQrbg82NllTtcDmLmb2fJUUbS0ZwgADtZETHap09KGx+a5Z3ZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eN+gfJb0HYDB5MfIT29Tul5KgYx9ZqPoSEbbyXa5OaI=;
 b=xn0XAlDwjnX0deJLwX+MG2hmXutRWcEB6dTRcMRwc6Ur2/iosK7ODc20Sudchtxz68jbXQLhwRs5b2uv3Rn4JniGYNHXBw4zOAXHMCd5dUk/66f323Dx2uyrBg9U606X3zxWKoEtTV3Be8Dy2b2f7Vy1Dn+39rs4zbUOlwxvgZBQlrVdldAFMfvvyIGuWEIZnBH9tD2Ff1GfYUmrlx4qnrXkrqQSKTZaMWbDCe4g2CRr3zOuTrBa6kHToaYveRP43Ve3dESGP8qxeQZFWdvUi1Hgb6YEWj7OcdiymeH3DPqjG6zn+ViUp6itnTxNrAUk5iLitBJYolIKnnUJJpdW+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN+gfJb0HYDB5MfIT29Tul5KgYx9ZqPoSEbbyXa5OaI=;
 b=iYsa0CCErqfe1RKJpc6CO0INXmsbo8l9DThv6AkuPWnsF2Xh/3+7QGTU/AbmSk3Jks+sjZdkUuKfA0DDJJpZPZOPAJL1GVWeCJqj2719xjQBLD8kurpeexCMbp7evJk9rdpzmmA6Tnv+x2jMQexHK/U4VLI+oKsmkPCGbpKyOeA=
Received: from BN0PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:ea::7)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 11:26:51 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::39) by BN0PR04CA0062.outlook.office365.com
 (2603:10b6:408:ea::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 11:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 11:26:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 06:26:50 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 23 Jun 2026 06:26:48 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>,
	<Frank.Li@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <devendra.verma@amd.com>
Subject: [PATCH RESEND v4] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Date: Tue, 23 Jun 2026 16:56:47 +0530
Message-ID: <20260623112647.3379581-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1b50b4-b651-4e1b-1eab-08ded11a525c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	YLpcs3lKW8+yTr5KcfMxchcjT/3hKy5RGXELHYkyc9ewRXqk1Gg1HnLTlgwcigms5kQqZZWKAcOc3PewBJ1Au5R7HQO9DhZD4mJqCmK1IKkpmfnWd0bcUDPNpcG6gorz4lBZP93E0D1jh36KV0ECrIJsRdRlnzhecBhwm00FTH4X4E+t/wKicCbi8Ok1o+Uysa5fI6Vt8Ygcon0A6yBxES32BNrWdaU1l9FD5k3TEEG5WS9f2iNFOeovdc5iMs5sNx1MHGw280we8liTxmZYygu5PU39+orOshzCPnWh8IdCvW25BndTjdPbp7w4dr2EvVvGXMJeagQlW6xCCyVjkptRKGAs67kzcbu3+RenqJASmVOdbbz00ZCXnCM7kcAffn9KtOwiEYjh0wFPK5s0osNWnX9VZjDcYzEYLneZSRYLIjEeJjobeg6vgDTxG76myKgPI7t+IEIysOO+3jmLB2fVNulm3UR1tCvP37fFUYZbJ1bXbbG45DNsegK4sOII0mgrzsWK7Yzlw6ON/kM20laWxQzjvL72I6ZfpB+N6K43cpdYTTZAMuh3Ajl4bxe73WPAza1+JyAh9SKSTZMOmGcaU/nHgM0JmX7RapBlovi/dmRYpE9KGJET+J+ZxGN1RuUQYr3cJyBbb3ykwPiaKrCIJOp61N335pQgNVoef7ndg2pCRbSCmCT7THc1TNS0MM/CjbEv2+ZM15S7X3GMxw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1g82Ll6RqTTmDHCk7MeFa0kJ9jBxmJGGrNu4/qG/r5lHZKQVtXroCBZbZYwBFSktZ/J2jAb5xRTTitJIU8bxte7AdZotHqBRTLwHKOLFvuSgmS2j6kNN4BgIQnaoGIY55/u7EZkdLaNydUegHpnwUrM6bu9lTf4xQBVgn6OEhmKMmjgksiy7JVTKAij8AUABpJy1wwtvEMaxJcJGt06E+K/bdoAc20lpid0/rfGcxs9At8/GJUMu0MPwjsILm3m4K/y+jpWpjAwTEk4SmI2bP+xFo9KYIlfTMXlhPdWkrvKHjDS+Gos9+MTQLE1Yjy5ze1pme/7XmpDUPW+Sn1D/+QazZLyXWtCyuaGGbCrjMP+UW7VDhC9mQ3PD3apQAeCtRpW7oV/DvFuiNkdt1a6EHro7dwZ3dogkHhmq600kItyl634Yomq0ANlksttG6b6X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:26:51.3899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1b50b4-b651-4e1b-1eab-08ded11a525c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
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
	TAGGED_FROM(0.00)[bounces-11748-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B4B96B6B4B

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


