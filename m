Return-Path: <dmaengine+bounces-12196-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DPIEFsG0T2o1nAIAu9opvQ
	(envelope-from <dmaengine+bounces-12196-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:48:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8640C732749
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:48:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=VMvZ+h7o;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12196-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12196-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1ACCF310992A
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E46436352;
	Thu,  9 Jul 2026 13:59:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012064.outbound.protection.outlook.com [40.107.75.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA889435EF0;
	Thu,  9 Jul 2026 13:59:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605587; cv=fail; b=W4x9tqAYmhfx7R+0QVaB1qKqofLAYHzcti8gJKC4ks/EdGfM1hAJuvSxJWcItvaPbOiad7ogsbFwNmr6QNijvb10CS3pD3C0MeImz2i6UcOrjJ1XIRepl1eVVoVTxJxyxbctb6EYA/yW8vv5aoF3NRQ9Hepmu2WHh4XkC3rkXHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605587; c=relaxed/simple;
	bh=ZqggBjMfA5CtR0PN5iAB4RPlHpqdO2stQb7p5zee5LE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RMSZgxFv32hCXxTGKfs8u5d45Bpc5JZgVOzS3FooMIC4qHycSbIe6mroe9r+DNy5l0cVRC/MuuSXOzksJp3Dj0glUa4J8NBCvU+1GsF7putCUGlRyqOJd0LU9XVunQJVEPUfwrW3Pynsd+vkn1qlYwdEGXTSvdLZkelpTCAuoZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VMvZ+h7o; arc=fail smtp.client-ip=40.107.75.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYh4mkJfAIQxoY7JXgxZqPr7WEgeKjE1Bk9UPmHKnO9qqclYzLDXapNEC0l6GajXP4I783Xjyjo3amlJOTBVl2Epvng8UKHSZAQ8d7sHY1no0aOubL9ygYFutenghuiTsz5s/KxtV4xcLwLu2DXu7sS5VZQ0H/pjekyY9XLFokaOUyiXmp8gfwv37WnxfE+NMhL9Pd+eKmXqbtAek3B1SWrElZMYxb7XiNcmaptTpYoz/4f3E7AxdOrZINxXT6WZtLLSJzh/peDL6cNLcxzVjLSDyegpbw7V0EeCdWpazcYd8MMDaDd87LyAzg6c1ApGsYXhmRyaQIZqn+fYcTYzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5BdhywwM6iKpYXpMMWUHDoUa0HOxx7H0MsJJCVST9Y=;
 b=yuG8/PCMi/YEV7g0o6F/W31QYqUpA9UwLa2PJdoasU+jTKTcC20lkOck16kanpJNTz2gy/eCN+4f0yzS08Vy8KvvquIlUTefrEJQfslA+WGM3vKo4Tb+zNVsauOLa31fHpqAZ8VzkP6b7fWgp4Eq6T38Y6C60hxNL4uU2BzKIW7YBLmMUF/peOTd4iKvzbrsge1oTR9yizv8vfk4AGsTQAkyl6AtejWAbmcyoDSJ9jTZOqNaeFBe+hQw5V9GU1F9LTnAlvdZAVc8jnhjqoV/aHWTvLI/pYXhBgEKCmo1Fz1GzOMpH+1YfGopkO7qRmRsHn2glMJ/RP1coI3euWyJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5BdhywwM6iKpYXpMMWUHDoUa0HOxx7H0MsJJCVST9Y=;
 b=VMvZ+h7on3dTMSWapaLa0IEJz+fv4wymdfm7LRU1kMusk85Hnz/5TyMecqGcB110tRr4wy/wwSlZzbGf9XIDMhVA77iUF9MFrQCwJX+OKsbfS/Z2Gqah70byNPIL39TqBX5WvWeaHrp9TTySdfU8EsAV59WmwZgrZFsSEcIHcp0RePAUY4ffG+n66Yb+TqZE0g7WgLfhNu+a44M5vKkSyc886v5P6DC0/HK26+IQILLFeDSVF615/PTLnCi0O3/WleT8mVD9NiFBjUwy6TMPVjhtTo4Tr/Nrr8BWyxJbJm7RSbq/LNPQi9S9vYZ5RmOKpy0/I4lxuuT8dW2vmsXz6w==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SE2PPF271E4F3E3.apcprd06.prod.outlook.com (2603:1096:108:1::7c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 9 Jul 2026
 13:59:40 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:40 +0000
From: Pan Chuang <panchuang@vivo.com>
To: =?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org (open list:STM32 DMA DRIVERS),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:STM32 DMA DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 18/26] dmaengine: stm32-stm32-dma: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:22 +0800
Message-Id: <20260709135846.97972-19-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd99d73a-25f3-44f8-ac27-08deddc25207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|52116014|38350700014|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	H10YSAfhisJYiKswaP+Ls6hzuas+pm4CUOpitoBS3JPjgvZZQQvsMLjq2OT2RYcpeddsgdCCjBHfbKgh1uk20UBv+n0ABASCq0iT7Z39Hzm8axjVAYpMuBLGtktjU5J4OSUwrgPfHYu4wnQVjbzQghrlFv0POwHlzBKObz0N0a/LE+5wNqEA6Va+X5UqxYhwwqz+AzNK5niMKSTUBUrx/qLI7dN9bz+SnxXyw8zkZpJlmW8U6Aq0GcF1G4vrrvOYw+hgVJZCQudIwcuG6n7KETOSdly6R1xWhUcBJZuBwTzCWev+foSRrtfyKZq8370eWC6CbsLc2GQ8i1G0tdcITDZ5SQC9q3/Sd/5ScRTSE2Wfl6fYCPuw4hbAtkH4KG8MoH2mAaR21xYu2dPNOsd7arfdv2iJlVMESN6W6+CZqm1tmxsOzBu4SaAoXRox5R7q9t7Gxu8ghO9YheVytqf2K4GSSiB4hbIdLv8TLR+bsUmEtEbs47eQfcPpRUjNf7LguW2MSNDDS+iStxSfqUygiz3pB7tF/0jazbZWzlIuMSxSK/k5BvKlSKlp+9yp5PnfGzBUxAS0D9i8whcKKeqIs7A3XjCLm/wUyVz3yTye8UakqYVpba8OgYSwL7Cpzd5U3fzhgmwMWEU3pCZW3UEfVdoiAkSjDR6XyGz/zd7g0mXEntCmFD85QA5yWXDxo2P4Sz/iguuFFp7VZJQm/mXjnxNpwDRlfMnq6vgA0eE9fC8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(52116014)(38350700014)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r3j20V00+xTOOIZpBX7jkRv26HSJZueNOUfc0uP8gWjuDbCHLKVm8DX+M11w?=
 =?us-ascii?Q?eKU1zrNyZk1x0P5ODr83+Du3k9dOCipW6Thi7cc0DLtocKKKWO/ViocANEca?=
 =?us-ascii?Q?71et9M8zY9+C/qaSxAvvaX3lpSpWLVYjlejNo6ywRMPl4Yl62Fzsz3HAYO8U?=
 =?us-ascii?Q?MBVukyXpll8lA3dkMSiqZ3OLaT0PI4pJby8WIvUC1cer5jbvS7FbTXKmeOkm?=
 =?us-ascii?Q?Po+6rllGWK3Xf6M35hiBmOQi8n75yddixVr35tcZsV5Dh/pLvQqJvTql0Dd6?=
 =?us-ascii?Q?Mg5smsjGorliYL4Azj8UH66wvUOjEZGSBHuDAUDozksXqBCaOBcompea23xm?=
 =?us-ascii?Q?hTKV7ntstDAO6njHlQK8sXdDgip7LdvYvpbu4266pjs/ZE1W6iLfvCmF/Pxw?=
 =?us-ascii?Q?FgY++1nSPuJUWVzMcqWzo01qpyuZ03eI3p5Kj3pfOj9+TncI25ktZWIr6XHC?=
 =?us-ascii?Q?iR2Vq41CsWqT0bpy2Y5faQzmk4wKI2hLVUwWvtiJhgHozhcJcN7fN7NogK9x?=
 =?us-ascii?Q?fL0QVqBQQV0Xqi8bErtGuzeb+T00DWvwPMC8uwI61ssbwTrlxRlXu5Q2gBBo?=
 =?us-ascii?Q?YgZ/X9F4hD7UwWErdd0wMWfW68Fji/+dBYCi1Uah5dqM55gw2NfNfGZ9MEP7?=
 =?us-ascii?Q?ARi2IkBF6jJPscG+yLt/hIGnKiduP8xlz3a7NcwZEaeTuu4L33KzFOy7/3OL?=
 =?us-ascii?Q?IGH2/1ZCB/UZScuTT0Ldx/d6LWEG1oNoHqJUIYjcD+jQNHKGUhvV08vCF2Pm?=
 =?us-ascii?Q?8kWIaoZWZWHt/Nzz27UjwUxOue0urdnRqUZ+9S63V7Yn1URkOLasbSZDWOab?=
 =?us-ascii?Q?COf4BXA7Fmle28tii+iH2GCzwEgxPgpfDRzU1DVMo3/OT+ZUKztM8uxttEKq?=
 =?us-ascii?Q?uNDPtzTHY9C2KxFD/C/MO+EnZgNTzaXsjA22jPg6tChPVOqvusnN3Uv0fXyw?=
 =?us-ascii?Q?PeCnPqNwChxFut9rGQpETMJIoRqN/adwb6P0/GK1SguPhwkdLe4S0d/PvuEx?=
 =?us-ascii?Q?7jADTYC/ryvGFRoPvm4hkY1M6MISqLe3uaqX/+8UzAaK2CYWLfGk3RIN79Gw?=
 =?us-ascii?Q?2rq/rucV/onYfomBS4vo/JYuS1Mm2lH4QtYwZja1X+jynFz5FuJhpFpkhCX1?=
 =?us-ascii?Q?lnux1rZ8bIg4sS7q4lDGRss8+4woBppEPluQmFOVf6aexDU0ovFApq22Y2Yd?=
 =?us-ascii?Q?fBflpvzBHA+DW37eaJkWy/Sxeks8gFJfGB+WLD8y12/0w9nX7YlXd0bkebZD?=
 =?us-ascii?Q?7Yp2i9Zr19CQJ/AO+DK0crIAcUxzBPIoHA3+wce1sR7zSj//CzkPV3tApkZC?=
 =?us-ascii?Q?j2cRHlS6LVj1ALMHBrFaQ3xFTNHDk00iiQoy/l1Ut7j+PaY7EAi5XEQqbJ7X?=
 =?us-ascii?Q?dr8WdLqVhlPMb4Srm6mLKwoIcfXB1SDBVcWCPGGj0nCzPvjHwRbUfH/sIJpA?=
 =?us-ascii?Q?pThPvvxhWPf98eOPLYuaYYEjRAMs1ctNZAYc/aFz3aBOvMCGAxOLDKNZ+i8m?=
 =?us-ascii?Q?nvFh8FlTc32jvHVFHlKO30rfqcob/O0QivWZg4sHYXhGl9p1HZCtwTfl1DMo?=
 =?us-ascii?Q?MAi2oZQzSrfZcRTSjPHZoQK2dq8AYAfipWAQn2V1R5ZEj/4Fj6x4Q9x3lzci?=
 =?us-ascii?Q?PN3nAZtZFQ00gpMkHct75lTDz8EM8cDN1FTdt8s71LTmbuRMAH+iihev7eXK?=
 =?us-ascii?Q?yQWRbjOHTFGQOhoN046W1t1UGS6zp82U6xPeX2sFxwC2gI9J1auGvfRJHkn2?=
 =?us-ascii?Q?7uuXmBJU4g=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd99d73a-25f3-44f8-ac27-08deddc25207
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:40.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISzXrvpzQczz7m1r82dqti6v7V2gEweeoLQQEaxn8ic439S2jhrtJOzriiO5S/fvRNxTb0x3wzEFu1kldcMMCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF271E4F3E3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[foss.st.com,kernel.org,gmail.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12196-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amelie.delaunay@foss.st.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:dmaengine@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8640C732749

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/stm32/stm32-dma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32-dma.c
index d3ad78562a14..51cb2328a8e1 100644
--- a/drivers/dma/stm32/stm32-dma.c
+++ b/drivers/dma/stm32/stm32-dma.c
@@ -1669,12 +1669,8 @@ static int stm32_dma_probe(struct platform_device *pdev)
 		ret = devm_request_irq(&pdev->dev, chan->irq,
 				       stm32_dma_chan_irq, 0,
 				       dev_name(chan2dev(chan)), chan);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"request_irq failed with err %d channel %d\n",
-				ret, i);
+		if (ret)
 			goto err_unregister;
-		}
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
-- 
2.34.1


