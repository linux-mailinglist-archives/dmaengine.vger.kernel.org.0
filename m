Return-Path: <dmaengine+bounces-12200-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zf4PO5asT2osmgIAu9opvQ
	(envelope-from <dmaengine+bounces-12200-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:13:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FCA7320E7
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:13:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=NMWhxQB0;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12200-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12200-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA52319CB65
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428F243803D;
	Thu,  9 Jul 2026 13:59:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012064.outbound.protection.outlook.com [40.107.75.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD86D438025;
	Thu,  9 Jul 2026 13:59:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605593; cv=fail; b=XQO1vNL8svqqSG3Y6YSAPSHOt8msUZKuit3NfQIXUW6c8wVmbAuNs0bdeZtjgcHPoGV+OE0yRYcMzeALwnRdNf64CjuH51NYCC92OpcCG2kj2GRemCxJ4ZQHymZv8NCvWx+H61T1SnhyHJrCcybao/Jedg2GYjXVcd5PDQLDFg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605593; c=relaxed/simple;
	bh=lw7ZNWm+BXZVMnJBdFzAtMrFzzCGpzQ2CB8gKeo/Xww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hfwEBc8kC5lR5Eyl7DJcuRyeFYShTMxMyZS1aqMSZAyOi45ovy4RxqPcNEL/tS1L4LpC3jofYwTGvlVvJki+8ylL7r4xzSmjWHytACjsTt1cwfxBXrF4YVhjhSymerVZgZtv+5lUiBku1Q1f5W3oJYxkEkUhtlF9k9yKUICAb0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NMWhxQB0; arc=fail smtp.client-ip=40.107.75.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H58WRaCnVobNw6KLG21hCmig52Nab8F0I3n3F56CVgs9UA+W2wFEynUlrRdJdBicXtOlHyAVVUmF0aciLrYw+OK1L79zjGM6Tgst6B5O7i47bPbceFYw7wSQUwAohsx4njYn6eRWDQ0zEnH4qoQC8ntlKvXrdR5czbMyg8IlZU7FABT3HEGyJEVjffmzb+KcfEeIuu8hN2AhAqLzA3onBckOUqLXkP9qWfkJ6NalOUmf4hHnEw37ofBexJKOqvBdjwHhUU2PSG9LJQ6j9AhUq/jXG2qCsK0N8VYsOr+gIVGw13+69YVjht3nuvNo5hCKs1pqQAtGzidcNLsy5IV6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsGDTwXefxXZ0QcDe1lVQHfvBCtfow5hwPf1wuIu4qw=;
 b=GPyOvTfh4vM2QzUb0S/j+Yuj3Am9I11NNd5ijzhLiSYG6Yqnlz5MMMSCiSyMkvt3zuKRfERowm7msTIyJcpfYRA2bFbpRe0ayNdsSgPAdga4NvGMLKeec0S/tUxZJS2JCdcZZaKqydPXfxzzycWT1RVBusvvWWDXCMt91gmo770kkrnPQeL9VejlDckaCJbKykK02bJzdVxfzArxu2PFZIo6WPX8CF8TcPU5SPPONEnBz3e5DKTPiwWlBWW6D5EPEFrd0rMF9XUa51twvODH76r/AzmlwUzrJKt2Yghr/RQwi/1wJNGavbgPYu2fiXHXrE8WyxYfIVWimxoEYYcY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsGDTwXefxXZ0QcDe1lVQHfvBCtfow5hwPf1wuIu4qw=;
 b=NMWhxQB0L3tyoN7aXBGB0XLdJizRWzwDssbiUuNfY+vwGu61/HER4FRv32SWg/TrW9/jUIQP5JpWL34/sR46Ypdu6kpGjW5EpUp734xuGVM2RMba3CC8IpOEqZZpkJw2p9IaLzrOhQeRHmtNz+yQLdRqnXnTQ+HAWDMQ9HicJdMYIwQNkTIX7p0eCpbGOkIGMw1B9AlViKA6uXPgZ9sPY8dZPbS9x2TSthuOzaYye8tSTXWhulXxp++W6PnHdlgNDSdC2inut5T9ZZ3P+Q7N5S70B25GUsVtM6MjOM/nUDQcZwISXDrgtY/u3+/tGAMhTbgX+OgoRCfkb2QE/85SpA==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SE2PPF271E4F3E3.apcprd06.prod.outlook.com (2603:1096:108:1::7c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 9 Jul 2026
 13:59:46 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:46 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC support),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 22/26] dmaengine: sun6i-dma: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:26 +0800
Message-Id: <20260709135846.97972-23-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3c564b6d-bc21-44d9-b42c-08deddc2559e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|52116014|38350700014|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	1vQdlcQqwkR7S2i2EvgYDgTFQSeH1Stm/qxNMLagSeblbjXfrx5jjlCT2etzN8aNeZky3cVyzt/XyjTMPcgfl6BP5Azcs/r7in8JhM7zgcGqudKHmO5s7pfP3cuoCBPKLJkWBbP54dxlUFTfYE/gfKtZNERx0r23Pp4gE5HjO9pD/6Bw0eUZK6OacV3Jg+vYL5qB2up4lE6nN1CTub4fC7i+6oKCEnxcZiJveWNkXB9XI26exXps3js2eLmxpXIRvecd1ayfrKVHRNKWdEgOZ9wBcb9OSjYRAp6SOFvEmbkD+i3770k0hc2Pe0AWmLjq7KJ0DsnCqtl1OWwkO25zixTPb0N8j1D5mZ6iqd78D/8PGs0+UUj+2KfGI3JmV8qup1s0Gc3fIDGqKlw6As80XkdlKMqbAMlRTr//SyGbrqb2hGK+lZbB12U/Au1zpQugIiNsasVqEdhtPORkJWR+ndYzjArki/q5UegT6ZOI4JJuhH2ltHixvBoaPImj2WsPxxg2yUwhLJS8805ZhzaHoRZRHxHU235jzonVWAgAH/aSxZMfgQyC9NTsMraeKcKRFHZTZOjJg+8eEsmrMzgdF0fuR1IRaFef7BfO1SxZ1KxF2VFQsTd79zV3bP7TWoyvgGcJ1BebWoxUl8EJpsQ2aer4VifrVFcR4sPnB/RWVDsCPa2lkcVI50o08hsBWsRrre6Hvl7ZWy+WmqYbk2QtAH4ZjfOYGN8HqmOr+oeIyfA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(52116014)(38350700014)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/+kSTp6Z90H54tffVvAZb+sP4WcQG/6wMim2b1tzk5p5CySt9bBLyRKQ4GUf?=
 =?us-ascii?Q?SeLKRIU/Ran1sK6LKC/Tm3VdTD/mEyBx446fO40JcsrTMrsCwBBSPpE5fD3e?=
 =?us-ascii?Q?V3TAT+2C7DfbsC6gYhubCKwpEs4b/+z4AHlzpygpyAfOEw+FoJijhQEOvlRX?=
 =?us-ascii?Q?Anchd4lR9mOUBEtxUYt+On/19dVDzm3dFV2oqpeoNgGMRhuHVJCXZpB6szyW?=
 =?us-ascii?Q?Wjwvt/hSaVVKRMDQdEgAyjCPJ0GiF/vJkrtj6TdJhgIDUqvYA10wI+3hXrF1?=
 =?us-ascii?Q?8Csxw8IAIYtKtaqDLGVJFaORnV7csuBeLG+vNFBZbu1qEoyPsJe+GslrgrrI?=
 =?us-ascii?Q?E2nY/3KCGCfAU05Yrfo6IFNhGggmo998LLAKSbdqjsbSyjDYsJC27qwlg01A?=
 =?us-ascii?Q?WYuPA/AT6J2+Uis/Xl6QiYbC1lkF/VCmu41vW0vD+21r7A3U+uSyGupEsHmE?=
 =?us-ascii?Q?sARVxIIi59osXoRAgBNrTTdIxgdsSK9QRDA/UN3AAxDWrgQKWO37N0p0IAd0?=
 =?us-ascii?Q?/9ROodBXcus9aRwH/sT8ofy1QTHAk8BffhExA4iDD1ODmZaNndZfVZslsQsm?=
 =?us-ascii?Q?EtMSwUsZXbxopBRk9j0IFLoWKz2re96n0n1y39VyqlBu/FuR0FX7TMGFBkVU?=
 =?us-ascii?Q?OqfPT4BJbuslIzWHpgY4sq+ijXtYNcwSHd79MVU+q/ARcHnTEbVXSlxXnVZg?=
 =?us-ascii?Q?wUoUteJ+EQ8yR2TeDGngd9vyzRb3tAaqdT67v0Vk7Cu/eCznOtDzl451yNcX?=
 =?us-ascii?Q?KkjDxQu47iGBwitsrRNuu6BhWooThMjTSAsZeGoGktE9hdf5qy/HuVi8XlI/?=
 =?us-ascii?Q?akma/J4ngjT/2I4lcURhBNDMJu4Sdn+M92qAzdyt4UBmSsxbBGS6QVn4TMnc?=
 =?us-ascii?Q?qy1Iy244lMDNeJ2kujPDJ+vp4nAAO0PDWEDYQT98f7aDh85dpn5y3Am7k00w?=
 =?us-ascii?Q?uH21uRpVHu3mRtIqLT2jrraH25kEnqOhD+OBjMWBhihLI36ifU4mx94wlY9T?=
 =?us-ascii?Q?prH/A7NIuxWZGHFDiQscwvAoPHmSeQU4wMia0MqFtGWIBZ46wCHFRdSp0c3f?=
 =?us-ascii?Q?RQ/ldT5BSNMPaEVDPUL17dhPAsXztUevhtqr+CXih8ujtdDCReZsX7R8Ic1g?=
 =?us-ascii?Q?+E24QExAU1MMn8cb9fmy1C8LYIuO8Hq6qeGj0AdJPOHhe7/KqQNOQAQgv1h+?=
 =?us-ascii?Q?HT2qtaq3t2rKaqnUv0coItuJaaN76HRa/gpkVNDrHoCFGz6ohzD3ZCbeu2RR?=
 =?us-ascii?Q?XkA4bsj0NixLn5fHVWwZzAxF99y+2J0p5ebbPDDfSKRz7PMPMpVAiZluWO2L?=
 =?us-ascii?Q?cTopkzksPMhyrPx4GpcAL2ytKI3rtBnjAtHG6rCrsL+vSP9ZdMuL3E1tzz2X?=
 =?us-ascii?Q?W1sZAJBDN7g/dUSvonQOV+k563WfE4Xb/vSL+93941mPtRH1iU26DQgVjDxm?=
 =?us-ascii?Q?Vkcgf8J/JnyBQ4ak69bEgagmxx4ux2WcsjIZrd7KFZL7xpjxVLkd+xLIPWdk?=
 =?us-ascii?Q?iJ9kg4f2+EUAwsHm16qMy7yKkFxjPHzYcinAq/aBy6OngEMBzjqxHyQjwvCU?=
 =?us-ascii?Q?8VVigfTRK77W+Pv15Z+o+4nycAVEImhEZyxTbKbQHFTliE1/8wmm/tYnf4Jp?=
 =?us-ascii?Q?HW/X77cwisUPmJmx+pNa7DujO+0Mq7VeITbw4BZkpREeD5pm/Ye1vZkRQLxR?=
 =?us-ascii?Q?ktaBcKqFIjU8HPukHcmQhGz0/Lye6jByE9tZ+yWxY1vHWiyxv+NR15Bcnzb4?=
 =?us-ascii?Q?DWY5+/5BOA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c564b6d-bc21-44d9-b42c-08deddc2559e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:46.4534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGIYXTE9yi/gQw73UrxvpnVfoYEWZXbUlNzqZBKFtYKED6bZBOMT6et4i75cD25qREVHYjvgU4M1Q0HNYjfR6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF271E4F3E3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12200-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51FCA7320E7

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/sun6i-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index f47a326dd7ff..87ad7eae2069 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1454,10 +1454,8 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, sdc->irq, sun6i_dma_interrupt, 0,
 			       dev_name(&pdev->dev), sdc);
-	if (ret) {
-		dev_err(&pdev->dev, "Cannot request IRQ\n");
+	if (ret)
 		goto err_mbus_clk_disable;
-	}
 
 	ret = dma_async_device_register(&sdc->slave);
 	if (ret) {
-- 
2.34.1


