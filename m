Return-Path: <dmaengine+bounces-7439-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09697C98E6B
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 20:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5E00344D30
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 19:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1148B21CC5A;
	Mon,  1 Dec 2025 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fl13v5iW"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013053.outbound.protection.outlook.com [40.107.162.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232192147F9;
	Mon,  1 Dec 2025 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764618419; cv=fail; b=uS2+WoGLXM2l356+Z4wjofVYND0iAq8u6L0Vo2BDndSv99cwWKcjf/Ptq2M2RiZJOXsaLvE1h9SAZRQcNFK4NR1OGFiJOEq1/3IQtkrDZwYXkaW6xzK/GAGM6QXInA3a5MCtVvwSR4q9uoW5K9bPAuDLdzK9Y2Ibjyt8jfkXbeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764618419; c=relaxed/simple;
	bh=JSJVUw7j2MJyE//Mb/V1tKoYGtG+MLaf2A+MmojbgTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DuGHJlKdoYWCdARi5IHPe8XHQ7j+bB33Hk4H7NJS+rqclzEkWwmIh84gHAOCAoAqEMwnlmssnnmz84WaPCMbJjYEAIo9GdqeyHiffbnN81JRzPycRCAXB0lnBVvxPPhS3POW3CmERQAJOfFyQ0eVvtH0w3xm2L5tKwOo480/yZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fl13v5iW; arc=fail smtp.client-ip=40.107.162.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIvkh5iHUtKdJKNpr2wQg73POLlz4VkzozkXs6WQRT9KK3TT2+TlLct/RFwRSFQ0vuVT80li9WuTKVTVkp/3x4eUzjMEy6ad+EV/ls4AG8WueGR+RUWXOj0teI+OwvatRFitN92D3fB2Y431+YEop4ECnNNAAJ+d9lvEwMyzIZptAWfwEACT0G5VK3o/UcVdzgTM8KX/63SOgt1aopy1dTSaF4utOkoTJhO7FlCgpP+w91C2TYQYarO02BNXjLyjx/cBHM+ZVruHNea7JVongcjJ0egugCguyrSf4gWgtmDHM8Npb+HY9FC4VvgRDtpKtKeWLv7Ee0iEsLbb7G+AQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Acgv88uD6XKidVuw2xklfNfTmEuXVBeELekPEZpp8ug=;
 b=CeGnZ+rDhEjxOq/bhvTwTbDBq8NkpnoqBMZ2/LcXGFw/emZBg9bK3BHe2QNysARcKpmG7mfrw+FVT8m1i0f1YMJXbBP2WjJzt2VtbkxwfAT2+K1AtbZ4IBZyqBtyJ83OH6QbBqmeZHsN86k4FtpWfCgQn/5cn/VPVR+evyWT6Kwb98Am5GIwarWHjj9dwFsnBz+FEuItH85/xKlBDLMeruV7cbH1Y//WkA6MhFH6laXhgexYHe+MTjZBrB+V14AiEo8tSQoakK3VX1VJWJofwwOOCGAZs0BaqSQtFJ1csBHWHhr1xrMH/XgixljZ0Jdo8UPYd6fxO6esoVaXSd/8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Acgv88uD6XKidVuw2xklfNfTmEuXVBeELekPEZpp8ug=;
 b=Fl13v5iWrO4/3ga2AY+dTgWfbFYLnZOSxYoA/0Pc6Em0Otx94QS6mnL8O9bmPjDHkHSYEqiQjLfywWRO5en2a7WlFqKi9L7l98hlbdc+gBh2BmKc1o51RXM5uegNvJprHANgaOv9IPOgEGvOiv9FGLavLHDaHrPgirr4FxX2WoBi2BGzIq5A04aqkwfmDUlqDQMluY6S9p+5lDPFNXKhZ9MMlLbtLsNH+XXmFxmhwyHzXFd6rwLDLMtUz7M72q4iF0zzlFzf60o4UXyFYD8xQ3cXBGzccIv/2tJgNhdzwDYuNaZVFq1Z/2vOm9xezw2UWXPiQjyWO3X66tAZoGFU2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GVXPR04MB11587.eurprd04.prod.outlook.com (2603:10a6:150:2c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:46:52 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:46:52 +0000
Date: Mon, 1 Dec 2025 14:46:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de,
	pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 12/27] damengine: dw-edma: Fix MSI data values for
 multi-vector IMWr interrupts
