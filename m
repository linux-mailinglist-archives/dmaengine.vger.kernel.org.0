Return-Path: <dmaengine+bounces-9519-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOQhEkvNu2mXogIAu9opvQ
	(envelope-from <dmaengine+bounces-9519-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 11:17:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF9E2C9580
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 11:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57DDF30156D3
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 10:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AC53BFE56;
	Thu, 19 Mar 2026 10:17:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022104.outbound.protection.outlook.com [52.101.126.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058673AE717;
	Thu, 19 Mar 2026 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773915457; cv=fail; b=J4/ovuvdFkpJOMh6klec/A/BfdtCal+mAa1vD7VbkeHPFHc89VSo56ppXK6muva4ERHkqzee/rSG1Yb8KnxitrNfYZ9KkKySs7t2ECzjyXxlR5IcbttCCPvmzwR2tZZASnLMwb+V+K+fqWnkkGyX+rSTyoyA8vr6jVIBdhpXbBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773915457; c=relaxed/simple;
	bh=z3ZQsc9idtFedaZsZu8lb11y6sM7+Pwl3eTNitgm0Cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KscQaQh/S73be3UeYtmCAx5dvPztVUxf4LMm8Fozwpt+wpCYCmv2enuuYhJvdyu6fyG32TLhYLmQ3bM/TYSA7xZDQ7ms4lwpjrJ/hXuuFMd8F014KAFw3MxZx93p3kYsHFgeCGnG4Buph+cR3FtkOIYXE9TQ2NOAJPWG0uskZQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNpHv/zFkQOSpo8/SdvqcfcvvUMXMq9A5ou9SgxXR8Ri7aOWQhAU8rrJVaYKuLt2Fah+DM6y6EJn7LAlJXqDe2y5VGOC/1U0dxtTHZwTUXw0farpJP68JY70P8PWQwD7fmAGJSCZzNAuT140+lskex75n0WmxWVf0mqYfZEVmbJeA6s9Y3YhCNcG1gstRBNctgXtWHFJ699EnEZEFu0OccILnJa2hQMngDgM1i5BBVjVKEnkOp2DC9+NcFxtQBp+B2KBsRylalugK91bJLdl21hX81LqLuBQMkVeT8BTDDHt4RjLbe5+j3re1PDWBjd92jCVMXNwODgpCn1KZRrlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgeJyxtubf86IksCug2DqCm1B9Zvg5QZp7j/t7af64k=;
 b=gV+dUxVqLAjesd/N2wSAqgEoACUf12PgrcgJoNRCVCFBx5TQwZjulkC/4u3WVeJphrfIbpP1PTUVxbMojGR4eGiXtxasf164yQCNdX1yMhwvI5xCnO124zGzyeLLSDCmm1jfzVl0kijMayZffBzxG+owiXfaUz5bdZ40PVSmdfL/AAQ7/aBAIDw+7plF69IlEygDiiW+AFGGNKoX12SzNBDxkhHt1huZ8IF5TLjb+CoWc3m4iU/PivVzcDwFNMIzme23qif3RTopb5uTFHyvwJ3FYk+cO37vhVpGtRX06CnwYlVTIYCONu2alyUqmwyMumNzVaN2clbZ1dncrlU/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR04CA0205.apcprd04.prod.outlook.com (2603:1096:4:187::6) by
 TY2PPFCC803ADFE.apcprd06.prod.outlook.com (2603:1096:408::7aa) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Thu, 19 Mar 2026 10:17:29 +0000
Received: from OSA0EPF000000C6.apcprd02.prod.outlook.com
 (2603:1096:4:187:cafe::9a) by SG2PR04CA0205.outlook.office365.com
 (2603:1096:4:187::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 10:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C6.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 10:17:26 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 724464126F85;
	Thu, 19 Mar 2026 18:17:25 +0800 (CST)
From: Jun Guo <jun.guo@cixtech.com>
To: peter.chen@cixtech.com,
	fugang.duan@cixtech.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	robin.murphy@arm.com,
	Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org,
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH v3 1/3] dt-bindings: dma: arm-dma350: document generic and combined IRQ topologies
Date: Thu, 19 Mar 2026 18:17:21 +0800
Message-Id: <20260319101723.246539-2-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319101723.246539-1-jun.guo@cixtech.com>
References: <20260319101723.246539-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C6:EE_|TY2PPFCC803ADFE:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 25c7da9d-f5a3-4e83-cf54-08de85a0b858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LoRNgA1FTMn+qTWBbK+C6xWBscNl2VnNw92dj6clCv3zyj3qSnnNujJ+WGa1/LMGuAQ4mZ1VQI4p2V2Dtqk4HPW8gZ0jx1GTyelh7Ny4WcJ3UVioYxQn1m82zixmV9VWwQfUqXvsiL/pIUAcsthFPYkyf3E6U5ckJHNT8hsOk0gdgNAfydt/5gZ347IocalNK4tjQqYWegRFm0CXeyDFI0HWQ+UEI+fytjmE/c1neeHvwz5kngp5+yUTyR7XuLGeco+IfTNUhZJdvyG4puxWvrt6Js5+uCmGT42OHWm33KPeHI1AsseJIqpV6So75GAFij+WWlMxacEkJLU9v4/h1bVjncqYA+KkO9KraSjrQdBrL20nMH0CrYpkPRjva6V04HCKzDS1ld/Q5eecYiC4LN14XEU4zWBVtm7D8K7VK8uyRXZrvKhIPjxmgbm+5BaE58PhDtWxCII0fGfARMQCM2aLqiv71jtyviFcdHI37WIQj5t3OxSBzIA2807C/Eg/wHShj6h29DP7671KtG3oZ0QoipwxHM+wasGKh7yGNaqVBO0TfnHRsYNOWn5lVX78riZ/0L9QGZAzzYPft5ql26LMVREI+UtaxVZGZVUokXxXMN8mdGM/ZBFuP1CG83Li1ASR7Kk5AfoU8lrhgXD7XX3N6VouMifvJyVVsDEJiuLI428FD9RapOe4zeC4D1AKww3Y8MQumasfUQ6BIfcETr7LTCxtpgCRTcICN8AkrmWABt/s2Yitkr9jrluIDByVvdDHfSJQO3cu/X84B9E9WGinM/CsSrumxcSZLx4xig/rOIpbO4w/EdYNczLl5cvC
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5aKMEUoSa0zK+C7JfecXm/ii5iR/IqnTwijmtbfr9l4X5/8g5zSsMppqOf2+vdFnzyaGUreAyZvoeqv30P5aNNJxJbvPhYjI6eVwAplAeLrJPzPquDOmS53/645/L8O891u2WJ/UGHcGG+DjfRzg0ezszW41m7uZRpBk1erld28twJVsLdQZFU1AFt2y3AaeLmQjPtCctMEpNaGt9DJa79VAfoknolQWvQKsPOb2iutyo3QXmT4CztCILmci09jgXBxdFSZL7g/cVCpDRdrn4w4eSkPg/taAsULaP5Ajr1NUNveUWZUaDmSfRZ2UMC9wz/v5vmGlP7oqSmXhfQ53jSEq8bQPmTwj6UJ+6/OTJhWiK+4VaI0KeTR46tpnoJA5ZeCZceQheTsFyc5Z6Kv7+cqe29isQBENpRchLQmxdTn/DfqxN9T8L5cOOq8I56/C
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 10:17:26.5173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c7da9d-f5a3-4e83-cf54-08de85a0b858
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFCC803ADFE
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9519-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[cixtech.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.347];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AF9E2C9580
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the DMA-350 DT binding to match the current driver behavior.

Allow both:
- "arm,dma-350" as the generic compatible, and
- "cix,sky1-dma-350", "arm,dma-350" for SoC-specific fallback usage.

Also document interrupt topology variants supported by hardware
integration:
- one combined interrupt for all channels, or
- one interrupt per channel (up to 8 channels).

This patch is Assisted-by: Cursor: GPT-5.3 Codex.

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
Link: https://lore.kernel.org/r/20251216123026.3519923-2-jun.guo@cixtech.com
---
 .../devicetree/bindings/dma/arm,dma-350.yaml  | 31 +++++++++++++------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
index 429f682f15d8..3639ce0d5054 100644
--- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
+++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
@@ -14,7 +14,11 @@ allOf:
 
 properties:
   compatible:
-    const: arm,dma-350
+    oneOf:
+      - const: arm,dma-350
+      - items:
+          - const: cix,sky1-dma-350
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


