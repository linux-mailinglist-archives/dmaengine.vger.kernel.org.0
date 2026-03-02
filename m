Return-Path: <dmaengine+bounces-9168-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KId8LoCEpWkCDAYAu9opvQ
	(envelope-from <dmaengine+bounces-9168-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:37:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6323A1D8B53
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 422C73027945
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 12:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAF836E48B;
	Mon,  2 Mar 2026 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="btShKAxS"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0500361660;
	Mon,  2 Mar 2026 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454972; cv=fail; b=UQ9R1rtVeyRZtfrLGaqey1VLJymxnsC4pDsnUL2kbZgB5qVefll/SZ6G3K4j4E1adScy2rWJhkxWCVlU9oxFGmuxcBB5Gezbv1ge7BNJ2yNKo2g4/id61o26cwV5TK2pr7NJoeWmsIe+3/g0wbLcbfFtdrL4VggMsUmGbe1NZNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454972; c=relaxed/simple;
	bh=FZ36u+zSXwoZDcrK0QKOnMw3qAC8SqLEQ4QiR5XtlBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVZnTRjgBHd2hiU1KVP8NLfGm/+q4rLH/Qk0zg5WVQy9OPZtuTDXTunkM+1xaf34yNgQc6V6SSzxKzxqebIItrbS3fcKxn1jtukpvuCFTku3P3av/yNUBqyz+c2e+PTji4yGG7ZMheReCFTqtX8Mxv3gfTSd0EgWMN/wT8Z+dxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=btShKAxS; arc=fail smtp.client-ip=52.101.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIE1AKZksibjVUBNT2vxYUhndCt+V2RkN4D4Kg9HB4fM9O0Y/1fMv8iPqpqsPMe+7Nf9/Q9zUmdVlCXKyFpoeEbokCPG04Y5u871R18EiNcVbM/8JrScyk/NpoU76TCtncUogkUje5x5wgVGqT7d+ZnReF9owD86ogNcqIAAC8Lv0G53pMs/rd2CiYsaVrB0rimECz0jZaH5EFefqHyj/NKwGqeDwXsMouvODd5n7Kv1dX75tTkO1dLAy9O00V3shmXarKEt8Qb80yulqwrLFgZ/kBUWGZl8uraFfWcupMdtb8yYusZ1DX9hOQmXWGQBUrw/mW1rlECWvMMc8+g8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGhqq0yfTO20h+D8W+H2g0c5ci9ioidN4ALU2BjQEbI=;
 b=LzuJ5tI029HvGAjxy/KERoKCfmPtL/Y0pbtU7gww9QA0DXGXcDvrM367eiUhvkSyXJpDFliRn+2r+/aUHxADDxwo1IZWp2BMiRL11i0gtBJb9kSzQnGFHMd+HxHDwJn45aq+afSJSZUPKjptb9dcH7eWQlDtXfb7DAgNUnehnO2DxG5aGIYigqtWtITGbJmu8ZhHNtBkFor9D8RN2zTGjK3zT2rqNutK7Ma9Y/8SScihrRkCnRPBV9uP4nVI+2CEWxeQK0gxeFHDrPpbWjVvfBa4RtaDAl6ghhSRfaUwkUKQFXkX5gTdsC11uma/2R+nVZeUaD+LGbAFnp/lCU1djA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGhqq0yfTO20h+D8W+H2g0c5ci9ioidN4ALU2BjQEbI=;
 b=btShKAxShDKwOVm80007wDaO5eC2RQ6p5qiOB6pf3mejDWqSiI6sURKYEP9PPRrImhTjRqaXL5zmMB5eNVuu3X02hjuOJjhay/ok9O4lh/5z0wtBfvNynH3w+u2NqS99CghqcOBiJkHmUbmorP42z0MgrVkMH3EHCIZofaGWij4vU4D1LL9ir3rW90S4Fvnze9OHLj17kOftRYGmU5stzwakItZtaULhjEb5Q4lnmZd8oLUk0wQezES977ouTLxNgC/PNZAuoZalia96LID5DX7OB3fohabGqn9RgrM+cm+0aWicPqUL2fHssudfNOKjf3+knHg7/b51HBmSOv3b1g==
Received: from SA9PR13CA0018.namprd13.prod.outlook.com (2603:10b6:806:21::23)
 by SJ5PPFDF5E260D0.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Mon, 2 Mar
 2026 12:36:07 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::f8) by SA9PR13CA0018.outlook.office365.com
 (2603:10b6:806:21::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Mon,
 2 Mar 2026 12:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 12:36:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:35:53 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:35:52 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Mar 2026 04:35:48 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <frank.li@nxp.com>
Subject: [PATCH v2 6/9] dmaengine: tegra: Use managed DMA controller registration
Date: Mon, 2 Mar 2026 18:02:36 +0530
Message-ID: <20260302123239.68441-7-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302123239.68441-1-akhilrajeev@nvidia.com>
References: <20260302123239.68441-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SJ5PPFDF5E260D0:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c94fba-971c-4e7b-c1c1-08de785846d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	rhX1i7UYWop7N5dlh0qAWt3NP5rC5jJz+S3Pk0kZXb/PsIeZoiIJpT5ySObzgnbwLURgAi+bCGUPsEeApBOrzXKrkEh9u73ZRso/CuCLt15SBi2eEYRQwULCP4R3UWr4ZLKWHgLGWvAEBl2gSaGoRwuACOa5lql7ajUq3lSaSoLzR5UgzCpDwdEVzei5ZDRmrPG1yDAZDrBc6BQYc4q8cfebSM0jWdImGA+K3/zHqrxs9+1gshW/Nz/z5V+b96ST1VfkBkJehiaWJxWkN0Ncy35OpMyqMPNxCDUW6XN/blqKUISbDNfkvkbUA0mEZZCi2NGHgMePqrL+cgaeDWYvAFS7vMKWp0IFf65PyushR0JN+Zq30Ug1H0TQKzgLtZOOOhGCB5D5sLKFCJhLWpoEAbiRz74YLaE7KXKAi297Pbu1+QqMWc9G9tRppqRi2zvuOPqJh1MdljK3Lrg0bDkHK0PfEEzpNPuCm0bNPxKVr28NVuv0VwR726agfZ5awI9BVOt2+smzLSNmxGRo1ZRSMg8FKpaiGlajQ9gnqvdqJO1Huq0SUPMBY9zkUBaaoK+213AX/ENlH1o8BqKmlQcXIN7awE3uckKR8JEcLDkgETJseb+/7PvxWF7byE8L2b7Kue9aZc3fXhuS+cnbLEviiew5gFOXwWDPkW2YDOmuZnJ7JLKxvbaAbgjub+rBfq1lAXyQOiD5BYBl7044zBwQCx3+ECcpCUYAUSGqS16dEjuWkfHKaPJqQkjBNOrehydHj+Wp8/CsWcdRNLE29LwHg45jumoYx5OOdtxiYGHayzAqmqAvCuDWTpSdb0A9nuwKIFtpHcFxtp/bsKq9jfdyDr+C8j3w1/MfI3zPvsEXJY4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0wL9YRs9u9hE5pSpJQmQ7QQ0l9iBB8SD2Ju9pGgMBRAbgz2OdMoHY6u9ymMc1R7Yq7xbv56eeRl53gPf7yQxvXS0DCVVYyow5dyJ8TcBr7E63A1/KJcLhlYrpVTqRPF/VLEh4ZnQ3BA+aUUcVglnFaA+llAzYNsGED//Y3HeUGtxrI5rW9ClzZyVb3kcQJoAdGTIImQyPHD4x73Rj+FHgVblUKrtkPcN7gNED7MoFNAQ0djD4VgizIWV6nxyozSn+QXHOoIkSWIcWdndF+ipadA0vodIs8wUxY1WSvopMt6goMXygUeqz9FwcCJGNhp2EXVTHl6pSaG8DUB+r9F5X4ZGtwSHJtT5Iuz5P5ef3YxreZ07tMK42/MPmm3ETmS3trWnma66y0sPmO9adaP3Q/DgUoyS+RNRN9px/iHgz8jI4z6C6NQpkLbS4CGdt5jb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 12:36:07.2878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c94fba-971c-4e7b-c1c1-08de785846d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDF5E260D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9168-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6323A1D8B53
X-Rspamd-Action: no action

Switch to dmaenginem_async_device_register() for managed
registration and to simplify the error path in the probe.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Suggested-by: Frank Li <frank.li@nxp.com>
---
 drivers/dma/tegra186-gpc-dma.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 753e86d05a02..5997edaba28e 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1497,7 +1497,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	tdma->dma_dev.device_synchronize = tegra_dma_chan_synchronize;
 	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
-	ret = dma_async_device_register(&tdma->dma_dev);
+	ret = dmaenginem_async_device_register(&tdma->dma_dev);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret,
 			      "GPC DMA driver registration failed\n");
@@ -1509,12 +1509,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret,
 			      "GPC DMA OF registration failed\n");
-
-		dma_async_device_unregister(&tdma->dma_dev);
 		return ret;
 	}
 
-	dev_info(&pdev->dev, "GPC DMA driver register %lu channels\n",
+	dev_info(&pdev->dev, "GPC DMA driver registered %lu channels\n",
 		 hweight_long(tdma->chan_mask));
 
 	return 0;
@@ -1522,10 +1520,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 static void tegra_dma_remove(struct platform_device *pdev)
 {
-	struct tegra_dma *tdma = platform_get_drvdata(pdev);
-
 	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&tdma->dma_dev);
 }
 
 static int __maybe_unused tegra_dma_pm_suspend(struct device *dev)
-- 
2.50.1


