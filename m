Return-Path: <dmaengine+bounces-10267-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM35N0PX/GlvUQAAu9opvQ
	(envelope-from <dmaengine+bounces-10267-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:17:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 743684ED507
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A8AF302A046
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 18:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA303EF643;
	Thu,  7 May 2026 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NsoVNz/C"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010069.outbound.protection.outlook.com [52.101.69.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F197F326942;
	Thu,  7 May 2026 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177853; cv=fail; b=SOcZjg7DirirY4eK/qyBABfZaxn+RY4rUYW6MaxNix/aKeIPbQpWSHvjhSfVWvErBqswcd2g5qsGWja6JbcIPl+WIOHtFBzocXcNkbVCrwuoE84/y8dAEr9GjuQxJvTjSNuR4mg+DEWZkWR7K0oeLgeufZZQ6Kxrcvi4sBEqmig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177853; c=relaxed/simple;
	bh=2WCSb1ndHVjlEJUDROZpbyEpySSbSf3PZR6LdCsUcpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PgZ06+DwuUNsBQAFjLKPj95BNwOftXilE9oMLjfxbFoCiu0vqb0mTRhcxYtRQrkYxefpJTn9XIPylAKW0iANQU8OqqH8J4/LSHRMa951NrWVbTAjz4G7r6L5C35VnThMo6Bg8beLAckRqFJdMeD1F8OkBXu/SPaNA0dwa9KXzA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NsoVNz/C; arc=fail smtp.client-ip=52.101.69.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiUgNGvaQKumtkJ9pxzMn/bIQKAJ56tL6LoELKnr5SAiJwCCezObwOpkJKANaS07qGu0LL5aWeqnKtEKrKHUIeZN6dOmQ4fhQrwuKGa94lGNR9kBV6jMJsBj8sw3GKjKFrx0UkL7B4ctU5otnKgRVBT3zR5El3U9MAOUVNV9usS+fTN6KkJh+oCcTi3HcuzkbxRgT22XoTNq8pHE7eozKBwMiTdaOyvbIpJQ8FZ7p/VKJcOmvbV694bSOm9DZ0/uHC0cgD+NnqdjTRkOVHdtq17ZaFfrX2Gl+9juz9+JN5CeUnoPG87YbpurbHYUPgRAeugjm9k6aEm0Bu6YfWAEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPw9/bu+9M7ZqO8vWoYUrTe0wsaQE3KcKgMQHW1QD3E=;
 b=NOQysYNHJeI0Jes5Vi0QhTLHCJCfxwx/L3Z+c3mS1V3SNeLvmko1l5gie2IAYO7heEQjrGVWCVvmE19iSENOiS0jY0BmLc/7Laf0dGirFQ6hjPQi/9anQghrlZH/C9YvHJfqxMXXYET+gBuvcdHRLlLHQA6wTYqELxUwN+juyv4mJI4Zobeyqtn1qqfeh5VhlBOR2zUF3lzf++2Dj2jKK8yH2bYKZ0gShzntiOHxK13kFEZshjLeQIvvJCH1s6zrIhtaaWMQiT8NblY/dzBGTJeL8w2qY6EA8d2BE2l3BVT7Z5fCQBq3Q9miIJ3IVc1nIlIuk3QbTRQnQ2KX9TDr6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPw9/bu+9M7ZqO8vWoYUrTe0wsaQE3KcKgMQHW1QD3E=;
 b=NsoVNz/C2zz5PemnR9lqaYUcaF3PJ8eeC55A0v6G8GKXcSdkSyWeJ+AnzEhqNDjDBiwg68cfwkNyDfI0aIT6C/QsodxbYBkJbC+PtbAF+gWob8KrnW5NIvdh8KA5QN3ndksQJWQSX0hYT6gldv9lFeIcJO1a2nuYNlThtXnzocjvSUvWK6XevpXKQ3riCXoQfStlo3HttfQIYArUpYwvJf7NdjLAcLa+FkBvQfJL1eRHyjsM7MbMjp1gFYZPcc92sahnifpz6M2Dp30Y1t1YqgTZfyECXeupQsQwWEjOQft1gnEAmTqsUfFCdIwJYDryqiPG0ZrRYaeGWmZdW0xzcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB10156.eurprd04.prod.outlook.com (2603:10a6:150:1ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 18:17:26 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 18:17:26 +0000
Date: Thu, 7 May 2026 14:17:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Guodong Xu <guodong@riscstar.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dmaengine: mmp_pdma: support variable extended
 DRCMR base
Message-ID: <afzXLe_ny4xemZKW@lizhi-Precision-Tower-5810>
References: <20260507-k3-pdma-v5-0-6b9743038026@linux.spacemit.com>
 <20260507-k3-pdma-v5-2-6b9743038026@linux.spacemit.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507-k3-pdma-v5-2-6b9743038026@linux.spacemit.com>
X-ClientProxiedBy: PH8PR15CA0002.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::29) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB10156:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a29c3eb-a9ab-4253-80d5-08deac64e453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|7416014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ke79/arKivW6K9qntjtJ+YixOCgIP9ZQ9SwfXoonG2okNhmsS6iqaYsfxmxZ51qSfQM1L8Oe5WZXDZnjhykrM19n53juUMYEIubdRcmaANbhieQkiN2wLwHTZ9Zlf4ojB2SXNnNHpQ3g2nCqxZgvf1Vv7ZLs2vv5DDSodhQDfcBHZjhMYqfUkXtptCFfGKPbo2Wg/MacZrFUzJ8c433WIrBlaxV9eYwmCy/PcD7CLkjtUYIEgwFMUhy8ESsFfZQJ2o2sBwNasLn4r5arsV3AVuSI7NLkdJb5E5dl/jSkmQoGclb7fgg+8JMRHRpid01uLhRv5axnjHmkG4/WNAJ9uVV6zIN4sUJ4ZgTJu/k05lQf7dYKhHZiMSyRc8CEiXMXPDkY05m0piyfRhtnEs2Q6TBD+9uqy+KFl54gOWHynpTFullbI/a+fYcffdDH/uCsHXpUEPsz3EHmK9X5qenF/5Dcq0f7G25TUA460vpFPxHA3js5Mk9ayalGz2VQdx75fYBpY8PnkC8107SuI5Pwjnv0uNircG+/nikHL6Crpsv01asNmvOm2lWYvNkYh1N9bTVJxRR1ubHlElmO9oI6zdvd7PlRyTmmEXKWZMcAfrUCbeQhvnw3l1SygvFfy0U/4ZNBSGH6EWumKtatUYA4b/4NZq2GFhJoc5GY+n/YrHQxOWbgd7SysFy005mQsP/lw+TtIYNpn7UQiQEsE0r8NxKIvaRgyq1/2SdIt07MS5PoHLW2ZGxj4RA3XM87vog1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7416014)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?keQA6UqZpqiAcuKwQATuB1iaC5noQRYIrmHtGyGVIX4W53xQnILh6tNolyet?=
 =?us-ascii?Q?dHCggcDRju7asIfbQiO6+ksyJeGPrNszBE15osr+maslr0HA0RMJXq0zBmHu?=
 =?us-ascii?Q?eOQh/Bg3nwnh06NX1e41G1Z9WiOvpZ+3SQImrTSGKIes0scktWRvsm5xqlvE?=
 =?us-ascii?Q?fgc1uwSMBTYsm6GhnJgUFt2/0s9rN9qZGn/CKcuUvWhJ0y53YLwmIf8npPZP?=
 =?us-ascii?Q?NZjEhVyoq0Hdj3l/QHZVQ6sDIokgxPqAwTdKGRjFiUa99lueG7/wwhgGCRba?=
 =?us-ascii?Q?oBNLAMrU3XWipkkdT7KHkqS5lReh0lo+APOmAQanXiJRvv0M8JF8vHvS/s3D?=
 =?us-ascii?Q?z1/tKnVrlMVdirrai27VDT7Xy1ccwkMZBG1twUJJmdKaqp1qofwVhSulPfa+?=
 =?us-ascii?Q?A0MVi8uwz/gI3fGHk39aK3cL5+hpXIxZMU/I2Tg76FW//oxIZArEFgmjhHtJ?=
 =?us-ascii?Q?1JbTu4jFl9SaMO9dstT2ithcLBlHy3b4IS42znnT9CwuxxryB3Y2i6bSbRvs?=
 =?us-ascii?Q?YCFY2EcvyXhVgkxUV4GMfGq99TcryFJXshmtqhnVlYxjjrd4Z8D4G1FCROsL?=
 =?us-ascii?Q?tNWuyuOnQepd12i2h++K+glsBSgUekUPcodlvLkPPVePrdgOFGQReAnNTX0J?=
 =?us-ascii?Q?hAF3F1kjVec0xtcptWErIdK/tB8yxkgBwscD/SGBd+bfxsAaWYu7HdXg5cd2?=
 =?us-ascii?Q?40Xfja2VLGjEY+Fde7vtncE4j/IaMTpdk67ENnoTKH9Jg2cC4NrOgwQVOC45?=
 =?us-ascii?Q?wB/7FGMORjskQ/K2v2Ou/aVNjcrQoqwBK7I5fXJ3QAkZzUzDsYLpg01pRrJg?=
 =?us-ascii?Q?Yud7JphSkYx1X9hu8vsUawcsZ4X0FhjdDqfKSnRwOYSmzwXX1VWXjwuaY2n+?=
 =?us-ascii?Q?vmjJhHJAvIPlrkoVpvx5Dr8dIjsRX9GfGG2XZ9+Y0rC7gyeRRDMVOciLBUzL?=
 =?us-ascii?Q?1g1e+YN/2rmc7pEx/1S9aM5/kIZRBMCjrrwyDitz3sSd/4Bj59OpZci1bheR?=
 =?us-ascii?Q?dP74XpldZGB1dqvchSAlaHNK1/s67m32U7Buv0RwiNlG4bAvU8uQr2mJyGzF?=
 =?us-ascii?Q?ljAuNWEyP+QThr8M3q9HrJ+SPtYabrng1Bz8SYfAoPxGtbi/V9lyMcnCl2Rx?=
 =?us-ascii?Q?lpxeTPCX9obSid+gxuDzvlVX1PzW0ZBbctzRfJDrwmuF3u3dom+2P+xFD4e1?=
 =?us-ascii?Q?PrML9wJVzsfxrrqbEHuDGgCqf2S9eiq7wLNBAguVSzXdKMg9OSCVMCO14YBP?=
 =?us-ascii?Q?4VBvXUEc/kOta1+mG9sMUbShwiEISW1Ss8ELYifZt+2Pe3T52paTim0Z5Rjq?=
 =?us-ascii?Q?3oEPn4/e6LJzpk1DXREkgaaPsb0UREp1i+T7IGzz4xpy8amnNDe+Uldb6dwB?=
 =?us-ascii?Q?RkrAwSBEkRuLCPXDR6Sosss4gyJhyV1uwkvHlxk7ln4j5lDcXMnwUew1RKkh?=
 =?us-ascii?Q?4R/wMdoiAMUANoltIhKAngdisYyO6jbv4kICqtzCa8bQEVQSo/LJzTbhdTnC?=
 =?us-ascii?Q?aAKrz7refVjR0urMeUDfofr1ssfkaqiGWWbylrxEGfafZXqlKkXXtym90peH?=
 =?us-ascii?Q?BkLe0sZSX6zsvM+s4kcVRQhalsrdJS5suXcZDKzulNHBfRmaOI++CWn/orQT?=
 =?us-ascii?Q?c0l0mtoatkmqp7O83laG9BwU0ic3G54vO6NyL8xY8l5CTnbNuo4OJ2oyc/IJ?=
 =?us-ascii?Q?JAHTTfxKBa+lC71zG12W3b7fSb33ZVlXrCSINf795ZQAFuJB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a29c3eb-a9ab-4253-80d5-08deac64e453
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:17:26.3683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGKqCdPx2o3L6CyOZ9wPqYyHU9LRPLTDBFk5fabQIJTQ9BQWHpwv1bsxb04ixvujD9NMJ0G1MBAWYLuJUj+MNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10156
X-Rspamd-Queue-Id: 743684ED507
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10267-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[riscstar.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 06:36:21PM +0800, Troy Mitchell wrote:
> From: Guodong Xu <guodong@riscstar.com>
>
> DRCMR base address for extended DMA request numbers (which means bigger
> or equal to 64) varies in different PMDA hardware implementation.
>
> One such different PDMA implementation is found in SpacemiT's K3. In
> this patch is for preparation the adding of K3 PDMA support.

Avoid use words "this patch", just

This patch should actaully prepare to support variable extended DRCMR base.

Correct descript this patch looks like

dmaengine: mmp_pdma: refactor DRCMR access with helper function

Refactor the DRCMR macro into mmp_pdma_get_drcmr() to support variable
extended DRCMR bases, such as K3 PDMA.

Frank
>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  drivers/dma/mmp_pdma.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> index d12e729ee12c..6112369006ee 100644
> --- a/drivers/dma/mmp_pdma.c
> +++ b/drivers/dma/mmp_pdma.c
> @@ -51,7 +51,9 @@
>  #define DCSR_CMPST	BIT(10)	/* The Descriptor Compare Status */
>  #define DCSR_EORINTR	BIT(9)	/* The end of Receive */
>
> -#define DRCMR(n)	((((n) < 64) ? 0x0100 : 0x1100) + (((n) & 0x3f) << 2))
> +#define DRCMR_BASE		0x0100
> +#define DRCMR_EXT_BASE_DEFAULT	0x1100
> +#define DRCMR_REQ_LIMIT		64
>  #define DRCMR_MAPVLD	BIT(7)	/* Map Valid (read / write) */
>  #define DRCMR_CHLNUM	0x1f	/* mask for Channel Number (read / write) */
>
> @@ -154,6 +156,7 @@ struct mmp_pdma_phy {
>   * @run_bits:   Control bits in DCSR register for channel start/stop
>   * @dma_width:  DMA addressing width in bits (32 or 64). Determines the
>   *              DMA mask capability of the controller hardware.
> + * @drcmr_ext_base: Base DRCMR address for extended requests
>   */
>  struct mmp_pdma_ops {
>  	/* Hardware Register Operations */
> @@ -174,6 +177,7 @@ struct mmp_pdma_ops {
>  	/* Controller Configuration */
>  	u32 run_bits;
>  	u32 dma_width;
> +	u32 drcmr_ext_base;
>  };
>
>  struct mmp_pdma_device {
> @@ -195,6 +199,13 @@ struct mmp_pdma_device {
>  #define to_mmp_pdma_dev(dmadev)					\
>  	container_of(dmadev, struct mmp_pdma_device, device)
>
> +static u32 mmp_pdma_get_drcmr(struct mmp_pdma_device *pdev, u32 drcmr)
> +{
> +	if (drcmr < DRCMR_REQ_LIMIT)
> +		return DRCMR_BASE + (drcmr << 2);
> +	return pdev->ops->drcmr_ext_base + ((drcmr - DRCMR_REQ_LIMIT) << 2);
> +}
> +
>  /* For 32-bit PDMA */
>  static void write_next_addr_32(struct mmp_pdma_phy *phy, dma_addr_t addr)
>  {
> @@ -301,7 +312,7 @@ static void enable_chan(struct mmp_pdma_phy *phy)
>
>  	pdev = to_mmp_pdma_dev(phy->vchan->chan.device);
>
> -	reg = DRCMR(phy->vchan->drcmr);
> +	reg = mmp_pdma_get_drcmr(pdev, phy->vchan->drcmr);
>  	writel(DRCMR_MAPVLD | phy->idx, phy->base + reg);
>
>  	dalgn = readl(phy->base + DALGN);
> @@ -437,7 +448,7 @@ static void mmp_pdma_free_phy(struct mmp_pdma_chan *pchan)
>  		return;
>
>  	/* clear the channel mapping in DRCMR */
> -	reg = DRCMR(pchan->drcmr);
> +	reg = mmp_pdma_get_drcmr(pdev, pchan->drcmr);
>  	writel(0, pchan->phy->base + reg);
>
>  	spin_lock_irqsave(&pdev->phy_lock, flags);
> @@ -1179,6 +1190,7 @@ static const struct mmp_pdma_ops marvell_pdma_v1_ops = {
>  	.get_desc_dst_addr = get_desc_dst_addr_32,
>  	.run_bits = (DCSR_RUN),
>  	.dma_width = 32,
> +	.drcmr_ext_base = DRCMR_EXT_BASE_DEFAULT,
>  };
>
>  static const struct mmp_pdma_ops spacemit_k1_pdma_ops = {
> @@ -1192,6 +1204,7 @@ static const struct mmp_pdma_ops spacemit_k1_pdma_ops = {
>  	.get_desc_dst_addr = get_desc_dst_addr_64,
>  	.run_bits = (DCSR_RUN | DCSR_LPAEEN),
>  	.dma_width = 64,
> +	.drcmr_ext_base = DRCMR_EXT_BASE_DEFAULT,
>  };
>
>  static const struct of_device_id mmp_pdma_dt_ids[] = {
>
> --
> 2.54.0
>

