Return-Path: <dmaengine+bounces-10389-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Co4JV2UA2q37gEAu9opvQ
	(envelope-from <dmaengine+bounces-10389-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:58:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB02529BA4
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C7623024F96
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 20:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC743C457D;
	Tue, 12 May 2026 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XYz0Go0y"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CB43C1979;
	Tue, 12 May 2026 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619481; cv=fail; b=maROTrOcbFqUEmii8URuI2u1YVQuxfsV61LrCktdZnISbtISZP9frKNqvdYFTjGSkMvAQCP19brtPgCrMFLVoVTGGNPnmyGxdAkzEbw2vVdfqs+HT3XZlpVHbecyGG0wDXW5FpFHUg6ojZlYyclUaBXLgxN/U3qjkoTknj+z9O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619481; c=relaxed/simple;
	bh=+dZeUGBDENr+5vCX37x4uSkwM8vXaWkHQ1DvJJYVRD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ns31QUq+Zrx94Yn1J4JoqMZgrk22sTM3RLXg8NeCgoAkZEPKD+1U2JZIkrK3foFyI+wH+Js4nh3IsWq78nm1h/sTLEcE31OZQVuKnXHAkUTwXEmzUV+8b/xypsb+9zAiY4LEA+hUl8wIZRTmyRQkZcxup1jQCow0hSBZZ3S8AL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XYz0Go0y; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMqL7xXsAuH5rCtXL0HkphYWH8lNZboKHsrwX/AVanOsfRX1zAvFtzyDlmd2NNBph+cS0zVl4GR/HDfyCM70gNloooqGsHXnxFl16bVAs3LJVxMZzggzVqOLhbj3ywuZzpX1WAbA9GLVjNXCAmtzgYUH/rCchecP0vdIPlJEIaa0nO16553axqa8bMFgzEmbRD/vu2F6SZszBtOxTuhRk8yX0hJ3DBulCVoltbFxbGKJFgKGLjBzPNnIWxvNp15fkild2oLmSYiXuSF8bydsJkR77dGJSnh0XiNhyoaf03WH1TKtO5J0snKYZO7J6GpiXfyo6NjMNehsCeIOhp/65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/t28St3ybJZU3QfvtLeQnUQvA+0Wlxx1vc45S8AJlI=;
 b=G5RvQ0pTCkK2XcM39csMAUfN3lgvJnkTVc6Oh6mZnjMT2y89X4zyMBsk8O2e4fWn6ZMABBu8GHbWFtCWlgdzZ/OgFzpBuYmoRcy8Vam0SbC5YR+Pqvbyscv+q3jz6h5Mx+19pWla0dxfhEgnt8448MBxQy07ciNdHZ5/jzAk8Bwd6pPb/2yEQhm7zTbyJQd4c8rUITCM7O0thZcz8f+qmP7Z25oDkGHxrNDOLZ7RMo2J1Ti+A7E5iQSZvpjklQkyCeAfPxaymLRHg4NJsM3H6kPyt4OZr2TzV6310T8nXxCbl89NthqJibk53vThDnG3Vyv/WOZcwUe98Ya5iaQBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/t28St3ybJZU3QfvtLeQnUQvA+0Wlxx1vc45S8AJlI=;
 b=XYz0Go0yID/gm4+QnVVUPuonupIByICH5XYTxB45lwW5S2X2WXHsuDtn5NIB1C7P9HJEgMSdRZaCYjRxuAQKUHWag+arroRNxDRrhg0d6koBA+cdQGy9UNLh37/ryDVNpa3eWXecmR9rKb4N2kNLrZEXLoMbC+63S6evOJ6kfgxEbQ6XvC/YgZVte94ZzFs9KTvniZ2HIdumhTpw71AazJCUC+LsQWtw/dBqYn5mgtDJYPW7IrDvvynJ4FsFz+3RGs5vc550CxtgWBvA0U/lyawdYmjQg+qlQWFi/KVq7mje5hbgXLVIteAog+/DO0uh8bP418oFCZylIlLGfjDrgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by PA2PR04MB10279.eurprd04.prod.outlook.com (2603:10a6:102:406::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 20:57:56 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 20:57:56 +0000
Date: Tue, 12 May 2026 16:57:38 -0400
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
Subject: Re: [PATCH v5 08/17] dmaengine: sh: rz-dmac: Add helper to check if
 the channel is paused
Message-ID: <agOUQrZMMAGoNyUQ@lizhi-Precision-Tower-5810>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-9-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512121219.216159-9-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: SJ0PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::34) To AS1PR04MB9382.eurprd04.prod.outlook.com
 (2603:10a6:20b:4da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|PA2PR04MB10279:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbdb933-0a01-4b1a-c63f-08deb06923af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|22082099003|18002099003|38350700014|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	m0aUNzdUret725zkibnnKDph6t4VE/WhNTIf1ba+KpJKR76cMNvOIDYe4o8EwxgnSvkC1yG4FOp+9A/30z+C76ERFw5zlaHb8Mo6XcOJY2xm+FWsrL2iG4TOQFuS21z1JwGxjnEl92F0kfcZ5/1aZw3dWsxGgqEvhu0vI02xX2yKm67UHrroPifmTp4ShcThff5QLFry0iMmCakl7i84cGhe6wcRhgTLCz5BPa2l55hkbYwLR8XKTNs5bIVBTdfo2ri5cT5OqW0tusNN5b5zhOcPk1vnBtGXETeq14QtgBpoSASlAts9mUCPVv4wlLIUDSbw//xuXAF0+2ediJSgPtRZltBXayd5y8XuATubXPqT9ChTkpoQ84k47REPSn5zmZfxxtVkXiuV0ldinHvtvIcmmhKFrkUKSXIZoVIPwpRGDx/HnbkjP/lj2nrVfPjuOZC4ZAi66emOtIsxgi4KK1EbePt2X2mPt8YW413MxBAe2sXLlWFq0m64BFEKyM7kG4SeNFr/Ld9lxFvJ4gKANX0Xm2T8lxGylcv58YYDAY6OwWdVaa9wZTxbxpV5ZGFUdJXjblq3wpT1mAQuQldRPLPllp2SpaOdfmImJAuYbobef+wjl6pcRbszXMPlhoeLjn7P/v09mJ1InriTlGCifoplNJaG0rqZJc3HCkAwVufCTpP4tzSNRHJfiAcVq9wBMnxNlT1KqFtoeuyb60V83TEF1Y4I2wEurKfuesePiNNoYaNhfC0SZG50xOVxAhqC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(22082099003)(18002099003)(38350700014)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cYnF8F1IHkjqGceTsD/uFv0J7P6kI4LXRYUoXgP7DIfQhFPxi/6zqVPWI/eX?=
 =?us-ascii?Q?HFrDXKz9ku6NANLM3988ag2Q3znieFtDAeNpjIDo6zSAwt1xbN9XPTZ3sQef?=
 =?us-ascii?Q?haGQDmbi0kowo+jkdK3479PYjp/9aFCBrjM9nzN9iPPKGk+VhHhSJIvcxQ7m?=
 =?us-ascii?Q?uUzvpmmYM0Ai0GOrQeKVnJhx/bppVgT99ovlFkw8D577E/Onc6Xc2Z9+lAdT?=
 =?us-ascii?Q?1+yuOmigriwSp+GUihMgIr5eAESoe4CaTJeltgztb5IFRjANiTFVcs1GVqcr?=
 =?us-ascii?Q?fjpZEPc2kNBAs/FuKMrHZK+Zapfd1XJRJ1GPYc5Zv+4GkO0lQqeYeYlGX+u1?=
 =?us-ascii?Q?NHxa2/s+icb6iY0nEzfGYqPK/vagX9Uq1KGNs/UxqdQQmS/JF+VuhHZus6SE?=
 =?us-ascii?Q?yFVTngIMiYkJP9cwGGbR/4qTqNXzIOH7GKqpg+nCtEHBNZE1AGc2sGQusROs?=
 =?us-ascii?Q?L52D3+srCoz8y83r1MPc33FYNBFAHFOOhzqMlX3YaDW/DwJ7ac6iqaYipfF2?=
 =?us-ascii?Q?Kvp+MR5WyIAgtaEHz2K2PsyUSePlsDK5wHEx5YERgDg2/Ml0F0ME339+22R4?=
 =?us-ascii?Q?zxKbAtId2XfPEeD/rBcBJOLKJgPiNZPmRt+BnQqWSReWQS8sgQTHxvAz3WPd?=
 =?us-ascii?Q?IdJ0ROp9mzjAr77V4+WIxC99FoG0sdjcYEVtcQ2Bocdd5HV/hQ4Vd+5o8c5o?=
 =?us-ascii?Q?UI/yCvGujBgy6s/PzXjDbM3GS5elR/LUhwfsOJ3JzHHkBeeNzm4FRk2Whuvj?=
 =?us-ascii?Q?aEU73xO9cuyxYXB/8gb/SuTAiye/7xM9n4oUUnp6lr/gYEc8T6Ez7CrOTsMu?=
 =?us-ascii?Q?OCjJnt/XAW3Lbveh4uHKnNFX9HfnaqAnVP/Mk5KKhhcrYjBghOBAZ+nvhdqr?=
 =?us-ascii?Q?X7SWBuw+cZIOlrO+79TN4vFrPli1h3GObV26jLzjjBNAhTn1ErDAXR2y73uC?=
 =?us-ascii?Q?TChTTk5j8mrffqvSVeWIU1UQv2VfVFwLYDmOrKDjG00LCU1kk9DORGOC/5Sp?=
 =?us-ascii?Q?ZhPAh1KDX+OO04bQ6lcx0jFtH4qlSc4W7YAiijElytVz5gka040qYptCv1+r?=
 =?us-ascii?Q?4/70SUGJLm7OeMSZnFROaqEsOFIWpOrxoUyvn67ce8AKPxohgIbdWsNpKiwI?=
 =?us-ascii?Q?DnAuzRsHeIzqjUF8tnSJb8otDUI+581uYiVPCdLFCj0VUNdXBominCZQSwnI?=
 =?us-ascii?Q?y8m4w+6YcmI9ZV0uILQQtjEywH9pI3IxQIwHpFgPStm1n+hcAjZ0ho5/v2OO?=
 =?us-ascii?Q?Efvj9P0N2OO9YAF2+TxSDnlHI9kd9NC3q1XzgMvXWgOpn3Ur8VPc9jAsX8+M?=
 =?us-ascii?Q?eYZouB56aYV/PumgvwaPBpMnmT4SDrKyTSpp0cEYSNxLzq6MVcSXNPMx8ZBE?=
 =?us-ascii?Q?IEocCSJFicO/iI9do/GexeVmQBvEIpiF5a/glLrnAULPS9RiIQFbXSZLXz2G?=
 =?us-ascii?Q?NgqoSte3eFFmMwbwuIt0r1AsZIRB77aH0NToYn6mLkQBTD9xjabVUHuIpQfW?=
 =?us-ascii?Q?I+XxRrloQLW337TYm1YqbGf4NMMmg3GEmaEvy1kPPVrT2vNZWPWGZNosvAzo?=
 =?us-ascii?Q?0C2MJC762VPDj7kzi06AxuvSyqIxRXfxUni6KdJt6rUFHzp8fdbWgBMfNYGy?=
 =?us-ascii?Q?lJ0aUSQPH8UOvf8x1B2z58+on83LIAJbFgSmaQSo6/ET9tK97cdycfAeHeuy?=
 =?us-ascii?Q?g4M1h5bpzY6Or9VEYovDTHi2r1ApAHhzSI/l70+JjLcLTtLTfGI9mWmejR35?=
 =?us-ascii?Q?gag5aqBMKQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbdb933-0a01-4b1a-c63f-08deb06923af
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 20:57:56.2645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHE4CXDmLl1X7EFrnbzW7YgJEqNihWrSb15s3T0rRymcnAQtGEMsb6+8DNyTh8pvgyQxyIjSxd4JxB+tAM6YhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10279
X-Rspamd-Queue-Id: 3EB02529BA4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10389-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:12:09PM +0300, Claudiu Beznea wrote:
> Add a helper to check if the channel is paused. This will be reused in

Add a helper rz_dmac_chan_is_paused() ...

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> subsequent patches.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v5:
> - none
>
> Changes in v4:
> - none
>
> Changes in v3:
> - none, this patch is new
>
>  drivers/dma/sh/rz-dmac.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index c7337cf27136..042f85e58a79 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -286,6 +286,13 @@ static bool rz_dmac_chan_is_enabled(struct rz_dmac_chan *chan)
>  	return !!(val & CHSTAT_EN);
>  }
>
> +static bool rz_dmac_chan_is_paused(struct rz_dmac_chan *chan)
> +{
> +	u32 val = rz_dmac_ch_readl(chan, CHSTAT, 1);
> +
> +	return !!(val & CHSTAT_SUS);
> +}
> +
>  static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
>  {
>  	struct dma_chan *chan = &channel->vc.chan;
> @@ -822,12 +829,9 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
>  		return status;
>
>  	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> -		u32 val;
> -
>  		residue = rz_dmac_chan_get_residue(channel, cookie);
>
> -		val = rz_dmac_ch_readl(channel, CHSTAT, 1);
> -		if (val & CHSTAT_SUS)
> +		if (rz_dmac_chan_is_paused(channel))
>  			status = DMA_PAUSED;
>  	}
>
> --
> 2.43.0
>

