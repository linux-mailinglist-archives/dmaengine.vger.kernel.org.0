Return-Path: <dmaengine+bounces-9393-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIhVJ5+xsmmYOwAAu9opvQ
	(envelope-from <dmaengine+bounces-9393-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 13:29:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 480F4271C26
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 13:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1103E303D493
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 12:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF942E888C;
	Thu, 12 Mar 2026 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="qhMWte9G"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011017.outbound.protection.outlook.com [52.101.125.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3243126D7;
	Thu, 12 Mar 2026 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318411; cv=fail; b=tmUVKHYfLIs1eD7v9xcDn+qCr26REcSFgIU2/yzs67z/9AiBanQnViMK1HZL3ugiys5BEo823F/Kz0iLvLBmWpXuDj2yvRsZhkMwl1WfQXVt8+7qD8h1kuPEw9M/So3y1Xajh0fyc9X6MSBUgC1I8SbQwuJUxT8qukGcERylUHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318411; c=relaxed/simple;
	bh=Bt7e+bBIvh2OaQgJIGbiPqyil3phXDRZh00j2krXCaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B90v8+F6iawwguIKCxOVkQMUhh+Cm5uSaGuWAD5EKS0r8ZD/SmEwj5sYqyCk5/1jJlRpyR4XJybrd8/h1hFdeY3+FI6axFQdHlKUxmLjTgOWqG78cjktZ3e8j+Nv8HKKlFdl/KSaaEPm9lEZ3xGg6DguesNltvmuwELtMqQ4RKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=qhMWte9G; arc=fail smtp.client-ip=52.101.125.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtxGKawHx75au63S4kFVB5cqEtwCxzcRut+J7AWF+pHPGMv/MIq6WEc0kLuORzDba0aGw8U5K18C0RWOPsUq7M3nJNKZ4cuYid5BuYmzeDpbc/BmH2Am7qyZyG22IajB0PpPsAXAMjgxsvAtODU94ZihcwWt6yMVoG9Pcw5/YGSSdze+ua+6VOcdkuYOO7ISvCD+CHoe3MH4y7cyh4VcquaY+ccw9ezFuKhgqgtuE9ZcP3DJF4beaupmTC4kcsh/GJvffTtbo/BvYapIEj9qIxOgKNoeA8f9u1sThP7D+RNtmpTkgv2rg4A5yzvNQAGMrMm0dWFs5kZB8AFj/EPBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HwS5cmqcycGdcmtZ68ClqjTljZiRxpPJ72fJbQZfa8=;
 b=fEoOdl2RsOvJIpacoH6k/I52gYcr4GXrC/fpAYayoQBZiCQGB7yOJNI/LSZi+tofVZRSWpiEc5FQ+6D+GfUSk4XnAL4scY9SV/SgT2+5myg7vY2xB3zXoGF4APpCLWvWFBPgsRYWCSFtXqSQzR4JBZmBb/wvBtGnOPllGbD19WFRkPnupyyKxfnr8vJUPln5GCyu7a++Y1PV6EFRHAIa+NxmA1vmcdek+6bLOWSb1/4LSlAoGMuCJQzjMySsJfWbXJJD06Ooikv6fhyhvWTzxGljDVAgR51E9xtunuFJDzc5uElGDnBomrIDaetfOhffdfDpiE2bFPKn+6WjUq6c1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HwS5cmqcycGdcmtZ68ClqjTljZiRxpPJ72fJbQZfa8=;
 b=qhMWte9GXLPLMDNE5ntd/MPAmrL+vwaMb+NRKoFjlyD9VfKKs0BCnMNjMX9zXWVh2QMBwAMeIq8PfR148yO/VGeYrW7XxTLK1DPxd/1BeqQy7jLJJ8nHsChoFkKqXs0FamPOGMRuo76/fclBvrEFUxmeOgHOuDZ0oIuKRAP07OQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8864.jpnprd01.prod.outlook.com (2603:1096:604:15d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 12:26:40 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9700.015; Thu, 12 Mar 2026
 12:26:39 +0000
Date: Thu, 12 Mar 2026 13:26:24 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	p.zabel@pengutronix.de, geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
Message-ID: <abKw8GKjaWHR5RtU@tom-desktop>
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
 <20260126103155.2644586-6-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126103155.2644586-6-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 0168334b-c1ec-46a0-0ac2-08de80329c44
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KRJyGTDqc2w1UnnGEYu1xbXkJIz5w5A4OaAKAiXWqJqtx+kCygHSN3lOF7SAsPVms/EpEqRJmzoac9C34kkayvYdhi7Ke5dC7bHn09L7Zb0T6a3rRJEX5OZaQbcLDXq245/EPxqItb+xEIw3+qiVu2Af+cgiySkJNh0gkwxoRWpiqJ0yFytZ+uwEMiyQgt6nJZ/kVADY7F9Z0cqhbS62Gaf8IcPX19DyXfsurHOrBJlzG1vwN+q1xK+quKK9StwYETUVWR/5L+c5BNiSzZf+IJoer336UBiryXENSZSqrTqIo4SL8Y3QHFq6RoPEcXtvbNd6io3NOniV7xneVP1ZyFqahxb1UHEpu93Puq4hv1F2wxIBGMHRmk3s5hKv0SwI357UHaK7WJO5Kifk5cEfHj8zwuXgJ6Qz2cg9d8n1jov8LUNi7dVbbI5+gqCxZbhNT0WPevfgagSTo/iR3I8+UgVw7eS1whe1URTZeJ37yYc5AdzMb4JxgjV6J1pq2/+3J2QUAnL6IlQH5DBZYtlLSy0H2SmmxMkBUy//DRXc+oAdyg1WeoJBwCplEMaNWJmQsyVKiUmwRETpk6aF3wcjB5puNCzgosoiVviTOMyJDo1T+oVftX7oR16YIIyLdO9+3w1K9mS+cYH6b4n+v8hyAQLu9jh6pYkVMUFfmP1CNiAzEfcCtGoVvHZsaXefl8mg7ubo1gGP2+5wrCB58VoKpJdG1I54dlzbjxbxAYGzM3/VeL07hmz3pXDlepImjQ4jLxgplNsRcC1KN8aP6HufpJ6D8YLdjuMqnA8dCIIfuRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2PAyuVtutSXpwaJ1ZFmBlx+g9MlD7O0kGcc2lSw/13ic3KSCMsbTKGbZfJSm?=
 =?us-ascii?Q?MqD1WqEKn9KVpObjwOg/LKyls23qPryyWm9GsMLEv1PJuNfT0t2InXRcXA7R?=
 =?us-ascii?Q?S1wMcJ+J/piErHy6LPTG2tn8jDzEwh+jWK0IRliQZGr9cLGMsnJvEz/Utcqn?=
 =?us-ascii?Q?IhyfICzti9DTU9a2YLmy0G5YfwjHcmeTN9lYWJeDSMitEN+5YdHU9dHxCtZs?=
 =?us-ascii?Q?L2TkXW2qA+6ByzIvcB2AM/rEkVwkwqmL7VHb2V5WAa58cioIPZhsiiJz6Sxu?=
 =?us-ascii?Q?WJ1gWvVL/9wSZ0gUfxt+1d5cQgdrjTSmd3CIIS/i5xQruURVyz6YmvcNxDOU?=
 =?us-ascii?Q?ErWxNL5FBBiHgksfB8B+QT3Ebqtyg0KfelNnJIiX3xlpGHECaEYOYOpBUHtl?=
 =?us-ascii?Q?zh1JqqoLVmDuZW0GhGiqBMd3CaQbW3XXGJaD3L4tP+LDdrsu8aPnPAlKWRmh?=
 =?us-ascii?Q?GMYNSxv7oPcryV/DNjvyWUq6KEzd/TykXkzWzUd9wBmAYpGErkKFKFpCXvEu?=
 =?us-ascii?Q?K9FoW5AvdN+xBpwrWKlnxFIZWaDzn5EdC36bnU0ClRqqh3JO44gK1N6Bp/U2?=
 =?us-ascii?Q?pt+k94KvGLB1293LLb7fziONMVMHdSuhJZUUk+yIIaYh03CV+0h9+upmoDbQ?=
 =?us-ascii?Q?c0Xs6AHiAlNPfmZCj/griv8TZPQLCfl1okW7/aleun+JGPCMLy4wBe2jO4Sy?=
 =?us-ascii?Q?YcYGMJIhPGsEGoQkBJqISfnkXitQx7aY8icgzNINmc2d5816B5g3l9iT5gqj?=
 =?us-ascii?Q?O3ENxjqtg3IkEAQAp2PYQMMoG1OSEWJ9liA2qYHTnTP0hDeyUez8kZzvBU9o?=
 =?us-ascii?Q?ViWvBu2QUNYfUEH941eQqEaDBBYubYT7ADgACRdtu/WNCyP43DBu5yMcUl+0?=
 =?us-ascii?Q?z7BZNvIadcG+zLi0bOBG4peirE+Q+ZxyM8i5E45lh3tMA8XrH6c5IgSVlonv?=
 =?us-ascii?Q?yD2Wcm7QFySw3rq9WzcHOTI67U/og9a8l1x3DOwO6c4Hiisrda6I0Fw2xbdn?=
 =?us-ascii?Q?FFo3fag6ieoefmiaf26AzJbNZnpzjbX8PL2PDCZXVaaNACmKMeVZBDA3q6U8?=
 =?us-ascii?Q?ggAO39NCU9JE/UOY0uLotP5uDziJSGlSZVm+auPYYfh6CUHoYl2spiJ+1Owr?=
 =?us-ascii?Q?HEX2tMpOSi6wYgceMoj7l82RdYv5FcSKbuzKoO5DlgCLsma68Yas05YMzwP/?=
 =?us-ascii?Q?nWzSfuROw2zn2MrafIBAp+ULjyffkyqGKwN4Hh73Z8TVSTvz6LkmOoN9MHOi?=
 =?us-ascii?Q?2OSLI958X5tDhwMCuS4HqkX/dMvun7SaizhdtQUdqliDlyN9MEizdj+MbumZ?=
 =?us-ascii?Q?vFDWAg7rGM5Odx582UJ+tY/zD5LhKsKHNv8Zrd2L1k0XnkXQI8QghCbUix4T?=
 =?us-ascii?Q?5y/qLRHsPpmobRKX5SOuR+mFAQHacYAu4vyfa2DgqsKc58FmCjRn5Nn8ij0d?=
 =?us-ascii?Q?IwjDwH5up0MDfY6H5t/kn8Awt9AJ2SXRjQEoiE96XZeis1QAJwljfZ6V2GQ7?=
 =?us-ascii?Q?jsYrMw6cZUo7MIEvQSpX5fiFnkg4o55r3kEaLM3mi0RfqCmLShhREQoyHPYb?=
 =?us-ascii?Q?pkBv2dRUeM0QViu/01NhfT0V+oCB5hR2JTFFILKgTSmEygP5rfJ4W2YipQX/?=
 =?us-ascii?Q?KKoNc9UOMKg6xW1zuBun4h5eI4BvkRkCn8pCfLqZ1n0ixNNmxn+HngpTQyED?=
 =?us-ascii?Q?YDVAcL+nXl701LKBz+phxjTKl6NEL7d/WhNsnELhxwUqrSZaJQK1P0ld4X5T?=
 =?us-ascii?Q?+/IIi/vB3szn0H1oJHtgl+t3wcm/gsYBxIRQ0gE76WQoMP5+60hE?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0168334b-c1ec-46a0-0ac2-08de80329c44
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 12:26:39.5101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxSdEyhdSSZRCJOHzJ8FdsL9tq+ZeXPB1BlWuvUmKJ0fEfZUha9PDJEP1zH6WrQ8Po938S0uhSqNIjGaNynImVT9pe4BDKFJRto+SQO9vlvO1bUDBEEu/NhH3uaRRSlH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8864
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9393-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommaso.merciai.xr@bp.renesas.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 480F4271C26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Claudiu,
Thanks for your patch.

On Mon, Jan 26, 2026 at 12:31:53PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The Renesas RZ/G3S SoC supports a power saving mode in which power to most
> SoC components is turned off, including the DMA IP. Add suspend to RAM
> support to save and restore the DMA IP registers.
> 
> Cyclic DMA channels require special handling. Since they can be paused and
> resumed during system suspend and resume, the driver restores additional
> registers for these channels during the resume phase. If a channel was not
> explicitly paused during suspend, the driver ensures that it is paused and
> resumed as part of the system suspend/resume flow. This might be the
> case of a serial device being used with no_console_suspend.
> 
> For non-cyclic channels, the dev_pm_ops::prepare callback waits for all
> ongoing transfers to complete before allowing suspend-to-RAM to proceed.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/dma/sh/rz-dmac.c | 183 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 175 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index ab5f49a0b9f2..8f3e2719e639 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -69,11 +69,15 @@ struct rz_dmac_desc {
>   * enum rz_dmac_chan_status: RZ DMAC channel status
>   * @RZ_DMAC_CHAN_STATUS_ENABLED: Channel is enabled
>   * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
> + * @RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL: Channel is paused through driver internal logic
> + * @RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED: Channel was prepared for system suspend
>   * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
>   */
>  enum rz_dmac_chan_status {
>  	RZ_DMAC_CHAN_STATUS_ENABLED,
>  	RZ_DMAC_CHAN_STATUS_PAUSED,
> +	RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL,
> +	RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED,
>  	RZ_DMAC_CHAN_STATUS_CYCLIC,
>  };
>  
> @@ -94,6 +98,10 @@ struct rz_dmac_chan {
>  	u32 chctrl;
>  	int mid_rid;
>  
> +	struct {
> +		u32 nxla;
> +	} pm_state;
> +
>  	struct list_head ld_free;
>  	struct list_head ld_queue;
>  	struct list_head ld_active;
> @@ -1002,10 +1010,17 @@ static int rz_dmac_device_pause(struct dma_chan *chan)
>  	return rz_dmac_device_pause_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED);
>  }
>  
> +static int rz_dmac_device_pause_internal(struct rz_dmac_chan *channel)
> +{
> +	lockdep_assert_held(&channel->vc.lock);
> +
> +	return rz_dmac_device_pause_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL);
> +}
> +
>  static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
>  				     enum rz_dmac_chan_status status)
>  {
> -	u32 val;
> +	u32 val, chctrl;
>  	int ret;
>  
>  	lockdep_assert_held(&channel->vc.lock);
> @@ -1013,14 +1028,33 @@ static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
>  	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED)))
>  		return 0;
>  
> -	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
> -	ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> -				       !(val & CHSTAT_SUS), 1, 1024, false,
> -				       channel, CHSTAT, 1);
> -	if (ret)
> -		return ret;
> +	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED)) {
> +		/*
> +		 * We can be after a sleep state with power loss. If power was
> +		 * lost, the CHSTAT_SUS bit is zero. In this case, we need to
> +		 * enable the channel directly. Otherwise, just set the CLRSUS
> +		 * bit.
> +		 */
> +		val = rz_dmac_ch_readl(channel, CHSTAT, 1);
> +		if (val & CHSTAT_SUS)
> +			chctrl = CHCTRL_CLRSUS;
> +		else
> +			chctrl = CHCTRL_SETEN;
> +	} else {
> +		chctrl = CHCTRL_CLRSUS;
> +	}
> +
> +	rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
>  
> -	channel->status &= ~BIT(status);
> +	if (chctrl & CHCTRL_CLRSUS) {
> +		ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> +					       !(val & CHSTAT_SUS), 1, 1024, false,
> +					       channel, CHSTAT, 1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	channel->status &= ~(BIT(status) | BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED));
>  
>  	return 0;
>  }
> @@ -1034,6 +1068,13 @@ static int rz_dmac_device_resume(struct dma_chan *chan)
>  	return rz_dmac_device_resume_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED);
>  }
>  
> +static int rz_dmac_device_resume_internal(struct rz_dmac_chan *channel)
> +{
> +	lockdep_assert_held(&channel->vc.lock);
> +
> +	return rz_dmac_device_resume_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL);
> +}
> +
>  /*
>   * -----------------------------------------------------------------------------
>   * IRQ handling
> @@ -1438,6 +1479,131 @@ static void rz_dmac_remove(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  }
>  
> +static int rz_dmac_suspend_prepare(struct device *dev)
> +{
> +	struct rz_dmac *dmac = dev_get_drvdata(dev);
> +
> +	for (unsigned int i = 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel = &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		/* Wait for transfer completion, except in cyclic case. */
> +		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_ENABLED) &&
> +		    !(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			return -EAGAIN;
> +	}
> +
> +	return 0;
> +}
> +
> +static void rz_dmac_suspend_recover(struct rz_dmac *dmac)
> +{
> +	for (unsigned int i = 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel = &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			continue;
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL)))
> +			continue;
> +
> +		rz_dmac_device_resume_internal(channel);
> +	}
> +}
> +
> +static int rz_dmac_suspend(struct device *dev)
> +{
> +	struct rz_dmac *dmac = dev_get_drvdata(dev);
> +	int ret;
> +
> +	for (unsigned int i = 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel = &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			continue;
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED))) {
> +			ret = rz_dmac_device_pause_internal(channel);
> +			if (ret) {
> +				dev_err(dev, "Failed to suspend channel %s\n",
> +					dma_chan_name(&channel->vc.chan));
> +				continue;
> +			}
> +		}
> +
> +		channel->pm_state.nxla = rz_dmac_ch_readl(channel, NXLA, 1);
> +		channel->status |= BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED);
> +	}
> +
> +	pm_runtime_put_sync(dmac->dev);
> +
> +	ret = reset_control_assert(dmac->rstc);
> +	if (ret) {
> +		pm_runtime_resume_and_get(dmac->dev);
> +		rz_dmac_suspend_recover(dmac);
> +	}
> +
> +	return ret;
> +}

