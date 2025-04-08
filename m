Return-Path: <dmaengine+bounces-4856-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96363A7F4F1
	for <lists+dmaengine@lfdr.de>; Tue,  8 Apr 2025 08:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6145D16BDDA
	for <lists+dmaengine@lfdr.de>; Tue,  8 Apr 2025 06:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853E725F976;
	Tue,  8 Apr 2025 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XoOIKjkr"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59C225F7B8;
	Tue,  8 Apr 2025 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744093573; cv=fail; b=ieFa/8ne3e97FuhMwAQCW/wZj6MQ/RJNkdgQcwdirgjZ1v3ihRaTUcOAFlgtPWDOl/R+FqpAM03E/ukFI8iV2wCdWxBrY/BPyByd5CxpfteTefqOC1LhHhdB+s4CyoAMzdCNeBujOHH3joGL/F0I/gUav7C3T1AOff5O3PvhFBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744093573; c=relaxed/simple;
	bh=ZEC52847TfYLHIMPYWEhMlzO9cMh5hnLKtPwKC22IWw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pcr/pnc5NVlk8JhKe6QQg++gWwjqpXFrGa/LgJV5jS89ZOR2sLjNOvBtymE1MweC+LmSroJznQj5e4eX6iLs2hhWqe6MQo4yBmaprH0stdOeeG+UFZwsfOYA8nF9tkWOpXNhAvErBC3xDzKlSxyB6gWcyTY42hPJnjSGhS0v7fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XoOIKjkr; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFM0TaPs3cJ0TkKd+jtxoXqWb59HbC/Y3jpNaEEj52I6jvNbEl2lpDFoOdQcQxfkO1UEaDDiyPFI+ue4wdJWfSMmkpBf8ZBBDbsx4ai/ySnIcvmCSe+JLsa80yA1A2xCWgkVBABqKJS6BS+N6uA2azRPHckhM0MPKjKh4R57N1igoU3Mg1LGHmNyZutm1TqmaaQBvChSyJjWo+ycQMfbWJx8Of9B9iZqoiFt8PU2Lq+dEyId9MejSimk4b9rBgrwmWq+DQa22JQqD1vYAE+TuRx7C85wDzuYLmM3AV/JDlVu+xQzm2T2LxcyNvxrj8r0Xd3wAhCp/3JLYwmIU63Ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D25cd/3keB6CcN9DupqCHcPkIOzucOzVkkI5Eh3O0e0=;
 b=mRfzeuc0cQT45+0TQ3DO8z2h+DmX2jPdp9bOqij1GJBcI+Ao+KmyiaMlj7WQPtfqKMfkk5wCECqFHTocZLZlRCLwPeIcCiLFm8ld9xIWn0d/ohrpWE5SUQBkVBDvwJ2OfaG6NeZJL8RWo2TbtpsCyWHhF0D6iEOi+AmXCd+CLVIcIn2NSyq5gARZT0wJHC1Fpdh/PtQTzAeZ0TVSeIXQamjxZA6D1hHNnNxVmzUXWLLoWggF3RY00pyEtI13INLVOaG7WXd1MWDEsS54ypmNUiM7R3xD9z3PYNiNq/eB2r9fMW3XwPESIXpNNcq2cu05SDWmH2rTKpxWM0KTmVuTLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D25cd/3keB6CcN9DupqCHcPkIOzucOzVkkI5Eh3O0e0=;
 b=XoOIKjkrlxGKySPBnhDEfb0yRvhkuxzZZoj8nfRuxmpoNeMnPk4NngVVnmIBpMRbnPSw++HbVUAFFGrTNfxH+l2MKzCsX6XmeTOa7IiQDDyHHm9thZqikN1pTwmWswWiwbBjP8m/Q3tKPrnS+/lg5hr0wdzsMa8YO87yo6rBv3w=
