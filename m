Return-Path: <dmaengine+bounces-7766-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F692CC8740
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FA51316AAB7
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5567B34DCCF;
	Wed, 17 Dec 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="A5B/rdQM"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011052.outbound.protection.outlook.com [40.107.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831EA34D3A9;
	Wed, 17 Dec 2025 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984601; cv=fail; b=oCvSpTCRKofnDOfo0fwdW5YD7VrTZvPJIifxQw/E2SwqIL2GV5BWUbpZoxerUaKjCr37RirNHQ0Q/hLZsqpD7NnEGfVuAKIa5tMROLG3WACAUIwv8QbHDBW5rAU2GXjXuSOG7QZpdv0lHOORDTPWXdaVeex/p6kka5GZlNg5pa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984601; c=relaxed/simple;
	bh=skyMRfeWpTo6BZzeY0XkFGD46Rk9WDSgpYO86pi8AjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=klOUSicZrrkTezctCzYdBJdqfk1j0BA2zj2QVCyXUR0DMu9xxvx0UsGqgbBwjT4g5baNnqr4v8NssWNOTd7jHgkeM3za769UYgAwz8D2ZEvRNjXmvfRoIKIxh5vWYSgNDKyzfFBUeslQcTc+NPB628EO2OcU5hjKlqRd+tbQsd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=A5B/rdQM; arc=fail smtp.client-ip=40.107.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTBCPAUqqlRmVbWUPK9nAw+BJ0HlEQ6YojPTFXd+9Bvytw6z+M7VkMHqa0S3TqzbtUrBi85Y/ogMBlQEk6iMcaA8ZQWNZB7w7UTMV0vvj74o0KGIX2k4tHT10utLImS4jlgq6u1/aWZli4e9PYb2UHEkrMWFAU+DQ55CtJjfVetKQilGRr6x87P0lAZ99iDOLHVs3de719VTRMhkDUtmA4tGiSFWJgaYvlyK5v0t55rvVb3XiN6N7G1jcRSwIkcdqX4ukhRltWZMBZt045XwRZLVmpsszbIJvr2uIBSVfIwZPC0vFf8tzi+vuIfp3IcPVx5m61YIZxQT0rJ87i3naw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeZARrfypgx4Jd1FbPoPvm8MGHmkk8Jg//fU5qtO/II=;
 b=lOsoM3GjzuMlY90MnLAVA1tdUaJCNn3ozkKQwew1FByZWuvlIf+1zZYFcZMjXxG/bGob3hKtzOMPDiWZ7zS4w7o0od3SBXo7n64g502M1FvFh+27MP81iTCboSHa44Dx/n1zEoddy/ZDBeGKEUT9ydkg5Kxng20S8ciz/Ud5VQmaz2pTvfctsslvJpjgJvs+PtUYOv7bmgpv95GqRxXdyA8KdkY9lb382lTMAPr4YMoBxOzsNUtL7ZQmh/6IHYg27zxRMeOcRs9qHa7zPGtril6aWachYMtH1nGJ0NBv3Br46O45mWjiVzjEHCj6c6VEfp24El86/38db3MRJB3VrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeZARrfypgx4Jd1FbPoPvm8MGHmkk8Jg//fU5qtO/II=;
 b=A5B/rdQMP7sjF0mPgaLXJOaWMoYaSoxoCqeX8qdz4wuxRb3wMkU3Q7oxbDSt/Kn1llM1+BL9iJ+0QFJye9S0/8H1u80j9Cpo6RKwrVkBJIt6cJ2rbUOjdJ9PvlOphsCgjX3jMLg0URU/Cqfo6CAS7O83UpMWUtaiqRtQmFqHkN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:22 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:22 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 10/35] dmaengine: dw-edma: Fix MSI data values for multi-vector IMWr interrupts
