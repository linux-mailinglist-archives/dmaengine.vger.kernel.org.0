Return-Path: <dmaengine+bounces-9442-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGZYLR89uGmpagEAu9opvQ
	(envelope-from <dmaengine+bounces-9442-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:25:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDCF29E248
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA3A7305CE3E
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 17:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F94A3CF665;
	Mon, 16 Mar 2026 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Thsvp4u4"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB94326D45;
	Mon, 16 Mar 2026 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681563; cv=fail; b=U1mjgI0sBdMohgw/Gx87NTGSf7NJTgaTiMWX42F+M0Pdmw1dD5EGAmWQxc63RbC6fiMyNHYLg9M1zDKGr9Aah/ZBN13He/HHTyI/B2+zgjsPHIwavaaQ5OXjOyKGqroVGszhngvZCwt9FI5rsYlfPtAdayqqbWF40kouTpnMn04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681563; c=relaxed/simple;
	bh=pF6hxTFOmPwCqyi1+oE9QH6mAlXtwnNlCwZ1k4Wsb8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZ+/y4dYr+sJHpkkxmD+7ja4duSfpdGhYf3SyndEOcyw8E9caRCH53nQSBJkEBdpOFpqZ53abzJmBecO/BG8XnlvUV/9dgS8J7QxYtG3OQp7zCV3JPXYuz1e6mdDSFKphUr/4Mtj7JrDDSaL/7VTjI71jh2WMHCW5Al1fyPzqMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Thsvp4u4; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MM00ZnPwbu6u1WGee7FEtbI8ot6N+2FZH3pEWMYOuo9zPCyW36sAFcMlQLOUPGXjJ7IyfERH6QZOzT5NGaGTpTZXrvEEdG/m12x0t2EegYd5gm79M/voNhj4tRkmMy/Wm6J4BcPEFx0ckYfyqMm9ux9vEcNJdvttuezmKJoAMkILStAfxIONduztunPIeE9ULQz5iazyKsF3ZVYco+mSIpmPpkelh3SIUBbF2ZwQo7/6sZWDvHL93gRyQsraNh0UJzNESniSkUXUz3Dyhbf/ifABc5deYXZ/0xItpZvmnlq8hgPXw4u0NV/cYCqPRzPtxcY4t8x0aka1zoxnWGRwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjIOaNOnRmD8OcTKpwui1y0WTJgy7HaVGps5etMSYGQ=;
 b=amBQLujz8Glt+ymcaH7yKzBuU/UO226ppNsT1uRGwNRkK9P/liI8/xFBN+S8sS8a+1tA3rn3Dh3ntamVF/88mzziIdDruHI/iEeIC3CDtW9+7wLpRXyv7Mgtciz3XralxOJexcBwrr5+dDVOEI3Mf6ZhPmRPXvrKsOMO9u9K1W6Ai/7zu7nSqj3n2oHrQocGVBhrHpWTyIoZuYWj6m0AIvMs8+Be87TGGzHsv8HK9A0JWBNV6LdPS0n2Xkld6xyQMhzB0thCsO6I/XBM1x1T8mGl0/ZGynxocc/kfgJp3Jladr/UcmFJyoejlxZ+oa14RfQxgjBag0O0Ze6VWeKkug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjIOaNOnRmD8OcTKpwui1y0WTJgy7HaVGps5etMSYGQ=;
 b=Thsvp4u4f0rn/FONfxWpeB+DkvmOZsSEbtWeIF+tI9hLXMJw/O47Jb+ZUmC7xHbKUnmVunYZAhze0aIgw1IEBkr02siNurFBDdMUxUqnWt3TLw7A0O73U/w7uHwMK5CMXaw5LiS/EruJaUnLuAS/3fnoNyl1XyNUaf+046xS3YrFpO48z1paGRFYWXk1sJyKreMqYrj4tPVZQg64Sabd0rqLRkmerbJPr7aDGb/iPCsw9KwTZmtIJCLNrk5NB+GB+EV3wSFz9av+M6OvH3J6t8ofRQH/m9odI/GjVIRs6py+Ak0ccjnEWEB7rW/4Oqqj15iEW5rG4Byx3HW15Hb3qA==
Received: from SJ0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::19)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 17:19:18 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::60) by SJ0P220CA0015.outlook.office365.com
 (2603:10b6:a03:41b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 17:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 17:19:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 10:19:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 10:19:06 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 10:19:02 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v3 1/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
Date: Mon, 16 Mar 2026 22:48:15 +0530
Message-ID: <20260316171823.61800-2-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 597fe6d5-db6e-49f6-e9ef-08de83802810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IIx+4B+RJE0aHpX0yOfFx0HqCXEO+UZ62fnNgJJHgBb4BaZAOwppnklVj+hMEqV4tjsg4njz/OHg5kU/TDPIZ+Gyvc+0zbUpERDa7Yf32ZPOpcG6o3qLkXHm25yfPocX1+OKXYQLx+dQMt4hZojnYGQx3zHMIBZJdgukADvLpWqTzAPIlQ53CqT9EsUn7aIidAkGWJG1z/0N5WDzU+18aCbNVWOfPZghgbLS1r+Los6Of1Axbkd1JNa7howvgTBqsM7Vb1WPpA6oSefFcK6SPBSonm20oLo2TidNZQ5aoEhjb/TdTqu/EDF9PqwqriiPPPrnHqyZWT04NBPylsdK90ICCgCsk7OnSezEREIv0CawKhxPmirNN652Irjnm+QgOB7wE0aTnMI/OVG1Xj9yJAJHzzJtHBd1vS7QhuqH/RFws1r+slkFAa7LHwn2747UQPiUwH19zaYxMF0pgj8wSrUIEA4a/V3KiiWLx/Et9J5n4rx/t80Uw3SWx/0FXUlcervxARgU6G1FXUsJtac8KGvt01b2cf4obfnLYaKRMu1gszbF3iMSSV+VQad6dNDqaOAP3yYK0NQqjZ+5YACTZja7ZyZzcmU0VNsAUTu0DhFf/aSZxK2TozWz7c7gua4iLj2nvwBtFd38ZC7Hb5zx68nKuuWgjwQvuZRkR5xDTl+0u63lbOpulPHrAruGa5xq7qagF2THYa+0I8KGCPpVZous9SIAaubJjZ+fTPHXaplXQ/f3ZCX+Jo3hEBM5GZbBeG6hz56PSBl2Fk+ZuJGKe9ZnKlfbB0KSfdPESW6gC5K0CDuiJF+dezhi8g0bgYMG
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JDLCOGMnBSp5Ly9KgtNjPAZidXxUq0d4wPM4pM6jU2hWJFqz+aHC8hgw+UqLGNZBKLPd1CyY/SAVKzydNeVgcAXnil6hSxndr0U+oum37vPVmiEpytLOxdE1pZHxsxMLCMoRXmmTpMKmCt5intWkolSGfc29JbaHGGHzqmsEYOBt+GMkojIKnUvDUvptwGb5p1mS9NnGBd1JOuIUgNqZoVuNnfUtJU9VH6NfqxNOF4auXkDlQWA3MGppVDMtkuo+V4FlPio4d/onWDXKgh8OLYv0vL2hFIHN6GVDD2GHPrEDRdRN2DazrbRI0DcLNovIbt9V/r/ijrYJbka5snGJRphgPYob+5YeoezOKgrQdp87+w388lc9k9Hm6qFErxnbYgBQZwFWtFeCp5TMwid4vdKgMDbVzsDCjR/zxA2gQmf11Ui/IoL+/W8XVZVjgDI2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:19:18.4129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597fe6d5-db6e-49f6-e9ef-08de83802810
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9442-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5EDCF29E248
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add iommu-map property to specify separate stream IDs for each DMA
channel. This enables each channel to be in its own IOMMU domain,
keeping memory isolated from other devices sharing the same DMA
controller.

Define the constraints such that if the channel and stream IDs are
contiguous, a single entry can map all the channels. If the channels
or stream IDs are non-contiguous, support multiple entries.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index 0dabe9bbb219..b5d8fd0b281d 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -14,6 +14,7 @@ description: |
 maintainers:
   - Jon Hunter <jonathanh@nvidia.com>
   - Rajesh Gumasta <rgumasta@nvidia.com>
+  - Akhil R <akhilrajeev@nvidia.com>
 
 allOf:
   - $ref: dma-controller.yaml#
@@ -51,6 +52,14 @@ properties:
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