Message-ID: <aS3wo94XbxTCkm25@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-13-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129160405.2568284-13-den@valinux.co.jp>
X-ClientProxiedBy: PH8P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::23) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GVXPR04MB11587:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eca9677-91c6-4d52-4697-08de31125ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rgadh+h7+fUJeYQrxoOqbRYtga+WJlbAMFMHLZ4+F/4q6Vlx/T+FTaUxPCzo?=
 =?us-ascii?Q?keIGz2lU1DqzbsMD2m0nlpJZ7JF8GUui01L6bJRMjjZko9xkBtHE/hQEYTvk?=
 =?us-ascii?Q?Ede6kbYygz4fzeAvNAgKtcs8MLHNoZxrh/DDzejfoFaU9DgdmbYHkdz4Zrn6?=
 =?us-ascii?Q?sHbewnsV0wF1n8h1Kbt1XCbWl3/SRwQmXhDSF3CzTJyw0JVyzBbS1GbunV3C?=
 =?us-ascii?Q?XTr9IUt8F40EOHiS0mpH/O5JUdg4FZQahFnnxxWPELPTNfdaA7CLNuhMilhZ?=
 =?us-ascii?Q?e0wm9HCefUKHlZSeVkNRtsS8xrF2lC98/AHjQ0vWO5cy9lZu1zWw6o+WxAUC?=
 =?us-ascii?Q?U5VVWpBG7J9g0NN+Sp+CBU3UNZzWiFJjlQgY7NewsXog2UGATbh7UbZp8Bs5?=
 =?us-ascii?Q?vyZJg57xH9rixKWIa5i6ghrxhrxg61H2EBGkXMTwSg8JAmt/17WNzOCNJDFJ?=
 =?us-ascii?Q?ZxT8tX0m47zLLFHdPBdZZZIvhTYimhQF/3LbjGpQjtZpjQJAFD7vlFeQa4r3?=
 =?us-ascii?Q?xjG1OMV1AgbuG/yLQ+Yr6S1tff6bS5V8bcheDlSnf/GwA9l476UBgKYlpMUR?=
 =?us-ascii?Q?ecFTmR8hjw6YKuBPkPCLCtWy1nwavB5d3zI1PsyK192rhdV5bfndqAgem+JJ?=
 =?us-ascii?Q?ZEmYQkHBxCXspH5tPd8ynkiGGYTS/sWYjH3y/dQQDTXYoZeqvCTb/EC/kUww?=
 =?us-ascii?Q?wmOt/vKfbY9l8+g6jC/Up0mGYLW3b45Xsr9fddrD7pKuakn+YA+H1TAPBE3g?=
 =?us-ascii?Q?WrXz4EGxwFpZbM8GS7hcw9FpeiR3DFX5cvpV/yqLWfJaCcZu2clwE9XUl1BO?=
 =?us-ascii?Q?B/Bz0w3TwXm60N5R46U/NEfT3txEQ7LB46btrXuloU0HES0Ahc4XPwYUq5JW?=
 =?us-ascii?Q?sqlmgAIBmh3Pm2Juj+4RRUgLAKf3oF/iEyH61i0CCFgR7/Cz3WYKWnOcwlHF?=
 =?us-ascii?Q?t/7vg01+llhw9tUO/BPI/ufzjp+4XPol/rVzMFvo/GJwX8R5abvLWbbmmmll?=
 =?us-ascii?Q?bnvXUJlH6OJTYWFNydn8+4eJPTKc1g5rSdkspeWZ8zwvc4cctsuWl/j0TuzJ?=
 =?us-ascii?Q?za7ItgoQobncaYQOAmyioM/D4CO79XdLRINsikqiBPhIlxWLukJKfi/ZqWR2?=
 =?us-ascii?Q?UxwH2kSydHT9eweWv7v4QU4E3uxv19fNTLa7e4VP0rB7GDAU4rISwSJb+isR?=
 =?us-ascii?Q?rCX59ywjAyB2GjbTlJyzhkFVq9Q4okNg7I/qY+n0P25+ZVLzE18CZKP/aaR6?=
 =?us-ascii?Q?AlAsO6YP4wUKEYwHeotYEwJ4DebyDGkFNbAtACy65Rxcq3KNO6B8ogwnO7sS?=
 =?us-ascii?Q?PZJhOGbGuoaz+Cve3HkEcg7UYn7yMQj7Ug37ZftCAu3Lo1SNrF8ZkL6BxCLj?=
 =?us-ascii?Q?pHcR5XJwuT+mED9iGHJJRkLSdHp3z57bbK7UHTuVNPmD5CP29xkZP3PMcG+w?=
 =?us-ascii?Q?ont9hCzljjjo65zdU3gu/Sf217DT5kbKpZdWUYGR+Qvk4Kxb3oFievB6eHei?=
 =?us-ascii?Q?FevyvtfLfUttA+h2jRoW0uCUpailBwHXdsM8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mJ5BxqtCPVXCuEdglQkijV2THIHJkgP9qyOYfv+OMT6tZm9t8yJz6F2OFT23?=
 =?us-ascii?Q?1Iud2zj+T5j9e38pX0wvT8vstmqLJl7ZFjseP2mKu7g1dSfMA5pS2asnqXNk?=
 =?us-ascii?Q?YDWoxKxvdwzDHhwpNUdIx95xm8VxAHHYJbQJC1TdLAvQkfWlbpBp9GY+Ddgl?=
 =?us-ascii?Q?PWqt8iv1b2rb+YNoLv52huX9X6blNV8Qna6M1b33mZN/o9JGtAVGp+XeZ3NW?=
 =?us-ascii?Q?TG5ogYcHGA0SFMjVLQaK4OKCcBZkmu0fEiaSLXPTR5QpooBibuS4Yn8J26pD?=
 =?us-ascii?Q?7Uk2P7ktRgO3A3Z1vAl8OjQBjwTyVXEmO76JeULT0BVlHp/lKoeLGV4T/T7R?=
 =?us-ascii?Q?k3alXGuhyBa89JwvxmQ7DAAorA+7hhskkVsq9nwiaFAgO65RaZYsGeHmSBs+?=
 =?us-ascii?Q?3I2ZOI5RioR9npXZghlHP0lJyNDJ/eTtSdsh0DdZuG4RcXJtBuskzRt5/xDG?=
 =?us-ascii?Q?KYmoGgLP429SDVhmrba01qx+ghlYkDJReOA5XQ5/cllExXw+IheMQ3yK8Ay3?=
 =?us-ascii?Q?lP/+8UDTJl/LMZ3vFz1PiU0I9u9dWJumnsBEoT7uCQd9Vz7UbKvc5P4gPbW3?=
 =?us-ascii?Q?De4LWkx9GAWcvTgLRGcL5lQoXQo0/khLnv7LBXv+0xwG2fWmPczmZsMqGYfl?=
 =?us-ascii?Q?SeAUIh6r5M4JneldaEKSymXI7um8KniJrFbeKTqcIG3JM1WeChbacfDXB0KJ?=
 =?us-ascii?Q?nnkR3JRfodvMv3m8jR3HTOX0kyR4IuJaJnyIcJwmyspy7JsebgHyVWG4Sa+U?=
 =?us-ascii?Q?Sc3vS2F8ROsdB+1stHT0gpgzaUZezy7xTdh8okIEmxOCCC51LYP1W5Zy/Yz1?=
 =?us-ascii?Q?UfvRcavQpxHJ7rfrx0optw27IQVFbTpHZMWqh+jdCSE6d/9dDVDuSGA5nE/C?=
 =?us-ascii?Q?JrHe5hlEtiq6YnmeMJZqwWbgtzoZgkzIDM9+GJateSh5zT52M0Se8VMldCCh?=
 =?us-ascii?Q?1M3u865xPAgX6jMv41XGX+hpWiugrQWhGLL1gm1S7c6JDgRC/RvOyxLBDByj?=
 =?us-ascii?Q?1TsFM4DUQXWzBDqoeYJcgF/zZhrog4uhAGCVGMWDQRImDYmz+5h4i0VrSUAK?=
 =?us-ascii?Q?8lnVZcjSETrlM5UIQrMr+HPGJIGeETBnXg5Aaa9axYTPFX7f4LsaEnjTZd1+?=
 =?us-ascii?Q?XKin0zDkZZdpomskCHzuD3987OUrtNCqtHsHmQJuz8KEF65j1cqy8hXS/8CV?=
 =?us-ascii?Q?dfM6sUQwI0v+CerBSouI+vTWt5tIpqQLgBnk464hfsMyfj8Z5R5MKUnkcLsI?=
 =?us-ascii?Q?Glwd/9OYuJYd8XFHUCuvTsx7Lqq4kjq/CKWD+z3KKKM+/DpZVz5Ai8eIY2U3?=
 =?us-ascii?Q?e/0B5I+G0jKwr11SpVIDHJBKcSciZYgTKjD/93/2kzmotlqXTM470Vmd76GN?=
 =?us-ascii?Q?EQoRbYOkfNP5MRscCWYacVTTLznpbKiosOagpPkw/RdtEa4QIOhegOt+EzYT?=
 =?us-ascii?Q?fJDDNasLis6hGIPet4Eprwt8AVP7DWsiswp1x562+wDol6RbSRlJEcnkalQf?=
 =?us-ascii?Q?RQkYeMNncASuec+aaw0DUZJA5YVqfLyo/KKa/Y5NNF4TS5Dc0hHsFJnq67rk?=
 =?us-ascii?Q?k5WAxCiJpf5Cy9oP9xw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eca9677-91c6-4d52-4697-08de31125ff6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:46:52.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6drqcfe+9pN9/MufMWjRkj210PXgbHapM8oUEXdp4Bt3J8H57IBMOezVuBNuomQobUgRUl37sedh0leyJXZVPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11587