Testing suspend/resume support on RZ/G3E (DMAC + RSPI) I'm seeing the
following when suspending:

rz_dmac_suspend()

    [   50.657802] rz-dmac 11400000.dma-controller: PM: device_prepare(): genpd_prepare returns -11
    [   50.667577] rz-dmac 11400000.dma-controller: PM: device_prepare(): genpd_prepare returns -11
    [   50.675984] rz-dmac 11400000.dma-controller: PM: device_prepare(): genpd_prepare returns -11
    [   50.684394] rz-dmac 11400000.dma-controller: PM: device_prepare(): genpd_prepare returns -11
    [   50.692804] rz-dmac 11400000.dma-controller: PM: device_prepare(): genpd_prepare returns -11
    [   50.701221] rz-dmac 11400000.dma-controller: PM: device_prepare(): genpd_prepare returns -11
    [   50.709642] rz-dmac 11400000.dma-controller: PM: device_prepare(): genpd_prepare returns -11
    [   50.718062] rz-dmac 11400000.dma-controller: PM: device_prepare(): genpd_prepare returns -11
    [   50.726480] rz-dmac 11400000.dma-controller: PM: device_prepare(): genpd_prepare returns -11
    [   50.734900] rz-dmac 11400000.dma-controller: PM: device_prepare(): genpd_prepare returns -11

