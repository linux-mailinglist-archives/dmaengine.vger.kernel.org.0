Return-Path: <dmaengine+bounces-12181-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hdWZMmCrT2rZmQIAu9opvQ
	(envelope-from <dmaengine+bounces-12181-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:08:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B12732009
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:08:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=U2t4Bh5o;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12181-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12181-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06853311876A
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E7C4229C3;
	Thu,  9 Jul 2026 13:59:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012026.outbound.protection.outlook.com [40.107.75.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93041F7EF;
	Thu,  9 Jul 2026 13:59:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605556; cv=fail; b=NKzVzbKPSqX2RKt37KU6jh6FNnYhpoagGmIKh/7PC7FvotlPzZ25e/luMyCJuXX/+2sD+WX89h2MX6jpk+edfacyR4y0SmAHryJX4+94ndJ6dE1MC44KqFj//FheNSjL0bijGhgbzOzlVIcucwcn0DPsatUyS/QiCmGhTDRerGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605556; c=relaxed/simple;
	bh=oYT1sbD7+UsZBXyR44JQZrIAruZkL2IbTrW9GHvvTG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=auwF+i8pvG605kRDWQRUJZqrZJlYuGfB0sb3l6mQaLcQ5fzL5rDGC9/1OU1XlQgJGNvL5rP5G+GzopJeC/flUTffA1zeM8JqeuYLUTHi+2caS1DFfzG2FGa6zueakeuPj3pxo8jMurFskSAfGv5gL2a3sbcmLUVByopG6HrJqQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=U2t4Bh5o; arc=fail smtp.client-ip=40.107.75.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJGUi+ORBpjQVORDFqJ40h3xmF7mcBgl3DmEdNH7WZOHOz7PYhZtUz+zGleMHuF6ozrLPSfzc4AmQtoaa8zwyX2aErv1v5RFzZhOsNz5lUq/jW1BiwEOYNwcjXGb5n83SSD8lgvQIw+erD4CAx6fgvplszXOdcSmmKpkkU6Y2UxnyuKjT4XyiJigpPibdvDcRy38gIa5uevZh38Bit7t6FCJbOVgjr90frUjMWgdu03J8BFt0KTu4rwEbYeL6rbQh/J20i5P/1zq/cspODlvUYpXVy3EaUyZALQhYGZF4t9aI1xC2x2PW1lTJHZqpJlxQWZeGNLlClpAg2f5UTuSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHdt80M6Xch9V6msT+1K0nDzKgsBdcd7w2pCI82Sn5g=;
 b=tLQw5qCLXEA48UOty4ridUonZwC4CBppLBlT42WMGQWlqDS8vSv/K4j9AX97nVEJHLUDlGvkJsimLr6atrTa6AB1wv2Qfl8HvTWYP9xLG51Six0pd7dZ3MI/VBvjqFBvKbEqIPY9tzFj3gcl6rBVLEjFCwW68wdUal2je+O5a1ZFoVRKUcLu08AkSko7qThmnlQR7/BuAD2s8r2X8ezSi/gGdBVId6PLYTSN6q6qdx7Ej7RkUs5IhgKRa8jbc8RpIsMW7toXRnNVyWV0TDSxDp0Uj9n8wIVDwwtsCH7rWiueuCWHzV/q+1o99++9z/6ZwFJEoQtBJy0a0PICWMZWRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHdt80M6Xch9V6msT+1K0nDzKgsBdcd7w2pCI82Sn5g=;
 b=U2t4Bh5oL3+1PwVfywFAGrNbHvo+OWpt8Fg8UzhFNDe67G3OhY20tHR5KmSHpqmLXQ3Ix2GFz6lLjIuB92OY8ilROaXsMcB73tS0zn97axoxqCV7Oxw5uH/WlzQm8L0A2uE9ltpUlZVkgcGX6eWFwZjmPRv5gAeYMj48m9Rny7q6Yv5Kaw5GiHMX1d6FBeawM2RrdopP5JcjsNjG3JL9LF7Lo7zG3Dt1MRKsPxRbTutt8tarDm4y7xm2+6XSVDA+hGjzMZdvS3rrqcdO6KToj+wSHVJxI1pn0xlKEXunKnG+krlhF3UMnD5TWBE7Q8AtTCASG0YrOrnqyiepZgXW0A==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by PUZPR06MB5673.apcprd06.prod.outlook.com (2603:1096:301:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:06 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:06 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Keguang Zhang <keguang.zhang@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-mips@vger.kernel.org (open list:MIPS/LOONGSON1 ARCHITECTURE),
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 03/26] dmaengine: loongson-loongson1-apb-dma: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:07 +0800
Message-Id: <20260709135846.97972-4-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|PUZPR06MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 00094d6b-1ecc-4ff7-256e-08deddc23db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|22082099003|18002099003|56012099006|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	nejFOkHxBfxlfNZIYI3Q+hvhfw5e+ibTpQc647qhEvuaa+eSLwFSeuV5QPUUi2FXJZqBGNs90sVimX8zJxgpzY2goVBzacHeTOLghhC6EbGKAkNkSjwXw05zGNM3hKBYg60WD+Mgn1e3oU1LWv3V7ZAzLV3qdVhZTCDg9RjPDcdWRexHDqluiKYTNGlzse962/OV036lcAi+wKkn4dNDa3wbDV7YOufcMGuQ7UGvCd2njb4Bm7vc/0Wv2/U4S/d/cZlItpynSAh8F/d/fRFVfqXrWZ6FcLnV4OICLVgXdNbeYG2ZUqV/HFatQPO5OnBHFPotx81fDvuoVlaoDM+EoJkHFyXdz2VzivToK3ZwVppEKQtuT4ym/OXtvNaGnemX6VyFAQrPCzIKupmdE0iS3Ccqyn4is/Glf08S5GVmAPniuOt6SHjoyodIbELo0iq0sgZixQ+SwYbqwCfXEEPqMMqTcM/NgCi9admYZNl8vbzDlhUMN3f6723lCR6X4cMrG4UXVKWN5uZevVrzdWPhg3dXT4TQTQ0P+eqlAXzFfAtJrCd+pbdMlj50fJP+TLvUaKVPOGIq4BO7g+n/gyi25+PYBU6uedgoC6LQDCVZ+nc4+Sa0O8nHQaeK1htGv40cIX1zH6esnqWoAP07oNms54SgMtpDzCnI4QJLFDUr/Vj2NxRt29+Fh8d6kC0JpwrboFrgUvxNISXZKKnN0LUxMADXZTyxjxXmVg3Czq7HNVM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MuiTJKnnChqTKZvc0g1ibOs0WwEsPhzNgFH/WMYMH9iq70/OIesBlD/TwMPk?=
 =?us-ascii?Q?sWTKcPeLb3JIoP58KzR0BBrBpw50pZPxlfp/lBmnqtXb5eAxL7DPnmV00L3h?=
 =?us-ascii?Q?5x67L8mgFm86urRSUAPYj1rTYYrDXJhmHX0JPTTKjvMu0wEdUQN4RdK8sy9M?=
 =?us-ascii?Q?kdYzsIG6SKx+z/AkQ6WGXGLpzk5m+F4+1UtRySZFWh2KmOaDnKp2wQ6npdk2?=
 =?us-ascii?Q?0jszbXLMfCYkahSlxuvtix92rqlwxx5+ALRDANZCqllRmRDaSr8OtHcoxr6/?=
 =?us-ascii?Q?uBl1u179VqriyaOXMEotgtJ6rLbnDaysS3W+/r88OvZVaU3G1onLPOvmpvye?=
 =?us-ascii?Q?w3DHrhiJRWyjSUEcPRkRVrTrKhsy/ZaaceB2S0GfemMmDA7WpDR0o4u15g+/?=
 =?us-ascii?Q?KgKMbniu3PcsSoYNCsVRhdZs14eQ15mC2tS/0iUlosQ8yzUwiCU2ejWWnzy7?=
 =?us-ascii?Q?VRUBx7gLq8HcHpIeHA2mac6+TeKQWBeO6TA3Xlzoyn7VN7sKkCOC6TD+q8RE?=
 =?us-ascii?Q?6Dek3pnarB/RAtgr4M6nelWrNN5NqUuJRsArE6CfehLloHrOnz+RYDgttL0L?=
 =?us-ascii?Q?UCPjtMQNtmbGr2plyC2X7XK0v3CJgSkhnQvwpe58Aj+c5Oeqoe/gYzfksjyV?=
 =?us-ascii?Q?vwHyO/31nXrUEAieV30/3CN4rfYhJRIsRbEhIZrKUGW3sA6J5SIUqZN0r4yd?=
 =?us-ascii?Q?JnEE83QD04MxxPJ7/nQUukRHdzetu0ufkCGM6FaWvdrMm0BW5IbLRDKxI37i?=
 =?us-ascii?Q?5mr8BPHDG3v9Umw44uxhLSGyPChlkqPYFnlJVFNZ7s4umAbySaVJNkPSHwWt?=
 =?us-ascii?Q?odEWTj2Y3iVofk7xwUFLeQ8oJ4V9TBTcHwMnwXQ9I8RLtp0MCjWD9ee/QZTD?=
 =?us-ascii?Q?waVHOcyqIUG72DNWhFFjYcgOYvRUFZrxz53mzMtOGpnmnOy+pZOpa8eZJQWJ?=
 =?us-ascii?Q?1MaIQmC7DPROMLqB74N4PZ/xl2lfifr+52/f97o0qKbi7w4GFLshVeLKAmHn?=
 =?us-ascii?Q?Uq8nirmHNhne/CVjXTX7q4QxTf+m+sQye+njYrroAn+w6T0guwGWk52gXxEG?=
 =?us-ascii?Q?PJopt/vA3zeFKAWfI5CEC+FhqtdmeCCV7RqkUxQ+42a5HF6Q/MmmTjOjBWJ2?=
 =?us-ascii?Q?pG790syTSTI1t2DZU/kJ0ijIcPaL5YnT9ohVPWHtoX/4z2031BnHRP3879vj?=
 =?us-ascii?Q?MM1gJdbcO8ng9vNhe7lA5sSsSSYZa0gePfsItlTNY1N6INzIoxqB2N6NgPwo?=
 =?us-ascii?Q?3ka5zkiBv1SRVuXnMsLmocBgoAy1uKlWrcixLQ2JljronFXx8PDkK1wU6gn7?=
 =?us-ascii?Q?slVe7MTmz6ET5l/aIoIF5dZCyRsaGEn3TAjAcB9psjwSxHAqoiROtTxaVgoE?=
 =?us-ascii?Q?Ge+SaS5XPs0okqaG4x3ra7EF2+PxqhLtsdtmoKYEDfuca5a0D0WcP5vL7I9W?=
 =?us-ascii?Q?V7pv/Uq5mCUOzF+RhB5R7BDJRtn3g9zTzLkFWslcd42LTyg74aG1vge4l0V3?=
 =?us-ascii?Q?iqFUdpL59ddomUIdpbQ6gFJseir+u+SXoHK8VFEdJlf3twpLTH6mW99gPGH8?=
 =?us-ascii?Q?91fs5yDZ0NA2IJHwr8orzxuvNCS9EoOt3IW+xeqe4p7CVtWiTgjCqOuOOUhY?=
 =?us-ascii?Q?qUcB6qeF/GTThK2RJT8PdmMT+wJORHwsJwVkHfesRmxqy4KLrSNyxPt667QY?=
 =?us-ascii?Q?5pHAH1YRzb92FrG8n7E8qnrTzBEQOeU4IGhw21IqQ3VH7eZ/baIBBDoWAkDn?=
 =?us-ascii?Q?5dPssRt82A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00094d6b-1ecc-4ff7-256e-08deddc23db1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:06.4191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3hq7PBs1aMd3c5duiF/Mamo7QHmOUZROMPbj4gq4HizEssybXftc01oUTAmyEakERugKwlfXMxvsduDS/CiQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12181-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:keguang.zhang@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-mips@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,m:keguangzhang@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17B12732009

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/loongson/loongson1-apb-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/loongson/loongson1-apb-dma.c b/drivers/dma/loongson/loongson1-apb-dma.c
index 89786cbd20ab..812bd7c2068f 100644
--- a/drivers/dma/loongson/loongson1-apb-dma.c
+++ b/drivers/dma/loongson/loongson1-apb-dma.c
@@ -162,10 +162,8 @@ static int ls1x_dma_alloc_chan_resources(struct dma_chan *dchan)
 
 	ret = devm_request_irq(dev, chan->irq, ls1x_dma_irq_handler,
 			       IRQF_SHARED, dma_chan_name(dchan), chan);
-	if (ret) {
-		dev_err(dev, "failed to request IRQ %d\n", chan->irq);
+	if (ret)
 		return ret;
-	}
 
 	chan->lli_pool = dma_pool_create(dma_chan_name(dchan), dev,
 					 sizeof(struct ls1x_dma_lli),
-- 
2.34.1


