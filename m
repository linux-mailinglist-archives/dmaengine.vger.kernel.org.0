Return-Path: <dmaengine+bounces-10392-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMzQL9qhA2qe8QEAu9opvQ
	(envelope-from <dmaengine+bounces-10392-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 23:55:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6452452AA88
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 23:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B5E730476F3
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 21:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D32C394493;
	Tue, 12 May 2026 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GRbuYLJI"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF445393DE2;
	Tue, 12 May 2026 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622935; cv=fail; b=fb0pmttlQBOUKFtRNkDPGr+lo5xkAIstPhdGYkYrVFStLxxoEIXVCrjAm/iutnoqkXmRNcSBpMU9ndIfhyhx/IxfkCqwF8Grd3Ch8EUZCBwWK8mH08ErYKteX9hPTgKUnXWjrSjRvSMU8KKndqz6yfpBEMOjlZQbYL3lmMQepnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622935; c=relaxed/simple;
	bh=SgYn3rw0xNG//Azu6cWSxImoJlL8wcrSpk4OSLidMX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N91PhsyWSoOdfgvr0kvBffQfc9p73qXbr8OROO/CSIdLwUxXt4MPmbzpfM+Br87DUqJumBvMT9ed6wxavkib2B0/tquxVhiChx5E6ZTVM5r7RSReDMfPkutCfArfpFlA+RZieHvmB2X3a4QaJvNUzCacMyj8bBbhlNk2oAv5ITU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GRbuYLJI; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbFM7oOuN6w8msNmudNvVmAv9hs1zF9HI0P1cfkpDC7IwN+ImUEBfXAXv9R76/QIS6CjndY2+/b7wwp+IjCwlsN2fG9RXExBtKnmfb+KX3nyJPkL8kZ2mG4v4Z1KdpZakqvDvswtZwykiYjhkbIVUCet8g2UwIEKllE+W5llmatrTrYAyHNkv0B3bR+Z2nQmEv9RSZoe4PE3lQ1A4loolayXmEaC7Cb+DKLQMeS6jJU2s6DZW3U3Dncw2gWeQ0GDK0yDq8jIB/GHcB+hncw3rZM29qn7K5hQpthtXdIsN1xow68ancWc41++0ceaSdO1Y5e9B95sszw1GCrsuMFwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYlaALo9s7UiTejCFHuNWXOfykCkbBTPNhLphXAmheE=;
 b=sqh1SWAdhOjZCEUFzKBAYahOXDYQ6AsoDkVH9Ag59GB0SLA2s6srLGDqXY/uo+apWHxwn5AfmV2Ih7gfie/ZYc7IrL6vXz546q0GPGmabZjLHokRU+LX+wRoYqKj9PrDJYv1WPao+8B41abFOqnQmSAbQ249ZhQbP2k8LmtD36z8f0mIU3ozn4ep5qYUNAQkrnEUJhgIAvU0vY5oe0UakPfsFO+0vkNpBCRTPQ4gyERCcQ6V37QMEQOFteuqwzaEXf6gGREgp5U+7hf6hKT8Xdy8brTX1geQ615JYcN004zOWiiNVHDbFAgKHyHaJprz6KyNq/433vwis9cX4b7siQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYlaALo9s7UiTejCFHuNWXOfykCkbBTPNhLphXAmheE=;
 b=GRbuYLJI9hk1Dzol1JllQZhI8ECMMyE1Im8k8VkaI/rnrhUPJpxS58N1I/b5afg2cYQReGmusoSko9zLQQlewAWP+J6WCZqLjU0BP/q2jNe6TQmPyuFl9GRIKBjtrYj36SGFxJTBorK6iOk47rShl7+VAWOrUE2scpUTCfH3xRfmsapcKQ7LHfwHj+DPfFv4p5mbH4ON7gxdzt8KYKyPyo0Puws+K/nsk+/rJGpxHxifhVyH5PvYOqbuP9INk810Bj6Wx+zW86iMTUx6Fo2f0krTM0Gx0bdNnSzQ0sIWeFxjp06BX2s7UL7/aXR8y8HJNT0HANp7qVhGBjj/B70naA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AMDPR04MB11553.eurprd04.prod.outlook.com (2603:10a6:20b:719::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 21:55:31 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 21:55:31 +0000
Date: Tue, 12 May 2026 17:55:21 -0400
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
Subject: Re: [PATCH v5 11/17] dmaengine: sh: rz-dmac: Drop the update of
 channel->chctrl with CHCTRL_SETEN
Message-ID: <agOhyampffMahpDn@lizhi-Precision-Tower-5810>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-12-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512121219.216159-12-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: SJ0PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:a03:333::31) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AMDPR04MB11553:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f63a06-8ac4-466b-25f6-08deb0712f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|22082099003|18002099003|38350700014|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	b0Ifklo7jrEoFotmkJHmzuTWD+/M4L6vdQLUm//AM0+Aq+f0ozgpZxDZNuK+07NQgAWafcgMmaNTY6CY5xlTQoUxFnlhFS1Ze/Zzxk/F6MmHtiiVHy19nO9yqyAQdat0QEFSkkYfu1iD6di6CmzH+T8DM/aYq1CzsrSceVDwHmmfEhIGgoE4gTSveIK3TwK8fXC+moU3MYTNVKv+gvW6veNVhfML7UOJWz9iaYatno/foEKPpbnxShPU7RA1pXUMArJTkgt25uDZ1I7S+RJ5Nt9mY8GbcFli/YtQQwJT6gpZ6H1lcTJ8KBBlJGrDTR5DYIb+Ct3G2tu5m6wZ/WkNrkrMdi1DtUjj5C17QDnAwo7RgouvQHvQSqz2xj4/aikjvZLY21/BI5QoxNZFEaX2lw0m/Xt59g/fzsSsTmd5oJjPBv4o99UQKQaSZUrXNeQzOdjWc/AneaGouSA41ndUO4QgB0Ik8UsJ3mPFH1p2Wo5E5Y13P0gesCgd02pDB0uTDTLp6o1qsbEjjQwpZt2UcXZ//ERm8G7Fn5sX48ynFCWbZxuYXspBJORzsIk5LqVL7Sp16JN1e98bKJsnbTLW4l1s3JIccjbOqA0/7zUkKsuPwWp5rm9tnVKbA1o5YXJmxpEIC9zn3u2PDIxJzPB+5hWqgxpKn7E/WbTnP4vWATgh2SwkqsoychKJpCqReQmIGVn5Loc2uqDYpMK7ifJ/fyvr9OWdetCpbGF442zA/FgM7fIfgYNZ0f5hCwr9D/mb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(22082099003)(18002099003)(38350700014)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NfXOGMi8Jepgmwp2B5XqKJAZO6HJFFTdXeL52kXxgtlxiiGbQ6fumKpXSt8q?=
 =?us-ascii?Q?wpz5iUSq1Nqx6hXAMj/IwbNwpPSnAAYZoNhPCYXctknBpSh9CioZn33ewub1?=
 =?us-ascii?Q?M83BeqM1Zl2ON7hLvZ5HCZ4oqk9CtrMT+gIZBJgPutP2KUcTB/Ar/io/sG1w?=
 =?us-ascii?Q?P0/iFsEKxGxItI4VC7cJqzHzQTqSrnQqa9LaHAr4eKcLWwh/Q8bG3l7FVfoB?=
 =?us-ascii?Q?X1+KYeOAsURyW9BMrL4fjQghJcfNjzDl0d10MoTzvCYzyP/LiIt4U8bKojdA?=
 =?us-ascii?Q?ZuPDL+cvF4jXzY4md+lBWYadJ/EO0jvNBratVWoCjQE0vtdz+sGH7cwBnG6e?=
 =?us-ascii?Q?JxGTSegY2ZbqKjkmK+XyA+zaWFiVc0hh2eBvM7+n1eIOJW6Hc8gTbadm7zcO?=
 =?us-ascii?Q?Sbv4cUugFnO9aIIi/EPp3eGDq7DRclEpuahQwmnUgoHMqkVlLLGjroFHh/+/?=
 =?us-ascii?Q?26Vt+aJcAvnsK+i8Pjec6ukpCgnXzlqvgqtDigHSmgvvsCkrxSmauO6t2+TV?=
 =?us-ascii?Q?XW5Ul60TteewKJ0L65YfJWokFM2iwH5gRMpTKaaYYUHjG1ff7BuYbbrikVgY?=
 =?us-ascii?Q?5gVXER3yrMRsEZ6Cxc1YiLvVQ7FyeBH4x9NBpJZ3EVxI7uDtZkw1+IR6bAhT?=
 =?us-ascii?Q?2AtANMAaRAkoktA+cLfeScNuVS0en25WdJv6s4azFOD5eV6DKSO4/JQ6fc+q?=
 =?us-ascii?Q?aCYDSYbVnmSCp/WfLUi/N55i994dHPa+A7j4J1eN5ZV8OgytOVgI2269SrIH?=
 =?us-ascii?Q?SIPaWjycxbBWBsnerJGDsdOsG549HdBlILX5pnZUwWnqdZzueUtlIOflEg3F?=
 =?us-ascii?Q?go/rPPeAQRevWmRdF+5PdQx0kZTgjkMmrpDVeG9PON+JgXkgdbFCmaTaQjHC?=
 =?us-ascii?Q?jYxmdqKrFwg2+Z83czRNFn2mPGcAQkBWoZCpcA/f0Hg+uUFCqu97GXnaCmiz?=
 =?us-ascii?Q?fn3jy04KHOc2a9qla1vcKDwhp9Q2UB5o5K9tkmYM0xAmfWdVm3WVeioil+EB?=
 =?us-ascii?Q?7MUBrxkvXptzHfUupDnKSGenIlHrOcMMewjrls+Kf2uGWI7LYuhJob3xVt4q?=
 =?us-ascii?Q?5vGqsibWMhA5WxC0W5Q9bmGUpSWwEEnyqPufzC/IjQL30ZrenJ+R+SQ03lKF?=
 =?us-ascii?Q?2zYKds3jOWsPVrWRhy8XkHIzEYas/uxKQLUYfKtvyEgd73gQcN1J4KEyGOHs?=
 =?us-ascii?Q?Ut4LfKN3kw3BGGgG5L6bEhUkavbQBW/7Tr0FDqBNAzn4810VbGW+16gRE0k3?=
 =?us-ascii?Q?8Q89CdmPv10jPUQvhuHhs2Mlg6AxeV4dOknpF+brEKEBq/yEf2kMQJN7QVNo?=
 =?us-ascii?Q?uzGFSFK5zacGxAdwGntMt+Zl7R0b/e124ADIXW78zVZL8/6ItnR8+DVB3KFb?=
 =?us-ascii?Q?ZN+Epy49CkD5Q/Rckdj3UUNxooo9PKJluNcEYuUOmmKzOXqEm8tu6tXn+7hu?=
 =?us-ascii?Q?Gdp7ixzoP6ovJeZoI7+5Zgq7IejFadp63qZDYW9P1NSyfYUkM6gqvTrZLY/x?=
 =?us-ascii?Q?LTVgFifQkGcCGVRKhZ3GYxH8i/L1K7dxaytOt2eKtZA44KOPjB/Z1zUFqTVX?=
 =?us-ascii?Q?RuCz/7VLXLT039JDmprLcefyAS4OSNYagPL6A05PnBhQJSvHORkntziDwAEZ?=
 =?us-ascii?Q?sbD/ERAAVXTozTyjXgmLfb8nTFSYSaQYlKmOWqwYbi7DFqgFYlAwSwyClhxW?=
 =?us-ascii?Q?1b6nMTTfKMOGhgCWQ7K0n87+gP3nODbQg4gnnUVghUG9Kort?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f63a06-8ac4-466b-25f6-08deb0712f57
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 21:55:30.9138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdzYLsxh/h8RFsj668accslLFlqcTC5zwC/lbeTIUKd/PqLUY5zM9+j92EktYcvXzk3eE0WqbszlU/n+Yaxz0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11553
X-Rspamd-Queue-Id: 6452452AA88
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
	TAGGED_FROM(0.00)[bounces-10392-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,renesas.com:email,nxp.com:email,nxp.com:dkim]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:12:12PM +0300, Claudiu Beznea wrote:
> The CHCTRL_SETEN bit is explicitly set in rz_dmac_enable_hw(). Updating
> struct rz_dmac_chan::chctrl with this bit in
> rz_dmac_prepare_desc_for_memcpy() and rz_dmac_prepare_descs_for_slave_sg()
> is unnecessary in the current code base. Moreover, it conflicts with the
> configuration sequence that will be used for cyclic DMA channels during
> suspend to RAM. Cyclic DMA support will be introduced in subsequent
> commits.
>
> This is a preparatory commit for cyclic DMA suspend to RAM support.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Changes in v5:
> - none
>
> Changes in v4:
> - set channel->chctrl = 0 in rz_dmac_prepare_descs_for_slave_sg()
>
> Changes in v3:
> - none
>
> Changes in v2:
> - fixed typos in patch title and patch description
>
>  drivers/dma/sh/rz-dmac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 2bf796dcc5f6..2de519b581b6 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -377,7 +377,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
>  	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
>
>  	channel->chcfg = chcfg;
> -	channel->chctrl = CHCTRL_STG | CHCTRL_SETEN;
> +	channel->chctrl = CHCTRL_STG;
>  }
>
>  static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
> @@ -428,7 +428,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
>
>  	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
>
> -	channel->chctrl = CHCTRL_SETEN;
> +	channel->chctrl = 0;
>  }
>
>  static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
> --
> 2.43.0
>