I found out that this issue can be solved by:

When the IRQ handler thread completes a non-cyclic transfer and there
are no more descriptors queued (ld_queue is empty), invalidate all
link-mode descriptor headers and clear the RZ_DMAC_CHAN_STATUS_ENABLED
bit into the rz_dmac_irq_handler_thread():

static irqreturn_t rz_dmac_irq_handler_thread(int irq, void *dev_id)
{
	struct rz_dmac_chan *channel = dev_id;
	struct rz_dmac_desc *desc = NULL;
	unsigned long flags;

	spin_lock_irqsave(&channel->vc.lock, flags);

	if (list_empty(&channel->ld_active)) {
		/* Someone might have called terminate all */
		goto out;
	}

	desc = list_first_entry(&channel->ld_active, struct rz_dmac_desc, node);

	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
		desc = channel->desc;
		vchan_cyclic_callback(&desc->vd);
		goto out;
	} else {
		vchan_cookie_complete(&desc->vd);
	}

	list_move_tail(channel->ld_active.next, &channel->ld_free);
	if (!list_empty(&channel->ld_queue)) {
		desc = list_first_entry(&channel->ld_queue, struct rz_dmac_desc,
					node);
		channel->desc = desc;
		if (rz_dmac_xfer_desc(channel) == 0)
			list_move_tail(channel->ld_queue.next, &channel->ld_active);
+	} else {
+		rz_dmac_invalidate_lmdesc(channel);
+		channel->status &= ~BIT(RZ_DMAC_CHAN_STATUS_ENABLED);
	}
