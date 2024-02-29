Return-Path: <dmaengine+bounces-1183-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E5386C162
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 07:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369FE286A23
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 06:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385D342A8D;
	Thu, 29 Feb 2024 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j/eShJSs"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA093CF6E;
	Thu, 29 Feb 2024 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709189588; cv=fail; b=KxeX3g/ArSvXuFWCog4tJWB0ZQIG0D5jxDVI5CMqCKV9DxU9qF8atCL5tg4zVDlENnO3aJncCWCKRDIA4Klv3oPf9pKXrdNlQoIdfO9yQ6WAn5Kz4vBB4tEI4g0cUCqUqizLBi+CEtbEPQIU8VfGSarzhwQuyL2eVdVeMP+YOQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709189588; c=relaxed/simple;
	bh=s3W16HeXxHw/37+rmaDK/JJGIMG3a3aKcxaoeoG8zM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EQItavPmjpc/iCGxN/j+7LGFsHpATK9Nz03CKJA1MIt5jxs2hgGut8lVTgJtlOvnxqPoKl5mJH7nIOlzIa3lRcTp9FC2upsyMx+Cq8dGM4RVu94i6YOU1OUMRzhzmeuZ7AaZ9bOyZydmwYP4+oDppvCtl4xtMzjTEKWUC+IJPrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j/eShJSs; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hS3eBYjhQo3iC2SYtrkwbESQa+LFCQIfBoAchh/azJk+dA965R8vuuxT1RosYU4Rh9BAcONZY7iRfppQGSNvYBrS9uf9kiSTusldspe+vkB6eFblt1ZxWyTkJRZ5N4wQM5l2cMhgnJ7FVLMH6g7Be9XQ8yOrAzW9PIV9HkiNMzez5IeXOX0cG8X0/L7PXk22XCAVL/Z7ZPpPOOYAEa/Cq/ylX/nd5D5mDc4tsns0vvSd82Tdoh1G5QQuIWchHvkW+PVa6hGFQkJD7Yxw2pmzgk4z9i394Nsye786Jn/o4vZfq3kXzIl1ZWBb3Gc7B4od1UYWM1Jew8kBPI8yRENqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OFWpu8fHclyDH+epjIffj7bs4jIfEhWJE6n15cATT8=;
 b=UK802L2xCfY/8DD5W7BQjGfTEq7HSwsOL3Tw+DUOLoFZv5rFhr/5tcfVeqx7n/twNTpeq7X768HlYYB0qMrcEV+C0lIsygQrZW66xd7cRXu9v9y7nNXZLSx0r5xkG95g24luWPH+7AD4s0gfNm3NmQCJONoZsjinJnF4Zj1SFwDXapcM/n2PlcTjLHNm/7pu3doj9jNyrFFxWp6wk6Tqd4mADgRIyrpzrDh9rD/rf5GfK710h2VtQqC9zVKfBPjAzJjyg7TiGCBweaxLa48MHkwHUysD+epV3sprL+b6rLUkSk3Cvd0MVfzPxMJT72iCbk9cPgcGDSSLKYmKcIkHbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OFWpu8fHclyDH+epjIffj7bs4jIfEhWJE6n15cATT8=;
 b=j/eShJSsWu/na+vI5IZsw5Z3NQIZp5wt6qFcDDkDgOwtCp4cxfmHHtWdleIiVN1XfsWcw5riXFiJSxXEbPVfGCCaW7bOYy3Jpfy6YUscWhCqZbyRS2RH11Po4kA//WrNKWxlygOdpmq4LmJ4zdtnx6s0ys1mCIa7Vs0xcD4hrmTx0R98qBI5iAfkHBDL5r0m7VABNiUsGQ/co2AjNV6nQUuv2hueLY5lthU+FrzSsDPBjrt+4Dh0KvELuBo+1yeBuKYprXc9o4ippV6+tTeGGg8OCVDBzK4De8XeNnNRSjG0bm03G5GfwJtoa0fPAu+zb6jk4leABP3+NSbVlaRYaQ==
Received: from BN9PR03CA0616.namprd03.prod.outlook.com (2603:10b6:408:106::21)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 06:53:03 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::7c) by BN9PR03CA0616.outlook.office365.com
 (2603:10b6:408:106::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Thu, 29 Feb 2024 06:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 06:53:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 28 Feb
 2024 22:52:52 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 28 Feb
 2024 22:52:51 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 28 Feb 2024 22:52:49 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
	<thierry.reding@gmail.com>, <digetx@gmail.com>, <dmaengine@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH] dmaengine: tegra186: Fix residual calculation
Date: Thu, 29 Feb 2024 12:22:23 +0530
Message-ID: <20240229065223.7295-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fd5541-61d7-45d2-556d-08dc38f31382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KgNsIpF1G41n5q9zE5BazhberERYqHKSnYak+OgS9T7OrTEfy4mnlirM3Gjq/zRjTC0VIMQcDWzzDnNb7oiJ7yHxh7Brw+qn5jrn9X9Xn0JZCD9lojJUVv26QV3GjS/owT3RJevSZYcGwGW39U8UdrHBXAH8rCxP+Il4hbHmT4wVX1oJm/vIuF3qjx+xNcFlDNuUKrK66QPpD1XI/j8krdISumJZrfUF08pjgxFmGPTegzjmDMssJLvlQJ1NHnr0n4lEUmmzaYoW2vqJ8mMrLSOeuu3QfRF7ymSXeyOalG39t2wgKnfIA3/BQPXGNJDB5Mfwt81UdAtEayrbljYlcab3mDUI/Y2VegFnO4V2DSThJB7Y+NAwXSHFZJEg2dEOuBEHd/NAKfjEfVwxeP2kpbcymw6EThYP5WCRjdyjvbZpDhrI/V1ojTKlxhrw3bgk0jOKcw9z/oMcrnQ1PJQG7L4T34IDwOROjKKtcmKdCPRMze8lmiqMCdOSJc5U147VoFJUojB5CtnGzNYhnoRG+j3MorfSnSPNH4ZIXo7g+ucl+Ey+49CybsyHiv1BBU1avT9hBVCPU25Mgimkj6xQy45+cFkirSRFthSOmIcbjhgqT95Ik/ZgRe/XaeS7EYF4O0Km5UP1zqbIxuEt3e8kAtVOjo41XyYcn6gRnM2/x/GVMa60RBlQG1cOym5PxzCIgu6lIXttKaeKV6wlr7HUrJiUxWAyusPzWDA86024WKBfrtU44BzcwBHA9wkqqRSs
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 06:53:03.3097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fd5541-61d7-45d2-556d-08dc38f31382
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

The exisiting residual calculation returns an incorrect value when
bytes_xfer == bytes_req. This scenario occurs particularly with
drivers like UART where DMA is scheduled for maximum number of bytes and
is terminated when the bytes inflow stops. At higher baud rates, it
could request the tx_status while there is no bytes left to transfer.
This will lead to incorrect residual being set. Hence return residual as
'0' when bytes transferred equals to the bytes requested.

Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
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


