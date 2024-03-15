Return-Path: <dmaengine+bounces-1391-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC9D87CD5F
	for <lists+dmaengine@lfdr.de>; Fri, 15 Mar 2024 13:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFB81C20F26
	for <lists+dmaengine@lfdr.de>; Fri, 15 Mar 2024 12:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38E5241E0;
	Fri, 15 Mar 2024 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tTAKYUVA"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD125610;
	Fri, 15 Mar 2024 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710506682; cv=fail; b=FFhZKwEOS9G+HfJfHY5bFL+v1R9WoGlHQOWkvReVSSU3AGiPYP69zO7US3lgezai/Jlwy2fidPLfE/A5YOxlOa6F6zNM4efUlvyvvcIfteju99mVMgvgBGBNjTtFMnPSPGKgqRaJf6MKBw+aUfg5UakeHjwsUewsV9dOSIKsBV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710506682; c=relaxed/simple;
	bh=2AvODDP7c14q+zYQcAXV9HzRG0nVwf8u9lSlwKyZxHc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eo2w6VGQE0f4fJuw1HqIVx1aXGvp1k+r17lqQ7et5tNc4nm8S4ICWOJsSvlcmfCjJovcZf6WdpSCO7FbJGdKRglcvflMFsRBMJNfMP2mq+Kehwiwc1Qb64Sx7bBjCox6yfgQH+mT6CR6SNohi89oDca/mTt8pGy2UVjW3k1IyeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tTAKYUVA; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaSPKexRdMw+NECXqc1aOs1fPZJ5PKTCbb99xilpKlM2RadPH0vERA2kjrsn3VpL4icYhQ/ghXUoZqpEGn5RdHLN2oJj19b/F5vSsejsWNICK3U0t1xBkZ2XMgeb4pMO4pCpMD1kk1YRc9dUK7/Y4vfm+cISor6tvIzgD5U30DO598JaQAx9PCfopnvnR8wvNrm4xb0GD2wOTNLW/wLUgn3x6mT/oBuPqPE0WQS7KK4quTFPceC2au9L1Mns0GkArF2cdla+VcWCG4TTmGrMV7sQrC4soAsKLZ37+7tJ67QAPaJ1R167WMv8NslCEVOnpPVRkih5/8QxKcZYpnWlng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeZlVl8zDiAyryXi7c4BZnR4xI7fGP+mqPXR0kQrMho=;
 b=Fnh3Orhozg4+A4KENtJfF+J1+DtRnQuXyO7Jv5unn+Tx4ahTxExEy/Rmv44VJGq5XJogBbe2rbyWr6MkHGP9RnUeM5s62ucN3tYX3BRmjdP6s5bOL7CeqMukVIHLe7UAu7L9bDc2LgYqMSsRSvHiNfcUJwqoilHeD/jaEtnH93k8fk+fDv1qvC6hx6j8LwXaVGXikr9HPItl2nR5A8Fz3v6X8QIKzxxveGCZmSZs8zEnrWc6NgL2MzNpS+uKVyJM4dw4msTww3y1QQWlfvkjeENhGnp/dY9kyNQAwZxB7MMhrD15Q+fvvnjTKZCwu2iTF5BctmDZ8AvuSOZ7UN9T9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeZlVl8zDiAyryXi7c4BZnR4xI7fGP+mqPXR0kQrMho=;
 b=tTAKYUVAM7ALcktSIH6g85QZk9rfCs7D0X6x7pnS96eeCBCNPI6N0E04bkNoJcfRVJa1LeFFh6a4guxboT1yUzs3MTyK7EOn50jt+J+eZ1p1oJllTQGCq9gOHZOTPX45yYiNBu8CResToZRoC9GMn9a8DhNZIz8HSC9KUHE2ADG0oEdY0O+Cj/p/7mfHpdyAeCvlVtJ6eDDgkq0VWkMYQDHYFO7u4OONBC11nO+kzecMQy8NMSYckydW1toIbZHneGvCtkWF/SfUAJYW5mftea8/mps8zgYgy/okZC2yBtB3xFHQJgH0G6yqjJH8PfXVC2OwgUofRQaT4zGKwXDBzQ==
