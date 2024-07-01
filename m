Return-Path: <dmaengine+bounces-2613-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F001B91E59F
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 18:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73322858C8
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8385D16DC31;
	Mon,  1 Jul 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X9972ZpF"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCA16D9DF
	for <dmaengine@vger.kernel.org>; Mon,  1 Jul 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852198; cv=fail; b=iVPveWXbMkK2WX4ghwQpcr7Go7/6L8VzUr26k1wK4O8ODo0/IMT/j8gtwNfcT47g4P5Z19O0m6QzFBzmKqF00nwh+e8xDWsLS7f4rJ5Iv8JnSHrljpWvhZeIXBRRIaU/VWhA2gF7EDHyTo3qOdxh8yRsG0Dsd0y4JOlNbk71NWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852198; c=relaxed/simple;
	bh=EgwuVUp24q0fhUp6EreOhzBfYt0Z7vKTMr/1gkvY2Ro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9fIHDdDyNZCHwfEqoZUcpXtykG9WAt01t5gUkaGdR+1AbBP1Y3Ggo+c5OKRO9suGjXfg1YhiWxwZMjaZHivDbJDCgUVN9J4Ad+44S6GKda0ZB7tcG3uXiB8pIEz5t3NAwcq7gEB3D5tTzApPyB/O28LJFnMiCWRI1JpHRhOohM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X9972ZpF; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7qG0nglsWquBSOdFIanCinzVpc27jqp8WAsB8bMp+vjrV/HEq9ZCyJVAHrh8es0biJEZsT96rHZf3LtseKgncEGR6uTbQCW6GCt/QMbGUzCVCKCaDDVVcsXcOsDELHMbq0XE/0N450dl37JgIFBtcy8xnenZLMsUsX4CXyErrT7xcSa/sPm2oc9L1GoD5h5arwrv1UzL2XkYYSqZxPMp91dgs7kLv0smfFBZmWKSU13U3hdpp2XQqHvX4cv5Ak6+6z5UqT77Pt3GaMv6YFi6U5WBa4+rAx7QgablXUbgZbGEj4+bBQwavUF7G+kmA51cPa3s28GjHTqaMeiDrCTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXurI5GeEpreoCLuS/wxIvkufR9Qh0W7OApTu6/79lY=;
 b=XEfS4vld25oJxOpvVtkDOlgZj+UUl/6xvCYGfh6DQLBRSw4JBLa3DE+lApibABYlmWaKbSLWQ5mBdSys6oLjlgtBH+dyL5dNBes7lZ3AKM1qd30oJUHPxJnQBz6fGGgG+HMsHnSzgPk5SXyKUtAaXwF6N26G4R2NK1zWQ8uTed1zMgRjZJwttJnHUwgOPWif+QYcO5EKEZZvf5Bql/SOn+9nn+RkeC9q1D+m0GFSJT1vC5Ojkq+QeTzr9vwW3aoX3deOYLJ83N4bKRRNq6qwQ7gtCdoFxo2V1m/EzF2X/ceKfI/n2QRvw4oP/MXCui7A3siZHmEyA03yStSuw6YI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXurI5GeEpreoCLuS/wxIvkufR9Qh0W7OApTu6/79lY=;
 b=X9972ZpFCrORrssnycx0M2eWHDwrsVB+yiddoaYHoA1ISpJ46zgntPLFLt2ZMnQCyAhfKHnxfjjSEZugQd5tXFFaG6kTIJEi4DZ1nsr5LyXDFWJXln6sHMDVEt7s6minSUQob4BA421V/xLeGE8XGYsDx/WigUASUEqqfAF++4g=
Received: from MW4PR04CA0334.namprd04.prod.outlook.com (2603:10b6:303:8a::9)
 by CY8PR12MB8363.namprd12.prod.outlook.com (2603:10b6:930:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 16:43:14 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::4e) by MW4PR04CA0334.outlook.office365.com
 (2603:10b6:303:8a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Mon, 1 Jul 2024 16:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 16:43:13 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 11:43:09 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v4 7/7] dmaengine: ae4dma: Register debugfs using ptdma_debugfs_setup
