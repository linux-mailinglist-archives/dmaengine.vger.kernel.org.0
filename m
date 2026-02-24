Return-Path: <dmaengine+bounces-9030-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K3SCRZjnWksPQQAu9opvQ
	(envelope-from <dmaengine+bounces-9030-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 09:36:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0EE183D68
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 09:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49CB93032062
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 08:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC72366827;
	Tue, 24 Feb 2026 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fHAqpCi5"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD201F30A9;
	Tue, 24 Feb 2026 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922118; cv=fail; b=B3XsTJsr3BarWT2su4ITQ355Duth+mHR1x6AZ1ROd/Hds26G4/R32p/8FhA+i2JiZqhSRt7Y/AxAHWSRncUqfrnrc9df88ZrUVQCDazITo60juExY8giURHmQhG4BnmE5YMOn1ew5fLY3LJIqENV32V6xUoW6kZy2JR1Bg3zHAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922118; c=relaxed/simple;
	bh=daDnOZujKP3brDfqHLN07i9xB4Hp+DmwSErRH0/xzDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J5Mj4JXBJN7ilH233cj0RW/VljgD3qI5WKZGq9JWr2NPtS9N44Q6kBEVcmiudSHECPUIn3n9CHlo5tnhUHHKo5TY9tztGwOFPcvlOP/Ra5SdDoDr849pvixR3APL0OHv95HDzmnKkcNiLDY2Z6JuaOiDUI5CsFZQmFtZfuXcb44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fHAqpCi5; arc=fail smtp.client-ip=52.101.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+u1a8gNmT+ufxnPKV1Pqrv7bce7qYKHgc2mP7bq4Mo18EXdOI650//z+fE3HzRN152Jllqkq/Ecv1UnU5qF8VEEUK0YRTPLGxd2xwPAUaQDA9P4Eb7gDaNyjBI25w3QGYfnMpfCiSM2GVRkQBIYqUU5dLQ60LBcTgBQARUl99sdxp1j3G3X33OSY9YkLgTUc2bAu6GvKmIJnaXLxJggEjryb0r8WZXmmdnBvRTGE+1FiSyv6AaUdGHoMc9J+g/UbYeWgE2mo2r7HN7lGm2rsDwz16EXsFq0BD7Fgvb0l5Pwb/CAEV6II4YGoPWjojGZv2wmSrfsW403auMJousHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdPlDzdlGddCOmEfz1SKeQLJqdQ626rkwDfE9ydTLb0=;
 b=ZJpfabBVF9hq97Hm3b//wdhZOfKaKymdlAlpYIO5eUJW+ECFzwsB8v8a2CxYd+TVvomRquShuKEGfllLz9SfctLVGloCQ51mCN5GtNyJlbUFUbaez1uUOueCBQydGlIr8A3WJzx7jcDHyi//fQVHj6iDJJZIrOiZnMU0S+h8IElGmJgrjPaDddxC4VpAbcMoHHfRf4O7SZ8zpHojzYtF91okfx6puDiWO60Z/gXeKKcVmoRnYPcRX5kszZ6yIGsLfPYhs+4FClMMehgvMrS8ZMH+8LwcW1uafyRHim9s4F12OPfiQ/qp000hxPXKyWS1uhdT880mZk2WdqMVi+kFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdPlDzdlGddCOmEfz1SKeQLJqdQ626rkwDfE9ydTLb0=;
 b=fHAqpCi5bhArosm3ukklFfY55KIDaObXWPm2I62QGcSKRoNhU45yh/B2DtM5zoY4ZGEOv4qXgF3z1dssdaZi14YN4SgSVhsSNuFm4BpQnkW96G4nIw4ZSnsJXwZ0VhO+WZE5yAKU8bQlaudyeUCLOJoXJVfGn55oPw0/x7i7/ez0GUDmdoz80vbJUW+CMovaMF9/3yIOgrt8jlVMH5TfS1545vNjS3325SNu2UcXGLNVL7s0AFInoFXv7nghfndBS6IDXAd6eWouRCdI2e/mdVBSibrOpBxY9LKN4b24/U3AtrmY7YM+sgOvxSn4FRAc30xOfKdpEd8FtZQH5f34fg==
Received: from PH8P220CA0037.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::9)
 by CH1PPFB21296325.namprd12.prod.outlook.com (2603:10b6:61f:fc00::620) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Tue, 24 Feb
 2026 08:35:12 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:2d9:cafe::c1) by PH8P220CA0037.outlook.office365.com
 (2603:10b6:510:2d9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 08:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 24 Feb 2026 08:35:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 00:35:02 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Feb 2026 00:35:01 -0800
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 00:34:58 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <akhilrajeev@nvidia.com>,
	<vkoul@kernel.org>, <Frank.Li@kernel.org>, <thierry.reding@kernel.org>,
	<digetx@gmail.com>, <pkunapuli@nvidia.com>, <dmaengine@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Kartik Rajput <kkartik@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH] dmaengine: tegra: Fix burst size calculation
