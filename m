Return-Path: <dmaengine+bounces-9444-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBk7II89uGmpagEAu9opvQ
	(envelope-from <dmaengine+bounces-9444-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:27:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0329B29E2F5
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A00FC3073A72
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CF93D5221;
	Mon, 16 Mar 2026 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k4VhFWFd"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029903D3D1A;
	Mon, 16 Mar 2026 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681600; cv=fail; b=grLT8pJokvx/YVm9hX6LCJai3Z1HM6ZN/8DqH2nrQVtGE633bEAsCIFXNSkGnpy1ZsbYJozTM5oJlSqjxfHPs03VI8d8RcNrG+Tci7oSvqkOaoS3fHsjhLenz6GFxhnOfqZML2AW4w/e18O9NhNf8NtdsQj/M0j2xlVIpOxMmHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681600; c=relaxed/simple;
	bh=DQkNHhFDyC19k9csVDwhNnWWmByd32w8BQDSDsEd71E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6y0swjhrHPIvOZwcfqaVQc9WCoWgfyqIjkoZsh1WaFvvK5HmzZra9Zgv+MVAeow7E1P68WZxjQ12CAY7jN0IS+FufOx5rAInCsVzStxMSqcGW9UJPNZCq/mUkDDaX3xC0spfXPIgvCEUHzY1T52th2REtPF5MaRhg9KUm210q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k4VhFWFd; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luyZ67p4ck0h9WWAlXZM00lEXyGpTdzCaNgYv+brBqpXoWL/mLBqFyE8PHsf/qqwmuwm9pUD7hruHxj0tGNrmQege4UUpfylHUzuxhfXGPA8z+6dQhS4VBpmstVY9FuSo81YCAgCoDjFF2YoTYI8kGkgSNt5C9Lu3xVf+tcQ7btSrxpTWEetwkkEM4bGiUZH606T0f0GC6mXdJXn+gZGYmL45HZXOrDbXTKSVVv+Z+piON3DGlc0r7kTX6/z8QvzD60vF4YkY2dk1zopUoUuFztwnOE7/w7BNTyCaD4mCg3vQwO6NXTQ3k5nERahxpPeOT1Ou/k111XcAcA3aenewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E/TSJ4/CVWvqg/sIkoN1Bc+TDBYdsoBTkTcWD4FXls=;
 b=m+MlTGddnFDs1DeyRIfefiAikonqGQxgjYgTPfYtBDwINMp2CGb0hqBNwNHhlw9Sqy3U7pZN8duBIxk+7ySmypIhbCXKZSaigiNP1+jfSgPsyDKebctUW+im3M/Ud3Qf3erPVKgZsQ1eY7x7cfBqck3OppyXwAqgRLXkcRUEBxU7u2ND2MhfkUGdGUPWaEwlkBCJrWxC+gH8YeDm0VY1OgNvr0+p0vfvNyfJji3dyfxfgfPaYttVWvUnOiVyh6JRXPhxWdvVDLyQifmYXLHlRVlZm7GKwDwgo/4PTQ7kJ5+BjxDpkW0Cx7PjSS4DRCXehlY6CpvNQKc9xe88XU2EBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E/TSJ4/CVWvqg/sIkoN1Bc+TDBYdsoBTkTcWD4FXls=;
 b=k4VhFWFdN/HDkHcTh78DmMmbyh05rZZkIy+3PdplZI0Z11P5Y0wZQvtGbVHgpZcB6NqgxXeaYajGzE7zZ+PeExY/DgomYv8W35I4DllwudlkF7FDbZddWd0vq5m9yONGorSZmRPnMPosKOeoZWm1VYcOGuAM070ISyJEFtbW8FpEP9EKHOYS+bGfZ6f9O+jv3dM7jWSBXKkMqOCrV9hHs27aKYx5bQmwN7h7IuwtxiBE2qUwjqeT8exJrSNYDHBAq3gDdBMiK5X1IzMXMKtkj7gAUT0vqHRDGlNtfJPhFQgcia62mOK/PIDplLCKfIYKDOYu3Nmo4lGxdInRCXPahg==
Received: from SA9PR13CA0134.namprd13.prod.outlook.com (2603:10b6:806:27::19)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 17:19:52 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::f1) by SA9PR13CA0134.outlook.office365.com
 (2603:10b6:806:27::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 17:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 17:19:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 10:19:31 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 10:19:30 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 10:19:26 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 3/9] dmaengine: tegra: Make reset control optional
