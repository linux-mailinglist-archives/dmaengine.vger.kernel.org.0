Return-Path: <dmaengine+bounces-12275-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5++YKOioUGoV3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12275-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:10:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACF57384C3
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:10:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=PjuUpxiF;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12275-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12275-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65857301D749
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A85D3EF0A6;
	Fri, 10 Jul 2026 08:09:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020075.outbound.protection.outlook.com [52.101.229.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3239B970;
	Fri, 10 Jul 2026 08:09:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670968; cv=fail; b=Rb2/NRqZbPn3SFpONwmmvUg9uCdIs6ngrwE4cMNSs7SqGn2xyE7lMFxKuCmBq75PMNIYET9+IZYukMSLZ5gngvpNEO+bVWvzRX6U7WLlQSuM0FIYM1hQ3Ql/oNit6heauZcEX11zhYpfF66CHgPMxLnmUxJjos1RiN+tMiMNRsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670968; c=relaxed/simple;
	bh=eXH+uzCVRr+A8nYAA25q2v2aMBiD9PkLzbzi0UOUKiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TKB2uZGI5XhDD1VTeoHzgPTfy5RgIHV3x4j/jqSh5mqlzxSfBClBaSNaKyMJ0UD/duCH8gSKng9ftBWuLIObYbdlE8Q1iWd6UMMTyAx65AhsitkicO5l/Av2jAHyHzkU4HqCMIAJpjQB7yNJuZK7b24qudLjPxkFgKugVY6mIrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=PjuUpxiF; arc=fail smtp.client-ip=52.101.229.75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utseYKQ1WfULorGrZ1w6ckH/jNZamOQmD29R3fOh6rAf4BuBwyV67C4lsux9mPUc6gs477rXBt018Lat3vM1bDnSbf01elp7DHz3rHLWbr6uQqTPCClE6gRnz+aPtHGkfRj84MgB04Pul5AKDpsIE/T56aXD58HAnUfb1zFbcKWt0z1tfd5ebaCR6reeknPuc1f9IgiHQYp1mda/upjDeehZIDFDJC3tifP2P/3iG3iqWkx+GWUg8LlAfic3FOK5ohB5wfQg8LINSN24QvcHdx4B4rxOsIQw6Vo4i0BPpyPJIgJJXAyakYOSLCyxIyelqxh8yJ+Kg3DGI0pC5ANY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfdeU72KqHLcsdNNpZU7QVB649xp/LEXXktUw9aIUFg=;
 b=JnsSldSZUk4skHnXamFpJ2BjFTpjb2pF4OrTHSIloLUJOqlbQ33irb17x+RnC6rB0zjRu76RFM5fAiWmbqErBcwfE4MwNeb4Z0/RRaiibJhaoORCAHgCfWT6nS5OnsmJiM+pNIhFJfbrf8VwvFfKNdgcSDTcE4hTunsshkMPxbdxJUB/WHR35fXF4eH74Ntm6gR3wA6HvUwd/nkoXyFZpw4E/plkQ4rYXnPlpOFfq2iUmQmXEf4Ud0PlQ6Do6RAbyy5e+fOS0Ge4yI9cbVt7wXdxQwOvrNfMLHpoiDm02H/VfzXSYt14Td7tTdWYU+fafC2ivJDe9s9Xu9mwq1IkHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfdeU72KqHLcsdNNpZU7QVB649xp/LEXXktUw9aIUFg=;
 b=PjuUpxiFaNBW14w+W7og5f6pUlxE/I7WDjJJRe4x2uFE3E0fwp/rxuAyAa42fuW+dqro+K5foNqf0OIKylq5kdTraCTRmzpsIcX6AmpUAn5U8t0R7GOotfSFOG+61Oy2VZT4oTyYeUVti+e03l9KcvVIwxIhCZNsbngSFiEvKZk=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6374.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:09:14 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:09:14 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc: Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] dmaengine: dw-edma: Snapshot the v0 interrupt status once per handler pass
