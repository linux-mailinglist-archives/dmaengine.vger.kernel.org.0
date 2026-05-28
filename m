Return-Path: <dmaengine+bounces-10989-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAZUOfkWGGoAdAgAu9opvQ
	(envelope-from <dmaengine+bounces-10989-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 12:20:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6682C5F0813
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 12:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 862DE3221BD0
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBE53AEF22;
	Thu, 28 May 2026 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fDGgLGwk"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012034.outbound.protection.outlook.com [40.107.200.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC53B19DE;
	Thu, 28 May 2026 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963137; cv=fail; b=NMR3qkEKTSQtdnTge18DYfd29rTHnjbGcBgqNYuj+pYYMzPIl60geHJP3b+nM0KrnslzZuyJU+LHqN+MqSmLUIl5WkWoDK68er4aBz7ckLpZupB2+eO1z3EW8ND4nnUWBy6ryN0ELeN1MjEioJRnEY4oFrASs5I/JZlByINP1Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963137; c=relaxed/simple;
	bh=o881pNHBD7262+yA8FlQNm/bLKBke/1jRxDO3vgS7wE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oe6UA+75whFA8KM2YC7MdT0r7dzMXdbgFUgClxLU4C2DuYZAs04rtNwkhW6nA616sBut3WNPfMVO2ShmUQolGi1v1SWI6hDElpxcejGk3w5AXkcgoG90tsceOxyRh0bEA54JiL/UBRI9RJwH/m9n4VMVGmhmQgdvt9mHm+lXRvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fDGgLGwk; arc=fail smtp.client-ip=40.107.200.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFX9QqLzy5FGGnoAp9ch7Lw9Cv3N96QUCQxBGW3T4gPpb84fj58muOUKH1U98zDbhlwdVFRvUq2H15tWECpjleV+r4/txWC8jSyIDYK6Xnkxd7DTlmHeEINqlY+pqk1rZCBmqGLASFFb3Aglkw1URlCQ60Mf21LUKaUySS/AjILgPPXwiMP37UNHfoE5jpWXrRRxezeD5RDTg8i+kGOMqmIIrDtkAUN2zc2nwMGp5/XIvgtvZWdpXBR5UBxtZeNtVcv/HmKWJ9zmOxtWArgHhH//++uF6Ng71FUUNWpLr4NhB0r6u0JIxSyI0yUTSs0vRXcZEETi8rhZsQII954HBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ql6D1aEmnRAlMxeYPdVGOifiU1G1KCulykxIyS054s=;
 b=h5nsKnPGx5lpCn8UmeAHiD9paRw6+anO4IP+zbIWuhr/kQU3YPq3TSvmnQ6EsDMjrq1BQN2iZBYPM+fSvoprmkND3mQN++LKhQiTo5/wZz7CTF+aqWvn6UQxJg6Pu0raB1Xikpj7IH4qScFjt7YbrGutMTZVdTmszZztaZyEFJPPBWRDIt7mpv7WahNhS3LCD7NpdLF3kDwM5Pgtm0Y0bJaNvn8iPXVAZT33PR6RHdgxR7SoPPh6pGk0iKiF0upvdTD4SbBpSn0VS2l4y5XkIeQZlz7bGM0/pRbFicwIwKhCqjO3u6IeW9FjbHDuJjwqD0Kl2LupgM1JMUn5xlwlGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ql6D1aEmnRAlMxeYPdVGOifiU1G1KCulykxIyS054s=;
 b=fDGgLGwkuTQkt6f9JeOMCwofH7bPRzBxSoxB6LHXMzEsf/xzDdI2u85UOKCgkQxSBRuelIAxwY16TMwliWe7noR+Bay/0BH59mDElDhKwr/zulP+Lk0EKsxUYirgOEFfNASQX+nygu7RonTY3oYQ1O9K7yz1gh8vITzhn32S29o=
Received: from MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 10:12:11 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::16) by MN2PR16CA0057.outlook.office365.com
 (2603:10b6:208:234::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 10:12:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 10:12:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 05:12:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 03:12:10 -0700
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 28 May 2026 05:12:08 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>,
	<Frank.Li@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <devendra.verma@amd.com>
Subject: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6 DMA Device ID
Date: Thu, 28 May 2026 15:42:02 +0530
Message-ID: <20260528101202.1244624-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 729861ef-19de-4c00-4ba2-08debca19545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	nKILwdNohTebqINBiDCevn3pi3b0zrfeCmTGKGyb/GMKyZIwgQxR5Ic1LAMsl6Y7u2Q1s7n0fw9IE6a0DJNWOwDzL843WjRbkLTloDzHi1qcl8BFcR7XD3zdQlA7FEbsu2r4pbbE85MkZBf85JzCpuxBZ3RPUybCKVNtQykeOuBpA4o2TW0prkOA8X5wfFGMFE93Opb1jlWgIsjXnGWFfRTYN6EpLV3anKHyAL+UNMWGPN3B3VBSzpPg0bORWjm4N7L4Jgmtc3p1wYUhRSRDTCzoWYSInVLYvyCoCsn50ZWsfibMT6SyQzfKQD/CtTbZhOSBm2XiTJwzQGt/ZJ+DJ2CxriW4/Nnzh6xq0rdDahLjIhhaKHm8YeF53BPwtYrSKdXfvivYK7XN7XHa9T+b4Q7lBb3IyJe+HPk13Zs2ibQroTSlfkKDLy9MBScdJNMU94zScfIkcyBVswgi9So73AbH5o7t2QPbRXrDyX1O6w+SYz17jdWOS45DaCaHSQkb40FqTEuI8CWOt+ubFWWlAjPgz+TcfniQpmjZSHTwQ4HN5ohZoZ6D8ulZiJ7G/xWp6SnMLuQE9Gbx4WY3i8JRqR5/RRGoPZJU30vO0sgfZ/aTyYVm4MWKntZhNTpqa2u9sMMno2oAxL+NRXXD2ZosHM3p5jK9McAKroHl3MZwr099X0JIFHWejdVD7v2YEGae7sOE2XP35F0LBY1Y2gk7JkWkPKI+wxY4U1tk508uoRU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9430H1fNihBxEAxxrcYbuf86peI9yyScIjvaFJ4lhNmK1peICIrety82l/0XSjtVYEYYWu70MEqZbNKLfWOpNc5lEcgipeY80/AxSK1tN+Y9gwjHASDJkVUMI/69yHMV7DIgRNrd16aifvFXUdSsZoZi7Y3c2NAA7d1QG03WLXpuENji1YJBOVFkQT1Xqj71SwcZJQd3t3DUBF8eRl7BIJt+xmXNiEVx2oNj79WFwfqQC/te6RnrwrTjfs8eA7dMyGp73kDo9WXNt0TTUhByymRfYfMwJa+zX1qvf0rZ0jsRYn3KRmgcGwQzb2A8d3PNRempQtikIq22ri+6zqlG7r0gXvi0gNLz+FMkDJtsNIEO3cqCqmos7tvyV1N2W7tpjmUOEthzw6MJt4Duc4clWxEMFCEIWD53HBcgus8c35+jj9cpgRv/fjkPJnbLBLdO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 10:12:11.2868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 729861ef-19de-4c00-4ba2-08debca19545
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-10989-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6682C5F0813
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Devendra K Verma <devverma@amd.com>

Add Device ID for Xilinx CPM6 DMA IP.
This IP enables 64 Read and 64 Write Channels.

Adding the relevant dw_edma_pcie_data to use all the
64 Read and 64 Write Channels.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 0b30ce138503..c5e041142869 100644
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
+	.wr_ch_cnt			= 64,
+	.rd_ch_cnt			= 64,
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
+	  (kernel_ulong_t)&xilinx_cpm6_dma_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
2.43.0


