Return-Path: <dmaengine+bounces-2078-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0708C9D1D
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 14:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C69FDB2271B
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 12:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392C25577C;
	Mon, 20 May 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dixOGuBY"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6AB548F7;
	Mon, 20 May 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716207861; cv=fail; b=eWQwoVWV34XRorgRvhppar/CuhVssuzeB5jAVuxVZ00qbUPHRVakyv7Yp2zek3hIiJA1uAy0y/xpiqy9p67vEqiW/tjUj2hY85Q064CapWVvmbg0XBIKZ3XhT8uC2fKeOZBBhQKCVFv03nWGnMOont/u9gYNsxeRDxQnf7rhK94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716207861; c=relaxed/simple;
	bh=DEXsZmSeo58xCvMWzPm/DrxUDoqwSDplm9/r5QtI1j4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F0K1TblI5R5Q7xRbSFSBwohnDAYSFq4k23XDakSad7Lj68kWuCGaf4gl7SzvBPPAbvDHYJs7pH+SpDWCCGchUEm12R5YkdSPoKS/f53PZtvaMLZwKGH7E+CGxFjBRkbyVVPAGNFSjSARZwLlPGwyre2DS/vd9dexDquKXywdIcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dixOGuBY; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/PA97WOujVHmXIqU7GVuTpExftAU5grwQJqmy7SVbGBTEDxkBYVTSTFjoH4EzqD+4Y3RYhUhSJn0txppcOH23bSzpdTEGZCSQ6ywtE5TsOMkzgxc8A5YQzV9UlL8yLY//bwCU0NecSzYntpCpyfHMTKIOMrmy7T6dF4aZwny42l8tFa++279Pg3IiPR4xPF/2CHDEB0o2IEENHpGRBM6tTj66Ox36PCuoO+ytzoIefkU7s9+tM2PF3ENSiAxul5/lYrEN7kEqIaeiiauHi0rw+Gpz1zVZ7F/eELwGLYJ7gZewGzyyrM+7cVD5e2apMUCUd5fhzkWAhNlO0URjnDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJXd25h0NH+4MRShVKC+Gk9crFEOq9qqIX3UWMD9U1Y=;
 b=jyRDPpkM5aNLSetPiIaA84/zXGNbWSXftUQ99gnAipNPxvFqItQnTudvbTkNBAQY70eon79lyLaDo3ljholcchVc6bN3Zmviyok32aSvVWfrvejxQ3dtP2sjCYitvGLckTsos3e5zUoklErZYVXqaTkY6Ar6X00+u/QnXjqrVjFxSK665KydtXi4ZntoPGhBKcJM4TPpalQE8Qu+YchBPc3c/3ZUDPB2AtxcvsVdhkuuOyNytGJo+WEM4jUgxvp3JrVxeRTHdHCs/uMaDWD9v73Tq9h1bdHVcRgU9jHfWcwEvNIzJuIfSHq8kPLighMo7o9ztr9d1MHizMyjmzYVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJXd25h0NH+4MRShVKC+Gk9crFEOq9qqIX3UWMD9U1Y=;
 b=dixOGuBYWHxxrke2wXLB2ZAdAxnDQqPq/pk5QtGSQ3rP7gatC/0oVudyyWNm0H1dXMFuh0F1yBu2NTgKjoSYDiEj+RUOKL4hM9M2oDGRGGInFihqyB8CzO3BLXmWedvLgrgoov7/gOSex2c5qm13zflwVcxLgToevJBbK3wqZMGmaL2tY54zuyV9h4c6DGWV8MSzan6ukPnbPbW9c6AmxB6ZPOW52UiGd1vs0j/cdIaTxkakQlPWEYm+8oObYPddKQk1NP3q9C60Ab9/1w+Vy/27bz+Ajv23ObKymESHkXkUHEDW00X3+56rJmSt1YKd6OEL0Dmo+5RyS/C399Kdkw==
