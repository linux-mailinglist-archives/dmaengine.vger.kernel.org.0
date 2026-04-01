Return-Path: <dmaengine+bounces-9815-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LLQLaSgzWm9fQYAu9opvQ
	(envelope-from <dmaengine+bounces-9815-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 00:48:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1EE3811CF
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 00:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1F11303F83B
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 22:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C76E3EF0B0;
	Wed,  1 Apr 2026 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z/YAdp3f"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971BD3EF0A2;
	Wed,  1 Apr 2026 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775083255; cv=fail; b=Z8IDLBYga7fgHP9yRojuWKSR5bbpMstlhw8EAQMZjHS9sjf1PINVtVW0RIWmUf322aYtEeM6O3+HznVE3R7mesu8Wm0KGMXIiAqnGBy6XDZAbr+3S4Am1XxgOEzZOqvzUZpu34xV1Ke8vqW0Yg3hgO52sKYZMv5jkbi5+nJECo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775083255; c=relaxed/simple;
	bh=dSPU2FLsURuIfcDHAbDW/tWKogM8lTrTJKam4mV/YFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RtV5UY7L3uerGgOOz3yeQ1V3QCjESC7cWiFi2Bng2EWyYH6+wY1TsKM0DP4gzTp7l9tQ8EnkcmOOmYzvdZhOVAut1+de+za3pTiyZHQSQd3N9ZkQwXQfMBmEWtSZ7vLdPD46LX0nDxmvLTgaZyj/JHgFy7As0IxR92QqlLNbjV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z/YAdp3f; arc=fail smtp.client-ip=52.101.83.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpASIBNbLzYNI0U+cyTnG9tTP6Zx9skpeEo8sNJd8Hk0nQfYedaEvDYh/n8fmya9Hpgyayngl3gUcUmm1AfoPYfnn/3GAuqkbZhMrNzPbXD14UzYGmpmmPyg/cwcdqObwo8sN6geWvHigSd7Fmd32IeVp5iOFGYAVTGrLFyy1Os8HNSWJuSErAd3UKmZJ/Jd95DYUv3/qsMch0exUwmQNBRjAO4//RVpHNhsM5yMcSFSfsfaGfh+nYEVT4OhOgXYn7yYEZTgqfo2nw+WvzYy7fE6E2yplXWAlGUpB3zfKoMt959ph40LrgMgGnwpPzDkFy9y01Sm0CIKeYmd/S81Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1D8LkzJOKrTgF/54gdXPEABGIdLijqyrtx0OyL22Ag=;
 b=QsEK56TCAJ2fQGzOckpGpUvLsJtSDU/OmEVDIKyl+4ZetTyRdQz14bT0wn9gPlJAWkAxUfgyP1o2Zx+ZoWK/wx2QEHunV2E4N1KG5h+TSQWAeeu3O1IXhLf1J280J4yLSUiHrNiw9lMUmGwJP8aKA3WQuoGyj3RgIb9V1bXkf2CUDH9wDB4FFMhe1ZFQVHKZcRbI86eJ2ZBXPS3LPWUsBpdvnotv8sPrSHMvNEEMipy5IdsZKCnv9oBnyblDYg/rNGwgDFuqTwWQ6D5/7lKGtuLgZ7hwDrKp4YOuUYz8g953Ul5c6OogQqmdZg4RqIJu/N8Zza4nVlw//mgqGVP79w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1D8LkzJOKrTgF/54gdXPEABGIdLijqyrtx0OyL22Ag=;
 b=Z/YAdp3fCjnVwDw+5If2kYbT5K/98K3hJiCp243PAOW0kEBd49MUv83K4nq9GOWbJRPl7FbldQEfU6D0ITVm/g0xB45yIfVnpnlAJqSqJFm/tEwPovVDIEqRSlekZH1K4vLNwvBt9bA3VQgayHo0CofLE96IpFUOT1vt1LPQ5J4cHwRbdGo2OZQbfczAZsqfVaDL4GWoE2ykqocF8KTc4ctTDSM8DkaXxoqQklouf2+EWhvioqh2Lvto/kW5r5hpXbC90NhhXtGX8OXtoAi9ETXimUywJABDiy8aZSoa3xzjRLG89uRYsl0MQWhy4puDjVuNmL6/jalrYo1k3Te1Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB12234.eurprd04.prod.outlook.com (2603:10a6:800:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 22:40:40 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 22:40:40 +0000
Date: Wed, 1 Apr 2026 18:40:33 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alex Bereza <alex@bereza.email>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Tony Lindgren <tony@atomide.com>,
	Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dmaengine: xilinx_dma: Rename
 XILINX_DMA_LOOP_COUNT
Message-ID: <ac2e4ZupU6W0Ik5B@lizhi-Precision-Tower-5810>
References: <20260401-fix-atomic-poll-timeout-regression-v3-0-85508f0aedde@bereza.email>
 <20260401-fix-atomic-poll-timeout-regression-v3-2-85508f0aedde@bereza.email>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-fix-atomic-poll-timeout-regression-v3-2-85508f0aedde@bereza.email>
X-ClientProxiedBy: SA0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:806:130::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB12234:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a12f6fa-09c5-444e-c94a-08de903fb3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|52116014|7416014|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	c8vB3dn5EACX+87z5g/OpihxdosIdSd9sHuVZfbPTw17MPG+tnaXEXojoUmwWnosMWuXIqNmMHaY8RBakGQpJiybEcEUyG6TFkrLWvS88jhXrPqBqfR3W9pUwjHyHWRkORVq1bzEjKMZ4cRxFtf4n+ojgTKidD16SoGK4k7PBjeh+WDUWSUwrx+p+6ukdSmiTuYWDRLOlWPAA0yd30jdvg4Q7c27flG6Ev3XQxCOB3WGbOZEnhqbsPHGUqWPiYVDgE+NCNgnPWJrMYJVbVZwq+Q+PBHknP+tmhKg2ZKwAZDHDuP5dNcRovCesej4XfYmtMyBlXG30aZpOMkvWgZpP8M3KlOiCJCHYO5I2mq6wqMH06KLTvG/af6/E61EfxKi9GoESjtD0i0m7VDYxm0PDdPqupHooOGlyOR610gEabMgbwmBiUMDiodTMmCOOE0EdExAU+7+4Zd3sv86xZbdhAk3OCfmbuMWthWZbX/fVti3ViQsVgc9iBysXQp+vwC9wZRQaPMAZv1GTuLghfob/2knEffqMz/6zfOhqsAhzq/SOU84aEPs5wYtF5H+bdgbD8RO8FesD+PJh3gElTTdiv3JbhyeS6MpQkuVfb+GGHvjedomSKwqgm/Xq1LdBUQr96UwIZJNOfDOelwWW4LGJjkrdgkisezt7//HuRGezCCZGsv2dY30SpuqdZykG2xqk5qtThliOxMX3jBughBGn7OJs3tVoKSiQ8nW1606rdqWag78XC7LW/3ExJtBde0a0CZH/Qhu/TR7Gyl1pu8JxcyG86Qwrfri7iSSWshpvTc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(52116014)(7416014)(18002099003)(22082099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IKI97u5CA+ehwOFLslt7ZS0qtHkDDsZjCpt66YU+bYtCRrjHjeZw8GTQctYg?=
 =?us-ascii?Q?eIJKoMYn0mffvqV+rccF5xzlwemZNjhROoCW12dZJWqcrkUgtvQOcJWio/Ws?=
 =?us-ascii?Q?uBMH7zTT/fRvL9z6Q6f3IGbRDsNyVCvVHUaIZHH3SApS8+zKzZIqAgxrYWQc?=
 =?us-ascii?Q?vVrZ4nLSEpBJROqSfd4KqQPgDylM9aA7+7un4iXCH67M+ACglw5A2TYug/S5?=
 =?us-ascii?Q?Jc6UyGiFsoCkPKPpKqTSnzhj853Fuz2Z2nONYcjU4DPlZeDTGwmf7rrBxv6c?=
 =?us-ascii?Q?AoQu/xhUcJxsQQZyN+ga/Eh9kuL3l6fDh8jx9tLNvqW0y57fgphryrJoxYvR?=
 =?us-ascii?Q?bIF6eQpUjLJy0CqNxcJDN9vfhakN94oPNnDGJNaBbkqjlZWmiXKW6WYhVfpT?=
 =?us-ascii?Q?u+DT7eQLVPZ9jBQF9c2uiDyOxy34TumXIs4IBQmUxF6egoP6C5Flruq2xulf?=
 =?us-ascii?Q?+vXoNiTIGKSv/QDcoJ9TrL/fyUUcPbrGbXJ8tGAf9wpyadCEbiDaOOhi0zrS?=
 =?us-ascii?Q?CXzqDWwzPDe2ncei1QblN90ZZcJzcgmQgDCNrvA4n8NqyhxigQ397703JufQ?=
 =?us-ascii?Q?XxprXDiQSRIFR5GBFyVknGhWXT5EaYfhTF/af+gFAOtI11+fyQZxy81MAdHk?=
 =?us-ascii?Q?Yn1IhAyFFihSmomFOQJn3KImE1gSvXUrAojzBApm0uCRz7M6MYwbFHBNOdnp?=
 =?us-ascii?Q?vJxfK9BVTqeri7RKip2lWXnqAh1kZfVeVWPH+YXYzYZc6kuhgt9DTut61Rdh?=
 =?us-ascii?Q?eURsLsY2ZFb25CAUl0sUecgvoWD2/W/qu5SyVyTTqaG9g3xx64O4WvhBKj0k?=
 =?us-ascii?Q?EEzcUbL4i4uhTuzxeUAzSAmJ4LEuE+8Q4z7bAVvrRsjQnqKTZrME8F4gEMFA?=
 =?us-ascii?Q?W9ynzI4L5wicxhKqcqJ44aItIQBdqxM3T7iDvLqBzTQccxF3nCviESabB0Kl?=
 =?us-ascii?Q?o7NyoUzTPJNhkT3dm5t7RAMCoNxAd0w35cj+H5ak6Ifq7GF57t6vtjD6s1BZ?=
 =?us-ascii?Q?MkRawGlh9KSNPaFUNejIwetml7zMG9jTIATCni0HNXC7OgU/cMin5XyaKjgW?=
 =?us-ascii?Q?YAhdHvbuRjMOUFgSHS7lS6rUQVUXajR1tVrMVcbip4OXjAoYlF+27G51E+mb?=
 =?us-ascii?Q?lUlc8UnBA+QF4/cXfRVOI3TucP04Y1sieYKvWb4dItuUIMWfsm/P9TUqPitp?=
 =?us-ascii?Q?As29uqa2FjLVDVYpkZ1tcC0M0Ff/ChYWPa6FLEptbsQaLKYD8Yabw5KkAHpv?=
 =?us-ascii?Q?TGxsCVhoIST/EtvdTGAJ05usRBmyEEmEqFh/L+M84hXBsVA8XZFn/1u9/1pT?=
 =?us-ascii?Q?2QtfL0A37FSD0G6zrWIeOTrGceDTwxlnSKuze88wscCEBWbczY3wZ71wpFdg?=
 =?us-ascii?Q?lF/NqNTokTPAr9sJbe4q/bBA/+RyLiq5Ymrsvg+Rid5Y9uWymNOPbZzG0Xnv?=
 =?us-ascii?Q?slN1o70ZXDL3HD0fIc7ajfATi2R6OXEjFVksFKgYeLgrGSZEpIzyE6usu5Gw?=
 =?us-ascii?Q?YoKLCyTTQMZkHkILg8bfJacxJYGB9Aw9Bh6Li5g3giW8g1lBV4Y5FaP3B2G9?=
 =?us-ascii?Q?1eiDY2FkWPsYHLhsxSh0MeW0EmCo771Bbhq01+7eizSArubyDndULqbQfOcz?=
 =?us-ascii?Q?HJEiR+g0E0HDu7rNnmN7jWfq8g++r7lJlL/Ozcyrw87Ma1yOvXwgTsM3DiCd?=
 =?us-ascii?Q?Q0UkcEDbeA1TUcWGcpEJkVXNsOQfTqGe+2mf9Dmo92j+6eq/0E7rdPeqokLY?=
 =?us-ascii?Q?EzuFaAaIvg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a12f6fa-09c5-444e-c94a-08de903fb3b7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 22:40:40.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7Dwqeodpzn0938i22kqtZFe/pp2rBMezDx1iB0jsCsLLIkVb9n4NUxHHp9dVmuTm8DDCJJ4JIz3QUoYWl53OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12234
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9815-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bereza.email:email,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF1EE3811CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 12:56:33PM +0200, Alex Bereza wrote:
> Rename XILINX_DMA_LOOP_COUNT to XILINX_DMA_POLL_TIMEOUT_US because the
> former is incorrect. It is a timeout value for polling various register
> bits in microseconds. It is not a loop count.

Rename XILINX_DMA_LOOP_COUNT to XILINX_DMA_POLL_TIMEOUT_US because it is a
timeout value, not a loop count for polling register in microseconds.

No functional changes.

Frank

>
> Signed-off-by: Alex Bereza <alex@bereza.email>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 345a738bab2c..253c27fd1a0e 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -165,8 +165,8 @@
>  #define XILINX_DMA_FLUSH_MM2S		2
>  #define XILINX_DMA_FLUSH_BOTH		1
>
> -/* Delay loop counter to prevent hardware failure */
> -#define XILINX_DMA_LOOP_COUNT		1000000
> +/* Timeout for polling various registers */
> +#define XILINX_DMA_POLL_TIMEOUT_US	1000000
>  /* Delay between polls (avoid a delay of 0 to prevent CPU stalls) */
>  #define XILINX_DMA_POLL_DELAY_US	10
>
> @@ -1336,7 +1336,7 @@ static int xilinx_dma_stop_transfer(struct xilinx_dma_chan *chan)
>  	return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
>  				       val & XILINX_DMA_DMASR_HALTED,
>  				       XILINX_DMA_POLL_DELAY_US,
> -				       XILINX_DMA_LOOP_COUNT);
> +				       XILINX_DMA_POLL_TIMEOUT_US);
>  }
>
>  /**
> @@ -1352,7 +1352,7 @@ static int xilinx_cdma_stop_transfer(struct xilinx_dma_chan *chan)
>  	return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
>  				       val & XILINX_DMA_DMASR_IDLE,
>  				       XILINX_DMA_POLL_DELAY_US,
> -				       XILINX_DMA_LOOP_COUNT);
> +				       XILINX_DMA_POLL_TIMEOUT_US);
>  }
>
>  /**
> @@ -1370,7 +1370,7 @@ static void xilinx_dma_start(struct xilinx_dma_chan *chan)
>  	err = xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
>  				      !(val & XILINX_DMA_DMASR_HALTED),
>  				      XILINX_DMA_POLL_DELAY_US,
> -				      XILINX_DMA_LOOP_COUNT);
> +				      XILINX_DMA_POLL_TIMEOUT_US);
>
>  	if (err) {
>  		dev_err(chan->dev, "Cannot start channel %p: %x\n",
> @@ -1787,7 +1787,7 @@ static int xilinx_dma_reset(struct xilinx_dma_chan *chan)
>  	err = xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMACR, tmp,
>  				      !(tmp & XILINX_DMA_DMACR_RESET),
>  				      XILINX_DMA_POLL_DELAY_US,
> -				      XILINX_DMA_LOOP_COUNT);
> +				      XILINX_DMA_POLL_TIMEOUT_US);
>
>  	if (err) {
>  		dev_err(chan->dev, "reset timeout, cr %x, sr %x\n",
>
> --
> 2.53.0
>

