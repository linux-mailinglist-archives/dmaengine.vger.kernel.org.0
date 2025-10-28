Return-Path: <dmaengine+bounces-7016-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27048C145AB
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 12:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7E41A664EA
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 11:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1422D7A5;
	Tue, 28 Oct 2025 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vjetOZWO"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA3308F35;
	Tue, 28 Oct 2025 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650948; cv=fail; b=HaaTsn5aWsBPJ0VfwnbnIdd1u8IG7MMrgoyW8p3QhZ8tZh7+cOOwa3P0bczS6u3/UzyXOfE4QOkc4wtLpgEeb2sM74sJThR0uMABiyLRSvHqs5z5yoE+xe2tYGjc0jgVCQuX2GNW9Q6E04u9Wa5NJa5n0TcuZxmLHfMolSTktm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650948; c=relaxed/simple;
	bh=iWRo3g7BCRolzDPzmSzmq6R3lxGEj2glFXClmSzyHSc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JAWm6K0WzeIi3zDD0Q0rgdov4stJJt9kpoAdqarcsPar5N5AdAdyPn7pbfAEgWIua39sKjkzgIRG2mu4jRp+YF+1dW+8MFmP2ZSvSObs4iiqKRISSJkVSiHQSE72A1KqYJIr/XNJFbP8VPjPoaA3PPN503uk8aeW2e5ENEiHCEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vjetOZWO; arc=fail smtp.client-ip=40.107.209.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOf3EPS+5lLCuu/bn0PypQm7AcFosJU9md04yruMJlpiFpSjJfg7SUDYiELA4s5nMm2h1Yv3b1GMCKdDrJHH560axfHcv/cnkKye7T1DU0VSwfrRpuJnAiVRrrw62evbjA+rpUuepFiE5bJZoHDUyG7Z4SmNHZygl9Z2sQbIXGuaB1IFOHARf16a//+S4erpeXisQRbFSY+iQGtk7JKiQUIabAMqcD6UTsRCB8RjmZeqY4P0u14w4IAvJ7/nVFBTqsA6XTJkIjGK2nnosgp1EPPIUpT4vnGVAatOdrvBrN59nUbq4NzkRe4ZjCVOy86zoKmEjV3RBlfYeShLcPHklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5uIUz3isygLciDGBvjxq1tE8e4A7hP9ueFPch35kSY=;
 b=BjWrchMgnYU+OuqZJ5Q3MR9mAYcuNAB/mWCx48m1RtJ+uFkIpZgz259ACh8hCpMbbpIbeq3slKERyQNgwh6a5yVvmlrBiunq5RM4eLMTEIRwePMxGdVO/0F+9/Urka9srQZhh8k12B1EpbapYcjYOhfEGiR79lp0skem0fO6hSUeyHA2BnhVaci7hM86+qFdPSfMjWYVGu2zH0yWen8jqERWQobB2uKl3jKCRRnf3OY112BhEnuwjet7wuBNvoOzKH3bFa6sOMuQD1wXnvXs3DH45b9tYrF2vi9F5PwtG9eCTDpBM5xV1V1QPJvfYTkKeqbuUmCLh4tLOEqf5EbqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5uIUz3isygLciDGBvjxq1tE8e4A7hP9ueFPch35kSY=;
 b=vjetOZWOAnBbWvYd3MXhcU9oKPV6wCL8z9o176otmhxzn8BQi33Sc6L69Q/6fnbqfr5883/4xA8pwU7HQR3tdVzj6SSFcJM0K8KUFtenMBDTaYbEwQ8GTvQbgDO9p2LkgiABX4qnpGQ+30sSlEgND4HK/Obs1SxD6izu8xMOHBQ=