Date: Tue, 24 Feb 2026 14:04:54 +0530
Message-ID: <20260224083455.333330-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|CH1PPFB21296325:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3f8a1a-acee-4040-4808-08de737f9f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jye+rJYElQeP1QDZK5C+DfsMRS9E6zx9z0VJSLmaY54Ee4CSNbD1Ulr4/QtY?=
 =?us-ascii?Q?2tYCjXmGC/q4LVgoT4rvkBplbcyGI9j2aQ3NWdEbtLKRJQ80bW8+XJHMHLON?=
 =?us-ascii?Q?ckqIx/DrukLaI36pWPI2JjLW3nu8R5fmJgL3VVn08SufgDydwLZiASAl7BRt?=
 =?us-ascii?Q?OBahqxebhrBRdZqme4Cd63Azc4F2vmtKllPc5/7xbpkiibwq705cxZOOAYH2?=
 =?us-ascii?Q?+IC6peMrybQ126CKG2ZbxtzsG2gAjuoNQnU/vk0jV/glCC5zhXIXpQJhNg2h?=
 =?us-ascii?Q?7nDJVRor/+MrTFsqzl42EmORmO+gDbszfE6ycfdBJIkMFg8vmf71AwLeIoN6?=
 =?us-ascii?Q?bmB9o/BYS0XkirlJe6JaE/yj2Y6GkM7lmbAy2ot0moWTnsoPXMt8Qhp+8WVG?=
 =?us-ascii?Q?9c2BDi9Y5PBrEjN+L0yTrfeto4W/TDolrY1dlSW7gENGkUeHwgQcnvS6pnro?=
 =?us-ascii?Q?kwhjXAEi5JywcrxW1AeM1YZZLejO4Kpf/a6DhMH47hIkjNWLNOOW3bPqIltm?=
 =?us-ascii?Q?YUzXkxQGRC3kYldfCTg1mCmPh+m3/EttkQOvra4iEwzhl035pHkjbfoPa0pT?=
 =?us-ascii?Q?lBDoR6CwPVSZqzejair8oys/DAJxa4fAfk3w3I8LQxTDW9Tihlf1sycyC4Rf?=
 =?us-ascii?Q?iY+RGLNGtDOKflwaEeKRJHgGwm6yVCBodWcwDoxumqFo7aT4irDO9YcFxcu/?=
 =?us-ascii?Q?WsDZiKC9eIoQTaL8uMk+iF5/duYLPFvJBMRj3uS1x8hqZ65pqKeHDQWNHS1v?=
 =?us-ascii?Q?IrqBMOke69xYtBOe0A8Rn8jHNaaA8fNSCb+1XherX+O1QVb+CBNKi4/Sz+HU?=
 =?us-ascii?Q?gTgZWKmA/icfbrnuMHAIb+tazroMqZSWijxutsqFZTXi/xEEuVMHbqdsBjAy?=
 =?us-ascii?Q?8UrwKEiMByL641UVWGCZYPVyxEydvlqkB82JxBmmuq2I9eDO/NM4rq4iuA7q?=
 =?us-ascii?Q?E8L8lmanRawYtfjA+yXgWeY6zj5D0bQU6W5kjL/M/CG0dqdMcOq/5jFmhaF/?=
 =?us-ascii?Q?WAHwSlFnIVfklLLxJpg5tvRa4yK7n7nya5jTS8ZZflccZdzWlZ8wMq+R1p2c?=
 =?us-ascii?Q?pedyO3CT5fOMP8XE8vJHMseq8yx3pVzb/EbA2bLwuOherKAK2NRik8FJui6/?=
 =?us-ascii?Q?9EksJTtq0Pd6MxHHdCTbh9v9/g0f2ra+CL0XyYCfMrvFPggXd8p37EuZ+eHu?=
 =?us-ascii?Q?nZXdrvlp888fxMh8DnAA8zsVk7PYBDofr+wcPKiW5gIpRM3tQyvqO4kx99pd?=
 =?us-ascii?Q?v2izQBCz0V55SD9Z62C3obYQvds4OPukTtXafLszrZJIeM+3WI6PFR+7arb+?=
 =?us-ascii?Q?F5DdOnsgmtAENZ+p6p9BBRvRpEAlL71EKf9aDABa5lt0OGb2z6N8yMii7aSu?=
 =?us-ascii?Q?Xc0h5PmZrvtxE0suTjdcRN/ZLXEbDx0/6NiyR9fyJFGuFeiJ6K6M+OMPSlF2?=
 =?us-ascii?Q?TRypdE7ilRcqxLN2sqMMVnKUg4q902IN58WznYO34QCMF1sTmGiE7n8a3ayy?=
 =?us-ascii?Q?kPrspx9BOTFBRKcGj/lDdosPC3Q5Yl+qDfupBb4nJ1b/+MZ6afgIUwHNNqma?=
 =?us-ascii?Q?2leBVzTZb8jSoRThhCBdfvOgDfWGFMra5W9IbTSCOYxvaeP+rFRkmNMvx40b?=
 =?us-ascii?Q?m9P4/AU9xD/gRO40a7CwBrNZqbGuNqbpMv9ugkjhD2B4kIAS8paFENl3WOA2?=
 =?us-ascii?Q?WrkxAvo4M0IWoued0B41WJSf0OU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s0ey4ZZP+OzPkczrBygCpGKIwOICQMN/lLano5ADzUBozGiaP1bARwLkIbgMOOd2vBYJ6UlFJy4zT7EqAstoAlSzxTaq+U6Br2JiMRq5ZDkU68Rwb6TcsvjO7R0uCU0WhEs69a15Ogas45QSjkZ7owUHBJ0YL/irj0Lku/TR8Fggy+wtG6LVeHNC5TkSMQfBJ7W6ne9LT/eePhOL/FZh/mBeFYt7hupJDDUii901RcAeLdePGEnzD8x8VJeJOBOw5jcXZl7/3uF1aGm1yXrj9FYuq10Btbiu5HrybeemVqUn+RXWoJTPcWsiPg4MgLBHrEUCXA8kpmvTlJvWRjnSHkftG+DcMlHqg5BhPJrF2W8E4GjYA5teouE1FEwxYak8ydm81lZ/YcuZ7edh6v1PFqOPTXMbxqPOAAEMLvM/aBH3uQXlJrr/wEUda+N+kyAN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:35:10.3271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3f8a1a-acee-4040-4808-08de737f9f46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFB21296325
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9030-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kkartik@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7D0EE183D68
X-Rspamd-Action: no action

