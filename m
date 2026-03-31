Return-Path: <dmaengine+bounces-9766-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDuaJrCiy2kUJwYAu9opvQ
	(envelope-from <dmaengine+bounces-9766-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:32:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D848368058
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 312AC30E0365
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA483EE1CD;
	Tue, 31 Mar 2026 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KjXhkZJO"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D433ECBC3;
	Tue, 31 Mar 2026 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952698; cv=fail; b=dVennS90rWBZqnt3QSQcCP4/tzN+CIGLDdhtvjxbkHcTVlb685opb5SNN01UnXAAT/3JD6rfBywWyHPbWjFg0o4mw1Jtbk0Jgd9b7nMqzqt0WzN+36/4oh7yB4VrhtD96NJYytpESu34i0+zlEa7UeRmOXLutbg51JvWiGPD+MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952698; c=relaxed/simple;
	bh=Er2RRwu1u3oKOS3YC2aaM4wUjBHuUHQTytGBNX25oZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVhqFyWj4TE8OlcMIYdmHYjacF5msm7QbTcQS//LsgOK3WUsWrTMhAjLPCZ7A7tpfmTxzhh1cZ/j3fjvjOHtbfDxlVURuD1fyDzbae5AATNSAf6br4kuJTVMVlHhIYEgMFpX8kt94+Cd9k+HScdsknKnF3mMNuDKjFUeQJvx3jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KjXhkZJO; arc=fail smtp.client-ip=52.101.57.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8dwwieOzUV+V4XkKRwzdX3iBF6bSlRs3Odv1wUOZqm6gZEaFXhoId8vjyoqHVErYff+U5lAj2i5VD0xFRmBQw9QbdlVwadI81C0FsxJQznnKGdrFOO80srItbJ+UuSYnbOqWWjJdU1y2cfUbS7oo8dHmvNVuIenJtVp8s3qfi/jxw2NwvkBzFxzMxNLPKRhv1B/ozHy4UDeZe81xHsxKhZXkmDOn4tIEATAFLYbyZk1iIjFI5F1V55K9W8UyQh5VyiQMjTr5BtH6XA6g2DXoyhL2WRtsCLwBydUoWl268F3qU9RB3pQ2r4qUx27lfyccAukWp3aU97jOnmY1C+wRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnQOQpqDrVK75f38aGwZwUolWtEicpOiR9xr7UsTKpI=;
 b=Qee7nNYblHwAUtG9I80b99CVcBBJe5NoDkJfwLKzk3Hp0/CkqfL/XFL85ykSGYxlWs8YOLlhOtQy7iJZSNjm9Bh31klUo0udBKSgt+AzxzlZGbNXPQYWsXSsCbUaF8DsgplsMSVpSNv3FvJ47B0SVC9S1zWb4D0GX0DunMUp4vYaICk9O8B/00o9Dh0qBEzrJw51OpzQpkveYV9dFeI7yS2fOWJb9Hh18VM3dyfOzOrrsHTsI37cYikl58X5M2+GHUfTBiDN19D+aZlOgZyXOw8j1Dz1KaJWoYJUkcKlIkTRWecC3j+y4MhpbCcPG7K0uEkpHkgpT6yeDNTZ8e2P7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnQOQpqDrVK75f38aGwZwUolWtEicpOiR9xr7UsTKpI=;
 b=KjXhkZJOzhszhMBOcIvIk1gI9DmiA6ES44yFsrxFkpj5Ah0r6h5a7sR82l0YHGN/gvqACGyY+nH5v7HJb7mGET2aFVhDWrS4tb4N8zimIDDoWTzz0clqdunDo7toIxMINHEy7tGmA0nBI0mkYLwOUs6KYPoj1ATllaJEKXn4ipOQrSh9PNL3+fZYXGP6rGaC+C4MiHuqxbIyJkw1dCtbG/G+yIsKNpv8AUjy9j1f8/WCJ9UdDHEmuf0GTq+/+My4q1y6UWccG0AhUz37jNGNaYZkzb2OHVbwKNVTntesfsGO7amJr/rISq125VK6tEVL6nFKHSzkvJZnQkJStatIEA==
Received: from BL1PR13CA0349.namprd13.prod.outlook.com (2603:10b6:208:2c6::24)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:24:52 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::9) by BL1PR13CA0349.outlook.office365.com
 (2603:10b6:208:2c6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.15 via Frontend Transport; Tue,
 31 Mar 2026 10:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 10:24:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 03:24:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 31 Mar 2026 03:24:35 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 03:24:32 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <frank.li@nxp.com>
Subject: [PATCH v6 07/10] dmaengine: tegra: Use managed DMA controller registration
Date: Tue, 31 Mar 2026 15:53:00 +0530
Message-ID: <20260331102303.33181-8-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab5a669-c60f-4c30-0bde-08de8f0fbec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	PIJJYZpzUD75YynEwB+E51LTAevFtQ9kFPy4ypeYAzvXNMj2aNmeTaZDoweP3/CeDCjyGtqBTecRBkdX+kAtn3xWfNICc3cfJJwA5DUPcVdHG4fnwo9Z+YmVaDwCiLme7lzwq2eCXcnsPU27xUG6wCeq5nFbkBJqsB4SkLiEKYEk2eI/Z5eyXx4LkqT4lMHz4fVSQdNh2lABC4aZoxEzV/+iYPt69foTOXhWX23tPp4iqSZuZEkFERodT1i5gWvNqO6dvVM560xyK3RB+G4a8vF503O5VoBBvaf7tbzMHpfoG+NTgwZWtghxMpfIRW33Bhmzs9WxO0JqzA4yz7BNRAa2v+F4BoQ7tq4kCFQoc7Hxa4bGIaRp7aauYMwV0KxuWrEGoXuuR1C4WxtN/toujHvOLi5j7W5DkaYyXesyLbCauoWxie/v0vBPrfOJxC8oR+yofz8ZPVCW3JfxrobBj9OeHTgRM+YcPu0hxoTY76WnOuA605ZIGIKLVGX3wxDqE7jaJOSbRoWFFWwSYWm/VW3n9x2LgZdzCmjTEufCoBQHmhgNXJvUfxfPN9wRGGeG+1h/5RV2r2slvnTboKm0rp19r0ZZRjCYmqOQB8egC8xhPX1TTt6vSGfuMugN1AKQ6rlGHOM5cKSilPdsW72U2dku+x+8pJtN+o9oqWwpD7GQFxnL1fZUHjuO6Yvb53AzqDXaEw4m3EUBEzbcHNyRiSNDP5GkI7hu8v2e8j6I5ywOGaWzHnulKon2+3w/l1FnnnUt14GO9P9gjmIWBBxGGPnHo5cv/aPwc/dEMDA+WPWKI9v9UKXYB5SzAIn3XDDo
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JtjNktPlyvUtD0RapRQQ3Ah3+7LxTJdk4jeuGgmelt3cbc4Dbv2MmiypIgGdLAloDlidFMcwAWbs+Pxt37TJIP6fl5s9hEMurj8DNaF3ATDxBLbdSzcdY+x2saocU2r1vF82H0fHK+eWsYCgusR6qopq2vOdupqrqbC4lWXQ9WaQvGEVuV0linqWtyC8mNlalbK5dc9X0ENXGqlfCt2UX+s43eXNMj6i9EkEo421vkjoXeehkfjxAGmkDWORFEXulA8oL2NRPokTw/r4k67aBXopDLfA+YrtphRNmET/spQaH9G22DEJMOcy8mP44sjZiwMspH3TP9yBFiaX5Qmv9Ety5unPrCh7JCSopyR41wvaq2L87P5RixKRSUpJIhTnd5+YIgGdK50sMqbitLb2QQY0YDWMuRrFwAQIItxCnL60zeZ6HUcJc+JSeWZAdQCC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:24:51.9218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab5a669-c60f-4c30-0bde-08de8f0fbec8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9766-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nxp.com:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4D848368058
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch to managed registration in probe. This simplifies the error
paths in the probe and also removes the requirement of the driver
remove function.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Suggested-by: Frank Li <frank.li@nxp.com>
---
 drivers/dma/tegra186-gpc-dma.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 3ac43ad19ed6..9bea2ffb3b9e 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1483,37 +1483,27 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	tdma->dma_dev.device_synchronize = tegra_dma_chan_synchronize;
 	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
-	ret = dma_async_device_register(&tdma->dma_dev);
+	ret = dmaenginem_async_device_register(&tdma->dma_dev);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret,
 			      "GPC DMA driver registration failed\n");
 		return ret;
 	}
 
-	ret = of_dma_controller_register(pdev->dev.of_node,
-					 tegra_dma_of_xlate, tdma);
+	ret = devm_of_dma_controller_register(&pdev->dev, pdev->dev.of_node,
+					      tegra_dma_of_xlate, tdma);
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
 }
 
-static void tegra_dma_remove(struct platform_device *pdev)
-{
-	struct tegra_dma *tdma = platform_get_drvdata(pdev);
-
-	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&tdma->dma_dev);
-}
-
 static int __maybe_unused tegra_dma_pm_suspend(struct device *dev)
 {
 	struct tegra_dma *tdma = dev_get_drvdata(dev);
@@ -1564,7 +1554,6 @@ static struct platform_driver tegra_dma_driver = {
 		.of_match_table = tegra_dma_of_match,
 	},
 	.probe		= tegra_dma_probe,
-	.remove		= tegra_dma_remove,
 };
 
 module_platform_driver(tegra_dma_driver);
-- 
2.50.1