Date: Mon, 16 Mar 2026 22:48:17 +0530
Message-ID: <20260316171823.61800-4-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316171823.61800-1-akhilrajeev@nvidia.com>
References: <20260316171823.61800-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa7cad7-0264-4233-f816-08de83803c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TcTCwB2gDmcXllJbc/KP8uZpRrHJfhQoR96qzYhbO+CbKeQlDeBsreGKFOP8Uw7MNYhr7wEx4a7YsYS483Z5i+aL+egiC3TG43QD+ZFrHdYwCnTsJVWwnuTVV4zmBwUpwUlaj3zwTroMn626vkX7MObMt+lxxHiq5bnbIko3BRFb2TC5J+Pr+kEgFWbRA6sAlSD4H9YGyZa0erKNDBPIXpI36zCQ1FeYxlCp6XbIya05HyaiX5sdukNwvDobl9Qg5kZW9wEVCj6kcO7XQx18bvuYCa8g2SwYnmLdJqCPzZ2Ofeib6UMdWCDwD1LE4vcpskUn4aHhjO21o6H7tukxIi0hwtyyMtdudm9R9GnYcnfxHUHFrThRtK33NtMs2olqhbzWl99aHLz5jIL4/dZx6CSAg7qtOa+YRwNjwp+3AXiFRTfK8xJjCUgKbzx5lmC1BtUjjIiAdpPsQu4+GefrXCgo4EkKcuwiEHqHv349KBYNyKo2ESJ4GTqcNCPZeTvbTCl+NmlUmA888ZgACFz/E91NYsQArJxF3Ef8pkEuaRV+wmFsK6RquA7d+fb41WYTtNqIp+NAcjh3n/ED+1/mJgUrSIW1PGRF/DeE8vjRchQRSXjqT0EcTyeguC0DfakGFc3bKgWDXEYdM7CbDmWVyJLOFExAq2eyvTUchmucN+qXn6Y45NLLKH+1oUxGGtCzF8y3ZripTsLMbvJn6JBnx8nXww1chu6b7tt4S5vqOw5R2GzWllxcJ67r8OmHKZcw38Flv2jwHVx8tLA8h+9KG9fgawWEn5z4kDIN0rTqj/YxrqnyzkOHx9wmiNf5EEno
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oJriBAV5pvBTUYYpY3OUeYDRm2F6Lvo4ZEzp6628u9Eu6HHXgJcWL1EiE/TegwD2LkaDUY2FiuIiCgmsWrNM84uq4/f7l1UW70gcZ8yZin6mS4hODxq2rQxgmlnuaSRcLgpKRFagtHfpJE3470+DvqDUBl581OdKPi/laP9uoEJajDyig2DgQqoWYogqehILkUx50XF5C5wpizXF5Lv6foEclpz8x0HEB6CFSAm5V+wHe0CFv0UZ0QMdPWdV4k41gXaM5Q6xgU3M6f6MzWnLuBIopk6mCN2b3pL32Rmvw9LzTD4zodoh/Uj/Q5zr9bNZG3IcuS8aFdTjHuTJC2IVKAf09wZpAvlNzjl+nORko4nle0vDt972IABFKuD2DFgC+3dDz0EszYsa80a7XmEXJ5PB0i2RA39AWiKjjFHAJcyYKh639iHquQTZKbWW72Jn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:19:52.1832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa7cad7-0264-4233-f816-08de83803c41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9444-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0329B29E2F5
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


