Return-Path: <dmaengine+bounces-8921-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGiiLBqnlGkRGQIAu9opvQ
	(envelope-from <dmaengine+bounces-8921-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:36:26 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5729014EA22
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC24E30117D5
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 17:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D83E371060;
	Tue, 17 Feb 2026 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hVd+s8GL"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013060.outbound.protection.outlook.com [40.107.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6831027F18F;
	Tue, 17 Feb 2026 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349783; cv=fail; b=qd6pFRdjnf8jYwANxh95rN9A55vrh0gaG8GWF7IzKS67ZagnnQkz6zfxKXPQsHP9IMYXfqQ+H4rpTCArRnQA0hJDXioRysXpZ5nbe61MxJJTAjJ22gM//bwwGJ7EjUSMb8Pn1T5RCg+jaklpybyBilrY+uMzy1uPOWxe85wsB3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349783; c=relaxed/simple;
	bh=e+fTyJZplhXPX1SFlE+uO1w3b2qiPxFpwQNoDfY5/K8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqkK/T9YpVteGnAcS5gSqrkhX0PhS6ipUVxwNkCQq29MkjQLo4gI7E6virWswEDOfZ9wLaGWzafk3jIdbKo78pgis9Mx6/cXfTBFfHbh4h/W7mNzxG9mu7PVpn8F24NXANblb838O73IXAFgnPwgtl2IRGl/N86Ze+NK6wk5p+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hVd+s8GL; arc=fail smtp.client-ip=40.107.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4LB/q7uVYfLfym/9vPlLjp4AIlTpicax/wB30E+aSBITAOhZjgcw7Yz6LVIebUODf1VkStfEbOUm3L8vKiZ75+MDtyVC07mJRCxlgM8C8c1lUxY98ui2uzop04fSdxcr7y0eZmc5kPFuE3Uno9tlIGGKTYGa3Nr5zBjPOIMKfy4FDnMNVXbXrCuP8iMt0g7DUCyxbDrtHERFuELXA9fFrvSS+c0gbE32TVyJAmkic1mBfjYPOC0hrJsEpmorAn4PMXPmCzVbUvYbQ18Oy1lVIc29TSE+gXWdrYajkNb/YL3eNcSLdY02G8ep27ZqD5VKol5Gj+8VzIXFV6EtyvoXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PlhUzmv6Jpd4cqsLWruXT+/ypbIw+QiSeeD/yR/qYw=;
 b=Rhx5fopozzZy3QxVceRw6GWEWgMFohX/WvUSmKN9hqtUA5C4QO8wF2cUnuuOJmwiogE6W7P3PrTwQ4zyBBqfmGyZ0ukerzWYMgSaW+mNLlgOH76XizjpQEjHE+KPSw1PJ5s/Ue4HFdtdmitjXAXPwWXGpu4yyKx6wrJB7ASNloKCZPFPhrby+OE+lLH+xkn6lsgm/d/3xuhldfrt7qsITXkPxpQoBXzn1F3k1R2LlINBfdH/BbrLrL2Sp14PT1N/DjPnIyThDtRFcZxDXHpPdKps+YBV7FWYoapxBLw+RdBCwCoNjezofD8B6Kxb0jg5B0TPQKtgjmMv5yA4lEdujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PlhUzmv6Jpd4cqsLWruXT+/ypbIw+QiSeeD/yR/qYw=;
 b=hVd+s8GLrnvOJ1KdzaePwpPVd++uvlPAg1Ti+Nl1jAPtu0X+VPtCcRweMt2n6uYCYNmy4kxRfhzWZzBrsOgO4RoQQXoS27UDl4S6d7nXZ1FweM5elMqG+koKdd76liDRzeF8jyrdxL5gucBVaAu8y0n79lL2rSFnMY9+uSm7ElIfnsGHZBHI4VRs/hQcxG/N2eVmRT7a7f/w9wfXYst3n5U5ceILWXia3NnL05BSCZHnEIAQ/aM5cu4LcWdoOAdasfKpdbuPxC8NPG6scOFBz9DZKNDFviAhvYOISmDYWSjAKV+49EGOXMXeXJV1KA/BpsDZmdW2XR/y0HDTtPN4Gg==
Received: from SJ0PR13CA0023.namprd13.prod.outlook.com (2603:10b6:a03:2c0::28)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Tue, 17 Feb
 2026 17:36:10 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::41) by SJ0PR13CA0023.outlook.office365.com
 (2603:10b6:a03:2c0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 17:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 17:36:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 09:35:55 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Feb 2026 09:35:55 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 09:35:51 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vkoul@kernel.org>, <Frank.Li@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <p.zabel@pengutronix.de>, Akhil R
	<akhilrajeev@nvidia.com>
Subject: [PATCH 2/8] dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional
Date: Tue, 17 Feb 2026 23:04:51 +0530
Message-ID: <20260217173457.18628-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260217173457.18628-1-akhilrajeev@nvidia.com>
References: <20260217173457.18628-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4865e9-26db-469b-a464-08de6e4b09f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R5TBlH+QZuV6J3e9oQhY+bsW19g/dvhSAB0lZwzHo9qGlcnFlDLhQcAbf+6Z?=
 =?us-ascii?Q?tDvYaA3MYtq44SwhleFnWKPNtDqKRU9yGPk1TaIWLT4npWjmhtOmfttthUgV?=
 =?us-ascii?Q?ciQg4sQVrjBktJqm/eALQlLkq0+Le4PLnV30nasRHLxjZ806TOYePT7UwJVl?=
 =?us-ascii?Q?5bkMnUPxTCvGZozUAiHHAgmPHAi70eWoXg0+bmiVjOXfLRBzXgKS7PBv+oOX?=
 =?us-ascii?Q?5n53zbQyCsGSrb7dJNnec3Izb3m0jJZJSH/nUF15ZidpctCUr5+vHgggbE+6?=
 =?us-ascii?Q?a0t/wl6/iC+GaIxL6OnTSwACVJ2za+x8pNSLkQf8xRMInr6mOAdfQfIQA2s8?=
 =?us-ascii?Q?X4+g4aisOmTA6jkTyGLe/dyfZyaKoWCSEK8PcVFzfX5LMS2dZlfhnsNQIeMp?=
 =?us-ascii?Q?GCUxCdcsJgU1iV6y9ttjMLiI/fdrncIuq93R9fVt6J4d1Ey10+RkufFdDiXK?=
 =?us-ascii?Q?fG8wyQFtbN72cwPXofgZvmFCofo2BOY/O5w96kGF6UkGg9Qqi4uAmk1v8Rx4?=
 =?us-ascii?Q?FuhAnjNKNkunoxnKdyAor23FIwL04VdmDYeBtMXrpWGF0ldbzLoGlxUUnXRL?=
 =?us-ascii?Q?+pW5PCv5O//OYnPJIEESL7mmxzZ8Mk/6TNSWjiStrMWR1FaquVuvjnNMmZqT?=
 =?us-ascii?Q?7COuklckcGvaKdpR8JGUHrJj36DnQZelbbs26/7ZJhxSctMGaTCDbzjSh4wx?=
 =?us-ascii?Q?W51GQKMGRjPtBXu8mWHKFgPWs7RKX2RqipqHGEKg2cCRCWTDgs8JcYSjrbIf?=
 =?us-ascii?Q?eX/dfduKvEQFutYb7OfpVtUxfKz+hm96rd6LWdgGz982S6tZvyZbaDwfhitK?=
 =?us-ascii?Q?Vc3y+lttWiIp+qnCRXyFMkUvbsA99I0+ch8jRNILN1hiQS5dxQiVCw1AiS1z?=
 =?us-ascii?Q?/qLBEZG/7t2OQwnsYfhJt9vTgVgfCH4RDPYwNwhIQxMjEWyq47edlXyOsBls?=
 =?us-ascii?Q?DtoaOEvoadCO9d1G6ghPrrvjudooH3E553g0cooeBR6v75qAx1q8Zqlb4RM5?=
 =?us-ascii?Q?VMxAjZq6S/32FfwTMbpb+Toycxxzru/m19W7q1KzlJpVpPk1ySWj4/b7urh9?=
 =?us-ascii?Q?SQ6zzvR+2K8oQhbG7O51PvkbKUTDFKKYNP2ShmA0NepJSQt/g4IKf756sFIP?=
 =?us-ascii?Q?U2g0ZVXhJeJtrYkkj5dpU8bNnz7uKK9t7NvyICL16Spf2JbZRxctUnms3mow?=
 =?us-ascii?Q?xCJWG5hP3sDcoq797BqEtZ42lMxsFqmPERzj5ZTLOTkqHZWzK+vCsrC8hmem?=
 =?us-ascii?Q?jf41Mz1TQrWtwQ1tqBzawNwuIGYuY/5DXY+G+irTMaD9Lm/jP/SEtsicBMsZ?=
 =?us-ascii?Q?oAYJyn2T1uuR3IhQ0+7oxPoJ8wLUN/7R4aBjXCTy0HzcPnU8wX9KRkN8l6lf?=
 =?us-ascii?Q?m5b4F9wLZzv0BEEKIsN/5M4FTD4C2h997B1id7JjC73VFM8L3uL0WfxdXK+L?=
 =?us-ascii?Q?RKh5CkgwFV2l9gPerjAKzMp1VTEi2TqBrHT1whsd9nsODBCAAgh1cr4pblGh?=
 =?us-ascii?Q?JsL84TCZo1c/3Pbn2sqQwuCfQzJPkBXN5F+DCPTCrZr5OheD1O18yxLar8un?=
 =?us-ascii?Q?nxOL+ukS52F01RhChyAU55nI4BEOpECNMJO+fntwObdzPhT1JPPpVMBQst+r?=
 =?us-ascii?Q?gnmlphNjI4XogqEsSDWbAP7T4fe6JAvee3G5b06GCpldiQ7737IZHwhxBvuR?=
 =?us-ascii?Q?jarcfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jZlXGGFVZGet7/+qLBpOD9oA/BXePS7tUURwKgVCmtV5wkjLb0E8iPVUEQyrY1W9LwYntcssNwMvuLyNwAoog2Xtse4MoeDQYCDM9JaLTChr0PPDrMl6AgehCZ1Wom+l5a8FaGtsr3S9wKBRNnjoIyBut2FqnjH9bmgOErc+a3REPJTqBxDdGr94OHmuGILzjF+GghUpFXWXMpHAWC3QAdjkayUe4Jovw5h/I2QCLyvBihFlL/8zhAyorTCaaT6fi0PO9ExXz8FE3zq4d8L/FEEkIahXI28a0xw3mQNzQe1a0glCtDEIMep57YlSeXfjnhJV6Xl6M1+p2d1cL6/Mq3YCBR9f5T+3hI7C3HTa/qIflR076musIDcUTLs85Rm662cPXq2htPMOyLqWlqJ+JID+HZxJTR0+mRV1EZLwageeoydueXewNrRTNihKQ8AD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:36:10.1521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4865e9-26db-469b-a464-08de6e4b09f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,nvidia.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8921-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5729014EA22
X-Rspamd-Action: no action

In Tegra264 and Tegra234, GPCDMA reset control is not exposed to Linux
and is handled by BPMP. In Tegra234 BPMP supported a dummy reset which
just return success on reset without doing an actual reset. This as well
is not supported in Tegra264 BPMP. Therefore mark 'reset' and 'reset-names'
property as required only for devices prior to Tegra234.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index 542e9cb9f641..9457d406428f 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -16,9 +16,6 @@ maintainers:
   - Rajesh Gumasta <rgumasta@nvidia.com>
   - Akhil R <akhilrajeev@nvidia.com>
 
-allOf:
-  - $ref: dma-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -68,12 +65,24 @@ required:
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
+      then:
+        required:
+          - resets
+          - reset-names
+
 additionalProperties: false
 
 examples:
-- 
2.50.1


