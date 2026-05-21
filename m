Return-Path: <dmaengine+bounces-10607-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBpHE8KnDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10607-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:35:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE8A59F7BC
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDD2730C4BB0
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C36A3955F1;
	Thu, 21 May 2026 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="R5JJV7jo"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020111.outbound.protection.outlook.com [52.101.228.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753B6397AFD;
	Thu, 21 May 2026 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345095; cv=fail; b=QkwCnmH75ZJeaqN6n9gbuzMvA2w+Jc0FkRTpNCcOivRRIgvTRhyrUkH94uTfRV6RpT/lvVhfKkdxJj6eUXwgEN/cyYlMyDXtuZhw4zkaKq96+c5Hm3204eakFONrzmFHVGSk40FND7qDrI+TVBDNwLeariSB4r8LGPAc/TJnj/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345095; c=relaxed/simple;
	bh=sl9waPAe7dh0tRM6thGPJB09z6kQhFkbtzaLcmlaxxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fGzXjCXkt1nTmuxM49KLvmaCggObx9PB4dKcPK3i9lXb5a1zyrQzJHYed5XaK/P/E3xe8CrhmrfMiKuFBUTulPIORhG1XsDsKFJIyPHp8/Op+3Mu65dqip6ZuEFAC/7DK0g6CqAlNGHq7VqzOiPsU8UGweOhrNPLwGlepFyPhhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=R5JJV7jo; arc=fail smtp.client-ip=52.101.228.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ah5Z9SXOQSxhazl3m1T+m/FryPrdZT+winHRDLB4VuWMrtUqUUdCEO6UovbQNBYN9J7r0WM6hYj4QHYldHJ0eMuJAkBisocVJOmtyM/r3bq0pUIP3X6t627SwJE1kqsqOuUUvOGtXW0k2v0wFv+JMJgGBY1wzekzwNzlFGxuD2uMG1/kMaFqkbu8RbBCpvFXFOeVYmUVEWlQ01MXBLSUtp7nmnPet0a9aJRpR2YBjeBx8qKTg/WjZCpKMM4xb+vaYbOIVwhvOAgLdgdk3Q/U8TOOzWuJk0eD6fWYKdu4usKGflKztipmQDStZy6B57LPKUjQUjOhOywsoABv+oZJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60kywydMrvv/i8EY25mzB0j1uu3PCC7OCoNnB/Fkt6w=;
 b=E/OfLPlVXOVFNOaV5PCd27bfOanPr5zN4435k6IdaZp8UevmeHknzJSqLAmT9jOf+fJL9lb25i/UVNVCnqsV3SFUOO9i4bhWa3/GSEBcVOHuFL+1TwJBNb2bItyA4VQK6JZ7aRkqiCT66/SwlJpd8JTjyrtxYerEqgC3P4r9zGk4jn3nIgCrMzZ0FzeSFGNj3nSv4M9MzUW9JUDJp8BKiIielk2UXnCC3IdjFxmdSUWi9Zb/i2FHIkkoMfI3td7UO+cazSXOD1stu31m4B/Ulibu98ExSNj4mwIWKfBcxdPRBD4WkNX3ZfdsA+z4efvc9NTdw9w3tyYximzkF3rwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60kywydMrvv/i8EY25mzB0j1uu3PCC7OCoNnB/Fkt6w=;
 b=R5JJV7joyE2VKDRObS1sh/Cjg61IF0yxI/oUa7LnrG/PwsFa79SwZhdIco/HPSD71jbHfhlLKm2PMb/Lo5DpG+gCTcf7BIKUe4lYT43JBPNgwaTHaOF5bAQ92Qtr9T8elfSgNkKxz3zg6rLcz+YJgofxXXgubP0AynedKqS0fz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6817.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:322::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 06:31:29 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:31:29 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] dmaengine: dw-edma-pcie: Add chip flags match data
