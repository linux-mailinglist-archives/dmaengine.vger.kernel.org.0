Return-Path: <dmaengine+bounces-12190-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jAzcJBSsT2oLmgIAu9opvQ
	(envelope-from <dmaengine+bounces-12190-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:11:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC2B732083
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:11:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=I2fkexvZ;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12190-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12190-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 019283169C2D
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DBA4343F8;
	Thu,  9 Jul 2026 13:59:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013056.outbound.protection.outlook.com [40.107.44.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96614343E5;
	Thu,  9 Jul 2026 13:59:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605568; cv=fail; b=jpUSF28vEoHODRly5XJVO4hDd2QXYpEPKtz03ZsRqUdeOygRoZOw3NNERZNGekjAYry5lEJvBC6HyxEsc4+khfXm+/RdyJHAuCZjLlKJso+fZ33uuDFw6iSVgGPifEiiAEx9cIGsSiLLd/MTJyrW06qSakLA+IrS0JAq5H6HfCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605568; c=relaxed/simple;
	bh=BQvZ1EYJe3/gqczJwk3PSs5zXaYUeQYSjMGe4BHGmEg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qa+XmW2i/nzZtn8Wrf7siCklZbv07CTjlb20idaE+Xo/k3jJq2JuAA2IUN29cbQboowNZvJt3kyu91oEH0CXhFCrL0L+CjrpBpT1MB0M/qAit4VUg5LyDbdwOxJObbc8iPaWyfldps9ilSawXHwG88CE1ljCpegpg1NJ9JmgDVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=I2fkexvZ; arc=fail smtp.client-ip=40.107.44.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXZtVnV9uL+fGpv1p++xJOmniCLz2W5jcn/Vq11k9ezeH4NkN1/dPIO5zTesu+XvQWzL+VIK2Bgh9uI47B2B+QIz9vbGF5zeHr2ALEPNBx7JK4T/9wND1TBi41TMkGPWDkyqHf432aeO4jvtElrZXirhU6meu+FlYXABOV1vc6oLnTtjIIbbEHrqIv6POgislQMEq0t67vp5T86y4uLs0CKjMEJJgrSiYz/+snELUQeKTmSp03DkVICUmRSXDFI4jB17yesLzt3cGrb5f6RzUParPFNpbbdVii6u+DIMfdhDhDtkJWvgn9lYR1UHVt/628JwqXZTRmaRa5U7mq5AQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwtCPwosBMBXIXZ797yKeRp4F054TEazwIGmef3+2L0=;
 b=OG/Z7xz7exhfP+uYhsvciCXp8c7FyKMSLkVH786/j8hxDiUfJcunp41u0bjzVc89Ip9it8YTyYEwJaBta2fcUpjoXuatLGP7BkpfekTiVBaXruJBHH9GMUHV8c4jiUxYdkMupWtiaG6e8hFHZpvwUCPuseSJFbv2RBwWqPmh7QiCAJxNT7NtFZIZMKNZftOKuVPlT4fo/RX4HMpt4TggWbzylBfjewAUnnn7BGBaPj+VRlgXSY/xz19jUyMvYNj/m+Sj/PUQaJX+rkM2Hzqie2rBkt/r8UWEz5+ibrCgLg5Qs0cD/Cfsb8E+ViqpjqRgr2WUz5ChrVytMm7ARaxScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwtCPwosBMBXIXZ797yKeRp4F054TEazwIGmef3+2L0=;
 b=I2fkexvZyn0gPAt+NT4U0DtTz5lH8SyFPfPVpu89nVGvv5tKpu6OfHseHRkm5amxYCH8iMvGBWmyqj0hZdsCWyGkQbr/Gnn1D1MWDmCQ1dgE6MCZJ0vCfzhqnMOAoc/J19jTMbgWpdTazgeKVwxmql0HYrk8HKGnLXv3AkGrMrFUgNRzSvQrUd/HSWxKGLOA3WfNmrlVRBWYFlfVJeY2121VGinVDjUaY5GFfPjsPsbzqGramAA9f5Ava/HppWQ69ElLllChSa8eVd5Y0rZmu3Aylt2wr8P47XzTQTiM2nhA2x5D2LhPKYJ6+hG5t+5+v4NtzBfuJiAGLp7P00tPBA==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SETPR06MB9093.apcprd06.prod.outlook.com (2603:1096:101:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:24 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:24 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Pan Chuang <panchuang@vivo.com>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-renesas-soc@vger.kernel.org (open list:ARM/RISC-V/RENESAS ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 12/26] dmaengine: sh-rcar-dmac: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:16 +0800
Message-Id: <20260709135846.97972-13-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2fa32d21-8ae3-40fe-64a2-08deddc24867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|52116014|38350700014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	crxQbo7aJ86udxF3NdNVMbBB2S/qAOBij6w+pVWd8Cwug/5d/RTVrA/XKjb9Q71vsqdjyVe5xxUeFyYr9GcPNt1DxJ6r2h4ARCyDxy/kL2s9Hg8PN/Sv08LgR7SxEiykjitFVWB2PGzgdGdtO2oJzpR0I0No/FhqgBNolHdn+I7IVEefzWRxcK47+XAWySCcTXwE3NiNO1ZEUZTuocsgu6mktmxeZc9sn/IEdnRc2DIAFU0wZBrcSchvsLQ3uaVEZJliT3A+szRWDzKNpE88OgTnyd/+L+nNxFgMtj0R2/AGzuP9r/PeQauF5OLp0jHytEM7TSq6ycXd+fTKvYfuWpDE/GT74YYH+3oL21XzA8FoU87j5y6AyeM+St/ZBgcZazdwzQpJe+UcNiA2hkQCoEe+P43N2QZvFHhXSqXN/dRugC7Dp0wSwDR2T1j3NUc/bXOwOIB/iU5ruMiLxR+e8hOw16JCDTj7ydQndewBjT4CvvffeZHrsI8rKLIcamrWuEX9dFaENPVclCxbJHq3O7R3Y5e5QHFsIs0fDg+vfpcKTgE52wDQh0GuLUgmgioTnsoaHPimuSXvVC4J6XoZf7CtYs6QqCIbLClEDsoNSHqcrO0jtbXBu32rYxhFfo6DJiBaxlgK8/FWhhlx0Suk9QCG9mBVrHSas33dd6JEuq+p0zDwTEARkGcec3KZ6aHx1/xky5bZnZabN4ASn1hcHF2/E5hJZ/jBeXeQTl0vj+0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(52116014)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?01IlZ5mJdfbig24p0X/evlBKuE8Nu/4mg430A95JbYh6UgCUQqAHa2Gb7702?=
 =?us-ascii?Q?Hsp1RT2tul2K0GhxdgrPc0+ukPjAt7gnGuy0A8RY6oGLzUZMqVpuAgZtF0yd?=
 =?us-ascii?Q?nP0uQY7etoPfzmUVahPv0AgC52dsTjV3Ge3VmRObNWzwV1DjOLS6SOGOLBwP?=
 =?us-ascii?Q?3ptDW0TjLgoDlz5p/FVXrwZUB6tY3xmGbbz23JhFj9b1RMoHIL3byOVaDTUV?=
 =?us-ascii?Q?eKF2UWVsVOgTKE6C+jRU+iePk5W/uRa5MWt0YlpH4iUjWp1b3IEzk1TtHGZt?=
 =?us-ascii?Q?j96C6Dzsf8urz7SfMTR5xugH+rysm0Ez+ci86ZnPVhWlnrghwMCcY6bVPT1k?=
 =?us-ascii?Q?We9Mw3BftxxiJOOoLaAOXEe3ET8TspA2FhtQrq+sse6YFfMDE/xk3QFZ+HyK?=
 =?us-ascii?Q?4eZ/03BFXDzHzCkQHYZSnRQAv+XPs7IAOUzsQQvZyhLnfK2gvpDgOttCGntY?=
 =?us-ascii?Q?P7uHi4yN91PlaEUr9ThUyhOnVshSpV6S6QG+6E6YrOO3J48/Qw/x7qOUY8m/?=
 =?us-ascii?Q?LnDXXChGiWtg8WI80dwjjVhBpjOdjNvhRYxIR1aM6d5eDw4eYjkSE5H38JDf?=
 =?us-ascii?Q?VQowxf1yxyIZVtKI/E6VeDn7h/KF2QdhLvlRM6VOZQ8q8M2BJC4iIPwxRqNG?=
 =?us-ascii?Q?kT4vmFtqFZmFt4geTLXtgBz2ZZ2wEBWSfdmbwPWL5Cczyg67psIcpDx6x2w5?=
 =?us-ascii?Q?ulmVgcNhtNj1+deq0ipb/kL6Zc4nDZCM687Oog469pPvYfCLS7FlIZp0+HOm?=
 =?us-ascii?Q?2shx5SjhLMjkJg9qSwG3o6a0KBt7WXb461d4tzT0dodC9hZrgKlDeNwuGTYf?=
 =?us-ascii?Q?SAerTxfxcjz8xIylRfdTaBGAsd2/seAb4n+8ir9m8L3+0Iz3NTRd6qbLEqpP?=
 =?us-ascii?Q?sJsZTFy96/2G8KtioWEqtUh5HnAICIRAd7xVEeDuBy3VctJ/J71IeZGmjUy/?=
 =?us-ascii?Q?9CQDAkEcJw2Qzcd/wZWWT5baikyLMV4SMm0kANHtPixAo+xVL99go0oIcrma?=
 =?us-ascii?Q?NDrbh7N7qkC7YP6uMOVVwj4cWDCBvy81LTszMi6Gkim2BxwSnXdnha4TCmNa?=
 =?us-ascii?Q?opjjbGCqjvg+xoW5xN8gE8kRKVVfSePbfeOfNKE7z7Hb8lva50KbqD7qIG87?=
 =?us-ascii?Q?FNBJqfobirhD5KNyi9alkCES/AujUjC+0KP9h0p7UI1Fa7h5xDFTAeQPStOQ?=
 =?us-ascii?Q?1MdnTbVQFsYvnKakIxBzi3/EtgHbaGq026fim5OSC0ZRKkZAhVwQffHLg7Uh?=
 =?us-ascii?Q?nFmL6m8Lkbgm38dm3orfX0QOT5B/0UVs+WPfV3jNWra2oXqx8hl1bFw803Jq?=
 =?us-ascii?Q?0Fqtd6eWXDC9/iJS5uYMxYr6UEtiCw9iq5bUXk23NUDN9DdIYUUB7OKLsJR6?=
 =?us-ascii?Q?cFdWNEvlVpQuM4Vtgq998kNXn0X91rVSEUD5Sb9mRxDh8TyQaMQhdS81clid?=
 =?us-ascii?Q?/tAFy+ragZ8+MAdPE23cSariEEdnblEUzYBPopEnYWXResChe0KVy1lVJny5?=
 =?us-ascii?Q?9oCrcrxORFDLpVj80R39ceKtlNSE9e8EeutgBO1aTgbDm2Yum8ZQipQCZPiR?=
 =?us-ascii?Q?/XfEfzHiItitOOC2AZjWU36v16REUNmAwBCsEh6ypia0AKfHSF6ifSUOnbZ0?=
 =?us-ascii?Q?VOPRByOBn9sGwgccPeVv5fYEgS123YOPRFXRm5R7hJXBJpU+vn3i3q6mqcZm?=
 =?us-ascii?Q?j1/IJXovsVj4T4qOzjRliydtIpdksBE/IpTjNIVFNpV8DLE4z+Vot5rwX/wx?=
 =?us-ascii?Q?ivtvR1MO8w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa32d21-8ae3-40fe-64a2-08deddc24867
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:24.3120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afhw5FfVrwtFOV5YJrnmDZviA9OwGj0gEI7+EBqZuaqt2dLZBBFVz6ZXwnbFS92tp3lI1ONpiWGePUJBywIJqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9093
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12190-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,glider.be,gmail.com,vivo.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:kees@kernel.org,m:panchuang@vivo.com,m:dmaengine@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBC2B732083

The devm_request_threaded_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err() and dev_err_probe() calls that previously printed generic
messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/sh/rcar-dmac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 44eab2d21d54..4cd7f0189bc7 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1793,11 +1793,8 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 					rcar_dmac_isr_channel,
 					rcar_dmac_isr_channel_thread, 0,
 					irqname, rchan);
-	if (ret) {
-		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n",
-			rchan->irq, ret);
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
-- 
2.34.1


