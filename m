Return-Path: <dmaengine+bounces-11653-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q/VFItzHNmorEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11653-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:03:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D52D6A9494
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:03:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=eF07y6o3;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11653-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11653-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ABEF3019F23
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE9268690;
	Sat, 20 Jun 2026 17:01:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E497E25B08D;
	Sat, 20 Jun 2026 17:01:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974867; cv=fail; b=uZLlF2qXld3RWG0JjU/UULqRiu6hHnZdwE/viFWY4EWkuBfPeaT2CtRcKZRfMffad85K+ewBWnpfWmgE0s5aVJDI6tOWsVa84dR7vHgLxZOZzMFjKHfqV0YU5XM7MIHwZZgB6FseI7UCdzaj9gKFOMiKta4EFeRdjO9pOubOG70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974867; c=relaxed/simple;
	bh=ucDretM/PaLvOXeC3CPY3Sa+CJC2W3DgIezUIzf/Z1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ItKeUzaIh9F/QmFQu9t1A4h8cHXoyYcAVrDCDMYv7Zk+v74DR95mlseXbmfMlr4oQi+tBBlT/LVEeuoysW783vkG8uZYzQvNmG95lGppyRRWA1kWhkaspA82U0xmfzB3TiN6BwHHOagP5dbNYvRYxAfiJQx3lYTIg1AgNed66TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=eF07y6o3; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7TtDl3hSO++IWP7g/FFXr4v7F9Lp5qiiMioZc3ePodAU6En+9z4kBRUEXUQ1s/mkD93CUXeVty9K91HcA6+SmtPHvzgfeRWPC9fALXdbUsDH0kwNxtvipP1pD+n3Uav0A7Lat1G/BhPEBIOzHq4tS+UGBrNqzMJ++WkkEPJZo3y1lFtlkLQZ/c4TCBOHMKMOoE2KrQcLibgndCqxfFS460Ml3BRzA/YM+0Wo7zFGSihFEWDj90EhXYE0Zu2RO00lp0dZ80PYohQdNaUoBiZr2R2QrQz0bexzPv3JFqkg36uWEj7e4EhcQb1LKiENOMjCUGdjRgutT6uDZmB1uTqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkdWY3792r+cMyrZks/k551OioQtqn2gE7Yl/Y+68H4=;
 b=Yr5ys9n/jm2iiLwvjKf7WCgrmKVCyJaCaMwrvlpm8YURMzXzsOR9RuldOHa7g0U8nxwfHQzvufCv91tbLDJbZuF4hctS6Ex43fbHnuOM8dS0xpep9zNJnQL8N1R+SXyQh8G4a3G3BWAuwR+g6R6UHUe5iSz7SugXZPh5aW0Ob9WMweHI/wA91uXb9OVxsXOsVQLS994MIy7fzWGcsXN1sTMlvKwzPr7EYCU3S6I0L2z7755lK+FRn+aTzFLrEVruIMzm68cDvrzoaa0T0S7Q/+2RVW5jN9LjOQZpJlvnfPUpvKdaXWfkhY/JJ83VnDdzHJAbg5VwFiufVJxQjnRsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkdWY3792r+cMyrZks/k551OioQtqn2gE7Yl/Y+68H4=;
 b=eF07y6o38OmUMFOy/olNZMq3ZhhhpjyilDvc8tzITU6XUEXCZ2rkrUzrm17NT0X9Mf+kGI6fvdsUesTSkeLOhNF/kwGPGoZLySmhqADfsFF4aQ0aGWRXU/Qc3iURkGH/z9GqEe6PxgsgqunCPVU1903ydFrPLr0EE0nRgcKTH/g=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:00:57 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:00:57 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/13] dmaengine: dw-edma: Add partial channel ownership mode
