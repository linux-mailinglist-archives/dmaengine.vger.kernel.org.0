Return-Path: <dmaengine+bounces-7185-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F904C620AB
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 03:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281563ACB79
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 01:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4E9240604;
	Mon, 17 Nov 2025 01:59:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022129.outbound.protection.outlook.com [52.101.126.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8B748F;
	Mon, 17 Nov 2025 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763344793; cv=fail; b=mwdkTT1N8oPv1CFVehptzc+09nt9ojv2RgStAZ39VsLU4ZCeiYxbtFsAXY+tQ9ZsE5KgiOlv2LYCkPy6L1fPe/hDb4F30+Wo6OwBynGMLlFqlrgA3Qw3XuSnKtuW3jPdx6UYwPe79ti0z01skdPC8egoO0Ps/0ErR/CqLMdKnos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763344793; c=relaxed/simple;
	bh=cGfHQ+U67SRA8Jlw2ji4JNBpbx+8W46jVdnLm56JC04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJuORj2NpkXWOIRhOOzYAM9sDuU/ZQeHYGNfFWs1HtRvUftkksL8Ibh9iMHbQsUbDuOQU2tMtGRD+KS4PyMuvtftmF57WWqqj2dWwO23K5bUsatDvNIwxFkGSmWGHbQZh18Us4Jgm0yfr3G84pGvIt98EC9NwrPZUB8Rb6N87sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKjuG85LFw1ZO/qiCcrpjyMYzotKqjODMUix8ZiyGMpQXaePv5Ncv6XZ34FCpDFK4yErpfWnLigYkQue2GmJZLpV4amgo4LTpXB7mpzEYriRZGgTCbyyrnR2i1qAEL0YWDcYTMd3UZfYEn0x0B0+g1C4yAfNhpaOyT9L7Q0At94f/BwjpE4Cgrve2BABOc+jiw+pKUkic61PDp0qjvqLRSlnrnXpPj6h2P/ZxxCUxjre0C0236Bfbfuhsc5kS/+LFAWyI+i6bd9rbUXpwwq0g7YkwKoZ/xbwRZTPcse8g8xPVhM5+fw51jUwAzfqHUTZXMbZf3vQ81/ZSgQYfszkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyvjQbcc+pDIiNPbfH3b5Hi5uTaxLFkOnWvjTmAc/PU=;
 b=WzyVpd6GmeooUpJ9K/sDnqnIm+pqSUxjsWUmhg8Htyr/k2wrdotFLGurglNJ7pCzPzHyIUUSJSVqbcQ1ibHQ2OC5op2lMbZBJoXRvM0apfE/bwUa74cvAPP2Fn0Z/XiTu1Sb1ZQx+3PdAEKrJ43bSuM12Ny+T9FE68qJBA94/THG9myICy8L8Zo4vTcl2zDa5T3S5xy3epJCHzxkClGEUw8fwZUzu63mw2KtrB8arPLSN0PEiWcrw3jgvqQR8RYOPdsXI13TFTYKm6UaNLt35IadqFGroOA5ShLtfH5AKPVYJxtTyx1kWi5lBzQx4+ia8uM4v7V6M1dxhs1CZKe1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR04CA0014.apcprd04.prod.outlook.com (2603:1096:4:197::18)
 by SG2PR06MB5130.apcprd06.prod.outlook.com (2603:1096:4:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 01:59:45 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:4:197:cafe::5a) by SI2PR04CA0014.outlook.office365.com
 (2603:1096:4:197::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 01:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 01:59:45 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 52FFE41C014A;
	Mon, 17 Nov 2025 09:59:44 +0800 (CST)
From: Jun Guo <jun.guo@cixtech.com>
To: peter.chen@cixtech.com,
	fugang.duan@cixtech.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	robin.murphy@arm.com
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org,
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH 1/3] dt-bindings: dma: arm-dma350: update DT binding docs
Date: Mon, 17 Nov 2025 09:59:41 +0800
Message-Id: <20251117015943.2858-2-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117015943.2858-1-jun.guo@cixtech.com>
References: <20251117015943.2858-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|SG2PR06MB5130:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b9620f29-caf5-414b-2ed2-08de257cfb4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FDAshcoEG708YG849Q0UuCha6+wQCyTJBjpabStjWh7GcJhaGStyMJ0FVPsA?=
 =?us-ascii?Q?BVLaWhOXRn4Uc6835sUKkBWs9Lbbg8l+Vhu15XbyEPadxlwDpplfFNpyjwa9?=
 =?us-ascii?Q?EXJZyxbsrtk98g3EPhpyHafEyLEl9B/oaLnk20NpdSmC4TIwDvQ6a8Wn+/6z?=
 =?us-ascii?Q?3MriG7wPOb+gp6VpyK2PlNfs3SHDVQmsuA7IRKHMH+2bT+c+jX+flQDEL7cl?=
 =?us-ascii?Q?sF8ZdB3cqRH2dhzeKrHBqVV5WV9oOJe1Jtpc2ZRw93n4OJZBGIR/yJk652IU?=
 =?us-ascii?Q?grKT9w8Ox2Op35kLLIChTTxnwyooj49Tndew4YY4pt0BA08FSfvF1LWCiqTu?=
 =?us-ascii?Q?lLuQWD/Zi7Cb8RWD86c7x7YrlE5tcf/FEqpdPnDuaEhMyBseGEhM6ZUMwGIL?=
 =?us-ascii?Q?5YIP3FXCCwwYub2tKi7//LEwbHsGTQ3SVM8IRZgUaCTXXyeMvhHQ+nAzm1N7?=
 =?us-ascii?Q?KOqbliB8aWYT9KcgrXfuA3//1odv4TgFqQCcfMbsdT062Q260025h17MVLEv?=
 =?us-ascii?Q?lSMTOm2gnmBcckiP31PR2MoeXai4ZPvGOuRb8N7LZ0sDTMYxmEQOk/EMxBCh?=
 =?us-ascii?Q?oRzauD9Dm6JiAMwkDsKsvfgvgySV5RbHkYK75iY/N9M5W/tXQN7zSyU+vefB?=
 =?us-ascii?Q?CsrjUYES7yhXVLJe/2Mqhd3hzFn0q04e9AGSP38RdaGO7NYIiSFh+Xs8IoFT?=
 =?us-ascii?Q?QjIab4Y60Z1RDQZLBl233XJPTDDdpEUeuvliZsE5pibzaeAOLfbRnkjouOZd?=
 =?us-ascii?Q?Mnsnf6s377/f9TC0O6CQAb7E1je0saqOZC+tKqYBj+M88NaR+c2mX0fPqbJM?=
 =?us-ascii?Q?htGvDZGgtphrErAqm0tOcF7uq32ofUoinFCIpWxYZKDGptaAyYGWCD3y+zK1?=
 =?us-ascii?Q?d+16hAJRvOXltQL38NrC1hWTJd6zvZCOFO1jdHBLRIgBQTlQMxKcM0YlGkt6?=
 =?us-ascii?Q?t4pgb0FQ4VFE79R179BXH1C+IQL4Y5zmpEwN8yhwGQ5Dfqopa2+fQnFA7g+g?=
 =?us-ascii?Q?sOQu8KSPxoNKrIbq7hFj83RblQfxdm2QjXMY3bOnbTjWrR2/5lpciBJ2t0Om?=
 =?us-ascii?Q?8ylEBDhDEHMNTHbFTXkqWrDLF19EVLrMtcDG4aK6KwSvYv/YtjvPZrZDcMCV?=
 =?us-ascii?Q?4Ji02ei6KbArt1YUYdqyj0YE47aiZhVMmNYK7cVMMel7aIUFPmdd52KdFkSB?=
 =?us-ascii?Q?NTgAitHuNhEhXT+ySJl2BTbHj4hjYI6ayf+8b54P6l+6BHF8NPbqD61T6Jy/?=
 =?us-ascii?Q?U3XEXtjX+VWkIyOjDTESZljH2JaqiFvnx6OyLTXRJbJ1CnpOMSeNZZBgGOzD?=
 =?us-ascii?Q?3suTrJCFRAj/IbpEpFUJvUXjBm82wa5W/tmhaROkMCfzdqYREVZMybEQ55Vr?=
 =?us-ascii?Q?hjUbAkMpQYVx+VjblaVi0u48zx0gDxK+pVjpvW1N/xSctJ6B8mn8P4Ijx1ni?=
 =?us-ascii?Q?/pF6BQJtawnvv/q0RAbIjrMTIE8xfnghiWB9GzKwcWFOd29WNTd9UEtM/QQR?=
 =?us-ascii?Q?Bz7qAP6cllbpH2P6v4TRSPcuxCUJVgeuqHVV1tlEnLCESrRgx6zAIuvhUZBb?=
 =?us-ascii?Q?3Ho5wAgB85UVsQn8wCQ=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 01:59:45.3746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9620f29-caf5-414b-2ed2-08de257cfb4e
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5130

- Add new compatible strings to the DT binding documents to support
 cix sky1 SoC.

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 Documentation/devicetree/bindings/dma/arm,dma-350.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
index 429f682f15d8..3baf1ba5523d 100644
--- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
+++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
@@ -14,7 +14,11 @@ allOf:
 
 properties:
   compatible:
-    const: arm,dma-350
+    oneOf:
+      - items:
+          - enum:
+              - cix,sky1-dma-350
+          - const: arm,dma-350
 
   reg:
     items:
-- 
2.34.1