Received: from BY3PR05CA0060.namprd05.prod.outlook.com (2603:10b6:a03:39b::35)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 06:26:08 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::7b) by BY3PR05CA0060.outlook.office365.com
 (2603:10b6:a03:39b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.11 via Frontend Transport; Tue,
 8 Apr 2025 06:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Tue, 8 Apr 2025 06:26:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 01:26:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 01:26:06 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Apr 2025 01:26:05 -0500
From: Devendra K Verma <devverma@amd.com>
To: <manivannan.sadhasivam@linaro.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <michal.simek@amd.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: dw-edma: Add HDMA NATIVE map check
Date: Tue, 8 Apr 2025 11:56:04 +0530
Message-ID: <20250408062604.2809548-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 914faa75-c1d6-4b58-283a-08dd76663f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wt3ch/FVrr2AxcBNticR2JCkwjLBSaGho79Nc94R0VUFrfxf6t5df20Od+hJ?=
 =?us-ascii?Q?0wxuuo3Q9QW9mQtZjZoF9sp2TFUQMtfS4U9y79JAYiOCUGTO5SU1w4LvUkoV?=
 =?us-ascii?Q?0Xfnd3Z0JUCGzzNDBwnYYXSkBv6HdnAcbGSzfLy0zo4Sg2CMb4nZvvn6yre2?=
 =?us-ascii?Q?ymu3TqQl3qchu4sE6B8OF4fyPaavWB/INeHhp8tDxxj+fnA0BkORIcDX7xwC?=
 =?us-ascii?Q?qtxZWXXFLR8BOiG76z9Wi5pTL/FYS40EmjSuc9uDM1VldeBsYGVUDm4lQTvz?=
 =?us-ascii?Q?rAgOQHfPgQKM/DHEayX/2DL011B//6E/Brs87cl+kfS686SwRLmK5M/wpUQd?=
 =?us-ascii?Q?tUrdwaeqwbzNtFXbrSLKxBFsBcv8MqDu5GEW1Ihrrm1p2FZ5pwzy8fUCPU8k?=
 =?us-ascii?Q?vupTSN3OTWZMNDvRJ+6RjnUHUSKiT5gsqCialEsWrurFNHHJlMcS4oCzAf8j?=
 =?us-ascii?Q?xl4tWq96knaoVKAQKwXVe7CmGY9IRxUhjxIwDoZNh9K22EwWFI3FNnqTbY0D?=
 =?us-ascii?Q?PfUmtRWLz38vEGGH2KhN3occYyri4ZX8kVCpwXojqhD8macbj5ajomRjFnZj?=
 =?us-ascii?Q?eT8/M+YhNhxmjoDNhWBZFI6o8OYg+eMv2BsE0UuXcfTR1sI/VN7/CU4lN7ge?=
 =?us-ascii?Q?9fsbllU7j5j3IRKg3H8nU0WX4MjcUrLrjwnBgSLxrtnYpr5tSJQPZJ0VZjzO?=
 =?us-ascii?Q?fmYT2eF8nAIG0Hlfjkj3avSeuiX4ahagVF7ydVHbfNC/ZYe9JEv2cNsh9i8H?=
 =?us-ascii?Q?Vax5CTcCBC+dhztS77AP2EBXdgZDD8Of/b9w1v5dJ4FzVCMz189Cg6AZSo9Q?=
 =?us-ascii?Q?TyVYFKoPv8zVPF9JeebMeXJ0g4htWKW3V12rfHUs/+rm/HOyEykPOjv3QIRO?=
 =?us-ascii?Q?vhsd94JGyY5GVV7SbtJCQRv4aAAft9Drienek5JvJZ2Hoe1B1LfubmBU3FKi?=
 =?us-ascii?Q?1kiBrqtWW/yvVZZ0sQqJhXVjIDyOoTfruGBnxAUoQ+siqRrJ2B7IT8Q8TxYC?=
 =?us-ascii?Q?4IfCMuvyfmqxnKcxosUGoIPo94YYIO6hPwMuIXdgQ777e1vTzvYCAA3JwUMo?=
 =?us-ascii?Q?VzJSl2SbZGp+bR8pb7CBWutxdAyx6u8b7bDbOWjYcyrfMRXpZIs/bOzmkW6p?=
 =?us-ascii?Q?2u3xviwkBKqJUdQGR/RCJW8QMj5K7mLRDYjgj/FPT6NHCT1+eQhlalVTXbrC?=
 =?us-ascii?Q?OL11g2otYmEpEyx7oy3A3WCXU4NPWW4rhhPlKPipW+XewnSEmQZrdJObqaP8?=
 =?us-ascii?Q?QTYGpSFDA7AKfFc6kSRVHSayFYcfPyAGQ50fS2Ei/DGVFx3doXHNoCFVgDXE?=
 =?us-ascii?Q?QmQYHo5/8J+YSaTd77+hoaDUQSWjaC3IwEeWXzKs4VBsDXG2pqjoBex4g7IE?=
 =?us-ascii?Q?lR0/s32Gya4Qe4te7fwsgIVaifq5J60WIBmZ88YHJhmy4grvmEVgZMm/x9oP?=
 =?us-ascii?Q?wgMB7G7EjaVQYdPBeZ2SYq8MNEHBismoChu6znoa/xIcDk1PtSF5y2x+3Dot?=
 =?us-ascii?Q?xUkbgf/xVeCOLyS3yg5OMCzyTOvnlB1tFt8d?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:26:07.8718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 914faa75-c1d6-4b58-283a-08dd76663f79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102

The HDMA IP supports the HDMA_NATIVE map format as part of Vendor-Specific
Extended Capability. Added the check for HDMA_NATIVE map format.
The check for map format enables the IP specific function invocation
during the DMA ops.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 1c6043751dc9..42b2a554f7a5 100644
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
-- 
2.43.0


