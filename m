Return-Path: <dmaengine+bounces-9768-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAE9BAuiy2kUJwYAu9opvQ
	(envelope-from <dmaengine+bounces-9768-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:29:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E47367F9C
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 492E63066AF0
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B968F3EF0D4;
	Tue, 31 Mar 2026 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AyPJHN4f"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E03EDADB;
	Tue, 31 Mar 2026 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952717; cv=fail; b=pFkVednzmepz8BrjIr7VV1+HxrcjqDqQ/0cZRJGbiscGHgJWW7vOTbObEGWqn1HrpfdgN03J/aNceVPquREGAZHkV4VFw+yCQPJPYy5Pq/jULt04ixXsXOHZx99iPZN+XTKiwCFZoEZbkD2S08eSJr5Vdiy3a7eUHrinW0M0dnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952717; c=relaxed/simple;
	bh=7NN+fCy3ciAgXr87buPM0i0enxwIfLoR6U+BS0kMvmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eO26SZO/WfmHH8aZtaLk8ExZS2knuNP0zeOUw27ZlazmLIjhhHDHUHSCk/j25QbMtv7T6QTiF5O5PHaVWOpQv/Ks+eRbmejBuDcK8WNPqiXqxPLsoEstmsDAI3+T1C1a6GLp/jUZzI5pFG1HdwNc9vkfKFps62Yc/w2wOQBPM9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AyPJHN4f; arc=fail smtp.client-ip=52.101.57.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8DcV3gWyVNGfy/VBEciQvPyRsP5+WfgneyQc08xE99/vNu29jjb++HZc3NSMJ4f8ReM9Zv2WelmoBDjfysFR7QmybhsKskRXE6dMltmxGELmHESSwNRj+Q8jiuRxuxT0VGpu86Kf19zbTe4gy3vhoykim40oNZ6U4oz2cG+N567ScXzPU3W95PZuOFuw5tW0KM+OpkVt5trrEXoZFWFFq8PAvkIXwSZhLI3WlkpeKhvO47ukjTJy7XNrA+q1Ad12vM11/P5wewtB8QkynALwZ2ncXdCSeXExS0Kd4tb6m4gVyXcLTPE5DVU5oV4XHfECqXMfMiwoDWWzd8C4uqnGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNb43pydXc7/NV/3gCGMgrCtYLx0sBD0PiqmxKkP4g0=;
 b=xZjE25em63WnizS/M324FkHN2BvESPuQ6+NnDBra141yRKtWR/8aH0I72iGgfyL4sQao9Fq/5B8iuVrSpcPzdjWoGayGQyoP0sKRL9dhbXCwbKRYtueWsb/mVJq6QfyDGhJ7RAo6whAyVmRMvUK3Z1ONmtygD0DnbMuVzxPNfOZJ6j2DjhTKSgRTp3kgskpoU/AP37imeuvNQdahVWnlLntbCtBWu3b+SqcMhWHiujxk3u9LUn5IDHSkVl8LAa/RWYmgP8UAlOp9AqhF2OH2zRL4BwTAs25g/94N74ib/oaV6Yf025HX8scrShTMRZvMLACzAvPLdJKgFwcpqHm4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNb43pydXc7/NV/3gCGMgrCtYLx0sBD0PiqmxKkP4g0=;
 b=AyPJHN4fmyzN4Cb/3fo/GRSig8N48iZjNbkoazvHOB6bQMWcQaIxstbbfL0w8ns7XRGw9SXhESvY4L1l5CbRkGcEoWKaJBrZpkynq4FdhcjQAM8Ze4x9MfZ/75QEyfFw5gWD2q/g+tv6ZSjRF2byDAl+CP+rtgPtDsHWFpnV+3SH8by4ekBsJCWjKh6AdFAhL35eUKgT3cFBKfqgOfsoDC6UxxVeNuE57gnnflwagn5ofm04CEgqQPsy+VqMxZI9hcBQogUao7ZYyMfc6yKnCGVCmC/+eVuK6Q8mzbyUVB35fVovtClzwLKkL7QxHZ9tuWo+vzPBoKIHIbD9WqEl1Q==
Received: from CH2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:610:50::25)
 by CH3PR12MB9080.namprd12.prod.outlook.com (2603:10b6:610:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:25:10 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::a2) by CH2PR16CA0015.outlook.office365.com
 (2603:10b6:610:50::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 10:25:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 03:24:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 31 Mar 2026 03:24:55 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 03:24:52 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 09/10] dmaengine: tegra: Add Tegra264 support