Date: Fri, 10 Jul 2026 17:09:02 +0900
Message-ID: <20260710080903.2392888-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710080903.2392888-1-den@valinux.co.jp>
References: <20260710080903.2392888-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0162.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e506be-3eb1-47e7-9ab2-08dede5a881c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NVJB6AlL3Kyad83unZ871tZfRQDS67ntuGEwqvvvcdn1CVzpmAJR/hdTNCQ9GS6F4qOAf2F2OQd8pSGvpc90diM0x3YDjZ86pw7pbZTuXmaA6aOQJfW/3CqvCk0vfPFxMSB5o+AXtSTrw6vH+6799h9Wb8MDerFLX+VZj8Z/E3YLSM3NsyWWnRuRc8fx/dPkCdqItK5QoVtg0DEgW5n9fFsV8uJ/Tru/ZKpLqHE4SUn2cJxwUpk3VlpY+D5YmPRFn2qc8AiXjprPQOo5zX8YTaJKJkgbybbqqhaU3Ekewgk7UWu9vOx8QMlDc9Q68lufZCZxoMyeld9i+XnoXRu4BIYjC6j9Gfdoq8MnBonKRyhZXTcWk2KKgDKQw2cCDtEyAsLBOi8etOFTiKhRjyI6sUXxwGwmrDQMI1WAOMLyDrE/4jGDCJ7ewGHpJqREXU1zHKGsFVfGJm+vSVCJ59/BzZAoSz8Ho9UyKcwDfagJNpTGl5lVQgaLxPayg7Fa/K4fTgr4kzz8UtEkbp10VHIwJWvHT0R0zBQnTt1MhZPoIvw5Rfyv9cmcnhYTkX2GmJKRFGjDNNZwHQrLnf9hUtfD9TQ8HjI7xT87UYouSj5obbUWMMZs8lUobfKnwRkQQjYnzFqVwhi1FuE4sYbfv4Zwwljahk2/4Tr+b/kMuDXBrE0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6BCnMav++UAV4Baxa1O5lFGlLEuTfTTTRJwKC5Utf8JHqjlIdIGf0OA6aabI?=
 =?us-ascii?Q?xS81LWsZyOzccokZmhD9W/x/toy9oqBkfyRQEq75sCsu/RXmgfgwyiK5voj7?=
 =?us-ascii?Q?9cBFAmjYguk09Nozn9ctvdoH3lY/t0Ur77oHTthS89yFLOgLJVFYFYIjhj4K?=
 =?us-ascii?Q?mK8oLG6JBgOyXypLQ4gXdlooKFmOGwIjONOpQKFOGcPtR/saNMQEYrksc0Ak?=
 =?us-ascii?Q?GA4FHb6wKhawe4R4xWQlabVog/VBqNRCi+qpz//1B42nMK7VFGbLLiPgajLC?=
 =?us-ascii?Q?eDirKDqUnAxQMWoXMC2zsveFkHc2+scAvwSrMBzNDoVDtjRgokxfI2yp0elI?=
 =?us-ascii?Q?V2eksCyAemV6urYVnMp7t1VQLJLpMPkCa49lPBipPunc5CMtTQC2wO7AZL5g?=
 =?us-ascii?Q?o9ICYY5l+eOXZecoza6CRRxO0LtiQrg84RZ+lGLFYVAgjeAsKbw8cmhN66io?=
 =?us-ascii?Q?SeflIHqrfGiVxAZAu7h0NI+jGuxYU4cEp2z2cHRB02B2idpEbnfN2e8FM+j+?=
 =?us-ascii?Q?6j3cdO2E3UstYedlJVFLDlVdFdPirFEuQwKjL5VpMDRB5YGViMyFbOhI3q9j?=
 =?us-ascii?Q?4CymHG02TIiREkHeviKxwNSEVxo+RdwZI1OKsyP5/cvEen0uWxh3KrJb+eIs?=
 =?us-ascii?Q?oIDrB7QSJWGw/dCDUr+ChbkQBpdE3ayuZkh6XHmjJ/TPtxG6LYaFmqm190ES?=
 =?us-ascii?Q?d1LAZMD8aKrs2UPcHHYGGOMN+BqbPwEvNd2szJ+t7WOA0ESrsL6ddDhmwApR?=
 =?us-ascii?Q?sRCKgR0cJTTrEFZ6JbgNFCfQKo698BXf+roQbjNVoIK8qNxuZfzgZopswi60?=
 =?us-ascii?Q?fa8EaDHU14EHtdaPywrCWdahd0Ekfj1r0a6ZCMz8FqjrANIV4OF8B7pW5Jd+?=
 =?us-ascii?Q?Jbn9n1YBeiKwvK0jeUmEpjcRaWegyMBS+QUwhNP51JOIiRpqo9d+4LPN1V1P?=
 =?us-ascii?Q?cHZnuM+ZNDz3dLkXnWZ46Zm6Stvbz+gqrbT0g5PrULHQKRiE30/L5KWuSS2y?=
 =?us-ascii?Q?o1tc5v0bNaSkCSxP1r1h4C8AGKMnPb+j14y+ulLFewETPksau6Anf+/Gm0k8?=
 =?us-ascii?Q?/gP1KpxAkgA9uNqmcARXHF2Vy49DVoa5ofRtZFA7kVukSHIGD9YgB/2No4Ty?=
 =?us-ascii?Q?Y37HVdTX4kx1IseOe6qnuVgaoS8WiuGA8+qo7Fw5ICxHOV/HlnWlV+gRd7UR?=
 =?us-ascii?Q?Yj3E4gbhUsS1zYlWyl9aPZq4fiGkCgrW4l3Va5M20ytMACrvBsQBLyvYsbgh?=
 =?us-ascii?Q?TMwfW6DlkHesKNS73tC7VrP7c6AC3yyj8M5IDr5rtuT9lhvgyC/yrUZmj5MF?=
 =?us-ascii?Q?c5N1rK9/FTFYLLdi9Ww2c1g2FUxBp7dF2DuF4nvrRuGEtH/BtkmGLJaPliNb?=
 =?us-ascii?Q?D3fWyeVIV4Aqs4YW6a7KDriJadgwnznWfcLxw43ET5U08UjC3qa0OLaG7lYN?=
 =?us-ascii?Q?6kDEUSZr3meY1L1G18vaDAnvIwKRSxhUwbDzPJwDVMFbkyjBb/HSzyg5UiC2?=
 =?us-ascii?Q?koggBPTQuMPLAr+G738SxNonQ2tElB334VAWXGMGPw9VvnHkZJIF8CCpD8WL?=
 =?us-ascii?Q?uwx5t4Z32ftkFU3J3Tal/4Zxs9ltCSVZpxzyvaja8ctBoIIkTCoqUM1DSXC5?=
 =?us-ascii?Q?LX3WUJ5ZE8Q1x27DmhEiQ1m2rH4kMktCc8PrZsZjYg/QA0rgvOi4Z1qrLat5?=
 =?us-ascii?Q?Oygh33XPAUNT3CHcOyVWkZGgoze9Y/GhiE5b4buEo3iIPVGJF1YRCMCOYYMM?=
 =?us-ascii?Q?AitQoKrHZEWDe08Eq2ZQ/qKO+dMfjISFAVdWjRimcp6JlxVb0VPU?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e506be-3eb1-47e7-9ab2-08dede5a881c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:09:14.5949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNXdXWcnEPaO+90LWpq48OPDjssgEjH4w62x0mLVxL6sxQYpzX7aNnZiA/7ltTLsiHYVzTlpJlkkHQknGkuXKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6374
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linux.dev,gmail.com,synopsys.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12275-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:cai.huoqing@linux.dev,m:fancer.lancer@gmail.com,m:Gustavo.Pimentel@synopsys.com,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7ACF57384C3