Date: Thu, 18 Dec 2025 00:15:44 +0900
Message-ID: <20251217151609.3162665-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0251.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::20) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a6e9f2-f851-4e14-2211-08de3d7f3ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xpd1BkPF2m5gVpDfHUR3EbG9wtMtJ78pao3ehLp+h1IwvUFMKGcLGaW7n6py?=
 =?us-ascii?Q?0PSAS3zsAiMEA1uFKRpla3qFtclqotkm4PTV02JLjuyRUiNpqrb9wuZVD0DB?=
 =?us-ascii?Q?q0T5OGOjgjhYgbnGUhEhR0z8Q2wTLf3JXipAupRZHZjqmcMzzclLBTr/xMU4?=
 =?us-ascii?Q?ilN7tTAIdKuTU0hgNVkA7fWukGvMx7P5iy1feX749UQUoRLVq9GV80C7ZTQv?=
 =?us-ascii?Q?HKWcvRfHrE866UIhWDnbn4nVqeK0aza3p1v1bHc9SvQ4D+8/a+RNDQB2Vvs3?=
 =?us-ascii?Q?puTdmWH3xs4gSONu4V4rEgUSmMdKQDHaOuo3iDBNDuHjOq918tSx08iihkYe?=
 =?us-ascii?Q?k6UD+R3yOEZ3c+FgVKTrdPbJXVT5eXEORtuIEGelxMYH68LprMgP8qFw5DH0?=
 =?us-ascii?Q?RC7PNLp6WQZnztVlCmES071soagnH19B29fkNSpCa2+PS+lF06ATO0LImLP1?=
 =?us-ascii?Q?4LSiBWJZZ0GhcRgM09jqo3E3JML3YAiBkE+7a4O7Pbfr02YwGNz8FH+4tWgA?=
 =?us-ascii?Q?uIqxL0CNYgvJWQjCrvdhs9Rje+ciZanjLV1kMFNL9sVzY6ZkfdGpHBTMGk83?=
 =?us-ascii?Q?6vGbQch0Bd1t8hDgg2DrFA+oKhF+BBdM/kKQhnYvLENge252g6rkluAH5Anv?=
 =?us-ascii?Q?+/ld2IzXQLhUyRLhoOEyAPNFIApvYnhFDY2ZE+sqnW/pGdvjn1/9JLk5ilcU?=
 =?us-ascii?Q?uIQShu/Dxt/NtW2jJMgSbNR9f1F/lPOyIokGXXELRJe1oxZ7rjslmOViwUSj?=
 =?us-ascii?Q?URfpI9Rbj+3fgyUdZ2p061mkMWOjbUPIxVVzcxd17vIwi/bxHyYi1GERQ1Dc?=
 =?us-ascii?Q?LFWlNiv+IOlRVaQO3wGGcuLUmSEJnzlUmaqUcnWearNp7r/YsOQhEn/Zw5sZ?=
 =?us-ascii?Q?3UqrWTAzLhHqWPmoEH9GYo/RF43JkGMZmxcSDZFEMoSSvFcKk4Z9qUeVfxpi?=
 =?us-ascii?Q?j4SVo1ke8dxg3C/XbuuEj9TdG0T3YwKSP/PG9NZqqx/jrodWyySasMFvZqMr?=
 =?us-ascii?Q?s1098cSJiH+1KnN2wBxQxXcNh2qVyyIDZQXKnXqO8qbgLVnXXdJ7yMgTiW94?=
 =?us-ascii?Q?zTjxnDRK3CUup/LIQcwb27QsbiNjb8coWVdYXCMXOu5j3sAPqErXkmNuP/k2?=
 =?us-ascii?Q?+syoabH96b7GpTT9zDTQBdKu/F97dui1BUtLjDJHv8ZpJkZP3qCagoyEFK1c?=
 =?us-ascii?Q?BEeoUB7uFbVyP3jZyEL7786EdrgIpDFkV/E1D4GtHAg3Mdm5hDGrcuQCF3hS?=
 =?us-ascii?Q?ccEo4+AASbt/JSXUTE+AJ1aAOoX4+RtlBHQt/kdgdOGiAEkyDBRzJ47RjsLt?=
 =?us-ascii?Q?kzukxHXtA6Q8FaswDxgZaPG8RnavlvIBmsGmuuOf548GSJlToRHjHG8TTw4F?=
 =?us-ascii?Q?uU/lbVg0hDOrMxt3ci306ehMaS8FdHRL93YKXmKgiWvTsgBN837HrQov1QoY?=
 =?us-ascii?Q?Di9HuqtF9WM3zAKev5dePdtWr3rx0MH+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kHtYGRrLsjiLr6jlrwfeaVJRM/dKfVQfX8hq4Mmj83rLuMJoVfMSa3hURlO0?=
 =?us-ascii?Q?jdqFvPlOjz/Q/+yr5VYwRkKvsnW8Nm2M9TLslg76ACCROdZYxauY9BHmwFfE?=
 =?us-ascii?Q?oQHJsSMd3RmOW55wIq7dqZzab9OaZgqKtxQPm3Hf42rTHsVUn5NPIxAep6lR?=
 =?us-ascii?Q?tptFOeFaH0mayiD+/PiOo0GeNLmpGecpL5NDrR1VKJt0X2WSp1+YvO+RRDi9?=
 =?us-ascii?Q?tMC7PP8Tx/0Ef67POo2FwcKX0tg9ciyu+99SXJbWWBQROh6+sQq2jxiq4bSf?=
 =?us-ascii?Q?VRpqsngT3rmKYfc87t76AcVq/s8Hkqm2a2HVNCuXNpYo4l2geU9V6u4wNIVw?=
 =?us-ascii?Q?dT2c79SrEUKdwQFtVqH3k8V4TR6cuttW0WywJYh/AklX4UIsimxrSqlmzXEp?=
 =?us-ascii?Q?PClU1Qu5VdOUuQmhHVxi0o2CfKwUNQmYNilGWrV8KWsyo3R52SXLzcaY0q9e?=
 =?us-ascii?Q?Jv0sFmcCUhZB8rq0gnRtM7nktyi0HMl2JBIV4LzzKCSrUP93TD5aoPTbLZZh?=
 =?us-ascii?Q?Z4fgXRmQNkjGD7jPHyfDXBpglLdjxCFxj/4rldkPnt49lSchNHqfqJhdKOL4?=
 =?us-ascii?Q?GR/bdRHBucdEdMGuVaAcvYwmS72lxvkhYJ6Hdf5djMNBgfhDijqsvU6AylpT?=
 =?us-ascii?Q?o0f4s7HrACMg5nGpWhXoBV8x5mme6TH3vCX46r7KNTA6MMIAcxRDF4u7e5xH?=
 =?us-ascii?Q?RyT+6CXKoQP2UlfvBOTnXXs8jXF70kSNeigYqenXuoSM2ElvShOWqQnm9V8z?=
 =?us-ascii?Q?2cwSTh+3pllhB7Xcp6YeP1GRls7NtHZPUZHm1hxw2Fjlvg5mnhQhQ+WTnCwv?=
 =?us-ascii?Q?fk47cYWG7SWdMWnSaq4T0TnDpO6afd1+O12dQ3kTs8JEr9xWh+GL53fmpW++?=
 =?us-ascii?Q?QPJbNwTi2Eeu7LP5ByV0UGS1JmhH+txFCrU8k+qVE2WqzAtlxtMh8Rzkhcg/?=
 =?us-ascii?Q?NdMDeLfKzG0QIXge6T8Ra52gtExHMWPdF3rEEfgNo0KodDjJHvqylDxxhiCl?=
 =?us-ascii?Q?JsXZEmUbj9xMqdhFFO5FXt3SfU0GuqWPxagqXUW0HGMhOnfFmUa2TW98tRvw?=
 =?us-ascii?Q?Mjxrx/PEfXyVWPRIdOyPyXb45TaHo/oBpeMkF/bUyP403l770YfI7i+CM4tq?=
 =?us-ascii?Q?eD9mrHErV6OUfkfMvTD/nnk0V14uRZEMwl3Pu8iWPGCNKZl++yaFsA9Sbljt?=
 =?us-ascii?Q?BWDM6of9GUfAbzdc0rVTLVvV2+haGLu9teZ+Qpmuk/IiGv8rSlQAbSsYlcWz?=
 =?us-ascii?Q?f8LSLYryKE9yUd9AhsqDxkiodCH5338aEOULn/fPMnI2CpNNL/57RYXKWsK4?=
 =?us-ascii?Q?zs26u30MuKRdq52tLwzF+i30Dq4PONYCQWbPMkoEPowMwSUpnL1mw6ToJ+zN?=
 =?us-ascii?Q?vc6Scx89yew+OYrZX9m2WLOm0+382MTjgsBCrMCF4uSdcpzxdxss2Er51i1i?=
 =?us-ascii?Q?MX/hMoazmJTzAWiF1xto88MNSwooQ/TyWBXqexzKe2sxMlWQ8G0h2FbPrwva?=
 =?us-ascii?Q?otu7wN/iDeyGmk1eWZ7TI6B82vQQLEHnDeYkKUJrAU7ge2jJ79tP1wOf7hYb?=
 =?us-ascii?Q?MblGks/JtkphTnpLj/LHbgt4W98bYY04VMQEazfXwdDcE9UzDWj7qJeVTVxq?=
 =?us-ascii?Q?qSZKmZTM6UoQ4+q3favry0Q=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a6e9f2-f851-4e14-2211-08de3d7f3ca0
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:22.1194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fx1PDO60d02lwUeeKRd+Q9AHLnZeRt5lkHcNkDiQIdqFTdrcoEJLjfHXU6fcoCWwv+LHc9kl+UFad2jHnhimg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633

