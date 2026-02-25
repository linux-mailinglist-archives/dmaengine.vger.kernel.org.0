Return-Path: <dmaengine+bounces-9088-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBmKNRAin2mcZAQAu9opvQ
	(envelope-from <dmaengine+bounces-9088-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:23:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4500A19A89E
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BC8130115B3
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 16:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC2127E1DC;
	Wed, 25 Feb 2026 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ND70C3vl"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A82820AC;
	Wed, 25 Feb 2026 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036603; cv=fail; b=RT2oTK9zHdgMHE/7RbX07jLn4uiWfyJyZftVqF1Bk+Ru4wUzW2Yr7k3OmAauaZTHl5/y0DSdCSUN3wVMbQOy3awlFuim1i72188QYa/1uz3E4Aj63kPBWm2TnhXjuLFUQ0lu6c+zoVmWsdByCldPtd6zmX99GO9o2U6IaQ5P5oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036603; c=relaxed/simple;
	bh=pLo1eW+0jS+lIxhfRO6Es2mlaIFkOikzB66lAllCVmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BHZnxM97bQcImxgxRYNC8chSF2E+62RInaNl+7LAnwCyG2zdfW2xxDTRNrefXVMxvGHE4zkT0nXMmsnwLMOkzWK3DVrMw6SAFBRhPQ/41zsbaUGyp8+vwIKEwI7xe7ZMtEUQKp/hz90Jcck0RTGkHiZvWW3n8pUNhJvKwwDSlv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ND70C3vl; arc=fail smtp.client-ip=52.101.84.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gu7HzY/eGq4DxhKkwHDmuHBWWZKti/y8V0VV1Qs/LkT+xX0IuOoqle6DXF/RjU0m1lEXYO/Wmp1UJ3Qolukfi7gkRVmDF8PnDbMcW0unq1FyFa8Kj9wUxCO5eANrjVjsWQDw3WaUxakBcCMNlM533flKdPacaiO5KDV0/cbr8NAlQbtV1n1jTSk7Vsh7QNqSDrd4r0Mek0GrpnRSoC8i4s6+4cIZL8hviKJX7iov2EzPYJkXrgzOmgUTmPkDF0QjLlbLVDB52XjYmijEs5fOAC3HKhrKEc+3ZDkQn+NnwbnMa+K42q2rAAZ/Y6CM3mgFmK1vovaQJgDZxhDChgadwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DS3VCBAgeCVGuWvNHIw3HCNZY83RjyQe/f3Y7ilAlDs=;
 b=tzQDm4ZiujijE97zv9q1lqgY4bf7FqFfgpZWxJhJRD+nP787sb9dW4Bph+Z/Vm6DDvBUtIvBoPIksNiXVStRVIqs6T22w9ID8YouW/G4EKSszcX8H2rEAkfzkJ6uGaynwoe7+o1bWSFJEN8qBKGm8BFEcg9Zbro/rMRsYBD88oUc4Sxiqs536wkRppkwdbY890yhVMg6j/Lo7XPEBlNICs4PkNbvsCVHzGv87j5evbcZPBmpKE6GMFPnZ7ipDbR7dhE6co3+meqry/t0CVGiiRKBWuhCbevoEPrBwuQGrNT74aLg6B6FrdSmtHq2O1G16qs/A9P7nT0PFC3ZV4NQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DS3VCBAgeCVGuWvNHIw3HCNZY83RjyQe/f3Y7ilAlDs=;
 b=ND70C3vl/dEAbxmJ9OsoHkV44epvKpsRDnDcvpOPI0+XDvm+xTgVpcrfgqrzTqOrs1oDVRy2z09yuN1TknU/6CcrVVKLTGBdesgimXE1x7nB4ZsLgKaUpeA8anobOl/nU7R2f7o4Ju7H00R7vAmOYWUS+zrrf0feaXGr3fWgtv/SB7LKGc/rWnTi/u/fuXMZMaP+kQRavEORl7kFSSwQbfQm3ec3pJ4v7G0hVURgoe69PI91m3o1ZcOuGj4u0d4owCgnCC2b0OuZ4KiJ6dVcLUer9GYxQ3vgN+xjH6cI17n8EoGxy1FNXK53ZRePwdcUOEk9swbrPDe/DdrzJA1hRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by OSKPR04MB11389.eurprd04.prod.outlook.com (2603:10a6:e10:95::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 16:23:17 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 16:23:17 +0000
Date: Wed, 25 Feb 2026 11:23:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, geert+renesas@glider.be, biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v8 4/8] dmaengine: sh: rz-dmac: Drop goto instruction and
 label
Message-ID: <aZ8h7kKjm1-FW7en@lizhi-Precision-Tower-5810>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
 <20260120133330.3738850-5-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120133330.3738850-5-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|OSKPR04MB11389:EE_
X-MS-Office365-Filtering-Correlation-Id: daeae983-5ba4-4f15-89cd-08de748a2ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	/DJWsvB61WRCvsM1bjugzWpXjZRedA5PsoibCH1bzwQENINn8mRNUK0SZJGZC8X6h5XVmMCxLMlNV6a2dYUa2Pvv38RKNh2YKZo0rxJuIu9wiPKkVWg75b8iUYbMxuxXpfZiSS1vRkhjopRBfdeq0MXPV/nVULBrxRf8t67bTwNNcCYGACrx1RKitYX05to0CBO/i+HAdTo01RKF/MItZB49zUbQ2CTGWpf+AaA0h15zaCSZVta3lsc5snhcz8MuJBQhWXLv6kaqfr/9+N0Z7p6hF/WO3CiMgaWOwjzDzsVnDDeCdgC0KTmGkAn6xgvMkqSeTkFT2nN2nJGoKnRDzxRBjypUttNkrrwXcsLl5ANXRTUO2DqHj32eG31xVdkKAMPbWTxX/Q2eKnlNSqmL7ZiURap4QUfzLc5mpWaT1RUj4+dzdPRS7NaeMSll/1d6A/gSQwrQm3JkJLzhu0cEgjC0TJFxvSOnsns+hMQ5EGBiAUZZf/f2RGpispfvaylJkIplqs4XJkbdYduJ4XmJyYR1paD+yYx6i4IB5lWzy4isgpnswieVWgkZQX4sDpKyNph2oFn4ylspx7cXFpxnnlEd+yGgMA9iUdTlKCgQubQe8cwhVnYzxk8dt5AAozbo40QdvnzEss/5GbPFnmSZgo3oVuFev4vF4Rs5RyF8wy5Ec1nA03FB2i0GkPwv5ce37qgYo84qxQ2ODFqeeeuMnyNww5X26/bCf+oE7tOWSeiqTDemwq/tsri1jTEii3FAaL9VdJvV8e8XJWYw1NoqB5Enr1Y7sDxhP9DsYfLODLU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r0eC20NMoSlPAXAtTv2JOirZhVk01paEjJfjZPLz0S6q/s/DLglvy87QCkNF?=
 =?us-ascii?Q?eEjW/iPiSindG9MRE46b5F9FTWPB4lQfzohIuzblMoZjMRESraiEHJFVu9kE?=
 =?us-ascii?Q?qNsxPGPZZWhRlnnX4YJevfy8VZDAmuYu1ap9gnWdJhAnWKe8qLhhkpE/7Gaa?=
 =?us-ascii?Q?ov8Gxdj3dfuXc7ZrqEaBWUrqp79XdqKytgGvYVGRcLshOZ2NhL8q+5YWIyqI?=
 =?us-ascii?Q?DRUj3yewHlG//ce0sWbTS/PRiAgpMe1jDXGdb78/31PfdLOtobs7D4xZSAUl?=
 =?us-ascii?Q?OBoOiZfs644rZgog6BFE6qQeAMukgTMn6mRS3ZJ0kseQtSpMjjDi5xdJoEmd?=
 =?us-ascii?Q?jahaYgrc24CY4smfMT/8KRsr/CnVtA3+A40gPzRnfozSyBytuQT+UirdTpb7?=
 =?us-ascii?Q?w63FKMxQkOnJYICuY+4416m5U+JLWBDkxZ2P0Mr81un3rCEEE6h1jPM9nfFZ?=
 =?us-ascii?Q?znsmzzSmVG7WRAl/MUlxkJdsVhwl3Q7QZeKnOyajaIHMG9Fd+br/G980iSWH?=
 =?us-ascii?Q?TKWLlM+loGSI0r5EHE0UlxN3NEI2HCBR7XO6uPsR9GsCPiKn/jdUszx98OBB?=
 =?us-ascii?Q?zUspxxDvKbC5j4fu61HsRwBsNTFhfBt+g9PnYvDWilgHLmYdzub+Njpzcuty?=
 =?us-ascii?Q?4STkic+PZ5ZSeie+yi/WJ7x+bk+gs8TMevyrxGp1fh1hwNptm1fxi5di1vLj?=
 =?us-ascii?Q?t+tbMcmNMGpn+/HIV9fmX8Es91nTrgmGJFgi7J6UQC0OcXnU0K27ZMk0NUKs?=
 =?us-ascii?Q?acGs/fzK+7JWac0Os8ewdXtUxmVpoLq6pXPk98UqCGh9nW15FNFknyRDabck?=
 =?us-ascii?Q?Bo6fxMmIVk8ESdNqpQFXgpq/uRJDMHPSOG/ygRTxM8RbzfocpXL/i0rOMEgs?=
 =?us-ascii?Q?OGz3vNaQde8+RVtil5azlOe2ysL0+IUkEOqz3zJMXC9yaCu+U3w6nZKE5O/y?=
 =?us-ascii?Q?PhgeKENsseWlKZyny4EB56TFuB3deGR5yY2p5R+TZmF4ULJYsGEujUSc6jl1?=
 =?us-ascii?Q?7pFCID6CmFvUX19ZXwAyLEYXnufYw0X2MI060XjV9bwWrO+lLDwABOC2ET8k?=
 =?us-ascii?Q?azVaH7V0ZZpNm3DUIjrtbXTjyIfwlKqFvm297ZiEBKHGSa1mO6dF8lQNqpDB?=
 =?us-ascii?Q?TGNa9v9cX9nBI1EEN9wTGud4oB3UEorbxkuV6/phqpvHObFArTUPEV4p3qii?=
 =?us-ascii?Q?yHsZPwn48PwbNzVuFizMbj/yVp311jRXylyinVtlv2cHdZiBXIVf9tFh1IZJ?=
 =?us-ascii?Q?1oKw+7WnRT81hYNO8ZrKoHoJ8xoynWRYJ9stowWg9UWZzwuTVp9foRVme6jY?=
 =?us-ascii?Q?pMUnkJsXy7SQDKaxduDdpH24xQOumLjTqUEE5O3bRQoqy2jy+CpVHvrDpgNW?=
 =?us-ascii?Q?9GYClL8AGl/7hYGPcK/e+ycWk+w+VB1FQ1rQTZTHf4TAnPxQ9YNc2l9xdd43?=
 =?us-ascii?Q?5qZfyxKHEKxIX1EgssqaSh013oXAKMOfVaZUalH7m+9Iamzu956ZEYuFfO1q?=
 =?us-ascii?Q?et6+QonOXguoMqQq35R/mf1y+MGt2AZsgeSMYA7FL13dXLacYnECp6ZQ461I?=
 =?us-ascii?Q?krFFdyJoiA5xwgotNmT+y8ZiX8ncaUMuRVe2Ez/U3aHQTIYsP+B19u078wrx?=
 =?us-ascii?Q?yfUO9YtqV0uDBub3tOiWsL+L9fc+E8uuUncBFCPFoLL1DMp1aRWi+icFnz50?=
 =?us-ascii?Q?EPDkxM3LUoKU4OG3KyZaFLwdBXo89ZFN12AmsF4q/nF609SRYnYGfTB0/MR8?=
 =?us-ascii?Q?l5JsXuSE6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daeae983-5ba4-4f15-89cd-08de748a2ed3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:23:17.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjzR+Yi5M67UkfFkyJnD5Dh4q9sHeMkzAmA1WAqhgEQItqRHtdlwd9xDsvSwEoqk4YKC2ZsF7m+JiJruPC/A7Q==
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
	TAGGED_FROM(0.00)[bounces-9088-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 4500A19A89E
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 03:33:26PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> There is no need to jump to the done label just to return.
> Return immediately.

Nit: There is no need to jump to the done label, so return immediately.

I think vnod can change it when apply.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v8:
> - none
>
> Changes in v7:
> - none
>
> Changes in v6:
> - none, this patch is new
>
>  drivers/dma/sh/rz-dmac.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index bb9ca19cf784..cc540b35dc29 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -706,7 +706,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
>
>  		scoped_guard(spinlock_irqsave, &channel->vc.lock)
>  			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
> -		goto done;
> +		return;
>  	}
>
>  	/*
> @@ -714,8 +714,6 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
>  	 * zeros to CHCTRL is just ignored by HW.
>  	 */
>  	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
> -done:
> -	return;
>  }
>
>  static irqreturn_t rz_dmac_irq_handler(int irq, void *dev_id)
> --
> 2.43.0
>