Date: Sun, 21 Jun 2026 02:00:32 +0900
Message-ID: <20260620170040.3756043-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170040.3756043-1-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5455cc-be21-429e-65db-08deceed7f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10070799003|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SetREhk4rrq0gj1o70DjiRCPO4qnwTm4mdXDrNTheiVKzDpRtlY8Mb+u+rD01W3OkAWOstIcKt0jRcQsBVarL4s1857CXN8uTlWXrJsjfqOMONdJl2CBTaz2iez8yesj8angS6JilOKTHs6iDFZTJ2tg69kLqcI0twGFf5OWJAg6zgZqU/W/wF1oDAZP7vNkvi/lQWQmJKgD9RcHnm9i/vTejUP5jdi2zmvnzgoHG3zuDZq2JwTL5NOejJ1DWP6ByqfMm2LYT4x60++D5EfW9xCkr6goOuH/YshR8/LPJub9p/jcZktBRpKsxqUNe7NHyl4C/+Fh9q+ZdKCXGe3LP3E82Bh5CDcZUHUVzqlaILrUspa0SuDgAUWzGZWao1qOQyagvw6JjOGvTo652tND/PE6KEbQwNDurjTvj3sDHtf++4t1+dbuOAtx7cjJsXdzFcyk60LcPlTJbjxe9FD4LzcMmCTVmKdaoYGa75gR0TH3k5HtaanWVtNlW7UH77H2JWWeVRnqfx7P4o3VKPmDWtbDamrdCxIvTBZeXaQs0j4OUmUsZ1d7DJKKaKiX+X6U33uzNSZWIj5mVcNigV4NUf0+nJHwVdsyRErgkyLUbBOoEEz9TIdipR8YUiWSq6VIJ8WFO29DAbvILHqOz6Hyo8eppnEqhk9+ZWdW1w2YTOI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X2ryzNsZMEO8GOIwwTmK7EyMyHADN8/Iu2NPQ++YcbxybQtOqgz254qTx86p?=
 =?us-ascii?Q?jzNGxi4rsh9G5rYIf19rIHCCMhsRkGwvqRwBVhx8X4GjHf352uVxX1h/M5uF?=
 =?us-ascii?Q?UfirfsqEe4IPbwjHuFvDq62uBqqgcY6lVBTDrtty6TC4qht7KFuMstX3ZQ6g?=
 =?us-ascii?Q?ThouHWLM4UlINW55wPvUXGskwDA5Thm0sADB5G+66UZSjabEdzjE6YwYRv2r?=
 =?us-ascii?Q?C4nqrUptuee1mrTXA5yd5FXHsxB2gz0ToGY+x3gZOTzDh4uI1nYD+Hf1f9XL?=
 =?us-ascii?Q?7sdL/WxSHX034U9S6PILEbdewv4WDZD/iRtTx/F5SxIYfNnnbPUSXHaN6sXC?=
 =?us-ascii?Q?ddt8TnQf63Fldh7bnq6HGutJqb9UnLRkMC37yluJ0BRjE4dfIgA+vSvvTnq8?=
 =?us-ascii?Q?BMmEXdeLvm9/YTARItR1R4Tpw74Dk2aFQPhLR6c+WjBw+finuAHJ+MmundOs?=
 =?us-ascii?Q?dDkaNm4yxRFHo66NAre3CRl56VmoGrinukk0WYGrAQXdMh1Be1FOqGXZR5DO?=
 =?us-ascii?Q?tbbS4munA6xUmOTVNEv0m6k2w0XOe/9yGccAjEHIa4Xsha5W84dTBxX5tXDA?=
 =?us-ascii?Q?h35Z8q+N0k+AZsG0FIi2UJfnbvRu/bushinb213wkZ5H6w3WTQr7ptMX1BcQ?=
 =?us-ascii?Q?WMhHWP4NR/oK+2//6/8Fr1cd74uNJxHoGEQFJ5ECoB9n+gSpSnquTBz922sl?=
 =?us-ascii?Q?f0caKNswNc7d0hu5lBAxOm1BJPws2ooYy9SdwPybEiWyEaFoXiFyqtTgWVtW?=
 =?us-ascii?Q?XwzXsrBcjRtkhBdVuyO/qjtkZMWNpEmbLu5RFVpBRMjKFZn9f5hsafxfJ6m3?=
 =?us-ascii?Q?7v18Vwvu9NFlQiFgiyZZXbKvGVJBrDrcdWm2gL7X+nQyBGIZOJpgs1cvAZ7R?=
 =?us-ascii?Q?/2llRm+xCfuWF8c9h6oA4S/a7C3HxEtFN6K3WMXvg1TijEsPUVDr5CcMLLjE?=
 =?us-ascii?Q?x/O0gWGagVMeJPxFKULTbxOR84pNEo1jR3EBB7wpssUZqRPRMLXUYKWpkBZ1?=
 =?us-ascii?Q?Q1nzhwa90azg1SQxD3x/iB1dDi5Y07IiBeGwpUfNjULxzxYI3fzsW8rQDF7X?=
 =?us-ascii?Q?V4tdpvMbhs2Q5oNy6Tbgq0n2IXZgtdJ3PgN1xSlShsnKMNAgS36RbwAWghsA?=
 =?us-ascii?Q?Lw8XdESAO+vioLRF86WSYiPWln6Z+c3jvQKDZrBMreYPMfpCRUVPiohnWaNy?=
 =?us-ascii?Q?cLowtIASmh6qfaSqEDPNbkp9ubidNU2D3zDGKAfx429opdX2My4y5oAbQhrH?=
 =?us-ascii?Q?1NmeLMfersKyBUOZt21bWcexGPdFe8K9beEiVhzHCFPDqHFw6Cu8AL0OhYno?=
 =?us-ascii?Q?vw8YDpedFmYWCZ3lfwKUHdjsRvguZs9Z73jvHT2n+MMij8pQLWPfwTqmp/8k?=
 =?us-ascii?Q?tWkCZjiyfVPS7Di9fVT4cCVIkvHNeeVj1MYGvmIN+9YlFWMO0SS03T3Oe33+?=
 =?us-ascii?Q?9IqHUDgYIzaAob1iHv7k2fuAvzMJe6aharovQUjABzj+mwlnVoItirO6uQxW?=
 =?us-ascii?Q?w99CFwPT27I9Lvns2LiIVMLC+8p7Z+oX39zCQbB4gr0ORV87dTNeZQGcC5BR?=
 =?us-ascii?Q?iXg5qHt5SQ/aBL5wXzMWA6r9rsqE/wABTCiwOWKVo7k+0aZtKyjMq5ErnymW?=
 =?us-ascii?Q?DZXhTICYkHpK9fB0OI0T7jheQwXyDpxTWi0zEyk9nHYFqmaY0fuaYzv9mm89?=
 =?us-ascii?Q?OPcURBRiPx1pKBs/aEYLVh1Q54QtsgvPXjXW0lBS1iZE0fX6S5BeItmE3mmc?=
 =?us-ascii?Q?KUf6QjjGaTp8IjFaomPLiaD/1PjQfZBrXI0TNYp5VvS1O9zWnMXz?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5455cc-be21-429e-65db-08deceed7f7e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:00:57.5167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MJgiQEh/UICc6fwX0H5cqNmWQvPF1H3UWmBOvzoDDJ9lA5ozQZty4+j0vSNCUG/CJ7UQjcTlUfS1b+P2bXL9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11653-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D52D6A9494

