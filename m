Return-Path: <dmaengine+bounces-9762-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFfTNUWhy2kUJwYAu9opvQ
	(envelope-from <dmaengine+bounces-9762-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:26:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ECC367E73
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2D7D30266F9
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7413ECBF9;
	Tue, 31 Mar 2026 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ylvma1zm"
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327C3A962D;
	Tue, 31 Mar 2026 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952659; cv=fail; b=mjaVM9QoE1Dhw4OOFgeynyaJUqVkPkDL+WWdXlhLJ8QxWPIYHpJecwITCMgtRcqVVYH2b1O+RqOMPyvGd6eRestx1H+wSEZF+1lq97CCV7YQmMiuJ9SYfYU0eRh9w9pTO82zvMznjjfX4hzojlQC1tpSTrzf5WQjyr1OOQB1gcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952659; c=relaxed/simple;
	bh=DQkNHhFDyC19k9csVDwhNnWWmByd32w8BQDSDsEd71E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrKc95gDhM3FVORjmJW78QgW6EYHhngp0uT/P61aMNtUX3EA1b8gO/5EgdYnBHi6McpwQSDYdZ65jBC5EzNi9j0tkF/GhE0E/EHFINKeDNsG95EkV4bkJncgr3aKsx76qNYWpz+7QLWP0+O7cquepJwgqq6o2IjLZdZvDEvA0mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ylvma1zm; arc=fail smtp.client-ip=52.101.85.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xf+/5aWeyDjV3GjAP9Ygco2qaJrmCj3fCgvVl8ABP65V1KhsESGPZ3uIBi67kAAO2RqEuIu2V2bYnBEheCV6tjz/bk0SCOOQOjS6st9MPGbdylH9MGG7jGbHA9SSLS6sX695n8OYaCZwnH/OJMyFJ592qkVMl8k5LTZB1UFHr7X62QL2xZ82ruKNgtVMvJhYfu1+JUP6K6i1xLB2OWAC2npfgYKVX6nYW/FvdMeLijnvdwECDHEHvBretcMf/CpdQSXvUEXBsEZ4BOloU6hiepZ2IPcAV4adsXHhUqINxMBweropcjORzdC4sZ3h810AkaBmlRUhh9hRQIUXvKrxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E/TSJ4/CVWvqg/sIkoN1Bc+TDBYdsoBTkTcWD4FXls=;
 b=mEEWkQVg4BwEV29/9BlE8xSdwiBk+OIJ7I7x5P2rmJ9PidTAfiNO1MYXaep3832azAT4gjM443ASKtuShAN4Iwa7D56c3VFpx4G8zp6RVKDe2jRHJOw6/QuySlW5V4VjIk3LfT/ozfr6UsnTcPLYe1PynJxXmk0CbdYrHOeADDDTuFOMYyzlgg2g+/sHt7zMIlbeLynos0gMeRx4f3I0ilS222d3PWWn9cxHaYLar0ZI+PKAyPQAgGoDpyqzITpA5j4oTSDY3A6VsK5zZ8Af2U3/DjFzyfXFOBFYxN6nce0cpVGf4XuZrEg51YxHWhLCSOt28TXkeJa/XM51RXe+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E/TSJ4/CVWvqg/sIkoN1Bc+TDBYdsoBTkTcWD4FXls=;
 b=Ylvma1zm2D/7QaQqqAUB2Xpi1iLEpc/M/i4PdznJ3Da0k8+RKRn7ObgpBkMV9VnHTPgUCKnhjPung6bdOKgskd27Zhy6EGp8BNL8FbLiPq+tXb8+yuZR/ymimWVy3/HZfdLJEx6SO0RoGvCi6GiXCBRfRFTj2lf/i5GLjPWAO+CeiVK8LB6KI04VLYdAjh5PF+hbqUl8cmKS2PdJuQMo8SNzqQ8VuUy3i9IhozcgG1n0y0d5IOu5P/pa6A5Pw6xzP5i/8iVTT7pAJjetPWb4gBoACDHP8XAcaQLRts+Dv89Kz5wJimqTQl6q00Xq5O4bj2Yvd2v2PVidEc0i0q79oQ==
Received: from DS7PR03CA0181.namprd03.prod.outlook.com (2603:10b6:5:3b6::6) by
 MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 10:24:13 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::66) by DS7PR03CA0181.outlook.office365.com
 (2603:10b6:5:3b6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 10:24:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 03:24:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 31 Mar 2026 03:24:03 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 03:23:59 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 04/10] dmaengine: tegra: Make reset control optional
