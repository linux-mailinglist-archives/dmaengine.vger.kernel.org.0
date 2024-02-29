Return-Path: <dmaengine+bounces-1190-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2C986C852
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 12:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6206D1C2123E
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 11:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A55C7C6EF;
	Thu, 29 Feb 2024 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k4mxdAHA"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26B659B6A;
	Thu, 29 Feb 2024 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207111; cv=fail; b=e6Y89vQTNhKcPK33ZHYjIAmlI3lnnZJAqGk87yPzXEih2294F+OPGcLR7Cgae+AEmjdhWlVGi/4Yi91EN1/Yojlv9ZuJlK8yqcluQul8zbTxp+y35TQVUIO4+tmPJORhoFqZP3JNCOanls7FiLxDZpHiwHaeKhxvGWTawxTtSRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207111; c=relaxed/simple;
	bh=2AvODDP7c14q+zYQcAXV9HzRG0nVwf8u9lSlwKyZxHc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=baGBKZq9bVu0Sko9ooGVjj/Q2IVF2ubaD7L+nmo8ClOAR/imD2xhpaQ2HKVXqrkmziYjinQhw7RV6F5t7FxG/aohZjyalYunUHN6mIPQEcTHQ5e0PEi2JMbTTBdYMCtTwN1Dt8qKhpo4Fq9nxhHgN6rwzkmFknhqhBjMewYnXQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k4mxdAHA; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIt6RlqFhUW8taASyqiPyIlZIQiKb/Ud3vn2xNdBSM0D2rj/xxxNxs1285CUbV1qkXuzhFMkgNyvIxqlgrGf+60zVdk8B+737CJmIm++HYfabSPOBy583P8cs2ojhBrcUJSuam9WA52bYb5wCzhQDe2i2Z9k3wo0HX+Re2uFclU9mKNV+Zvle/D3UgJIL+3GTGpypkvU3VxNqQ3UGsWpm1L3yTyHISSheVnudh82RiiSLvSBFpwQ8AgqMhK1pDiUCcddVEv2qXxDo7yN3iXh+GPhq13uxwRLf3bw3Amqjja5UJm+cdxuuiaYgoq6pRBw8vuW6bj0OaGbTPiQMett8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeZlVl8zDiAyryXi7c4BZnR4xI7fGP+mqPXR0kQrMho=;
 b=aSgaeWZntCZN+hisTvtmHghAFudmxGFre7Ip+L1E0ju5s8qNoK7bwgkc/6nZteRrOtoKScCAub138ZRVo2//E0xA/+R0cUn128DazCkfLODEWAS+Rs/+JHEhqUlbeZ10a/bcUvUkyX9FrGY+PGiXguA3ZXS5/AQ/lXrKtf8dC9Nb7CQX2noIABHxS2ybL4p5rQ6KGlO3G3DTNtgQd7/9WwKP7lxK4rY223gYBrbW4t9sTH1/OxKjsaDByNw94u4nSQPYUCFhVlWutyPKoPnEEbo6diUxhuBNqq3JBFDf0hf0vkC2TB4O4J33x088DpH2Uur7X7HYESdjlyDIUzs1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeZlVl8zDiAyryXi7c4BZnR4xI7fGP+mqPXR0kQrMho=;
 b=k4mxdAHA/KJPXuoJUZ3XSR7VUccmINTrjVRXBkJKuDRt6Om9pwWhnjoXKnAC/5qvvEXrESurR7bCaDvIHXlZ9C9qWMstLVBOovo2nj7g0PQokuOgdss2wqZK5PfroI0i1HOdBeoynh1wBaC9hMZ6+oo1YJcKvzrtY1cM6fEdOXTZBBvClT4qOUaAOiCGw+4CJDZa0bBAwipL2SsUZlQR7vV1XlhxLHRRGHvpOxQ1RW72AoNuO9oQ+CY9wEEaN+DNjAOHEXI3MyBwsaBfAvCsA8OP44izOeftcTrfmw3N8IGI3pSW67paZt1ESv6CPqTfsc4NeyLghr6di90nk3o37Q==
Received: from BYAPR06CA0063.namprd06.prod.outlook.com (2603:10b6:a03:14b::40)
 by PH0PR12MB7471.namprd12.prod.outlook.com (2603:10b6:510:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 11:45:06 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::cf) by BYAPR06CA0063.outlook.office365.com
 (2603:10b6:a03:14b::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Thu, 29 Feb 2024 11:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 11:45:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 29 Feb
 2024 03:44:51 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 29 Feb
 2024 03:44:50 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 29 Feb 2024 03:44:48 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
	<thierry.reding@gmail.com>, <digetx@gmail.com>, <dmaengine@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v2] dmaengine: tegra186: Fix residual calculation
Date: Thu, 29 Feb 2024 17:14:39 +0530
Message-ID: <20240229114439.21246-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|PH0PR12MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 5634d516-7a61-4bfc-418e-08dc391be024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zkjLTpxIIcXt9dnTZLCee+v5a6G5D2reQ4TwVd1/iRaTmmGtCcVFM5sn9sc5CvQu5O1uVtUjBB71tdR4OaQscUMDoK18uSyyVerSAKTc3+mUWf3F5rFKqbjHLu5z4d8xMU1W30SwB+afJB3iLA+feT5v1rOTgGSd8jBlHIZt+zM/5RycxKUOMoBawSynoBEpacN0NK+gqBLP3q+gOajrpFah3Btq77JJ3zA5qFGMqM5q9ljw5RFGbNiYQXHZLQztR9oWGnjYaAJLfTfQhXq9NW0Zsd+gv+WI95RVScEzTzmzlhlI8yhDozA6b2IxBwOCkyj7jQue6clMpTtuIdtFRb+YVUJdTq6YagqrnorqWqG34mzCWkDprDAAZ5oQ4YR4k1SWpTJuRcWnrEzkVCTlqTZzB5V6fvKtocfqZQrfm9e86EgxYV6WaM/oBLToM6+ODaHDIek6qnZDY0GVIuomg7qmQuZXfwcX2eZ9fTaz7p0Dwl3eL0SqtkYHcuXBqg/TreTLBu3Fw7VW8zzvoKTsPFfmb/zpgR5z2uJKd+mx1L7vFkY6/xB2+sTbyqp+e4erknsEvECBJiI7Yziu4ub9akhR8lzWa1lvKBDM2JVuzxnUq6b0cqglbnf6Mb9j0NHYEiu6mGLc0PN5uGnZaaeljh6tlHQftz9O9TtlvyRS90ARu7YrceMeDZ5xjfiy1afr7Pa98uQjZs4hYyuZ3NdaWOdUlNuIsn7QkAsQPKtkgf/cPMTpmliltnI8kpcn7i7v
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 11:45:06.6984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5634d516-7a61-4bfc-418e-08dc391be024
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7471

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


