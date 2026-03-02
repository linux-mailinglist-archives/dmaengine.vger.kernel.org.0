Return-Path: <dmaengine+bounces-9166-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOacMAOEpWkeDAYAu9opvQ
	(envelope-from <dmaengine+bounces-9166-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:35:15 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B551D8A5C
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 944F730229AC
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 12:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB3C36E486;
	Mon,  2 Mar 2026 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kmq9v79m"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404F236E469;
	Mon,  2 Mar 2026 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454895; cv=fail; b=XodMgHSx1SWy5f+vSomHWiW6SjYmCjw+/1q5srXsLrGCKeSavjB4TT0aDeG9h5a6qDl59zjiiWv9ha9W2G5xSL6d5Wy5AdNRbSt234G8ohpV7jwF7mj68rHPAWHGtpZ/VPWLNX0qXK5EA4jtyT1dqm5DeoFA4A3+yvikq5YfJfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454895; c=relaxed/simple;
	bh=8DLSurOU8fuMOC/Ta2Y4ZHwYaeR80Co7YKM1GzNslzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkygREt2MbovTUIhyYgum7Dhxb2LWkvOUrnWMzwXjLPBIBwQUpEanShrIvUk0pDsOXh4Dd7fQTZNyeWlAvyoHYAyiOr9DwIuejH1EclLg6II++z5hpVorMFtoxGdnn6/mEMH8cFVK7vi60m95q8vuKhZvnpslORODDgpomV8JkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kmq9v79m; arc=fail smtp.client-ip=52.101.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fk+1U1oHc3W/Bn6R7iLCZKsmIkqElRljYFosFmnHSZLnVujV33KdSOrLIowe/syXx69Mk2X0WdFj5oxh4PlgZ1u5Zs+d/dFWtqB0fNrx4SYoTVRWBAhjVfFYhJs4i8btHWUkMKY1ak5e9tVbB+X701GGjOOTK4D9PzL7iVZaJUK2K3U07vtSQfBbBR1MiJ7ZTL0LJrRE1BhPSfdQVR2F/TbCZU5E+oUXk2qBr3PQNh6Tytv/Zh41Iu8B6trW9SnUvOPK6jPmVkPpDtNbXeai7XyWsuNWo0sybzF/hKTCa2SdX6mTlYqfqIapPXB5OCgZirwPr9k8mX1NCqfmD32Ppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HRfxm0pnufUERojXOf178QP3aE64MD0QhEcByjKafM=;
 b=J3j7m5VNvF9YqbbL1kMdBkO9e1UZyWThbHCKeC2GxRThWa2KogjbykOlYJX/x7SyYBWHUbPGc3pirfZn+n7RpMlebsebCOoCxCBpGunDw4KrB7KpUVwWrSBhLWxDSDvEEUwvtn9X1m6OWBlQIT85FwrEMMwzW3ZcS8YBsGhQ1wkN1DuX/KfK8gULI99aTTw1ymPJBWG71waAXlLs8SQ60KzeGBILDDhPiwnbIKJpKzrfTEtpyHUMS57FZcCrHoCl0HsQMGmbCQXzzYf0tXLCHqQUVZRI1zTFj6OtHkR9OhsiABket5mLiRB/J5TvDOqql+uhX2VcO57AVyS1c2mPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HRfxm0pnufUERojXOf178QP3aE64MD0QhEcByjKafM=;
 b=kmq9v79mC+Fe8TJXm0+uUSPxZ+ih2LTHshfv/fdAiO+fas5y8Qb8EqGstdxRNCqZ3jcSkbZKS46gN9K9mkAgpVs+c3xitgv0DDsmrzgKgI3XhMO5FEbrdJHyjqVGW3P1jTfxUPcyJ/knelcEJ7I/x0dVhOkwFj/cwG5EUUpt6GxtgRwqKc7kHRuyt1nnh8jjcLF+W89Xv0fhSzLFhREGGtou+8ZVHDaOZrKvLmpL6x4y8byOKf9xoDsPNxOPaxj9Y/0P9aTAMwaj4S9mJ++1UShTPsWw3OozJr7+RP9M7MrGDTWGHymTZFkSWKG83GqgG9f1GUnQJbSgJx8qLXeJJA==
Received: from PH8PR02CA0031.namprd02.prod.outlook.com (2603:10b6:510:2da::7)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 12:34:47 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::f7) by PH8PR02CA0031.outlook.office365.com
 (2603:10b6:510:2da::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16 via Frontend Transport; Mon,
 2 Mar 2026 12:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 12:34:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:34:35 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:34:34 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Mar 2026 04:34:30 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v2 3/9] dmaengine: tegra: Make reset control optional
