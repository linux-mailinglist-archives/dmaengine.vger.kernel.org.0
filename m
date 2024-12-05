Return-Path: <dmaengine+bounces-3905-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2387E9E5904
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 15:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B1E1679EA
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C84721C18A;
	Thu,  5 Dec 2024 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sULmI7pi"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF255218853;
	Thu,  5 Dec 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410770; cv=fail; b=aAWi8Od5aaSmR42o0FRAfTwdGQOnPro78CAT0qZl+tTwx/YSq1qtIRbsk53k9nj6lZ+vOrfZTxZtiCgKHDCFIlNReug8yHBGFOx0wWEhGNrpM4PfPXXjjIjEjGTUjEEfWSQQ0lBFWjWg4ejlzZF8hsrtazNvf2nkIVAHrhMTAZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410770; c=relaxed/simple;
	bh=Wm8a8iYs8mugx9s4X9EgjsYB1UgK+Bn9Hgs/7Q7l0jo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ULjxff+BcuapOT85TQjnBOi8M/M9nFwEGCSp1+N/sbFvrwL/Ju7QuXM21L1fLbFTw3bmnpvM421LJhEiIbuZ3IZsWorHklHLXHfvPz37hSnL7DTEbjDtv/5t9rFNDT4JNR4xcSLQVCYBl19w8IvFRW3KvYUiX8sj/XMZI9IIooA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sULmI7pi; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7X7ShzXsfgexYW4Ng0q61nZIfnpEoc4bKP45roh+A/v8Vp3y2ACXwjU1oiFgV5aE3Rgw3eNYcqOAVgAnkSovTt/3vX/OoCXh4cvZhBzH32XGcYCwadOXpMYUBeGDLyQdotyXpntOxBewkjmHPp25KVKe2MkNXMjpMc3ssdlmG2ElOZlkI6DTn8TUhXno11dK5cuezGnCSsAhGcpX4WuaHnPJc8txhoaxo62fLuIixLR8B7pw08gn4088yNGzupowzJVKleYx9okCPFaKxu7LsJ2FdGvjxYycZcaCl1kdIGPcZRmnbgfI7edNdYql57NpG2UnwdXzJsQwsHMTdQfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaiYb8wdFwSILgp/Qv3FWlA/4qKoedxZ/sXwKHNLR2E=;
 b=NFKVWjwS0+YMgD3H3nqpoTNbyBtCoETUA8tgUfeZMtDyLMFjZNwOeISPz1fIYqeobl4/r1FkFpy8Pno9Gl4LFaEtWZgAqNUef6c2nHsrm0r5ko5XU6QMvtxSUF5Bq2H8zKrWYGJgv7aDqvgaPzQCmTAVG/WO92NpSu08F6ViuFGXBaIXsVuLguzdSaDV0zJYRC80DvwVwwm4ckxz63mOUfHDsT+HBhfRMQUuoWagSLU3AiAi9Mzk39Idv7pJaMLiaeuNsyqRQptbvF7Ft4AuYdOOEEKfmVoMwpcJlnEi9VARMAreFPNvn3kNf3cpu6bw5gEAnLwCoVnUaCbSRXr6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaiYb8wdFwSILgp/Qv3FWlA/4qKoedxZ/sXwKHNLR2E=;
 b=sULmI7piQNCuxSqpczBm/EoV7yxwj5X4A+0A8oogu36f0Mff19NIhsovwyzPAjsTGmm7dXL1eETQryCFQqzEBlZY17765qNWH2YJoRc0si+tHRAh/l/LLQR/TTBUtTHeg+sIf6w0d3ja1XxlDCSbO+mHmUHE6Gi2venIcdpsJwbq1E4RxLmuBzHAG9dQyyE80jkcAW19CVlcQxB9afB8xbZEBXOwLHiDIX+kKwdBdbV995w7Bj5v8EN4+aNq5tOR9YoyTP2JRo+Ao1qqquxPuqVTdxQAffC+GiixcpGCFE1RkafoWAZiN/W5oI9sMSuhc+KtfPzQpdwwqrasNC1KHg==
