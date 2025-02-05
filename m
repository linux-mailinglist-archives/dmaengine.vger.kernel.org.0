Return-Path: <dmaengine+bounces-4280-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD6DA282DA
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 04:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9E73A5339
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 03:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB0321325D;
	Wed,  5 Feb 2025 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A7HluWw0"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D9953BE;
	Wed,  5 Feb 2025 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738726317; cv=fail; b=ZDrKeen/8RuLUPg8s+2lUABWsKaVugPnlg+kv4T+neglptv0wNb7xX8QNeOvHF2R4hQY+LJC2xzMAwo4WtyGSSUsfDsyVcq9pv6m2MZDH0vBJH2RLpTfQzSZPNFVMj5kSunuvu1lMSgVA8zf00EV+tBWeK/UtY+g40qww5VRKcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738726317; c=relaxed/simple;
	bh=YzY5KHnoPJLthgq/aXmSGFLaZuNMzbUkw4nte2CiTr4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OB2XKWOsbMsFVwzEEOtYT4a8qALoz5Ad9XBj3s7RJFvN+T8A47sGo/6o0SEkljrNzKcZ5zOogAUCoCEGl27JdFukR0rMHdBZd/TrDE1F8OLKPKjThvAJvSESSAtKPjgSr3UVCcsX//6Pf51B7whwXoK7JoxMxPKGICIZwhP+O1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A7HluWw0; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgoQPyHd5NIghJJc+KgZ1tKQPk7T7X2wYm0mrDCgRB7P+5YF4+ZNVgWN+df8+B3Ralg6ipIzZSORepe/RCR9nn2nXeL0WBNxmQxc8Rq7cLSFNc+XFJ1kGjZ7HJaQ01JxISkGJKBZpoF6aq+27140QzhAU7cuS2qjV+O0I2giCfBnjj2vgkRGFjWotQ384TCz7+HOa3e6Zr7Ok5HH2Lp8O7j8t9mxN8o3ap/48FHJ9ndAANOQO8ZnleU87Rj5Tiupz+Vi6fYYKbM0yCin0BdLUsM62FZBnCmDZQQcW7BzXK8T1SVbjvNzfUaOVdj10Jt/13kqR6glflElZmWFuMZmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDWkP5nVZzEfddPknpMfThIrKO18OKZ5K3qpJDfDWvU=;
 b=tBDQHVsVuJRWbkEZnA1WBHJ8+lMoT4rKUiCpqBrVYpu7mFUxKyI+1H8RGeZ7h8e/VEtG435eDyyjRkGQz2Ow0SzJCB/ypBG4ztf5Q0AkblUOx3fgA7rSbjgBw34pzrr09utJVagTcipBkGf7MmX0AwNtN+FFvpoQMqm18zVx2jTaOSBI05QQ+LMHRwOw24/A/x2mCYoP2G+7DZYT/+7CTCNKACGX07yDaopcvNL0BLPS28KDxpYkKwPts2T7gF0I5W/l4ffzyjZ2JlNHmTftQNgsLblwMO5aGb+hqcBkZecwQpp5BbXlW/cZU7whg2SCsxsMpagCDpm3OiU440tMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDWkP5nVZzEfddPknpMfThIrKO18OKZ5K3qpJDfDWvU=;
 b=A7HluWw0H8efOfyodxXAo1FauESYacHn/lHdz9SLQh1pGAheSnv82cC0petIPSexYxZWnMYUNsFEnRNcexrt65c8LJPt2MXd9kOAsSULcOg6ORZPWHcu/CGBjB3Z3ijrBTh3C6mvsn4UbgyNlGrJQfXoCRZtVdwqK2EhoJFd2GVKmeV4PqJP2iA3S/y/rCElDtEB90l70xKoOBktLqjPwkzLicg5dBR02ZQVUh8CjkhZMZd6E+lQBnbEyFKWYefp7zg1xPYkaIpjwWgoa0H6wUxqBwIWLlfjhZxQ7sir8RZfeQ8U9TSI+XtwTFTT49Lz/x4AXQ+G9DjIlzY9Lm2E1g==
