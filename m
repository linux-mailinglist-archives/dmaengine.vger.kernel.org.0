Return-Path: <dmaengine+bounces-9769-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONQ7HCiiy2kUJwYAu9opvQ
	(envelope-from <dmaengine+bounces-9769-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:30:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E85B6367FB3
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 883E7306D0D3
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA033F077C;
	Tue, 31 Mar 2026 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hJ3ofZMU"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D713F0768;
	Tue, 31 Mar 2026 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952720; cv=fail; b=HLXYlQ6a+2141Kydvko5+UpmnMKM5IwsKpakHIed9f2qNg8dEmReTY/uCtLmfVpUDMrO2afNFy31AdYn/wJb312RMhEvchqP8iAPxVDwxqssRzsAzNK/FMLzHov4p8FGfUniqPv7/4vT0egUIzOuBSOmCvSHT8lkkh731DU939s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952720; c=relaxed/simple;
	bh=S1s9eEL+e6ZhFAmNEYpv65ZovJCBkkZwzR7yhlLIEow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXVSMMVTbxXza0sUsssaIsxWt5oSol6O1o45hUW2IxMsbO9Jmm3gNAaiC/KqP3G9WlwU6GgRxjBG8UNFhLOC9PFVNRHZi6EaTXrN/zbOSAOu4rbVpzwEK5LI0z6z1Wt03sUjg+BABzKqVxdfwnN3HxkSLxBFBoPVomex8Qj/Xsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hJ3ofZMU; arc=fail smtp.client-ip=52.101.46.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElDN2b5G2L/smNmD32I1bLCkN9w7LrKGyeZ/4SLA4Az3Lih9X/1RYZy7spzaxLIoLdmq6Dvitw3Jn+Sd6bagDsANyiujDCyh0Yiq5pH/2vhwA00tksXpXOETOwOsg9LmB1WLpvYNM8am7knra72mphIg4IeX3BhPa98s2St/+QTiw7HCJhreh6+zMSfALNpafpXzSnsGlJLoDvQnacj1uhwHP5pCIK8p7l7juQXcFfYPIrnXJ3ml7m+xWfRqZ/0Otf38gOZWcm7C8CQn0mrF4jx4embmqMBDwDhVv8F4N6kTi6LDkrsVYdRg8K8zKkdtdLcmZJkJnBEgJHnh5H5ILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrBIbZMyVZaLHD0RxJdtH7oKyBdkos2HKFAeioE4AKs=;
 b=HU37BzbvvZn+XBdEFzOoY8Yz2npes5wi52JTSxmB6wQNstVweRyLHW2CiBywYS3c/2851dF4jLBcJoUHUBm2pk1jQ2Xs/MFI4HSYQsvbGfFpm9oH4KRyYRzjK/g75QXEi7ZmySxPc/uf47sxfuk/QES6gVBt2akTgUFwmCGxtoz/gW0wfLi+IG0gGagl1P48XDp4oKYyf3kMJQBcEEVvZ7GwyPLlOwopaQG8dfbO+1xyqVbYFgj9ZcOeOY/D7wMm6ULVK+J+jWJWoiZrlhc/KjcvgjXCxyZU1J1Lh982Te2LAoCu63NF1QNe3WrtJguszC6FBaIDPr3kEs4AuTaVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrBIbZMyVZaLHD0RxJdtH7oKyBdkos2HKFAeioE4AKs=;
 b=hJ3ofZMUsdp5yogVsNgAVv1Okzl/qWhTdghyiN38sDJpiMxXqNJCQd1x6zfSM8f639nY6LfG8FAHQCWzkTzE5eehzVIvGevruU34oclLHagTaAR7SyXnBL/2AIhOvCaCKzj8fz4Q36TINnSHzOfhe5tbz5kD66nH4yVdzYDQIiqGFroBJsoLV0PJ0FANGYvRJVN8tbWzUqROxYAQzfsCLe4AV8aymopWP46mbJDWj6Y4JxCVM1zefymEO+GMQIsQ+yx4JrBffPRqoeAV29n3N1vcAm8dhXhgkeeRNqkY3/Fjjm4QHEtdib0iC19cT747AIyQBoW16iunIZRRR+OO1A==
Received: from BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::13)
 by BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Tue, 31 Mar
 2026 10:25:16 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::bd) by BL1P221CA0025.outlook.office365.com
 (2603:10b6:208:2c5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 10:25:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 03:25:05 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 31 Mar 2026 03:25:04 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 03:25:00 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v6 10/10] arm64: tegra: Enable GPCDMA in Tegra264 and add iommu-map
