Return-Path: <dmaengine+bounces-6341-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E74E4B41889
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 10:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6DD1BA454B
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7BD2ED153;
	Wed,  3 Sep 2025 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="LvAifYK7"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010002.outbound.protection.outlook.com [52.101.228.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240242ECEB2;
	Wed,  3 Sep 2025 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888137; cv=fail; b=clb5McqA8qP3GUyWkfdVFUtqzOJLVVZqyl7lAjehOXYT0yCYEdc0w9uNTtNsnum+Zl9FRjR3tP9SicCg6San8lvcr171ZMy6Ek3UxBXdPGheu+VCmYqc2fOgSq6NBAGGdkNTQeTzuHxV7/UFTDJriLPhRJX6LrLph7Xl8za+ntw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888137; c=relaxed/simple;
	bh=dgNUL9QE4Jmz3LP43idVHybFUWWnTnM7MefrjxgIvwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KV+9SQujJMxkHNdw4jwnp2H7i/mzVRC8FHmhDJRH98sjg1rthls9cG4+PSfUuINuz3wZIo3pSqzMlui+7UHxa0nOivJWeNakybD7mUS4gCPmwPqYxrDMEbc0b276VfNS/w0+j+4/aN5SZ3WLToURr42YDZrBJnZU5O709VAJy9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=LvAifYK7; arc=fail smtp.client-ip=52.101.228.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ah59uscYtazilno7eiOPbOAKNaBvtTRO4RLZlvC3XhVC5RVMHGaIwYBEiyGartR7R4DfZKOXJG4/Sk7pqCQBNCSqJtlXkRg+QgwqrsL80fH+LLRoaWWSbBTcYY7BOOq23pLJw31Q1nUwcg0X6HPnc8NrIbwOCO/+f/UZs7Fui4CaUNS6BjzzCHXXlLRD6xp9xk2lPGSh2QRrsFcS3srm9IikNwSFUQ/mJ/44eI3ugtK28v7hvt3r362K/1vUJzYKbrkJ7HenSyPCZSh59RinS2h/TLE9+ZKgDrk+pM98U7fvuh7/+yanSRoBddR0AqvY6vY3B4mCrE4+o2s98XJhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07VX0wpayWKUlVs+AvN1Azr24QZKESgYWTpa8pAhKm8=;
 b=Hsa8T+JkzHDnsAHMIIdkyM9FifaRj7pXOZIkL8mywvnaDI0YrffOseWEBKhFNWleFRNyLg9N2H2E71t3WIZY6Y3VbIW0Md+rXb8z4W6VEtwoQ89Xhc93VEJHb9LP8fgfwH9rx38Rzp6gv36WsKnzq+KSl+8uQCCPmmCJkdzlKHjw8MvFjlH8+hE/ooXBHEWHTl+eI22SRN4nNMuvsPaYGoXXTS36sD/eVdPKnWvDa0oca8RhyjLfhBQEBjvOFgIRUzDzeFDQ5at//vTKhnAntxiv6hp/nBIDbTbDfgf77+kl7mdKLDtulxmtTljSbkwmqOIT09HQFGgBnrCF1yPhmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07VX0wpayWKUlVs+AvN1Azr24QZKESgYWTpa8pAhKm8=;
 b=LvAifYK7CliTsF26p8WqmntPL7tCeJGNg6mDQC2XYNjUYhHMVFFZBgi1le8Hcl7XQpPnJ/MJp5QgVHuJBaKxkU7HuBnhSKp6+R1DkD6rG485Ct0wBYgbOEWDuGBHmFNBkIIgGC+lLCUw9b8mL18xc7z5b/nnOOtJ+cTCEC/VCc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8530.jpnprd01.prod.outlook.com (2603:1096:604:18b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 08:28:52 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 08:28:52 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v2 5/5] dmaengine: sh: rz-dmac: Add runtime PM support
Date: Wed,  3 Sep 2025 10:27:54 +0200
Message-ID: <20250903082757.115778-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903082757.115778-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250903082757.115778-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::19) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 48992ef5-953b-4ef3-e292-08ddeac3e9eb
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bsXXVj9QdStwgV47ZGWfIEJ3oif3C6A6AfrmiBOG9Ijd6m8VnQlTCxAYyIJY?=
 =?us-ascii?Q?KqE1IbBdUmCVhKb+B40L3+XND+skb1bVMPErJsMK72tJ5nEco+Im9rq6ysiH?=
 =?us-ascii?Q?/oe20MHtqrNUtWslQfE329KtagTY7VmdQyk9k6w6hS4BS4HRgq6eCdgDQRPa?=
 =?us-ascii?Q?tDp9l5nRLd42ihsXXAvTYEFihy14y5K9AqQkKcf6rtwQQSOtkbjMRwHRkfVj?=
 =?us-ascii?Q?ZLbyzJmWjdVaXgn/uKhVDP3F8jrcLxKw4fX/8pfP/rPhdwwyC4kfqMIGT4R0?=
 =?us-ascii?Q?Xxj+Z/Z4SMm4HCIPZ4T/q7VrRqCidASCq6DACXBE6YLlHcYnQp9p2c0Wl+At?=
 =?us-ascii?Q?l9gSodNYKDfqNm9U67XMQlGgiDKeugjbN+Pf5oHmMk4DXoe8+TDVoXXHhT+6?=
 =?us-ascii?Q?P6q7vmcgFbdNC5ryZoMxyIzd/EnPGbGP9Jnp5Y0ThNmB122wt2BGmU+DBb0h?=
 =?us-ascii?Q?7d4gV61jztjiNd84Z2UEmhx+j+yIV9WhhOZgXNqdgRnlnhddpp5Tix3Ivh4k?=
 =?us-ascii?Q?Bl7d+lYI/9WLqaPuh1YGcgUv38a1EPImuowKP9k0rP3MaQU5DbTgsxz2Z+V7?=
 =?us-ascii?Q?von51Ng9es9oaUHMk33cgJKU2Uht+FKKamaFtvnE1GgCPT70jz0YcU3BYaJV?=
 =?us-ascii?Q?VnR0Vbcb5itnicTPxn1MQR+1Cxu2lmBagDVHNwFqW1FSgBuzTw5U+qdUz26d?=
 =?us-ascii?Q?+bhr9Z52x3uMZZdrkMbz+SeDfBYAavhIfLj/Ia3AKGW5qtl8giD1uhc1tn4k?=
 =?us-ascii?Q?eRmD0CwQo/JzqK2NCpL32RKXsx60ph7/jBTjFQoFSVSFZ0qKKLY/Y+5BBUl6?=
 =?us-ascii?Q?dWSpzvY6jnOLsr9UQUEUO8RxfO6oxg3WKmtxalylu1/9hKuaojszGmgTi6q9?=
 =?us-ascii?Q?iSzFcndYTW94YSbXUpwHIYfc9poGm8qRADAnsq1KXhjUTpc1Ah22Fi6oodit?=
 =?us-ascii?Q?OxwxJn6TVK/GAnKzWc3+PT5n4Q++m8wpfHGLP6eZo4bi+G1gWjHk9lWAo/1c?=
 =?us-ascii?Q?6Fd5dwZIJE/+ClHjStrTs2opwYrLOV2HljlYpDNDVDEp+vEXg1Y16ReOQRgV?=
 =?us-ascii?Q?NQBOJJdxmnWF07WcSXN+/bk77WH84eatecSLTpjvE/EW+D2cB6mOzeHhBtaz?=
 =?us-ascii?Q?JyTtKDpimKmgwg0gfYnDfiyXi3qAIFF9lszOg79AzqHa6VUg4ZzgZQakTtA9?=
 =?us-ascii?Q?nEENZo9UY/uBhtlenzpEGMpR7uUKvIK6/FnTj6MKxMve0J/gRL03ecCpa26b?=
 =?us-ascii?Q?ZAWyFFt3RvU10kAmk1QpD08VcPCXYr7Wi4fy56X906hps9rDZPUJBK7/ZIgu?=
 =?us-ascii?Q?eYTtgkZPma2KRAdZ/QsdzMITOlH/ZW1pVU6TEx2+zk9xPFs8wLVDhHvamV7N?=
 =?us-ascii?Q?99C1o1gR1LOUi72J/9pgjxTkGkP7iKIEDiD1qCELm9v7pjp8U5K6QCeVROOK?=
 =?us-ascii?Q?fK9q+GY+vQ6U1+5uiC2+KWIWZOASD1HxzXpQVkZyTQFzKLbV2nG/eg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?272GXMGuauJ5d2i7BwyDkoXE2Du7P1/Xt+34QuDTe3ZyfnQEM+5J9Kuj9UdL?=
 =?us-ascii?Q?wTai0V8ewRsoT62/65yP/q63NR28uk6FcPPq94A+n6OVWyfuENvvYbxW6rQ7?=
 =?us-ascii?Q?1n6HBpzrMRFJPNjXrU0N+fHfFYGuPd44uVLze3GGSer5QAZg5gulrFimRDKa?=
 =?us-ascii?Q?YlUIgp3LVEqBwFl7DhJfpzBkFkCDW5+LVuexgOzn2y+xA1NSrOAmKM55wvNe?=
 =?us-ascii?Q?fhxqcHVutOYEjEzHn72b8POn6ae5LM8Ub7L0SMCIg3/AzvB1J8vXP7b82rmK?=
 =?us-ascii?Q?XeSA12IuQRbXziOA9WGBDba2B/NiVTEoxFDcowm+3XwH0jSpwJhvyuDksSyf?=
 =?us-ascii?Q?CRzhiulpjw/gLv4ry12YEYH7LCsNRIljGPGxTB5gGXJpXK/dWqjpw6z0KQXQ?=
 =?us-ascii?Q?DJQJDhpwzpbaPcm/RP0PxxfyncGHUliyOevmcY9HGHcPvkC/n1V2oXZhizyl?=
 =?us-ascii?Q?fXWIcXEVkXQpnteG1YaKlqVsgVV9LuJbsSWOb7hq0Tb51mCfQWAVmulgZegi?=
 =?us-ascii?Q?lxc/VngmL8F7OQYoVVZ/fbiJ73U6joptTD1OQUwv0aNOn6sdFWxEJ3pftJ0T?=
 =?us-ascii?Q?zln79YpwiS3zVtyp93ZcSZMUwHS+556tRgRLmK7E3lEyQ8Fv366Y1WMjbYEH?=
 =?us-ascii?Q?zB7RdFlB8d8KQLnWL3jqox3V2aydjKPeAja4VHRMEfDIzpvxYlYV7S/NdLzs?=
 =?us-ascii?Q?Vj2tSaGH2vNZNry6+RknyaLdZiOKARwtfw6wdM5+UVuVyiIkve2z3kAnMQS4?=
 =?us-ascii?Q?8fDrvvdFQj+MdYoUsl7m3wxuUftdCnzzMhYN9uwm3xIujIt4MrMTxkA6P3/x?=
 =?us-ascii?Q?NiIwTZg/pCRzjJHLxMI8VgWr+1zwuR++tkrp5RDjGJyVpF00YGNtGxd7ojwL?=
 =?us-ascii?Q?xu7j9tYaoo4QEQXX6b3eEbmJKyF9QIky6IWGVvuWy9wkmZ1jGqwUqPPHV4Vj?=
 =?us-ascii?Q?T3lweP891HUIsd0ms7DUHgBmTTMqmfsh0Szr+MmhNzEMBSKRcHq1BwZMXQ/5?=
 =?us-ascii?Q?GzbTiuJNX+RNbJJL53oyiRIJFdA6YtrVRQMZHlw8sIDaPjuAa57gpC4E31KQ?=
 =?us-ascii?Q?gd+dDk3zAIbzhcnDdSTrzU1/zei9IbqZkMDdy7RrAUkz/mA6tPK56EbwpR8w?=
 =?us-ascii?Q?crGOTA9FyoOM/Ht+O+Sz4/xUS54aUmfTl4jDYnR2PMXxkXluJRWDOR7ei7Ru?=
 =?us-ascii?Q?rNzgcp+UOO1EG5Qf9jmR8ti4lS0PeK5zom8xLIg3a/xqFsO62PAcGmkHjPL4?=
 =?us-ascii?Q?py/GFRLZqmib0OkINE50n/KT3rr0MoqXvOdwJ04gXc06hH7FPCYsNbLfUvem?=
 =?us-ascii?Q?S1k54PeYFX2nlGqbTSQBsPKLDsc7/HCeFTHNbptevuyRnvsdj8Wowo86YiRw?=
 =?us-ascii?Q?Qr9cFcFfYvQ/h+ddcd+8swmh/+gAla0BeRF1F+dm5CQ0Dd56IRCV3giTxHS4?=
 =?us-ascii?Q?3z6qq2fcq5z1GTkE+dpHT85w5kR3fIMVD0goP5Lm7iFzqwRYlNtgEcvHTpjn?=
 =?us-ascii?Q?0CAukRFweoJaZujz5NK/ejJBftG7qZLH9M/BD3/65nZ1Cmfy6Xsk9suYsWQj?=
 =?us-ascii?Q?1YCzVSM7c6d+nTo73ahtAxyEgjPl8pKoJwXSH71KntxXn5BIkTj2tecmOepw?=
 =?us-ascii?Q?DNZxBeDfkNBz+0k3ZElfzWY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48992ef5-953b-4ef3-e292-08ddeac3e9eb
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:28:52.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MhP/uUYd88KLrxQmIncK1g7QVSKcnNNd/DVdnZMpkc/TqUAGYvtcFqddei/lwXLdMpyhA57+dyVsmhLHFTGKbIfSon/+qWTREwx8uATFhWpYXxcMcw8rDfGCUpC5wI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8530