Received: from BY3PR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:217::22)
 by SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 03:31:53 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::29) by BY3PR04CA0017.outlook.office365.com
 (2603:10b6:a03:217::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 03:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 03:31:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 19:31:36 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 19:31:36 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 4 Feb 2025 19:31:33 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>
Subject: [PATCH v4 0/2] Tegra ADMA fixes
Date: Wed, 5 Feb 2025 09:01:29 +0530
Message-ID: <20250205033131.3920801-1-mkumard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 16fb249f-3da4-4b6c-25ba-08dd4595a22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QtmblLxszBwhvDFDHkD6In+lsXTkepF8rHevtQowwWDESEKKTdonyGbUNGIr?=
 =?us-ascii?Q?wMsRrrLjmPl1hEWWiMbBHnqJ/BPS/i4kwzB0pZ14AR+6yyoHZRbg+fF41G+A?=
 =?us-ascii?Q?xmTcq6w9IqSdrWJBPDNXMXSFiI4ol1XUj4vLViczz/MAqeU71oBBjFp0T5ze?=
 =?us-ascii?Q?6fij7ovw9aqwSKh9d1mydpSbqWCuv3Y+5cMoNjBUq0UbltGp0+ZbopSiIVnR?=
 =?us-ascii?Q?EA0tkD7EmarXJqAP0lSNvuZdPPUMeC+vuscMo807Ny1KhNpNu4wteFz+r1se?=
 =?us-ascii?Q?hHaWH2D664lcqjsi4ywghW+4H5LNO/8kfX7Xb6XNUOBQek4iqWrm72HcAvHe?=
 =?us-ascii?Q?TiIFwrBOkeazWcze/tgakoSjsMpo1NoR1FPjweb6fBIB7UeDA2OigbBkhjUj?=
 =?us-ascii?Q?d9w4jGkQozgrOZzgZUVEy95fcICFLYgzNAp3ivODKz95gtK7OckZFsUMallx?=
 =?us-ascii?Q?pFwdd3wnDY3iU8VNXnv9IvvJ1uzYjBlzWQzVC6GF6UbCNs+edvs32OA66yHZ?=
 =?us-ascii?Q?iYKPrQKcykao483FwESLj4EpDMFmiNeBk+u3utVnMddwUdfttDYn9ye3uC1H?=
 =?us-ascii?Q?TJx+Fy/eojxvW8XfjZH5sCxHJIFyZhxEEDbBk7ZVzH5yIiVmJGigR0XFet+q?=
 =?us-ascii?Q?czep6TZiTGCoIDchUS3628c/cmPTFNyumfVukOK9jxOiuR0uZNoeRv4nPUz+?=
 =?us-ascii?Q?Z36WCyiiOSEadVx7f6CyFDiUjyOmWP4ZcgazhUxRYEjbVbcRGU44N6SudZbc?=
 =?us-ascii?Q?ZRSz199JYAdEFEU7ifJ38iocMtjTh7JHehEPTECmHbqY76kgOfkT0fc1zuhk?=
 =?us-ascii?Q?mYhuzylE3p0ACQYG9YdFtdtFXR7g/ZExoXPIFgVeYcsux56N5yupwj7DXmJj?=
 =?us-ascii?Q?hIoxi17PJTn1ExQ+AbClcja6z1IYmlps5xs/afoSimZd1w2X4HOKc2X2Go6N?=
 =?us-ascii?Q?SLj9rAMyVQCboqpfAc5qqfrj9fqGEABuxyAzD+pWKWioGVT5r0uinFSQlaTb?=
 =?us-ascii?Q?HMP5JwWFzyf+5JHf74x0FTxZqFxa6FKyC+oiJarxBCUFQHu+QlfWjRM/3869?=
 =?us-ascii?Q?gVPgk5s2ksjN/JCvcC8vGbcVOxgzSZ7BEOkyeNZAwm92tbGClasyYxwSdJ7e?=
 =?us-ascii?Q?fBbOH3B5jqHh/77FzjgiyvhrkQ3071t0rszKY3YAVGvk2IAWyIRJ6/usvhCx?=
 =?us-ascii?Q?n1qsVks5BiBqlEjoZK+kjsRKZnUdvTV5+AjwM8jMjhnqCG+1iPyENoMhkKyr?=
 =?us-ascii?Q?1PIoM91bmYnDxg8NvWu1Aa99VTRqUUDtk5gPde1UvoyrccP66cdLnsLsNaDI?=
 =?us-ascii?Q?ed9V3YDz9bJJ2BR4eL/ie31dTGlVbTcgHPcIU4Dvxtl9UiVfz+pxTmzrQEON?=
 =?us-ascii?Q?d2OwPBagspxd/nUXZ/gg89sI/3QhUb8HQsbrzwrbiwETl3zXnnfwxSqCp02+?=
 =?us-ascii?Q?Hbx2tSIdOP3DxTsdyNrhtn+1CH6A9L89y76svhiOfEslWKgScDLs01PbVatw?=
 =?us-ascii?Q?tLnMp2qHjUAlm5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:31:52.8383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fb249f-3da4-4b6c-25ba-08dd4595a22d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299

- Fix build error due to 64-by-32 division
- Additional check for adma max page

Mohan Kumar D (2):
  dmaengine: tegra210-adma: Fix build error due to 64-by-32 division
  dmaengine: tegra210-adma: check for adma max page

 drivers/dma/tegra210-adma.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

-- 
2.25.1


