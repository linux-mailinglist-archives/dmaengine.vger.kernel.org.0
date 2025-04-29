Return-Path: <dmaengine+bounces-5037-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164CBAA098E
	for <lists+dmaengine@lfdr.de>; Tue, 29 Apr 2025 13:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681001B6218A
	for <lists+dmaengine@lfdr.de>; Tue, 29 Apr 2025 11:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01B4253F1E;
	Tue, 29 Apr 2025 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jds+CRNy"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A6213227;
	Tue, 29 Apr 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926264; cv=fail; b=k3kAvfn9n1VuOD4hK6CSJHbnbJIgucnx6cFbIOiRyHwQoHw0+GWP+1ev0Wbb1q7axdIbkQFlbYZDgbnM+oWoJmlSRZF0oGy+fSLSLmZyA51NUKHhXzHTH80KzwiFyqX7a8+91er8Rt77FeynO47QmICjdefI9GyvXqC44Chqy1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926264; c=relaxed/simple;
	bh=ZEC52847TfYLHIMPYWEhMlzO9cMh5hnLKtPwKC22IWw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JOK5R3i7nEYP5LYh+x+lXH7d0BjN/ajpapPmM+k62YVkl/XUZUw84kVmFxXNPvSAj3oWq1S0UcVbQv+3IQyFAcBMQ10DIIOprxWcwioCiYXuxV1NiVYhwQhR8JRnqRKhVpLfYAQ15gYy6WAvesQbBXkdez4/rU+wNdm/MgX3WlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jds+CRNy; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZYUmFUe1HQvhaSe6X2ZqoC76mbfmjJ0E3TECodl9sO72AfYRW+n7FLkyVxSCMdVa5giJxxnoS8pWy1HbBWOZUH+T8SLmPUz36nOjXj2T9MgVKK/US8EqV1dtSQmYi1ltqRy8FIMnd86ebY/Y3KzmAzdXvpkCRxHMUSFedc30GApPeYGZYUV2uSsb0LVpa4+aZszHqn1v3Dl3psBCFdNdkuRaJITLuG6LNLxAxJKm4ZkqzLA4C2JDr2ij+0QhbTlWf0f4dpSXjb80K68bMd3a1as6vBeXdGm0USFNXSHjjfBFtW1kdK4o90Ps4n6PXcoDXc621zTWzJ6Mv+f2JzfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D25cd/3keB6CcN9DupqCHcPkIOzucOzVkkI5Eh3O0e0=;
 b=PDI1Q8qz3cMnt3r4IFDRIvH47JR7EHgiTzKuTkX/nyYR77xIL8cKidWk6Rjm0zbcn+7U4hHSW+fDy2fRnKJo6rRwH+QmUKNsBScRqPhPCUjY7VVyGVoZ6qODjxf6eZYmG1se2uimWXou2rMjQJOvK5htV0/pUXpPZmyJ2cYDRLDDTNZDDmrtHQZrxp8D8UuKMKTY0n/dmfSWePUbouG23B3Vzqd/T9+DUh6d/eRVzE/DzSei8ld8c2ln6+GlQBONvbsy1a30r4qfbYzwPvtopYLVV6BlQeFtiiSRAzNDEM3ieOs11zyYxW0Sgr+Dw8BACNw7wufQiN5P+/LR24guAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D25cd/3keB6CcN9DupqCHcPkIOzucOzVkkI5Eh3O0e0=;
 b=Jds+CRNyUD+q5X6b187B3qLqSi/cTEpwm6+SZXpMnSMRxhiTSb+54X2KPF4XDW/NPzT0Ld3cY61F8ONEbOAp/s8kCAlHtu66cmiMcfaJyhGN+EElUTIjsAlo5rAg3JhCZc2hG2bBLpWQ5/ZwxiOnzLANNffpDVSZTtBvpkP/mmU=
