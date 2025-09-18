Return-Path: <dmaengine+bounces-6628-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC76B8409E
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 12:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA2416A4BA
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 10:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E152BEFFE;
	Thu, 18 Sep 2025 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JZzgXKBB"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3255F263F4A;
	Thu, 18 Sep 2025 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190853; cv=fail; b=lCbkv/sTqW5Kzm2xYgLEXnGhN0AQwhi1FOtRheBilVxCN1HLecTXXH+Bsnbmof6dYKBozzFJzuUeO4y3WP6LiV/tHXpdYMQWKnJjkC0ZW2NS8R0wx/ycSqbjdx5huxRqjlO/rGoUBy8tKLEMVT/VAMllBmpN0C7uG0jVuaHdJaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190853; c=relaxed/simple;
	bh=RxrmJePOGzaIRHs8CO9zFWpB2bRK7w8s8jp5KGpyoDA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iS5eujruvbYh8iAacumE5MeLSefFPWiWmfKnCCo80cEEHqO0c30gzNBpPUMyZsk4UuUKpENCYfvTo6l2McoR+lHKuceNuWZOkklHPsFgIcp1bda9Qg73Of+WSfs1FC8bdjcnwnEZQtXkAvhnuq62E4DPdbFBd67NS/mfvL5MEig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JZzgXKBB; arc=fail smtp.client-ip=52.101.56.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCB+rN28RgtzTBJ3jbwficI/jYBVUN7hFHm+tm5pAJ5S2nnSg/2eFqREbdHWj9U07pc9VTTGKZGbkxsoFQMphZmPJKVefZNrI044qvdk7K2P0CdHnwgSeilqEdrYroeNjgGDAB5SWaOZHIZ1fimRjdhaC/l4thdFg59d926fuRLxiWz+5gexc/61sMpzsY0N9iqWGtRFncYASxnG905U+Gbdcj5oVzxWhZTT7w+VbSYk1rsdb3+Asb4W+NLtT6B6+FFFRL3bn6I+hvz3p+6SxYhnkbPoGNNji6GAQLXGFOJnUTeTD/8ctD04fJqPB8u/WNL4V5Jc9HNJo9vSGhblKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtZFw1xbLEKWPYrABR0vnWVYofF0wlAOnJ4QEfZ9tS0=;
 b=V8aufaJtK/b+OLsNIxVSIEmy4Fq5CynIindx2ZDcajvlqoWDejxterI51VJq1fpj8Tl9hbm5QExDZbMDCrztn9U1zc3TdkbkzAMiO+ftjPHymBSD5y9ulohLOlETcGz7zghF4Oz57x5kL6UE2PVizixqs3Hn1XnA4Z+aQPc4Fm10rMMUcYnfB3DvKXVo6u6QHgW79woCGb1zKC3enkFQtrTyz4zG0qFOc3o3B0E8wHEAB61sWnDnT25hmV3Hd6S21z4IYDUY17tXjWcY/7u/oNinm4o2cHW0NfzG8LChjpaTM43umjfq1B5jqmCJ2p6Z+ml51vxDKAfy/3sVSNyAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtZFw1xbLEKWPYrABR0vnWVYofF0wlAOnJ4QEfZ9tS0=;
 b=JZzgXKBBYKVgm9ihuGBVfS15cRs0zLsfhv04tqXp0uON9JhVlZ+5osO4gA1D9ncUsRV3Q8XlRYeAx58U7AH7PIn48q5N95/X05qmPtQod0zYH5A2y6kUWBsloX4DHb560do9xlGaUzhoXH4fm1iaw//KS4E1J1Notq01iCXeK8wus5s1tBJP/okH+mvb7jqzwEFAlvSMhGzvTZp27/g0akuM3YYyoaeJ8fyAc1KVDCdQpEdNgrGHFzSVg+8j/JdDysvGgZZo+wGI+gCTnzcQ/DaKozBhb8gHQ6PZZZEnpzS3N9BDu6txHdttm2s3vhR0oMuMtM/ASx3Yq5ERhZpeyA==
