Return-Path: <dmaengine+bounces-10817-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPOOOp3rE2qoHQcAu9opvQ
	(envelope-from <dmaengine+bounces-10817-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:26:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FB15C664F
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5947F3015883
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2513C3AA1BD;
	Mon, 25 May 2026 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="S89ICSpQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021138.outbound.protection.outlook.com [52.101.125.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A609D3AA50B;
	Mon, 25 May 2026 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690292; cv=fail; b=n0WxhS60g2vqpWuvdkYVpM51VdBv7LObTbW1qkF8Lf4SRpRbNtRUJfKH16iMroWCMtxCEX3bIJLdzEGLOoSJ/7ItCWdfbWsprvZX2Va733ziQRQhU+OW3x4+A/VgqPGg08iMDnEu4q1EaHrHFx4PsbV+vOhb+UidLMU4MzLPEE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690292; c=relaxed/simple;
	bh=vWxt0Lw/RZqU/FSLufFDn4R/8kIHnmhapFw2Jw82JRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qYSrvIRxAIOOB1WzwCmjAFXTMdayXUsWJmo2ZdTaNDWz8UY2oFTr5mm4Cob6qPYJvaNzlVarvZ2AfZ0nFBGCYPnd9i/7VKsEJrK7j+wCsLq/RbA2bs9b1ITGPE/iY0L1yZvsuxA7p+KAQQC7HH7QIaMzmCNUo72RuhQNyY0d4HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=S89ICSpQ; arc=fail smtp.client-ip=52.101.125.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knKum/M0IVqkVtHiwG8E8Gvzvjs4IKDRzJO0fi6+I426SMvRJPhcvtNmIlz8mxITqwXRmfuEB12iKj+N4iWwdRRf6u+KhpxVHaK9EDOHaGcrcTli6sVVIBeNeV4OUiszMkoBtuE6QlrKR1ajRuj7Ejx4fC8ByUvCzjnWXm0d9TEKDXK9OoiZKS0KNPXOFMXFpmcWcnstSvAU+oG6LQQiKTZUxYhGAY9tA2PsJdbuesf3jfR8aLtTE8hqnC4ihTp9u1Ib6XwOsyJn77xzDrJt4PicRpoQiLZrA6cWGx+S20yYyQxpzuLoJ6IkK69r4X0szkB5QrMa8/oicQYeZUsiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJrSYzdKuYhZDq7PpiP02aH4pCooKCgCGpcQ0HAZczU=;
 b=ICIxfnRPRUvElqLqygTtH921Stp0fY3LCre1/XPy/TGOnwOpPP50Mfoq9bkY4E/YlLV6QzZ/daCOGo+z0qkMqGOEGD0ksazkxHCiojCw/Mhle7FystTlWTpjlTxedjxnuRG6bQllZmmT8Wqxp0iNw0fnOnAfvU4XUTEkR/NexTzBSg0sX/uzTVJpz9vTwjxSafKjXqQ5uKdVNjX+i+AGL1zlQHNlUNnmd3zyiqJXXGsHX/cQVkZdwsRKRhqUpe6M7dzlsG4Sc3UvM7jhDQn9HYZpA9JoMRdrqbaQJue1z6H4vTJTzmcwvm8wz3v2nKv3h6tapwSgjYEyiGd3gOeytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJrSYzdKuYhZDq7PpiP02aH4pCooKCgCGpcQ0HAZczU=;
 b=S89ICSpQagbWK9raL0Ku65SN7OKVDQXum31EcbLFJJOX2Wod7jo9nWOMZ2xeJ3BUCBp5juHvtZsin1CV3uOcvl8L46IrAINHKOTrNB6nsD4jp0+IsU7MvXU5U6dH2IcZPXGmba9rE7irF4HS0JuqG3CItozQNG7tf14kD6Mb1Xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7796.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:441::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:24:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:24:43 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/12] dmaengine: dw-edma-pcie: Handle optional data blocks
