Return-Path: <dmaengine+bounces-12191-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +zOWCCGsT2oNmgIAu9opvQ
	(envelope-from <dmaengine+bounces-12191-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:11:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 773F773208C
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:11:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=BFDnXm81;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12191-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12191-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A78B3316FA4E
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E20A368D7D;
	Thu,  9 Jul 2026 13:59:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013027.outbound.protection.outlook.com [40.107.44.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4384307BD;
	Thu,  9 Jul 2026 13:59:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605573; cv=fail; b=mvTAb6CkFFQOIzImKNqtWq9pqOxnrVUIJgyNMKorjKYk7WLfH2PtiZamFzYUvqvRASNOhqymyQQdXA0DY5Yh2+sZTE3OCzJlBDFxqY/flM+T9qdrD5aL10GvtLFys8C4E2rsPZcTBRxSGgzIcoUcgyy0bvGP5PCvJPhngjugS+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605573; c=relaxed/simple;
	bh=wL0aS3P9M+kCWfv0h4DcQo6Ild8S8DAPC1Ck2eaDIh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nzdqs4yIuoo6c8TcktzZgQzPlP1FCqWOpY8cPcPM1VLQqrhrgv5Lp3y+OBFaX6W5tiGxSaPPio3fzQXt43jUIQQMVDEohz7T14otSST76CguVG/A2vpmWByTaMQyNmmYepRHe1HtZHrSePsCRjvJGrGo1JXJJEuQC8RRNyjEhWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BFDnXm81; arc=fail smtp.client-ip=40.107.44.27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnrxUJkwpVtHka3RMBjKkxbSB0k0IxolNcqcDY1KchOXchkAVQqolmMYii9CclQPLptlVsvEh09EnUKIScUHnyTsvSuEECXK1ZUTnQfpNs3ARAdYXK5Hqf5gDdAmw+235vxtuOEHFgzSOiH5UQYE2cbChzYMe2MCibhXh2ZJNOGQYASGqdIwdFIxOaxrH9cyBwWmDYTt/pK8w7vCcGn8HcVTqKxtxdGRBtt8UDUfwaeXIN+/nCm+o0KJD8EtymWVKL1Ug7JwdQke6CEOr79tOKmn/i7ClO6WgATcdWTEgEJUIlESOvqyaX8nswLzwBIWv4gIBjrNQtIw+nbGzXmetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot6F4EFsJl61Z1SWCE/873ySDoxPYe8ZrkD3NnRCGNE=;
 b=vuvBp0pTGB7Ty6Hkk0mneDk7mkgIbvzGg17GPMYVNzWPUHsgsltv5aOtitrTGwajB+Zuixofl7zYrbqsC7Q/So86RuqHI7VlmnKcSFGIcjZHxu/7kFtHodJm7SscRnnZEECMjSZf+gLubv+BRaXJdvtr8qIN6edAoV81rJW6mFoIXqCnrFYDHHqN7RHFsepq2YKasrqgCGFooH6gM+8C8uxs2rFrGgJdDUctAB5b6D2+G9khRlOk0qiASML/CQH2c0CSuuKHMiGX99ImZ6GPL1ysCyHuFH4qDxqGdAVV/mqMKcn6w6OmJQTjZI/j18N+AYMlDc2fWKAX/DD8FhXF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot6F4EFsJl61Z1SWCE/873ySDoxPYe8ZrkD3NnRCGNE=;
 b=BFDnXm81o1YqeNRQfqc6oHOCwILatxg4yZYX05kD2FWpua6Li469pNUq1p1J/6peHwgwFxWkECIYKM+Y8z++4qa4oTsD3bOh8pIvRZ/VttbD4n+ec7HvFMjDJiNI3ebk0TRUZVr3yrTBhDlryLtp0E8O+7Zij8BZoNWY00ThoC3B1AtczidyGAUuJCSMoQI4/TWfZd1H20G7/peMrBM/H/ATLWf20K1GsEekzKMNKgjYmV74CMx0zpxLHMAgVeOpDVZ0MIbMw2rvsA0baoYmJZ3o3YlqHoNdv4LTgZdPa6q2/tq5twZ8QtagOKFo58CstKhybJzxXD3heaKx5mY14w==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SETPR06MB9093.apcprd06.prod.outlook.com (2603:1096:101:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:29 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:28 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 13/26] dmaengine: sh-rz-dmac: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:17 +0800
Message-Id: <20260709135846.97972-14-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SETPR06MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 96dd3a6f-6634-4cf3-1904-08deddc24ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|52116014|38350700014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	EGcf0LcX50CeefcKPgMK2hbytrn73MPsr2nrDkhhYHA9joK0YOi+4yWj9t+3NWLwLHflXwgyJ6L4jUM9QnfLWAv1dnoLMrASz0j2XyBnrXEy5U1PDA4QVoO7UZGoTxm5Btn67otIxHSqW2WXvo5vwpKus4CHfIkGrsbn4kFD+KNrBeJY6Tvu+o6aPXq/gIsQ7XqsCU0KVHyDO1O6k2ldyTvSwl98NC6CNElnFF6L7+0ZrPzRHEOkFaj5bcUqBRAHHmthvoFT8PpFgO1qEYpkxf8AXd8FVCAYE426YSfehU4WsuG2L16LB/IirJb5WKaSHrS2SutKHNOEzvu7PiOxbCRAkDCWWz6QMgbAEnvijRmxlSh5pRH/0IepunN2+8rCMXhGJXl5UCheiV9GZWWiYsG/yNRx332FV6V0TELzE0PHrh8ZSIBN9Ckq71upCMmctjZATM6s0nkLV/UPU0j0B+7C2Cv1NCJvPaQghsDh3JMQ/Wn5Ul9FABSl2DgJj9T89NAncHfN3HGSqHo9bT7KBjIzcB53CICyX9Tf2Ekdc40GONap5kYyjd0DNFhd2cwgzqTA7sjuWPxxyAcJB39v3oJ+e7omcM80a6sRqmV46ONuTyDzF5vZVAvsxMP1a0lxAuBOFVYiycNUWQrNBWDv3mf9063k5mlmZKyRThxeVXJhcjCcj9pWNGH/p76hMPIQRbuA9oTONWAoa9gFCrd2fC/Hun4XZMDM3bCyAkpc7rQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(52116014)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ScUXx7VwW3bTFMtDxohYN3/ooHSQEt9c2uOA6p6mQfDRkUSam9nRbmFlkRuP?=
 =?us-ascii?Q?51n3MH+mnHaImGe2TKZVl57z8xo9NHJieGdTxxCc53DoLyctPhZn1Pe/krny?=
 =?us-ascii?Q?E7DhvfyjxoWAURez2gV/JVDrCCEwUJI5MkeTHseKkrT+lVAEa3qKpz4ZkRo9?=
 =?us-ascii?Q?vBeqXNHmQf8jWJtY/1pPzy04Pho8kJjQESvbnHGVzZ15rgsLDEDcFn2amzvd?=
 =?us-ascii?Q?JQr7knc4swn4QN5mC/gClJYTrdy/a78vakoxx5zoJG2QSsWOPsKMJ2bipajC?=
 =?us-ascii?Q?JnCAhlH7zOlZyZA4VI+TMEWzSyfH/n0YLNHYwQ2ML94EUKSztQc3Hkpx7A4/?=
 =?us-ascii?Q?FT1uEL8pIWf9c/ncCPx1gnA0mfmoe9pZ51vlHEEu5u/H/npw2B5oaKy7HZGc?=
 =?us-ascii?Q?xTv2L5sEPbpfYxMwvoRI2I2RSOjsvJuSFV/chJYPJteT3T8kPZF+yEh0CYix?=
 =?us-ascii?Q?YLJX9vAjby1ob2e0GtMMG8MDB8OQ6ruy7hnFBRFKHiN1Lmz7OXzc7SjYRJco?=
 =?us-ascii?Q?6BCaeg2PihgkK0AQbruz7tw1jTWpCUEnzK9dS8L+ga+l07NouFDSNOO+xUAH?=
 =?us-ascii?Q?fPNVOQcNsPP6o+aanczBmLHdzrqkA1HVsT5fnSyT7x868DwM5fJv2R22LSrg?=
 =?us-ascii?Q?alDPnk+lUGXcdGT6NYJ9doVDXa5zBAWZkVmh1UkBTmooTmLupJSWuY+IOAXR?=
 =?us-ascii?Q?NtIkykS5r0Y4/Mk9kJaC59yVriafeaY/qkKeUFbsZQLwmiUqJfZqATXdbSAO?=
 =?us-ascii?Q?u6QJvxYwCCV4HmX0Z0V1EPFUTr0Kg0OApOEWRICO0KBIWv3ijgi4Fk6I8e7O?=
 =?us-ascii?Q?2b8Go+ZqZtFoQ47y3ZD8CJCtx3ESwktuZPL2AxDTrJ0ETuKuWB7YRrLh/9NC?=
 =?us-ascii?Q?E2Fd5fl/JkqsZ0UM2reXO40hcv+oYCT/uBxGmD82lHxwyJqjHeCuCguKNjsZ?=
 =?us-ascii?Q?+Q6tnbKR3gHuANdbdSRxcjyENpG2BwLlTPiVJ1OJBfFPjVydHzfDFP46g46T?=
 =?us-ascii?Q?VxLWQTZ4g3aDrJXKePp5RZdzdCwnZNT55A5Qh2ObuQ4eF4PYCreXDkYquX8q?=
 =?us-ascii?Q?Ia0+YnAo2UItxdVlL2xj6SwNcmrRWzugSxNn5vSGPAXLF8ljMv+tUU1A5AnJ?=
 =?us-ascii?Q?3nfyeGNk2JL9s+nm2J4upcZrtSQx0USMR0RRIRYR3NUSD9cunHZR4IkWaPVu?=
 =?us-ascii?Q?8/CCg+dI7ub5Y0mMpOVvzCvTieOvy/isMR1fXQwDhAAZc6DQ6i/I9r1cqfxs?=
 =?us-ascii?Q?ZLlN99Lu+iDRhIo770eha9iZqP3gkCg7KaswB0CuKmpRS3pWwHV+qRkLzFWx?=
 =?us-ascii?Q?a2GdrfKM6Rl5JCJFkOw1HcRST8PbTw/utF5FOeAzY9XDKnwJQMFTD3z8xcww?=
 =?us-ascii?Q?3Zpa5ONAxAxfjXlzD+VJky2OgMd+VEMg4UgiV8Ij7fZJLOZuhXwpFva9unzE?=
 =?us-ascii?Q?ZGq65pA0WXjrWgnj/8jrnL1DZOStsLZdxwuN2gobPux+iHD88kHV7jFQm9AZ?=
 =?us-ascii?Q?QnBdlxzE0Vzl/zYcHLirThrMQ7Swwgba0Hpu4Mr5oYK13THwAQmuORxWLoBN?=
 =?us-ascii?Q?gA8ckBTQARqVu16TpCJGK/czW8R3R4SFuC+YkmEQhwAzAwtc1X+/vLdsiumF?=
 =?us-ascii?Q?3vGpthPTEvG3ee0skoStw9P0TwT6f4hEOVKRvmDVGdMcr7z6mLI7ocyxYZUI?=
 =?us-ascii?Q?ln8QHy+yVAZn/AMTn5udFxGt3eWnpkLBfyvzlc9IcvUcK8oFbws5r6w3koHU?=
 =?us-ascii?Q?XIfy2sWRig=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dd3a6f-6634-4cf3-1904-08deddc24ad8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:28.3881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXWSyC4yv+7cndJigAkBiDtqkPBqojSHIn00CQFPpPeM2P5Xh1rnVUtDQSLAVm+4CeLyTHrTPHsyRellcXTifQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9093
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12191-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:geert+renesas@glider.be,m:biju.das.jz@bp.renesas.com,m:cosmin-gabriel.tanislav.xa@renesas.com,m:john.madieu.xa@bp.renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,m:geert@glider.be,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 773F773208C

The devm_request_threaded_irq() and devm_request_irq now automatically
logs detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/sh/rz-dmac.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index ca76f1bb45c4..b5ecab072be2 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -1335,9 +1335,6 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	ret = devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
 					rz_dmac_irq_handler_thread, 0,
 					irqname, channel);
-	if (ret)
-		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
-
 	return ret;
 }
 
@@ -1470,11 +1467,8 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	if (irq > 0) {
 		ret = devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
 				       irqname, NULL);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
-				irq, ret);
+		if (ret)
 			goto err;
-		}
 	}
 
 	/* Register the DMAC as a DMA provider for DT. */
-- 
2.34.1