Received: from DS7PR05CA0014.namprd05.prod.outlook.com (2603:10b6:5:3b9::19)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 10:20:47 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::c) by DS7PR05CA0014.outlook.office365.com
 (2603:10b6:5:3b9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Thu,
 18 Sep 2025 10:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 10:20:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 03:20:25 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 03:20:24 -0700
Received: from sheetal.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 18 Sep 2025 03:20:20 -0700
From: "Sheetal ." <sheetal@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Thierry
 Reding" <thierry.reding@gmail.com>, Marc Zyngier <maz@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, "Mark
 Brown" <broonie@kernel.org>
CC: Jonathan Hunter <jonathanh@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sound@vger.kernel.org>,
	sheetal <sheetal@nvidia.com>
Subject: [PATCH 0/4] Add tegra264 audio device tree support
Date: Thu, 18 Sep 2025 15:50:05 +0530
Message-ID: <20250918102009.1519588-1-sheetal@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 28474fda-7747-4b7f-544d-08ddf69d0881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JZmIOHYwTEJYMiHpYQyuZ8L2L87sAlpAl1/Em6Sb9dCAjvLwTTacDFExxfeh?=
 =?us-ascii?Q?0MPawsSCw7TJeFpVZAxcw+no+u+VeLiT7qZyPLhnmr+UcptWZo9sHW5xwuFA?=
 =?us-ascii?Q?dw4LlEadtrb4gN/jeHHJOnN4vzuxIxjgJ97P6huMJg8bPw1snagPjZxlVFU1?=
 =?us-ascii?Q?WeYjIldcuI6joV4H/YMNEOYyIeKwjElVNnFuMs+KhOkEMk/5dpGJ2k0re+Uw?=
 =?us-ascii?Q?cIrSma/rHFVqxM+LTpkMj8JbB1CzPSFPyDcNzvWf+UQocTByyhDrRpqIMApp?=
 =?us-ascii?Q?VKEbGlcHXj/lLF/xX7VpyVPqTb+dJQL+tFBfdJs3WBbl/Tivo9zOJTi+QQFr?=
 =?us-ascii?Q?RvG+uYtqvgv+0ieMYgdBxbs9caVzItA3vh71dnNDBLLGiZq84SGIiwtyIMe/?=
 =?us-ascii?Q?8aekJM2e0ernx5aK0RDt5QF8J9pGgXCzGEFwPVtFM0NOXrIcY6VeBXRZWt36?=
 =?us-ascii?Q?L+3MzY32pB/K2gIh3EWGlwRO0m82Plbin/6ljx0sD1+t6rLdIqGHOWQ7RYGD?=
 =?us-ascii?Q?ISdefk9nm6in9boNDTgZdOQpMfu0U7yd/y3gUbg5FErFTcZ8smrjd5zSWnCh?=
 =?us-ascii?Q?X37tmJ8CrM2Tq6L7c9dr0f0kaLp4eMAfL5ZbM+DAZoSCKX8SUMDjl6go8BCu?=
 =?us-ascii?Q?WQzo9w5oMe4eFWBCp0gGKaAJPRIFrUVIog/HVvGFj9O0bwq5pYIqX8TcvCTC?=
 =?us-ascii?Q?+DzQGp6ExXtpFUOXZXCEYE6dBVEA0htJDJbjfUzdp90GtHQmTIVYgImRP/6j?=
 =?us-ascii?Q?ModeOaFPaS5f3j9GVOy8p3gtzmggsuysrz1ulpgyABF3QFM9nrd///kFTCLt?=
 =?us-ascii?Q?VC5iMAONSrz+jbvA0t42OCEJ1ElnoglEW5P0HeOoP1bwUKDwbdctiv9ebWX9?=
 =?us-ascii?Q?kKGKghiGBIVu6UjLMSrMq9lfs+dzt2Xtba8HM6DKeyL8cmAYWUGkESK2xEqP?=
 =?us-ascii?Q?txQSpteAoh7mxrdwV2TWVHriCio29tc0wcug+AhRjJ3K5ZbLG4rKn+qBUfhe?=
 =?us-ascii?Q?snDSUEBXYBjYHgfk6fbSP/7tSvQmGfXSstWeYltYolZEOfzZm3scYnjeoYo+?=
 =?us-ascii?Q?0ssBIaRZDLm1zT8+1glf+l5Z2j3+ph7aw9b1ThuYyBN4l0+QRRdjeSgYYY9c?=
 =?us-ascii?Q?NVJWe/lT+LtnioKHqBamrOXMdaGAWldtpOm1Q1OmrH4SsUheK6vyxrg/0Q+J?=
 =?us-ascii?Q?eHWXpolD4PEMkLfXQO7ArKJ9XQykWY5BkeM0Eh5OnD/QIdfJvvi8C8AG/Idq?=
 =?us-ascii?Q?Zffn4YD3LXQWi16MjUmjQyayUyBRVCzPRRChRbcQdjPVYUax3UIakia6MNQ6?=
 =?us-ascii?Q?C4+2fjY3g6ajVeQAzwaVllyxKkzI6NWhdUWcueQbFK7QzDuKPQtSYMcJpzsc?=
 =?us-ascii?Q?690X3t5bO5DuFEZDZQ1S0EvtbA3jxeTZ1cn40Ddr7bnCTv+ktZT7cQj3s4yA?=
 =?us-ascii?Q?AwtCYneioe34fDsi5BmhQPeq8e3RvNpER/qE3Tbqv5+nPs4cn9IjNtit5JEN?=
 =?us-ascii?Q?QekrLhOWapjLZYo/10AxymZMMiVxRjg/9E7t?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 10:20:46.7974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28474fda-7747-4b7f-544d-08ddf69d0881
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957

From: sheetal <sheetal@nvidia.com>

Add device tree support for tegra264 audio subsystem including:
- Binding update for
  - 64-channel ADMA controller
  - 32 RX/TX ADMAIF channels
  - tegra264-agic binding for arm,gic  
- Add device tree nodes for
  - APE subsystem (ACONNECT, AGIC, ADMA, AHUB and children (ADMAIF, I2S,
    DMIC, DSPK, MVC, SFC, ASRC, AMX, ADX, OPE and Mixer) nodes
  - HDA controller
  - sound

Note:
 The change is dependent on https://patchwork.ozlabs.org/project/linux-tegra/patch/20250818135241.3407180-1-thierry.reding@gmail.com/

sheetal (4):
  dt-bindings: dma: Update ADMA bindings for tegra264
  dt-bindings: sound: Update ADMAIF bindings for tegra264
  dt-bindings: interrupt-controller: arm,gic: Add tegra264-agic
  arm64: tegra: Add tegra264 audio support

 .../bindings/dma/nvidia,tegra210-adma.yaml    |   15 +-
 .../interrupt-controller/arm,gic.yaml         |    1 +
 .../sound/nvidia,tegra210-admaif.yaml         |   49 +-
 .../arm64/boot/dts/nvidia/tegra264-p3971.dtsi |  106 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 3190 +++++++++++++++++
 5 files changed, 3346 insertions(+), 15 deletions(-)

-- 
2.34.1


