Return-Path: <dmaengine+bounces-7658-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CA9CC2BE0
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 13:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 824EB302E7D3
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA4D3A1D0B;
	Tue, 16 Dec 2025 12:30:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022131.outbound.protection.outlook.com [40.107.75.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC463A1CF8;
	Tue, 16 Dec 2025 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888234; cv=fail; b=YzL88Jn6nCJDL5riu+VhtgVr4wDUzeYaWC5/t5eBN8DOiUKfG3Z7SyQvOOHDHZnM4WxOhKjoL38NcPNINsfwAdZF/0T30YjnxUVSqHrqBX0fPeUIg+H0n98zeTu5udwW3Htkm7MrDdNwxhcTqCYOs/I7hfPJHTNIjdNgD0MPUKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888234; c=relaxed/simple;
	bh=kWhF1mMe9M4ACvKxCZzz0LTCjjN9VnAV603TGMirWsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHuSGdLNOuq7Vo19zKTZ+/0bCxDtSNED3LYa/Qnsv3jn5Es3qv41vxUBHff7c8m7aZF+IyBHJuMnBkbMvUXTEGKmm/cHkVD8u6nDxUGbNmNRstCjOs/aMoAGASAdtodLSeVYc4VmEx48KaMDUD4M5zeDZcDpV0IUxiujg91pDvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAzMHXIudcvL74qfFqV+8IZ7NdM9WQGA+5K26czmtLrbxN2G9puY62Feb0BJ+0AwTrqDJHYlBvre6i8yRGQBtqp0qBCAuoZE854rOoE1qzI1yQjH/4QeBg793/jPybCkOeIs58qTqnJqTXPO1woE2snK9+5BMms+Cnb0y/4NHRsbrGkmxiuXQpqiPHfpuJRmZuiNM+mx4c+sWk64RlcJw2J77VOa6M0Yf/TuFIH54tvqHvOWMu1nFTfCs1AGqPJg8l3YkVVOAueQIJsg+5SDMOAd7Szi4kVK/xdBpAE/ns2EeEI/eKJ+MShzGCZDvNrG+vrZPSMuDM9SS0ozCduieA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/IA7W0QQ0+vuHI0trqKbJcGqKlt8uV8Yb4QVBHpVIE=;
 b=tbBT5m6Kxq9r9eataMyhX8ebAiH82NcW/O5RDpXsV311MCqxc17lvABviKI7vqdLaDXi4qOFlSQrXjnECGUFYWHRKCBaT5cM0qXGpUxczKzKVobw4TfbgbJdowGippZGQC2oYDTovo9pbVv5XfU7GBBeWSIh5/Gs6du7E/nUxnMUlsgY9kuvjRLXEp2e8wii6eDTfdYrDPZY35ya4byrylscX3OlNOZ94uioBfGvYoce1hIB7LTrVcwf9/8Yu27jx8OMVF/KlUdiBxgUvrFyaBvohR4gilMXC/qADZCNVzgNdoqvSHQi4ul4Di9KfMyrTYe+uNdZyLYNcpCqdQdifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0038.apcprd02.prod.outlook.com (2603:1096:3:18::26) by
 KU2PPF02E3DE66D.apcprd06.prod.outlook.com (2603:1096:d18::485) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 12:30:29 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:3:18:cafe::6c) by SG2PR02CA0038.outlook.office365.com
 (2603:1096:3:18::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 12:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 12:30:28 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 4F78940A5A30;
	Tue, 16 Dec 2025 20:30:27 +0800 (CST)
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
	jelly.jia@cixtech.com,
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH v2 1/3] dt-bindings: dma: arm-dma350: update DT binding docs for cix sky1 SoC
Date: Tue, 16 Dec 2025 20:30:24 +0800
Message-Id: <20251216123026.3519923-2-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216123026.3519923-1-jun.guo@cixtech.com>
References: <20251216123026.3519923-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|KU2PPF02E3DE66D:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7a7fd6d8-0760-402c-92ed-08de3c9ee575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IIXJhjicTfYXd4qvH6wRvTH+++B8ZV2MesVetjxUibkYTA6p/JwW61Dzp0jY?=
 =?us-ascii?Q?jBOyug3yDcq7r2zqdN+mbws2LrbnJNWUiptIExlTgvvkxKUBo5qkbWOB+U32?=
 =?us-ascii?Q?TuzlxMj4zchYI6BXAuJ4jzGw6hw8xfH5TEkwvcdqhjjpqxlWAXHNfHExecj/?=
 =?us-ascii?Q?U9O5d+/dRG9Js3tr5ySYgWsLS2nlMc7nSn8V8TBgr/uaWHkkC9r6Nz5SVoVr?=
 =?us-ascii?Q?wnfXAiXFfU6ZQneBBvKHOoUQwutTz6p52xKBFAgE0PRn388A4qGckFfbt5ts?=
 =?us-ascii?Q?jVMpXhspTKcrUuKs4OpEoeW1bK1SAVHxnhw9cDRiFV+OeB9Z6p6jT36S7b8m?=
 =?us-ascii?Q?YqTt6yavinBZI5lMTkx5NuoePO8izMgyJWQDlyLwaQ9i4leNRnx437XKY4Xc?=
 =?us-ascii?Q?TVuM3a+04CWNrh+uU3ydJJqzF+cJEz1VTmzEFtOi5I3QFRJKZCr8sc7FB/Id?=
 =?us-ascii?Q?aRvPhvsxRso/Zo1d7Tp84vw+9XXQqbGlksDUX8MNesQzlDqGXGG2I/ST3cUw?=
 =?us-ascii?Q?dD5dOK1DgbzStAZ047PT3eVyRgk/Xdc6/rE4EEHW0bIOOa2J+KJOx29roEBg?=
 =?us-ascii?Q?goMH31wc6Mxv/fAXWWTxjM/0cgiA6/HUPDRMfc6Hqp2NE/8gxnXB5ApCHlEt?=
 =?us-ascii?Q?pplvj9NG5VyGnozIF94dFXfrkwoWODpS2kfXqrlpJ+OiMrclJCBPzXc7nSeE?=
 =?us-ascii?Q?EvefJkni1x48VdCO6fAKSvULleyk/l89aksqYAWbIDLBuIAShsk4ccQL0DF5?=
 =?us-ascii?Q?yI+jxfRucHk1IqE1g30lpEYDNzCWGOY/dqMKAzvu+aNkVN3wEnkGzwoBNrF0?=
 =?us-ascii?Q?TO97F60r4nr54zVYvXb4nj3hJ6blvN51OPpL77PVUeo6T+1MqX3wHqm5Nzhy?=
 =?us-ascii?Q?4g5S2iCSzFBxPHyN08df6kemJITy8BxtQEtYrMvnYzZmZBZuEJdn0EFzB6u7?=
 =?us-ascii?Q?6UJZ3hQmIF7P8PH8T2zW7NPPCh9ywiUt1S6hk62uwTjkUb60gftXkfQPbqTT?=
 =?us-ascii?Q?/nm1oVOs0yZrJQE78cjTmbFEGdMocZMlzqBAADbWjzAveLK7coFfndnozaJ0?=
 =?us-ascii?Q?PJkhwCSq6sBLm4uItLt/Llu+iziGZ1LHM5FsUmMDSzP9q3WqzAQ5MIJniZZ0?=
 =?us-ascii?Q?zJ5NkGTE8YGpuRTrqazQ6nudGMb+xnHR99bemv1i4VZDEiYXBgIW7XP5vH96?=
 =?us-ascii?Q?O752b4alPCOMMAat7EVie83l2sdXnWq5Oehk7WS0ceons1LUKdrj30QGTKnS?=
 =?us-ascii?Q?fp4eMioR8/Wkz0pm9yKWYFytYeNafLPaYgZY6BeYT9eHpZ98KnprxN8Wc1Le?=
 =?us-ascii?Q?jhUto8nC60ZSJMRHQdAEJnrx3djOE2WtP1yQcvpg5d4ndum9EqbJLTfDByrV?=
 =?us-ascii?Q?sBHtNCUQcRrDzWQdjljL6DH5NufMdxn97Wicu5OfliFihH253SSFmKXlxa7M?=
 =?us-ascii?Q?xWA/ENO8/zLJiuLK7Ecd4tTDdtroit31iYo5M35sU3SJZ/+M28Clk3Fm8UNe?=
 =?us-ascii?Q?jfonQcP2W115rUitu7EDV3qEzZzvzMjDkp/Ycd6k/EUp/f4qkMnc4s8yQb7t?=
 =?us-ascii?Q?Za9DNeL4SSl+10xy4yA=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 12:30:28.3376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7fd6d8-0760-402c-92ed-08de3c9ee575
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF02E3DE66D