Date: Mon, 2 Mar 2026 18:02:33 +0530
Message-ID: <20260302123239.68441-4-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 36958968-8af6-4381-18d6-08de785816d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	SvNeWpC/GhLuIIjxelU4QsPC40U0ml3Dd5TxkcA3hIQocmTvgJamheqFr4ZPjIElDX3fZSa4dwhENdTjis4tQUWs0uOvlkv4wSko/H1LU1o4KYn1DGzd6bQ0MaICXEXk8rCRLs2PhbWZ40sIiqS1s3YQ1Icn4vzMtUjvHF9+5an2hhHvrnTonnkPGaYcngXFG9x766Plkgsnp6UpGald64UmUM5P0lDXZq1w5+Z879clpIrVskU9TnoJmgkpBbJT7ucWUpDtjAAoY9FxSFf0ixH/TxNE1vc1TaQ0OvOEJ04vZPvCXn6RD8XYrTt+kHyKeswWGnBT9u4zrvcCkVDOS6ryJd7LYDPUDwIRGy/cCfLwoQRaE7SfZbHT+CYl7E4+p5eO8D25NPfLhDNVpjCyuXH7TfHxOkY6enMYwv3Y7PIQoZSViHvyloHs9dhFEqdl4piVFS9PeGEinBMbG6L/g/c24wbJ6qLrmjRiDwfc3LB/DOSCRWK/qDxoYfhewGKbz78sImRQHpHcOp9xfY3oNriDHPoAjqyQgk7iTPBJdVTtqxpb9U3hO3jSxu5qG4tUvqG13Ty3iF1bU5S1MAaNR74knXAWDIgzkk2gtgoT3EhimxzuGpn7Ph+prpDIxMHoW/dovqsd/GWl43bIOqNJosrI/mMK19enBtKmMF6AL1jqEYQW5oGf68XMdsSlD5e1p4FmFGSCNCQagp1pA0dhVP9qxgo+OrAGO2dTooacwm5wrvx4iW0c7sFm0y2QY/gAC15VZWGye59mBBPuGi+59jOD8dCaMrwGbGUoQXq566Camrahcuh/tbiuvXg0qiJKGJXYHpiwWbMbGVq2q1wx40HRjmKYrrBCfVTzLLge870=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4FgRnSIFQ4f4Sv/wzKhuc5v/F1jb+k/CPYyPjc+FXBDK2sdYjaXzN5Rx9P80wXc81m6UhsgILon4ZuBmGvicudfrunZWLGloNpPxwTHVDeruI/ohV+FQs10jFotw4BgxX6IS8uqovTtEjHbWW9M+uhj97a9is7ShVhrAPnDXFGhmG0+l4DEdHynxeJTJRv6wnIdxidbJcuuf4H9woAezzWiW8ZCml2msbJGEVVVlVbKt+2lzOpLmOjR6q93j3E2M/Erbnh5tHUTB8lNFkJfgCh1AOASCqbLSfw4vBOPF7rr09xJm6xuX8UTyR4DvSTDBGVsdgWAYFEF9iyu6oSW568EXIHLrWFJQe5Zp+k8ialsNMbNS1MFDnWqFAL6pqfKbs0l+F47w5qeUBqKV7dBWkp0gVblwQz3UI5TZtE3Kf1002X2YvFTK7AxzFCVezOzH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 12:34:46.7134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36958968-8af6-4381-18d6-08de785816d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9166-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 86B551D8A5C
X-Rspamd-Action: no action

In Tegra264, reset is not available for the driver to control as
this is handled by the boot firmware. Hence make the reset control
optional and update the error message to reflect the correct error.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 4d6fe0efa76e..09a1717aa808 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1382,10 +1382,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
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


