Return-Path: <dmaengine+bounces-9621-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE7kEeZ+wmnqdAQAu9opvQ
	(envelope-from <dmaengine+bounces-9621-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 13:09:10 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3857307EC4
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 13:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B3C33139A86
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC9B3F1672;
	Tue, 24 Mar 2026 12:01:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023115.outbound.protection.outlook.com [40.107.44.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9533D6EE;
	Tue, 24 Mar 2026 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353685; cv=fail; b=DByIS0uy7fexIQj/WCLm0YXrWwYF7/JYR03ggbB+h50YE8LKCR8lCJ0Mwo5eXTAKoFGmrJgRhg8Yrlbx0jIDTFVeSAH+RrmOaP/3sO49ia8K0/rWs5rO/oe6gEYPqYEt2W4QkpXk+6PzecZfamUBiqnqIGYiN5sQqIl4a2mKJgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353685; c=relaxed/simple;
	bh=/HmbZDlsOzINf4NRjlM6hgEa2csw7W+c9PUlzi0lXlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9IVrALZ4qlr9AUA1V7+AM7J9ZMoZeikskEK0NERgNovUr1gj7fdnQytUPeF5ALOvkK/jYV9vNy5twF2jOZ/6Huz8XfVU03YJZPzmoKuEhCitnGlwmAsa36TrU8epTcR+LiU+TNmA/fPFNRgHNj5wvEcFvoFDc0s8Y+Kr+vEP8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwXI/CJFCQKtVLJBBAokd+YayppD9scUvMuJIB7koVfr3cYcZOVeA8AsNYCj86UTmmzNPLQJ7jd5b91/NKKqRX0Ocq5fiJt4bTdC7wX2sLq0vjMDnJvv9+NPmk7hItsKcWSBM/UYE9ywd+bYyRyD1/hf1l1934Odx7/WLp5t/YrvOSMzAAS83ouYDBUNqVUTOuo9O9LFnJdIZZ/Plp0iNyAPzypdu53n/G277p9W93Z6+BJY6UxQgnNNrhFDU7/vtH8199ck6RtKLx9ZGkchi9j/09bBE8XNWEcToRTr1bcq7oKbEaK9/KOFFjhteHcSObVUziUv5sVXU0Ovkpurhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F2ZtiaL0D4+L/2kCXlSa+Ui0dYNc5FmNMQn+l9MELQ=;
 b=vigUZF3yV+p8MNDtG786GBGD6ANtRTX4ZhS5B7C8hyx9RW/E3/IGj7z5cLiVx+bZ6c/LhghC1kgKm997qAgNfO+egTLBCFzwNct6/2kBjScV5UCumJmJCM3S8UO0tEKHcprjH/WPxtPWPaZ3ExTPA0cpqrecTG+IhOJzS8LtCJvLKby8Jfn+C9pSINs2rvVdAHgo9pP2+eWuFBCuVdWwKwJO49nlgEWEE5OWWsUTzvO2ulNXyOhJcg7SO8a3zxMjDHqKG/Ebj4rm1Zkr+xFbd3lP8gR927X86AiQLleTNhI0ggCp0g1MzLtItZ2EkHMmvgbt+ZuafKjgsK5wwiW5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::36) by KL1PR06MB6491.apcprd06.prod.outlook.com
 (2603:1096:820:f3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 12:01:17 +0000
Received: from TY2PEPF0000AB8A.apcprd03.prod.outlook.com
 (2603:1096:300:58:cafe::c2) by PS2PR01CA0048.outlook.office365.com
 (2603:1096:300:58::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB8A.mail.protection.outlook.com (10.167.253.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:01:15 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 1FF574126F97;
	Tue, 24 Mar 2026 20:01:14 +0800 (CST)
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
Subject: [PATCH v5 1/3] dt-bindings: dma: arm-dma350: document combined and per-channel IRQ topologies
Date: Tue, 24 Mar 2026 20:01:11 +0800
Message-Id: <20260324120113.3681830-2-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324120113.3681830-1-jun.guo@cixtech.com>
References: <20260324120113.3681830-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB8A:EE_|KL1PR06MB6491:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9d05b991-7653-4df8-4b05-08de899d0d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LipTfqk/06WzNwTfkBNQMEUBNX/ctTM00panZjhlczQOM1Wyhik30JccZ5S46jFDXLAMY/Mfcmd2/ZAusPtizOJ97Bp+uRkp7qsJf+aEyzrete6zUZkep67t4SdzWAWKy8asnCzDRYPIPpzWMVI5/E4hVnahiRVpHnJYVejPpW+cXlNwH40UGCitKNiwqwiwVfCafwGD5o3rmREAiouhcpivwxxzePv/qHaco5Ywq7HJf32Q+Swo4Bh0GkYFMJ6kaeoqjnAet14mXm608MQAFKZO1knjWqKfei538zfrxKEurhgzQDuoKeNeAjh+fh6tcy6QbQh8HmKh2nGU8vY3Bt5sFffr6UO/+RzkRGuvB3ZYmBIBssGdRSRc81xRHGyZDF/1OxsXqdHgwOh/M2lwD9ps3JUypTbYVSmqvsmb1ZQIiMBISt1tvcJXIz7ku6abtrW+ZgUrFEFDaKLEm6VzKtG4imjQhyuCaICf5Jq5Ua3uwV3k6sDwxUc8ZCPwOBv6JnVvvX0BGUd5QmApXJyxtDfdENkHByCWzsS90dfx9/B3TfGkGZb3TJI/jAgTevEwh97H4m6Ad8yAjG8Y3o5DQa7a6I9j3CqlJLKjL9u/oDCANMZEURW6nk4tghwi0WXBXInGftcyqMa+Hw2mSppQ23OeFnIf9w4fLZL4BdtFiefNbisC8+uGocci1CuyisYc3sJvuF0qCvO55QCmqAqfu7r2xBPXGhvtbHQUJICYjzHC9zWnZpZY4MAakfIVNI4vtWzcrb9gPm1pN+/++lpO9CVYU7TRRWqEB2dfLaHCtS2PudLEd8cqvzs255ArY0/4
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7rd2Pe2soIBxuch9Je1HQocdL+FSIBf+DrbpjTYc4+J9iw6iFo2fpHtpguubcgbBlNyU/2glOXHbOwM7wvTMkd7uRJYmP+WktpOS/LavRacCR4WJvJQCPHl/lQO7df1uzOCrLVRMR0KMQ65QuqDQg+lUU6rCFUl7d9Ob05kQv9VDxLIJAvc/1DaEizdDH+VC5a8NeFM8ckYQEAWcuddwhzilF+DZh5MIsUJ5IPyr4+KS2BDjhwGcvCBGmoXleVYP8NLIKYSgUDlAc33wbzhmUFN1Jufc+kj4iaQABIWcWwTtP6ApYYgOQt2M8XpSehYFyC5AKfEPTZqZlogbxtr2ZDNHxSjA1pYbR1SnWmHrHrpIT8kCv9lM+vnqatqHZr+tOYIC4+2Tcif1Mg66VR4SjSBX/Q0dXZDn1s6RWDOE6AIF9HTWZCy9Lt9svogFKOKb
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:01:15.5931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d05b991-7653-4df8-4b05-08de899d0d57
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB8A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6491
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[cixtech.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9621-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E3857307EC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document the interrupt topologies supported by DMA-350 integration:
- one combined interrupt for all channels, or
- one interrupt per channel (up to 8 channels).

Assisted-by: Cursor:GPT-5.3-Codex
Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 .../devicetree/bindings/dma/arm,dma-350.yaml  | 25 ++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
index 429f682f15d8..bec9dc32541b 100644
--- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
+++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
@@ -22,15 +22,22 @@ properties:
 
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


