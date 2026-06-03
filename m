Return-Path: <dmaengine+bounces-11145-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SdqQJlZAIGoczQAAu9opvQ
	(envelope-from <dmaengine+bounces-11145-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 16:55:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B36638D54
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 16:55:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=CD0MjgJU;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11145-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11145-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A11F300CCAD
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 14:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1B533ADA3;
	Wed,  3 Jun 2026 14:33:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276EF330652;
	Wed,  3 Jun 2026 14:33:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497225; cv=fail; b=aQ6YCGYKhX7b3e5zq0v1C1bWs3HVQUNooWytKh/ou+/nNYA0OFCY8qTdDvm/v8mfRB5pkyQI3Lz9znOcgt4ihSke9ETyNgUhtldM+zYWKfsQ2egfyRK0zJwyDcvyYFb/HyujuXgJdfB+Mit4+8AEcSztfVnlQnbni17C6K0LH1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497225; c=relaxed/simple;
	bh=lMJ/Pur0SxtyLetz7pwxyAHmdu82hEIiC7IYbf+t0ls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tzXOfbIHfBRV2mN/NtYGyiuRUZlyaod02nhyi9mnLur5R3EoebdJ3pKaaqHZA6ehdj2hOBDX1yJ/CydxPTm5EiqbSg2jVBzqCmaQg6Rl1a5l+R0SlGNdR4QLuD+12wK5UIXQekO22hOKyIkVW4kfCkAbMVDyXWTcQudy+cHL05E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CD0MjgJU; arc=fail smtp.client-ip=52.101.85.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/jbBHFqpl/ELIM8pIm2T2XRx2Yuuum78pdnSlr4YHq9sZeIhGQi8mrFwssMb1ASX/ShiDpCHzCfADGCYdsNrAooh/KOUCx6Qy2XUH7S1v4jj1EyACoinuI7xWu4RJa43lDnaY4dxGEL4i9BiF3HYqeIYqN0kSjHlTxdQviW0vfXveWklhUBLng9DLe0bQW4ECruTx17quNTTbaaXauoaVs6d/OqhjK6GWWpBJUa5VU1SEVcoMTPlClP47nNQYr6MDLfFsu+FZQS7coy4gqDPAU8MWoerLRHTPP4/Ucci3JQRf950XmfUmOIcN9wgBlq4tltdWaYqCWJO0z70eFpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gnpkq737gUH9ZLQGa4MH3iKp2E0ZxxbD9X0tlICjD0I=;
 b=R0DnJLh9Ppj1y3mt6YiCXbuTJ2FZuELX4I0S6XigRQMYz3mmzK8ycFFeC3DCzbD5nuFddW869/uy0spd51ZBQHlWNjhEProYrpjEa/otiQNPwsLE2DxqBQIbODs5xi7lnu4lVWjYdDyS53eIYGuA1ovgrpK5f0y+qRDnGqWXtXtrlA2RV+di9JBMrtwck3Drie0pvCXhpkbz9R5Deh5AHYmt3eL7QWi7xxOQqP9I3nkU27NxGQMS9Nu1/DOWR/9kyR5oWWd/mWlKtB+sU4CJy/OYD/15yaeHIG93z5XPMmXyw4L6bC62n441GV9cMOymSewjwURSu//TAS2B9nXNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gnpkq737gUH9ZLQGa4MH3iKp2E0ZxxbD9X0tlICjD0I=;
 b=CD0MjgJUBzM7/eJqMpYxS9hzwep2PUutgcCB96AFwQkGvEwdYmCmQFhIT+pzLBV+YDUFFSLBXS4L3vNmFcRGhv3sgdo6Qz/Kqc5/Xt8fOug2A0lSDnkIyDSo/CTukAIrJUnLo8mORJ7MzvYwFKSctFbUDg+yWQtTJ77hAD+4Akc=
Received: from BL1P221CA0041.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::19)
 by CY1PR12MB9649.namprd12.prod.outlook.com (2603:10b6:930:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 3 Jun 2026
 14:33:35 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::1a) by BL1P221CA0041.outlook.office365.com
 (2603:10b6:208:5b5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 14:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 14:33:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 09:33:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 09:32:01 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Wed, 3 Jun 2026 09:31:59 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
Date: Wed, 3 Jun 2026 20:01:58 +0530
Message-ID: <20260603143158.3243500-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CY1PR12MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 161f14d7-fd4f-42ae-0dcc-08dec17d180f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	0jECFSHcpkZfQkGMwigZN+VcUSvmmTAiUZUEScI9EvvNmbSM5KcQ7Ly5qYcoz27zmir5C09aVauDDckkKq7ptM4WdtcFW7t+tCxg/cI6NLt1wXiPhhyF6J64PFg4UGyXab4QDJn2hcdPQL/qJU2RIDFQcuJE+Wb1KKtD0DsieYV+gfm6XBhDxRL4ZxYG7cGJk3zOKqdI6sfszrldykqBeTFm6Mpk3hbo5GlS3rLlg4r4Faq/iteO9YM5iypjEahPR6sOicsNdEnlffBj7YF0mwT88htCE2Vc6RXwBdVEjZsJWbhWjzWpK8/+XS7k66svwxSqbhjgJwkgq+h33ekC/nXJ2/2y4Dp9r2fxJjbQ+3icKpmil5PNTYvILL0fTotN/nhlQDKrrYyozRa4bn7pm/KuJhVH2fMOnacPH7jhX97hvKPgN7uOB8PSwk8Tl3Gx2GKKzynVkKSlgi0D/csBkFpunlrA1PtUUp9s+Up50nj+R0Y2bDMB5OxO3rKHszG93XE/jD3OEJQFh7loQZ5vSm6L8Lfr3H2vQ/Ut2K5Pzj9FYLmEzd4iDPpU+OoUtiaPdGrvKgc3OjcDXuIjSwUPNHPDLRA8j4qaFEtP/86VOHplWd8/9sT8qNVEhr7U73edGEj+B9fvZO21D6DswNBWEgz3yPxg/IY2h6J/mrxHV26AbO7fIwoUgTcsLTysm9mqnclXGEty6gErkFpvS/Krs6EkrH0PcoHjTiFjtv5wTZ0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F6qrN1xBMZZx/GTPALjhEmCfH3nHOTVtvo5DbYa2ACpelKrymIKuQB6U6oNDccAFuRpi0UBqNRsMX8OCqXQYrOY/MafSFbr1gudGdCRfrBq6zVpYN96eAJtUHX4B0qDbhUhIfcoV5VxvruRcN6MWzxc+/cs9klFZ2eOBcZ+8iN4JOj7DsYgi4ZdstV2SkAQJ7F10N7e1QkmG989x5EOlHbNdE3HlZOPMPWeDIXJ80WZger5QnVFDYYgQlbi7T7bB3jKQJRpjREa3d8HhA68dcp/fqypZO1W36fIoFi0Wt7LpKtPS9H+oss5gP0mYASaQ80fpf96736lTQ82VP8zahG4uyIQSP4BJnbXhuKLClu6GdHWFmWClZMQbG/jKwC3avELXh1O5zl2wPapqIsxs0ihTnEKhtcYiZnHNKevoAlaQS0m0McisI0p/vdZofDta
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:33:35.1462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 161f14d7-fd4f-42ae-0dcc-08dec17d180f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9649
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11145-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37B36638D54

From: Devendra K Verma <devverma@amd.com>

Add Device ID for AMD (Xilinx) CPM6 DMA IP.
This IP enables 64 Read and 64 Write Channels.

Adding the relevant dw_edma_pcie_data to use
8 Read and 8 Write Channels for initial commit.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 0b30ce138503..4ba368d18cb1 100644
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
+	  (kernel_ulong_t)&xilinx_cpm6_dma_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
2.43.0