Date: Tue, 31 Mar 2026 15:53:03 +0530
Message-ID: <20260331102303.33181-11-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|BL4PR12MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: 7974bc2f-6849-4744-701b-08de8f0fcd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VJZ/ioB7jhKBLE0uyykjDMQttDtsH3UGwQHV0mnaXENbEslpuDtFRlBPaRr5p0dmnqpq8BdEh720NwCW3Iz4IUujS5Cau/DvOYNpS0Tpq1z+iPee1tAnSXtSXfem3dSfaKCuHRpmuH6V8QrDVeiJ/8gTJlJZjn+GvswiHyxLup10dSnJL80NyhItihx4TRnzImdh0YXEmbtUF0UENZsE4xXhvMyyQXtn/F9hjOxhcqaGPPuS1aGZlf7IVqrKxF1GVdsGAGXpQ2QD1si6Jl/wRPQAfdfBIzkmyAo4JC/x5buE9W5kdyj+bTrEw+W0H03lkmGR/42X1tClstklBwyLrp5/GMa2InmV1lZ4yqfDzvd+//8ndalpe6vtEpDxdIrg/PBsIpaHARii7s+LcfXpw4zkKQmgkUDbUqNvEp7AnAmRgdcSjMo44b4ZlMM4GIVFlrc0s6rffoZXmhaZvLnFiCQW2sHVnwV9ycBVe+kl9uJybElGm6mYlcyq8il0mi7CSARUj3XsbSMXkCEntCRXhluR303AbUNk8MEPuMSt/U6TqKV1mvuh8OHu93GB6qJCLGTKvnQzHIhs02BggvuTBVbr4PIFuK4h0NOrDX3FBfmF9VWpRUokiLZlOS1T4LoxArKhrrQkP+Ps4NERk4t1UECfejdpiQalQYDC1+FSPFUvkKqi7266TK8xZM8r3ouReZdQQkiacDhXMsy0mUMJSXHl9b5cwvWYN6fyfd3xMQk9Q1H4StBwBDZSf3JzE85ShCEb05pbpy58suWIMlmeCOqQv26zBl20Qlhbw0Gl49UgJIokkxKL4eO/WPHXlL47
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gbZLLwqe6Hjattl3GorSYZYDflFoohkzyADEu2EFQaz+O3dUXkC8biOQ8RoporYtT4Y7oWWA6svW54A8wlkEms38nsk3ADrp6Oab9PCaSVR+iqkIinq7tJzxlOzLw+CcSvOdapTzYEXu0lVBTGtb/TLrTPD1J05jHLPLIf5Lf7JXjH4+FWHn8x1ISWBRZvLnmY3LdQ/EmxWMttAxBc6jZBPNYVEIXGiBL6+NEeL2QQhNrcej8JxFuJUVu5ZjJ/5Ln+7yriWHmUvsD4DlTu4uD1Brr+wJwpCrBE5oOJP8MX6F4HMnay8J0F0Qyp2BtJsFVjFYsbXcmWy81cdLdXPQsYfVsIhcLtMpPgtosJyvPHWEuxCZVp8bwtqUDK0FD/SmRzpLkaRYQWiTdvVU/KxBFtFhasknei2EIPlNMrXxZnE1xiqQRnbatoxdHnaGKtdJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:25:16.1674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7974bc2f-6849-4744-701b-08de8f0fcd3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9478
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9769-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.128.44.128:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,0.0.0.0:email,c4e0000:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E85B6367FB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable GPCDMA in Tegra264 and add the iommu-map property so that each
channel uses a separate stream ID and gets its own IOMMU domain for
memory.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi | 4 ++++
 arch/arm64/boot/dts/nvidia/tegra264.dtsi       | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
index 7e2c3e66c2ab..58cd81bc33d7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
@@ -9,6 +9,10 @@ aliases {
 	};
 
 	bus@0 {
+		dma-controller@8400000 {
+			status = "okay";
+		};
+
 		serial@c4e0000 {
 			status = "okay";
 		};
diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index af077420d7d9..b2f20d4b567a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3244,6 +3244,7 @@ gpcdma: dma-controller@8400000 {
 				     <GIC_SPI 615 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			iommus = <&smmu1 0x00000800>;
+			iommu-map = <1 &smmu1 0x801 31>;
 			dma-coherent;
 			dma-channel-mask = <0xfffffffe>;
 			status = "disabled";
-- 
2.50.1


