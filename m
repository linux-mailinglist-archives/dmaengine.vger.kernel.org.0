Return-Path: <dmaengine+bounces-10394-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLboLtOjA2oW8gEAu9opvQ
	(envelope-from <dmaengine+bounces-10394-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 00:04:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C545552AB3F
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 00:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D20F1301CF7D
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656B139524D;
	Tue, 12 May 2026 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MPKnZv4w"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6537C914;
	Tue, 12 May 2026 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778623436; cv=fail; b=Yj8k+RFnUa7sUwKrl0ht9Yub/vWz7bGCdRPcjcLFz74v9v4HtWr+2A56w6J1ktVSe4q6sDL6o14v81/zKe10xSKu+br9lapi7v6YaC1rjQORqdHkrF9yyVCfXU4trfxDWD3aA8spBplxO8SDdyosSPo4zBtc167qjjcbfMROS8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778623436; c=relaxed/simple;
	bh=oyTRl27OzydaJp4Yg0zIYmC4CTYPaLKybKIkk0OPvP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j3Q95K/faKvaRUFc4RXcRdUb0NywRbnWQ/DQZ7ObIBoDJcEfPPLBWqBdCK3+uJqSdf2mV1fmc/EWhmpM3wDAXDU/EI4Cf5LHD3AyFTWb+zbIWaC5Vw3aE74qCfiGU0SUN/5ckEiBFmV1xcEE1yW6I1iF+ehNaK0pVcpvhca4rXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MPKnZv4w; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuJOMQtsHCdGE8vsxEzfyWEuMjkVuIi26frp9YK+0atZ+CC7hUx4omjpyb3jJJuAjrtsbyGqmNA2hlP3/wB+LdS2nDwk1U+fgK9vhaPZ9HD93INNtgelLlqwtL49CnpIgCnSAU6Sf3/mayumc+GuMQzUUtvKdiF/kr7ZD3vygM/MOuVAClNYRdlw4K3dJ/P4CaB6MVuLQBvlfoEp9Bw+eNHRJb9/JVJPA5Qi6WoND8LLcEulbowlC2Kt6Sc5JaaDhXRlTP8bd/DtpQoSiB77VEvU0VUyJZ1+hTs+g4YiV+OMzSrWjZ/ogVf3Ffgss774P7Sv9sTxEBWWJL0Eu0vU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkchEmlV4VIuFQf6k9/iPmLZIeRkCtvgV5vEWuNxq94=;
 b=EdLIWx/MJHGHhT4v/Kas4Q1kxf/7HfdjeL/s0ozL8MniP6x82EbCW5ZxAYkMAg+71kvGvHXdTKvk71l7MKewcVWun7NZbST86NflK0DFMhDtxS9DeEBV8uQzGYInPverPvW0gX5H38rgrvE3GY3m89e/qaezcRRsW+3avs+4btb2BtzCWiXAQ67yIuaQ0m8g4qqfQIGTZvH3eO/3dRD54kfDVTG9Ftz1DKuBTFHR87ysg27WeLVUvxp7E8SWv0KoBOEA2ck19ix6heH3AGNrjPGlRoIt9VYtXoXJSM+hmie8B1R5eGQSPPeMk6H04Pu8RSwz5g5XpFRuCGKYMFGkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkchEmlV4VIuFQf6k9/iPmLZIeRkCtvgV5vEWuNxq94=;
 b=MPKnZv4widGiyUhFRysCTgn/bLaRfCJtAvQV9FRtGbdST9uFA6QIPleYOTPJZ+c+k1xIN75kDvraAsobGCh0jabYFUrAhTTYxMwIru4SxZIqHwb3xCiyPBZDAO/7ioXNaEvjU/CXhe2ZPbnWNULUb/Mj7i63wiAwrxmm8QYSWLb6w/GPq+c4JYWpEZoyWiTQQ+uPmBT/fPKCDpO6wRL8tB9cY1S6EUimB2kpVfvatKSd3iFYl5iLYe2bu6zF4ZxZojFqVZSI//v7xJ+MqCz6GFDpPZoKAdSU4jfLljHvc8i7XPRvuawGhub8J3s2bU7BdyPK8QwktyZu+6BFOWtAEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AMDPR04MB11553.eurprd04.prod.outlook.com (2603:10a6:20b:719::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 22:03:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 22:03:51 +0000
Date: Tue, 12 May 2026 18:03:44 -0400
From: Frank Li <Frank.li@nxp.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de, geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com, kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com, claudiu.beznea@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 13/17] dmaengine: sh: rz-dmac: Add runtime PM support
Message-ID: <agOjwF12NI_jkOzR@lizhi-Precision-Tower-5810>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-14-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512121219.216159-14-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: SN7P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::23) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AMDPR04MB11553:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e143919-ca18-46cb-699e-08deb07259f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|7416014|38350700014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	29o7K5Dp0gHBiyOROysoznii8m7fMAUvN1OXtzqHmSyGe7oIMgHFwXOtrRTdbhLDh3B2KRe5Th9wCTrARYFYJtxhE2ug8MmehkPdWJIg1DJ38IYy1yJN6vWWmuitegPn2++4zrAIg3gTK19/hX2DKtX2YXM+sagmNy+xhdtZ77SNjSwq6njjhcq6NpkPC86Im3YQZGDelDCdYKE+CVLAdvEsGzJfG+GR+cM4tmGEyvNyYBFmu9d1KpMAl2+toIbtk4WbhyOmNJ6+y5c2kBfDAbA6OiL/g9sJlGnBOeuZQJLT2W5FM/ryMIgiK5MwWmIbQ4bGe+/kOvW9yrrGdKizvXbGWMSI/r7zdsAsKefpkqW25JUm9kI0on7hcVCQn4Z2B4434dB8whPxAPPOQKmeZHTZeEu3zwxFFz/J7PFHTHADWpSSYstPMICQX1I8f79WY9Ly0maFz7RrCi7qpeDacMp24lmO1C5D1DG4eqG4Jx725MMpeibGKfgXtdKHLuvvZDQa1iEDa/JihJa/TJEwJYlQqhra2U1jpIdVZrQQX7OUWuaR4AtRj3fOvopBpyYKBTv23+AGkPovOVQTosdrBJA9ZOuPU1saHhq68T02ICHBRAzDCOtfpuCFnLU1yIc139YoCSIS9FJPUrvs0DO8ev7v5faYqaZjZyWhEIUeBTNONOLmtBTs+qsv4/fRoI3TSY7Z120qJNhAmkc5em6FpuniXA4gVrC2qjYS1YPZ7jDBt2tAeIdeD5wxzhQhPU8a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(7416014)(38350700014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0RW/Ur+S8AjYnR/3N6wwZSR9P8XrnHUdPxEPRJ6c+F9cLhhhEJ6IDf+gjUDM?=
 =?us-ascii?Q?E3c1qw25/eeVGBWqEY/CKx3YhtMChPK5x4F2rJephlO/SDiPKx+pLBuwN0CV?=
 =?us-ascii?Q?7jFyf84D7UM2O3JGMf7DHcnzDYDUUPkx5hKGd9VfidwU1SThb+m+A4e2rJ9T?=
 =?us-ascii?Q?U7BFD9IlN5zyR/h1d374ZU/3+4Z2OijRfBJwlv56cczddziEfR/Ej4s7/mQ0?=
 =?us-ascii?Q?pH6AxVsSRucMbBCkuiZuo9DwAsP/P9OEtWn6ekXgDHZ3niobDQcIZ7IYHu7N?=
 =?us-ascii?Q?p5OegwP7I/02M1ew/90FmI5sFNN3yJQKWRZi2Yf0c/4gZAcJSlbkpBTt+lg9?=
 =?us-ascii?Q?R32tPh5c6fDwa8nQY0embPg5voc0IUQHDzWQJ17K9AQQh7ktK5TDYZ93v2Pt?=
 =?us-ascii?Q?uivReckR90ilSkdYkD2T9NkjiGVGfZNRCllEgZbAr1wANkUGTQI9TFNhA5Yk?=
 =?us-ascii?Q?8v+SJn6QZRtmMr0FYoRc6I08rKYexE9M/PwY2hJ6F363RBmzZ2e9nvNQghvd?=
 =?us-ascii?Q?vq9P6b7jCsHPT22YOE3cGV2xsd+MIdZsXQjzBsUXTD86BRPG268t6CaAokpY?=
 =?us-ascii?Q?p5rKD6EhcJu79IaJ1Z6pvNZg31++qrDe+3nfGU2B7/3X74ex2KR211avm9if?=
 =?us-ascii?Q?S7KruzA3bdEL920lBLfbhxteZEwzZFOab1/DjD69pHJKvJf+0SI8jUp9q4+O?=
 =?us-ascii?Q?bMjuvFfxqvk1gmJsxwksCqJIwTMbsmvm3SriVyDZigLhLMEQ2uHbMjtQzW/M?=
 =?us-ascii?Q?kEoQ4vlsNuND9Fdl2YFnXZATZwStKQY2LKxwD33hInU1vuQJeaJ1yTob08ka?=
 =?us-ascii?Q?d9nF/csUToCS9I+MltbkgtWqFbNvzpZqd7Ef7Szx+9gKyfjC7rVoNFJBi4Nn?=
 =?us-ascii?Q?v3UGbkDg3uxSsAIcQ5Cm19XGswsIY5e4QU4tcETQVJA+1pqIQIbsRC+ALeOv?=
 =?us-ascii?Q?X+O62nyTjDd5r/udm+DjAkawh9/VsVKGfn8uiZmhX/GEnMKs/v+NUKejt03Z?=
 =?us-ascii?Q?SHMmYqLqJHcu4XH0b3BHIM70IIeXIdNMFKkbMVWxMlWERqICH1HrlZa21a35?=
 =?us-ascii?Q?9962Qd0Mb8FaZlnl4uIndYpd8Db7550TD+xCzAOZixY1RnaumsgzUgw0VIC5?=
 =?us-ascii?Q?0pLym9337947zkEIDth363AW573RP+uPrS/fH/BzrzKsZZzvAnfK+CDOsG0d?=
 =?us-ascii?Q?LAWXo/vCfySVsbqrs1IJd+1v6oOY406S6uV1U/d7+sRWGMHuEQ9d10QpBthQ?=
 =?us-ascii?Q?QiLxePAXcb2GZbvLs2SXjcL33hp8tXNhSr9D1uEyH688SFyXoWD/6VahGBOJ?=
 =?us-ascii?Q?FpcbJt8UQQ3C2LmndP84Wf6nKJ1A78UKSlHBckeZZk/jSRwKI02bug7olaYv?=
 =?us-ascii?Q?cjLqq+kvL6BTTA8AUvZU8lB1TSryGuXLY2DGgrncSOPbT/zPapQBwF5YD4xB?=
 =?us-ascii?Q?Uq5XmBFjyJhyJCS6j5R82SfzArxd3ZnzN5HubNfkYgF+6Bl/owHDpfMAL6IL?=
 =?us-ascii?Q?XEy5uCaF/YGqtHQSL+YethhpHlCiZ6yL9g1+FRHWQKms9h1P8NcAihuL5UjA?=
 =?us-ascii?Q?3piyHXcdJ6F1VZ3geZQ4ynPYeiBDEKXA6L+z+FSSm0fmRtxe6B9zo6CAyfpL?=
 =?us-ascii?Q?4HpWDd2OJaXyUxZycAj2reimxd7nzpv9Sf0YsovcJlSWiHAFM8iCF2xtetdb?=
 =?us-ascii?Q?5c28N20LMiVyhCBR8RYUyJbJ7S/L3wNouIFmK9cjicg8ooni?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e143919-ca18-46cb-699e-08deb07259f2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 22:03:51.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kbl/1sioIhX8JrClhDLOFoKkHOr2c8c31Ubo28rX4uIAhDIGRvtR7S80arJXxsvFdSNGY3MokqZtsmCnfRajcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11553
X-Rspamd-Queue-Id: C545552AB3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10394-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,renesas.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:12:14PM +0300, Claudiu Beznea wrote:
> Protect the driver exposed APIs with runtime PM suspend/resume calls
> before accessing HW registers. As the current driver leaves runtime PM
> enabled in probe, the purpose of the changes in this patch is to avoid
> accessing HW registers after a failed system suspend leaves the runtime
> PM state of the device improperly reinitialized.
>
> In that case, the driver remains bound to the device, the APIs are still
> exposed, and any access to HW registers without runtime resuming the
> device may lead to synchronous aborts.
>
> This patch prepares the driver for suspend-to-RAM support.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v5:
> - none, this patch is new
>
>  drivers/dma/sh/rz-dmac.c | 48 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index d6ad070be705..df91657fd5e3 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -488,7 +488,15 @@ static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan *channel)
>
>  static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
>  {
> +	struct dma_chan *ch = &chan->vc.chan;
> +	struct rz_dmac *dmac = to_rz_dmac(ch->device);
>  	struct virt_dma_desc *vd;
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return;

According vnod comment *_prep() call may be called in atomic context
(complete callback). but runtime_pm may sleep.

Frank

>

