Return-Path: <dmaengine+bounces-10384-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMLzANmPA2qM7QEAu9opvQ
	(envelope-from <dmaengine+bounces-10384-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:38:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6856F529662
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0ECB306A1BB
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 20:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108A13BD629;
	Tue, 12 May 2026 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="grJpY1r+"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF33A872A;
	Tue, 12 May 2026 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618324; cv=fail; b=H3uaaPbl6zHVs836zg9SsNyYtsuGomvc+HWACH6lexs7r5NaNiknkl2PR0qYrI4ibjkaohc3IFoA5eenR8tsG4EJ2ZWVbE9PblAQnxS3JWsWkZEijHWJoAPbkUVQV0Q6Iosfixmid7ypumHUrZVE2uvyKfNinlPPbHiTMIERkEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618324; c=relaxed/simple;
	bh=d6IJStVxeZLlGxabLL2gS2+NFLQ00CHwXH08hZkJjjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OGT8tOeIkS4gSr4Cax8l2g5zhzeiib2HMKyQl4hXkUPlEkxEB1ixx0jPlu7oyXM9wvhfq+ncU8wVjS4n0obBk3AJ0MBfjVe1Q3nBUSbAXj4BW2bxwJfJuVubOLy2Lk/RsNcqEo+1KFZ9m93m6s7rppEPVVbqXcHEg0HHItuV91A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=grJpY1r+; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaLCqmcKeJ/Lk+eONw4lwnWur+tWl6dQ0j17+7+jl7HIOF/MUzgB3OSsuOjjB/JkRyHL7UuPWI6IKQP7SpCOHQpbqSlb/OoEF0sUCGiyoyQnMqPiXocWWl3eGalvLeFAxMdOKhZeSGs9SDPR08XYMdNQzVpVjmUo45SYYC3oycloouBulplZDJVQJt7RqteMDfUa9zNWy/lqD+IiRorVtEM8Cs8LNHuk2wAqUYMWkG43V/g6gHZcQABQ3FBkE29a7DQY0eFktqEQLX3yR6pj8QPNcx5wEoaSpHmki7+iOCVD5ymfiXu/3kD6wsibdjoYIJjLcoERhl/GDAsVubPexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wt2QgkXHb08yq9wQ0KXqewDf/if6fmiGkrzr7iVjK5s=;
 b=Nr8ZnGUpWbIGLa6ajpw430L/IJKp2e9hq03sijqK7hEVUrc6NjGKfuM008I4hmJH9zdBYhhhp4pCtUbl5i9E5ASr6PfzDUKcZx4MwKRetlqNC7tlslWYe/9OzEAljjwdy8m5JzEME78G8vpwVhETVfR75GKjtyJlVhMiuzTaBg5glQrwP5nHEDGjGvr3XbnUGmomOCUEIyZwbnmWWEumrAQimqTG8oh+rueiNwTE7p/mu1ycciFqO/QAoLO0HvrWONP8fyosayq0g3ayUe4gxvS2WGQ4l4lZ+rbFYNqh/VEWGvn0UWxi2vKzu/JaEESd/6xve5irQb/ExH1eJVXiiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt2QgkXHb08yq9wQ0KXqewDf/if6fmiGkrzr7iVjK5s=;
 b=grJpY1r+0tgFx7lr5PAdG+52r8Y5g7Z7B3ex//Oc4iciHe/oKYbB7NCJoY9Z5hPweWlF7C7UaBvm7QxYb2zbF5kmuzf/YbeEYC+Znu74hjj9QDo4sLSx7uoUn2rb2W4q1x5wJUz8DuYw1TOndUO37dTBfL+XY4PVlNMM18suhS6oU+ApVir+4skunWJSV/BfWmyCZl3E2vcqI3H3W8flJ0mgzCx7c3klCILCC0FFQLCM2vbRBX4hTss64XI9vss0OIhsXujrenB0CsvsKncXOE9YjBVm2C/ox/qYsc19DMCVNKxUTLj43TBW2uEy2PPchoICqIfW+4qLRihvK/s3NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by PA1PR04MB10142.eurprd04.prod.outlook.com (2603:10a6:102:464::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 20:38:41 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 20:38:41 +0000
Date: Tue, 12 May 2026 16:38:32 -0400
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
Subject: Re: [PATCH v5 03/17] dmaengine: sh: rz-dmac: Use
 list_first_entry_or_null()
Message-ID: <agOPyBs7XvvamUGT@lizhi-Precision-Tower-5810>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-4-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512121219.216159-4-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: PH7P220CA0105.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|PA1PR04MB10142:EE_
X-MS-Office365-Filtering-Correlation-Id: cdffb7a0-d4b3-4824-eba0-08deb066737b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|52116014|366016|38350700014|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	NAhJsFiQm/jodxr5mOahV6CE8itkjAMILZ/2hkpQ87Enl2YXAs9DjVrkYEHsUuog67CpfxBhDa2wL6H5pgmHQ3t+fSfpCdPbznx9lf98nAMeiyvYbf/YiR+aSiIy7r0w8REuntm2jj9mO/uKeDCZeI+mna0xQbBM4ZKO6LPx3rJtVLgbyxLrtYNIcBG6n2mwBSCtU5Xn9uwrGw0X95aKk8anuwrWkasQcQgCZhe2E9CgTPx6meuLDiLPYfoHruk/v8GZpPdrluxmm34S7Ahz3HszlVj3rIqbFe1iVPC/wNz00IVjqDF9EtPP5xFJiR9v9sBm+j93oYG58c/zN9BKrooFdHjFmnD1Qa6NvDN+OAYZrdZGeVdGrLQAwSMKBJkOCDh4dHp39fF16kpADlsrqcU5zs8d9c1/ThgJuFK/gKy77jTr9qkATCsDOLvnzZAh527A9vBHqcHdPcX6HPd/1jq/LN2c7bdiYrW8OyOFPfAA+g7agnPZEb+aYEVX3zHpmSM+ADgAkm7zvmVfLkV/6oYCTpuUagMfCZfbqhYy9W6LfXvbmRLmBnymUR69OJ5Fqoj873eYKtOpakQiPyXTqf/thzAIqFQBPNqOtG+Eyptr2bJcDYkDssYxI7tvF4uCooxIKSf16PvRjjP0B4aLrBNMC+iNV2CbwHu3ctlwl3QzmeWrE+nOwYX/UVV0HNChfI5ez7NcthQWu54U1v37HFzwV61WHKnT/AGt4YuSOyrmC2arzDoWro//SrfBqHJ9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(52116014)(366016)(38350700014)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OPi8EuHWpq2/yiAbJLiIbM70EUzX3jJtUYp+Z6UiFxr9FxK/Qt2OPCaADenB?=
 =?us-ascii?Q?bd+ySskO2XpFEZI51rhEjk7FPV7tllRlwzisOKePTrtiu5V1hw/Gs2Y4dwxL?=
 =?us-ascii?Q?qNKGKIfewz9arPAaBIarCYUDlV65TrWA1i23iNXphL93O4XrqYG/+plCk9/q?=
 =?us-ascii?Q?KG+zPmr9aZ+niIlx1T4a4DcfR3Cv/uHsu5j4ArCsFRXSZw0z6X2clXlo27sS?=
 =?us-ascii?Q?WBFXPCeX7IzHzOR+iGgx8sy6mYs5D76GIzxtQ/e1Vm/yoJ+j4SqZj2rs3Rbd?=
 =?us-ascii?Q?ItJLFO990SFInvqPeHgzOtmraZZ6PEw1/GrVOhuKIHbJS4Oan1fIqaZW7fOA?=
 =?us-ascii?Q?m5YenuJdKWeDOAqAjCS/5Og5h3i1athaJ9uZbPi47GQj2LahPMg/Ep25frVK?=
 =?us-ascii?Q?KfavG2y6AounX18DfabsTeyy2C3rJsfjXjvjIW3W5PgrVunczB5JGSxMYeDt?=
 =?us-ascii?Q?Hhv6PN4PxfWWIHZ1R7P8Am6UxfwoZ5DXt9skBV1cRIo6C/jKYtgWS74wwdPa?=
 =?us-ascii?Q?a1WGYRJmGveLA/5m8sR9VZlYjYE931QpTOECJVu2+uXGT3D5hj7UiYnuN41b?=
 =?us-ascii?Q?LJqKEE5yEU0uI8XrSE0h4dCPoEI6034dFEgQ+FDrUIp9ChIGQZO8JSlcfn7q?=
 =?us-ascii?Q?1atrhQpgOjm6GBlUeZyDKwFn1/p2sNLLrchG2zgHZqvE80TekspJ6BCdYQr7?=
 =?us-ascii?Q?NBn5p23tjgGXePTkmZBd5/7cbZu/qFf1lOFp2otvLG/C5GoSu/A8k2JjemN5?=
 =?us-ascii?Q?ikh07BNm1S7eYzAp3GJFgpenFEhbIOyh5/l/Z6Qj180oFsbnZiUQbedkViiY?=
 =?us-ascii?Q?8s0MhrtQT24EzM30cy0UaFRWJPmglyeiQpZs98HLH2rRRPpU3nGZVbXYJaps?=
 =?us-ascii?Q?D5VlmRsChv759t+Tvjiy6RmKXToeefMQS+kSCZjxi95LeZAsQzv02ZPEsbix?=
 =?us-ascii?Q?h0NtnM7ryHMxJubRnNEEGWgvA2PkJS43nuHtH5d05OLPnZuShhAAxKbk9hm2?=
 =?us-ascii?Q?ZgB/L/zXGfDubi+9AM1bfr2UsSoOMV5c2OBcp8BOWFoOeSApAMWTBRZtqBzj?=
 =?us-ascii?Q?7PK/o/VMCnI1Gp/6yHfmZYEcvZUIH2mz/DFr7bIsw2aJGvW7Pu7WLoK8pTcZ?=
 =?us-ascii?Q?wl0KFPRsh76zi2JtAw2eta3at+EqSv6h+kmwimYXt3SldP4JuLJaPBvbU0YK?=
 =?us-ascii?Q?lCp0t9juANJ0+lGcgGkS8hbS6Opg/FuNJbdTxafOZQTvRsXfIluB+FgY0+l8?=
 =?us-ascii?Q?VtgsXIbnjjJ8AqjF8IVrx1wFX2LuyJ5EEW2YzKkMyUD75IQyWuIZa0lmrAbO?=
 =?us-ascii?Q?RVq4MFJuov6QA9MF9GU/eR7Z+TCidG+xBuGFYDP/DPGNyIhb50elonGsqU0D?=
 =?us-ascii?Q?97q0/FwPImyKyku1ypSkjGU8isexozU1WDiM1mJVY1WVHzhdDPll3/PQMa58?=
 =?us-ascii?Q?zBfInYnqZz3JTCWfnSs0EegE+rbTkxGjHxvBontwGFp9cGJQlcTmQW60v07R?=
 =?us-ascii?Q?mbWwJATADNyA9q7gX/DZ9tRqseHqezR20S9sUeo+fvdimFcwcAir63Eo0+wp?=
 =?us-ascii?Q?9tsaLkHfo0ZKotpr7aC9/WTVJeZch1lZzzlTunNIt1Mpw/x1ZS3Xsr07ctzB?=
 =?us-ascii?Q?8diQ9J1iG0jk7RD8Ynh9oiMnT8pDw0wsjDSdGukRXnRRVGaf5oGVVr9GSVHU?=
 =?us-ascii?Q?DQUyzdCrT6xmhZ7hnR6e6W5SJ3/Y7Le/1VhL24DcwO+hrefA57xnta2291aB?=
 =?us-ascii?Q?Ovfn8EkdUw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdffb7a0-d4b3-4824-eba0-08deb066737b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 20:38:40.9379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZhkdgKTVKHHFOt6PoKkh6qogdPo1uvjEU/1CufYrMUWgk86ZkEqDlHo/9Ap70bIBoG9NOSbeLICHeHYR6hr+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10142
X-Rspamd-Queue-Id: 6856F529662
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10384-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:12:04PM +0300, Claudiu Beznea wrote:
> Use list_first_entry_or_null() instead of open-coding it with a
> list_empty() check and list_first_entry(). This simplifies the code.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

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
>  drivers/dma/sh/rz-dmac.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 6d80cb668957..1717b407ab9e 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -503,11 +503,10 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  		__func__, channel->index, &src, &dest, len);
>
>  	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> -		if (list_empty(&channel->ld_free))
> +		desc = list_first_entry_or_null(&channel->ld_free, struct rz_dmac_desc, node);
> +		if (!desc)
>  			return NULL;
>
> -		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
> -
>  		desc->type = RZ_DMAC_DESC_MEMCPY;
>  		desc->src = src;
>  		desc->dest = dest;
> @@ -533,11 +532,10 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  	int i = 0;
>
>  	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> -		if (list_empty(&channel->ld_free))
> +		desc = list_first_entry_or_null(&channel->ld_free, struct rz_dmac_desc, node);
> +		if (!desc)
>  			return NULL;
>
> -		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
> -
>  		for_each_sg(sgl, sg, sg_len, i)
>  			dma_length += sg_dma_len(sg);
>
> --
> 2.43.0
>

