Return-Path: <dmaengine+bounces-2121-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFDB8CAD18
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 13:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E83C1F22F53
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 11:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E22745FD;
	Tue, 21 May 2024 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PiiW/HIy"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9419C3BB4D;
	Tue, 21 May 2024 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289754; cv=fail; b=S7D3bFUSod45NeoYq/5J/EVeF/deZ+VhQpVkLBXDmZXcPZ+JXd0v61wgAVdXkMlMpVnKLDc4tghuu8oBR3MGP+aSEJ86mrsxES+to2EVXldn2p0PxftVEiM1haN+OBMij+oOKXDExcdDa6iEC4pDXvkU5ZKBka8gt5yMndnMygw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289754; c=relaxed/simple;
	bh=DEXsZmSeo58xCvMWzPm/DrxUDoqwSDplm9/r5QtI1j4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MZubcD9tlqlA4oQFpj30e5OEUzm9Fyjv/yC/odojerIQmBTGXwNLLg+ftuTCicmawBXyT+rK/6A7aFeFK67UX0oHtJXTda/ZG5YKznzcGBbHYud2P3sf0opdXTy9keWUvMvUsY1MFf9OsP2pYMIsUPOfHltlzle9IvqIgfv4Odk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PiiW/HIy; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrRjzVFi0tt2xWiLW2/b463x7yW2TN5Lomm+y7B19TjPfeJ2JEdabhMYOsgQebyCCO50vypdwWOLFI/m6I2dM8enwafz7JxHUHVkGIIwtLsNvboWxrvy+afAEEo6IXnHHUEm50opVzMUEqxFkhUUS4W89zu0hInZh49yDwWEfSZ1YSINCTFlq/DxkyiSgeLIQgqgzPMmgxL9JJAr1z/X4+o9+kzHZyGUz4lyByqhC2qIPb8hTlTFsIj2zILRDKKeSfL6hT+AGCSUuFWOd4SQKkt73cyHlcjh5KZlOkvf5Hjlmc5WRXbWnEpHvGHgwgeVd13VVcouM/OVJsUWF03Jdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJXd25h0NH+4MRShVKC+Gk9crFEOq9qqIX3UWMD9U1Y=;
 b=db5nH5oEWGZFjGGsbm8T4ak1bRMJeSNxILDey5fMSEKtBzfDB+4qGfMKYROOpjWCMZkG7K90IsP/XS91Jap2zV11sXmGTSQ2TMWSU38/6Zg6/9on5BTnbNDkJwwrJn4Vf3/FLQqNiY3GTlzeDgEaPr2RtIQlpXzrxionMClk6i/hbvu8HtaiTIET8pdnPCOC27lyfe13biN+tm5sDjZdYFDy61Thwdvc0CD2M8I6yMkAW5nwIuekbB6xeQd+pyQg4UBP8COV312TkN9nOQyGWREiveNeBqwnDZr8c0/Y7GRj8SutFRRrnabYFRYkr+RZxyqjv01ClK4WsVx6MkAQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJXd25h0NH+4MRShVKC+Gk9crFEOq9qqIX3UWMD9U1Y=;
 b=PiiW/HIy5TBRyWDRzU6gyjVdxzY60c66trsh2ENwlzDq2QET/hi8z2f5Rp9XJBtZOK949BscY9+74O68k65rJ6TBqbyg9CIKPKaH/EmMXmRdHMsV9Gt0c9obME6L2NKlGbhvFCaTLu9xk7f5PfYKVIYWeL2T1vXbUKM+XGVaxMgpOGuhtTVciIPh1Gejlrid10sfVUV8AxAssqYt9PD4PiUp+QW70Q/I6TCXfvJ68Crnp2uvplveCpaXLROPf4d22b/QvyNwDJEsqw2w5ufqdv33p++4fZHE6omPvoRPG78OzwooeRztaux90lWEDCzt+P0co/V0cUv7hvsd8rHqlg==
