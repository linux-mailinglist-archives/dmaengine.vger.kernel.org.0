Return-Path: <dmaengine+bounces-4139-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CE6A13F24
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 17:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB7F1887C16
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 16:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F1422BAC6;
	Thu, 16 Jan 2025 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="db6DZx+7"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0F18635B;
	Thu, 16 Jan 2025 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044471; cv=fail; b=d10NqaqO1DYLI7XiAhaTFeszDYoParREhuSuEPXTXqHrN0yRThCYPO6pkOiZ1EWy8Hck90dYTulCkjjW/TADvyRPxUuva5Gq2d1UvHZym3VzQdAza2BzBvuJ6ma3ow0RIrARJu03vgm/ymwqW9yLR5P59lRcOelDM/aKf41QTdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044471; c=relaxed/simple;
	bh=P6e9KK+ZsQ7J0t6LnRG+4VSYJUODw/m+aWsSDuSP8aQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P4sSy3+y2mwM9q7t+BLzyQMcwwbboGxEhT4wQSWL39UxTjyg+CLOB0TI/c1ZDuqUPOPbuA6oDvisI1CSqTMxDIpcL7RiHIZsd+/TsOM0qb/ALku/YYfBzSO6IirCOPPU4QpvxYHWZtr8RKdluVuwZPTv+IQ1NtTBSWDvBHiw7o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=db6DZx+7; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdlDBrND9eoF65N89YIr3qc2N6zsN/SDjpDF5mwEDVNkbDz0rjXOKnc54eIXwos/eRwHk87pe7HxMVYuJ1QAS7Z3rzIVoeWQTtq6Z9iAQstsq2O7GcLZLIBM8+wvDR3F7LNdY7ytwbVAetffvu6RWouaOXlX/xmQPUgkqywgznH+gLOxzXUaO0IGYQYwryroJvaHrY+jCliiVF/C/+qs2YWB/gT5S8Qz2HWZ6+fMznWpCah3bVnw3DumiZrttOsezX9MVX+hCECKBxLnSKqVY1faf5c/SWqqbGTq+kRjtMuErLIQmoEJUQ4LgMStUN39T4SzfDuG74dv8jhevu4xUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC+Sn0GnGUg2BzNNzQNKhWV7l3mz5HP7mDl/DEBsfjQ=;
 b=C7BIaW9X/zJoHMpdf43F/aDU/Z0MfE8d+VDEh2t6T2ouBEjQuXoglh2T0zf8Z0t6JWBHqrkqTyLgCw+ZuLNmNHjxewcqU08yHGzJWEk/8P026NJHC9XlF+mvFODbuOsAXKe4vyHpXUtwn7zyJI9jqmmw8B4Ib2sOOCxcMJr6bQ5SI8o2QDpc01MhVuFN2snL6Ax2MTHxtAcY5xH4SYisMNvq8hBqHtcG5KjlZPkbOEQ4wpOJia26U6Y7tZThehA5ApL0/bv+k5mCEEhc3tl4huUzLa3isU3INLyAwwAiprUpsUQIvP15OlX9zw/vihYv6JRxsR9e/+Bo+eQXq46r3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC+Sn0GnGUg2BzNNzQNKhWV7l3mz5HP7mDl/DEBsfjQ=;
 b=db6DZx+78+V9M8gUvwtCei2alXN1plJf4nOABPxBGemL6bQURCTrZNY6RalU+K3kD+bKsGBJc00ch8WGs5080VyoIYWsmm7eOozVWQ53rgbUR2j0AOzJ3cc49+FSGIxiDoy90ZIFMBEob0qo1AYQn/SqMQ5l2skWHibMOCvg7QbCV2jfvvtGsPYYf2sqp2O78xtAZhAA6AU1mtuXh/vMaXgUmPdqf5l3zUtBeimOKvStu141w6aDQgoknqDJ6gXsRnSpTX3aoV2d70BSKuFy0zKO+eEQFDzaE/NbzNVTbx4hWPF8VzmMq6gORl2F+PesG8yrXDXWpVXDHVlzuI9MWw==
