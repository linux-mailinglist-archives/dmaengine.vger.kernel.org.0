Return-Path: <dmaengine+bounces-9089-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNPQC0sin2mcZAQAu9opvQ
	(envelope-from <dmaengine+bounces-9089-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:24:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 900A519A8C2
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F229930484CC
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBCC3B8BC0;
	Wed, 25 Feb 2026 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hoBdHiRU"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0169A29A9C9;
	Wed, 25 Feb 2026 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036638; cv=fail; b=nIjV5zHDZMaFqSYdO8mTvWtiIT5Kt93JiLAm26mqpNA1HsTvGpH0q/k1Kr1J+hpDarguLMruG3ZsK5xrUZAxSiVepJlFIVRkQ6LIWWcb5i6OvjAe+sFIbfEbf3N5X7AIcmW6OFKv5zvjQhJbSqHTMrBKLDVPFY5e2Jq7Y67F4fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036638; c=relaxed/simple;
	bh=3+j6HTxUbY/lWKFxCzzx/Jk5XNSK5xdZzojfJ+68xYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UQsNUUgjKBQQnOpuIli2+H2ciG90+jTtS8wiV6qGW4j7mNX4xgUdTOfl6BYSsFudMy8hRtlEdcNYvNxfc+RLdv9IrPAU4SAKhlp+U2TtvHJT/Nws3yJcpklYz+JTfewnzKUJFOwjug66A2yJm4QMWCI8cTuItsRNL2UI/n7vrM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hoBdHiRU; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxlVTBCoOUhs9bGtw6B2FXNa8fcvzhFRwjSAdpQSKR1QZMQB5oAHbwX+q1HvJifN3e+DdKofLrHagJlk26WkTVSNGtj89lC7gOPRfjP3I4oDBwWBUQiSWDmpni0yLQlRCnmGk5zyvNd4EfAhuZ3ZOmqr78BZENOIkVnt+X4xlWtL4VtQfZrccoJfblEs2ibuj0Y6xCGADLtQBZYTsjkR67fTyOhrP5vwmd96ZhIzRGQFaTaU1t3be1PH316qPBe5ftaSyuRAY3Dy5yw644nvaSuwoTu2DlErhjJwdsCycUCg7cZOcRu0Zf+R0WqPhhWbo/pyPULIsXny791XKUxfXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McF1J4/k/KYguELiqav600tQaYmfkWc06kod9ujOjCs=;
 b=vF+r4cUBFagEBP4m1kJ0c9mEx5uWipvh2nYpXUJxLNF9sgy3gs68Z9yL5kreC8Z60C+8G0tCskSw/qt5GJjogenCGecYcnt62o+fnYbUOy5IN/bACEpY3ky9bMJyGUbYrOQMcm6R8gKcKxh70kkHEMUpQbVxtQPB5E7Hjd/hDrNa/2gYWvF0Jgn549w+TX/h62a7bEJmiyDEzYkTWZVqTv6UDDbPP8ituEPUvmYRy3rYb6j/pcfLJjdKfVpdDFxTy/kP/AxZzVFC0T8LTmmrwY3LyZ/8sDtcTRNapPCAf9+QXBL0PPgYqbbRIh+Nxo/BJ/T/6iefbsPygNMXr71wVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McF1J4/k/KYguELiqav600tQaYmfkWc06kod9ujOjCs=;
 b=hoBdHiRU+a/nerMGkQC83r8rQbE2wfFntg5tK8UiWaI4b6xN4TpqVWLo671lhXRKspfQcx6bVReBdN3UmhUYLZzsFzQXHC+sE27EgO3zotD3rAwplgkaFPOq6eKi0O2mTE/h8/fAzRbpcV9sehDg0jNCJ3z8jKIQYQdoihw0Zc0FbHLMFJS+MckqOqt/ZA6/0OeaVol0wtnQFPUewbkOyPhsKm+gHSWUY2x7ARA6NJj0WFjmpXBTXzb1MFpN8DPJ9WhduBabRaYWENKs/sxcbYVCiIbqd4mAK2KnIqSoDEXtDCt44qGEKNATce5fZN8Tp6F9ccgwsTOCJCdhnXRfOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by OSKPR04MB11389.eurprd04.prod.outlook.com (2603:10a6:e10:95::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 16:23:54 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 16:23:54 +0000
Date: Wed, 25 Feb 2026 11:23:46 -0500
From: Frank Li <Frank.li@nxp.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, geert+renesas@glider.be, biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v8 5/8] dmaengine: sh: rz-dmac: Drop unnecessary
 local_irq_save() call
Message-ID: <aZ8iEn6kGSav_lrZ@lizhi-Precision-Tower-5810>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
 <20260120133330.3738850-6-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120133330.3738850-6-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: SJ0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|OSKPR04MB11389:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe76645-cd20-400f-bb11-08de748a44be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	PsmVmlAQ1+CnOIN5FqUDtWNSJcOSbh+UAf40eV7SI9pH5c3G+KlvpnNxx3BqNHhZHdZv9w+M0BWonUvxL7Am4wkRY0JxMgjgM8GcpfQVRw8iucfQMmYURxAWbWphXP3zVeniG/lspmWQ5gRNiKF90kWQTiwUKTB2gNBUBgXZBE/8atWxmIpH9tYDPgWolrnth0CfXxcSdvQdHY5fzjAp4eKht9pQmQmWLolPyFbnVIDn/NWWC+XSlBg1Ty9Zmthyt6tZy0F6ioCIpMIB8b33gWPiQk7I8kuXpd/rLoNZCO4rNNVC2hWrcXk+GC9uZmZ0pX1k8bfauB92c5pi4pjd97dCPyolFJ/im7C+eCIlWMSdCqCMhKHq6OvKQGFXDEke7CSmg6SZSbVtI3ofprcYRyOyEUSVqPT0j5ka3Z2+kGaOnyVu9qLDYFu96W2Q1Sdf1L9NhMQ11go4bu9Wt+thTP1WTtudn55Esb+IhG1vkd2UoL3YAvy0SoKngOJDLfHyeMhwLSzXYe6LeYPTqIIERH+8My8rUGrxQuBzE5BwckUIOHyl4Dfd998bP5HgefID2/BSDxXd/J+B7Sq7njzYvSVjcgJeC8jlAsdojdglGE7seAhvwRO13FD7Eed+uf1ERzYJkbqw93tU9xCTXF/X/ADQ5mHiST1ZSaNtsNP+1I/3v6VqxgJ+8R4iE0Jmw3clnUJKnMDtmFT1Xh0j4GS9OC36xtbOmtO8udKSiCmkmd33FGoidaXsXKHwasOeT4OZ0DhvKG2kLwx8I5G9+LC6F24ItKhvDbQOKVoc/Qzk+Dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6RYhYzJfDNUjIQp7q0xV1ctyvvbl2qhUPio8qyx0ZNOIqmBnoWUvnvGHM6Ag?=
 =?us-ascii?Q?vl5o3VRXvPibDFZOGFwXeivdpGdSjbpzYuC8em9f7jnBj/Z2V3dym28G4D/w?=
 =?us-ascii?Q?tRjk/5DdELwvjIoXRHy4CUyibJlVEJm8pTlPqAkC5MnqiwWSgJZeU3bHCv8Q?=
 =?us-ascii?Q?6sxhQ4lVplVoWKYjiNNmoHiv3adURuc7L5/EpJw9l9dsQ5qoIUcqfzag6wYj?=
 =?us-ascii?Q?WYrHbLUGkk/rtA1mcF950KFrx+O51oB7RSjAb1tN4OWkTiD8t6fwo0rqDMFt?=
 =?us-ascii?Q?qyvQqEaWyDIsWbpDAALeyvEbCvdPx9kR7iusYzH0EmQA2RK3KBEPQArOWIIu?=
 =?us-ascii?Q?ixz1HRWwJ1xDeycyzVCDzKOC3MAO41dnKQGhcuEUC82LrY2LtAcLtv3JuOrj?=
 =?us-ascii?Q?boYu9J98cFTVe6FvWf7oDCS4PGS4xGhMbqag1wMh3xcBTzsujFmOubVRSjql?=
 =?us-ascii?Q?faeV+Acch3vLdmMypPbs0ktYRljgTvwMt/7acE9lNvWfiOXKtjQSQAMueAS8?=
 =?us-ascii?Q?aOIzZ/xV5wGtXR9BtJtBI3Ulcehjh3jSAajSPWDyuF/L441dutxOdUqh5qr9?=
 =?us-ascii?Q?VrSG9CMEfQU41gUNOkcn6md4aXcgXRv5y1Xtyx03BMH/4pbfN5byaAvLgRow?=
 =?us-ascii?Q?Zm/bi9VZ580NIxj7JSK6M/M9XSvM5To7CarlJz715xLXzqREbkUiDRrTchAj?=
 =?us-ascii?Q?zkzK4QXfarkTBbK+VEPJqao9cZ/+dxdM7U7FVxMtT1wQowCGnv9PNwG2V+j7?=
 =?us-ascii?Q?en2raV6nFYHJ82ULpQ+DJ7qP/ceWsIRc15sSpDBq12iwo8hF5jSwX2naZSVm?=
 =?us-ascii?Q?GIXE7lP0AAKHVhc6tSL3RbJavb1Xhx/QP/avRkHatHlXzt1HoKtpV3hbX/3o?=
 =?us-ascii?Q?tqtyMoJQkTMiX/KyeQNpoQNiHqSYMo5+7/nVljagctWtG+LSkd7PfR3djiTa?=
 =?us-ascii?Q?2XdsRqE0p/AA/eFwWoMNyxSJzphUew3mVW5C1e/jPxs6BBrd2KfbWAP7ctaC?=
 =?us-ascii?Q?2DGwJuM9MCe852CTQv5gkR/XwJicRexnPhNPXpKly8gYJmW1Kfh5Iq9iYDgR?=
 =?us-ascii?Q?qWmbHlU9CXrP49k3dIql6V3iN4YMAXk7aGTKkT2mug0ezwjd41XGgOwreyxf?=
 =?us-ascii?Q?ne9W4N3lUQGeAa0DISe0dmrwxks1/OimqOYr3IN0lth9GtdkezICr+E2QkQI?=
 =?us-ascii?Q?X6hN0JS1dV6TGEwszWu9vctSVljj/pVklUi/rPJqm6LKjxDwu4h+iu9xpv+n?=
 =?us-ascii?Q?zLUSEciw2C9MS6np8T9uheFsuqJRU1xGovcnW9dfmc63lqWCkbPS4cSmSAJ4?=
 =?us-ascii?Q?oIvig6t/zfLRy1Zpaz9icZpPbWQ3s81qK+SIcAJ01ws+xVEsErqHOoRUfIgj?=
 =?us-ascii?Q?nuePH8hGkvpOOlOeBwjI8AiVmjCNfDxqOl5N7Zn8vI5oA+vkarZPE9Hkqs5J?=
 =?us-ascii?Q?fXs4xi8KaO+lbHS4pq075Kr2ZKcx7C2u5iu5k9cqTnAhFQ9mj/yF+gFa7oMm?=
 =?us-ascii?Q?j3S53vO4il8kWD1JQ5ny5asGKLkWABJCdA+4cjpR3r1ftukhqruiSZ5NVi+Q?=
 =?us-ascii?Q?QNrhRNgo6B6rqi0+81z49Y8YJnp2hFX/2r5Hyau2hmjIvPqsDm98FE+OgLpY?=
 =?us-ascii?Q?f924iXF0VVg5XDrLl38pY6/qKFMhLIEOs//b/UzXINiJzTJUloedH2dXBgG8?=
 =?us-ascii?Q?xWjXUT/q/Xqm8LaRp3k5nRkIzXwqTjoCOR7cUmpEES+qk0ER/vWxnu7PYUqW?=
 =?us-ascii?Q?Kiz6MYiNvw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe76645-cd20-400f-bb11-08de748a44be
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:23:54.2222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArT6rShyZ1gTShr4nWKa0zdEXvAqujogldL3V+EbUBzKURxo9oB7hXFUHHRJbJ2oXVuWGWx0C2Hn1baF+4d0sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11389
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9089-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,renesas.com:email]
X-Rspamd-Queue-Id: 900A519A8C2
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 03:33:27PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> rz_dmac_enable_hw() calls local_irq_save()/local_irq_restore(), but
> this is not needed because the callers of rz_dmac_enable_hw() already
> protect the critical section using
> spin_lock_irqsave()/spin_lock_irqrestore().
>
> Remove the local_irq_save()/local_irq_restore() calls.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Changes in v8:
> - none
>
> Changes in v7:
> - none
>
> Changes in v6:
> - none
>
> Changes in v5:
> - none, this patch is new
>
>  drivers/dma/sh/rz-dmac.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index cc540b35dc29..1d2b50d6273b 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -273,15 +273,12 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
>  {
>  	struct dma_chan *chan = &channel->vc.chan;
>  	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> -	unsigned long flags;
>  	u32 nxla;
>  	u32 chctrl;
>  	u32 chstat;
>
>  	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
>
> -	local_irq_save(flags);
> -
>  	rz_dmac_lmdesc_recycle(channel);
>
>  	nxla = channel->lmdesc.base_dma +
> @@ -296,8 +293,6 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
>  		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
>  		rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
>  	}
> -
> -	local_irq_restore(flags);
>  }
>
>  static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
> --
> 2.43.0
>