Date: Mon, 1 Jul 2024 22:12:33 +0530
Message-ID: <20240701164233.2563221-8-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701164233.2563221-1-Basavaraj.Natikar@amd.com>
References: <20240701164233.2563221-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|CY8PR12MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ad519d-100e-4f3b-3fcd-08dc99ece6ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tN3cVBK7Kd+v1iBstaHIEiWL58Oscm8Ln5QP/LncrNU9LTjW/YpvE3tVtd+6?=
 =?us-ascii?Q?WWW8VsB7Pu8l+cKf9pexlOzfHz8RJfpH//nHo7+3/vOFn4MHTPdry8RdAHRz?=
 =?us-ascii?Q?AM5Kw9nSehwfRQ+JstC/9p2eFa1BRE7YONiF6B2mk2/gpYGbJG2fn/TUGjJH?=
 =?us-ascii?Q?JzAJGEkmIO0xbKr5Y4H8KhOhG/RYjmgFrW2y48jprC71T0zk+5sGcoBsl/By?=
 =?us-ascii?Q?nWVUiNmGtAxZmiKIyjI4px9NO36gL6lmmtBeArwCSIp03Lg+Abfg0WfkB0YX?=
 =?us-ascii?Q?NARdaxraEyUpi1+RN5gX18v+xMr0e4Q/hRrEHxBF4ow3Vw23fvcggAuCsICc?=
 =?us-ascii?Q?TF5ZJoU3kjK4Hg0Uk5oxRvwi7AXk2ammXy2/nkehukMQ0d8wkUDUM02UxjVk?=
 =?us-ascii?Q?LgwyVBnfWJgQ1BcM/2YX8NYkG87eNHNJw1pwaio0au8JTiD1DghbXQoalq5D?=
 =?us-ascii?Q?uOLqnbLrOAupYAQzD5GvwX5bhRvIc88TLp46gN+SvlvR9/p8TQUdd3bZVRm3?=
 =?us-ascii?Q?q/E9tWSR52VEk6ZkAlv+eF33qcD1cA/H6BtyC+kquF1ZzXVB5hG7aYzhF8az?=
 =?us-ascii?Q?niQ2px7CIdr8xhQJL1kgFLVpjMwv4DZWZct1vEOiGOtrjScGpEgUg2GhFeG1?=
 =?us-ascii?Q?QbKHIOfy2wlsE6MSmXQvnBp1fn61EQip0CGxPgD2+5jrjVXaYUraQILX8zss?=
 =?us-ascii?Q?RkQDUvNBXSXacPyO6HJa6FhJbiFnOY6dsAlMlbzNzvcbdw1zY5kv7Vj8Zeq6?=
 =?us-ascii?Q?4zkQ2id7dX6GFSBFBgisKGAzcT0UswmMdGlC4rwR5C9qhFPMllxrJnaACt8K?=
 =?us-ascii?Q?NwrdaRdsMcJJeozIY09/8tp9/y2fyUAgiYpEjsBI5+90Akv/ikBszQDK6Ui6?=
 =?us-ascii?Q?sg82fEGoocpz53uGQ3afrJlCZrYveyMY4H9gSbp0N2UxxGD6SmZdAjLUN//B?=
 =?us-ascii?Q?rwVOQniOHanUIY8hOJ1jbf8tMB/hPQIEBs/XrjPduyCmZVjBJghMTKupAE9X?=
 =?us-ascii?Q?JqQfsUHGmzE3DSUhcrm6TALH/hKD3o1QhyfC47env389XG/YAZC57a6mv0Cn?=
 =?us-ascii?Q?Cs4EFwOnPZUoaDexyYYcql2b3AN916x5wGWtp7e+svQRiRo5HMTojf1udOaG?=
 =?us-ascii?Q?0NewBOP9B7vVIipVdsBKfBVvcL3cqNuoe2mgWBpvgz0oFpPnQjioYg4mfFw2?=
 =?us-ascii?Q?rOARkKjmhtpzq4MrBULaRPRGFq8/VjHe5QbKnvPt9W03U9MFeNaqA0dFN02z?=
 =?us-ascii?Q?vL3GT+sG4QhWy4Toi32ekkSv2KmWiIOpVTIwtO+SSXbyRGS6A10ZkIGTfKBS?=
 =?us-ascii?Q?q5RKVKFNB3XUmvGaeuiSNZJWacETxKWfFsWotG9BnoLMNYM8OO910Oim/n3c?=
 =?us-ascii?Q?14Qsm5bUZWrFgXIh9Lwfw9xe7SHa7o+EK9hsOmh3mbo1zJLoBOg+OTT1DdJu?=
 =?us-ascii?Q?DA3PgCg8xilQygVn5BFfPYVDpw6fnqap?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:43:13.9806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ad519d-100e-4f3b-3fcd-08dc99ece6ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8363

Use the ptdma_debugfs_setup function to register debugfs for AE4DMA DMA
engine.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma-dev.c   | 2 ++
 drivers/dma/amd/ptdma/ptdma-debugfs.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
index 205bb8822f84..f318f7db5844 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
@@ -253,6 +253,8 @@ int ae4_core_init(struct ae4_device *ae4)
 	ret = pt_dmaengine_register(pt);
 	if (ret)
 		ae4_destroy_work(ae4);
+	else
+		ptdma_debugfs_setup(pt);
 
 	return ret;
 }
diff --git a/drivers/dma/amd/ptdma/ptdma-debugfs.c b/drivers/dma/amd/ptdma/ptdma-debugfs.c
index 9aa7a49ae5be..f2973761cca4 100644
--- a/drivers/dma/amd/ptdma/ptdma-debugfs.c
+++ b/drivers/dma/amd/ptdma/ptdma-debugfs.c
@@ -138,3 +138,4 @@ void ptdma_debugfs_setup(struct pt_device *pt)
 				    &pt_debugfs_queue_fops);
 	}
 }
+EXPORT_SYMBOL_GPL(ptdma_debugfs_setup);
-- 
2.25.1