Date: Tue, 31 Mar 2026 15:53:02 +0530
Message-ID: <20260331102303.33181-10-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260331102303.33181-1-akhilrajeev@nvidia.com>
References: <20260331102303.33181-1-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CH3PR12MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: f265344b-71c4-450c-7882-08de8f0fc8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|376014|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xkAttQnssvyO09t4TMN9slLFogpLzffSuM3OJyBIN/pUt2nsoq6RyZWc22Vg7WT+Aja+uRZsICRxAG0TU4cS61bUa2UrKwm5cLpUhUchCODVHi/a/ACAr28bCIQTPfMLrej/camG8VK67E8+n3+V5A6XKeWG8lIxkuvQREM6/12gbbkl/WmWwtHNxH2TziYAQiGsRHhnIC4mhH14EffrBoJ4xsajUwaJrSaQSDZavaLzDPRyIIdBYDGmqepH4Gd4DK5phi/Vj17yfyNwp5AJdpembhxFHVF8btK3eDFd12bWH0lDtwj+GqM3c0Pr7s6OyqRRrM7GraXqZmVvVrFYMzq4AP9MUpSK6RuZgdWJ8Q/UT5TxuYj34ydgXpGV2CFWkYvtDpiVYFcUGJkEHPeP00ZV++BGL7i7ZBb7WqaNrHN1WJ64Sgh+4XZ/OyceiPmLO73nv3BlI/LFl+Cw3jJSPTG2gBLEOY7lUlvrH/YjKvslNkp0tuSoHusCtyg4CyDogM5fnswARfS8iWQm4IMFcn0dlapS8v+ymxHjlkadEGvnqHxAVbVHNGCl6vrceZDSqRbaMSU3dSaxj4hRYtHapFrAqyX5yKVmWUOUIlvip9wbb2sEqa815X42ttEKt/xU3qFPrDnCGNhmjuhBrVs0H7bygmtJ3XR2JGg9AcCnLLR6KvecVWD+dInmZSwWCzwAUsEzDYRSMHZBidJcvVK/VOQn7NqLSOBeEL011u9aY0JFvUeROD/xmNW8Q8M/oqTkgcuEKKMwRW/4tslbCR8+Ok6xFNAVT0EDWSBMi3ojop5XnDyMDFUkAn+tOtF572pB
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(376014)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+GRJNWlk8QwR8Ldh5K5oKC0dVg/ag+bXD5d2ZDVhLiC8fa2Zzr025AUSvzl2MNqLkqOBfVj6TBeAml6hzPf+9DNWMPHPs/TLowGG1fiFcKDD0K/3hfAiwFmkrBDcqL+wrNFAwmsuY+uWQM3CKPF8t0ANMdGiQoR+JJJgmga6SagYi/sSy2iQHDsdVU4FeL25nvZm5dgrk+W69nCchIvxxTszQLw2+2HcY35SSRsNyLvCyWEs9Yzc4hymLj77mRsz+ZUrOfA/SO62CYZZM1QzqIXhhJ55NxoakHiOWG11BNIKNpkegWLNulplaSp4fWJRkRVXs+o/sa2roqpb1O8dleB7yWr7CHQzNZS8YluEFrFlfCPOpnW49/0cHn5OTPKmZRsu/PzUCKVdOTqrkRvthgf9zW3MU6syeVTWW0r8m8vjPbOvAtGGgYneUQLeaOIi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:25:08.7375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f265344b-71c4-450c-7882-08de8f0fc8c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9080
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9768-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,nxp.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A2E47367F9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add compatible and chip data to support GPCDMA in Tegra264, which has
differences in register layout and address bits compared to previous
versions.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/tegra186-gpc-dma.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index cd480d047204..2383a2fe73f1 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1319,6 +1319,23 @@ static const struct tegra_dma_channel_regs tegra186_reg_offsets = {
 	.fixed_pattern = 0x34,
 };
 
+static const struct tegra_dma_channel_regs tegra264_reg_offsets = {
+	.csr = 0x0,
+	.status = 0x4,
+	.csre = 0x8,
+	.src = 0xc,
+	.dst = 0x10,
+	.src_high = 0x14,
+	.dst_high = 0x18,
+	.mc_seq = 0x1c,
+	.mmio_seq = 0x20,
+	.wcount = 0x24,
+	.wxfer = 0x28,
+	.wstatus = 0x2c,
+	.err_status = 0x34,
+	.fixed_pattern = 0x38,
+};
+
 static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
 	.nr_channels = 32,
 	.addr_bits = 39,
@@ -1349,6 +1366,16 @@ static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
 	.terminate = tegra_dma_pause_noerr,
 };
 
+static const struct tegra_dma_chip_data tegra264_dma_chip_data = {
+	.nr_channels = 32,
+	.addr_bits = 41,
+	.channel_reg_size = SZ_64K,
+	.max_dma_count = SZ_1G,
+	.hw_support_pause = true,
+	.channel_regs = &tegra264_reg_offsets,
+	.terminate = tegra_dma_pause_noerr,
+};
+
 static const struct of_device_id tegra_dma_of_match[] = {
 	{
 		.compatible = "nvidia,tegra186-gpcdma",
@@ -1359,6 +1386,9 @@ static const struct of_device_id tegra_dma_of_match[] = {
 	}, {
 		.compatible = "nvidia,tegra234-gpcdma",
 		.data = &tegra234_dma_chip_data,
+	}, {
+		.compatible = "nvidia,tegra264-gpcdma",
+		.data = &tegra264_dma_chip_data,
 	}, {
 	},
 };
-- 
2.50.1


