Return-Path: <dmaengine+bounces-10603-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJRMD+mmDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10603-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:32:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2703759F6F0
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0696230327FC
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278D7395AF4;
	Thu, 21 May 2026 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="p8l7JIwE"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020087.outbound.protection.outlook.com [52.101.228.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FA939280A;
	Thu, 21 May 2026 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345092; cv=fail; b=CI6Pb/NjrrpME5Mm7tdKFkKulTgCoZiOP94AWDjSi69cKnFVs4Ww/TyNDNdNVSQM8ftPD8qXbs9YVjYY+NbN1Wnd1Fc+/cA9106tis4/3YnW2kSQDancqthvhsmeKXD5b3bvlSOisGwaS6np/72oSYXZx5xjymLFr/Z0sw9oNRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345092; c=relaxed/simple;
	bh=AskA2I3sJCzBMDbM7e8u5sW170JweAex7VKcO8APvA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RxIzyPfZvNj0vgPK8jUTXlxy92m+9VU3TRVLGhKRUJ5xUT3BeMtJ/VZOU5Ik2m6tk/qfT2KS2g35drHfMO1AJwOns0yp7EGuY0P3x592bqyj+IAzTl7lNEEWJDQ/Wk2WE083rgs8Wi3LiNHyIfej96KbpD5o+IA1YaX+n6OdiHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=p8l7JIwE; arc=fail smtp.client-ip=52.101.228.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnyFRCcs8GVpHKT7yfYbEHuyDsN85SJ+H2YtFaBgSGsuAyVptWghcDF/dHoXZZlO9LoP+XiFo3upqZ4IMd2pSn/cfHRIpg12kTltDCWRx8UpTD9Zui8AtcYsg9z3RbzoKZ6V9/4odhGNHGf7dibQ7pYvsx9NKvZFhwkbDxhOh/UjRC+NrpjurPArsf+w/0KlqBwZfPWTes0dnhVtn0mpJVbAlSE3dJP6TrfS2YnuYMv3Ub7cKPXk4SuA6HD0am9B3JLi1SaQe13H0qHgXdGWkM2cF41gj0esiFDgCextJSSe4ydVZSCUi5i7QUYtGisQ/0z1GYVA17ghNHLcr8S/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcKlDAezGyzJptobqspWBXdpzI3uAN4M0TEirzYhRY4=;
 b=amn9dPnbVQIYbRrIkI4+ZONKY62UOjix114iH8OkOVL9ivFceyVklYTDc2PdHtkGc4iv+/+cLAInHx+kuk6OI8WGg79HeeQSXT3gyUI18CUw/1n/nZ1GsdzcMcNFu9MM0qxKe0ciBzSWWEofkv2hPisasw9BO3TmEQ5hbJBWQMMv9DYYb8Cel1hoJm0JeYxD1uikotUfA1/JT18C9kCbt9DVMs7BsspNbQH6nMJdrcRQwNliy6dB9s4zgwNaNogrmuZpoFCKqGePRCVQ0I5ehQIEVb7kXZKiOro/rVL4dOLy7iRv7eswNLCW0G8Px2yHC1N6k0DJJE7OnrqUMXJ8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcKlDAezGyzJptobqspWBXdpzI3uAN4M0TEirzYhRY4=;
 b=p8l7JIwEiTOwLIow2MyCCaBQC4OT5FV0K/iIIjBXEG53LV9URo37+7zFF8EBKBRXeIwb0Z/62JQ8GiN94VGbtZkFvS22/CZPaNtKLU+Mn/5JB7+aRo1QuWuPgQHAaUkwnTUuoqMZDonLfuBodhBdjwSQBvLJpZWKP4Xn10YXU7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7818.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 06:31:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:31:25 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] dmaengine: dw-edma-pcie: Add default IRQ match data