Enable runtime power management in the rz-dmac driver by adding suspend and
resume callbacks. This ensures the driver can correctly assert and deassert
the reset control and manage power state transitions during suspend and
resume. Adding runtime PM support allows the DMA controller to reduce power
consumption when idle and maintain correct operation across system sleep
states, addressing the previous lack of dynamic power management in the
driver.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v1->v2:
 - No chanes

 drivers/dma/sh/rz-dmac.c | 57 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 1f687b08d6b86..2f06bdb7ce3be 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -437,6 +437,17 @@ static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
  * DMA engine operations
  */
 
+static void rz_dmac_chan_init_all(struct rz_dmac *dmac)
+{
+	unsigned int i;
+
+	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
+	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
+
+	for (i = 0; i < dmac->n_channels; i++)
+		rz_dmac_ch_writel(&dmac->channels[i], CHCTRL_DEFAULT, CHCTRL, 1);
+}
+
 static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
@@ -970,10 +981,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
-	ret = reset_control_deassert(dmac->rstc);
-	if (ret)
-		goto err_pm_runtime_put;
-
 	for (i = 0; i < dmac->n_channels; i++) {
 		ret = rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
 		if (ret < 0)
@@ -1028,8 +1035,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 				  channel->lmdesc.base_dma);
 	}
 
