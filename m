Return-Path: <dmaengine+bounces-9763-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JohA5Wiy2kUJwYAu9opvQ
	(envelope-from <dmaengine+bounces-9763-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:31:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC84436803B
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB25D30A9977
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6B33EE1D8;
	Tue, 31 Mar 2026 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I0TVemAU"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E33A6B77;
	Tue, 31 Mar 2026 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952661; cv=fail; b=k2uFRoG+x1D8paLTT0VdmlZdH5eYN0z1HBrA4JHVELXQvQEXhgAnk7dH9hsjpEzmp69sj13ox8lmRo8VhZgg6jX/kXaHuiBc8zURMrIWsBNEl1lWT5uUAiplg3awIhNqcM2Lp25ttTB+au6DxNdr6BIEGZFTeFYRk2n6jOcN7o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952661; c=relaxed/simple;
	bh=Ngs8EPNMcbZmCb7C00t2bDxa3rlI6qLzn7lzhHMz14M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krDl6QVoj2KKQIx5CwclWzozCsgRVolVlyRiYfkPrc1JIchAC3HWfshwg0uyqVTu40Xp5r73+Tlru2ZyFfnawQ0nqvGC79pFCrgZDPGXYJV3G+rg4cSQNhX+jT1lBzvB7MF2WsV+ldzx9ZoJelCC+d5UiqQqeSWnFoz2A2GVYoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I0TVemAU; arc=fail smtp.client-ip=40.93.195.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5sclkp3pR661Hm7ThiJc7eGEyeCsE/4NFHi+PFusV877hR8PoB2d3+c488xJdtJnx5FM/z5yS5J8GbpGgEo6ajeKG+iGb8iqCHZkloZuquTawwR67bSsXrLVHN2IezTwxzmd084LhYP9zFfmaCD6bsOCAROrTRey5j937Bc5J9syG33V+aJWEa9hAvzm6QJzcC8QLhI6xZ4DiMqIHzvhxWpWqj3hbE6Pyu8Ixx7Gt/TSmvX+j7nf8RJo+0FlIfUddrhhq1WMfj5KNiq9KYp7EnvIPmuhw+rIsBuNNUccHRpS3jGkXZhICGQrD6qiIglW4ZvoSl8zHzEogX/1Oxozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhxS1xYdxOO4vXubyanW9eEpLqgh+V2kvpwL19Nm5Hs=;
 b=JX9pbWT/m+5mTncfQRxqblue5aKghYRF4QG5iNbZlOc/vwGxZ+P7fbU4sUOCrmSYolbv+zodMpZmFzm5RqNFdtngBvDQD1f08awo0TqQ7/KMxAZs+TLomEN1FCUoDyEKOPDyjlzONVexBESRxb4pKNUM+FKwHxOtiWwLUH/x3zlnn2t+kBM+2MFBANP8QpszPARRIt59rIwuYUDZCrsL/xpDEVXKJmD0KPICXN3/0XX1kfxgAzxGskIFzwzqC1LEiWiI8froaaT93Vqzs3Sjc2rY6St4YbLUX8BsZaU/U9Ar5hsn39D7n/r6vld0jYCvrxsziuML8x4Xj2g3/5KneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhxS1xYdxOO4vXubyanW9eEpLqgh+V2kvpwL19Nm5Hs=;
 b=I0TVemAUyD9W2NV3WH4tt+valxAnzc1QvnqTQ4c9NUxGgCluKOGdVVAyHBbz6i7FUHfNSdu119ch60FIsCKJnvse7aDrJUIlKf0pdHkpqaN5RbGSIi5DhDTGPK2nIgBx1SxjBF9Z1PLSsN0Ugto+0pSfn6avYNXmFSucqXwHoH4umEjC+rUKLikFIL8TcaNhJ1uay6t+fh0UwmCOOF2ibd+mqFsfE7z8BjE0swyJrG7irZwwkUKcZ2fW8b01Fq+s+7dUWnzrNQTa29v1DYqGqypGTBotAKpnec5HE+8au0SLTjcYNY58SXLalw03msJ5DzzwRGPlTcjuw0LMGM4A/g==
Received: from SA0PR12CA0029.namprd12.prod.outlook.com (2603:10b6:806:6f::34)
 by DS5PPFEC0C6BDA1.namprd12.prod.outlook.com (2603:10b6:f:fc00::668) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 10:24:12 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::ce) by SA0PR12CA0029.outlook.office365.com
 (2603:10b6:806:6f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 10:24:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 03:23:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 31 Mar 2026 03:23:56 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 03:23:52 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v6 03/10] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