Add SoC-specific compatible strings to the DT binding documents to support
cix sky1 SoC.

When adding support for a new SoC that uses the arm dma controller,
future contributors should be encouraged to actually add SoC-specific
compatible strings. The use of the "arm,dma-350" compatible string in
isolation should be disallowed.

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 .../devicetree/bindings/dma/arm,dma-350.yaml  | 31 +++++++++++++------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
index 429f682f15d8..78bcc7f9aa8b 100644
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
@@ -22,15 +26,22 @@ properties:
 
   interrupts:
     minItems: 1
-    items:
-      - description: Channel 0 interrupt
-      - description: Channel 1 interrupt
-      - description: Channel 2 interrupt
-      - description: Channel 3 interrupt
-      - description: Channel 4 interrupt
-      - description: Channel 5 interrupt
-      - description: Channel 6 interrupt
-      - description: Channel 7 interrupt
+    maxItems: 8
+    description: |
+      The DMA controller may be configured with separate interrupts for each channel,
+      or with a single combined interrupt for all channels, depending on the SoC integration.
+    oneOf:
+      - items:
+          - description: Channel 0 interrupt
+          - description: Channel 1 interrupt
+          - description: Channel 2 interrupt
+          - description: Channel 3 interrupt
+          - description: Channel 4 interrupt
+          - description: Channel 5 interrupt
+          - description: Channel 6 interrupt
+          - description: Channel 7 interrupt
+      - items:
+          - description: Combined interrupt shared by all channels
 
   "#dma-cells":
     const: 1
-- 
2.34.1


