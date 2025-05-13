Return-Path: <dmaengine+bounces-5152-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EBAAB4C6A
	for <lists+dmaengine@lfdr.de>; Tue, 13 May 2025 09:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B8B1B41149
	for <lists+dmaengine@lfdr.de>; Tue, 13 May 2025 07:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4B31E9B32;
	Tue, 13 May 2025 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rMM1aotC"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B41D1E9B06;
	Tue, 13 May 2025 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747119811; cv=fail; b=MNdQDdnMjl46rYg5hjVuhneZVp55+inLrdan+XRjfgE7qUJsLKo776mXQ70of5q35YcqfbsjwZQ9iE9D76iMxiS/lrfZhyOPc18jXtlDbE9ndnnzHqEsN58YaErP6GvejltnwayTbhcq/1g6ipSDKoOXWLG7Mp2OJG5yIa5dRlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747119811; c=relaxed/simple;
	bh=sAPaGNbmcNaZ2FjSmVeLeKEeXH5DChwSRCnidHOGLMY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ujzpjik9Yh1fT9Z90K3BHlayeyRUh6Mc7RQwuxBDluh2KjTzmgBRuIvCKlS/7RUkMlCsem/3ygmk2xwKTpAwKDNhQiwqknX0QUXJzqvrdPzVYQmorlVrb4TTbfOoU/ZNxXEtp0hWedqxgBZkZZ9BggPY6lAeNRrKh4O83djasMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rMM1aotC; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VljALCcS7k1Zwx5gUhm2fFNQk/KitPf+Yk9QexrAFHJDMEghDufgaN8DOUAwnwJ494fim5fDOTMuaH4mMQm2wQJ50AD2YwR5HrCk/2PA9AKRsEL1GOyg+j6vv8Ej3zaH2wO0o9VikelR8lRKc5c7Xdl2jQBS4HEFkszbIlH/6iKaNkxaNQ9hQYYbzEpZZQnU1rLBCAEBcZhmtib7ONXvQjxs0UXiONtWFS0da9d0X5bjj5BvhR8nRSGaWfTlwOyg8vI3GcgiNs4fo7KZaHcZd8LWFvt1BFg0BGNPiQZQ7eWLdnrzcuxGklxsPJbb6BzXtn4gbF22hRBNxqsCxG9GVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYKH/YcYMcy1gobqFYWWEFylyKrDse4rTF+9j0iuxYU=;
 b=B2/4LqC8r6gJbusMOU+s21HYTenh4zQBIUC2A8cxTGcFfR8MbHsTn0puTlIi+79BxWvUzq7YKb8uYF0A6ZtqUEqj5cnBu+MlDUSPZriaeQm31g2v6ggrqAUp+iTUOcg91JH5oYwoMzFGcb9CZql8kIYKoKhjW3K4qtOB4RpCTV098Z2bmehWk4QI166OSVSGhddbWSwRJK7iMxp/hzORCFaw2Uapu+/ZR7NeHjLQRLFS2sgB8Kno7x3V9ltryNkrtMcYlg8B96nFJln8DciisiXsDlDOoDLmAuraW3kJ6IcfOYbZtQPLR7Jr+lbPlbM9Fro7s8tCsYtxYb7WpeERtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYKH/YcYMcy1gobqFYWWEFylyKrDse4rTF+9j0iuxYU=;
 b=rMM1aotCRA5aILlpqTgMICzDfvCxrIQr5jJ+vfPwCJSEibNJ4G/djP74lBWnyNabPU9HpWG5xkip5uGfIxgN4jmhJv1Id36tQDjc/gXYPTyGLp6TiTX3qxMS1Z2tIcOoRTCaPC0h3wtF1Uj01xXuGtf0hl8QfKXpJNK1l52fMjo=