Received: from SJ0PR13CA0210.namprd13.prod.outlook.com (2603:10b6:a03:2c3::35)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 14:59:20 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::64) by SJ0PR13CA0210.outlook.office365.com
 (2603:10b6:a03:2c3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Thu, 5
 Dec 2024 14:59:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.1 via Frontend Transport; Thu, 5 Dec 2024 14:59:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 06:59:08 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Dec 2024 06:59:07 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Dec 2024 06:59:04 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <spujar@nvidia.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>
Subject: [PATCH 0/2] Add Tegra ADMA channel page support
Date: Thu, 5 Dec 2024 20:28:57 +0530
Message-ID: <20241205145859.2331691-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e56f578-9261-4622-ded1-08dd153d6637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7iHWrjnpjovxwlex5eVOlj4MzI+0OhCz6DQhDluGdiRJod0jruZn8ihfSxh1?=
 =?us-ascii?Q?F6djixG3euc8zksn+WoH5SzmFCXTLMdtgvHRJ+Cy2xavbXeRi+aDTkcsanEg?=
 =?us-ascii?Q?R39ZrolpqvMhK8mIXxN1j+YP6wRZVUJemFnjREBCcywbmCAfaohDwqRfSUKu?=
 =?us-ascii?Q?UbVjtd8NYWwllDj4ih6PPKs4fn+C4PUfZaKUKotx8FfR0q57+vfEjrFdqgG+?=
 =?us-ascii?Q?rx3w3K1fLj1lv6eAmejYm5DoR+NK5I3OlYv3r1E/WbxCqDOgGsQStS7YP3WV?=
 =?us-ascii?Q?JV6XXaBq/q4BQCwxO6GMvAwWXf2FjwOU/6yYD2bESN5vcIytYn65ml1i+rxl?=
 =?us-ascii?Q?cGJUWsErU9pJZMms4gRwhh4YifsQzv2mIogGRgMN9ARsoGsJmST4VxyFWGjN?=
 =?us-ascii?Q?OMT/l9Na1c4S/ofYcfU7ywFsg/TzoQ+UTx5yH15+Ct9qKxwQYfNtciyEITcz?=
 =?us-ascii?Q?3o0KMI64cjbcSIS5QQr6SAoVADzRWMmivd7JNM92z2bGQDFdWTKAb0FjQs4O?=
 =?us-ascii?Q?eiWPztKud0kA6FJ8pvG1/RvhLIR9TKWB9EYmxYzT0hXLpIze8hN8i0agDkYU?=
 =?us-ascii?Q?aeWKu1oLU3PMUJ1EXALMkLdwIyCQnqJEXeNDpaiwArAB4MeyG3yGGt939IUL?=
 =?us-ascii?Q?3pf5oOVUdsLrn9zODtA0HDRCBpxs3yfXaQAkMtMFcUqURh0i2Xs0nVYNvh1l?=
 =?us-ascii?Q?Ji9vFDIiaGSmDZc+ULEI362h+FIUwzHgnudFbcyOJchzXr8V6yvcHKVFH6UI?=
 =?us-ascii?Q?8HueF3OztfqCWZegXVzbPvpM201CXbx7tuvLLyKBwqinUHqO5GC4hqOXfWRR?=
 =?us-ascii?Q?ys+y3czFTLN1uI9OQ11HcTmkJz71NiW9jjfCHf80/XED35taOVNGCy1y0lAT?=
 =?us-ascii?Q?rmN1zIRbGjt1nsRj3IA1zVWxDs10EW2aD/w6eVIYx+OQcKWeVftcTZggi/0u?=
 =?us-ascii?Q?Y96u6US/s4Lx3va49anHvqlG+HqA7aebK2Bg4eRa8GA045TPG/3P9yH0LUX5?=
 =?us-ascii?Q?gHT3ErBzKivwpXqy1j4iOsvEVcp5g3WBpVPXExV3z3z3NM/Xtq6tU0pJ3aFB?=
 =?us-ascii?Q?v2n77w0DW/taWJyOLj8MASIq5a4kupbdmbZ69GOMYaOPgUoYihVImkaLtGVC?=
 =?us-ascii?Q?UfGwehgHDw6wcB+W58CV3HBxDkCybpAmNMIuG32RGwqLuieyHXIYUFCF4KiA?=
 =?us-ascii?Q?a0NYLSbLj3uxIFVsZl3VBlRWRFM8MIzQ9YV8M3TI+LTasMg5B4NRIobswQA6?=
 =?us-ascii?Q?HyK50rQSmVMi7IuyHG89OdD1xkbih6vMYeBPzCui3c71cC2qWYQGwcJbAUby?=
 =?us-ascii?Q?H64ckPjjB/L0WksN/1/bvM2JetPsYhJlsBRPY5KMi7d0gzSdMtb74n/VMVkA?=
 =?us-ascii?Q?MF2Hj37B9G6G7xHwkP5gxjXJB1m7mHPt+8Tz93k6Y4NFAEFpOGkKHezMHdgw?=
 =?us-ascii?Q?z7atQUQPbWYXCjSI/VUMes0w/nS23MTK?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:59:20.8291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e56f578-9261-4622-ded1-08dd153d6637
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172

Multiple ADMA Channel page hardware support has been added from
TEGRA186 and onwards. Add channel page handling support in the tegra
adma driver


Mohan Kumar D (2):
  dt-bindings: dma: Support channel page to nvidia,tegra210-adma
  dmaengine: tegra210-adma: Support channel page

 .../bindings/dma/nvidia,tegra210-adma.yaml    | 19 +++-
 drivers/dma/tegra210-adma.c                   | 86 ++++++++++++++++---
 2 files changed, 94 insertions(+), 11 deletions(-)

-- 
2.25.1


