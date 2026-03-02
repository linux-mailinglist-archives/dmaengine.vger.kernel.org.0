Return-Path: <dmaengine+bounces-9172-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHkBK+aEpWkCDAYAu9opvQ
	(envelope-from <dmaengine+bounces-9172-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:39:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ACE1D8C6A
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 445B03035F65
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717CB373BE5;
	Mon,  2 Mar 2026 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jQTCPOUo"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307C036E48B;
	Mon,  2 Mar 2026 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455017; cv=fail; b=caCEOPxYt5vyAyR8kk6S9o1rICV607gfKDjdg2qK4T1Fcme7KWgcRcElO7nuZBoMXx7VIt59ADexqH8piyu4+n4VhhvxAkI9J5Kt3PrARwuuEF1HB/QY/nZPb/s0l457hOlp0ckWHaDhEbnlPofYhYnvf0JQwEcLMDZcy43WafM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455017; c=relaxed/simple;
	bh=NDcN5ScAigBowCNQiSmrSxANmDvZo0U7Oj7yR28muVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kj1eEgyGz5iSfteyw/kmS6q3Md1Tyy5h5btfxY31X6+Pwul/hBMn3wHuRBOVb5xpSOnC/srW3mboGjK1mm7YQY1kjKL/frJEm8vCz8++giU81ySNQ3G8aDvWhcDp44TDqMZRpfL9RkjgDg6dWMTOcr7R7TNnwJSBqksBBSftWxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jQTCPOUo; arc=fail smtp.client-ip=40.107.209.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyA1jWdg3xiMakvP1ZlOq77DvIHhQbUr1GUHqmAU7HaySpM0CZapfZmEs/NLDBQEQYSvLEQUrzUXfxUn2iX7Dn4Ba3vS8IYODhSJd6e/BAd9KD1RGTiIB/RKaFDun07hkGCYgYu3W8yMM8PQx90JwSIQIXrZyYA5MQ0/Y9dWPW1CQGnv60h+y7ya600jBfxgwGtSaalJSB5Qa3q9ucrdcraiwO/Vkx8VXBH/RAyh378Tw/GIBUHk/5NqsqPdbX6uPUGVYVYg2SBYRdCxUlo3RIdb2bE1psjD+LpMmpWzQDUYHIKVxOe+eJ6fyyjdjdMmuWDBLESyORlgeb8yW2pfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXQV5yMCUUOGlqMBdeGR3r793DKFDWhvQo7TpCmc1G8=;
 b=vFuKG9Q/AexOHclwSdcPBMrd4/J00xU5va8QOdBwpsNEt/wf7S76aIkJ4BKD+aRyqmS0mW5PijMdEP4vqPIwIuCf8//D4hBCnfwaDa642iQtG3gk68ITA8ylZIdP62IjvAdjamtWIl5N7gHIqQ20/ERAZ5VcZdyWTsqF0gJ7r8PLWJB4a1LXuLHLX1IBVJqbm7UujVMDCXxYQZi6bnufGTJUMSawU7FPfYRn9b2BDctIYLnTAaThRMARjBygYFYX7rFeAnTry15GYzYgwZVNUyle/eFV6PaQLsCNLa8ohkz5g4ayztrfs0SYPjC4sBEPkoNSLdF5svIotWSJkLAeCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXQV5yMCUUOGlqMBdeGR3r793DKFDWhvQo7TpCmc1G8=;
 b=jQTCPOUoUKdFdcI8yQ0SB4GiIGemg2x9EnGkb1/SAJTTZ24jRAOhs75W+Bgz45KF+yK9WciMlWQz/Sh862UU3krKUDCEv6wxWV9RuvmrRqUDiLvTRvqlkXSVK+3eczgLMzAVoe/NyYQwWC3Is6hC+uZl+Oz25mlfjUH+d7BLZE3EHWI8DEk8YoB8myWm3MDXWZan/E17b3HOFIWchFtY7jlpSRXq9cif3Wrcfkcb4Hbbzafwyb/ym4/4RbYaLQeEDCpgCDjxhYIXPzhSBiPOpIDolfSsr+9GfyrKRcGi4rvOEAUDw5IjnSNbkz0ryJbv15lqQy0c2rJ23fhI7SGMEw==
Received: from CH0PR03CA0270.namprd03.prod.outlook.com (2603:10b6:610:e5::35)
 by BN7PPF49208036B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 12:36:53 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::7d) by CH0PR03CA0270.outlook.office365.com
 (2603:10b6:610:e5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 12:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 12:36:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:36:32 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:36:32 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Mar 2026 04:36:27 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v2 9/9] arm64: tegra: Add iommu-map and enable GPCDMA in Tegra264