Date: Mon, 25 May 2026 15:24:19 +0900
Message-ID: <20260525062420.3315904-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525062420.3315904-1-den@valinux.co.jp>
References: <20260525062420.3315904-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0075.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 0617ecf8-24a2-4dbc-61cb-08deba264eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|22082099003|56012099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	dRivp+x+TsCcIjl3pSGgaX+Tdv6VM6DEhIIGOrneFu/rScs9rDQbZ5EZAbGMQOaOrOzrluiftgwDSDouSdpyIP5VVKyfKDi4CpIivzExtskNL95fu5FZIz1Rt2U1bf2vwfL3/Q9wIGDkajPr0MIvT2QbN9PTXjYOLQTgDdlBqZhuP8yBJ9J/YNMCWGzTExsEE3zc+QJYLha/eQovmlFQ5lBuHYo/FOtVHUQ+GmHmNkMYwXobJDW8vZZIN4vakLhBDMlRHBNufNNOKHFqIgxoQNoERkjIPm+bi81yKNB7qQ4K+JuA3o9Tv0SzHUp0ULUmxsglBjVKTGHxxlmVkj1BVehbR2ld1GbeY0bbY6DQA31m6+mt9PWC54xegzCk/kZHb/MQdvkuZjDimpUYLKN25qnMCHNnjewmHwNHUfrIVc4Z6xSOMV6IXxyd2TlNrU8vg0D4Kpe3X6R2aIbqaA7wqEZp2ykf1+UELcxuJ/RF1IJlAbDlt4Ez6ldJB65lGkc6nwNw0b9Uk/HmE6mnIyOBSeVvkvJZKhzFd5q1+FY28fXjXX3VBVJ67KdGK2F+pIgLCkMB5FUHgJvBXLh5v9DeRhXOZW34jjlNuIdo784iKshNv9MXjqHy2OghmzmaHnXPNXd8rXtvLzlLDeSGl1rB2aUGjpQf0GeRBHfIB4L1YzXfRx358YuQpFgSSp0AAYmn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(22082099003)(56012099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d1tkCt+gBIDT0NvAEHIU5cJw2VN+35TWIQcOtMPLVtL3TPYzZMjJugVfh9Ki?=
 =?us-ascii?Q?1aLhIhI8fsD25kIas9xAZ8qEeqKAyyRpdLPRasV+fzT+cZQCZ+y43kc6hbuS?=
 =?us-ascii?Q?t8hLnreiV95LzHLFyspwzUSwDizltPbBtEubroPA3onm3F3dFr2zAdxcs2iu?=
 =?us-ascii?Q?9EM3jvoAaaU5lQsWd7COQyQXXdEHHHu3a9LZcUb0VeVHJzaTDweX9bCk+SQq?=
 =?us-ascii?Q?0oPHPnOpqFoR19uOxMQHgL8w7nIj7VqWM1gZpRCJ5X8jKKWNs1ev4bj6h6mc?=
 =?us-ascii?Q?euGmL1vOhA68jwmH9tDBXV4Ti6uDuLkupResRSWhaViXkqsbnGxFNVEkGouU?=
 =?us-ascii?Q?RzUXQ2yNYOUVgcnI1WAATC+JJekjuqpNW0YsUpnejYcazO4TcIAnwHGqIXI2?=
 =?us-ascii?Q?cDKI1fdhryATYxLMVv/Bz8KGHAH/L+5kpiidtLJMeX6My+vNFMWTXUr+s5yO?=
 =?us-ascii?Q?safWYfg9dQTtoXxt6h/7WYbJ6C6iQtKOoQjHnDH4QEaOxzPdZcSTmZ+9sJ2z?=
 =?us-ascii?Q?AKnwXHJuAvd4KdRU4J1DF799DmuyxWdL1lhXr0WKhv6eosmoWBkHHx+AoVzw?=
 =?us-ascii?Q?hyrQUiwxGy7yD7GGRNN/zPYHGM0pwI7pZ1qwRJHlvl/FNrpO9bb4EOvyA9wS?=
 =?us-ascii?Q?aXS4NptJJSaOkJiMf7GDVcE4Rw00F3YPlNoUvf/eTVTJLKVo0cVJyd+07Xf0?=
 =?us-ascii?Q?daisweIUnRZ+5MdQWR96Kuv2A/a7TDheKpriLH6p2tuzfyprqtAnNi8y6g9a?=
 =?us-ascii?Q?pdmqHT43Pv2J8VQx97x7/wpfu/rxJxj26rDNjTBmnSzZBZ30pv6msJd+p5qr?=
 =?us-ascii?Q?P8RfzaT5/In3lXKpLkIoEmcQo/3k8qfUI137Iu2rOIFl0dHMkIgps5C8uTaq?=
 =?us-ascii?Q?BxcWvE0/kS+Rb3sgRVPb7AjHBVSV4Q3RulLhmmWP+FaS16sovsaBtyaJcXAi?=
 =?us-ascii?Q?xqS36Etm6CA4aAaiU/GTCMK7NbhSW0BtLhxs77keo+w8n5RMGY7jcingUpY0?=
 =?us-ascii?Q?ws9evt6vmOEXKSooTiieLxsy4i2QgPj5B0xZBntYjXNdAAUKLLGRkgozgLFV?=
 =?us-ascii?Q?HZRHJsxacYEUymOwJPpZeEE8FWNKEaTuW5leqTNLHOtGiumFEULU0OPHeuZ6?=
 =?us-ascii?Q?VR+4F4j/mh1z/H6/vPBTJm8g3/ugZr3CedNWloDOLfILs2WjG8/pgU+moITK?=
 =?us-ascii?Q?i4DrWQ7Tr+mjgYa3cEByeuEi5jupmEoCr5wKyneJ6pxz1NkMpVTAPqCPYviA?=
 =?us-ascii?Q?B9HIshS/rG6ETKXKO8AvWrHGTF0L5sjQryV/3mc3VnGSV64fcatvCx19pJyF?=
 =?us-ascii?Q?dgQxFQZWajJhwEw8TUAKQZ9mf4cheS2RF2cAbJ/M2AwU1BLl1ggE8LslZTUg?=
 =?us-ascii?Q?iAreH6Hvn6ZvS0oGY4/R+KepeewrbWCnbKGKfhjkqkbHbNc0o45BpluV8Dbr?=
 =?us-ascii?Q?JcQJ2rvm1WeU06jOUHY4Tl1vND7cNp0rLjzNHOz/mumo8vs40+GpmDLS9+ro?=
 =?us-ascii?Q?J3tKwLlPpEMI6uWrF+JRrq8QHs78noiApgJUwosHQKo63ANYuiCeiqknsUYq?=
 =?us-ascii?Q?D3INaYcqKXIq4HBv0fnnlL64c3LIAnvvcFk4W6bveItYs5UoXVIkeljI8V3J?=
 =?us-ascii?Q?Nn3kZowb8thIIjfdaYSwbzvAZmaY234FV0ENv1i+ikA0A2a1lR0mFw0pnl8m?=
 =?us-ascii?Q?56TiYULggKzw7oZHbCFo/0LzPAxossKAY16kCR66zTtpATgXI+at3KtvR1Mo?=
 =?us-ascii?Q?JDFaHgo1U0Rniy+gusqvye6IdQdGMgoDwwbIPb14K67vtVaRN5a0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0617ecf8-24a2-4dbc-61cb-08deba264eea
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:24:42.9619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SR4B+YT+HH+1r5AGVtN/kjpbbFTAtqf8NYcdLHd3ZSm4tyo5jL21rBtJXu0xRdhQr1IPi1JaSLUQfrg5LGdFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7796
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
	TAGGED_FROM(0.00)[bounces-10817-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 96FB15C664F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Skip data block BAR mapping and debug output when a channel has no data
block size. This lets future providers describe channels that only need
descriptor memory exposed.

No functional change intended for existing EDDA and MDB devices. Their
static channel descriptions still provide data block sizes where data
block windows are used. A zero-sized data block now means "not present"
for future metadata providers.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index c2be43170e02..00e9c9775e3e 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -410,11 +410,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	mask = BIT(dma_data->rg.bar);
 	for (i = 0; i < dma_data->wr_ch_cnt; i++) {
 		mask |= BIT(dma_data->ll_wr[i].bar);
-		mask |= BIT(dma_data->dt_wr[i].bar);
+		if (dma_data->dt_wr[i].sz)
+			mask |= BIT(dma_data->dt_wr[i].bar);
 	}
 	for (i = 0; i < dma_data->rd_ch_cnt; i++) {
 		mask |= BIT(dma_data->ll_rd[i].bar);
-		mask |= BIT(dma_data->dt_rd[i].bar);
+		if (dma_data->dt_rd[i].sz)
+			mask |= BIT(dma_data->dt_rd[i].bar);
 	}
 	err = pcim_iomap_regions(pdev, mask, pci_name(pdev));
 	if (err) {
@@ -478,6 +480,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 							  ll_block);
 		ll_region->sz = ll_block->sz;
 
+		if (!dt_block->sz)
+			continue;
+
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
 		if (!dt_region->vaddr.io)
 			return -ENOMEM;
@@ -503,6 +508,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 							  ll_block);
 		ll_region->sz = ll_block->sz;
 
+		if (!dt_block->sz)
+			continue;
+
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
 		if (!dt_region->vaddr.io)
 			return -ENOMEM;
@@ -536,10 +544,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			dma_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
 			chip->ll_region_wr[i].vaddr.io, &chip->ll_region_wr[i].paddr);
 
+		if (!dma_data->dt_wr[i].sz)
+			continue;
+
 		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, dma_data->dt_wr[i].bar,
 			dma_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
-			chip->dt_region_wr[i].vaddr.io, &chip->dt_region_wr[i].paddr);
+			chip->dt_region_wr[i].vaddr.io,
+			&chip->dt_region_wr[i].paddr);
 	}
 
 	for (i = 0; i < chip->ll_rd_cnt; i++) {
@@ -548,10 +560,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			dma_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
 			chip->ll_region_rd[i].vaddr.io, &chip->ll_region_rd[i].paddr);
 
+		if (!dma_data->dt_rd[i].sz)
+			continue;
+
 		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, dma_data->dt_rd[i].bar,
 			dma_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
-			chip->dt_region_rd[i].vaddr.io, &chip->dt_region_rd[i].paddr);
+			chip->dt_region_rd[i].vaddr.io,
+			&chip->dt_region_rd[i].paddr);
 	}
 
 	pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
-- 
2.51.0


