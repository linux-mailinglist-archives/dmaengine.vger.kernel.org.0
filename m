Return-Path: <dmaengine+bounces-9588-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAwKEJMowWmbRAQAu9opvQ
	(envelope-from <dmaengine+bounces-9588-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 12:48:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DBB2F16D3
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 12:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22BF4300B46B
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 11:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD9439B483;
	Mon, 23 Mar 2026 11:48:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022120.outbound.protection.outlook.com [40.107.75.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336EF392828;
	Mon, 23 Mar 2026 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266512; cv=fail; b=DSf6Id34csZGNm7RcCrVHpyyAbQXg2sFw62n12QqBAKh2dSuOGQ7kQYdaj7i1PiGSlKNeofYiEPZQU7RCVaeln23ZhVKBIVthXK+hmatUEZ8ASW068t4laSUk6IHtjy1n3cdgFviE0ZzZG5wkhszqu8/Y0rCkqEHlz3gsGzjCV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266512; c=relaxed/simple;
	bh=7A8MSo10fIttNaVumvCBAaqbEdKBCoWmoPr3+Yhg9K8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwrhNI3UBptqkREnKt5riafs/+THlr00s9GzdIAZPtDHSc4uidEIpTaZcbKJLXzQaMFXbTdFPuTzy0o/NtUbkAU4kdzLnWkBJKW38ZeRanxx/vGwb5xlQFNZl6UCVBq0GeHxfBaX+k+xNCRztY/8x0icoyyz9ifPM0qdiDyKQrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2B69WFQlf46Mgk+wju5E1kFLBpSaOoZX+WHmO/C6bvinZZ7FAaVlYpjAe/QHAjBFV/V+GR3nY57x1fKDG4bs700GwIxlXx4YzleAWkUpOgpHxOXnIpQwFf03ZeljM7azqGXjTDA3nLh/BqZSTFfThHVoYWwwOz1pDwQG8FGVxqsrLvY2StZrxkLDaq29mtiSJBzC4/3rnn5RNJ6bUpN5/+4f/f7vcEWMELJUOEmiIquM5Bojt+rVuRn4Yf5ruihvdZ5HXFBqB+gaB5AhcvgerDOZvodXKJQSi8EuXAVcHAATCWkj/Tnlv5sp2quE7xxGnzFs73DrXcUkpIsSzUPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vV532aEbVbKjSBZ8fOcIUS5jUDl3wqrJOvveGpsT9Do=;
 b=Kn0anWcCxBBPDlr3QrW/vJUd97/wvLx91+czif+3ZIuSzX/ssOsMwk+9SWArP+bWQDNpAK+O61VKQfZi2QGmb/9NA5LX/bWRf4P0ZLshDW1tP9zCXF5ruzJw6Kh2lQyxWkigD+5YjbRjcnV9KuuqAE10QU0PYo1frP8mG2sJ2e/acj/7/BCBiXVy57mw1+yzxao9+a5oyS7PSFXKPCljJZJts2LWDD9FRfTRBmNn39tC80D86/9BqBLA67qAEFDAIw0wBCS594LuzucoVnOly5FP+muB3XwB7eRk4dOKm0kA48EOePtxjPBunsMiviSmEqMmSWOtS11LFtlXGKwOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY4P286CA0134.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:37f::6)
 by TY2PPF7E205D1F6.apcprd06.prod.outlook.com (2603:1096:408::799) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Mon, 23 Mar
 2026 11:48:25 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:405:37f:cafe::ab) by TY4P286CA0134.outlook.office365.com
 (2603:1096:405:37f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 11:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:48:25 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 397204126F88;
	Mon, 23 Mar 2026 19:48:23 +0800 (CST)
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
Subject: [PATCH v4 1/3] dt-bindings: dma: arm-dma350: document generic and combined IRQ topologies
Date: Mon, 23 Mar 2026 19:48:20 +0800
Message-Id: <20260323114822.1925869-2-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323114822.1925869-1-jun.guo@cixtech.com>
References: <20260323114822.1925869-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|TY2PPF7E205D1F6:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 158d76f5-c817-4f4d-6a3b-08de88d217ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	+4vQmSNEUsJpwjQkVw/da556zt7xu3bAylvwb9SV4ch34XKXATKkPudvLmJf0agaK+F4YlvIEXdDnBCRTTmBmG28O/gBDAzz4D+MieUNRNdK6OfcFi2m0Zcz3oeQwBp6Q/AbAAMzFCVof06bxjZBVmW8zrThSu6gMT9AN+QOoiwIi+xCxdiQlp8sV+uQrKOmAdUnnqU1EUzRztR5NYemEZGnp2CdrNCHuizEG5H+IAtPs62uUt4OpXfsN1NR4cIjC8C5qKKTbd+LZJ8NPZgpk8W1pYv7jGhu/9Xs8xwjNtyonbgFapqwifyejgqS6tutOg7C7xfFNYUYEee8mhJwBYIT226LuKxjGco7KflDEguw6musNUtOtAQRkLQhbd1gzh4Wdk3hThYlMrwCGFCMBenLVkxNehNiFYCO8y2PTLCCb3WxMSBifYOHKTxV1cNkc0NyJujpPcT/qZmx2t7AOsoEV/xAM31BFhuL8eI5eLM7oy4c/s6ivci/TSGKqmRHBlshqbDG98cORHV27WRYeYYyT73GyvYKMvRn8fg+JRZUnLwHfObEB5M4yQ4FmJ4K8rxtoisti727QrtZFRvZiqVIM5n5/bKRVjpUV27Fdp22eBYBsWMtYM2PV6G/YN5gPx8U9+0F4qUionS56kSSJlQlxlQMXmXvfqA2OVClvhbm6vfEVfPQn4I0ipfyQXqwlKmc0g72jJ3PvrnK13oV5OHr1xMAR7xUr32femJ5y4dT++ZUGBesmsI+8GtdwAFw/PRR2ZBr9s4zt4KHwAfRtUep2/oJ1nVtOQv88WqbSUTcFEdSXnOX1UW9SuYmyFbH
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lzsl7ugjDZ293ozU2gm8WHR7aXgNip/RKR47Ep489oFvv6IkiAe6f2+JI1fwJ14bmXqX9qOIA5f6ZeedpJmj/ZGLdINz2ocmvzp0e7NOukjWfzE/pgUoxzNEEf3aFjewsk3Q02GxFag6GsfD2btN1dzde/uWbwPhEpXPGysjUes25aTamIrPP19iE68C1+AqY3lll8jPPmucSDHxrnDpyCqeZomMtNNscjQMuQNUFAsqSAohn5za9KEeEA8lUmj4m7ipwwz/Rq3Nd5sKDmNKhdfD7gJw7bJM0KdPXfyz4bS5f7qen8H2KUOhYupkK89ZdAqaShdfA9E4jeqP/tsUp94bP9BwTwdshcXWgdmyf15Tie0iMj1nmLFInLJcrJ8eH7aFKTGfP0LiJMlSsrjRlcwkmt06d8Gnevho/khSItEOVzUQpPXcxm7CcxgkL6eb
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:48:25.2284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 158d76f5-c817-4f4d-6a3b-08de88d217ac
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF7E205D1F6
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9588-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[cixtech.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0DBB2F16D3
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

Assisted-by: Cursor: GPT-5.3-Codex
Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 .../devicetree/bindings/dma/arm,dma-350.yaml  | 34 +++++++++++++------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
index 429f682f15d8..47091614d1b4 100644
--- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
+++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
@@ -14,7 +14,14 @@ allOf:
 
 properties:
   compatible:
-    const: arm,dma-350
+    description:
+      Use "arm,dma-350" for generic integration. A SoC-specific
+      compatible may be listed first, followed by "arm,dma-350".
+    oneOf:
+      - const: arm,dma-350
+      - items:
+          - const: cix,sky1-dma-350
+          - const: arm,dma-350
 
   reg:
     items:
@@ -22,15 +29,22 @@ properties:
 
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
+    description:
+      Either one interrupt per channel (8 interrupts), or one
+      combined interrupt for all channels.
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