A DesignWare eDMA instance may represent only a subset of a controller
that is also initialized by another OS instance, such as an
endpoint-side OS. Add a partial ownership flag for instances that must
preserve controller-wide state owned by that peer.

In partial ownership mode, dw-edma skips the initial core reset in
probe() and uses the limited quiesce path in remove() instead of the
full core-off path. The flag also makes the driver validate the
ownership granularity required by each register layout before
registering channels.

For EDMA_MF_EDMA_UNROLL and EDMA_MF_HDMA_COMPAT, the driver programs
per-direction registers, such as DMA_{WRITE,READ}_INT_MASK_OFF and
DMA_{WRITE,READ}_INT_CLEAR_OFF. These register layouts have at most
EDMA_MAX_{WR,RD}_CH channels per direction, so the capped hardware
channel count still represents the whole direction. A partial instance
can therefore expose write or read channels only if it owns every
channel in that direction; otherwise two OS instances could update the
same direction-wide registers without a shared locking protocol.

In contrast, HDMA native uses per-channel registers, so it can be shared
at channel granularity.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Allow partial ownership for HDMA native, which has per-channel
    registers.
  - Quiesce represented resources on remove; v2 only skipped core_off(),
    which could leave those channels or directions running.
  - Revise the commit message.

 drivers/dma/dw-edma/dw-edma-core.c | 52 ++++++++++++++++++++++++------
 include/linux/dma/edma.h           |  7 ++++
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c782eaa12021..d87791205837 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -750,6 +750,9 @@ static int dw_edma_emul_irq_alloc(struct dw_edma *dw)
 	chip->db_irq = 0;
 	chip->db_offset = ~0;
 