When multiple MSI vectors are allocated for the DesignWare eDMA, the
driver currently records the same MSI message for all IRQs by calling
get_cached_msi_msg() per vector. For multi-vector MSI (as opposed to
MSI-X), the cached message corresponds to vector 0 and msg.data is
supposed to be adjusted by the vector index.

As a result, all eDMA interrupts share the same MSI data value and the
interrupt controller cannot distinguish between them.

Introduce dw_edma_compose_msi() to construct the correct MSI message for
each vector. For MSI-X nothing changes. For multi-vector MSI, derive the
base IRQ with msi_get_virq(dev, 0) and apply the per-vector offset to
msg.data before storing it in dw->irq[i].msi.

This makes each IMWr MSI vector use a unique MSI data value.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 744c60ec9641..1b935da65d05 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -855,6 +855,28 @@ static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
 		(*mask)++;
 }
 
+static void dw_edma_compose_msi(struct device *dev, int irq, struct msi_msg *out)
+{
+	struct msi_desc *desc = irq_get_msi_desc(irq);
+	struct msi_msg msg;
+	unsigned int base;
+
+	if (!desc)
+		return;
+
+	get_cached_msi_msg(irq, &msg);
+	if (!desc->pci.msi_attrib.is_msix) {
+		/*
+		 * For multi-vector MSI, the cached message corresponds to
+		 * vector 0. Adjust msg.data by the IRQ index so that each
+		 * vector gets a unique MSI data value for IMWr Data Register.
+		 */
+		base = msi_get_virq(dev, 0);
+		msg.data |= (irq - base);
+	}
+	*out = msg;
+}
+
 static int dw_edma_irq_request(struct dw_edma *dw,
 			       u32 *wr_alloc, u32 *rd_alloc)
 {
@@ -885,8 +907,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 			return err;
 		}
 
-		if (irq_get_msi_desc(irq))
-			get_cached_msi_msg(irq, &dw->irq[0].msi);
+		dw_edma_compose_msi(dev, irq, &dw->irq[0].msi);
 
 		dw->nr_irqs = 1;
 	} else {
@@ -912,8 +933,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 			if (err)
 				goto err_irq_free;
 
-			if (irq_get_msi_desc(irq))
-				get_cached_msi_msg(irq, &dw->irq[i].msi);
+			dw_edma_compose_msi(dev, irq, &dw->irq[i].msi);
 		}
 
 		dw->nr_irqs = i;
-- 
2.51.0


