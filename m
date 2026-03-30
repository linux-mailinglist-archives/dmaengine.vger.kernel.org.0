Return-Path: <dmaengine+bounces-9716-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAHmFBeRymlV+AUAu9opvQ
	(envelope-from <dmaengine+bounces-9716-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:04:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA68835D6C7
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8E6A30B3AF6
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 14:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E82325704;
	Mon, 30 Mar 2026 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZwEbMMg1"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D42F322B74;
	Mon, 30 Mar 2026 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881951; cv=fail; b=h79DGgGTQzf6QP2I0Iha6Yz2s32cWRDB1VMVmUFZtyStsnsHkRjT6HyDo1np48WNoGkCMzp3DhWwPt8SOEj34FZR+Q082rJS8JUqPYItLjdqqjnL8As9/jlx39CVzQkz4u3lrZCcuGjONBW2XjPUlEhwN4OYQ6q0P2wk75UEAQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881951; c=relaxed/simple;
	bh=5dfbZN3cfbE09itP6RIr+gzBtx6aMa1BqQvP61Lm6wY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCMZJNNzYTOO8t7Wi76UBWbdKLGI5q9bvQ/rwg6qF47+vBx3gUWXBi6YxwUASNFhJ0vFI/DVuY5pzYgk7s/+zpvu/pSKZ4wZdebn+vXBvqDOpQV2irSY/XuKqQr23dcY728Ainz0eNle7Sw+/oSSapbiYyubqIdI2g9WI8NR3JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZwEbMMg1; arc=fail smtp.client-ip=40.93.198.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0dKQVPBAaxj89ScZSvs+gykjbXHXazept6+sZv3RwW10/2Y4e7HKZLaSJWkJvpGEmpHmcZPq+5b2ExqJFxcUgVr8ym9DRCdQxq5NCTw4XXpz0VJhr1HdmhYvA/6NIDeCEEHChdPSt38mO4XjZZY9xefkDJqEyAWVZppyrrLgLVjSmTDXmR9JebvVFCYp0GPk9+zqVFazftgwDWCixEJXwmhRBKQ9/c5n7SSvpi0/BcVkaK4D0CBfkRf3mHYJVY/I4+gXqWmP+dDi78vvWzmIWQO/tCX14rHyZZRiqpY2BmRVrb27JEnWr/1XqFOa4leCzNDkCh12sNi4ACYfGNj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXmNbv853fCOfQoWNUbUS09+MBhzNx+faVitjwwOBrc=;
 b=l9m8qbGYnXXhg+ZCP7JeAZML6qluOpaeRql5gg0/NyIZiO0wTEMn8++zQ4EV/AxG1Y0f8QOF3wfoXFXk+OqkZXpL966am4ji0ZnZfNwqAgikHSHPPu5ombPZGCCvK65NAj/qKw3PfX5+nxVZTI/yfEf0nfO0nR3YCBBa6yhWGUSELqbO+8QvWWx9OFIx4wkruBaaDZ2y5xNCBEX7EGAmtZvpIJHuRqhyLE2Z8rKvNY76/AkpjvTyDB19/OEWWeChuWoImB4OG54izKI9Ih/mdGOjYPuh6tTVnyMKLnoyyu0BtS734wzJmz/tuN7ZEOabjWJIXjL5/TSfahvtHBvBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXmNbv853fCOfQoWNUbUS09+MBhzNx+faVitjwwOBrc=;
 b=ZwEbMMg1oAqT75ag9AkGCgwmIGfR6ugRjYDyY9tU1bnaXdUiPxaM7HsIsAgFbaTPa5qkEu5MS3EDRqZTHcaLmRNL5ghSN9fC8ZUx8HExCkgtkdQZOucAyJXYmWq7dTVG5iKW6jNNV9r4gu5f/VWlSmVMOyot5D/zPthaFTMot/M46lvKETaKi0TcGlL/sELas3am0ZLio3LdZR6r/TQCnHuDFTxjISmj3lbMYLAYgxw1Z65yVsS38QhORLmM2pfue9t2tUuQWTHLuGEqZUXF2AM49bHjTwwpoD1fKI6S4kkO/UzBgeqhF5CuO0eKWkA3O2hqz9bIRId6u4JkJJj+Rw==
Received: from PH8PR07CA0007.namprd07.prod.outlook.com (2603:10b6:510:2cd::23)
 by SA5PPFB9BA66B77.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Mon, 30 Mar
 2026 14:45:44 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::90) by PH8PR07CA0007.outlook.office365.com
 (2603:10b6:510:2cd::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:45:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:45:21 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:45:20 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 07:45:16 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v5 01/10] dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional
