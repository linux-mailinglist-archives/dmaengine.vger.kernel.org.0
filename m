Return-Path: <dmaengine+bounces-8368-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD21D3A27E
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 10:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F11FF300C0CD
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 09:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE6833ADB9;
	Mon, 19 Jan 2026 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B2oFx4JB"
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ED629BD95;
	Mon, 19 Jan 2026 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813818; cv=fail; b=CAX0FuXsAfB/ZXjp7iI8CnZ/cBg2FrPxal8XP9+hGatKnZ5Ke8ogsx0DxYOweZ7l5smDkdoEx70dIZ90//o1s3N+7Ucw9FhUl5lZcN1KLBUx+0MBpZxUqIxvhVMcv+3kAyvG6yEn+SYTX9KTgWltqfXmEvX6utDL/e4A6FhhLzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813818; c=relaxed/simple;
	bh=DXkb7syT2HsC/E048yzSJuSJ2BmXl8MidiAbgr20IfQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mJPgpV69bKMlQHsiXiGOcbPmyOvpfo1ARrx6WNFyPEOK3FWWCS5t5vkPbvcwiAHizN8hB55iNT+NvjAgg456VelAQFERLK4YLGlpNi0ClidR0nn0RBC0h3yvc27auDI5GbOheOgstB8KYZ6XKP+T/Uc89Kf0prWnCz4+1Jiksmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B2oFx4JB; arc=fail smtp.client-ip=52.101.85.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCZCoOmA/PnQrQ8hzSkkJp5I65KlstJe17fKk1sNxazMF2PWg8apXNX3UXg+c7o+kEFG3xYddMQyGJ9YYmsnzj97K5vJ5lgjrl+EUf8KP24OfuBNIf6nNN24fVUfIjh71sOOO+575H3JuDZTGnpNhJGO1SwrCtOI2YdyKlrelJDXuOEmD4QMx9TWaJmeSZe0pcnaVB8+mgkqFZKp/qBUcBz0hVDULfRJqcc/PUhJzVM8g8YvrHY52w7FFCxvm0H26SrX1r+WJNQVerswR3zSzLua62pArfTkNsYX8RJ8jR1zYF4TFRgdTTrDVOokn9hyH7iidVVTcnxklLNgyjI/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgwVwjHGlu1lu66wujHGfonwt7hOEpW8a4lVKLfVauc=;
 b=p3WpMdIV0Ql0V7MCE1a4lRhoiU+K1+DTZSrIFu3OR0lKhNFiySeTBKqdkOl1SeHIado/hv5WUKr92uqsFgNP5jpZ/NkQGc+Ys0fzDzsRCK7fe1oN1rvE0JnmQs2w31GY9JGfU3p1+qCYrVRriTtpmAMtnLrbqvVaYU3pOASoDEHJWS9WB3bgufGXNdfNyDHCVnUa5OJ7dno5NSq7mb7yBFKVpVbEOJ0XR8asfdnWXv54h32kOVM49wfFHdAasp4iFsltWiwhcoItKPFr/ezRcR04qL6ecYxGxXYBPFVgFRK9zl6ArQ4YoeKgV5Uol3QOiz5vQPUCLxtczsAvIGoGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgwVwjHGlu1lu66wujHGfonwt7hOEpW8a4lVKLfVauc=;
 b=B2oFx4JBrZk18ffrXEVbm9OsK0lTd9cpCP16Nj08bMKechH4dwKyWgB7HZFD1xuuNbrI/sLcK+cG+1Xf1Z8b2gT17D27eKOCo77/fxnfnr5dLx+mIJPhdKywYrtD7fM2b+u6P9GGFSkx4MW5FfLHBuPOP5x3I2pxUx7VoFPTzHQ=
