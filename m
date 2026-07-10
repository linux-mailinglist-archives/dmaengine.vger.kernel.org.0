Return-Path: <dmaengine+bounces-12270-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wNDrKUiqUGpc3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12270-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1277E738557
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=k66zdhoE;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12270-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12270-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22FF9305EA52
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73F23E0255;
	Fri, 10 Jul 2026 08:09:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020099.outbound.protection.outlook.com [52.101.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB873E2AD7;
	Fri, 10 Jul 2026 08:09:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670960; cv=fail; b=f3XCrjmmRxMF6Jh3OaEA7JgIcf5U/1l4xrCUTHdywXDJjCjzNBMg7OZDvwDrdaDBuKIE5PYCe1/thMe3kxpi3B3aid9MS29qYzf+jY1FM9W7yj0icGTPS7gFP6CHXfMijI9+D/l1BM24aQl+z5ZyEqoaXQNdAwb2H7TltwRthr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670960; c=relaxed/simple;
	bh=Zl5EJ+6od1lom5OI4o3WpwlyoB5LqoufO12Tytrs0Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hGpVNkwM2GgJFQ07JwdOWNIC2WWwfD6UkQ1/3UUkM5iUeh/3eGFXbIUcl8qHCPCHarPxyafTchBUS2vb+jhqLG/MQXvP5U8UftjXYrQ3E1izRzs/8mGjpQhikx9BdFK45P9vpaNfDIZ4QLhUfmKiOn+bYZCzDpIDYr6wLyafcCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=k66zdhoE; arc=fail smtp.client-ip=52.101.228.99
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGAAXKWIlwf9FLi89zqDmC3YmJQaSZJ1Whc5FP6HHyJugHLKKzxegkEHyl//0Vu6RkzKdrRmHqA/zSfvmR35QglS328F4OhXVmr6l20z5KTRnmWZmk7pRVBqmw6L3js5UvQWQtY0SMWnjUJ1VHT+KAfBVcm+b167119D0A3j9vjmly/byh3WJzRs65ydoBQg1Fq/oIe+DtvgpGZripUq+h8oRbMo+QeEivymL/b4PJbO+MB00bwO9VVFB87RkJp0Hpw/Un42GTRON2OnzdRTXJfGR3eMJ2xXOo8MsMr2SSg/lWBEx7c78UsXKjsUF4ETXNBY3UMlKLEC3nY9KakqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCfcREcRESYitW2g4iibxkniDIgNYXPZLFZPwZaPh9s=;
 b=fHsFEmNrZoI/jdWzihM1AmHLIwb4EnLVgHv3tDbH+/yfOlVfmq2+P6nr+m+UH9Cp9ZuQRRTay6rXuY4kRcwvYKyFsYXljHG8eSnR/bxdlS02F065oJhxOhYzTiQUedfz5H/MfrnPlFtqexOfb/Li4n2ZUth2o2sD7Xh+mAqFX0zPE1FGoRNxCzzrXu9eFQH1YZHY8nTwwmBU5jrsJdMZlQjQTJJZyot7N9+W5Gwngq0pvd3rQAMVsDalb6e5CFlu4jqs4bBw5HT5Ka6gCrzDd594tcQ09KXVIMRaNMcu0Zu6EuNNmfLngFrdO/ZXiqfmN55uNhwUx1QM0i+qiq1g0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCfcREcRESYitW2g4iibxkniDIgNYXPZLFZPwZaPh9s=;
 b=k66zdhoEV296aIccwgJmYBij9wJTInrpP7xDQ58bxe9qnALIDK+2g1w58xl9tVPOecbjdZvpZSIahrVb9H7ZDMA930ihrZjK1smG4zRP+Sy6DFF4OkgEtbTsYsS03DND5TZB2ZjW8Rd4RnA4/cWSSNHzziGb1DgIqArx4AbrzBU=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6374.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:09:10 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:09:10 +0000
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
Subject: [PATCH 1/7] dmaengine: dw-edma: Fix HDMA channel status register access
Date: Fri, 10 Jul 2026 17:08:57 +0900
Message-ID: <20260710080903.2392888-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710080903.2392888-1-den@valinux.co.jp>
References: <20260710080903.2392888-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 82317157-799f-4a4e-71a4-08dede5a85ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OinTEYRc9QXSugTsP6LlcRT572QkHSykQPDZl/6wt3+1izvQPuas87NNN8VGWvW5Pu1nDdLu1T7Sc1oyfxzU506rxhd/PCw/4i646TqN4qqTuEC8eurr8h08gKOfPWLogzmuxBx7z/NjWWzRWAWdLnCjQfN8qE9RnjNzHuEb7ujJpTl8glUWOMICC7hEq2qJKRYyeVZjxcz8q6B9MMr1dWZ3cv/q52FZkB6a/t1LHW2OGCJc9fqvaDvrzz4l72lRClDFJGSvSTHhsjahbBkEOl7tNOgJETClv98OE1rDXnQbqq1+0mEGAqzhFN0ixj0zzKIup/PGJ8CuAyxdLBWXzdKxVVJTh6i8HEznS9WeUoqVoLpkemAchJHVzoll+WPxULRYrirZa3MH9LV0ou03XYmXPI/JoSbfrdra9rjj8Jp98MiS83HxchGb9wQyG2GuCfnIf40+FkJ862HIc4JTiIYpMqt28u6G8mi5WHWo88oYHylKQ+5fRRZiV5deZzvkSQEWADR9SMpqQ/f4x+tzAaJuD6uzdra8GlMrdyLKT3LxlSG+lmXm23mFu6ICZ0sB7YNNflR2hjbj7K4H3odDJFUw4McVxrR9GRNAKe3toAduv4eaXI3Q2vtDLNqmrGFAJgU1xtbhwL+xiMLTGYfPKn50+SxRF2BX/nJPRvjCQiI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x/Oa3BoNpucfCQYGwiFjvi/SWcrJ3u7rSCP0q+N143alL+/P1onpvoD9OVLr?=
 =?us-ascii?Q?sxmiWmowb/sxoC8zBEhZx4iarhVXFiU74/codDzD7lwpNVTyCRIy0gYihb5c?=
 =?us-ascii?Q?W4UNtz5NXOaiXoJfznBV6gZ5TLTTTnvbNfLj4L0Y6IGKsAc7XnayX1I2Yyox?=
 =?us-ascii?Q?kACoL4pghTcJVhg0NUP6BLmnEclnEtXqcPMunVgc9x3wtFPaJ76Vx4Rz8mEx?=
 =?us-ascii?Q?H3Sy8vzYmaBmQ9FDYz0eMyCHahl1LZspeKgeet849AJ/TWKBZg6YCoi+iKxK?=
 =?us-ascii?Q?WTYp9sWUgxA3ivSfSaoM1fvmCR8+5OGnrGIQnnGF789NHxo5QV3Fb2KfE8BL?=
 =?us-ascii?Q?oC87GToVbEuLp/JQsZUzRyss7m5fqp95U7tIRXLO+DSTTU2WcgDVPUMUfKsr?=
 =?us-ascii?Q?1VgDMX5pF6EBgvZ9XlkxXVv9sMPjnPcHgkzFM5KsW8vo1ozwWzCE2uf9sGfa?=
 =?us-ascii?Q?AhZ5uv1j9QpZdn6Yn2UylvEdKH3w9k1/uxDkQedihcYzQYMGdnNdNrFZfP0J?=
 =?us-ascii?Q?szo4RhB/1SymEGgpGu1JYHHIDBMGIFdk5Oy/Z/yuYjr05xFTWZi8tysYVv3S?=
 =?us-ascii?Q?ZHlwgi3yVMK8WtBoqHImZEIetc/asLBjgc4eTRJiGQIgsZAWhFVASU2JKmQG?=
 =?us-ascii?Q?78psgEyVvzIhumCWN6BNFaVUNEZcXAB9gc7XN636Jlt5WguVIZdepnkEYk5a?=
 =?us-ascii?Q?cNis4ZKkw9QOOtjzMrQ0lRS2AHO3OIkqbVK85MHdUcppcykR1lyL8ffXsQlR?=
 =?us-ascii?Q?gp6LDyIsD4utljCwHwpllSqGsRbuK74uxSE4/WUBs3inB5rt/HGLO03jzCp1?=
 =?us-ascii?Q?kzJh2vLqw+oNNOvxqFlg+j/x4R3lmFz7GIZP/sAzAbQM4+Dukg/u0cIvqo6V?=
 =?us-ascii?Q?eQjX3i/twiwk7AeKV4SfQgs/FuW8ToWfN6Y4v7cH+bNg5lSNwa0pyRNL46JP?=
 =?us-ascii?Q?XBR5kTfl0r0BD8UeuG6T6C1VHzO8NAjHaPPH99j6Fun5c3o+EGfE5DbUpI0o?=
 =?us-ascii?Q?6DxzZiVDOukyNKfXexWktGyHSRZ47Udsq5IutLWT6s+IOuKtxjYsJM5/wEJo?=
 =?us-ascii?Q?N0b7uBqTZlMvMoZrvWmVujT9wS/0zFPAOSnkIS4DqVLQz+Am/NaVqkDsvtnB?=
 =?us-ascii?Q?ca3h5GRXq4MF4D+/kwPF1QPphbCUhvtV419gx3drFaYDdkR43zw19BKgS4N/?=
 =?us-ascii?Q?NB7yXoAN1K6rtyr3s8rErkxsMEiIjJN0HM9+G+iu/ZwB2WN5w+XcUQIg/8GH?=
 =?us-ascii?Q?INsdqdLKu6bBwg74Wz6Ji/0IDeu8rFe0AdAEBx2SnK1OeUZDryaXOxcKqrAs?=
 =?us-ascii?Q?ACEbgBMj621tGWAxn7WrHiMwfjIR6JWfj+TkchHzd0zHeR2cwDBVA3+sOb8e?=
 =?us-ascii?Q?CEQYACADf7KRayXmPX/iaPwfBoW+GEDQ6DcaUnOtOJLAML4PO6VHAklCnrdK?=
 =?us-ascii?Q?KWhNihoET89IHinPIA45moJPOZG6SE7XsVBd75BHVWpqJRk+/RHBgyNmZjKW?=
 =?us-ascii?Q?xyVAMCj9R0w3Wv7f6DQNaDxjmXLrpfZQuswY7wsBFtg+7+Lb2T4NW1rDWJR/?=
 =?us-ascii?Q?zPFFfl+UxcKzHac2+fTBW9AuzrbEflWL7VXL/KVsS+zMXaTLzekKsyhTfgTe?=
 =?us-ascii?Q?RJYx80F7hd1FUS6pa30B9rlRjNNIMqKpmBQUayjaC5zD1Olq7L+cBSes2jWQ?=
 =?us-ascii?Q?UeyB41e7KFes62OoK85+3WxGI0M5ql8nBCeX7KuiG8QDrhhLnfy/+CwDjOEj?=
 =?us-ascii?Q?r17zsp0PDDrZP01FQv4JPt05qk1d8yJYYv77R4iWsK80Z+hFd1dq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 82317157-799f-4a4e-71a4-08dede5a85ab
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:09:10.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3Y0+ToNiEONt7HFQgd9aMssu/plnD/lAVTizmVCcB0B0UN8ABJ6mXzbvHCpJOwAq8e7O8GnVehQkUUkBbQAVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6374
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linux.dev,gmail.com,synopsys.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12270-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1277E738557

GET_CH_32() takes the direction before the channel ID, but
dw_hdma_v0_core_ch_status() passed them in the opposite order. This can
make the status callback read another HDMA channel status register.

Use the same argument order as the other HDMA register accesses.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Split out into this preparation series (was patch 02/17 of the
    dynamic LL appends v1); no changes to the patch itself.
  - Collect Frank's Reviewed-by.

 drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 632abb8b481c..2beec876b184 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -79,7 +79,7 @@ static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
 	u32 tmp;
 
 	tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
-			GET_CH_32(dw, chan->id, chan->dir, ch_stat));
+			GET_CH_32(dw, chan->dir, chan->id, ch_stat));
 
 	if (tmp == 1)
 		return DMA_IN_PROGRESS;
-- 
2.51.0