The v0 interrupt handler reads the interrupt status register twice per
invocation, once through the DONE accessor and once through the ABORT
accessor, although both fields live in the same 32-bit register. On
remote setups (dw-edma-pcie) each read is a non-posted round trip across
the PCIe link costing on the order of a microsecond, and with one
completion interrupt per element the duplicate adds up. As an example,
profiling the R-Car S4 remote path put the handler at ~7us per
invocation, dominated by such reads.

Read the register once and derive the DONE and ABORT views from the
snapshot. No abort is lost to this because the pass only clears status
bits it observed, so an abort raised after the snapshot keeps its status
and its own interrupt delivery brings it to the next pass. A second
abort on an observed channel cannot race the clear either, as an aborted
channel stays halted until software restarts it, and any restart follows
the abort() handling, which comes after
dw_edma_v0_core_clear_abort_int().

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - New patch in v2, posted as part of this preparation series.

 drivers/dma/dw-edma/dw-edma-v0-core.c | 28 +++++++++++++--------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index cfdd6463252e..377812eaa110 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -218,18 +218,6 @@ static void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
 		  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
 }
 
-static u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
-{
-	return FIELD_GET(EDMA_V0_DONE_INT_MASK,
-			 GET_RW_32(dw, dir, int_status));
-}
-
-static u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
-{
-	return FIELD_GET(EDMA_V0_ABORT_INT_MASK,
-			 GET_RW_32(dw, dir, int_status));
-}
-
 static irqreturn_t
 dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 			   dw_edma_handler_t done, dw_edma_handler_t abort)
@@ -239,7 +227,7 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	irqreturn_t ret = IRQ_NONE;
 	struct dw_edma_chan *chan;
 	unsigned long off;
-	u32 mask;
+	u32 mask, sts;
 
 	if (dir == EDMA_DIR_WRITE) {
 		total = dw->wr_ch_cnt;
@@ -251,7 +239,17 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 		mask = dw_irq->rd_mask;
 	}
 
-	val = dw_edma_v0_core_status_done_int(dw, dir);
+	/*
+	 * DONE and ABORT status share one register, and on remote setups
+	 * every read is a non-posted round trip across the PCIe link. Take
+	 * one snapshot and derive both views from it. An abort raised
+	 * after the snapshot is deferred, not lost: only bits observed in
+	 * the snapshot are ever cleared below, so its status survives for
+	 * the next invocation, which its own interrupt delivery triggers.
+	 */
+	sts = GET_RW_32(dw, dir, int_status);
+
+	val = FIELD_GET(EDMA_V0_DONE_INT_MASK, sts);
 	val &= mask;
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
@@ -262,7 +260,7 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 		ret = IRQ_HANDLED;
 	}
 
-	val = dw_edma_v0_core_status_abort_int(dw, dir);
+	val = FIELD_GET(EDMA_V0_ABORT_INT_MASK, sts);
 	val &= mask;
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
-- 
2.51.0


