Return-Path: <dmaengine+bounces-4136-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E52C8A13E43
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 16:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128FC3AD7D0
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D3122CBCF;
	Thu, 16 Jan 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sTbjerI4"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C15022CA1C;
	Thu, 16 Jan 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042802; cv=fail; b=aOyZxyt4lS+7aNdEzjmZvE5LDICW+tKmWZyPnCfvRErHYFecyF2JjsNAeCC+mgcy8aIyIz6HtlIw4hwu6vNbyXwwHD9gr/q5A3hOBP2QqABfDo1bMdYqqFlMrIY9ZwxTY0mSFoFbWAmvDg2Iazh6n9QZWJqPy6TNJJJC4cKQAX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042802; c=relaxed/simple;
	bh=dqgkvWXQLmDMydkSvzijtm1qTQa/5bZSt9JXPSYZctg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Md6aSF0m0zGdE41iJxmGqCdjxGC3fl8fh/UXKE88rGYpuCvhrYo3w7NtmhcAm1bmVO4kLQpsGbrJylSNq4upbSjg2+9pvfU+n4Q5pKpAU7DFUSCXr9iaFDnoUwp63nF/S/1Mua7d1v+pUQJ+IY8GG5d/5M33H6pOHyxZsm/KUpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sTbjerI4; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GS3RG7BRz3eeVDtOq/xNfvWKPwdylcDYwvvn2lpui6j09D5Edv3lN7IbYqjZPwwbXJx43QXx0v4SvtAdm8DDwuqDtjgmrOO+RcnJGuz61M7Qc2znBIK+gfh1XMDXPIPiaA4JVC2yPNetj8MdX5W1dfftgJ+8og5juB1ZyK51AaKqvb7rdmgHXIbd+2Fy5C3z6gWuc7QrkSmgR/Fx45LgPpLoAsmJhrJ7L2uSc713RV4ZJ9vIgrL+cLhuDIKj8AsUw/m+UmiWBAAM+0fBt9D8qBKr9l2d4AKil8sf7xFRWOBJy1g89SlAFgqbdj4w0qTSOLKQoAySt9Um3Xnpslb/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxAMgbrY0WbwH9NZrpiSAJAJjhMTw3MQju+feRChkKE=;
 b=DplKFneZi0x5LbHsNrPuhpThdEDpTNZ1ZJp2eayjswuOI/1PvJYQI+Gy8Q9+Cpmv8FIFuzvbe3g7q7Vv+MIW35ztc6ksbI/FxDhGNQ30agghZjtM4/PFISPFM7i0DxnaFdE1Z0v8LedK9mUMU3AIvFnVnOhTiNQu2/aIcXl+YqwK96/JijFUog2vGFP0g+RlvpmF9YzA1/nH8mjrfegneQVFGxXu+fWoVAZgty3CCkklypHINTtddSM8MsvREJLJT/NgIgTRZnUXlgiKA3Zy9re3YAUI654brgNUephgPVS4Vls8iprU46xPv4RZgy8dKedXpuBVOq82BiGvHmecBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxAMgbrY0WbwH9NZrpiSAJAJjhMTw3MQju+feRChkKE=;
 b=sTbjerI4dtr+4g/Rz7DmleP4lyQdgrsZ0mdZtQMAJRfNkCKEa+Zo9B8c6SdCvCum/kqmqazImr+SrJrJ/SWJ9MvZDV/Af07P/e1bXPHW44rn4onUoUpvM+x5xAs9RqfQVvfxb78IOoImtiOgtuj2OV9beM/JlGN7EpWgevaIcXPbaPI0VhGxKQBXOOkQ7bqC2TX+sEPlG92779sFeUqmHbA2xVqFupvVbs2SIaNltzglKEBtZevMgBieO6BkTbs2c0PRQliigT0mV6eESF/tk9VxAyUMWBMOUtFXRxSsiJeIdmqD0tmT9o2QcP3w9ESvavc13TeFBZv2CXxFge+qdQ==
