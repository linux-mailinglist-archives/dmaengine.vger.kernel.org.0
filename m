Return-Path: <dmaengine+bounces-2019-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBC18C1F9F
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 10:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B8B1F21C7D
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 08:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FBE149C51;
	Fri, 10 May 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L4ded4jT"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFB714901F
	for <dmaengine@vger.kernel.org>; Fri, 10 May 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329307; cv=fail; b=EKAdYFzEdS0BG+T3hfow1WsolB3wAgsVC47HYbdAQLD/PO2prqb6F44yOvSYL2qFR9jNvYcFW3PoSwaQhoMscQXllIp/VUBIBsHDGcEQsGjqHnGnNgtnAC+nOtv0ODV/hbGYS9YYY+ksyf5vql1qAg4J77dbzOgFlAJiyGJVaws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329307; c=relaxed/simple;
	bh=4RuWRIXzNbc6nlzJ557APC6NGuoXP6yiV4oPa69vExg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnnu0aA7YSeFsj1VXHggX0cAPyWoTA6i5+ZKVrjfizZOp3LRX6x15ZJWa1rZrtMxsBx1Gsz+NsfWOVLDVTlBE2tfyfW/FmERQ+Agcah2FgyKxchIUu2j49jSZBXN9erKOdU+MOubzFPi4pd+xJfyxbKkATO1JIgOQLlac2pYmDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L4ded4jT; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGWg9mlhdbemKb3TiJUbUTSeidVkrho/1x4tBA/Fu5N/dqYgwqxYiXzcAm/jAs999QbY3NX9Ocacc8tNVneNXfS+8byagyOsSW8rIvG1GXRGuhcB9Njpjcl+dkmRmn7NQTdroY9MF73tyu/xosw0smp5rLXCZPphRUqFPCsbAVkOrc19YWCu+LfDcuu/mL9Yg/CrIYuDcEVnUcv2ULfklpuyw88xAUSK/8biBnanE7WT5k4teDmTfFDZBuGakNGhZPJPqQ9vzUXXoaMJgDU3v7vBPRaxO8gM9Oc/AjeQDxwkje+D3FDYbuoVWFrO2ga3fiiiWcFoUf5nzxgrpSRNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkgh/hHGXIl3qrpx/GwBnmw5Fpr4nvymV93feM6A6cQ=;
 b=fY6Z1FYaEYG8aGQKALNePqFOePJ/8YOIeYr0r772QBvWHiBI1uaPsRAPCA+iVzfzeLBhkvm5yLwpEV1RKjYadS6CL2FGwqCVJD2cZWfKr/YsZ0B4nemNTjLtR48TBfe8stTGy0IlfES1lVHgZM4zy562INWXsu1alEYNSmDXv+WZ7Hs+PAIiCJO0Nyp5D2hRSYIhBi4//7j/SzFjEgAG78n2cROI6JOsNZL3CnrpQYA56SAkRJoeeBbRNf2JgG7va8eAbGp+IotV7g+h6K0DZta9YpibSgYJiXEk+kX7wVug4UONFQm3Vrg29XfBSBz64PrCCP3vXxmlau6vRhZw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkgh/hHGXIl3qrpx/GwBnmw5Fpr4nvymV93feM6A6cQ=;
 b=L4ded4jTVzFOFoIhC49fTIGnvjYt1F3pBr3Zkb3R5qDW1OD5eJr5SEouBcHU35qGc18rMz3aLAbF97dZSbKyvvc9BBxhjqKXd5CwwyHNzqnZNce4CN0FHGRdqDz1aDl0Zjia14nS5Hpih4qw7D7xbD63ACZYu+/1YEYMeuNqAYk=
Received: from DM6PR11CA0012.namprd11.prod.outlook.com (2603:10b6:5:190::25)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 08:21:42 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::58) by DM6PR11CA0012.outlook.office365.com
 (2603:10b6:5:190::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 08:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 08:21:42 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 03:21:39 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 7/7] dmaengine: ae4dma: Register debugfs using ptdma_debugfs_setup
