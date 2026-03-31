Return-Path: <dmaengine+bounces-9760-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJEFBXeiy2kUJwYAu9opvQ
	(envelope-from <dmaengine+bounces-9760-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:31:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 558DF36801C
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7353D30527C8
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7C3A962D;
	Tue, 31 Mar 2026 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="chpj+LSX"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8033EDAD4;
	Tue, 31 Mar 2026 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952630; cv=fail; b=AaM3GVSdtlL7n+wv4YvBy/FC2SlRW7r1mylXPpfVgR32QJ5C1c6wBQz434X4JkwwO6JKEKt6mYMSiNw4Rt7NQ1ZC5pZRRekPwpg6Ml0dmcrmIhjhdQWcU1VncHPB16McB9jbLd61Nh+JL0dC5nMnbFMUBOXaYhydo03ZVXlkyOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952630; c=relaxed/simple;
	bh=5dfbZN3cfbE09itP6RIr+gzBtx6aMa1BqQvP61Lm6wY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUSw8jMq1WE5U230GF50OJAu8WQpCBRWCFOVrEU35ursNhbiROM2IscNK3535NRYdVyPUslAg9XsiGDWonPa4ibNVZ/WoHHINsA9Od0dQeT4uZLyDwBn2LAUG090KVK3oPDI6dmKLe8xbD1G2Vuycw/DbkZDZipwcgLsZJE5iYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=chpj+LSX; arc=fail smtp.client-ip=40.107.208.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjfuNMpm1p9/kkZDBE0vdrXMKC34WdSK1qfaWJSP9LUWxs1n47/jTkM160RfSUQHlaRXIQ9+mikBsSfBl1VWYON+apdq5rJI7Msm3JlfVNFlEn3xMZJjzz7Ex1BzjgGwSfLmIILbh4FhOqxVunTa2E8YcVIfWsIq5AABksizpUXEBG43oY7xQjtVRENd+SkQDf4o92wwE5B/mgQwJUG8FRDY+tOOxLp5ySiEG6oJWhvbCHdONuKSKBxe+g4zGNukwj1xa568gOuvl2v4Bneg9YWTbCwmL8vjdhfaamT6QRaKG2MaoPEaZoG9OLa3zaTosqBdvcqrxs5lUEZGZ6fq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXmNbv853fCOfQoWNUbUS09+MBhzNx+faVitjwwOBrc=;
 b=QcW7d8F+EaSbKEUVdqXA4X6t67zCSE+J4ClM3xHc/siCLWHgzu3v3XQsz99Q9RLiIl1sgtygb1zAInuW89E4qqRO09rF5aNWkp0vFywlq1XYhfIx2nj20RAgcSV4hZbBOMclpx8emh2mNhCX4WQLDpR80cXOi36kqkneJH2J47KJvgiCLqHCVTNQzVtoOCdXBlN10maxc+I7QkmPLTAsbPxynD0WPFekXnEn0b9hPyhGHS3V8cf8tirBGtALHxGhWLe/QuaVYwbFJ5lyb1xDgZupUoQwWAMgDPaw/+dWUKLGYaV8SsEB4/9i/tC3lOZrEHuaV9QoRq5rlNjzKmxB7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXmNbv853fCOfQoWNUbUS09+MBhzNx+faVitjwwOBrc=;
 b=chpj+LSXrDz9KzRKsGVmXIRQyh1Xui5VVy0++L6kjB864W4R+MUtxptfcNBoX7F7B/t4BFEquBPNUYxDBjzBtRAKhrYbWDo5Cx+0zFRyCkUfAWHltNlcnphCrpijR1seWwAdzpKMQJBpfJeAZWvlJnDUYrH1Yjm2A5TfrQbFb2q8hcgLZKcfVa8I8jrVmDP/QwjXhx9Exi1I0vZTfPIZcK3HRE5dZcEf6glmLLNN3RMkm5c0HhulF8q/tgHrj6o7Tt9MK8jLeNxli7o5IUy6kU6Hpsuv5kPWVA8tHFhXvccY/74vz2dPzbup7Esamgi6jMSs4+stLOAd8nfm007vJQ==
Received: from DS7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::25) by
 LV5PR12MB9804.namprd12.prod.outlook.com (2603:10b6:408:303::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Tue, 31 Mar 2026 10:23:46 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::28) by DS7P222CA0022.outlook.office365.com
 (2603:10b6:8:2e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Tue,
 31 Mar 2026 10:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 10:23:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 03:23:34 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 31 Mar 2026 03:23:33 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 03:23:30 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v6 01/10] dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional
