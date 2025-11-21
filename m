Return-Path: <dmaengine+bounces-7273-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F521C7728B
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 04:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1277C4E78C9
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 03:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4683F283FC3;
	Fri, 21 Nov 2025 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZyR8nkL/"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FCC286409;
	Fri, 21 Nov 2025 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763695445; cv=fail; b=ZyLNhRh++RVvSNnlJy9baIBBvjmFwthaGwEKbN8+F2UP3KD3gh+fjW65qKTMKXOUQH+bNbibI91CtnvfHjQf3DDPx67PrtYRJGzf/liKSlUGQ7OsQ+Th/gsNIU26zbyrlwmLO/a8h3HgZuEktm4XyLokeEEL3hGfBCrSgT0s8ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763695445; c=relaxed/simple;
	bh=PO3/gXOe8p3o4jRecQo1HKFJrtZjy951Aeb3olBBUx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PgclQsmA4KqWMPnAa+03oASx5gzlN+cCbd/bhGp0xTloSJ4r3sfBJpVCYqcPgFnT0UxLRUotRr870wjk56pozUCeM7B9NcCliQlLcgu3jeI1KjYfnAcMK8Y599ZHCzTsmCt9tKTbC0ixcF3pXaYf2DLkai7vVwi8mKPeTpwVazk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZyR8nkL/; arc=fail smtp.client-ip=52.101.69.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bnm0MuR0HION2UoyrUSgbohGggeoQSVWt5drcEJIGhV9ltR3ocDYEkvaxv3hlY+DOG+LPEaHyH0ykRBP6uJBfnH0Dd6exZAntsUA6XalbMazWP7O2Xx+FxEywHKBbaTfSTBYm/DzSc6ZjGfMKSUzK/NSUtM+ADS/wJxbxfdy7Q0CMzGyoifAcJO8a82JLMbpGssFkspFmJarm9lttQ9S5VVV90XXTy65rIKoPxxfi6YBlIrxjh33Y5hmxc3291WUGC83UKd57T8emCNZRNYtZH8fYBFycjimbj+Hqt8uPb6m9/mdKvn/+E4PMDuQ+UgNGxbfduyGuhmnlyb4lPFJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNQfpHNMemRbkBo/EOHZRI8HnYRo0hR54F2aKpX0+bg=;
 b=VFmWg5yNOrLIzU3KTKpFkRsLRPrZX4QkzFl7xYZH//83Htm+HysdM5aCS3k+BdfDo9FkDi0acVS45q9mzpSBmJHAkCI9SbT0T1QmagQvEclvq37mVjogaOUofRnVdjMQsdTY7QqWIP9qDFZzS+F9Ow0s1xZwtrxWM8TtRmF4CrfKP8jIM3p5jnqHPfLe24b2HCMaNoA1C+eCz96u/LthxCEu1rbtfYQsJz85RcDHs2LV1WAxEkL4bWwoNIUJF7TEPLyOiJtQW/yvXstR0TYk656M+x/vVKRxlLwWNXPl009EVqTY1NPQKUH11DhNouloq/UHebYl+SH6vvQq/7rzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNQfpHNMemRbkBo/EOHZRI8HnYRo0hR54F2aKpX0+bg=;
 b=ZyR8nkL/Y5lpmTQD8kCDwjRyvtutxvcwnlpTqvDGUizISIE9SdRAhaFw1bxJGOLVJRFgcDhMYLK9N8fU3LXf7FG2BkJnIR+30rbOgsc8vggrkoQkcDiypKiOFqZu5t5AdPRPWAi9ViJkXOyROmAnIN7I5xm18awauznkX01aE43G/xZWq+c3q6jWbLiVBG2KCDR2ygf7XgvS5GvNPr70jkhnNslF6M9FUB2asGGuCUavithUXwc6Ps3ioMHrbmjFvzuFTycXcjvv8nibOc954ZIGxoA+g/R8wjv8eFfRqe3FLKLQLcAGFhpUtKikX9eamUBauoZWyvF0AvLAuCIcwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VI0PR04MB10592.eurprd04.prod.outlook.com (2603:10a6:800:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 03:24:00 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 03:24:00 +0000
Date: Thu, 20 Nov 2025 22:23:54 -0500
From: Frank Li <Frank.li@nxp.com>
To: Johan Hovold <johan@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] dmaengine: fsl-qdma: drop unused module alias
Message-ID: <aR/bSvuiR2hHI4Dv@lizhi-Precision-Tower-5810>
References: <20251120114524.8431-1-johan@kernel.org>
 <20251120114524.8431-5-johan@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120114524.8431-5-johan@kernel.org>
X-ClientProxiedBy: PH3PEPF000040A3.namprd05.prod.outlook.com
 (2603:10b6:518:1::57) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VI0PR04MB10592:EE_
