Return-Path: <dmaengine+bounces-11142-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NHkJEocMIGo5vAAAu9opvQ
	(envelope-from <dmaengine+bounces-11142-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 13:14:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B35FB636E89
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 13:14:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="1X7jlUh/";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11142-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11142-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F43430A575E
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CF03B4E9B;
	Wed,  3 Jun 2026 11:06:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6E3368D5C;
	Wed,  3 Jun 2026 11:06:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484800; cv=fail; b=FhIsHPp1RovjraIas6ecUX0tl1JbFY4yskU/3vxBL9te6nRL0dWsbYfL8RMTatZkhfRV67vT4iRWQsi0xLQniojYashmCcTHNt7Q0UJ/FvEnvJYGfvlyh9u29YD1A0bj5+ocVAfcBzc+yg1IzaMyrSns3yKDBblMliPpYu+YeIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484800; c=relaxed/simple;
	bh=HdSNI9zX0HsHAdyHE2QwRIFxyHzwmqJuGIuNkTU2JZ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gdJhPhX18eH2lXXGyfX/fxatRDgJKQTINHFHuDWTY2iB+Wdj6j98pMS1XF50HIs/GJoKHLbStPIz/eoMnG7naCIe61M4/vptqHDWWuVJds6N6tNK3IQ1rOxS2lZBr26fx6JNNhIoy3eWAAcRNl4m6+i1u11sZ1Dl7pFUuePH9d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1X7jlUh/; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnxMlNMmLdvMYKT4eAgV+1LWs7dMp7BHmQgGmtabRavdW4o0X4nFGJgG8oJxRcMFoaa3QYIy5vTh4vY8SjPqNVDDXjbG4FIg338zm76SK/FgY8NsW734H9d6EOHtB6XFsE1XH41WVUDQVK8TFJ6AgD5lL690916s/uinz0zxYhkHTplTzl+eGwaGTiEsk2oCCBlk+dYvLzIMi5DYqFY/4Kkf0pW8mt8qXZur6aPSbtiL9B92Gl4H7m6NXmbmNbHaFlXnNKV41R2ewqTDpgwLPOgNVUKk45yJpLG2NtwzL8E1gcs/qpDRsRiiPDYqO597UnYv2B2bmfdczZDDK8geaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkuriwHZ+ZJn/ed3QfbfGNS5/W9Q6vHRwufby80WFsc=;
 b=K0ZrNeLXPAlJWz6xjDTkm0plTHmvqoJMADIHfh5FlFNrZfUlBlOCJixdq0+EATBSjoZDmrQid90egXNfZPBoDNdI8D9gA7Dt6+kI1td36PhIzAD+CH4BPQ0/MrRIhzLVFmSKAEjACTP0mK/XSc9N+Wmi2bK/xpkgoQ7/kjQytKGRiJh+UXazqufF3ky/ejC+5B1E6EThIRj79r3YtKd1gCFwbv8lSSg47lkqHzzVSgrgx82ck3/7Gj3eW4kCuwIQkQGpGmepw7HjfhQt6UQWKh1lAWiBVLFo09fXAO0y/bPrHSpV+9jyyneb0HONe2roWdtj+ShZU6J58oB84IlH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkuriwHZ+ZJn/ed3QfbfGNS5/W9Q6vHRwufby80WFsc=;
 b=1X7jlUh/FO/Q0IpWagEyOwY6I8bMC+8ma+vPrMO2s6kqV7sKx7uAkd69118scplLyTSIsDelAw2d9jMuC2+7/BD+Hx9qM7/+kxZzoSp8oB4xTmjEK1yK2br17use4WbQt/fcu2IxzQ21JdiIXeQ2Ma94XlTPyj/szDoyo+nXPEE=
Received: from BY3PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:39b::6)
 by DS5PPF5E0E7945E.namprd12.prod.outlook.com (2603:10b6:f:fc00::650) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 11:06:33 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:39b:cafe::4) by BY3PR05CA0031.outlook.office365.com
 (2603:10b6:a03:39b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 11:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 11:06:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 06:06:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 04:06:31 -0700
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Wed, 3 Jun 2026 06:06:29 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>,
	<Frank.Li@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <devendra.verma@amd.com>
Subject: [PATCH v2] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Date: Wed, 3 Jun 2026 16:36:28 +0530
Message-ID: <20260603110628.2807317-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|DS5PPF5E0E7945E:EE_
X-MS-Office365-Filtering-Correlation-Id: fef2e3ca-4303-4c03-0310-08dec1602bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	r75ewyY77T/bkHimsYHscCnZjmG9WDrddxrauy9XP4fQqUy8zIfUa90K9d4Emz+TMxdpPcd1Rcs0Hw+kWRggutMxyzc+fHBpPzstANdlxAYMkNkO3v11cJchvbSGHMfHEvInrL5R3N7hnltBI1djXtK5+JjWDmK2S/VA2gC/C/e2LYsxxnCzsCwsU8+2zbSXluDP1VXFG3DuAO9eQjR+5YwMMEy/jqWs3Eg3pCgCRZb/L6bpdCisnAxH4lRwQZobHmzWsN/p/q6gkCHCPEZ2ePmqQ9q/59ADlfCGdcFz+LAx6HjLlYEfz4qEl5RbvO8BMXcgEhdltTD1Xt8FWstrWRW45fQmyywHPPzR2srGEB77W+rxw01atM6fygIHmeYplh5WlG7Dkfkyku3w/o4+Xdx9btK3vopGsGZikRyIo+LerIChWlpo3KP0aG3d5c0ZlY0EnwisH3puullwbNwsBqBNDqFL1Jq1Y1ef2J4HKGVSZLuP5yZjqriTdqaMEboyGMJn0r/SicTWuET3b/y7G2rrGbMKUwZvrQFY20TlNYmsRjhAWww7fY0WD20fWo0sdG6D/hl3dRMMQtvld1ss3tem2STbyOkh08KteBZd5mV6WcvoQodPP+8Y7/5h0/FY6F7PHKGfY6RWPzuk3EMpifAYpDx3hfPQoBbrWh6X3kfl1YuEPaQXiVobfMixIL5784rAMGDGGBv6auRqZmyFdCwMLNXv6RM1ezZSmXJtN9Y=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z4utA2phMRQ8W5j5vW9Ixz98WEFeFMk0TGphO5nUAZfshh1Pr22pI4PUME+uvcj9OP9cGH7t+Obnb4zkdsHEJWcyqVSNtaM1MlpZ+yNnwZYjMNhnLjOZ6/ji7ItleeUxprac2F0LhQ7TAD8dGKseAWMAI9cDUpeYh66f/yHZlm1tl+EdEiugNMJYhXY2cZWhhEsujFCpjcD2CkNviUvGmMHs1XX3RxluNv4fNeTqRL8oYcqbrhNtLXofzkm9TWxIBJ64YzxmmczU2JWbtQgu4gJXJaLuj8Dan9AWKhqM0AJiTnbOVL25EMHAkmwh3GcHJYzxcSpv1JkWgyNuKWlWUhjfWvGwFhyWtUHyfYGrl2uKJiTujz0HS4RnhiVLo4N1a8nQodYO8sPvwu3WpsW464thH4D/Jqfocbna2wPQMDJpwoiLtnSmAwJhgVl66+2R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 11:06:32.7932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef2e3ca-4303-4c03-0310-08dec1602bcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5E0E7945E
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
	TAGGED_FROM(0.00)[bounces-11142-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B35FB636E89

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

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
Changes in v1:
  o On review recommendation of sashiko bot, in the function
    dw_hdma_v0_core_off(), the loop iterates over registers
    as per the number of channels enabled and not on total
    number of channels supported.
  o Changed mask types to u64 for higher channel counts.
---
 drivers/dma/dw-edma/dw-edma-core.c    | 19 +++++++++++++------
 drivers/dma/dw-edma/dw-edma-core.h    |  4 ++--
 drivers/dma/dw-edma/dw-edma-pcie.c    |  8 ++++----
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 23 +++++++++++++++++------
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
 include/linux/dma/edma.h              | 10 ++++++----
 6 files changed, 43 insertions(+), 23 deletions(-)

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
index 632abb8b481c..d7a3c9a73e9c 100644
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