Date: Tue, 31 Mar 2026 15:52:57 +0530
Message-ID: <20260331102303.33181-5-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|MN0PR12MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7ccb5b-f0e0-490e-03af-08de8f0fa7d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WPa3lXIKNcUrVCIJuB9waxCww+6y5UvLsKwxtMCsT0qiVr2y4ue5FFG5ACshjimq6uQrsUAJmYKyuCOx/FBIdN8VJfO9efn26uBV85YEKFqg7JPhG6hi8Cpv2zUCnyORrNjDkWcBT7S9/q/VwONvNa4THcfSjmOt4Y90v/C6IHsb08A+6dGR8Z1p6I3urpsPGEIVSVk8JoL7kv5YRFDPG5aYZg/mCb/zKoIrBxZz1Ynn0GAw71kAW7HL2/vJXO2UsTKf0etcYIzjfB59GYUYBbFxaDWSrC2MidA6+BgrHxtYZOagyif7jJWwmrDo3lA0MzEzXbZm2eZMKmYerwF3UOwsYS1cl93zwr6UpZ3kUigRljNxF4nC+nLPCif0bSfmHk8foAEHOlMJwqwLI7+dy72wRk/f2f9Dr9b2hZsBMBNtycsmQ8FoiKEUYylGEt7gtsQOnvZgbfK9FyBGvDQWj5df6BJsr7b4vF8PjayTDKIYFUvYM74Lyp3VimBomWvf7mPulbljCHUBYnM3+XkQYM/4V2IKEKXOrw8wyx33xA79tLe7LCU/fpyx0fijjpwWQJ/J8bzPKSLc4JTgcHGHt3tfvz2OOc/k1coWIQaBjay+u4vqu2dLGdw5s18IVLL947fJ6R45R3IKC+z/C9dx8pkQW22EK15LofxHqKjn4aPZDPcUjC8EmiEUIuS2WSD4AMWh5A8yoR4D0HejxFJYek2QzedQP8zKY1ufZL62jUmI7MoNHqDK9klySLXB6yyCAhxRbLIQFDz9OKaPPr65F+MIh1k4dRqhFGJ9+CeqU/Q2Q83NBB8TUcjlX8m+Sa0S
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	frqWwC1OBWLGFWtwmGRUINlEPNqUJfwxXF4EUCLLD8DZQ5tfX/oRenCc4bX+s5Z9FGroJ10BaSzqB4sjzCKIXYuq0bRbtMsyHgrvDoC+cxLZr5cqa+WVqd0bz59P0F0+df2PvexYtxIbD4veElZ3wGvzu688lKfKXz/2D86vz2EwwfxNb+zwRAw0GL0yGK3rzAHbFBiilBR2haXHwIUK4Ti3N16GpDZM1JHFkfqJQOViASSLBj4YBxyeO4JMMDiyB5y3MkHTq+PyEgcMl1D+YetvVGovilbZobxU//vMEwj5fx63/JYRfmXNyv8gFReVCZfyZYVL7HSL6z4od2HqBXs42nBI8uWsGi+ILkeThiCP+P8St8HeMDLM5DpHtXiJVRg3JACZFDk442CTV72zITjHkfMpzOpwbk1DStt9/2wJFkUmlCOGtjavsW7yoxH4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:24:13.4797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7ccb5b-f0e0-490e-03af-08de8f0fa7d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834
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
	TAGGED_FROM(0.00)[bounces-9762-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nxp.com:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C3ECC367E73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tegra264, reset is not available for the driver to control as
this is handled by the boot firmware. Hence make the reset control
optional and update the error message to reflect the correct error.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/tegra186-gpc-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 5948fbf32c21..a0522a992ebc 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1381,10 +1381,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	if (IS_ERR(tdma->base_addr))
 		return PTR_ERR(tdma->base_addr);
 
-	tdma->rst = devm_reset_control_get_exclusive(&pdev->dev, "gpcdma");
+	tdma->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, "gpcdma");
 	if (IS_ERR(tdma->rst)) {
 		return dev_err_probe(&pdev->dev, PTR_ERR(tdma->rst),
-			      "Missing controller reset\n");
+			      "Failed to get controller reset\n");
 	}
 	reset_control_reset(tdma->rst);
 
-- 
2.50.1