Received: from SJ0PR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:33f::16)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 07:03:25 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::1a) by SJ0PR05CA0041.outlook.office365.com
 (2603:10b6:a03:33f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.16 via Frontend Transport; Tue,
 13 May 2025 07:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 07:03:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 02:03:23 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 13 May 2025 02:03:21 -0500
From: Devendra K Verma <devverma@amd.com>
To: <devverma@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <michal.simek@amd.com>,
	<vkoul@kernel.org>
Subject: [RESEND PATCH v2] dmaengine: dw-edma: Add HDMA NATIVE map check
Date: Tue, 13 May 2025 12:33:14 +0530
Message-ID: <20250513070314.577823-1-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: devverma@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: b7854359-826f-441b-6a05-08dd91ec412d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gCzrw6wTxjd87Q61jdgrkkhvMxCOlZd4Ps1AaEoCZdmDqEbjefG4AC1R+R5n?=
 =?us-ascii?Q?liZfmCQc026XcyNx6pFshdlOz7KMueTR6YL3GJQSPQhrwwZfpLwLfA5fNRWR?=
 =?us-ascii?Q?FjNJB17ZA13SUOmKPikS/+qrzgrxrqx2SOFpY7ptZShaqyu0B9QEeA56Mzdf?=
 =?us-ascii?Q?1yDPv9TCB+0aac/DunKEWE9xncpNuN3iOtYQSIH0Ijw6b26LeBGLu9aFLjZ4?=
 =?us-ascii?Q?VdPGbsob+pUM7ExeNfMSomtP8U05P0gItiZwdIlRiZRdrkK53hPQFEL0NHZd?=
 =?us-ascii?Q?/30e8haAwAIl+Kl0HHtRSNTEvIaAHExiEZpWFQjVfUv1AZMZ50cGUJYZfsgB?=
 =?us-ascii?Q?dCv4h/W6LdtZLGmTKZrbF99+bpHPiiIO6AQh2IxZmpLHteI9J3Dyin4HuWL5?=
 =?us-ascii?Q?+ja9qGtTnL/OIWTs9oBvKmxGoSOXZudUsI2EDwFig/M7Z1rbpJdGoMD69Ivk?=
 =?us-ascii?Q?UazI/+wDS2UbXF7mUJAjkWBP3YuV2yAH+p20HfsPdztQaz/yRAdR8cInMbOs?=
 =?us-ascii?Q?i0OO7TeyVJvKncpUN3o9kT8g0DHGfEpbKT2/rsp2MeRzlZ7Ii37xuarTQHrJ?=
 =?us-ascii?Q?DZoJgjjK0dedFkAmYWn+GusJeZ6AGV5lzM0cFrvEsQt1IY3fIqbImItYHh//?=
 =?us-ascii?Q?/4pZsZLcayAmuh9SIRESbzPHVpRG+8zyaR6gfHBqSN1xIPkJymjGIld+tzzO?=
 =?us-ascii?Q?rbjBxOOhZ2KqRMlNqZd8Rj3CNkue9bNBQ8PPTirCs6vr4VmkBD7Fsu7wWLs+?=
 =?us-ascii?Q?GQ6BljWQjIHJDR/dRTNKBju2p3kIoqx+3UKl9tts2aRSv3uykLZzAOob9xYj?=
 =?us-ascii?Q?o8RuPwSXS7N/+iMR3/v7DYirOFi+4GnJje3r15B0xVwXMpHpgDZ/uzYDPtuf?=
 =?us-ascii?Q?udRtubmALJ4G7BzTZXEkEXHjJID/yg4MAxKsxs5jIzlEEVnqepIkraDuAfen?=
 =?us-ascii?Q?qwA0fnAMsK8C7LkkcMlKL4tCj6tB2tVe+c/XRyD8VKPDucElriRkcKHa0kr7?=
 =?us-ascii?Q?YdjsS+SsBmEnPPTKJBhlHoup8r4ynWl5nOunoEmG7IfYlFjh8R83B+UBNh5u?=
 =?us-ascii?Q?GMIX61h3u7eOnO/VDGrD+VlF5g0BFYl68PbkRoLVlgLdu/ela5xdflZc5Bhz?=
 =?us-ascii?Q?qyvecj1n9v7B0rN9uD1igFmJvrIBPMOYemd6PfQaeG/+JZTQmRZyDUnJtxBn?=
 =?us-ascii?Q?dxX4pN1G9WQKoC6U3ZuX+7IeekUfu6tGhtDYA0if5XKMlT6gN3hdpm49TUyJ?=
 =?us-ascii?Q?hJOn69RNsnJsz7QqmBgN4ks92fGBGcZPsY1tWra8LdEQkyIeJSfG6qqtO+xa?=
 =?us-ascii?Q?gZzHBvwPsxlVrehzEzJJCCdDr8mGRQpRB0n0cALY1Uieur+EuNbwGQokeE4F?=
 =?us-ascii?Q?WKLbNKTRsUby61+Juw6s31gc2zMUOdWvdObRGfpAOl/ZUKMSgt1rGbmh3cZJ?=
 =?us-ascii?Q?m9hMIei2ttrF6Mqfj21Q3s4Dlb4a2t2UXlJbkcwN5kG0Lu0iN3OdEfm+z5Cb?=
 =?us-ascii?Q?qX297P2kPEsg7T5862MF3A+AjSREbpFdaPEY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 07:03:24.7063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7854359-826f-441b-6a05-08dd91ec412d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

The HDMA IP supports the HDMA_NATIVE map format as part of Vendor-Specific
Extended Capability. Added the check for HDMA_NATIVE map format.
The check for map format enables the IP specific function invocation
during the DMA ops.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
Changes in v2
Addressed the review comments and added the 'Debug info' for
HDMA_NATIVE in dw_edma_pcie_probe().
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 1c6043751dc9..49f09998e5c0 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -136,7 +136,8 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
 	if (map != EDMA_MF_EDMA_LEGACY &&
 	    map != EDMA_MF_EDMA_UNROLL &&
-	    map != EDMA_MF_HDMA_COMPAT)
+	    map != EDMA_MF_HDMA_COMPAT &&
+	    map != EDMA_MF_HDMA_NATIVE)
 		return;
 
 	pdata->mf = map;
@@ -291,6 +292,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", chip->mf);
 	else if (chip->mf == EDMA_MF_HDMA_COMPAT)
 		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", chip->mf);
+	else if (chip->mf == EDMA_MF_HDMA_NATIVE)
+		pci_dbg(pdev, "Version:\tHDMA Native (0x%x)\n", chip->mf);
 	else
 		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
 
-- 
2.43.0