Received: from PH0P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::10)
 by DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 11:09:07 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::87) by PH0P220CA0027.outlook.office365.com
 (2603:10b6:510:d3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Tue, 21 May 2024 11:09:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 11:09:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 May
 2024 04:08:52 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 May
 2024 04:08:52 -0700
Received: from build-spujar-20240506T080629452.internal (10.127.8.9) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Tue, 21 May 2024 04:08:52 -0700
From: Sameer Pujar <spujar@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ldewangan@nvidia.com>, <mkumard@nvidia.com>, <spujar@nvidia.com>
Subject: [RESEND PATCH 0/2] Virtualization support for Tegra ADMA
Date: Tue, 21 May 2024 11:07:59 +0000
Message-ID: <20240521110801.1692582-1-spujar@nvidia.com>
X-Mailer: git-send-email 2.45.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DS0PR12MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f25bb8-ed38-43b5-7091-08dc79866edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JHCOGC/pWj2OUVK155EWkAhc/2kr3y3YZ/JZhZQIExOEMop7TVrHZAHmDflR?=
 =?us-ascii?Q?xXCkEV4oO6GEqMEaHYGMQ2ITzMp5HeK12XS1CoRfNsTH7hWUUYIv+WlIkpBE?=
 =?us-ascii?Q?Rh6FgumkM8QY/hV1RutjkG1qY+ktgTopZHbLc4ECSdgwDfGjMaFLUz9bmVNO?=
 =?us-ascii?Q?iczIAS4cA2c6IiriNeEBKvFrd1aVO+JkavZ42bodPfzKdtcKGgCRZ8pct3q/?=
 =?us-ascii?Q?dcobaLwoS3EOt+iMJs3GqJvsnMyTLmf5QAbzptYwRtdPnz8JQMcRHjIDJogU?=
 =?us-ascii?Q?EZUy0CRP1RYOxHvy7Ox1vfhAIELXMKkwRuFWDALEzJEYF8jtL5J84x8KW2IY?=
 =?us-ascii?Q?UOuL9rd+GeomihpvmNSWHh9U82p9+frP7ytbQkE1wiprMgzuu6geO0SAvrvA?=
 =?us-ascii?Q?/R3kFn+uvNIlwTdfc7vCQdELSgOE5jw4rEYdAXWuWBC+bRSW1/HJnLW9STNf?=
 =?us-ascii?Q?0UQWNpbXK/WWA4Nb8Z5b/dsHcPbeSSL3L24mV1oVSp3nVOddkLHi6R4VRiTK?=
 =?us-ascii?Q?7MJqYNuxAmoL5PTAq9bBL0ZkNerzF1haKz7ohzLGc41Xcj8jBRkcxMIX8C/F?=
 =?us-ascii?Q?oRRbVdIqpUBnBb3qSUjE/jr84HgFyFO0oVqXaGeEDTDoqqnMg5GW4LFQg7W0?=
 =?us-ascii?Q?O9ros3ODwGx4W1XBhV4TAVONDqA3zKpKOXjYwHjN1D3/DCtzTgknAUfhSUbY?=
 =?us-ascii?Q?CpSQRurB2UVS4JQ8Pfl0xo3UaXKqS+mlwMN8Xj5r+t7whuLRH3vwtG0Jtt9W?=
 =?us-ascii?Q?S3uNUtdlW4jo1w9VS+WKMF+/X4sJ2vOXP17JfTzCr05jJ/2hfiSC9dHELydI?=
 =?us-ascii?Q?mtPNKkqMAO6H4Umye74QjUjqLURvbReMnJ8VCL6aDAg9B6wfdqGqbQtYd6ov?=
 =?us-ascii?Q?y6QB1fE5WSNaAARR5I36fmvl62C0N6SSW4xvFQHC0tLYfghTyU+YyYmfmkRH?=
 =?us-ascii?Q?12fQM9waSPZMiNzgUT8HVg7ML1bnMJjGAjZQuxfR5HPO9dIGtJCt9DpDSiJD?=
 =?us-ascii?Q?StQWscF/GOaQm2wsNep/IjnIQjTwByi20kWaYQRpVu0aux70xN9deAumPxqU?=
 =?us-ascii?Q?tspSlCKTzz++5J2axNpB6QF/ajuUnXtw2L79cosC+6aKOzHEwPwtqPfJHmcL?=
 =?us-ascii?Q?rLoa8DKmMh7b+xO/z8NEjl3/eDkBa+JK5sJGXoaTJVcuAnZN86YWyiyuJ+k6?=
 =?us-ascii?Q?RSipdQRBDpGM2EIEVfR4/NQry/Cn8mGP/vJKfR6LOOs0Fe4k40j72ywupkb0?=
 =?us-ascii?Q?sMunGyc4Zo+EzSULzzIvTwbSkyVbyE68Dx/rt70apVA9VTwSz0c0IiwVpLw1?=
 =?us-ascii?Q?l54bfO98CTwKksWGzLT0oUdtri1IdGmzdOyj4LBfL+7t532cUISfxptAjfKN?=
 =?us-ascii?Q?E0Sl0kMB9IJe5iY8Cpyr5obFjMwX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 11:09:07.0815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f25bb8-ed38-43b5-7091-08dc79866edb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779

From: Mohan Kumar <mkumard@nvidia.com>

Tegra ADMA HW supports multiple PAGES for virtualization, to
support virtualization
- reg-names property has been added to DT binding for the hypervisor mode.
- In hypervisor mode the ADMA global registers are not accessed by guest.

Mohan Kumar (2):
  dt-bindings: dma: Add reg-names to nvidia,tegra210-adma
  dmaengine: tegra210-adma: Add support for ADMA virtualization

 .../bindings/dma/nvidia,tegra210-adma.yaml    | 10 +++++
 drivers/dma/tegra210-adma.c                   | 44 +++++++++++++++----
 2 files changed, 46 insertions(+), 8 deletions(-)

-- 
2.45.1


