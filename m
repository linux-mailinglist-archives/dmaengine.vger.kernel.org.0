Return-Path: <dmaengine+bounces-12195-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0eWoA7u0T2oznAIAu9opvQ
	(envelope-from <dmaengine+bounces-12195-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:48:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0031A732740
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:48:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=PZsoNAM5;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12195-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12195-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D403C3107A14
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAC2435EC7;
	Thu,  9 Jul 2026 13:59:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012064.outbound.protection.outlook.com [40.107.75.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968C435EE9;
	Thu,  9 Jul 2026 13:59:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605585; cv=fail; b=pl9vwpRE/XdBhtwDf+vDl6CgSKnW2TkF9YHWn66atf69b9tovj//a4Pn4jAUp+1PhhBqKCYMRO45kna5ZofS2dk3kAtv62bg9YM+6mHS8Ln2+GOr7CswUXG/vMe4f+az0jgxYb0hfLBnTgrgdGAyWkSJuJyFr8Mzkib4odY6o6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605585; c=relaxed/simple;
	bh=5Ei6DoS5yySK5OJnI5cciejw1nkj9PDBh5P6v7e5GR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NaXjjTrOWQS8AU6GeVaE9HorGfwGcyKWP+kVhNQrGb2dCohGK9Fa4aO/tkpqYruQxC9KpvbowFYTyrsvvpddSZYfHYDfr9QV695KSkGb99MdaskSluH4VWYhMHFIJzuPvvTzdX3m8SzQ8aOY06auOf+AOEOtbO5jUdJOq2TzXxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PZsoNAM5; arc=fail smtp.client-ip=40.107.75.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mV/+TI6ZvAS8Lk4ZLV5H2HJVuwJhFXVdRSquDJd4GUlBLrGE0+91zkWcrr+wGa1Vb/+Ok50GtyfbBBWReUsqNlOyN4qnNXool3Jg5jAYz7Z8/sxo4L1FSOMvmM36ce++IvxVyeKvgEjUXXntDP+kQx7/89smvtVrb+MeWJ+sFLkU/lAXTlb3rbVUL/e8o19vfeoqbBrBwRdrKJ0Kzy+GM7okDpmsEfTmXY8lhjpg5zQ78dH0abwJgQGX19SJrVNUoRMXKNf7cE4wwGX19c/KYWT59up7jfyQQG3XZWcQQCu8UNelR2RcKsMnpHVqQ1y+7ww+uNLukkWOv1Guhr4ODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZkqCetdAyYo7YTMQ+FmLyPOJsXeWVq2ghxWaM3o6Zc=;
 b=iAfw6U0F2QkylP+uONSJuYAoQ+e9pnzdtPWsfrG69TG8YaV6d4NrE6mNuSXM15MSA4V/+ITEG4KUYKJtCWuEhdsgNoIOoavdVtQKgt65QrOpb4Weiakv1NBYHJoe3qTzdiYOA6s60JmK2V4PATSFAuC3BARlkunOTeSCMNzCW/V5ViGqueEA8hJArvQXZGQAuaLuPYGqzi5Iqzg2/7bzY3Q+r+5Out5euPha7z6fi37q8ux+3CNdtf7iHYXsWpBSJX4+Zp6DHsnNhTL5OyiVHYRZfQhPEh8JAYkz3UFXlrimFOIQqBRuYBoOpHShwSBCopE5mddrpdDCr6jQfuOJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZkqCetdAyYo7YTMQ+FmLyPOJsXeWVq2ghxWaM3o6Zc=;
 b=PZsoNAM5E5LAfneRMZzvc4PEA/Vog94bt9WSaBG1glKUBaI8uoq9dPsMV1SgohqIdHon+vXwIxjatRcX+c8+mgtaQVQRPXD+67w4BQgSBIyPWkDF/E1NQcOK6n4UjL0Qh959rvXhvIWHiLek/X/DQn5BGYnhkPUm0mE1dhm3sekfRy6SA0Szm9JoFyQd5WuYhh2gTzVxxHxo0V/XBCugKOg84TRmz8FvfYNY9GiFqea0vjDeIvk7SkZ3WBaY8vbcHbMEq0JIkhmamge08zZP0HrbercjXHdWOL2yy4lhdQLf/aesC7xDVd74+5RhmiKh51wPPUMnLWWioSN9F/tufA==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SE2PPF271E4F3E3.apcprd06.prod.outlook.com (2603:1096:108:1::7c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 9 Jul 2026
 13:59:39 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:38 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STI ARCHITECTURE),
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 17/26] dmaengine: st_fdma: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:21 +0800
Message-Id: <20260709135846.97972-18-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709135846.97972-1-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SE2PPF271E4F3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: 7933145a-a034-412f-9a66-08deddc2511c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|52116014|38350700014|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	K0x1JvXVqDmJ1YEBxeZMZoponOvyjeF0BpHUd3DKH3ipM6egEx99ejTf9JE81WAGirEB1SSWotBvKiZOEYn3B5gAYdiSY3ZgsMR29JLQ5GfiWN1S0txZ5529W5MEkYa77S1Mev4dlXSNnO8htNV7Fn0/CFxE27uq2KVn5mAIB5T1Z0xDsdCscD4IifBIbHHFvIiqEYSwgb89KRu3BuNDwAkaQEZXg9KT1UlCzecXhjw+BVTwTedYSlgkazlGAHYMd7KCtblKjCrG2EWvV20jcsRlOcoc1XJ6iXg+op2wUUSu6nAXUX0PVqXPsGsNjQ6vKApWIayefJF+XbBSr940g8p4MxK7N/WoWbSsX6sE9IJXFfI+dhmdjH31xzLWzAMlAjogmDxgPjehKOvi1kXe9Ab5EdSKTaH2DOvRURmnnwBWrrP8MBN2UU46wlEYDFBm/9sbtCT6ih5QU5Nf4KD2+bnKYjpm/TNy5pB/YNKc9z7LDx4BkFTm7zbnm85WJ1GXNZDwHwOIKHB2YBFCbVjdqllxgeBlxEzae1WW/ZHBh9pzaVq4JtNaoZE/HavSGPPAxO27d2qnlH+RjEqWDDyjctni3IQ2NpRZHwSYCyveBbx0/N/N6Tu8TAL0htGzEOa2QlcXw7j9bR2vObgNNX5jXFCU9PF+JYXb7K/DlGAM/CqoFth8b6xz4EHA8/sVloxafOdPJIllEdyKKF4xVO788ijCYWjLHhM4Gw8eIJrV42M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(52116014)(38350700014)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M04PS+42+dOzQElDLjiT9mCfk1sNjqllPceG36L3+oDG7ulQySsizqlO/xJA?=
 =?us-ascii?Q?XFxnFozi3uoiAKc015xKtJnNJ6o9IjGDqVEhFnOSsP0J80+ZRCHJs8rvNpj4?=
 =?us-ascii?Q?sMkS8x/O5cUP9WdHLgI/pq5sZsYP1QKfnwxryxHj8bPQrOOU5lM5Cs3dm0Xk?=
 =?us-ascii?Q?XWCA3VAyKErS9D5+zvQEHDwa3JAKdYHGiGbkcZQybk+HppftP8Z0FEI3tX0D?=
 =?us-ascii?Q?nKd6VpFOS52ly0GvJHoQXH4jAH55wbQGA00QBkqd/oZX4NwJJoNGvwSPj/N3?=
 =?us-ascii?Q?zq93O5a4vnlBeZ/9qPPH4f5cGmAWgwA6UcJBbFd0ihAB/JVUPABSOM4XJJLd?=
 =?us-ascii?Q?dN0gR5LNKqfL5WnqRPVtw6rbE62edjapCksKwLaZl5gYDxCLpCA0MfYqxWTX?=
 =?us-ascii?Q?87ijpTObQUL4K2fWeTY8hBu1/YLj5X7R3en6PmWxqRUs3+zzQ878n01gtfWL?=
 =?us-ascii?Q?pp/dvhJ3Pjt91a8vo5/c0E/ho53tJ7KK++mQJKmmL5CbSoh28oUpMN57FG5v?=
 =?us-ascii?Q?A/7VxHzbHSP4j6U1bxaxrf1fnoj4T6H1C05M2JdmH0MyderrHJlYOphtuwzU?=
 =?us-ascii?Q?TP4pBEGCjry87APjH+PKPtV6im6EtqBsTLZ8r7nhhI0sbI1+qY61ziZ94g9l?=
 =?us-ascii?Q?lb2KfhJFa+CBVara6gNl1MkfVEvaCtgwtlMwULA7ZkHgpQZAzZpe7KhLltnR?=
 =?us-ascii?Q?TFKJCu9dv79sQOxSL7C0PwopHrslBOofJ95M0gtreUfRhp5Pps1GNBh/HWIG?=
 =?us-ascii?Q?PW8wZ8NK9zT+9LLbo73DGWaANgpcoMwEa8dS3rJQ+djAehg9yIblRsMD4m9j?=
 =?us-ascii?Q?jH+L/ztmTHf3+uvlsvYoQqK5m8CTQ5ac861mLmJKdUh9xQD/a7/Z+6x+q21E?=
 =?us-ascii?Q?6U56x+rBrkp//veXDBtwUW6HEXuKqhFMU1z5FgZ96KAWhQMYiwEaxZw4yIt+?=
 =?us-ascii?Q?CKYFF6VxD0YUwwh/EACt2m5l4ZSN+amj1p6YEqH5DOyFcnx+arZ8ue6PyJ5c?=
 =?us-ascii?Q?l5N5j5VQM4seT9NvKKRzqUG4ofWCEfw+aVogqBRMYKosM9eYSBFW2+Cdd+rC?=
 =?us-ascii?Q?07rQhODWDm25NUwKZO4z04F1m4ZS4y4cEUJD+5y9/0alSTOYE6RozaYZZRsI?=
 =?us-ascii?Q?+XYe01MzjkGEqP/QOF6rg5zf3zTv0FZPB5CybIpaeseZSOE6uizbS4RcZ2wq?=
 =?us-ascii?Q?n3N04SnOlzNbyc4SIgLvFgkoaH/0nPeeeS7N9kT2wp6do1iibVI6U53gavvO?=
 =?us-ascii?Q?ZFs0Oty7rUo+cAq/PHuVoGFWzNy4k28pUIvc3zF2aSSxaueU7kJezJBit1wx?=
 =?us-ascii?Q?H8tdioQrq7+09LxY4Ub0Nh0rKUPZm3vytSUwp6RgWTMMJUXgIEtauZlDywSf?=
 =?us-ascii?Q?eWqx6RW8qI//4KeLQfqlOV0guBdPHv2oh6wV/dd+acnmd5zb9boPeLxjrdiI?=
 =?us-ascii?Q?Gop7Ji7P50gny4rholt+ngSmZ4vp7DQWYoLJ2ruyWX2lCASKvAjaOHEQGfvB?=
 =?us-ascii?Q?7uxJqprtYW/RVtWaF1ywUlYHJK4IaY8sEMbRzGhcFqsX7sMCbjj2KcZM1s5d?=
 =?us-ascii?Q?w7tHRnSMHqePKC8ie/DnQvu6k83FCZXPXYwAUWlMv9Uogh2tywGKZlMaQTNA?=
 =?us-ascii?Q?M9joBpF/FtxMWzRKU3Bl3lhPiAA9QDPjEFI8f2ArtupoFBGJqkUgq/6PX3yK?=
 =?us-ascii?Q?5Ve0Cp23VUBIfjucHK8PfyIRUD5VjBiPAacqFU/3L8OszIztcb0wP360BQTl?=
 =?us-ascii?Q?m4Xyiyme9g=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7933145a-a034-412f-9a66-08deddc2511c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:38.9164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7hAX41IV/g2Nn40cbz9KB5ip/Ro1v9905ZoF9jvufTeIgq3STvyBEE41NsuRsObvml2bvICuNSV3GaryXoUQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF271E4F3E3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12195-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:patrice.chotard@foss.st.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[vivo.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0031A732740

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/st_fdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index d9547017f3bd..05a2642601e6 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -771,10 +771,8 @@ static int st_fdma_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, fdev->irq, st_fdma_irq_handler, 0,
 			       dev_name(&pdev->dev), fdev);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request irq (%d)\n", ret);
+	if (ret)
 		goto err;
-	}
 
 	fdev->slim_rproc = st_slim_rproc_alloc(pdev, fdev->fw_name);
 	if (IS_ERR(fdev->slim_rproc)) {
-- 
2.34.1