Currently, the Tegra GPC DMA hardware requires the transfer length to
be a multiple of the max burst size configured for the channel. When a
client requests a transfer where the length is not evenly divisible by
the configured max burst size, the DMA hangs with partial burst at
the end.

Fix this by reducing the burst size to the largest power-of-2 value
that evenly divides the transfer length. For example, a 40-byte
transfer with a 16-byte max burst will now use an 8-byte burst
(40 / 8 = 5 complete bursts) instead of causing a hang.

This issue was observed with the PL011 UART driver where TX DMA
transfers of arbitrary lengths were stuck.

Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
Cc: stable@vger.kernel.org
Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 4d6fe0efa76e..7df0a745e7b8 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -825,6 +825,13 @@ static unsigned int get_burst_size(struct tegra_dma_channel *tdc,
 	 * len to calculate the optimum burst size
 	 */
 	burst_byte = burst_size ? burst_size * slave_bw : len;
+
+	/*
+	 * Find the largest burst size that evenly divides the transfer length.
+	 * The hardware requires the transfer length to be a multiple of the
+	 * burst size - partial bursts are not supported.
+	 */
+	burst_byte = min(burst_byte, 1U << __ffs(len));
 	burst_mmio_width = burst_byte / 4;
 
 	if (burst_mmio_width < TEGRA_GPCDMA_MMIOSEQ_BURST_MIN)
-- 
2.43.0