On Sun, Nov 30, 2025 at 01:03:50AM +0900, Koichiro Den wrote:
> When multiple MSI vectors are allocated for the DesignWare eDMA, the
> driver currently records the same MSI message for all IRQs by calling
> get_cached_msi_msg() per vector. For multi-vector MSI (as opposed to
> MSI-X), the cached message corresponds to vector 0 and msg.data is
> supposed to be adjusted by the IRQ index.
>
> As a result, all eDMA interrupts share the same MSI data value and the
> interrupt controller cannot distinguish between them.
>
> Introduce dw_edma_compose_msi() to construct the correct MSI message for
> each vector. For MSI-X nothing changes. For multi-vector MSI, derive the
> base IRQ with msi_get_virq(dev, 0) and OR in the per-vector offset into
> msg.data before storing it in dw->irq[i].msi.
>
> This makes each IMWr MSI vector use a unique MSI data value.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 8e5f7defa6b6..3542177a4a8e 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -839,6 +839,28 @@ static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
>  		(*mask)++;
>  }
>
> +static void dw_edma_compose_msi(struct device *dev, int irq, struct msi_msg *out)
> +{
> +	struct msi_desc *desc = irq_get_msi_desc(irq);
> +	struct msi_msg msg;
> +	unsigned int base;
> +
> +	if (!desc)
> +		return;
> +
> +	get_cached_msi_msg(irq, &msg);
> +	if (!desc->pci.msi_attrib.is_msix) {
> +		/*
> +		 * For multi-vector MSI, the cached message corresponds to
> +		 * vector 0. Adjust msg.data by the IRQ index so that each
> +		 * vector gets a unique MSI data value for IMWr Data Register.
> +		 */
> +		base = msi_get_virq(dev, 0);
> +		msg.data |= (irq - base);

why "|=", not "=" here?

Frank

> +	}
> +	*out = msg;
> +}
> +
>  static int dw_edma_irq_request(struct dw_edma *dw,
>  			       u32 *wr_alloc, u32 *rd_alloc)
>  {
> @@ -869,8 +891,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  			return err;
>  		}
>
> -		if (irq_get_msi_desc(irq))
> -			get_cached_msi_msg(irq, &dw->irq[0].msi);
> +		dw_edma_compose_msi(dev, irq, &dw->irq[0].msi);
>
>  		dw->nr_irqs = 1;
>  	} else {
> @@ -896,8 +917,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  			if (err)
>  				goto err_irq_free;
>
> -			if (irq_get_msi_desc(irq))
> -				get_cached_msi_msg(irq, &dw->irq[i].msi);
> +			dw_edma_compose_msi(dev, irq, &dw->irq[i].msi);
>  		}
>
>  		dw->nr_irqs = i;
> --
> 2.48.1
>

