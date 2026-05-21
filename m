Return-Path: <dmaengine+bounces-10663-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE0gONAxD2qSHgYAu9opvQ
	(envelope-from <dmaengine+bounces-10663-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:24:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9035A9381
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2505F31A3F9A
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 14:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158A03E0C70;
	Thu, 21 May 2026 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qAMmbo+J"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020089.outbound.protection.outlook.com [52.101.228.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADFC3DC4D9;
	Thu, 21 May 2026 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373332; cv=fail; b=dmr1USf6zv5uEfuBCSnSEEnmtK3c50LCDHGCZbfwiF6H+xKR6w3lq6fjO16ERU192hcuJdzdK90ErSiH1BfWHhbitPpAkFNTiAglh+S0wcM+8wDRhewHDl/mF9Kgg9K2ZOs/mqVbdhCAaBpag7JVHjFvnRSXAZ4DCIgN0fUHubQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373332; c=relaxed/simple;
	bh=oRkagc8aFOo1+CJm7NDXMt8SySAmrqcM9O/n/bBChxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j6Pl8Bx89j/zfiI7JCzxQWmkHr+sYmaDZRsuS6YKIY8rQiViWDHGOjmTR6f+jO0vbkYQDqPtOpn/zCye+7ftZjHovwRuOqHzzpNYDC6d6/rXQLpX8FSgOLvPp76m88uWrfEDDMgtYOq8cp6en2HtrraIsGK/6R+Ey3FCC5iuIY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qAMmbo+J; arc=fail smtp.client-ip=52.101.228.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8z5/hWmfBABB1Th+0iTYS7PnFN9jtKlFfdFTsCkUSuCK7MyHFgkJJ1wJp/6647YNZxw55eXex6K0CUN2659i2sAPNu0OExEkixGbAEV3XGBvKr8C4laYeA7wy/s2n9qg7ZRiYZIMvYSqg7vkNngywAFq18BdYVAIwRtOBgEOqrGpZqWcHK/iKLCzsh2GvxOi0P/n1eO6Zu/lJBgpVNuSlP65oXTwm4c51Lz4cVemJTp2RJGAOQbqsAsPeRv1sl7RkD/VmQxjUvSoyw7AFJuoE+WPF/UyElgIKGzlyHHuf/V6RdrcVgmzv7Tmoz1KTaa2MVPbMCyydiuDq6veMFGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTNTx4x9ZOqI/1aVuecFs6ey9HTxleqC6NhZo9jWifQ=;
 b=NBmTQbwOMtXV5F6mbofY2QtzqUy5FSwrtw68tFGpWWeDAbeyPZz8nYf/KV6jfxcu8xWW5zK3azNQHsUAiRGIy/DbqsqK9/yTYmXfuLruZfqvkpKVAdi+E5YU0HGR0vMF4OWnOU5s80FuC41n79PAfEkUwerzz0ZXwdyNfVIklbqIrH9j0B/ky7UGau9fO+oViMgXGJCLjxRPWTozucbrCxji9/bDe97jy48CCn8ry7SUd0XyP5APc5Kksn3kvfwmKBHHzLfPlDJ7qmyOHn4LnOCa19kAZ/7hzyUaz0Ii11vSVNiUN/7Z1+ziDHr1JDxTBEhzdIyEp9ENhowUpacODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTNTx4x9ZOqI/1aVuecFs6ey9HTxleqC6NhZo9jWifQ=;
 b=qAMmbo+J1Mj0Z/Ib6d3h3Acr9kkxZwGa6+PAOu3tJGyHPzlnmHJ0Th3CqDspA6Id4JSg6wD5fQtJrs60UmR52p+4nQzNKQKQZ5HSRgBxcFe+PMNx5hy0I6nmGYiFCkS0Na2AAGrSLygI4ZlJ6JeiePHyfQSnh732ZXWGbHiCiqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6259.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:22:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 14:22:02 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK
Date: Thu, 21 May 2026 23:21:53 +0900
Message-ID: <20260521142153.2957432-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521142153.2957432-1-den@valinux.co.jp>
References: <20260521142153.2957432-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0164.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a838a8-a16e-4657-619a-08deb74453cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2BmcL5BhxRF4Zxh8bN5IMf/MLWX716glpwRTe/TOT4ybQ6pEFrNu+5+JfXQLhdU/ULlul9G13h7SMnjgEN+qvReIuGIcEUqmqUxl+l2phtaBDqXUjGQ3usciYE7X0C7Ow8E4Ol4S4AWQxT6WnRhPDgTHDaFA+ttsvb3tDTwWgf1Bc9YmpJxH4yrZ7gN3xeauPc48Byjk/Rrrms/Omu2r7r3Ggr3I0JIuaLrr9i4SpkifV6vShwugDIiEjVhW2M/PBKWHyH6cBJky/Ock1ZhR3rI1uUaWHMGFmsfcA1f9VN+1P8Scv/0NWfIsmSF/ja4qpkgQVEK4RXIXvG8MbiJMnI9RYOqrLtEHEGbHdzVA86VNXuR6QwDj0lySH/y7QDrA39Wkw/44Ci5z5xvDbNTQPwSQzGCMlJZPoHZS/170As5ao4a6gCCYxOGb8l3zO/R3qHMy4FULs8erXudc98TJiUpJXtITxQoRDl+PkIOHiS6YonVvzWpsBIE6gXgrN22l5TNAGeYXN1qDa5OIWfFz7wrepF2fkxW0DkserWt7sEag7XrUOOaJgMzA6GtG2Aiud/zsLScv00RwpFnxrUuF3QW9qYTsZJK8y0huPnIdVnrXzVE4BYr7vmlEsmivc99Es23ZGmQucxybq+hl7wn8WdwMxbSOXsD45ciw4vjKNUGRM3QrcMZegzkqSX2pkKf9N2UkEUVUKYAFYoOU+IWMcw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FqOEtedeDDNCWiKRB37f4xigJbAIvNpq0vspiNcOE/8i9C9XvFWSRzO8hpmo?=
 =?us-ascii?Q?lyZyBINH0OCsU4n/+zt/YCa5Xvk4GEEwvDUeS3UsOXzwJKgPgeAL6bmnoMID?=
 =?us-ascii?Q?cRz4Rl5hMrSQAlb7STGyuNfObNtxIJ6330qcGac+BkLVI3rzIXSu1V9RPUin?=
 =?us-ascii?Q?WkiU7laybyiOiba9ETl58k1Gr5+n8iDYsPO0PvATe9cDxcbcpko/GEGku+Pf?=
 =?us-ascii?Q?eGrCPhpQ4R+nHVlOQyjDAYVUlfON8ggwdJ0PjFjqTFOAg/0a/53RxkvfjWn7?=
 =?us-ascii?Q?o2hDgE0ANxIrhJqx0JxsdIpiW2+6y9AFQMDovO+6qQ175JYV4gSgyNvi1TkL?=
 =?us-ascii?Q?g6T6sTLGvawq/XjPLoNP8X8vQuT5RGzPmMtRWrc3uLLM3gk7Dg2SqO54/9/j?=
 =?us-ascii?Q?8S1PEGJL1IovnnCQaW28l5I8gkK6lmbz2Oxa1YR/ZASBWbrLCQ6hnc5hHgSv?=
 =?us-ascii?Q?gGG3g0pMHWip7aIPs+vKmTronJd4tFEN4xU0ie109ehfnRMd5INDUYOey1yx?=
 =?us-ascii?Q?F5yHBA+g5WgkGGcNc7O/izJ78QYj4m0zJSodIoq63ofo/m60rmGSpTeDspDl?=
 =?us-ascii?Q?hf0I/xKdLNQl4vuEueKnpWqkmbs6xzQ8A/DAUKxAGvYoWEr2aWqssYF8bgEV?=
 =?us-ascii?Q?DBav8bj3FsQRFgMdJxgb2bS9rrUj55v5kjInuX6IN686jSiI+Cow3RK32q8N?=
 =?us-ascii?Q?x4eP7XmC3lKL1oWPcSr9rAWb8IoI3ck4yf3Wd11BruekP5QboG4k0MkcWnt3?=
 =?us-ascii?Q?zmYblLKAXkSYxX2Nt2nuVhXHqwIAJB6KfsyRrciVpPYntfy94bhI0irxLtMq?=
 =?us-ascii?Q?ZJ1LGEs8tjCzZ6tyIi17SFfwJKfKtssilwO78IuqMjzYWxbFomw/sKsdx7Fk?=
 =?us-ascii?Q?iLKHBlpUrSPttk/unsVk4E0U8zdVGnTVds6nejDCwMcEDGI4MellAqrBJwOT?=
 =?us-ascii?Q?3/Vih0/fNV533mPeLBmjHbXOAyuBmSpPVTa5GoGaE6gxlYEJvxxLoEjOVLKc?=
 =?us-ascii?Q?wOSFnmDr9sZinyCZCz+gpCz4xC8VvFtlsDpHE3VLpCHJkyeFrt8xeXeHkj/B?=
 =?us-ascii?Q?8AX/deKJzX64TDVPVO5TowfXuPYhs3b6EM/UDzVoO+IfUsXacI0ouTfdTnzs?=
 =?us-ascii?Q?jwRkKb4XYvcHnMVoyu57YeMp/3UOX49yVWdqbUSruq+wgEaOw00N2Pfwu8GT?=
 =?us-ascii?Q?EgfEWrAWRQHrQL9YKZwYZFuZuqkgVldFGTHb5J9J8BxTCsc3L7dxSMCxbQgt?=
 =?us-ascii?Q?8OLEEt6grID5ngtyttME8JT6UzaeknJ6oakUAwFQR14pdovTqWmIiRluOB/u?=
 =?us-ascii?Q?SMd9MwRYVYRovDXgYu2KwZiqZJ23MSkagRtbM6JYKqgroU4BzTqfOAxZ1hmG?=
 =?us-ascii?Q?HCWNSifNSStaHCJYyZY1AHsad8Pl/duaj0UkppHBd7NWIpAhxxKEF+C6BbFn?=
 =?us-ascii?Q?/ZUqkTZFDVhxaLWfQ/DofiwF8CTfInGUIHUrG1qChTON0IwNdMZgBX1OgquX?=
 =?us-ascii?Q?8s/Wo2g+NxEPnhndElSWM9GXSHCT+f2WjguZeiutlZEoVDAlsICxQQVHyzpq?=
 =?us-ascii?Q?B6IQBgLnlf6+PCj5x9HC2UjhDWyc0OYl83t5DpT0pRjL72nVBXmhFFCE18pE?=
 =?us-ascii?Q?eaKHO4aZ0dFi6s9NhmKUnZy95hWH5Iao40a8q8qRkg3Y3m5ogl0ulmNWKoDI?=
 =?us-ascii?Q?98wG/FVDeDJAPZMqC/VveymPl7zg7WgVAyknK7ws8fINhvPPxVi/rI/d0k8B?=
 =?us-ascii?Q?tAcy7Qy3K+BZSJpC+Jvw1fr3rpf8eU6k2oMfzZfYfqmCpe8ybNI1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a838a8-a16e-4657-619a-08deb74453cb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:22:02.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvUnQR9wiIE3mWU/BHXK4yvUHHiU9DMZT3tL58mOd4B1bQ4vme0//cOgyGK4y43AUckNh/I2TLP16DecpL3rVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6259
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10663-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:email,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 8D9035A9381
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

The DONE_INT_MASK and ABORT_INT_MASK registers are shared by all DMA
channels, and modifying them requires a read-modify-write sequence.
Because this operation is not atomic, concurrent calls to
dw_edma_v0_core_start() can introduce race conditions if two channels
update these registers simultaneously.

Add a spinlock to serialize access to these registers and prevent race
conditions.

Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
[den: update dw_edma.lock comment]
Link: https://lore.kernel.org/dmaengine/20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com/
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.h    | 2 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 902574b1ba86..6474cacf7195 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -109,7 +109,7 @@ struct dw_edma {
 
 	struct dw_edma_chan		*chan;
 
-	raw_spinlock_t			lock;		/* Only for legacy */
+	raw_spinlock_t			lock;		/* Protect v0 shared registers */
 
 	struct dw_edma_chip             *chip;
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 69e8279adec8..cfdd6463252e 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -364,6 +364,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
+	unsigned long flags;
 	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
@@ -408,6 +409,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			}
 		}
 		/* Interrupt unmask - done, abort */
+		raw_spin_lock_irqsave(&dw->lock, flags);
+
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
 		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
 		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
@@ -416,6 +419,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
 		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
 		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
+
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
-- 
2.51.0