out:
	spin_unlock_irqrestore(&channel->vc.lock, flags);

	return IRQ_HANDLED;
}



> +
> +static int rz_dmac_resume(struct device *dev)
> +{
> +	struct rz_dmac *dmac = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = reset_control_deassert(dmac->rstc);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_resume_and_get(dmac->dev);
> +	if (ret) {
> +		reset_control_assert(dmac->rstc);
> +		return ret;
> +	}
> +
> +	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
> +	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
> +
> +	for (unsigned int i = 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel = &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))) {
> +			rz_dmac_ch_writel(&dmac->channels[i], CHCTRL_DEFAULT, CHCTRL, 1);
> +			continue;
> +		}
> +
> +		rz_dmac_ch_writel(channel, channel->pm_state.nxla, NXLA, 1);
> +		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
> +		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
> +		rz_dmac_ch_writel(channel, channel->chctrl, CHCTRL, 1);
> +
> +		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL)) {
> +			ret = rz_dmac_device_resume_internal(channel);
> +			if (ret) {
> +				dev_err(dev, "Failed to resume channel %s\n",
> +					dma_chan_name(&channel->vc.chan));
> +				continue;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}

Then on resume I'm seeing the following when testing DMAC + RSPI:

[   52.831840] spi-nor spi0.0: SPI transfer failed: -110
[   52.836950] spi_master spi0: failed to transfer one message from queue
[   52.843474] spi_master spi0: noqueue transfer failed

Which I found out that can be solved by moving:

	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);

