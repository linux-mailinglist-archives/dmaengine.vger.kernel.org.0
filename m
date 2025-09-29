Return-Path: <dmaengine+bounces-6723-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7351BA8F29
	for <lists+dmaengine@lfdr.de>; Mon, 29 Sep 2025 13:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F89189F111
	for <lists+dmaengine@lfdr.de>; Mon, 29 Sep 2025 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2CF2FF168;
	Mon, 29 Sep 2025 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hXNairQK"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E2A23D7C8;
	Mon, 29 Sep 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143728; cv=fail; b=LSfdAGym119pQ3zUJawOMi0eNnRQgHuFM9JH3f7p2uI5B2t/IwuD6Mkdir5wK4mqICcnuR/wmIv4g4FlLDDKxTACavqC9PpuAg6e2FHQu91w/Lwap0+lJc7YCMxI2wGi4tntxUyVndvWZm7HQRCimLtd7i2kKcpecKg08N7S7ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143728; c=relaxed/simple;
	bh=y+K5C3TbLlAyMW9Ocf+ORFY961EtCyGhsxiW7GtWU9I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nfamwm8Y5rpP0q5a9YTVr2ZFNp8NRn0NjoF38EIBzeHdkWYmK0qutzsn3kx0MlrCQ723OmzFL18WO68Wm4qv2ZB1M/odjNqiPtk780nxS+J0hNtdoMhwpGyJZT39TH/NRtVrTbUK+qHukpv2wnZrRLR+eGFDL36SlHz19a3r1Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hXNairQK; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMyVYM+Ckbehk0QXLfjhyt6VxoNd7jiQnJHWgoVxc9vUzp/mdDyb/MqxU8mtUxKe3+/fDT+2D9JZz8DrcKDEBpC9QYDqx0G9h6uv3ZY9BAJmwcH1h01KzYuBE10Gkh2hZcsMV39h/aOy/xLmgffKCl+8QEtoQnDQ4HfVq8KzQ9bWUt98t6PB1KzHOuA2PKn1dXV1PTwxEchR3Y9SKEWaLZNi4tjOV8oelK8Pyl6MKuOh6d7+hmMKQCPOxq3X1HUOWPmvQKv1VginC5VPuyu5ZuRkn/QZGd5IG35OoolPxA+LaBE06tO0ql4U+l0R+M/O/bU07WfscAEGPbTNlzuobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NrYEKHZKKMl0rBkf2LoZ0vgZAgfnfYI8w4AqKbnxjI=;
 b=RH3xHcC9cp2MMV0k0qaZ+aoBytRZSs6cP/WGbO+uWFHNpFiWVE/QYLkXywDhp5ESa8GMT2XVV+mhVKrR4J6ilMJlZ9t8gMw4peKtRxtjrKz+Yuvahgct2JUbojL2ywvuRJimnvo3XnSP6nVeFYWiJHUaTEfDp+pm7vzhEOuZIJpkVeSseZiZ28z1f3yDAM9qoWnfhcVI3GfEzyZZzufeMl92a9gnn3rtN+6O53iPazZUrdlafpyit/sYAnHv+YbQuluYHiIazOJAKoJS7A+1HY6RnscVud9zgKshjo+ZjRyqgk8WMPdfmRaGOTumqB2Y+4e46441dwRzS2T1aluZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NrYEKHZKKMl0rBkf2LoZ0vgZAgfnfYI8w4AqKbnxjI=;
 b=hXNairQKt2BtArPLxNwDhGGs5HrNx8buL90f8cuPi3VMbTOJdJsDtS0J+APvFfpVlQ/Ks8T6tqYhc0zgjfA2W/t2qF6uhnqc0CELsPeuNfI8fphM+DWYlzwt8Ky6tKmiCYhP+EjcygbVkPwP2UBAT1WvE6M5D3yVk+TuWIytytZYocafEYLKUzQaDYpoJn4L2xarLTAuMpPPKK4Ig8kLpHAdBtQCYONLBn56TM1I1cSNgvDG7SxjecqA1i/kXpCxxxWCRctTJ3o0bgRXpmQRRj1mvHwYAauxybhdXgUeVVe7z7ynoadVlSWudeHTfVQAkixlT2GO+DrKGLRvGLsVog==
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.16; Mon, 29 Sep 2025 11:02:01 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::59) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 11:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 11:02:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 04:01:54 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 29 Sep 2025 04:01:53 -0700
Received: from sheetal.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Sep 2025 04:01:49 -0700
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
Subject: [PATCH V2 0/4] Add tegra264 audio device tree support
Date: Mon, 29 Sep 2025 16:29:26 +0530
Message-ID: <20250929105930.1767294-1-sheetal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: 82cf6ced-8208-4117-7c63-08ddff479de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BqDXYlfNu6Iunk4jQ0b2Ij1Q8Gk4TrS3LM5//WbjfLtFHNbnMXiqqS/d7ZMl?=
 =?us-ascii?Q?lDzULhAHK5q3AE7q6KwBaHiPbycXy5pGMc3dEC0fsyqP/ryqqMcSDutg1ngt?=
 =?us-ascii?Q?aqZ/ykVZL2Hp8ijYirPLGSeSmArh3LQj/cidrSPy2X+Y2mIMvg0/G5hklplj?=
 =?us-ascii?Q?UJiuqy8t+cTzUguXEuokfu9acNbpXNE+mXSFR9t63Inww1JqF54mkUfeDIaX?=
 =?us-ascii?Q?hpF8JFnszcc7LUyaHm4ZERg1fwrEU5il0GZMPPfyTMvoRjz1jQ/eX16Hg1DV?=
 =?us-ascii?Q?X0Cbrr3/WgLBR+pvJWn4TfH06jOPURqyj5W47lU+B3GUfYSoz2Y6i/aeXQcv?=
 =?us-ascii?Q?LrQnuG7vZOCg3NrItR8i7YW6AibAV9M7ldEp+Q9z6r371dFAG3djcY4RHtnZ?=
 =?us-ascii?Q?m4HyNE2lsro5ypqhkWpff3Ra+u75D+PdRhfmcuwNYXnrppHCKjejqKiK9hbz?=
 =?us-ascii?Q?HzZT1F3gc6TQBnal6ZWhnQ0HwiG12OYaplQ/Meflw4JTu7Wct2cVtI1mQNZt?=
 =?us-ascii?Q?8RMHro8gCum9GtZdy/aMu+0yue5W8AKQYGLzMPfQWYWf3BRLny/aIQdQeB/V?=
 =?us-ascii?Q?BJHWkxJgp5UrgA8RcgXya71I3KqUsx381ZqSRefTgizbfdOuIW9Xua7lhcze?=
 =?us-ascii?Q?KPuArlq2bdlgqs0kUC1t+2IUKNv4qoPqwctRkR6mS7/V2tGgEwhwiNJWni8+?=
 =?us-ascii?Q?eIIBjLS2hl8faJHNl3m+M3A2EpkFrPQMjzpnQsxntK+X5rj6N69M7O8ilTIa?=
 =?us-ascii?Q?PUbSjqvGP1VBl9kAV4EXdVNV/38DIlQa/bN1G8udidIaYMf1wiO5xUeHx2tk?=
 =?us-ascii?Q?jOWn/u4hbjRbG0A9zU+4MVzGDlx3mLYLhdlPwYmVElcVFLJ5jN/DwAhjFfVh?=
 =?us-ascii?Q?g0jEyDTUzCfRFdizr5IzbslT5zvQ6xXB3lAHzCO2p4Wf/z1l53MAtuSJa4Ar?=
 =?us-ascii?Q?QCNc4QFd7mqHnTw4aCpqZ8SjEVS+J6wDB2v5oEaha93eS4AMh0gSQn5kpgVH?=
 =?us-ascii?Q?CDcJqQoz9bTwgMsEv46U/kL4F4ZE8wHvNCJVdx8H7oQ7B0pKZHkT5+mw/nPD?=
 =?us-ascii?Q?C4L1c7K5H+U3RHYDFBXi41pQQZOqHLn8dTrZEkvTnI7myZjyGvCgX+x3OdGA?=
 =?us-ascii?Q?i1LGUvxKdy+ZckEsWbvkI2h2vVhrxaiTi4SIE8FQHk4tVidklO6BxfuOcdjC?=
 =?us-ascii?Q?5oeyEq/ZpMH+Kr4+XGzzaBer+rF9CcStGB3K68SGsN1RR856cJi9yEdsdm9h?=
 =?us-ascii?Q?8f8fn/4pmLgfuNTRc7GlUh8NGgmkEovmMYeXCl8tTQdL0uCfS45SZgBO8F7J?=
 =?us-ascii?Q?fZ/yoL0k2b9ZEsLweeRfMPvWHrYQBu263OpMKunjlC/G6ovvmwmMqox1XV3S?=
 =?us-ascii?Q?m1gmcqAdiNLpjvVpxyVUJ7oMd2SEbVVzq9vT4iMb//3eK8h0zHaaX+Z+wQTS?=
 =?us-ascii?Q?2iFcG1W1i2bGd+XZJt02oog2TiEHeBi7w1HUMkppTHcJH2T6OoB0mUQdUJDV?=
 =?us-ascii?Q?ZkS8ccLQL5Gh2KHjp3Sc7pofWRzi5cM4X8lF4ZHZHWIblrcE0pgez/g/yBed?=
 =?us-ascii?Q?zGlfL4oJduZVK0Ukznw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 11:02:01.1931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cf6ced-8208-4117-7c63-08ddff479de6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838

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

...
Changes in V2:
 - Update the allOf condition in Patch 2/4.

sheetal (4):
  dt-bindings: dma: Update ADMA bindings for tegra264
  dt-bindings: sound: Update ADMAIF bindings for tegra264
  dt-bindings: interrupt-controller: arm,gic: Add tegra264-agic
  arm64: tegra: Add tegra264 audio support

 .../bindings/dma/nvidia,tegra210-adma.yaml    |   15 +-
 .../interrupt-controller/arm,gic.yaml         |    1 +
 .../sound/nvidia,tegra210-admaif.yaml         |  106 +-
 .../arm64/boot/dts/nvidia/tegra264-p3971.dtsi |  106 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 3190 +++++++++++++++++
 5 files changed, 3377 insertions(+), 41 deletions(-)

-- 
2.34.1