Received: from CH5PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:1f4::20)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 11:29:02 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::ce) by CH5PR04CA0002.outlook.office365.com
 (2603:10b6:610:1f4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 11:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 11:29:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 04:29:01 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 04:29:01 -0700
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 04:28:59 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v5 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Tue, 28 Oct 2025 16:58:56 +0530
Message-ID: <20251028112858.9930-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: d12cd3b6-8878-4c0b-8fc6-08de161531fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PhogdrKE45o7ZssQbiHeyUWmh2gZsGeY7Ngohd7CXURHQAlLRzp2xFYk6igz?=
 =?us-ascii?Q?hiDJ1AvInc2ydJAHx60HPZDVM/lCmPcfWOHoKXwH+TJfhfYBKh/8wosxDAhK?=
 =?us-ascii?Q?/y+kkKDar0ZUC9/WTCrak6j9Qu5g1xMrXyZQNcT4aTRy46lthQZfF/WIvTo3?=
 =?us-ascii?Q?NGiqzb0ZnyShm4KIoKsoq/tsIOTaSLgwS6RPw0a3Bj4lfYCxmcP5Yxmprfsz?=
 =?us-ascii?Q?sjbW41wqzefrEu+wJ/3pGjFNhU3YfQXMrPtk0anx5Bo3NRgywLspibHfuQEH?=
 =?us-ascii?Q?n4MuVIWVA0lmTo16rcLtxJL7sg9gnEyTcR9HveZ5VAZeghUEhWwy3NhmaSlg?=
 =?us-ascii?Q?6916WbaAX4GFdLD3tWf9RYjrnAiIVkwNDehDWjLJwjRSJoXjeiovlY3ZJ4Al?=
 =?us-ascii?Q?veSrUP4zodJX50LyM4/UkPTBo0+EKa13+dl+PmNKlVeJDU5dR+jX7m2jbEzH?=
 =?us-ascii?Q?QHXavid8j5sp9lcSnDIvxpNA+Lgqq+OnSCqYRP4dydUaaQIq6h4Pd10L39sG?=
 =?us-ascii?Q?q3/i1Do5yLbphlumbvyP1NzNz02Fy0WGRhgC4kLYVH75jeKtgMFW8N3UTlMP?=
 =?us-ascii?Q?VwSEsi0JqLzR/PmqtJrsrwObInMgUT9HqMovsoFx5VYdeukHnAxPR2dBN1Vi?=
 =?us-ascii?Q?mtsSuaFlo5kgx+ZTXQ1dZIhVwuS7scPtyzxOoj1K12Z9NVe/d2mBJRvM3Zyr?=
 =?us-ascii?Q?wnmUlI9poYVVXv7TsmhgUcMBON+sxGlh9bLu1ZTq0T6nF/NuSOYG2qlTckYH?=
 =?us-ascii?Q?OM9aeedJZvzQCV6t1FlROD3CxEKytmq0mKqN0zsWPZQZoHH4rXe/MKpygu0A?=
 =?us-ascii?Q?9ab+1viVNYsDhAdNGs62W4k6E50q0yF6CgWZfFMUtE3rw9HyI62gLOnma4Lb?=
 =?us-ascii?Q?GemKaQf92KWOXpFsnd8nsnMXXZfZP4EQGWmI9F5A4PilWibYk2Xe8JBzrwa7?=
 =?us-ascii?Q?EBr3qVkVuGBXATeZvhh8Ey5cO6DEWN4wPVg1eI2PhLRhpHN626mwUbKyLhwt?=
 =?us-ascii?Q?QmbVgVetCJtNYAoHZmzJKDi6T9k70cxEAqjmMPnLd/Bt2pEOxtaXiGKw9/Zv?=
 =?us-ascii?Q?Kt6qXf4aZRPIfiJWED6HieJuKR5MAsYcITApJQoYNSCMJEfy2EyYFrkSJK/i?=
 =?us-ascii?Q?VUxQ5lG88Sn7rfYYz3m3UBnmaNX7NaLAcuhia+DCYLbytZaA9E0uGb8XAcyo?=
 =?us-ascii?Q?gcFAFIEXp1qiOlY1A+ExXAkyMmScsF6QQmuluV2Scp43KNv5zY56wb2jLKAc?=
 =?us-ascii?Q?xA5PbSFnp9ub/QsFF8R6t+D2BlGqNt3Pbzv4U72jyREuQEKrxWvc1hRh5Iv8?=
 =?us-ascii?Q?kXe/8OAu6nHjur/3R8CYh8pCMbCi2FACR46Qd1FtS1SnG3HHQ4ZWIcLjOUb4?=
 =?us-ascii?Q?hriB6YzlN5e4rpgeB3VrDrYtwJ+MaTD/ljlSMUQU+aFqx7aD7dZCYNvFQ/9Q?=
 =?us-ascii?Q?Pish6/RBboxrY9wkaowvabrRY+VS00BO3/r4f3ghLt3WO9YPdVGXFhrJect2?=
 =?us-ascii?Q?1ORYrSB1ozaPH+pndeW0QaNwwxcWpBiqjIU1B6lzQwOARG4fOchd/WdH2MAm?=
 =?us-ascii?Q?wzB55o0PBtEL0FFgKuc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 11:29:02.1487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d12cd3b6-8878-4c0b-8fc6-08de161531fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740

This series of patch support the following:

 - AMD MDB Endpoint Support, as part of this patch following are
   added:
   o AMD supported device ID and vendor ID (Xilinx)
   o AMD MDB specific driver data
   o AMD specific VSEC capabilities to retrieve the base of
     phys address of MDB side DDR
   o Logic to assign the offsets to LL and data blocks if
     more number of channels are enabled than configured
     in the given pci_data struct.

 - Addition of non-LL mode
   o The IP supported non-LL mode functions
   o Flexibility to choose non-LL mode via dma_slave_config
     param peripheral_config, by the client for all the vendors
     using HDMA IP.
   o Allow IP utilization if LL mode is not available

Devendra K Verma (2):
  dmaengine: dw-edma: Add AMD MDB Endpoint Support
  dmaengine: dw-edma: Add non-LL mode

 drivers/dma/dw-edma/dw-edma-core.c    |  41 ++++++++-
 drivers/dma/dw-edma/dw-edma-core.h    |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 168 ++++++++++++++++++++++++++++++++--
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  62 ++++++++++++-
 include/linux/dma/edma.h              |   1 +
 5 files changed, 259 insertions(+), 14 deletions(-)

-- 
1.8.3.1


