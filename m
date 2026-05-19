Return-Path: <dmaengine+bounces-10523-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPVYLkYJDGo5UQUAu9opvQ
	(envelope-from <dmaengine+bounces-10523-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 08:55:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D164578706
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 08:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A82B43004C44
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 06:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5839DBF8;
	Tue, 19 May 2026 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="jeQv0Olq"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEB739D6C9;
	Tue, 19 May 2026 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173365; cv=fail; b=gLzt7QWgs/Qihm3rkLHmAAtJSMzU73NDebRiGpQEj0VwLHw5BgiHQ4xy4/j6MO9ZokANhF1fAEi1AuYJoiLhCmc1VfN8DDVwDyMtgKdVFx2+fVJcrtabrIyfaUyMyyj3Krm9vU6o1WRKiifUH7TK8roEqsvveiwIJr3cULsdH0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173365; c=relaxed/simple;
	bh=9H7a1uvvTIsj+fqSs+fdMoCTpulgCzjb0dafsidd57U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K4lw07dXcj9Bo2NbiKl38W16fvJkJcBKHAqUenhiOpRggOirOU2sYEjk8+PueevwNFBQTfuxTOT7CCbytVOimVX7yLkEy2MRdHToCsxpNOGTFCWQEAcy/EKt0vRCRirbbncjImeUrd5IMMT49a4OVzsOuZcL46BpjiOUg0n9U3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=jeQv0Olq; arc=fail smtp.client-ip=40.93.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtO3Kg0ELC4LjBpWvorl13Nxv6DldXRyaULxw56a/EbI5Emqr6S+l5+45B9X7wtPdHTJwSy0Mn8k9ibEbZkF1CUgqorszMtt8i5UVLqThI3FvPkzJTx+1YoVX7RXQ9U2RYpV7Q/YV49FOK1tPCQtagz2AOl0A2OMXl7U5ezhavR8SCnsyWI2G4jMCH5VNz+cplScBMpfAeQp9Y6FH4FdhIWB7a99SQDnPmNUMmRTqD49TreJE9+d8fmBgN8wDrvpaDfdhyRUe5c8eZKI0iQyCIqrtOjGz9uslm5wY3BBtWpKQClNCciybsz+DfbZDfdqyuq6FHE1Xc1QULNsmsYYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzMViZDQHBbvndZb9SHszpRQ6Iht3PMCzt/zibk/Qmw=;
 b=dz5YrcZdgpYORqi2XM9/FdeKggyxxxm9Lr5QVGMKKIYdUklsgWyp0N1+mpmETylX4ig5YxdRY2CTGQVuKnf56OzT7ife0tXNylD/XVOHzel9n6Bsg5DIf0nqJedPP8d16lAxfkL43Cnhdga2VhDOK907GYSlI7RKUoMnJ1+yLGniutIb7Ji9GiwQQ+q/2X2f3aPDoQyGsP1fEHWJKeepDaeRF6Ggoso+dthNLOav9mybtezZdxtwj3i2oACpyAb9Kd1aBM5BMrXKP0ZktcspyU4PETq5VaMXCYhf62RuZ+Ly4KKntVePeoT4T86pRN93KdQ0nzz0GHlWjf5FtdnBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzMViZDQHBbvndZb9SHszpRQ6Iht3PMCzt/zibk/Qmw=;
 b=jeQv0OlqWRmgmGGvw7PqPo++fHBDMB69JUPSkb/kv0nhsv1j4PpdCGuqUoTVc/898LFx/Y/oRvOBOg/YoskWmijLjJyO3x5do7jorOFGqw5Qc3udnAZVQcQX9ouURtKuNIa0vvzJOyIVQ8bEgvxgHRncLYAIpYc/8HZpB6zQDI9HYPS/drBUs0+O4IQRC0BYmu1ssz2mRE5P8FGrIW99llmjAy9uftOrIJcGFnSXC+Ily4m1aQhwfnuDifhhY50ZRwd1Y9z+mRq3J/mUSIvjIHIQSRU+VQEoqn7cmQ3Z8eNiW5jJrWOqSNavC5N47+EH8b4VHwkIQDW7XJbpcmuRbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ0PR03MB5678.namprd03.prod.outlook.com (2603:10b6:a03:2d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 06:49:22 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:49:22 +0000
From: tze.yee.ng@altera.com
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tze Yee Ng <tze.yee.ng@altera.com>,
	Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH] dmaengine: dw-axi-dmac: drop redundant DMAC enable in block start
Date: Mon, 18 May 2026 23:49:20 -0700
Message-ID: <060733464e19298f670cd269d4849f2092644923.1779172907.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::24) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ0PR03MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: e28d2acb-3301-4c8a-ad3e-08deb572c208
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	+tbVWMBpWqNJYCf1AWN6X97mSQB/nMpDD2nd0OyN4jexAlZJtXlRoeQJrk6B19bqvlcQJzzCHIMEDd43yXTUHNKOsvLw1Ein7TPWEVJZIYDbRIVAWE+VTBgDKIhUYXnW5nVTOxEPn8RcMEX2VhljzHzIl/Rlp+75wslhornNjAKv7HprPa7+/By+wujb7b7l/hvgG0wSt8pnbVPvHKXEF5QygoJncUuHp6CcEuCNwDzOLpDA6QI8zlkXfNSnCz16RsRfqjz1kd9YL4A5LUx5SbU+2z1eSQR2OT+WArZjFuMsSZnJCqLnhWCUXRdKqdKvMmfsLvb4mtQbxAl6XYjoGv8NXd7NKCG/RWIPQLqWkEN4TvuRo3HQXwN3ssG83MYRQgvjeCWHxs5XbO32AN+jU4ENnaA0nsiXO19OyboPsguMZgEW8tNjtBPduJHVlhJBpfeBF7NeRFvp7HacWBf52hNSSFGRM5bkWXlE/kYbpIwzbHyo55xYXI76oM0va/bq0ato7qv3G0FTeKA23jVRHDw/avgjne0z+ECX29Pa2cAU1VJFdBE6aFgh+RsbTY6uV1TRZq6NYJR/4iI3FSu/uGa0iZ9EZ2e5YWQUh9dm8KmXC992vYdrDQ7ysZEBu/FKbU3k/9pmIgo/7PPRs4lkXarvfDvsTkUopcP7UE5HuJcAn8qvL4IrcXUY1oMBDe3H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fwhVM6rCWjmRsFd3AiwEuyhnf3gVMc8EJ841ACQSqlQw492dGQxNMJdR+3Nw?=
 =?us-ascii?Q?lTcqPuLYjfMyG7luVbPiSxFU6AUkd9hFfKN6OeqWTXuBoM+v6PFMvI5aJE+5?=
 =?us-ascii?Q?sGp4FUjIxX9dcjaFRCeZM80WNxhrBIDixsvAuU/9O0D9qlFoJMZUq1Bl7DJi?=
 =?us-ascii?Q?mjKCd0Yqz08EQTLft4pLArMk4LmVpniHsZ/rVj/XZ/qsCiySi1S1NG5DbQgY?=
 =?us-ascii?Q?mSqHPmSeWY8vnDcTzjuy+u1TmErBJG92sj9Qsu5JOpfoOTZ5aliyPVkN5GIW?=
 =?us-ascii?Q?uFirpIAwVLxXwy74e+UKJRdSpQosrjzerCfPcHvzUqBrdZ78c09XWyIDTHIe?=
 =?us-ascii?Q?MYzM08pLvgbWgBpl1U8FGC7qP2P7WITjL2NCd2bRThm1K/d9LKL+COHK/ihW?=
 =?us-ascii?Q?yoaG3TTgIdrISjkZtOQrPnEXBx1k+rXuYXHq3+GXpCAruFtkjpL1zdOLPIfu?=
 =?us-ascii?Q?zWnUN9h9Zayz0T9EevLT42j5UoELXHE62+FDKjB8vGGi1DJLE19WUW6VLVXT?=
 =?us-ascii?Q?U+H9pV7Te1BGpOcRYQP9+Bz1F0HT0S7Zbq1mx6+mkUfTIh4VsCUFo3dFsa2+?=
 =?us-ascii?Q?adXVhDwBfelEH3tYNsSCY8wlolKXQzKnvPhWURuLC1sqCCuLt9rEt2AVig7d?=
 =?us-ascii?Q?/ZUUK3x9M1Zv2e/cmWcKiZEObExJluT7EkrRQ/33OPYFfARioZ/Z9CvUmEt7?=
 =?us-ascii?Q?TrVydPxH1KINIGKZsBTlTP6KGhkhBhweJj8viXFOEMAlqICOoL4fv/PaprDV?=
 =?us-ascii?Q?sFvzbjVXvabfYeAw1e/qX5h+wdelDqXPn3Ugo81u8fU+54o1bE3jFb2i3dQA?=
 =?us-ascii?Q?rCgUl11bSxYVZVaDYdbxyBO/HlghUokBPPER5DjdtLJ0pk5W7wIzslTVWUGC?=
 =?us-ascii?Q?teN1ap9eySHm9IhnUnbhojZPRYc94l2SHBKz2LC9rPzh3rNhilTloX7H99s+?=
 =?us-ascii?Q?OZyOTNb9gWUjB8k/9E5y7ij07bbI9IaWmU8PhLaOkWf0MX3yTQ+IsUFnG/yb?=
 =?us-ascii?Q?mJaMDZTdKgpG3iS/j07zAkgkGVil5KcdKtP9PSSAJKIcXbST7onQ5zyg6ULn?=
 =?us-ascii?Q?ygukwNYx6E+hwu1Yxz1J7yKIT/S7lokumYLWsl2JKFuIsHFdPbfvFf/PYW45?=
 =?us-ascii?Q?QnChldDvSRTgQXpORC6tdVFaCCdIo0wElomHnW5iknn+HQCqPdNU45lpd/ui?=
 =?us-ascii?Q?Oul9omo/tYE4k5TOhP4YaTlr1LzYdKiutJVLGN5Jywh68N+xbPgpnR7ljzHd?=
 =?us-ascii?Q?6Uzl8KJ80050S9Rfms85xP/ffDxR3KdWHjkJq/Xm7vSnIgXGe/Acm5hgnVjA?=
 =?us-ascii?Q?jmT/YHytnx0YttzgQ8+DS+neeEbOSr3ywCw0FJ02dZZE3351GqkQ7R+z0MJw?=
 =?us-ascii?Q?i5ESiOlICrs/vZUIv48zNM3FuTCKkfUlUcdBNg18aCOaY0Fzz8J6yna8AyEF?=
 =?us-ascii?Q?88h9Dp5wBzq638+i+4KMAxZsA0b+P75MOqqBt93ol8wV9c+6pxtsu1rD2hFw?=
 =?us-ascii?Q?KXSJzUs+hqTWsn8ytTrzPe+8vlZSF9i0fx+N1s+wiX+A7bC4pxMHssS6wd42?=
 =?us-ascii?Q?RDI0Pzs5h1COOW7CkmKjq/c0veFjS0Tu2+PcLAfRTJXT45u4pszpwPECf94Y?=
 =?us-ascii?Q?ou6m+gJ+ypptJs0666jo7agoootlsteJFqiHFQOQuECiR57TNZ03QvpRil4u?=
 =?us-ascii?Q?dhXXgZ0T4xwPTlO35SZUBFLg4NSebd+Z4UvvnPnkLHW77ABtJWiLduX4ly3W?=
 =?us-ascii?Q?UgZ82jsulw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28d2acb-3301-4c8a-ad3e-08deb572c208
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:49:22.0794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LZQbOS4hy5hZTPxq1jzpro15OaPFeYhMGDlpGgKaVXZR4+dqtTO75zJAKscDbnWEWAHKKCPB3x8k7mZ2aLglQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5678
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10523-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tze.yee.ng@altera.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,altera.com:email,altera.com:mid,altera.com:dkim]
X-Rspamd-Queue-Id: 3D164578706
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

axi_chan_block_xfer_start() runs after the controller is already enabled,
so calling axi_dma_enable() again is unnecessary. Remove the redundant
enable call to keep the transfer start path clean and avoid repeated no-op
programming.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 4d53f077e9d2..f7a50f470461 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -437,8 +437,6 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 		return;
 	}
 
-	axi_dma_enable(chan->chip);
-
 	config.dst_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
 	config.src_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
 	config.tt_fc = DWAXIDMAC_TT_FC_MEM_TO_MEM_DMAC;
-- 
2.43.7