Received: from MN2PR20CA0017.namprd20.prod.outlook.com (2603:10b6:208:e8::30)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 09:10:13 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::97) by MN2PR20CA0017.outlook.office365.com
 (2603:10b6:208:e8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 09:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 09:10:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 03:10:12 -0600
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 01:10:10 -0800
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v9 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Mon, 19 Jan 2026 14:40:07 +0530
Message-ID: <20260119091009.70288-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 989a1033-e741-4e3f-8458-08de573a8e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+mcHA8XFSJayVMPhB9VWAPyf7sxUwTxCvQzDDe2WFvXY92rfIL2zy9MzETRU?=
 =?us-ascii?Q?8kt5wZuup2WkptqmtkI6vF2XtAVG2CAvipEt5U++Mz13mbsqNTQWtIvBvKPQ?=
 =?us-ascii?Q?Mg20/FoBHKUziP1LCtmzCbFRGmRAAABUHXDGta14olLohi2bVwT73LUgcyhr?=
 =?us-ascii?Q?ftnBZzUYR4TVBUjotdpqN3X1+MuhIk6nfGJt9yue5emIlbsY6vK08rOuKqJ9?=
 =?us-ascii?Q?VKB4MosjCJ/TP418Vo8sRXZ/u1SoCyrsPmYivhBg42VGuHnB565WuW2U3kBy?=
 =?us-ascii?Q?kcsWNpRpySiIlqZDxRSeV6PIltnLqn9mk2nPsSgZsacBRUIfd2Rgov8fyOvm?=
 =?us-ascii?Q?Kgk/ZTzY/eAUvQuUZPOFVLYPeiVeOivcFqZJ9DxBj0wlAtWuqF/ojdZxgHs5?=
 =?us-ascii?Q?eHRD++2wEomy327M7bhbQ6ulZu4D1O00E9d6cSQ6PUVgLs7J9miAGuteF5ia?=
 =?us-ascii?Q?1xijF/OUQxZSHuz2dJXQrd9A6dpi4nqTfvyyVo8GECZV/uY7P6JzO8Ak0wzQ?=
 =?us-ascii?Q?prhlfUx1/RUZ2U5Wf5JbaloGzEjlr4vkby5S1QFGzrPyzu9C+cEGE0luDidq?=
 =?us-ascii?Q?AVp37jUafnsJH/L4JoTvyVcVW9AlM6N5mEieh2v5NBkcqA4LUgqkqbLr5GX3?=
 =?us-ascii?Q?rhCqtwS3aXPUk7d6H5837PyVDTPKZTnh2WXUUGuSTJRlZ5y3f9hjogsTjuMm?=
 =?us-ascii?Q?su4u1cLyOcxjojyyaPuTeVQqX1gFDxW1iSZocUob7efT5sOoYORIBC4mb2v/?=
 =?us-ascii?Q?pCMou4+eWokBF3cFeX5BPWuO47XlAXTy6GK+glqzu22SxnlV5xmeXBZtiTV3?=
 =?us-ascii?Q?hy2MXBcF9q4VkS5h7a9FJa5/bRD92ArA1yyKBztnMEFEXhp1acD2U8dw8Zpf?=
 =?us-ascii?Q?k+dKpofoJpDiYja1cLffNQ9ARzo/WYocpsXJfIMrXaIl2LdUJomMPyUFXN62?=
 =?us-ascii?Q?K8klkQtk+FSSV0YhDHFJkbWYFnOX40JU11riD7eooYNASxHiJOICJ815vUr/?=
 =?us-ascii?Q?s8cgjUHUiLwA+ykElyZRHJ8fQzEMR0Ya1rYTtErXHDa22MTCNoOziVNbHnH2?=
 =?us-ascii?Q?9cxjDXX9EcADb/sfZJ+/Mon+yCfI7CMc4L6V9OHZLOqu1FZg76r4mifrVNCA?=
 =?us-ascii?Q?BKvA0JvqnlgHBEhAA8yUN+mwZIEv8tfAQMhOC+D4Nq1VtTpfV3ly8cI6FI3j?=
 =?us-ascii?Q?icjcVv/knwj8bw4jdLVv93Er4p0IBHBCZMfkvIYUIXShMuGymi523j0oQ+wx?=
 =?us-ascii?Q?L7GsUuHMzmKS0g2XKwm/w035tAL9QNFqhG9Vr7+TZmy9dvFs5ncpJtQWC+3p?=
 =?us-ascii?Q?WRM+gMntTP4pwGwPB2DNz080o86EMtqqt7Rgg3zPFol6iKtQjStGcUpkGJzs?=
 =?us-ascii?Q?SMXbI2JK3es+wT9Qv4a9uhvgvAYw8kTukIBrlcELu+LBLzZPXz1cBsId3k0Z?=
 =?us-ascii?Q?srlnu7BFBHUtnbcCux/romlHrZ0U0XZ5tz+gm8ObdYgr5ldBhOMnwfAZrvhK?=
 =?us-ascii?Q?b2h7PwzqDOmrNN7vs7O9JD9PM34iPk1agdD9EWU+7qup6vFWjVmWUJuOf7lx?=
 =?us-ascii?Q?H8sR7s3oI0Q66/vPXZbX+FBJ18csD4gDnNJwl/RyoTzcKgHKvK1F51jhSNvO?=
 =?us-ascii?Q?6h3vO2ZcrSCcn7zBOtEvqJTiPmdFfjhv4oHSqaeH1lnl7Yqx4V+sAfDHT2Nu?=
 =?us-ascii?Q?IgU6/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:10:13.6183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 989a1033-e741-4e3f-8458-08de573a8e14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814

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

 drivers/dma/dw-edma/dw-edma-core.c    |  42 ++++-
 drivers/dma/dw-edma/dw-edma-core.h    |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 223 +++++++++++++++++++++++---
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  61 ++++++-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |   1 +
 include/linux/dma/edma.h              |   1 +
 6 files changed, 303 insertions(+), 26 deletions(-)

-- 
2.43.0


