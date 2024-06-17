Return-Path: <dmaengine+bounces-2389-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B866390AABB
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 12:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE681C214A3
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 10:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1082E193077;
	Mon, 17 Jun 2024 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r8niQR/A"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931A8190687
	for <dmaengine@vger.kernel.org>; Mon, 17 Jun 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618693; cv=fail; b=tT1dHy2oKu++w51FSCjK/TpZwz4o7r3MBjAkgCNDk+5Vg9MFLcXchRxiFj1MCCkV3HcV5FpP69LAMDEKx5cCTFMSY+wR99NgAjOVbBoC3U4G9ahgnocG5Vd0cJWJIbkP2yQTiGKdfItqHBNY4Esihj8V5hanwtE/dcMJtHhVKVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618693; c=relaxed/simple;
	bh=3toA92OZ6DVWH+glzIqT9ndarbU/okeC6x4v2mFcvyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhKN9bDe+6SERR41RXZG8GSpPAW6sFpF+QLUO5qIoRwrzwcLxYdRWbNzodfite77XIgzM2h7SKySO27NatyxljwUo2VZZGmG7H8dDBXCDvXPELfZNtqlDJISc7EXR8DLW7E8YC+dfrDmtLK65XuKhg5nrmevUBtLhSuLeiLtJqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r8niQR/A; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n84ZLzVyYtAeqNr43ELoi/w3Rumyqp1RsZ5xskHzv3Osr6PbLc96gZ9reqzGO8iCyyy0IQKGVXkVr4ndyBiOHsxYQwKTI9JBCBBXuOQ3bLTHIoVjUt8WejsAZKhW06Rnyl5a3nTsCpLm2ydYDUSpDVTG1D6jzzkhIVJUeZPlvdXtRKb3fZ0fQSmsbOoDASmd9dh4ByOJKUIZ3uyMVqBWLK9Z5MAAQMFBkIvAoEoJMw0YTGyp8Qe2UEbNSTItYqE1YluFSg5A4U/LCcDNK9OjvSxHXsL6f16GTx6IkEwfFRPZDt9fl6cyIvAPMsnxPkrTcx/qpufphhUwinDExhqQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpAkxtDte0CSjWjVZ6dsaikB/BIAr7JrgOapNmUR3Mc=;
 b=mGKaH7wSRDgXzapPF1JKt1rBQgmEqhAK8YK4PJaPtRYY9eZam5z/X4Wi2R30tNOAPmMhvq9EvRW3zE4IIHwDvl81duNVU8qPiE0dWRR9Zoj1u2fXvb2eyfu5EoR8Fs3KJiiiToxB9VrriH8W3ntcMSho45dJGx9fGlY7UDxvj/67HT9q/B4HhTIUJl/Jp9B5xChDuuVXVRG0+gzt4g2PZGKGd0iVYWmiDVrVRj+ZQixqhBArdYWPumnleqoOwhiTCbo6E+SYFon1Pt0CQkNnaDmp1aVIzoWHVLugq/KRMS9tfMRty/mB7JkWjjtCeDi0xpFWVJoFHg7Q8xxMHfBn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpAkxtDte0CSjWjVZ6dsaikB/BIAr7JrgOapNmUR3Mc=;
 b=r8niQR/ANFkvyScdpc4LZUHgHyt6vsZXEgcXDB+7NzOWs5dhZPptC87kWTW6Upx2egD6Nj34T7x6oDykKdc3ZUWZmn3aAXbqUTXKuxp5WJi5cI8yCcoKiiog1DZltslqqCzRtQf3cbRYNoTdZ5SQ4CToPZgX8g7eJaWX/xjNMJc=
Received: from BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::30)
 by PH7PR12MB9201.namprd12.prod.outlook.com (2603:10b6:510:2e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 10:04:49 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c4:cafe::b5) by BL1P223CA0025.outlook.office365.com
 (2603:10b6:208:2c4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 10:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Mon, 17 Jun 2024 10:04:49 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 05:04:46 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 7/7] dmaengine: ae4dma: Register debugfs using ptdma_debugfs_setup
