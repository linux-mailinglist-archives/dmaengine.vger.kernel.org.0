Return-Path: <dmaengine+bounces-9663-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLjdCz4UxWnr6QQAu9opvQ
	(envelope-from <dmaengine+bounces-9663-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:10:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D70334203
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E76A9303B01E
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8560E38C2A9;
	Thu, 26 Mar 2026 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VVxfM73k"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E733D6FD;
	Thu, 26 Mar 2026 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523435; cv=fail; b=YxxW8vtL4ujE1n/6uVhC9E7IvaQ2TYoTTAkFVaJccSUQ7MXr76mrdUqqZLaLMQSj0RG22UtOF4vmjnHfHg4foozEg9XIREia6uleEziIl8E7KytvdVNAV3i87AGEhpbQj2dDqTk7DQviJdkr3X/uVXYqSzTuvECZi/Os9jT7e8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523435; c=relaxed/simple;
	bh=cOnBdhYDJjoOonyxy6J9cOVn7VwNuWKKd4gElnOThgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIiO29+7tBGlvgJWCgvj7bFjcNrbY+SYGo38t5qDEMKO4AKGuj4+ODZLabiDPX8rIViQW+eAJmo3hodGC/JiWwFP4BoPSKiro3X0+0ycuYUFGZ2kfEoKwcu9RiHpQk9smX8hLwBNgGnrlxFDV67w13oe+mEO8oBRgto7G8JKRGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VVxfM73k; arc=fail smtp.client-ip=40.107.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WujXDPc0BSBlybje0kw+EFUtELCPpTBSuCzOK/BDCAN1yWxLS8At6mZn/XdREO3Fb5gA7qKXEzPGWEjdZu+rc/aJzpyBFzqTXBKxA8Wm3X/MllJ2+u9752K8C3DWgPaT1ZCSv3bX2XfsGq/XW/+9HyRDP8FXKAWB3nnsf/ecdG4sxOt9b4vBTrdGGRXMxrtqXbWEk3Wqit/Lao1HWU0yxLPM45Nq95S+f3wdrzXiIkLRTbCciItvIYL4T77DJ6pI/dF1YPvVqsejGDkHNxZXvoqLPBeNqKyRA1mTERGN8kfaG4Nt0SqbxdW04PkPweD3JuEnYrjQsXAdoGc7WymgLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdZOv3o+BgQHy9YFiHEoMmPHqXWq8rBnamTKAcsnLy4=;
 b=Ubl828TdtmzvGlvMGiHM4Zetb87yXGp4TPc9TP9+IGQYfi5441YUrDBoj8maM11KlX9zsUA1lEP72Iya6EoNY4KNfHfSw8++1aCdw1eUTJC3dIXTzBkfRyIJkbC3JmYzSSSQyPlL8xuo909cNTt/JxilIoZT7NYaxraelTs10fH5A97M+APO2glHr2o2edxQkrMjwHO3diSRAGGw/YaTBNBQjthUO04JeSoaEuoo2TxuAC5O27ifrXdQ4YqWtHHpqKiFgHFTNOfBsnYwnS9B4H8fwLpJ1mlT8WMK3zorE2aq3TKeVzJXPE7euVUz+C/epdLOum2uxllGLyfPgnwVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdZOv3o+BgQHy9YFiHEoMmPHqXWq8rBnamTKAcsnLy4=;
 b=VVxfM73kjHBTHoGIDJzk7Js2sO+kvWvkPSydGNqCrvFXywR34totjVFtZVq08jBr4hdMaqcL2AJAJYuufaPqYDU/r07+5wMNsZTrufW9msbWkcPPctxd1hrJVNbkRQr8FT2DqHmrT2CvKzdYlIrG1PjEjHt9HWd9MZJK5MF0tOOyxz7fhpQ8waWk9YeELji34H7WK4JzV0xaiaLTHlkMAfLTWpSbLyl6GumwmGK+vsF3axHfy4+FsHdL/+cMzJibfhq73LfxsUBMN3mFxnEc20aOftKfY4GJuCZhHo4rr7prInGAUVStUhrJBS0kqpnrQSZ7PX5JAs0qRR3ChhG39A==
Received: from CH0P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::28)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 11:10:28 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::36) by CH0P221CA0047.outlook.office365.com
 (2603:10b6:610:11d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 11:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:10:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 04:10:12 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 04:10:11 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 04:10:08 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v4 01/10] dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional
Date: Thu, 26 Mar 2026 16:39:38 +0530
Message-ID: <20260326110948.68908-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326110948.68908-1-akhilrajeev@nvidia.com>
References: <20260326110948.68908-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: b9bd90ad-2dca-4b72-a7f0-08de8b28494b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CMR2zjrDJALQ9tjIES+0ZbBwEU3DAvwSL+ZGHZPxRQkSV0HcCI1/0jZXJErLHiIzcuAFaRfLG5yoiuDYX6jidKxv3KOdZkG1fRG2idrQuDdBGac8XG/DAk/9IraGuN/UrBXVzrtMMXC78G5Ahy/bYsibnxr7zVTlkYZCTZLHlqlLnpx3Qt86dVOdZJX6xKfZhV9m1/LUTxYrEhSS1lhfaQR5HkaVn1Q0Omh6+yBlhWVv4JFuv6izkD9/9NabA2Ie80JkrY6M9ldm+bG6FTXX5Ro0fPtncqNCP7OcbCyY0Noaibn7EiqrcdFnJyGuezNNMja34PVDGcxAabXxxNfOGFDNJazr60I9NGcmUQUADrhWUX9Z5YihWvJ83Dz2bCqoqfb1lYQFBJwpyNsS5fzfqvmsrcUP6XMLOyN2SmNHmVR8bHXFzy+K5ktO2idYHU4cuItMKLYlIK62moqr0snMfM8F5CTP1AhavYIYk4YAfvVI5IO8bKWkInyvLHmbME7cOFqC0B7mOiFVHRgRiI1hDwMDd510qy4QnSzSJq6SyGXSe+hObNd3mCpatQFaK5xjh8SRTIu9iHFugMXUA8mcdbeZI9FqBWE/Xz5Qq1Gf5ay2h1EOPzbQRwZV/E6qftXYknnbfNqVS2mGobkeh2L43ub9mv+lWAQnXSYW+D1OZHg1FWqt1itwH+CKUG+t0kgzO1uvguXvLF6UVYejOGk88xeXbZx5WuGrXjNZHPMRFyWqHWmnBTFuPnv/WC2d0Vyldxrxk4VEDRDPdLw1WoVFmmQ5AVUQGRN4TzWGNlbmqQbvisj8xTdmOgFgUleQICAf
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MiB6l6Ud9nyeXGrJhzHWAVUHuxD8IPcYYy31YRXNlT7dB2TBqyyvAfQq2KWTLjgK9TDETAAbZiZlAwuM5eAwop6bMnkJlu4apBltQyUNcnvteMkyXDMoPC2fMNToEZvX55SnJEzqvOfWtbDZiQwPrgBbD64oNq698eseeVixtfawdMdP9ogXKsc/MVt/JDDJvqarg9OvR6IfHQqA3uNJzBeIbbPyY5Q1NbbFCoBgmJbyjIacpxhPlQAG0OpPKy6Ch4REPJ/A0JvdMYY05ScCjbJN+shQQ4OVBQKhX4ISCut267ipJ6w9RkeOpp+OA60L6K+GC+gl6aiKnH1rBoYYe0rVAzocCGqw2Fbjt+lp9rHEzod+fDQaaELs7SjtT64oAf0Y47RPt4j6jybC0AQtdNiOKsRaTL48KYApYBOcVDeTvSmULM050ok6e6safLGQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:10:27.6480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bd90ad-2dca-4b72-a7f0-08de8b28494b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841
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
	TAGGED_FROM(0.00)[bounces-9663-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B1D70334203
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tegra264, GPCDMA reset control is not exposed to Linux and is handled
by the boot firmware.

Although reset was not exposed in Tegra234 as well, the firmware supported
a dummy reset which just returns success on reset without doing an actual
reset. This is also not supported in Tegra264 BPMP. Therefore mark 'reset'
and 'reset-names' properties as required only for devices prior to
Tegra264.

This also necessitates that the Tegra264 compatible be standalone and
cannot have the fallback compatible of Tegra186. Since there is no
functional impact, we keep reset as required for Tegra234 to avoid
breaking the ABI.

Fixes: bb8c97571db5 ("dt-bindings: dma: Add Tegra264 compatible string")
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml | 25 +++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index 0dabe9bbb219..9f9f1a30e139 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -15,16 +15,14 @@ maintainers:
   - Jon Hunter <jonathanh@nvidia.com>
   - Rajesh Gumasta <rgumasta@nvidia.com>
 
-allOf:
-  - $ref: dma-controller.yaml#
-
 properties:
   compatible:
     oneOf:
-      - const: nvidia,tegra186-gpcdma
+      - enum:
+          - nvidia,tegra264-gpcdma
+          - nvidia,tegra186-gpcdma
       - items:
           - enum:
-              - nvidia,tegra264-gpcdma
               - nvidia,tegra234-gpcdma
               - nvidia,tegra194-gpcdma
           - const: nvidia,tegra186-gpcdma
@@ -60,12 +58,25 @@ required:
   - compatible
   - reg
   - interrupts
-  - resets
-  - reset-names
   - "#dma-cells"
   - iommus
   - dma-channel-mask
 
+allOf:
+  - $ref: dma-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra186-gpcdma
+              - nvidia,tegra194-gpcdma
+              - nvidia,tegra234-gpcdma
+    then:
+      required:
+        - resets
+        - reset-names
+
 additionalProperties: false
 
 examples:
-- 
2.50.1