Date: Mon, 30 Mar 2026 20:14:47 +0530
Message-ID: <20260330144456.13551-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260330144456.13551-1-akhilrajeev@nvidia.com>
References: <20260330144456.13551-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SA5PPFB9BA66B77:EE_
X-MS-Office365-Filtering-Correlation-Id: ae29e5cf-8216-47b0-a4b2-08de8e6b0578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Y0I67c16gky285ttvtXIdkhSCwSqXJ6uc5Op6M3JkxRRvMwa8b2Dl9jhZxYEq3Rw9RySnlkL18LFAz6ILn7rfnmdH59W9AIRpFvL/rWaZN/hIw53aIpJshdzLR/H8Ty/mfy1FuX/as0rBtt5zS8XqvRe0fvtJO8x79DVA6rzvxeCiXkbuUnATK90bJMaTMQ7IGGIpQgWKwK452ZwbWyOYXygkVrSM3xfYNuRB5PTLl6xHOlhMsMjb6v0OzqAIHlSADFuCOxdVJtNtOgu6/qgh8PZgFD9JA8XrTbq4RC05c4dt4vkP1yODiSVML+BiLQRVzkoVZpNGleD+CubbrV8/D1srD37XUQmsGHN8YzFiSeZbzxBiEtf5eXdquIDBYe+hq9gIAvmPQh65D1Jyt38V2NVhRAB2plk3o4y3566mN8DKFtB6RURZezAKt5CEOUn7g3ToEt6ojhgmPPr1mqE0LHyQwJV7K2KOPox+xuYLjs3oUyMmhnFK3VOt7otDHCiIAgh4FCYYEqCcwH3saKOm/1EeO4A2DJIs1OjqxQi1m0Znh5cL22JpzRDKEPr0CQ5M+PfwikUh2g6ax/d9ixOM///cVWe96uujXRfXSI2rYWnfP3W1o1AO7QxVtHv4H1hA2gFkmV5ANxd0I/YAv4WUOTIhHgu5QMqJHPF2NJmqXk6jEVnI5NbbwGETUQPwW9sIvR13lWq3+BUbDHw0Ld2hBphP+C0W+sWNxA1WqwniivOZ9giIXgDK+72B8rrZlUw3UZuIumePJCwp91jMWGpdQpuJrnqlUpU7qzAj370PbfvH16AVKGC8y+W3koV2TlR
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ztOIcAwZLHw9axt13fRpbTH2YugIZudzJjQkd+97HCT64WlttOaCV7viYSe0XUE/dreBSGnxkGqry6csqXSVXfAMTTjtEAa7iXfANZbk6dBh3I56W+LKJAm2Nz99is01GTLCLgzjKuPwlgHzqPz31GCARUh3FWBQeucelPs/FXtRhvlWZ+PbxOdtcXjSFstqWX3E1hKW4isX62M2t77NlCwrfsF2WEij/jiBqm7oDRkar2YW50JtD7Tb4BNYEYBPvylHRtZBoyLD6xoA0SImQ9lLKQVgc+sUBllTShOBdYpC2G040LzNf8rUAJ11gBejd14pRvsJUnnHjCeWwtPRERwp8TBiJa78V1+esizNFn04GY6Vo7WKgKzVNMyvW5N98xkGBobJ9YMXMSnMtxnvusV3MmRLFvttvQXTrjfbOTe5EENRqLPK/awG5SgST48J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:45:43.6452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae29e5cf-8216-47b0-a4b2-08de8e6b0578
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB9BA66B77
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9716-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[Nvidia.com:server fail,nvidia.com:server fail,tor.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DA68835D6C7
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


