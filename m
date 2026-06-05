Return-Path: <dmaengine+bounces-11185-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZUYAAQu1ImrLcQEAu9opvQ
	(envelope-from <dmaengine+bounces-11185-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 13:37:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C139647C79
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 13:37:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=JUIozBaY;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11185-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11185-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE04D305C228
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 11:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E2D4D8D91;
	Fri,  5 Jun 2026 11:28:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2804D8D88;
	Fri,  5 Jun 2026 11:28:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658925; cv=fail; b=RbiknzYkQF6/9rY/E2lrvWGUHOUAk2+P0LzPrjom6tSfAuq6BZZqwNEmaCmAKABXDydEY2hAD0pd4dUEGmQ7a0EV7lkVb2ZbDtmrfobdOVWwbtIE5JBS5xHnG5VOT6dpR9J0kZwtvRHzL9hxSDYBcqAXx0A7hmvnvrP1mm0tRFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658925; c=relaxed/simple;
	bh=j0B9D4AmNG40qYcx7e1cAsv+xQGPRN4KlZnFtRiAiiE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P+qaUDwjcRae9vdmVGW+ZMlMlr0Z9cbsgxn/PXJl42mylWpieImbADdzLzIU7+lhLRAblpdXrPhpLJMiQszTdVAT3KVo076WVLV95l2LOjHbpQdAkMKLk+9/yF8IeRaQyaedC1l8k1tLTTIPOAyL9/jTZaY0cGv2gdJzKQSzKAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JUIozBaY; arc=fail smtp.client-ip=52.101.57.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+Gh20EfJL4L2alwIXDWw6srwWslG9GJk3/8RphsCFgwghUZdFkoODXvE4rn7Tj6DaloqzlPOj0ERt+qmaniANoArkFY2fKKFW4aGFg5PZxk53svbMWcq4W3F5g2yG5A0+tzHIB6NfFWDWESwmbflV3Fxi22ceP7oNtuyj0n0F5rn9sMr9zkJ7GsQb6Azbn3yk7C98oHewJ96LEW3Fxvq2gpl8bR+NKQ94T6nC2dbIw2HoiEgGIBxXA15ckkQidZUdT5ACrh2cUyQD62pufF6V6Zx/45Eh7D7Te+lO4So1VvgfzXA3IJF5IEPG/GcTWycMap+Vk4lta1bt/ZT/epDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWZ78HTa0QeDHZbQ/9CGlqT7xtGTkreJzSj7EwoH2ws=;
 b=cBJQb5ibvni1Rl4Z1feE1D14EDyIMHoOZEANZeEZhWzTNuWo+DjcmJk2TAbPTBTbtAadhA2auBy72nlAFiK4fC3De8juNWsMnTtLKlxAdjSeY9zQcsn26/ef3whszrmO10gfa60ePZKSpgo3QYXtCMPQpu0TPS2n4t6wUkkrnS+02OBeMVlVJCOP3FL+FOuYEqjzh2fk1iPffIY3ZjYrukc6KbeWwaJO/TGMWJgd9F6MTXX5H5i97UvOTMXgrGcHLEE/p1GIa/K2XYdo71LaHcVhxu9CexbRiiT9JOZU7964UKgPsfH0cGcuP6aWeRGm8GK8cBBPu2iYeS2krlo9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWZ78HTa0QeDHZbQ/9CGlqT7xtGTkreJzSj7EwoH2ws=;
 b=JUIozBaYg8sngGGSCf8Y5mhPEpwSY1pm3DNtvSXeWFmT3JOKcujboL6Je0CMvVPxUxJCA/44lfHdUX21GslxVg8AMPU0QfxDkHByrX8ggTloHyzFHkKgn3q2t9icrepolAeLcONX9bac0Z1riNTsDLUppfnpNvJJEffoEr5dwXs=
Received: from CH0PR08CA0004.namprd08.prod.outlook.com (2603:10b6:610:33::9)
 by SA1PR12MB6678.namprd12.prod.outlook.com (2603:10b6:806:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 11:28:33 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::2) by CH0PR08CA0004.outlook.office365.com
 (2603:10b6:610:33::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 11:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 11:28:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 06:28:32 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 06:28:32 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Fri, 5 Jun 2026 06:28:30 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v2] dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
Date: Fri, 5 Jun 2026 16:58:29 +0530
Message-ID: <20260605112829.679697-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SA1PR12MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 132fdef8-5620-4dc2-5d36-08dec2f59338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	JlgFcpmnQRohOHggClbSKiDTJ4Zg9jQDK9FyZWIQk5UzuQckmKt25zcGph06d/Nwl1EL9wF/z1Bwx08jiheJ/8JdEllLaur+UIhriPiJolKe6uTUzHjWRPgKzmgnJBdETI23YPjn0MQeHw5fViOjYhzeFlWAxIqf5K7YNvnYPzwjY6z3uMmS+fBU6rER/Ad3+S/ITIkau0iQ6/NAPq5moB7sPr0E5eDQc53Vv1B2YcR5bygI1vWZvHY0Cxbqc7RdR4O70mSpaoFCk5XadkKi3Jm+dU3tKxV/Kwao1JKxzcETHgX+2O1yyelEdR1WoqDcWta8XPFZN3rnv0vhLAFb5CBihO+JQFJOfVgBxxRjeTKCBgW+oZAPrK0YnTaPWseuAkxgktcwkXR70A8Ez536CXrbMTJrpkDWvU1pXeZ8pbT9cDogTbd0gkJ6q2T4mB7BXEkJjQwp58vggHHbyp28Cx8T7aAmv0OQeOtloYCq84BpLC7CQ732P21MKaJOc55QqERNYJHnyvCLcx9xGbOxLa7o4MKszguMnbOpWcNJwwMUHd2H2kGUI92oY01OBcqpj1IeJw9JcHq50ykYdePPAkovycCc4G164Xymkmzr/aNxXn891nqzXRiNWcVqXB4a3rSW9e1f6B6Yoril4CloMlnNUB1ECggl/e4DBTQVG4kwMV9OoPuC9UhshtkZeJESIHZpFQsYGzVHm1j3tdzdymmzc3wK9CLnTF7nrXkU/KI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0rRJj+aKj//JG61hSdSRjnBqXn1vh+B++4M4WbamIcBKz4lXr6C8TrF6v0HE3lDd8wtOw4R+3QnMYFtvbar1MK+iEtV9u3WuB2sanYHaSMilOTM0VF9a+2619xaO6Tn/mc2QR/unFwqnHXykvVE4gl0+9GF+FKRhVfle0V93HZHVrSxeeZOGvMQvvsVE/yl/l/Tm/6sHHihplh7RDc9/AWTuY010LJ3wAoIWW/r23CkKidaAR5BROx1t7cR1mFfVyWOlyMEc5/P67LAsPQ+tIRNruQESaqlncWjDgGJTNeEVpNGY25fgfuaz1bGARxdcBunFNQGw/1XgIbYG6wXCa3y//itW0JDrMQ6Vrs6bq56HtJtijZwl225hB8HPf2ct7axcT4OGLpzzE6HmBgWq+EmCTJenM/98Tp5ck5E3utsNnrrhpoFQK8WkRwaWBTGC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 11:28:32.5495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132fdef8-5620-4dc2-5d36-08dec2f59338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6678
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11185-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,m:Devendra.Verma@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C139647C79

From: Devendra K Verma <devverma@amd.com>

Add Device ID for AMD (Xilinx) CPM6 DMA IP. This IP enables
64 Read and 64 Write Channels.

Adding the relevant dw_edma_pcie_data to use 8 Read and 8 Write
channels for initial commit.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
Change in v1:
  o changed the pointer assignment to intended pointer for clarity.
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 0b30ce138503..2082d0021a8d 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -27,6 +27,7 @@
 
 /* AMD MDB (Xilinx) specific defines */
 #define PCI_DEVICE_ID_XILINX_B054		0xb054
+#define PCI_DEVICE_ID_XILINX_B00F		0xb00f
 
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
 #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
@@ -125,6 +126,19 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
 	.rd_ch_cnt			= 8,
 };
 
+static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
+	/* MDB registers location */
+	.rg.bar				= BAR_0,
+	.rg.off				= SZ_4K,	/*  4 Kbytes */
+	.rg.sz				= SZ_8K,	/*  8 Kbytes */
+
+	/* Other */
+	.mf				= EDMA_MF_HDMA_NATIVE,
+	.irqs				= 1,
+	.wr_ch_cnt			= 8,
+	.rd_ch_cnt			= 8,
+};
+
 static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
 					   enum pci_barno bar, off_t start_off,
 					   off_t ll_off_gap, size_t ll_size,
@@ -547,6 +561,8 @@ static const struct pci_device_id dw_edma_pcie_id_table[] = {
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
 	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
 	  (kernel_ulong_t)&xilinx_mdb_data },
+	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B00F),
+	  .driver_data = (kernel_ulong_t)&xilinx_cpm6_dma_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
2.43.0