Date: Tue, 31 Mar 2026 15:52:56 +0530
Message-ID: <20260331102303.33181-4-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DS5PPFEC0C6BDA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8b724c-cb9c-4b81-c823-08de8f0fa6db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	y1F4b6hqaTHx0dtzV7C5+gPA5uRF64nlpRr/fxOS0VSAXjBe2bJjW+1nyyp7GgfJ57HTjvl0/agM/krJ0Nwtonqz8o0UkvH++F/pOEXN45ICT7qJAuOPqOudE8HHUh3NbCpXN2Tl/iRnSRzlSiqdfl1ID4rb+9y44fGSXacVMjVnP5YxHX8iidcP7b0Dh0/uHCFk0RDEM6Sg/+Cz5yEtani5fKV8BNiW9mGK4ZpQeU/hucPC/+gOBHBN1TPqk+GQDtL5KQ1Pi453CQ6/25sCDsZyEK2opLwhfMV3NVtqkOC8eXoiabJeQRqe952lLkdf0J8VqkO2tCSGJzsekCMrGau7m6+fjzkSScMgH4r0b5nAf+pZshrxDmFM7Dd0MYvL6/0A8Kv5+km95HxaAbUu+8kMSwsUj9ROyLRFFrdYCMxNNAWC3Uo0RHNOVbM+f+rIQ2BfXja9mjzTNibCc6x7qEizDRraux+u7LrM38hS4Ojsn1u4Sox1k8h036zXhBjlDLPId+HjLe3sQH5KXh1navrThkWk9dZOGoP+o6qNt2z4kzoezx8UXFrbRgpYUrYfEo5cdVBMSFQmZ6y3gQKnKJlhTP9ZDyDLIi2MnKHk0TRaCsvZ5LldOpkwvoaX+TBDVVxofh1PQ72ojwdsGpxKIDBPfwmZK5G4hMVtG7Y40cTYd4N7Yhu38BxoTVpQ4T8X0BjW75Lmb6cK6nUuAE26ZJGjm8BE1cVrN1bHJjggshyy72ahhcOdRMeq8v5yncSpgXI/gDqYVpZa0xcsU19zp9etAFZH4kLnzlbb3QD92xGTY7MiZay9Wp+ky25O7fcN
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HHfa4OphvnKmhnofNwCnr63tu+qQ7bHubXf/DNNBLP098rKm+EzgWSg+MJPnvA02R6YM/q1hc3qIPaYti9SS2ZHQdXXt4uS9AO7DDUnqVhTAsFViFVKl52IlfcE0BWWWsisqh8pu9zSmIqwvhysL4lxRhxu/1QYDuXdHFnsp26VxLSi58kOyYCc0vJit1dpuJx9U5NDmTLPpG7xBtkwUcjJJ4t0sXJphqRsIqUKWukAw5cf/qtwOb9yvoXeaw1cQpRihcW6yn4RFXtk/JXmHrlvTvaYQcz1Ewx3idchmzPYNFeycpEcMoWwMHBqqDqK34r0tgfCQwuEurZOsN90Of28OX0P+B62Uyni+hxslDqJVo89uJGFXza4qlWjP+qBOTrlQfJZY4hCmprtsYCq1bl62PCXZX5CMQzqDodEK/QS6ddIV7zJjDLJknzSVjPY3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:24:11.8526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8b724c-cb9c-4b81-c823-08de8f0fa6db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEC0C6BDA1
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9763-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BC84436803B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add iommu-map property to specify separate stream IDs for each DMA
channel. This enables each channel to be in its own IOMMU domain,
keeping memory isolated from other devices sharing the same DMA
controller.

Define the constraints such that if the channel and stream IDs are
contiguous, a single entry can map all the channels, but if the
channels or stream IDs are non-contiguous support multiple entries.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index 64f1e9d9896d..bc093c783d98 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -14,6 +14,7 @@ description: |
 maintainers:
   - Jon Hunter <jonathanh@nvidia.com>
   - Rajesh Gumasta <rgumasta@nvidia.com>
+  - Akhil R <akhilrajeev@nvidia.com>
 
 properties:
   compatible:
@@ -49,6 +50,14 @@ properties:
   iommus:
     maxItems: 1
 
+  iommu-map:
+    description:
+      Maps DMA channel numbers to IOMMU stream IDs. A single entry can map all
+      channels when stream IDs are contiguous. In systems where the channels or
+      stream IDs are not contiguous, multiple entries may be needed.
+    minItems: 1
+    maxItems: 32
+
   dma-coherent: true
 
   dma-channel-mask:
-- 
2.50.1


