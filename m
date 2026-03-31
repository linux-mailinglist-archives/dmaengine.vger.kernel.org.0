Return-Path: <dmaengine+bounces-9761-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCK0Fjahy2kUJwYAu9opvQ
	(envelope-from <dmaengine+bounces-9761-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:25:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E53BC367E56
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13BD53014628
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AD23ECBF9;
	Tue, 31 Mar 2026 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CudUg/gu"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB83A962D;
	Tue, 31 Mar 2026 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952647; cv=fail; b=Rg3bC6jG4YKdXoZoToGbA1O15mevcn/AnomaS40gcXvMueQ7ZVKj11gaTI8KLmh4aUW1Q/FWTXXeGA5xsxW2VeCuq97ohpZKCHkzSThVLOnP5zumS5jMl4Bx/mzB/OSEFWTchOCf8+YfZgmNf20XvCuF8RAUZBTVbENYm+hPTZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952647; c=relaxed/simple;
	bh=I9Jf6991WxDcrrVxLgNrTEuMMpB2mQJt80ACs+rMu2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/6fyWRn5S89ac+bFTIZGBCkY8hb5h15kKWoI7/c28tpnsK7zhZzzbUvDmw9Lr6jk20fpO8+zWQHw8YwxGFHVWIM+lgrihpExlyLO6puwPyC8lO9cWud0lB/ezXjk/X110luQlV87DIsonlmEa31E+PTB55IksAOZvNHAPQ+Zmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CudUg/gu; arc=fail smtp.client-ip=52.101.53.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOwLe6+RkcwkEF+P4xU7dBYB12Zu9rYG3+DzXhATOHUzBJPYzLqlq5laVQwDexQCzCr6Dxg3GrCW/uqh5pCzX5WZ1Q00gYqX4yJScyQgjNquhsN7p3PfIGCOEoq4mlKoJSGrFqSbv8QKWVzkYG7TxQA7z8PIT63cgoGjEdwZ9zgTefwjSK4z9rhv40KmrwIjhG+xuKI+JFuM5fBCg9rgVOtDUtUQDoyX7w19gWVcmGMHuvxAKsyXRNc9UYiUKtq0NkvvaT0OOm3vcYNDrR9rlO2rGmzt3nMMQVz/NP35mra28Rn+8E0xgV+0BAhBtbEc6P63be7MSki8CLN4RnyS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mG3HNC59MBDQbzEnowzIv1XlbuWYfwd6rnH3TJgW0Qc=;
 b=llBS1IPeOUiVJYnTAalXpK2Tvw63NGv/Cpw3E5VkVup8clbcak4DhXjzKeTHpvJqiNh561eQZWwjbzkp7GdcNxg1NIYUp+v0gJsUj9e1OA6pgga4L8+chdMoRLg7atRm4fNujwRAr0dsBfWsuw9K9NE8kjfRSm+E6qKFSEWhaL3BpKP9rC/EIZUHNR5hojMGxzogEG7atMl1mZB8FNmUqsPzEmdb2M/WPSJVBLz3mN2SBNW5cz3Osp9OsJ5nspd6D7XmtWNdOhfhRO9iK20xZd//LPgelOJnpXSzH6CmC8OR/Ng8JGFBEZN4JDhdClwj653JjNp4xyABzoRQF9CspQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mG3HNC59MBDQbzEnowzIv1XlbuWYfwd6rnH3TJgW0Qc=;
 b=CudUg/guBsMfsEb4OyT8OV83rWH0ZzcTI+sNxzcyqgD19zjvOPfGWQ4szvobvXhyHOpdJdBqF1o235PlC245XNNt+0FbZJ07I2It+98ATJA39n8sb1Kox/MCzC/E6GhkZMT/KUbuOrVz3obgjYoSSx9RPLftBSD9G+UlTimkrHu5J0BhMh1Vz+S1jqMz9Ct5XZQzWA/Hklk0CPD5gS5TIzJqxCpAHdldkhZkM/RoR4yJGSJXdDii2BTj/cmkGgPqLCG6W2ft6WZo6C98EP47DOJp0LPC9gC5LsS6EC58ClrOpqAR5L1jJO0roxM0huxF/Ne3nsF/bqChmdekTeXfEw==
Received: from DS7PR03CA0210.namprd03.prod.outlook.com (2603:10b6:5:3b6::35)
 by CY1PR12MB9559.namprd12.prod.outlook.com (2603:10b6:930:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:24:02 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::84) by DS7PR03CA0210.outlook.office365.com
 (2603:10b6:5:3b6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Tue,
 31 Mar 2026 10:24:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 10:24:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 03:23:48 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 31 Mar 2026 03:23:47 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 03:23:44 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v6 02/10] arm64: tegra: Remove fallback compatible for GPCDMA
Date: Tue, 31 Mar 2026 15:52:55 +0530
Message-ID: <20260331102303.33181-3-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|CY1PR12MB9559:EE_
X-MS-Office365-Filtering-Correlation-Id: 38355393-e796-4ad4-4852-08de8f0fa12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	WAnSd/ctD/b208O29c4sXZ0u5B53+P/iCT+k5K8kkYrVVfCzMXwFiEk2xkB9WyklLoxJ+zkwNEOGJTY/xSo9cA/r3FA9js/eFbMhdxiXLjHc2AGCkzdSiKrGnDoGr//6GSiBgRuWfZRSscW5x+6YI1n4G+isBCA/Knn86ROB/d3KdyJXn5rEXGsKGBRgMvkLryqsjRP2t2yr2cmrWz4RR8OTi1mDWkIVGaavgfn0IJ4XPlblSTP1YjuulV6hQI6bnzrqer0x46LB7Tx2PKuiH6uqVwFyBibPpj+c6DwqLrGrvHKhVuLBYTn1g4kjvF04y5eCPsSQ0m3mw7arJtl5udp53O5phruBOU0Tfqy6BZ199Eu/m+jEb1UCuBu/y0ESLIdBEyyzgya8nR6ZEXwIZqn8mxoq+JB6MJ582KeQrKsJDTRRb0OwBXqx+4LgO25XsYY5SaYOl/KBE9tPhsW7D0gcjhAfby6MfSwA+MNrpmD42E2uPcO4FXNGF2gcd8R0u3PWbUjnymdiIUoW+c5cDoerkWpldKOuVtE28AxeVTT4cAdT4/Y9BtoJe02YvN9++qYbPOCSencnKlM1Aui+YnAPf4DWCpZWcTlz9UAKC4417KhfSB5zcBbtMhmkZjY38DhIje4M10epvrUrsFt6JveDN9Uzy4aGAjS6Cnxb3niS7V6Z9D+U8TzqgG7oJPjfy+vPgeG6SheVVj9V2l6CIO2QyBTNLBX9SzvaaA9C6i0/IWyG8jsm7TfLMg+XVVK/bGU1OwcUHFswlXS7UcqYT4kRsq331CmsXYxnPb4h/XQ/q+13CijFXITrCd/GWiVq
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7k1Dp4MqF9yGaEmDfpEAI6cjo4qgj+Ti3KG/MLpUgZYFug73PjjpFgKqeon/NSg8b+HBhBeGVfinQWNaBncX6s6MiVM54ObfxbfbYhhntyT2ZolN2htUrzdzm5+PRufwtEXVnD7hJiuXhokPWCcc3AzM9uaOpjXISjwh/LxQmyNzMJ02vUkyH0O7arjUYcYaBFxxhRBpeTcUEmFKksa4lZQw9bdaFsoxxdD8N5XAR8hd3utX+TI+basu+v2GLedYfTCFNqe8PFK/8/hi+BbhoREuW7w6N4OSQXE5ZGU++S/BiwQKoye+gAyZ8EAx6WRN86SzWgd/DvUPwdJtn2nBuLfOewhlRfBkBeZov4PZrbkKa70h0jpH6bxCF4wMEQU8o8Lc4mq7ajFuFKsdNAvZg+yiXepX+DIvW9AEAkbhTEqfme3z6MQ1y4hrO2jfjN2m
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:24:02.2992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38355393-e796-4ad4-4852-08de8f0fa12c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9559
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9761-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,0.128.44.128:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E53BC367E56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the fallback compatible string "nvidia,tegra186-gpcdma" for GPCDMA
in Tegra264. Tegra186 compatible cannot work on Tegra264 because of the
register offset changes and absence of the reset property.

Fixes: 65ef237e4810 ("arm64: tegra: Add Tegra264 support")
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 24cc2c51a272..af077420d7d9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3208,7 +3208,7 @@ agic_page5: interrupt-controller@99b0000 {
 		};
 
 		gpcdma: dma-controller@8400000 {
-			compatible = "nvidia,tegra264-gpcdma", "nvidia,tegra186-gpcdma";
+			compatible = "nvidia,tegra264-gpcdma";
 			reg = <0x0 0x08400000 0x0 0x210000>;
 			interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.50.1