-	reset_control_assert(dmac->rstc);
-err_pm_runtime_put:
 	pm_runtime_put(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
@@ -1052,13 +1057,50 @@ static void rz_dmac_remove(struct platform_device *pdev)
 				  channel->lmdesc.base,
 				  channel->lmdesc.base_dma);
 	}
-	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	platform_device_put(dmac->icu.pdev);
 }
 
+static int rz_dmac_runtime_suspend(struct device *dev)
+{
+	struct rz_dmac *dmac = dev_get_drvdata(dev);
+
+	return reset_control_assert(dmac->rstc);
+}
+
+static int rz_dmac_runtime_resume(struct device *dev)
+{
+	struct rz_dmac *dmac = dev_get_drvdata(dev);
+
+	return reset_control_deassert(dmac->rstc);
+}
+
+static int rz_dmac_resume(struct device *dev)
+{
+	struct rz_dmac *dmac = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	rz_dmac_chan_init_all(dmac);
+
+	return 0;
+}
+
+static const struct dev_pm_ops rz_dmac_pm_ops = {
+	/*
+	 * TODO for system sleep/resume:
+	 *   - Wait for the current transfer to complete and stop the device,
+	 *   - Resume transfers, if any.
+	 */
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, rz_dmac_resume)
+	RUNTIME_PM_OPS(rz_dmac_runtime_suspend, rz_dmac_runtime_resume, NULL)
+};
+
 static const struct of_device_id of_rz_dmac_match[] = {
 	{ .compatible = "renesas,r9a09g057-dmac", },
 	{ .compatible = "renesas,rz-dmac", },
@@ -1068,6 +1110,7 @@ MODULE_DEVICE_TABLE(of, of_rz_dmac_match);
 
 static struct platform_driver rz_dmac_driver = {
 	.driver		= {
+		.pm	= pm_ptr(&rz_dmac_pm_ops),
 		.name	= "rz-dmac",
 		.of_match_table = of_rz_dmac_match,
 	},
-- 
2.43.0