Date: Mon, 17 Jun 2024 15:33:59 +0530
Message-ID: <20240617100359.2550541-8-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617100359.2550541-1-Basavaraj.Natikar@amd.com>
References: <20240617100359.2550541-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: 793bec5a-33b7-4a90-e227-08dc8eb4ec61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vfe9n3wrOOLXNylwQwgVugAwBUeRksqyDaPSRM94lAxr+a7Ow54D8D1E7hf2?=
 =?us-ascii?Q?4HOSfYl2PtrqLEnGZfHD9y3HQGkyMOA8I1qkIbskQXysuzwwHfXvzsVAnSG7?=
 =?us-ascii?Q?iDWMZtPjocPdgc/lPTcqEoO0X60dGaZTH4UksJc/6aKuur/XtZmD4SWiCtKd?=
 =?us-ascii?Q?9IHQBfxKFLmS8H9Yyc2eiWHEVMeSP6XvULlJU7UHzzmDw9NQXQhZS16b/fTD?=
 =?us-ascii?Q?35k2S/4fGcCGaC6LT2ju1ewTJyP6ACYyp+BnvWb4GRmr+HBMK8InWmo+niiP?=
 =?us-ascii?Q?xFo83hg9Zb6EI14C5COcwLuLhtH2v/xH1HtTzf5SQr1Mqfhiykn8eqxpEEkA?=
 =?us-ascii?Q?cCX8GoHogi2wnBSZOeqT1+nYrndNv6KCIf4vsypAC/efzIIt5DeeIwhURvSp?=
 =?us-ascii?Q?FA4eqdibPCh6W3FQwhUORPpqrS8aHZ8ii6b6HipU1JEpNmzAFY9nmGb3uXTu?=
 =?us-ascii?Q?QY/7SgigM4u3UrEDohpipEHXvGAA35YRzNJ2bSvD8cNZbRmD4x/sMlR5UXit?=
 =?us-ascii?Q?G8lqrVXpW048UMw452NPNp/0Q7zQviTJkVFiqg3/Wqyzm3PBNjME4nFhVcUs?=
 =?us-ascii?Q?fFFot1OIwZNFlb6+YLaj7W2X5KPeDSY49I++xCdcwfNpyQZdNoe5//R2iKkU?=
 =?us-ascii?Q?EUrlYl60l2lrkTztGcI/6hkFLNjNZ3edrHEEtjy4/5JupnLFU9cxOyw5UY1G?=
 =?us-ascii?Q?VcWY7fAa0UyP2Dub6lB8dweb6AkfVbPSVgLJnwif8KOKmTUHc4JdtnI6i9HS?=
 =?us-ascii?Q?SB6iu2gApAtSWMZt8HRkyXVEuxc7cfcFymku5lNu7f+9QcU1yNujxv9KaCXd?=
 =?us-ascii?Q?a6HtpLVa7YjmGdDyQAiL9/sYN8/sNdHY9ghjMVGmR0keAZHAMSlcK3qcuIAp?=
 =?us-ascii?Q?b+QraA8Q5wdFp5G3Z+cJ5STN6vHwTeSil5BF6liIKx2u1M4rs1uPRuuecfqx?=
 =?us-ascii?Q?p42RTyncAuVQ1Lf8mHrCmWztlrhqiR96Y/6EC/SGvWIJbL5YBN7rTzfd7LBH?=
 =?us-ascii?Q?5HjxrLVQoIOyrJWDEj/T9XSuwcePsMcREQyPHbE4vdGBX8Dkihdd285T3YrK?=
 =?us-ascii?Q?e6zamjJ3N4NiR1RLxtO5kc/wy6STXy7AoRTbb05C09k9Ja6Hke8iYSPVDDSe?=
 =?us-ascii?Q?SH/fTU61FkequZEKBU5o1UWW5u6WSkypR8ephibsru/HjUVZhNaOJu27GSO7?=
 =?us-ascii?Q?GwWFdXbea+qyWX67LOugbtSzG/LVxAT7BHM5JxhsXFpdm4EXFvYRgVfeGvz0?=
 =?us-ascii?Q?TSR6zosz4B8lZvhy7F75hZspBTD6BAw2LgflqC9taagxcJYtdK7scXTxH3IR?=
 =?us-ascii?Q?ChqtJVeCRo55DRoN3GjdTPiFjloxvttB5DMcTN6SJzjCaOrgM06Kf5NnuwGm?=
 =?us-ascii?Q?XH7b6D7xepytG4xPtgTohyRO3YTuivbr1IKthulsoYxuiVI+7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(376011)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 10:04:49.0238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 793bec5a-33b7-4a90-e227-08dc8eb4ec61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201

Use the ptdma_debugfs_setup function to register debugfs for AE4DMA DMA
engine.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/Makefile     | 2 +-
 drivers/dma/amd/ae4dma/ae4dma-dev.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/amd/ae4dma/Makefile b/drivers/dma/amd/ae4dma/Makefile
index 165d1c74b732..5246d4738413 100644
--- a/drivers/dma/amd/ae4dma/Makefile
+++ b/drivers/dma/amd/ae4dma/Makefile
@@ -5,6 +5,6 @@
 
 obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
 
-ae4dma-objs := ae4dma-dev.o  ../ptdma/ptdma-dmaengine.o ../common/amd_dma.o
+ae4dma-objs := ae4dma-dev.o  ../ptdma/ptdma-dmaengine.o ../common/amd_dma.o ../ptdma/ptdma-debugfs.o
 
 ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
index 77c37649d8d1..d6082f14acfc 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
@@ -274,6 +274,8 @@ int ae4_core_init(struct ae4_device *ae4)
 	ret = pt_dmaengine_register(pt);
 	if (ret)
 		ae4_destroy_work(ae4);
+	else
+		ptdma_debugfs_setup(pt);
 
 	return ret;
 }
-- 
2.25.1