Received: from BN7PR06CA0048.namprd06.prod.outlook.com (2603:10b6:408:34::25)
 by PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 16:21:03 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:34:cafe::c) by BN7PR06CA0048.outlook.office365.com
 (2603:10b6:408:34::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Thu,
 16 Jan 2025 16:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 16:21:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:20:38 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:20:38 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 Jan 2025 08:20:35 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>
Subject: [PATCH v3 0/2] Tegra ADMA fixes
Date: Thu, 16 Jan 2025 21:50:31 +0530
Message-ID: <20250116162033.3922252-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|PH7PR12MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f23151-d7a7-43e0-8cbf-08dd3649c593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rmjH6RVbM3sqMSt1azbmm5cxDCKbJS84VACgDgOTrpbT/WLLu56FltbdilAa?=
 =?us-ascii?Q?u1iKm4wrnt7WBnwUWtdmKVSMeTldGoyYrC61hNGhJ2Ak8uz3mT7PEIjvf680?=
 =?us-ascii?Q?x9fJz30fWsrB205DK+loJS6yz0HDMyNVwG3t4NcIGtZswFrOv9/uXU5ILRQ6?=
 =?us-ascii?Q?ANxbpfdgWbI3rSKPfWvrz1Ws+ieIJDfl/7lKv3jNdC3k13koblCz66ujeFYE?=
 =?us-ascii?Q?lDBR/B7wuJ120IuurXNrCmeA9M8SFXtH+Bmv30mefbbRXktcxEKEb9q0JU3r?=
 =?us-ascii?Q?l71pLR4Y5ENW0GRj0+EiQeCID0lT9HeqAmiYqhlkXRXQmBIa4Vtl97V+JHF9?=
 =?us-ascii?Q?XdNrDGwItw8CzQLfqlFsrGDD8rqvo92e5ahpu/oOwWOKixYgE1UcJyBq9hN/?=
 =?us-ascii?Q?E4tV0D9J7Ypx/WyhMJLBKiff7VakO4D92bCiW/98YCq1FAsm0/Xo0Y2AzBAS?=
 =?us-ascii?Q?pjFLFHAIQ9/yPHVeWr3GCVaFvxDWw3UvtY6WWPNkT+rjOus5dOejNlUqcPrR?=
 =?us-ascii?Q?1AWuIR0pdANf/k8qAH52q5S/05QWWRiRuU9tkiOAoYy0JOXPieG8L2a5IOUY?=
 =?us-ascii?Q?85GTJ4i/+fP6rTMsxSQDZN42+RIjwKNboqLmp+uI6re4AnXUrscEKJco9NFl?=
 =?us-ascii?Q?4723Ij6nwG51FGjPsapcKSs7x0xlvaYP0nPusDZ0Ua6d9C3N84rAa10AmmRl?=
 =?us-ascii?Q?uDzdVJ7QEDRTjdCm8S8dvmJUMt4OkAMNY4GUYx4rIj4AnQX2S3MgfwYuzPID?=
 =?us-ascii?Q?fpJfb83sIOZT0mQF4u8Oyokk6+Adp2JWS39/NjXqx7sCEOm8+q6FV3xuvsBs?=
 =?us-ascii?Q?7xGGHmWUY+ysYH7HYOEIEkN+vFRgDwp3Ii4Cz8aGlE2lb1JpwU1wHt4GgBFF?=
 =?us-ascii?Q?PN8rKJesuHS7J8GDndAItREMhh0AhhEfzwZeSoUQOtZ0OqmDGMCdx7MQffnX?=
 =?us-ascii?Q?NG1YcHePlx+c/wKNTMn6b2yCbv0IG2yynV3J9eC6N7ZFRyvTq1hErcCC+MM1?=
 =?us-ascii?Q?6olqOM2HwYRUH2VXxlsZjm2jk0MO+6D9oO+iSNl/PvAILYHF1fwNeLUp3Ek9?=
 =?us-ascii?Q?Dfg7F3q2Hsz8gYqmrYcWpGakOPuU5JpTnC9HCADFX7GfX8i4WMy5ftkmU+25?=
 =?us-ascii?Q?hJNvW+hO6x/YhDw7iI42fH/SRvXOSP6V1yowkKE/1nmKJdpAkJykuhHgAZ65?=
 =?us-ascii?Q?BxQElKGWUEkgoSPQBF576NZh/K52BOfdiEb05u2kqMFBy1vaBQWlWRISF9cy?=
 =?us-ascii?Q?j7PcSOk1h1h0xxQthqpEX/7dwT9dpyXr/OmcjmoW18tojBaXGQttxMsSvUQf?=
 =?us-ascii?Q?42nLTFGlxTOOykx6pnkgalfDHOfjdcy/MeA5t3Jr0A/Y8PCh2zbbYh1N+koH?=
 =?us-ascii?Q?txgkU54+Zi+OKZkAE3/Ne/LNXZkGJ7Z4AUo7ci/XGqEYAOqUWZspXm0DFWnl?=
 =?us-ascii?Q?pD8rb1p6DJsGa5EU8jzev8Ujcpv4bJd5sKwQc6XJgtjpYdffFsAXbMPpbGaL?=
 =?us-ascii?Q?tGs5L1zeYIf/I3k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 16:21:02.9741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f23151-d7a7-43e0-8cbf-08dd3649c593
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6000

- Fix build error due to 64-by-32 division
- Additional check for adma max page

Mohan Kumar D (2):
  dmaengine: tegra210-adma: Fix build error due to 64-by-32 division
  dmaengine: tegra210-adma: check for adma max page

 drivers/dma/tegra210-adma.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

-- 
2.25.1