X-MS-Office365-Filtering-Correlation-Id: cba360f4-1dbb-4f68-9cde-08de28ad69d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5IO+5k4kgQKXX6OZSaJ3+ebRrgK8KSUKZdl9SQjfwNJy/MEmFALig1CKdjke?=
 =?us-ascii?Q?Cswdm6m3pAmhHLbcKjZvvKkr9hzxTBbnk8skXzvbpzCJdx6kW6HbGY3DMdYD?=
 =?us-ascii?Q?BiCdI5fHyOvjIrUD610q8UwEfmnjyKCO+PLjTyOu7OlolaosewJ+bAqqD8Ix?=
 =?us-ascii?Q?+DBrYUwjP6DvJzxab+RvK283d+hlxhn4TTrXdR+ZEP+OjRZwHwyglhsJ7/A/?=
 =?us-ascii?Q?wwTLsU1iYT8PvMQnibnHvYHx+DKyZ+wUGeC60NoWNFb4NhjNn67lEqvuweHs?=
 =?us-ascii?Q?zvXe1e85y4ShZvrhiPyT0eW4CernhVqu4bgiileXCsH38dAEnh8dJUSydgQC?=
 =?us-ascii?Q?L8DzgaHELgbqFrAv2Aqw7AMEg1K91ZWHaRCEnbT21dNjyPm7ey+snWp8+hk/?=
 =?us-ascii?Q?my/1Dek0vZgZwsL4KEh+r41dIqmRPExBzHGdrhVegJL9UuFVjydMtwghpo+3?=
 =?us-ascii?Q?gbyFXGBehvtkgCTF9Bk3bNfnLeim+TxajpFNMa6XLPwntLuc+5ZVBl5Z6y65?=
 =?us-ascii?Q?xFMfHbioldusD4u+o1U8R7yw/HMtfjvzGI9eo6v8qKdaVzKVnUT3CjQ9IxaZ?=
 =?us-ascii?Q?PnOG7W+8SkXyp+IXa1GCrSpTDy0LjL4ISveQMFPutp4zaL8WTL37lUVPyW0E?=
 =?us-ascii?Q?jCAPOB2/AKwa1SsEUue6nJro1d95VxtHmctgcREAP7unflgoDRBudQq1vQyv?=
 =?us-ascii?Q?/aMaA7g2QZtkfrPT2gIAJkIUvAshaiSKuk1znpqEPlWvu5SxrO+W2sZmcxvC?=
 =?us-ascii?Q?9dR5ZxAZ2q0eUmQ80cVH+0SC5g5C6HG9uIEZ3FciIGm6NSbXsbxZeWkat46s?=
 =?us-ascii?Q?TtWcsv/y+02Bz1SFZEl/JYRK27njXL9tlxOvuHJfS8tcYklWZUuJKVkDbuK2?=
 =?us-ascii?Q?os2/VyjBkGQ0U0gIPzm6mBB8ofctMZ5UZwPM7xPQdg1UhVUYDzheEPckdKn0?=
 =?us-ascii?Q?ubHfIrvzg3elwHxlmy7RTJkzZPCQExmYyLWA79ftHq21x3jGAPB2y3Pv9uDp?=
 =?us-ascii?Q?QwFVU1S59VrHaflyA8A9wpFwi4sLebKVOw5bQpzryW8fJBDLhUPYyzRo+xpa?=
 =?us-ascii?Q?78vLtgDp6U1PIzXdyOr24hHQuOvSa4gigLdmFLU6/JgbLiGNN9nim456z8gw?=
 =?us-ascii?Q?c6bsVu8L0Gtebk+pEyF4HynR9zxG2RTnyevKy5BPx50GCkvz4lNd7IuGQknM?=
 =?us-ascii?Q?E5Rq9pF/UnKEZ5KizadgBm/B0LdqheKfEJ8xg6JDD7b95kZScqpZDFDriYnK?=
 =?us-ascii?Q?ZmxljRf07hknNUzvQzD5eV+ba1sTcyLljAYOvufextJdOJMe4qbjV/Q0tPWK?=
 =?us-ascii?Q?3h/59ti/q6k9XC5THXGFzUwpRuz/1w/wUwFhMkbUCY8JkTA5JLbdnP2pR/Gt?=
 =?us-ascii?Q?yIXDXQ86gjftL391DVPWPr+noRSPCp0ZythvuajXGGcrqXLPk2/QyF/F4PSC?=
 =?us-ascii?Q?u8tpWQd0CmLgLFGrw2ufioD0wwZ3PZKR7nYtneCCWulY79zpUt/p8/ue2qvg?=
 =?us-ascii?Q?zaiqZHXHlN0WxcmhOdv7KQWVNJ7mYsmf6NOL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tp8gIdOng2MoUuUY694cczi4hVmEGWF/01xCkQ3eF2lXmSk0SSYtkY0eqgRf?=
 =?us-ascii?Q?2Q/9x0r2iYOil+dT3ne6xf7iX7HCf6tbxnd444GQIlIs/YRhclJKzXMGDurf?=
 =?us-ascii?Q?GC9O7Ep436I3TlQspMf3pLU+8b/2v6vbF/6pJZPPCsTFRUL5G4h/kdav+sGx?=
 =?us-ascii?Q?qVpV9PG10h55OI1/WcNo1Mo1cHjNr/X/zTlnJyxmf1GhukEj0+BArQF+hO5Y?=
 =?us-ascii?Q?XOaQa8Jvc7vUuzEsrQWx51TtNEYYJVzuFzYd6w5rwi1yw2wNfg3lPH1o8UI8?=
 =?us-ascii?Q?q+BVpPyfNESFOJXHMUmgmSJVqW44XFoJQQP0aireLCUcH/xeOsVfiHFt5dmC?=
 =?us-ascii?Q?cRBmpKk4v3usOmhhszJtxNw8cKo7EPBnAw4w2+TaY4WAknIYrDKkCKVep3tK?=
 =?us-ascii?Q?+AlDRr/5KGTt5mXu2pr7cYOYIThFakUTM1MH0NSyFL8RGFFRsZq0ja9jpJAd?=
 =?us-ascii?Q?CDu/F1pL5hLPj6yxjXUtqP4gzx/lYoIkAz4sT0RnZQIgfDZ6ncwhNMXNM6FU?=
 =?us-ascii?Q?rGytsrwkNvOUnh68u4Rb0LnXikH15m2W161ygFzcnRtuN4nhXlMyJZmzN6a3?=
 =?us-ascii?Q?kcgIX9T+yQuQ6Rx8kYIq6hGGLl/mLbcTCWc5rK09CT5I/r92UcdgRvvg710p?=
 =?us-ascii?Q?Q8gFp+Z06p0wtPUVv1RFMfrnNuXzw9lYxFKFc2PFb7OXn/ljnRUjqDHtzSiz?=
 =?us-ascii?Q?nreV8XuUgEjL2KsM6AqqN+lWFa4fkatnePgJ6uvFxQZSgSFLTztDQtaew+Lp?=
 =?us-ascii?Q?HMXFFnhltRpHT1IytjZRLeSj3M1eauTzEm8evJqVJ00Fb176/r2d0+5UP1VQ?=
 =?us-ascii?Q?J76k3u1qsZczHK9cFwVEY0E1gMgYIwGAJ5UH+sklTE1KhXT28zRLxGeXUbD/?=
 =?us-ascii?Q?cCCONo8cdvfURyRS4oQk3oVqr1NdGyxmeo5aDc1jiXuSMaOPYk5oOkdlcJMn?=
 =?us-ascii?Q?4corZBtoUSYnnd4vmOIIu2su1ieUQCKbu60fBq6oQJpfmN49gqg6ktfUKHbh?=
 =?us-ascii?Q?Ac9tWRv6h6FrOwHtIzZG1OIMJfPL0s3sFazdU4Hwinawv3DtOsw5v0IrapXf?=
 =?us-ascii?Q?WkSQWmRc7STG1Mmb7Ee3do7o2ewkUk55bPiV4v44mNQP997I8uhqTawm2BWM?=
 =?us-ascii?Q?nGVUbjTsvvSb76+cUT9HpOHFNt8Fv90YZq6Er3/WlZ02O+a/4MPdObtIIpBw?=
 =?us-ascii?Q?DdAduzfO9mB8inwvyN/vUIf53IfewiD7JGdy+RuIbkY3jw9JHahYFfF7oW0F?=
 =?us-ascii?Q?3TFztnJDz9iL5nQmf1EUKzAabWlSZ74SlhZQlWUiG9ZyuQQgtb2pp26ZtRku?=
 =?us-ascii?Q?yWNLookGz/o9UtWwTQ3FcbvozoVm/KgQgJOhH7BRG74jaWkrQXYXXGemV0/r?=
 =?us-ascii?Q?B2js44Om21Tp9Pqp8AZndYewsnGgDT4oBmdDOVpYbFOxuo5SMmt1/3a4dJXu?=
 =?us-ascii?Q?EOt1DMy4ukl2GPL5mW4Y5O0BdjErCtPx7FaZU+WJONU0WY6pVcGb7YQi+YE8?=
 =?us-ascii?Q?nADlyx+PHXkEFhJd6ycFs8OMWInwR5HCVKn7iso6Se+FVa/SI2qhNrHHPHTG?=
 =?us-ascii?Q?9Qx5vl7P2Vmtn96/T1C7gUPiAn4XkXsKF9XTIIVs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba360f4-1dbb-4f68-9cde-08de28ad69d0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 03:24:00.4711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cLOvESN/GXN7cly+/CwpKGw72FU3AOEoEE1Ozwv0uInsECDOnUTPKW2Wzg0W8cEOJdms8QPyvvbZvfwePCbTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10592

On Thu, Nov 20, 2025 at 12:45:19PM +0100, Johan Hovold wrote:
> The driver has never supported anything but OF probe so drop the unused
> platform module alias.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/fsl-qdma.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index 21e13f1207cb..6ace5bf80c40 100644
> --- a/drivers/dma/fsl-qdma.c
> +++ b/drivers/dma/fsl-qdma.c
> @@ -1296,6 +1296,5 @@ static struct platform_driver fsl_qdma_driver = {
>
>  module_platform_driver(fsl_qdma_driver);
>
> -MODULE_ALIAS("platform:fsl-qdma");
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("NXP Layerscape qDMA engine driver");
> --
> 2.51.2
>