Date: Fri, 10 May 2024 13:50:53 +0530
Message-ID: <20240510082053.875923-8-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510082053.875923-1-Basavaraj.Natikar@amd.com>
References: <20240510082053.875923-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: d569de72-903e-482e-6d06-08dc70ca393b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C1Z3kbV5jDsvxusZA/yIpfS3y2jKkRQQxxV77yj36jFnE1OghHECv6UljBIE?=
 =?us-ascii?Q?pEzgiFL6X/ovkHyfxohwtJZFBdZ3UjwnQSP3gZwx9hdzCIYHAK0L6tsnJgrw?=
 =?us-ascii?Q?V6eDm1HhU38eFmoqmmzLLSl6EuY9pWevMoPYkBr/tGnICLBt5qfIIHybtl8o?=
 =?us-ascii?Q?qvOwuKCbfGHPy405oludiJEDZgBGXfubIFfoqlNHMJtnmCmSLvUvFElSCDZ4?=
 =?us-ascii?Q?sJuzDKYC/JXW5dCbsYnyn7RE5ehdEgc7+2e7CFgTGK7YhAo05soIiFDNeBOQ?=
 =?us-ascii?Q?hoJh/Bn3kiZsnvpzroIybFW5Mk32uqGP8jUoYyGRv00zGtYimFM7/Z+YCMQs?=
 =?us-ascii?Q?KUMnhyl6e3iH8+9Mr2Z4gsykILWcJPj5iCgOOtVzLeKP4zN3Z16qjqPktzFD?=
 =?us-ascii?Q?tSJjfd67feLGOpxIAQjgPdu7JOGOt63Xi4tcmOMskLQCNs1YGwNARyZtl8BE?=
 =?us-ascii?Q?DhKtL3wjgjuo4M8F8xU8x7fCOPjYPtFOo/J0niutWlz1Il2ikcuLaLa3OA67?=
 =?us-ascii?Q?uznkCSWbdWpLjNKj9hikintRxXD6W+WCp7C6lKKQXjwb9qb48k/8F7fpVscy?=
 =?us-ascii?Q?YD3XoPx9l+YPloGZTByt8RFhzZ18ZOQOLYWA0pwuIziG/faNDmafKg2+iLmD?=
 =?us-ascii?Q?5qoiEn460tgventAGmz/VOpuGcWzUPUXaQ1+2F1MNW7AmfmAKCOV0/OC2w8/?=
 =?us-ascii?Q?l9noggn2zXNjUo5TRHlQR2shH1OicSnl5ktZRzRsRB7NECHViiw+yklXyLQm?=
 =?us-ascii?Q?n+0KTHPXUMdBAjG+bX930nNaOqez9bVQnLWZEHBW1LYi3eLOzM8WVMjYRUS8?=
 =?us-ascii?Q?UZQ4xk8ZLHakdIYITDsJLZ5CW4Mfp5xm/+t12vlawsRgr+3AXBtSNPEGUKfL?=
 =?us-ascii?Q?rCIyYTMWYBafaBU3mWUQu94XEnnSbbroaoR+kqNmlyZ5ez+yEIy8629JwKQa?=
 =?us-ascii?Q?wV/WzSCREfLI2R9rSk52DnV8B2KEBTeVa4q8Ec4DgwC0qW0FfuFb5pOwqheT?=
 =?us-ascii?Q?H8zeNsJNutTRBMPAsEikCMJWCEVFZjkbpvbZS+S01aGKcafAlWvXehiSqVFX?=
 =?us-ascii?Q?0U/0+mH0bpCYixrZkWww6oLOMTG+sFxNwPGbQk7hx0BiVegS+UkSR/G6o3us?=
 =?us-ascii?Q?i+nrHukkeK6abCsH4SjzDjSCnMZq1EZMuuz+Roek/P4cxt21z5kAdWOGPwwm?=
 =?us-ascii?Q?SwSyVD+cODxWhCul3bl1MF8vlaF5ChsVJFGlIXCzZBmyimoX1zzZICd0Ovfh?=
 =?us-ascii?Q?4Dm/LbYVGhobe0tCUSSjwfTi1oy+0yOx7pPnFSDPuO2AtU5NE9mto/wBeorF?=
 =?us-ascii?Q?a6znhtecO1ZbMdkA8VfiiNvsRTxXLUJ9zG8pzVO5kJWLktcmMPYTLDfvP28Q?=
 =?us-ascii?Q?MNfl3JnQQBuyuCPS+lmfz57KwrMY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:21:42.4887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d569de72-903e-482e-6d06-08dc70ca393b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877

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
index 7c4bd14c4f12..3a5bda9e2c92 100644
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