Date: Mon, 2 Mar 2026 18:02:39 +0530
Message-ID: <20260302123239.68441-10-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|BN7PPF49208036B:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c78b01-3482-4b34-0698-08de785861f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	NdkcmNli6kFdqjmoNVL+hGM0/6ECxwU7mJGC+fv+xHL5knYKL+TIuqxA5S0fKIAoalSDKHhvvZmYqgTRXidZZ/As27PIN3wD+CUMtoGSRvRnX81qTqy3iML8y4DB93jjlsGQ1NNRwNsDam9u0whwy0j55vy/cXmdguTYXdzq6SZHYzq1eDXGGPfXoZHb1uPJ+JtrYgiQu8JwGeOaSgujMcBt8JSqScJaU0Gp0zYjlxnF0wPjFZxbvIbIkdwS1IXlebiNxtcTGPApmtzCenf33+NJzI88SgqH8AEYFQ71mRX8z+SuT3yPVU5tkd9SKcuZE6UIL8optZHWgrliz61d5eU+DURp+oRnaa5+TreGsNFfZEY84ywYltKxEE91bTfEOi4bTq+/i/ow0wVWFIp/XTEeFCNlkyEy55d5FXl4YUNSbXdAA077RA99p8se6DPnuXgBHc3+U2p9BcuTcUDcn3nyR4oX6xMmPQ+ciWtD9q6KcK3XA+G8HWZcZt6JYFifOQmOg695dehioinfzMgE2E4cPr8WHwU9pHcVzHvE85MT/kghOqXkUtwKRnEkavCeR8SFimusGenEY5pLeucDTFPLOasl4etWVoBKipWz5frsShIzDzAmAwP9fSgYOwP93y0PH/gK8WgS/dqgj57hV88PeFzFwT4S/rTv5zr3x1iOP+xnzhk62l2pSxijFtTS4S8H925hh3P02hbcX/x/ov+HiHImW52vXSV91YCdhucwohRLg0AVbUAfZvP06rP7bil/eeBE5g85wA1xnu0ncs1Cy6OszKvDi4082jtAODySBhCx1XaMB/65d3UBCu1AYsNoA6M2/7dUfgrJh4QEkxAkUnj1g0WOT3ubCplbKQ4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FFWxFNbKp6c5JFybksUmUTGzgtrvMozgIHheDV/VEMYFnS/GcFJ6rBelEhDaQVtsVtmIZWFHn/B2Xv6x/IklpV01xePBeME8TR6X3VgDTCKO1TACa8HMn5E91WHY0Ab6JD9DjSTd11TpeWsjOgVDRnx1TUjFA+WF1kotu28WvO7nMMJly+uVju4s34sSACkRoNODLOA8GxsU2QMFfYuAnoFZz9BXHY9G8c9XLYM6mNU8GP4+CMXGFOnLzFar0/6fYQdOwIKgXB8V4Zzn+gHKf5YdfhxSGjF+5OQGc46u3eMxAlTyi3PvjT93WOHpkeFW/SAqTOXEPj5aX5XfCn3dD9GnP4ROd0IVkk1y0O1bFF6xJeEQ2z9SJLqKq20sWa6XzPmhbk9ywjv9mnymg4RWrrVgA2HnsDgKGU8NqefLeXcp1C4TPNdPP78Y8/xaQ/DO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 12:36:52.7717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c78b01-3482-4b34-0698-08de785861f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF49208036B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9172-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,c4e0000:email,99b0000:email,0.128.44.128:email];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[226.204.49.0:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 48ACE1D8C6A
X-Rspamd-Action: no action

Add iommu-map the GPCDMA controller node so that each channel uses a
separate stream ID and gets its own IOMMU domain for memory. Enable
GCPDMA as well.

Also remove the fallback compatible string "nvidia,tegra186-gpcdma".
Tegra186 compatible cannot work on Tegra264 because of the register
offset changes and absence of reset property.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi | 4 ++++
 arch/arm64/boot/dts/nvidia/tegra264.dtsi       | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
index 7e2c3e66c2ab..c8beb616964a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
@@ -16,6 +16,10 @@ serial@c4e0000 {
 		serial@c5a0000 {
 			status = "okay";
 		};
+
+		dma-controller@8400000 {
+			status = "okay";
+		};
 	};
 
 	bus@8100000000 {
diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 7644a41d5f72..9821d085c766 100644
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


