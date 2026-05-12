Return-Path: <dmaengine+bounces-10388-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCdmD8GTA2pz7gEAu9opvQ
	(envelope-from <dmaengine+bounces-10388-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:55:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA6B529AD7
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AAB930F220F
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 20:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBF03C3445;
	Tue, 12 May 2026 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TqOiTw4F"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1FD3655CE;
	Tue, 12 May 2026 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618996; cv=fail; b=DTez0HAz06CsnVMedaPUhqO2B42fr9zuwHUx/2ZAeup2x1U1NTpKW/iTHrjklBszMl8/8NZsaT+wql8qkjZjE6gjevMGM8yN4wCbH1jTC/uaK1Iw+136En+TBU8LI9jstjbef2TzzKcT1Vla5HDBI6TSVX8ymqesebHIxbn4x4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618996; c=relaxed/simple;
	bh=uCATfj6TwORHtc6Lz5Sp7hf/qDBhQYQVjE3m8eEMpyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fpaCuE+M8/HOaammjRLimdQCPQ5+0zNrEebs65xMVwE/Jp0qDw9+3SyCu0I5xAQHMXnwHD1qAEGgbMel+tP2aWqKBG+zRY+v7i65o46N4dDFXUypwYJtVxWTKtAHaCAV3v1QU6ToFp4nSrVSo5h4LWzpYc3YHSMXqNf1YSjy+zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TqOiTw4F; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKCZI7735jwkFNaaE9qyaj3so5UKFUbs6LsCsFzYLgSk0DC4oAg4DW/yZgZnYLFBaB9L/X3cc2D9DaMrwBxt1GTr/KWlvbgL/t5EgqT+HqfKEWvJa7PsEWoxHNgnoRiwMim9BHbPPtuSvI4EFKP2pjpqEOo1W5r3eOdcCcXfGp+rJHTnLyYbalx5kCyAMFGFYw7SDXQrn+W7N17/PArPGx7RU9iNnbavr/LyqOhb4QbKcyTxHNRX4nLQy2I4/6U5zkA0ESMjtUsLdzP9xA5QG7qnVbsMrVQmHDuFb+oyYuBd1J7sc15u5cOHDxXfNoDnEeLk7KMb97HFioB41M/2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc/WyNZzktdf+dx1NpGibEdumHz/qlTKo1TahHwbijM=;
 b=lupm0V1VwkqnYlIOwtBp5IsRM+J8BYIfFAIaQXiTPNX7RjEbwYGQue44PHeVkCNPna8PuYLi1h0J6X3FMByiOnF28p30OWVOdTr3Vb6+PQtDBTiDSupdI7iImQVNCkjFbNDR882NVYMzOpmfJj6WPrzOMbnoD58/d25Q+6rwqRCehsEJ49jmJi6UJodvNKKOXkqFa0kc70UECWrZ5CnDZyENuiU5JfYOI46EpYLi7YdTeqzmfEd1YMSlLpfcLei9zFi6oWZ6f3USaC1+deS90oH6QztlLCmbNoPZ2f8oDP+qzJViBx99w+zu6gt1lK83HtA5AWp3ksLROVwB17RJxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc/WyNZzktdf+dx1NpGibEdumHz/qlTKo1TahHwbijM=;
 b=TqOiTw4FhZP9Jr1l2zOo+GMdfcllSQcPe693Bkp+LU2VUa7mE0QPoGZ+1CuwjA2s1QWT+SFfCD4NVdhsjRo5u8opOPoGUcpYi969/Fpqd6KEYtYKdj4VyF9ko+4V+YV5lZv/Psk2bWNvhqTWcYmM7C23uFPngSxuFmMrwV2dpRT7JtvPlBjvF4xPRAsZd+VMuXqzAMlk1RnoZQ4G3T4hS72M6crjNJvcPsEfhR6EQB5cfZAhWs6gz0fnGfMHxYUWrb0eqTrVu/PVhnEKupLQKv+mnK7iGKKo71nh9f4+8wpBIEE5+HusMmPv4YYDgXDo3mj1Sw49OFFVokBYYOXtHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by AM7PR04MB7077.eurprd04.prod.outlook.com (2603:10a6:20b:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 20:49:52 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 20:49:52 +0000
Date: Tue, 12 May 2026 16:49:44 -0400
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
Subject: Re: [PATCH v5 07/17] dmaengine: sh: rz-dmac: Add helper to check if
 the channel is enabled
Message-ID: <agOSaCSIeJAJB8R3@lizhi-Precision-Tower-5810>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-8-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512121219.216159-8-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: SA0PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:806:d3::30) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|AM7PR04MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec1d181-8b4f-4c52-a41d-08deb06803ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|22082099003|18002099003|38350700014|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	oZ924vUi4UYimexrFBCC/l8QZ5HpvbjtKjFpx2rB9Gx016oOY1QdPS7x1dZNz1gZ5rVrE/J58qoFq2LiJrskZ7TWEZEe97Srf8fX/UJl/YhigL8QquJs263h22AXvf6/XcsiKM70Xe0WPIDUH7rJz1SS2I/0ErKxuHoQl2kFtK7iJv6Wq2GgHn5PMSZ13BqIyqYG7RtdvRLpjXikklCoPVB2Ck60+62Yt3LEelbIgR1/UPoE3/7noJbWMQW+ngzm7RDwYngqRYD3pYrFpem93+shRLKe+hD+n2j/AB4ddeNiVwsu3MEn+KAvhbOorxsjGXwja+trUnniweo49RG9tlyWOFZXjCO8tTmp2UyK2JzNSMkhGhwC8aA/rRgcYoHSTpDh64OeQXHkK0L4hHkW68DQo9cebVghRpb4qATDzy/ef8C7dFibYu3TCP7PjtAMELzFM5w/aRIJcyQDZrznR9ZIrmgWR3WmzqwTDkSaMuuC+Z8Bmwm9c6Ep4qn9zgZ2iiQqxmd/qudsVUnXA3fv3lwYugSSBsKPDMexc/Zyi9Rurh0xCI9zmqTr4clXbXGkCCwZZ9YUF9iKfGQ5nefNbk/OJ4qzmpzSIlLeO3Ewaibk4yshn1fOwWUc74hkLRvNzDbeTHbGpuIc5eaHFV7DuC76LTCUSbnr16LDkOh3p4I2bXblM0jKKNQ/2fudliUXJS78ZMdWrTYC8HR9uGOaaXvOihU2F1sHy6pA2oX1C4Yi7vUEup6W6MUbO7gDUxmk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(22082099003)(18002099003)(38350700014)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dLxDkUdayh1NhF+R71rIGgtFfAFwuzZCB8tuRNflDupG1MGeK98hbynaoFcD?=
 =?us-ascii?Q?Z3sP8BU5Oepk6kn5DAkfZP7A65pEFhi9QWFxT4SU55ZT+QxoJNvdIXFj94yb?=
 =?us-ascii?Q?VOG3PI4T3apxxQuT/EBfcksyNyQJGJF1BmxhMUHpOL+9w22knMdnXEzpD4am?=
 =?us-ascii?Q?PFK2fGbnjgRXAdfR3yMncliyXDVGwGxaS1DJIQzv4AQ9f8bYnrZ8ZIBt/hLw?=
 =?us-ascii?Q?IbhciQ1M6nnu1yJJ5kBCOjtlLdKZ6Foftvc1X9MYNf6SBtcwL8F8CBLpKn9b?=
 =?us-ascii?Q?9i60qUhblUQq/jKU9x0NUYnhYkorxjcgwsxJIu3qWUIz2FMA1SPTCW1Jmhuz?=
 =?us-ascii?Q?dx7AjnzLD+p3+LgduWydhXcBO29Q4gyyvhS77Jj/HNNfiMKjT5wET9lBV4x2?=
 =?us-ascii?Q?FindXiCmbvZvVQRFNbMCiYDve/B5xJpc92ntmhYmKZD7pT/DZNZ7zsebwhjn?=
 =?us-ascii?Q?nROGshzwdqaI2cSL65yYD7DNfHeGs4R8m65tOdklj1Ny/1hss443KsvJBi7S?=
 =?us-ascii?Q?sPMCp3CwKTiJlBjXeBHT6B5g3nM1/ipTAscwyeP1J5tK501S6txOeBWbanxr?=
 =?us-ascii?Q?TaC+WwxL0i1UY0nWLJQ97KnISsN3ZqRi7N786pnpg62IbQ0g6Q7M01Ci2PhC?=
 =?us-ascii?Q?aNs/psdiCYbnMU84LOXHl1wgdwXh7D+rzcp3I2jyWV/la1ZRom9cwlr3eT3+?=
 =?us-ascii?Q?+tk9zItdVgjg/eMD4t+EG7y+FrVJXTdFVBV5RYJLTte3vGOFPDQHSqv+MYJm?=
 =?us-ascii?Q?jwpO3+uQB2062+C3sZYPAwWv0nwfzbLP3lKMZ1ladhFHosl4kxE5MkCw2Aji?=
 =?us-ascii?Q?jyBW+TdKY+DK1nfcFI7WqHA4Ye5cIDBXabLUCz0VjuaTHyua7ZXaD5hYT0gD?=
 =?us-ascii?Q?JU6p2G85DM8seiBay9cC0SkGsgcArq17QQbhghf2CxmVF0VI/nE1wXmWcFUq?=
 =?us-ascii?Q?QVCrMCd80PRSPiyngjxEMEroOOgP0GJpfg5JbxeZyuWyJkOa0OA7UQkQq3Iz?=
 =?us-ascii?Q?yLLAZzEwvWMT4yaGZZswM6HjfxLIFY/FdXCcwBVV2fTEftZ7vEcXogn6WQkG?=
 =?us-ascii?Q?i4RtadFDt8TZIbvs8DGSZJ5c29pzXXJP5VFQtiEr/9ZSgpQUBPHoEvlNy9Yr?=
 =?us-ascii?Q?WikjXRmjwVNDppVgSoW+755CUzZy/jzL+HeLpb3cMOtem/E7gGh4LicTBEbd?=
 =?us-ascii?Q?ahmro/mrMdVk/hCmpPSo3iL0gspe7qdd2j28Ogv/fj6+HUOZeMG1+BS3nrH4?=
 =?us-ascii?Q?RwzFcFz77JqnEOUtUIkNKYRlBWAPyB22bHRA2UT9v9smGXXZWRsBmJjr0vUF?=
 =?us-ascii?Q?0WwGBeIUiDCNq+RtJeodtN7HwINZxw93l3KkIg74IClfx1TUfU9NnzKRT/tv?=
 =?us-ascii?Q?ubCAQPTxjHfCF5a84hNZ+WNnT+VkkWQdiBtocctXdvQIkd9ZinpOdWBRzI8H?=
 =?us-ascii?Q?9Bs3XH1xqQ4qe1862hr8PprTYjshYDF++UA6Wl4sXiTxWDNuNDNYn8Zd2qGe?=
 =?us-ascii?Q?D8B/TGuU+4JorVyi97Qm8t8VqwP2A6pntI3nfbsEDW/dkDnA/UBM8i1CeD0h?=
 =?us-ascii?Q?Mkfz2LFSWnPj/FW+cm4QpXs64eLbqBhMkQIQHBk+sR9wgcc/Emx8adwNQ5l3?=
 =?us-ascii?Q?2TDcVA5Zfzze2AlS5MNqZkJw6Ugh4TNEWq5AVha3X778R1hv4p+ywjKWDNTj?=
 =?us-ascii?Q?+EQbAKFjWl6J2XHvf5+lqSdKpiA9dmm8nNka/5OHvCgvvXek?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec1d181-8b4f-4c52-a41d-08deb06803ad
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 20:49:52.1906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Pxs25ADniT9/DCsVyuhugMGWjXL0NVXPcml8ZNUnhEf/PQEj8yLa06pFgEBJ+u9tPMG9CoeLH4/zBEu2Ew2HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7077
X-Rspamd-Queue-Id: DBA6B529AD7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10388-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:12:08PM +0300, Claudiu Beznea wrote:
> Add a helper to check if the channel is enabled. This will be reused in

Nit: Add a helper rz_dmac_chan_is_enabled() ...

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
>  drivers/dma/sh/rz-dmac.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index d3926ecd63ac..c7337cf27136 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -279,6 +279,13 @@ static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
>  	channel->lmdesc.head = lmdesc;
>  }
>
> +static bool rz_dmac_chan_is_enabled(struct rz_dmac_chan *chan)
> +{
> +	u32 val = rz_dmac_ch_readl(chan, CHSTAT, 1);
> +
> +	return !!(val & CHSTAT_EN);
> +}
> +
>  static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
>  {
>  	struct dma_chan *chan = &channel->vc.chan;
> @@ -840,8 +847,7 @@ static int rz_dmac_device_pause(struct dma_chan *chan)
>
>  	guard(spinlock_irqsave)(&channel->vc.lock);
>
> -	val = rz_dmac_ch_readl(channel, CHSTAT, 1);
> -	if (!(val & CHSTAT_EN))
> +	if (!rz_dmac_chan_is_enabled(channel))
>  		return 0;
>
>  	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
> --
> 2.43.0
>