Date: Thu, 21 May 2026 15:31:10 +0900
Message-ID: <20260521063115.2842238-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063115.2842238-1-den@valinux.co.jp>
References: <20260521063115.2842238-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0074.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 778309f4-fa58-4a39-d416-08deb7029525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mw4jqU3r1SzJ7CMwnnmKfA73Zk9AH/GI+5tt0fI/hDSpSX59RQwx7jFi39sdlTWwHNPta5ikDW8RQZFxXe3NQ3mjrnUYZNKnOd4Wg3uUEzApNIgt+TceYTqEjf+4b5vQOX0HCmG/aNTVg3z4Wz01kFfwXJPufUmgxLDZ1MTgkItSq0cbY1olRolJCi0jhfmTnR9n4ColcX71ZX8HqshPOSbsHaqo/azWsvxrV0vhzj1rNkiQzXS0sYsli2DQ1IERzNVIavKmPvW1hkoTf/xX3k5KVhepby1eILgeURcuCM/ZFxxogpSIpaKGno4quBN1stPMZIbln3lCIqVkt7SHM4ITiFwZUdpaEQmF7nnc+1FeJciaNDvEAxHNsRzLqSVC0e2Vuq8TL2f/a3xjAxwfAKLCn0FrUIsqiYcwDEm0ugGiD4gn+CjVe9DuLjq7p5YrByziGFtJAaSMld4qFrrfhnRIICzS960xvJPmdmwrJ/zZKoOTQAg7p0KPiWZh/IkEo9PSPqgbcrVvxcIqxx2ZXIWx9XpDrMQCJ0fH46hKnUQcQiUu2Hxt0shdazS7iEf+7UdjHG/NdptP/1YrM1m0yJjyx+WjSV9xdACwEWGTw0a+IDkRgxM5rRBGGEbnQfmd8b70PfeXB9oBZTTrsWa3H7nwtCl4D/CBuc8dgse/UqsSmKGhRWAngJpfkXdCUOTK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yfhIdYY+Rb8dgXbIBxI9U4p/dhzR4eGAofjzuUIq2nzXw96R0PdwEtAM/TF0?=
 =?us-ascii?Q?Lf4mn7XE9yjjVLC9PUq4ImabfkVFPeXhaOJdFugQ4IrcTKGS7YaaNKbiLX2s?=
 =?us-ascii?Q?XWy1rR4PsKJWTcvKX/Gv5oyrcB0Eezh9ZOHxuRwGWDcP8vHtn2yXcmg/u/Wl?=
 =?us-ascii?Q?9yZXVvMqresC4tnDOmFKyfPYSZKo630mBy7uvPE7igjzASV3YJunCcOuDIZQ?=
 =?us-ascii?Q?pZvoVPTUO+ezywYIuIF/VaR6B1pndLGxqOiKuzcC+V+Oz2dFrM7UxISQ6UwT?=
 =?us-ascii?Q?qdBDHXkIsNCtAKpqKa8qBAAc+34IbxzWZP6pV+2NLHV40OAT3buj54YXDmoO?=
 =?us-ascii?Q?Vd8CAqlF3IJ/fUCenQtTaBjqxgvjicZuWDnRJcN9Ff/1Kjr8iR6BhxV9Sy1J?=
 =?us-ascii?Q?4DrhXvlwNKW2sycUXEsk016u58D+eGKIdR2FHtIoQNEQpZRNY7YFk/57Yf1A?=
 =?us-ascii?Q?PKNkPZgLIi99MFgGUSRuI/XKf8KvAzFCZoX+E9kO+/OQKN07Skpb8liPmm0u?=
 =?us-ascii?Q?yY4I43s6Z4rSJMTqt9xd0J+3rVcIVHmxUm8WJbWKQ7sHkdmv721NuUTwMXZr?=
 =?us-ascii?Q?DLGwpCUMVjvpp3RF5sEuCixNsw+XhFrciw0/EtPNCSbvhL0J1n/nLy/MXJt/?=
 =?us-ascii?Q?KJJqXXFs7M4Ez7tRvwGM5RH+rUckCOrvoyVX2B/T8ihSZivJErxYYP3vE04P?=
 =?us-ascii?Q?vjOaFgveGE+mmYKuGVQ7Syxmyy7uDgL9CNxdjqKid8T1bjwYAGgZnbnYYQxM?=
 =?us-ascii?Q?jWMcULi32HD5yL+rRuaz0yk9fBVCWhx6od/FnxWIy1CemHbcgYWwHIgeW1iS?=
 =?us-ascii?Q?cXhn966fjYm2aufv8o2IDZi6++/IKZxpmcYJyrULFS7H52n29/6YlResLcEp?=
 =?us-ascii?Q?Vjbd0tgEgY/nap4NUbOrzqdNKlKp7iqIJtCMeXkMF05mK6GxTQ0jFwSPhHa6?=
 =?us-ascii?Q?QHSXWlY4Oy8O6mCiC4/krli2cZQ+Tb0yKh9QPVtXaHCVQH1LgV55srh9iO3Q?=
 =?us-ascii?Q?mK2yINqFyjZuny0bkdSI4TnygO6/chsJrVYJrqJab83BEyJsAnZsWE50t/Hd?=
 =?us-ascii?Q?xBMWhExl3XVpxxboXjQ+mbgYrpSswO6uvfzUE0fruHBgn/0PQd3K5IzAxmOS?=
 =?us-ascii?Q?3bN+c4ioRxbUWhv1FWOLXYEH5CI88V16wleg0Dtd9QnLiAxBMyfqYTRV6Bdt?=
 =?us-ascii?Q?6yXT38ZrJctut/NCAtp6xNscWmu4GZozoO0W6ANviUGWGNdS94OaahnCHc1u?=
 =?us-ascii?Q?7+z6t7ZlPY0l/yE0veGfgHOuPbWQAhf0mPN6kn//ZrINJQvJ8YhZMM0YiW5f?=
 =?us-ascii?Q?yxj5fZa+Ox9OBVqN3kPE4k+vGHIHDK6qYyASqG9GKIUQUBtwT/faEUUWpw/N?=
 =?us-ascii?Q?S5nsX+xhn90MUmvM+4j93Ll6GPz2cLj1WuzM4y8OU7ZN47mKgztEsSD6Qkvm?=
 =?us-ascii?Q?1FXii3u0wZ7t80E9h820vJnSR0aThvP1zpquY55LjFk73I143mR9VhQVhCGs?=
 =?us-ascii?Q?Ojnh17D0vvCAAh//YTcxkfiga4uxfShcXIc9rnLh20akXPtK+cNekiKpTNgA?=
 =?us-ascii?Q?3zL9+f0SNTD1B7V0ziCkkRdefpYvqEIMsvg/OHv0rl0tiT6hvzhLqFh4hXz1?=
 =?us-ascii?Q?BKGne5G7yVnQ/WoHG2EZbKxvf0oJfMywaTh9Ib7wC2HNam1jvpkpryAsJuPe?=
 =?us-ascii?Q?wb/tgViAoedJH59cO1eoU9QvsU5mTckjP7A1aVFX5N3XF+agayuYgg4nZP/t?=
 =?us-ascii?Q?mEh4UHUA3aDopIb58dlTWgABe5A7C6zi4J3/wJ3GYB/tJCAkCc57?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 778309f4-fa58-4a39-d416-08deb7029525
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:31:25.3960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FgqAWIxCu2QDE2IoHSWBCT49PL6af+YrNEm+Y1t/xcPBw1F5AGYyLSujpyQdEShq/B2dtdLSzg8HqdDlJpkag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7818
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10603-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 2703759F6F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Store the default per-channel interrupt routing mode in dw-edma-pcie
match data and copy it into dw_edma_chip during probe.

No functional change intended. Existing Synopsys EDDA and AMD/Xilinx MDB
matches leave the field zero, which is DW_EDMA_CH_IRQ_DEFAULT.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 8ae164169c7e..cf2f09f1891c 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -83,6 +83,7 @@ struct dw_edma_pcie_match_data {
 	int (*parse_caps)(struct pci_dev *pdev,
 			  struct dw_edma_pcie_data *pdata, bool *non_ll);
 	unsigned long flags;
+	enum dw_edma_ch_irq_mode default_irq_mode;
 };
 
 #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
@@ -432,6 +433,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->dev = dev;
 
 	chip->mf = dma_data->mf;
+	chip->default_irq_mode = match->default_irq_mode;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
 	chip->cfg_non_ll = non_ll;
-- 
2.51.0