Received: from DS7PR03CA0345.namprd03.prod.outlook.com (2603:10b6:8:55::29) by
 SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Mon, 20 May 2024 12:24:16 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::ef) by DS7PR03CA0345.outlook.office365.com
 (2603:10b6:8:55::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34 via Frontend
 Transport; Mon, 20 May 2024 12:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Mon, 20 May 2024 12:24:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 05:24:01 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 05:24:00 -0700
Received: from build-spujar-20240506T080629452.internal (10.127.8.9) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Mon, 20 May 2024 05:24:00 -0700
From: Sameer Pujar <spujar@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>,
	<dmaengine@vger.kernel.org>
CC: <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mkumard@nvidia.com>, <spujar@nvidia.com>,
	<ldewangan@nvidia.com>
Subject: [PATCH 0/2] Virtualization support for Tegra ADMA
Date: Mon, 20 May 2024 12:23:49 +0000
Message-ID: <20240520122351.1691058-1-spujar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 7572be15-2d30-4249-89ec-08dc78c7c41e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CZQ39v+/Fr3wDHxwgymnfXMOrYNQZwerfiFioXz6NV+5dLN5zL3AoklShrPl?=
 =?us-ascii?Q?zsNONmIIreL3pf8XpWrdPoyO8Ll29Nrs+mClba/aONG4Q2D1XT3FRT+9RWic?=
 =?us-ascii?Q?rELx9tWRHmEJoRC7qy4XgPk7Ah7X7Jvcq/OiUAQ1ggzRVJdq1p7qLL+qLHDc?=
 =?us-ascii?Q?YtoRxbx+Aj4x96dAGaCNxg/HNpTcULG2PiyOme4CFlAhftAROKPIdC0ABVAw?=
 =?us-ascii?Q?eb63TgLTt8D9wiBnwBgtd+6bmLoeJC22oUvCvfsqxJgQfjobklwXmiHs5vwL?=
 =?us-ascii?Q?59UJx9glvAEKBXAh+jIy/k37VNj7eVuSZknNlbhdFQw44KF6t1Ggoe3z1Hd7?=
 =?us-ascii?Q?k/bHmaQYoIupV/umNQ9STtaOey5JgoZ9d7AXYebwczesw0dWxgyVeBbeBvn5?=
 =?us-ascii?Q?NgLuGFLmV+/DPbol+T5l8fzY8bnyKkDEDFT76JaJHGB9wrqKZJrbC+ZZmdMY?=
 =?us-ascii?Q?aAJ6Q0+PlA5VWrqEbA4XjV4vZzfIkcdzZg4pQ63W1KbVjDBx3wsP+IWD/zV4?=
 =?us-ascii?Q?Ys62eeO9AD4oVlkOUFDU/tMKghH+StvyujONLM250IpajhiUOs9mbugwTIbh?=
 =?us-ascii?Q?cqZeM+MDBZmo5mp/UCXkGbc1/MW4mcOlbHHHnt4K6j2d8Ys7EHnEb/evSbMo?=
 =?us-ascii?Q?cLfdk9Pkm6lJuadFR11LvqEOIHBoEKa2EDgHPI7wyWWhBkyLcejhrNA4Vnz+?=
 =?us-ascii?Q?/RaF3IwGD8+QJyNt+U3MK70UMuJPU8BHzjSOjDK3EBn0nZtVnnGsLdsFV+io?=
 =?us-ascii?Q?oZo/ceHM75c1pN7lmw26IEJuZdyI3jMQ5DgcYdUN0laZJDR+KeK7hJ+3ABqy?=
 =?us-ascii?Q?0A5SF3jqYjjEPlGaG7HsY7+6uhHwDjRHN+BaJ9X2/z/eSc6dTu/Duei0gpe/?=
 =?us-ascii?Q?eUfczEAvEDL8JrS6KJvPaS9F5Zkm0dN3pl2jOHbud+ltNrVgaHw2Z0HvzMyx?=
 =?us-ascii?Q?7OJnGx7PJcOM8JffvuUFB1FrvDOk7L2p27N0BQEWJQEo6fPoqcqNwOyecs/T?=
 =?us-ascii?Q?LqoGoek1pBUQeR4/m1i65jQs/dRyv7gSLgsApOoy0oMXZ0PtmEQU56yHbLvv?=
 =?us-ascii?Q?92tmMzvLMGWGSbYA5zqkH3pwtWggcz/oA0+W8PJFbDuSJj4JedLwdfu8/OcV?=
 =?us-ascii?Q?DBPqel+H9m48ltOVvcmUpA5w0a03c2Tg535IepI+8+rA44QWR97x5xLNaT11?=
 =?us-ascii?Q?jDGtdt3CL17EGDcgLYeiwwdtll9LG7DVbc33wDMgFz9wqNXaPnEUU9JU5CCa?=
 =?us-ascii?Q?q4S+GXm4Q4LCaa9GFPs5kCfZomGvQkfCE2NtviyUbpjK9mZXmxrerIiC95mY?=
 =?us-ascii?Q?YsfzoT1x0I6UnegTrL4Rl2/2kN94Pi+9uuWGL8TDbf54vzX2lCJlYuxSpoJj?=
 =?us-ascii?Q?sroAQhy/qvc4Rtr8OddUWQG+AYkf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 12:24:16.2706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7572be15-2d30-4249-89ec-08dc78c7c41e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178

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