after the cyclic check:

	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))) {
		rz_dmac_ch_writel(&dmac->channels[i], CHCTRL_DEFAULT, CHCTRL, 1);
		continue;
	}

+	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
	rz_dmac_ch_writel(channel, channel->pm_state.nxla, NXLA, 1);
	rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
	rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);

In this way 
	
	rz_dmac_set_dma_req_no()

Is only called for cyclic channels

What do you think?

Kind Regards,
Tommaso

> +
> +static const struct dev_pm_ops rz_dmac_pm_ops = {
> +	.prepare = rz_dmac_suspend_prepare,
> +	SYSTEM_SLEEP_PM_OPS(rz_dmac_suspend, rz_dmac_resume)
> +};
> +
>  static const struct rz_dmac_info rz_dmac_v2h_info = {
>  	.icu_register_dma_req = rzv2h_icu_register_dma_req,
>  	.default_dma_req_no = RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
> @@ -1464,6 +1630,7 @@ static struct platform_driver rz_dmac_driver = {
>  	.driver		= {
>  		.name	= "rz-dmac",
>  		.of_match_table = of_rz_dmac_match,
> +		.pm	= pm_sleep_ptr(&rz_dmac_pm_ops),
>  	},
>  	.probe		= rz_dmac_probe,
>  	.remove		= rz_dmac_remove,
> -- 
> 2.43.0
> 