Received: from DM6PR08CA0033.namprd08.prod.outlook.com (2603:10b6:5:80::46) by
 DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.19; Tue, 29 Apr 2025 11:30:57 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:5:80:cafe::39) by DM6PR08CA0033.outlook.office365.com
 (2603:10b6:5:80::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Tue,
 29 Apr 2025 11:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.2 via Frontend Transport; Tue, 29 Apr 2025 11:30:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 06:30:56 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 29 Apr 2025 06:30:55 -0500
From: Devendra K Verma <devverma@amd.com>
To: <devverma@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <michal.simek@amd.com>,
	<vkoul@kernel.org>
Subject: [RESEND PATCH] dmaengine: dw-edma: Add HDMA NATIVE map check
Date: Tue, 29 Apr 2025 17:00:48 +0530
Message-ID: <20250429113048.199179-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 7739edd1-c439-4252-ad08-08dd87114f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JgzQykWBO9agPL+xZAVuLtbvUAZfoFGUOUgno6Mr7FaI9128r0Mvk12Imoed?=
 =?us-ascii?Q?U7rycxl2aNTFjk0SBP/HukrKL7WCZdS156oKRblu523jE49MAmAbeXF3kMMf?=
 =?us-ascii?Q?Vu/COfBksr/DhQP+W0IKZnbx0L29rdqEzC3Xl/fH6uqmdFR2B4Rm5Eg6OuTO?=
 =?us-ascii?Q?1eWY2+SoYqa45r6s2+C3cYAp9JgqjOCn8w9dacJRV2ieuMVWEMDzaqh3RNMz?=
 =?us-ascii?Q?ooYfULth2GzrBlqRrkJTOl+SthjnFSD+dEPhk+b2inyb8aNpYnY7G1oDcAd3?=
 =?us-ascii?Q?Cps8qBf4vTy5C1fscz3Y3RvGxOQX+D6iBF8DocbPDzGfq4rOc7VYc07ko2Jy?=
 =?us-ascii?Q?0aFwmR2aMUq86hdep3TXQW3+vS5DyvoQuMfMtavEerr7OqOoSe/ZU499XoQq?=
 =?us-ascii?Q?F4NHSMCto7dVhqcmeWYpTUx3t0/1K7LeUbml01BQyqKC8uSI58Brrw7V2tIF?=
 =?us-ascii?Q?+kzpZ0bsmIJWY92+vkU8fAMYiDIE7qSDu21Ro69Qfe8gOhV/8Dg4z+WrrnKj?=
 =?us-ascii?Q?Pm0WYIeV2+71LxesTj3CwQhoe4Qy61oNa2ZSFTBxy36tnqP9Zn0h5YfMKgZS?=
 =?us-ascii?Q?7U8ITBcyNnN7x7jCf46ohNjtKkb/MT3zJblfxL4SWwwehCrAwS340z6vho5S?=
 =?us-ascii?Q?W8pHNkf3hmyP+jZRW0cpLFTYC4v3oDGhQcEAfR8RonSl89LE9YXNsII9LlXT?=
 =?us-ascii?Q?rfy/P2dqXYzc/p95YxyVZTBBrI/f5z0YhAg9FNr+TPUncSFCn+apdsH/ojsG?=
 =?us-ascii?Q?g38+cM7ucCC/5J8eRn742HSIK9pOpmz7hG9CEJw67nkRlYtx0Is7E6Qm+Wr8?=
 =?us-ascii?Q?dMZBlbD57LUEC6OJRYiA4qwZm1aiVtG5k+pdWOXTKyw4eSln76ENwW9fYIFF?=
 =?us-ascii?Q?RIYX3pDbl1LQrFT8MbB6xYQjOXPvj8l/7XvleCzTzBLNQS7ellXPSiyvorJD?=
 =?us-ascii?Q?pVr49VqozCPaqfZ9n1ENJ678q+m/9IcbwawRwbNp9hxnKDWfai3UH8GoAhHw?=
 =?us-ascii?Q?W3PmHtzx5uQtQOAQ6UWeTocOb/FsnG6RhDE/by43zSRqAdNI3qheLxNha/GT?=
 =?us-ascii?Q?xUzRuzwgHsVNl50hxy7xeaKl/PfgqxqjT4lfRufbOqc/EcUmbAMXTCQ69ZjP?=
 =?us-ascii?Q?9j/jZyEiRsfOl8g0sE1KXtvd5BNjQQrhUeWJakZkmZFe1Ci7wyzw5fp4n6Hl?=
 =?us-ascii?Q?YmFppJRtCwXWi6XbCpRc2KPx7SXRRGKlPb5cAxP35N0hAJVZxFkyEQE/dIKy?=
 =?us-ascii?Q?aHnAxNdk7Jcm4gW2L74Iw+2py5dA6Mk8VSZ+ZMLy980hjLprgw9w8S/Cfz+c?=
 =?us-ascii?Q?0E3PfWhs09RbGL5JI2bW0PJdxynfyNSmfBqKfN5CCLtCpyn2jwcAb1Kk63Nm?=
 =?us-ascii?Q?6mEeChf4dCCi6yxLXdXgAJ3m6qnv2XfUm61Dy1ORLvXnPJdWW4Fuj0X8tXHV?=
 =?us-ascii?Q?YNXPHz3lPGsfWrDUXZ22Le3xKRpO0P7oktOAK0h08nqdtxKxMuM7ktpjnakD?=
 =?us-ascii?Q?Iz+IZwI9u4w3N9gpwA8t1kaCbz6QArYpyVVx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 11:30:57.3197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7739edd1-c439-4252-ad08-08dd87114f76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369

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