Date: Thu, 21 May 2026 15:31:15 +0900
Message-ID: <20260521063115.2842238-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063115.2842238-1-den@valinux.co.jp>
References: <20260521063115.2842238-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0595eb-1a73-49c2-f9a0-08deb70297b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4Jrb9ARVTwryGKvwypmMy+e/w9YqHLIhnwA4dZEPYx7vK8wmiJusUKaCth7IcVbUm2S0hJZMFcEMDWF/bcYOC8oSbhrej4j2TbRDrL5Oq6DHY2fgfEZ2f4g2J4hgnQmTOzDdlrMKzNZ+gglfIQwRVTUfRQqRit4J58ccyV+hLobMrFiJmVzz1yeOOFAVQiLqnQA1x1+dReFmJwCqigB0AG18qIO4LvP5WWG7+0eXPv5AmhxetDOaNv6Jn/wgAB6Bwpm4QwX/YZj2jTV/k6g4WxDfdjuTbjVjfXz0dHsg2fyb326UOoNKAuH9XSnRgHSlNxzAh5SpGY/8FVq+ez6/lLul7ovhkw1wyZBNf5hRED0kwpOVjUql8KT4uKYfNEN0eNYOZnQR1z9zunC77IjJIf93es6PuCklwP5gdhNcNyH5SR8Pg6CqUVjBklaBC8nOamk+VhBjqBsMU5FwgRxlIeS17CJ2Degd5ASVYqckQU0AaJhTy4YjKDD6+Cb2Os5jTLnItmRDDLn/hIVQkJQWQmb9wcUunyq70R8L9rBqk8igy/5+zbfpL9mKoQeaL1Vce8W1Kj+ljRKVI8TOATu10UWGOEWRz2tYHOEkxF4ZDicd6XjxaWh9o9jFfJQA3+UPvxE74JwU8VvVujj5fqj4uW4BcfZQmyq343KVY/sSkGqqU2mCYePZEODVLDfJO+bx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F47DfpjG+mx+j/iVGe8rysCyZimVgEb8f4XNPsVmyI6WcDxV5BAqFfVA9aBz?=
 =?us-ascii?Q?FbYgZXpvu81vnKy2vr3bXNOdmFr0/K3+KvdfDSPse8jU/WY3UsyIASPeyB4N?=
 =?us-ascii?Q?iP6WFDjbaFqQIKibzGtoOiIxP9RlP0IXPKUWpJ6HRXUj2JsWK1A+cdOtk3Q1?=
 =?us-ascii?Q?MBDYdU30vNE+Scc5xdv8tkKvUulYCLfTgtZ9qwYsXsVLk8Lbi9q74LQorL8V?=
 =?us-ascii?Q?EUaRn5wlgWpts50f3Qq1y4jaU+Pj2d9gIrHePm6lbc8EaTuX313aNblD+5Dz?=
 =?us-ascii?Q?4LpOQ9ag7q84OJAmpzbzA38s3DpIsILh6NDR7lRS5zaljyVnwtWReGfcmIYD?=
 =?us-ascii?Q?oO7BM3j+53J/XR/8ZAAmlV1W5eHTLwqhdsrwhAYE1GTZy5HjbxpgVxz2M0QT?=
 =?us-ascii?Q?58lMH8DIvNfD3jh9+ZZ3DHDZfr/GqHSghCPg7yQvmDzgMem06aVL9FNVQnTN?=
 =?us-ascii?Q?xBQ79cvHAV0j3qiW4vD7T0+6PNJAAfKVxoNBjiBG8FdJJ7VBlSbYp0JEjguM?=
 =?us-ascii?Q?2O3DxFlzL293QcdVxFbmbwJ+u7tMk5TeAFAX8X73CuVghy6DsxG1NSDXGb1l?=
 =?us-ascii?Q?DceZ6sTzxxTwjVji2aACj4WR4W0OsYWv4PLTjIT93/TDnLCKRUtsH7jDkX8t?=
 =?us-ascii?Q?DODZ7uJvyByDMe59leFiBYRbTaUlwKiFF89RBgt+REBfRbHGknP8ijigItk4?=
 =?us-ascii?Q?bXrVET4q9znDBTybfK1bes3DZ6i/06hF/sShgTp+IDAIdC677hg8+rntXqrD?=
 =?us-ascii?Q?E9mTziLj+JVxum0o2i2A3HJeaeEe1pr6WhUcvSVYbNcHs9A5i1JJZKaEib48?=
 =?us-ascii?Q?xxAzzcZAlRelRyt5TM0MmgC0fJQd6TFCHFtl5D6P42FGsWV1x7iGNyZb0u8T?=
 =?us-ascii?Q?0ekZmNQ8K8bpjabmuvm/t00JZAtoGMkVF1231ecfWj5AMaenXDdDCmcrCJkr?=
 =?us-ascii?Q?rYSpKHFedxSKLvA2TMn3oXhMeIhq0HWOkJNl8MZ+lyL6JaO2q16QFJQvr6/U?=
 =?us-ascii?Q?1GoVvzsa2OSwhqSvZdid7+cdxVRcaCKZ1CfOvF0bH82w3hRnHr0n3J9UhfPb?=
 =?us-ascii?Q?YYw4i31IiY2dOvhs1iak89YRrKROGH0K2m0z650DiYmUXIV0J0TKKoJPV9HF?=
 =?us-ascii?Q?ohP6EiQGxDp50WJmcJisvqLGTM/Qi2sBcdAyPHiwRftL5ZNtXx9iRsxvqaSQ?=
 =?us-ascii?Q?zuvn7zmLEYALD1v7BgDnL3pXFTru2oQEGni9RwJkUK21d9AUy6ADCDDJlPB3?=
 =?us-ascii?Q?KYKOuDnVSdw0JV9u4cAughJ58NsORsi1uZiuwk1A/F74+TUQkWVKCVSwjEBE?=
 =?us-ascii?Q?aOiQL2NDkBImio+gVgdeJoRQw7K4hCRh78O2vAQ/4i6wPZDMp+tICbX22NO7?=
 =?us-ascii?Q?tMfpaCK5eE/g8TbF49qT+XyJ177wpLLuwx8e4UJMbcxQJyMI2Nq8VvhRLzdH?=
 =?us-ascii?Q?YAf3PoeuR6LrnlSAUOanRHW4E1WM4QJZOYuFth+dKcQ0YuKO7eg4SOIFHWNj?=
 =?us-ascii?Q?7js6HQnczT8cFn1crw6rHZwCnOAbUom3WWcI42LPl6tuC4sJOI042NIhNxGc?=
 =?us-ascii?Q?JZTvPLS6K43oj72Lz1VLq+jeTKSHUklNlta1NjAr9pYewcLhHSb13LVSKyiJ?=
 =?us-ascii?Q?Aecn3FtpNrhqYS3okz0FxUh0EkiO7+Vql4KvqErjNF+rcR3lkWroJpc5TktG?=
 =?us-ascii?Q?LjnpFABScH1h3bNT+hfPwUx59bZdK9KEXEBVckl+qVsDHzeC/lftY5Wyw92u?=
 =?us-ascii?Q?2y060Je1LwdGnR9yGzxPtPCv/VTK2xop2vDIQxrdyFRmfNDKosjr?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0595eb-1a73-49c2-f9a0-08deb70297b3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:31:29.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ib6lm5RVwSDNFAkexOp7ny35gzgQpMKERh1kEbLlvM5u7cZGDXMxHMBMTByPKLPTvpMVZnjgharftcbYkcxWtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6817
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10607-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: DDE8A59F7BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow PCI ID match data to pass dw_edma_chip flags into dw_edma_probe().
This keeps per-device policy in the match data instead of open-coding it
in probe().

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index df02b244e748..2f752e8fb999 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -85,6 +85,7 @@ struct dw_edma_pcie_match_data {
 	int (*parse_caps)(struct pci_dev *pdev,
 			  struct dw_edma_pcie_data *pdata, bool *non_ll);
 	unsigned long flags;
+	u32 chip_flags;
 	enum dw_edma_ch_irq_mode default_irq_mode;
 };
 
@@ -455,6 +456,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->dev = dev;
 
 	chip->mf = dma_data->mf;
+	chip->flags = match->chip_flags;
 	chip->default_irq_mode = match->default_irq_mode;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = match->flags & DW_EDMA_PCIE_F_RAW_SLAVE_ADDR ?
-- 
2.51.0