Date: Tue, 31 Mar 2026 15:52:54 +0530
Message-ID: <20260331102303.33181-2-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|LV5PR12MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: 8953036f-8439-4a0e-c043-08de8f0f974e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ONK3y9zBDTv7rHTUazdQCI6rrKTAicroWqmfCnoOVM4wu/m2jtBNhULomWPrCpvS1J0kTf0rOEMINGVgtj+i3V9/20e0IyH/M5UbcoIa3UkCdSvEhtarRoUG70TuAow+URKf7Pd3/8WVYdEFU7oFRGaBUDjv5bv/7pKnYWoDZqCV2j4E0bZeFoUvQvsN46LpTGMA/ledo5P4740lkUL8rVavWFniBMNBnRbMiM8XcAOcHaC1w0ZCRGeoRY6Im9xfU8Zhu92z8eHz7uBiL/rvyzeXwq1KERPzle+MLNEmmz7Xer1Yu6bCmF50OsWGZcdhlodkx7Wz826gFoD+fjSbCVHuUvYlhieikLVJeFucWFD63ie5sgzT2ivl8xiC/9GH06JUQBoUGdtFcOrQmcqwK7yTgFtPSbox0POCDp6tjgWlxma+81EwYSMvNFEo4cmNehZCSfkEq2rY+zOUJa5zGonnAjq8sNT0BQzIXAjtqG/oJKRpVrQoLcU3X7sCUj2B3SUak19iQhOnTo9kAeUXNAbqdJuAp0EdzQa3eIVcPQNnj0oojsK5J3aRMPMFkz/k2EBSd2xfVBPZP2XfkjIhiTTsSle9I/KpH5AoAsI/ir4c6Med5FGO8x4vagsaIZlpZlK0LmwCKdKXZrdOoRhGFGVOlvSery4BWUKhUvFNwzLVY5WkdDQsM1UF19NGSuo1INd1yW5EM1ZAMIHnjQPJM2l1LziodFsk3tAPLqMamLzqXP/jJun8wdm5J007Sm/+aIKYpHhAoA8usvQ8H1WlXiAMPkcO91/K99bY4Y19kLveJn+tdCTBtz+Aa/uV8OE3
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LA8J4jo4m/rtG5CGd5dGYTo3xvAdYdh+MY7yPjG8u00tkCDIDOCMN0WMvlfOYiBfyHL40I9wwEeLTMdXd09fPdpKEE+BtnLNkWvNR84s1mCq2Y9DXVocIWuaO1AkcrH+G20vdfcGOrJuy7Q2p43dAxeIXFpyRu+UvELoqPdvKBnzW5AOTamBZ5dm3ZE4Xo3oYsaYef2leGrodpwOdTgCm/i4QBzpYSZv3RPogOObZrAbqjHwkg+6hLSZwMm4c64wkxOKKMyixg2TQvsqOUyIHjMg5TiyQrTckOxSFm5iexNN/sdJR8g2ntShd+LlGP0BRbzykUjRB3VGYZ04hHRD3JmKKcZS4SAdTlTbMb3SA6c9mdo7rPutH9KNBWz0qvdjVrzzFl3poLwZ07J/7fJMs1ZmCL5U5PDl4sBZfcSu56YqPXSfFsQG+xfZwqZPG8FY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:23:45.7429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8953036f-8439-4a0e-c043-08de8f0f974e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9804
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9760-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 558DF36801C
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
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index 0dabe9bbb219..64f1e9d9896d 100644
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
@@ -60,12 +58,23 @@ required:
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
+    then:
+      required:
+        - resets
+        - reset-names
+
 additionalProperties: false
 
 examples:
-- 
2.50.1