+	if (chip->flags & DW_EDMA_CHIP_PARTIAL)
+		return 0;
+
 	/*
 	 * Only meaningful when the core provides the deassert sequence
 	 * for interrupt emulation.
@@ -1081,6 +1084,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 {
 	struct device *dev;
 	struct dw_edma *dw;
+	u16 hw_wr_ch_cnt;
+	u16 hw_rd_ch_cnt;
 	u32 wr_alloc = 0;
 	u32 rd_alloc = 0;
 	int i, err;
@@ -1092,6 +1097,17 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	if (!dev || !chip->ops)
 		return -EINVAL;
 
+	if (chip->flags & DW_EDMA_CHIP_PARTIAL) {
+		switch (chip->mf) {
+		case EDMA_MF_EDMA_UNROLL:
+		case EDMA_MF_HDMA_COMPAT:
+		case EDMA_MF_HDMA_NATIVE:
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
 	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
 	if (!dw)
 		return -ENOMEM;
@@ -1105,13 +1121,25 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 
 	raw_spin_lock_init(&dw->lock);
 
-	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
-			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
-	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
+	hw_wr_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_WRITE),
+			     EDMA_MAX_WR_CH);
+	hw_rd_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_READ),
+			     EDMA_MAX_RD_CH);
 
-	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
-			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
-	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
+	if ((chip->flags & DW_EDMA_CHIP_PARTIAL) &&
+	    (chip->mf == EDMA_MF_EDMA_UNROLL ||
+	     chip->mf == EDMA_MF_HDMA_COMPAT)) {
+		/*
+		 * Direction-wide registers are shared by all channels in that
+		 * direction, so a direction must have a single owner.
+		 */
+		if ((chip->ll_wr_cnt && chip->ll_wr_cnt != hw_wr_ch_cnt) ||
+		    (chip->ll_rd_cnt && chip->ll_rd_cnt != hw_rd_ch_cnt))
+			return -EOPNOTSUPP;
+	}
+
+	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt, hw_wr_ch_cnt);
+	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt, hw_rd_ch_cnt);
 
 	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
 		return -EINVAL;
@@ -1128,8 +1156,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
 		 dev_name(chip->dev));
 
-	/* Disable eDMA, only to establish the ideal initial conditions */
-	dw_edma_core_off(dw);
+	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL)) {
+		/* Disable eDMA only when this instance owns the controller. */
+		dw_edma_core_off(dw);
+	}
 
 	/* Request IRQs */
 	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
@@ -1173,8 +1203,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	if (!dw)
 		return -ENODEV;
 
-	/* Disable eDMA */
-	dw_edma_core_off(dw);
+	if (chip->flags & DW_EDMA_CHIP_PARTIAL)
+		dw_edma_core_quiesce(dw);
+	else
+		dw_edma_core_off(dw);
 
 	/* Free irqs */
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 0ba8a1143fb2..3c730c88f0ab 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -55,9 +55,16 @@ enum dw_edma_map_format {
 /**
  * enum dw_edma_chip_flags - Flags specific to an eDMA chip
  * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
+ * @DW_EDMA_CHIP_PARTIAL:	Only channels described by this instance are
+ *				owned by this driver. Controller-wide state
+ *				must be preserved, and layouts with shared
+ *				direction-wide registers must only be shared at
+ *				direction granularity. Layouts with per-channel
+ *				registers may be shared at channel granularity.
  */
 enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
+	DW_EDMA_CHIP_PARTIAL	= BIT(1),
 };
 
 /**
-- 
2.51.0