Received: from PH8PR05CA0008.namprd05.prod.outlook.com (2603:10b6:510:2cc::19)
 by IA1PR12MB8335.namprd12.prod.outlook.com (2603:10b6:208:3fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Thu, 16 Jan
 2025 15:53:17 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::23) by PH8PR05CA0008.outlook.office365.com
 (2603:10b6:510:2cc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.7 via Frontend Transport; Thu,
 16 Jan 2025 15:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 15:53:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 07:52:54 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 07:52:54 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 Jan 2025 07:52:52 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>
Subject: [PATCH v2 0/2] Tegra ADMA fixes
Date: Thu, 16 Jan 2025 21:22:18 +0530
Message-ID: <20250116155220.3896947-1-mkumard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|IA1PR12MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 8929a296-b98c-4707-f2f0-08dd3645e38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UgmYkwdpm1/LNwoPDKkM71tVRvQ91IbCcHaB3YnXq2/ArP632cs5aMknDJtP?=
 =?us-ascii?Q?MhfK9NgR4N861BSPu2F00cS1lvhCWoQZJHfeotcvTnb9z3tMZepLCaCbsxFN?=
 =?us-ascii?Q?akOq/tZ3FbfFF6busuPAytGQj8fxIC+xHXmNRbAC/mFcFpU0KLxo7Hh8sJyD?=
 =?us-ascii?Q?7McUtLxrm8lh7niufxpd50AMz7Twlcb1g0T4j5caGbAtmc/veSbxsJJyPlPA?=
 =?us-ascii?Q?I3hj+2FBTQup7kR0yqKNQ1DUKnuA/7oCTd4d9N3pTqtYv8SLeS+cWMkxheIe?=
 =?us-ascii?Q?geLyXrVdnWTVo79Zj17z54hDoj9+BHiCHQicMhS902jHYeQWFtnZ2qiOyjYx?=
 =?us-ascii?Q?xqWHufg8a8vBfvCwmUB0GtA2XNhMkaNoZXtBl2RBSyKfbBu/uj5VL32nHXeF?=
 =?us-ascii?Q?vtay1fkbRntnhmb4ewbYz9nuF8wD4izvVolJhJ501A5ymjb+6o//PQ3Kaavs?=
 =?us-ascii?Q?u+nJX+mdjs+cVZGqNuwwCrWoMcI/+biV5PYE5+wFnwJQWPgF3ZV7ZDhfaYZ5?=
 =?us-ascii?Q?dhu1Sd8IBFNpgY1Xx7YGtL9wXvl88M8Nxhxn4VSgcNu5JIZdvIbZ58CHeMug?=
 =?us-ascii?Q?qFt3d/9r0nuMONzX32/88tPYZu9vEFwSEK2F9RfdljwWqBw1xUX7I9Af8orZ?=
 =?us-ascii?Q?FGPCRzePuPMH+uW+mAhcgE8HmbKYpZbOrlKDH87+UcT/9VIu7udhio7c84F7?=
 =?us-ascii?Q?OODhZxPnsw+95kq+N97mB0eAhtLovP0Gs6V4L4Tva3hCFyKXWPIBnGTHt4Y9?=
 =?us-ascii?Q?iD8qtiJwLHT7ffNHP3lMmFkQ6WJpy0QpswC27lxDJ5wbBLnGh4wF72TIKILw?=
 =?us-ascii?Q?wHvaux26gV0reSFefjT4GxRID1tnmFwWG4FfHY2eFkILe3+8TT3CvILra6To?=
 =?us-ascii?Q?u6bpg9IQ2CNgKkaaJhVI0CpxUGHm/FGrrynKYc3E3mHZLjOG6TkR2DnVME+Y?=
 =?us-ascii?Q?EYBS6MDqZW1eW41dMSH4mB7dLhq6jHt21eq/jHZtAuIP8bolp56JjCvwqNjG?=
 =?us-ascii?Q?q3CoM7xgGPywYwUywPkrMvLE2QN663fHVRnQ37rtfSH3B5Wg5QlmqDxHjnBc?=
 =?us-ascii?Q?pvNBDrynSq8/6toDlYJ+ng+lDablaV8ZiWrNPOfcUnZCnI02EunJqxBsdFIV?=
 =?us-ascii?Q?7/G6E6gsFVeFbaxb77Q3p3uR/UcM3iPVMCknzJlZmABWbiAUswsqyYesgD6W?=
 =?us-ascii?Q?h9dJ8F4OKTcgeKU8PbOXIob/u3zUCvXIRcVBTDnskZlOdv2OqQW8d9SGN3OU?=
 =?us-ascii?Q?bT0mrned1tW+FHqwXxVZPEYU3KLRQzd99o9GcB3pjVmH4a7ef1O180jVGpFc?=
 =?us-ascii?Q?Dk/d/OE1JUNvfySNa31fzae4fVbGHlpAt4xN8CQLzMHMo2+SegNzwKQNuU7L?=
 =?us-ascii?Q?9NEVCQHaQIyV35XEf45TKpD6xY9NQToIwflzRRWIa46Exrw7Qt0Y8Pn9bkOH?=
 =?us-ascii?Q?MtlMVbdgnEPwZBMuYNzUUoEltWE2MLChjVg0BLNOQ9v4FPZvupTwK0v9RUy/?=
 =?us-ascii?Q?zzT6Ft9Vr9eFov8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:53:15.3577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8929a296-b98c-4707-f2f0-08dd3645e38f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8335

- Fix build error due to 64-by-32 division
- Additional check for adma max page

Mohan Kumar D (2):
  dmaengine: tegra210-adma: Fix build error due to 64-by-32 division
  dmaengine: tegra210-adma: check for adma max page

 drivers/dma/tegra210-adma.c                  | 19 ++++++++++++++++---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c |  2 +-
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.25.1