Received: from SJ0PR13CA0149.namprd13.prod.outlook.com (2603:10b6:a03:2c6::34)
 by MW6PR12MB8958.namprd12.prod.outlook.com (2603:10b6:303:240::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 12:44:36 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::e2) by SJ0PR13CA0149.outlook.office365.com
 (2603:10b6:a03:2c6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.9 via Frontend
 Transport; Fri, 15 Mar 2024 12:44:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 12:44:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 15 Mar
 2024 05:44:21 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 15 Mar
 2024 05:44:21 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 15 Mar 2024 05:44:19 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
	<thierry.reding@gmail.com>, <dmaengine@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v2 RESEND] dmaengine: tegra186: Fix residual calculation
Date: Fri, 15 Mar 2024 18:14:11 +0530
Message-ID: <20240315124411.17582-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MW6PR12MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b3d3d0-e449-4aea-efc2-08dc44edab8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZQX65ay6NBm2L/dcbWS0jimP+1A/04kOaEw/C0vwEUYtCl/zjFrQFxsftYLmcXCxBA5BT+cR2TRubqaX4xLO4TyInLgsogt5pSwouQv44n1nhM0m4ZgpDZPona3SHKT0Q6jwzm87XLtHJGvTBEyka350mkPG4IZ7T1sxSEaiXCqX5dCY8KUjA6RK2KIwIgb+Zv8Edt4ko/3IjswxrR9avsVUSDcDx3t7pUbkeVswOz6NQIfwvrRwQ9XzjhkEymAIw/hAAfqrg6vR8FU34Z9BB7lN3erQXNQgXt1llFDk8MkFVH9SQPKrmz7yzsSeBCGfZ/esZ1piziJuSvXVAv0d5CogWZLbR2JrT7zwUDeBR4Jifzm1UJMs6O8UdXeaH02qzETno8LILmh/ghBIEYQ2gpgFIbBB2nUw/zkoizDjGZ0OaVBgbFu8oWdWsM5L1tdCjSyGU2h/g052Ikf8x8CrSo6/p4pl3ZpfuyEHlHHJFZb7OF7fOboAWGZIXCgbLuCxJLuvDJJhbhMRgHyq/yaPhKvwlxRMw3vCvn+toSpL4ebYvK5Ffv/51a/jJ/Shk8T5FzHtnYoS7mcFR1iQ5BP9XBjv2aAZ0gjar6hbFGZddTq/3At/fgy/YV4cidQEqR4HzkyFOL7BnPFKlumE6lhX1fjL6jTingb6foYDCldQ/s/QfXUGPiazFCFDBH0l9KAvIf8mMv9HvXfe9mLlFrUONBVkU3dqA3DsdK7d+XaET5Rj6NAylw5+R+bYdWXWxpmA
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 12:44:35.4792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b3d3d0-e449-4aea-efc2-08dc44edab8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8958

The existing residual calculation returns an incorrect value when
bytes_xfer == bytes_req. This scenario occurs particularly with drivers
like UART where DMA is scheduled for maximum number of bytes and is
terminated when the bytes inflow stops. At higher baud rates, it could
request the tx_status while there is no bytes left to transfer. This will
lead to incorrect residual being set. Hence return residual as '0' when
bytes transferred equals to the bytes requested.

Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
v1->v2:
* corrected typo - s/exisiting/existing/

 drivers/dma/tegra186-gpc-dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 88547a23825b..3642508e88bb 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -746,6 +746,9 @@ static int tegra_dma_get_residual(struct tegra_dma_channel *tdc)
 	bytes_xfer = dma_desc->bytes_xfer +
 		     sg_req[dma_desc->sg_idx].len - (wcount * 4);
 
+	if (dma_desc->bytes_req == bytes_xfer)
+		return 0;
+
 	residual = dma_desc->bytes_req - (bytes_xfer % dma_desc->bytes_req);
 
 	return residual;
-- 
2.43.2


