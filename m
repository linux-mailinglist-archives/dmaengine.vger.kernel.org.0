Return-Path: <dmaengine+bounces-10382-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPYvO/+QA2ru7QEAu9opvQ
	(envelope-from <dmaengine+bounces-10382-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:43:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A425297DF
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16E6C315EBF2
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 20:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC19036729F;
	Tue, 12 May 2026 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BITGTzDu"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51F357D01;
	Tue, 12 May 2026 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617754; cv=fail; b=iJ2xrdjN7VBz39C5D9HoJz0+inpqXilOiLyu8beT5h/w+vesLD/qoJr94MqplJgSAIp+OY3IrDyX5X0C85vaG5/12w6rfi1LB90CyiLE2745bhQQyk+TFnmgnSr2Ab75PjnZ7VkTXOMuBCi7CYxjISeH4NroDCFXObE5lMhlSgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617754; c=relaxed/simple;
	bh=5PSgA/fIgVKcLoCQz9Wk5YFN1hSHDCS1W2uDajZ+UFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c6l+yxQD1OHbkge4oDBjpsb8ts9tJcsh2Io0fGxcvxEYjirPZduNjBCfFyW2NTdjYaOjA6FQQCEV5lne+v+/I8LqKLxzSEPOqsDjLpUHpXXuyP/D5BExpkAUG3mCKGcl39Svzd4PubzPMlJZNCOYqVuVXs3mMlqqIVrBCBRPBho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BITGTzDu; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9SiPhQpLoaYgkdVRTK22xGTjOQMjzo0iXt0A7g01B8qZbqOisztUnv1CPRhxbBWBurXPj9ydbR4zxcWzE7sCQ8tt1J4p+vrjwEGnJmn9XxBwa7Nx1Uq4ufHUL/DQIzFb+u+84QYW6YVbgfFlccg5FibOiyMCzF+g9EIs88V0ajzmL5wBVKX4l5HMu84Q/LQFmXG83OAF5CZspKU//Gm4FxNrsPGsbGz4U7qVEMLlVDiO9LERbe2GCUO5lTXKtRYEpl5P9uw1iIUSubGBhY0YSDwBqJ50J2/MoZOGDm8Qe1wUOoi6L5lK+IFhC/6MOq319TD2W16t2yhHZWCTq277g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zNPldR76TB3Ja5jkTt3PoItX61hiRrG7ayWmB6Y23A=;
 b=vPpJkyHizhYu55UDlWYvhXLlYKsIcBGQvRDAioJHMbOmgle4MnB8QfO4xvZv79Rh8m1dYFYp4pQUuuXiiL8QEdglC+XOq1no4iji4Wmg0i9zrmHajhb4AK+jYHIncoDTT8ePhqVA5f3V9QiAx9wD8nQN0nh1Pr7kTWRc+nOPQ/tRYoDVaeM+QB6Um7eGIKItR+ph8oo73NWD1HQhIpmTvkTYgz+yHFnrA6ywQ4R5XzsUExzEz2yPo0nGBe1ULNEE5nlsVqFwjPyHM1g7Pu/GPjoTZvbHFc8FVM5qOCSP5tmpoZTgShtBmprQtONTn/OUN/85bGMYykTmmQWFd9obEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zNPldR76TB3Ja5jkTt3PoItX61hiRrG7ayWmB6Y23A=;
 b=BITGTzDugE0XRo8X1eucTrv0k8Tbd4HfBChwNXnx3vzhMPvHtXxixQZI1HiLfTIrdLdo97sy6r1wRQW3IwkQNoG9qE2CzAdTC8Nw+zjKf00fnxydz8fwDd8/MdlXyZaP/2+K27EaPoR5+6kdfWjL8GyrrpE429sftJWXuVGVLTkJhhhYjOXf4hpMfiMHqw+CswvAP8pLh8KnDIe00WJVcmYJTG42rvH4LdKjfoNe6yiunx1rnMl9UT7/FlCT448yv3+Rp+NWFxEqewmaZ9lxv9fJBpVFsYt0w6YznVjse/P3dYQOdnGt3VJdQ/cNEXzbuKBHNnJMTtp1E8HcLHDgcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB10914.eurprd04.prod.outlook.com (2603:10a6:102:480::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 20:29:06 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 20:29:06 +0000
Date: Tue, 12 May 2026 16:28:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de, geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com, kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com, claudiu.beznea@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 01/17] dmaengine: sh: rz-dmac: Move interrupt request
 after everything is set up
Message-ID: <agONitk0FUgq2Bwf@lizhi-Precision-Tower-5810>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-2-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512121219.216159-2-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: SN7PR04CA0185.namprd04.prod.outlook.com
 (2603:10b6:806:126::10) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB10914:EE_
X-MS-Office365-Filtering-Correlation-Id: 72933b89-2047-4561-1c09-08deb0651d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|18002099003|22082099003|11063799003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	kZUv4/oSATRoyWOcpgAGMf8w4LAcTqjCoNa/8QKpiWTRIm6zQO6Q7qARbZhujaPY/dgzmeNtV1WTorp9bW6ZoMBEtfgyaOKXgAk7d9wBuQglgUTM6SXE86bOeDJLK7cynEXWjP1+wOdbeIOdt3r2tF2gXRS/ekyotGXl57VQ5/Hnn9WYbRU6Jvt+c/OAiSmDBlVAgqohhKxEEb5+bcMQsVZR46E/rIadltfSFHBGUy49XdNtiXIwd2fCX8awO+9WA+YB9xiVd0sq5U5I2H0Xh+mNXzTAYFkDj2t3HyGiQpGd3NG+stUHaKbHTGVLn9uSftX6ZMFUtGkvqnVXZfAb3sJTXSCi5d68mLmgFkJLNv5wibEYhfcOY9GHuNAUs9bSeKM9On9Z+LoDTySyWOwcd5yQmJ3nEpsaojAfW83SLSlsWBAdbTvi2MOFa5Dos/F5+Uw9q6bdrB48a3TlWXLyRIgQO9WipOPoO3REfbTBa0kcP++otQtSkSHYGV3e+dlJyPfFN81TnNQ55iY2pKRroLBLAQz5H56FkDcs9aYsoXn8gq7FQKxfTJVU80HTfcZM4KnBO3hQglqKTPbSSalOhwGbF10I1uKinB1ZLn7c6lHgt6/eKhFhpdldXtYYIQvKLMT/tN4MiCd3N2NVyLrMX5qJ3iBqDNz0/BG/Iyyq2R/y2GZ7aPTiue4SI7APx6Jim8or60Hh1UUVlLSsomFwWEjDJExQVRkERVvbOtsN++6tFi3WorKQn5zOhG/WNLsN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lHiJ/MTyfK8LJLMdDdez0UtRzTDgaTK3cSF4vFZWjf/q+XBVoTAEwYAnwwoM?=
 =?us-ascii?Q?hrc8J9C7hNOYIbXYew2SC/h+fa1raWNUeAhx90Tb2bD+0HBAIn53dbrYquUe?=
 =?us-ascii?Q?ptEt5YI6CnOG9DMzt8XLBdIMO/q26DS5DPt3MXaYQfPEOXss48IXIAj4+qIY?=
 =?us-ascii?Q?X9Ilm7/e9aOCCCQxlmFUcXyMnXmTbklGDhQmyDxr5jOlJSoJTSRCohTs0Cih?=
 =?us-ascii?Q?b19gf+uvByfKteU6b8i5eEyY2tIWdxbfjRj5aRK5FCrKpyzjqoGAm1wyanfj?=
 =?us-ascii?Q?rNoBO5jdPYqUO7ZQxVyY/NLSclz3PQDv/qOq6QaDKCgmWxWuxHz6KtyMydjr?=
 =?us-ascii?Q?5NoDz/bD0qTk6ZaQ5BxCQG5rhGx4iu3TvT2hdCMlPHAMq+dXbPsntQGQDMjH?=
 =?us-ascii?Q?jDZF2n0g0A5l94F1VsdCYQwcxQbcNfpHwAfz5/JPagtbtA8LeXKco8XoYStM?=
 =?us-ascii?Q?4qwo8ZC/eMNOoZQdU0kpzpA3gEtT7ytJ5Tg1yY9PNv6DGdtXn911aRU2atHk?=
 =?us-ascii?Q?RdN5fvo7OF1hxCv6GLRvUIHcspG04tdEWU/jYAVTIGvRRJjOqGdBa3n6LcN4?=
 =?us-ascii?Q?f0hzd1a4rTP95YIQXdocZhQGLDcJv5eIG4vdq+qmgm5uFBbYxDhm64XNJsVJ?=
 =?us-ascii?Q?IdZUgldWt8K0kAdegGG2BLBNAGGXgVRsYGwJUuJ4/JbFkh03jzxayUs3zbsc?=
 =?us-ascii?Q?GcAD0IZVGvpH6nfQnB3/wLeLiKf9x90ukRL1iqgGkTlgkw95ug03cLn25Oel?=
 =?us-ascii?Q?tD2w9eqY1wYiMp4GYL9SSHQSCafWXtIMMgeYOPj+G+b8rh0Si5b8r4kDtYd1?=
 =?us-ascii?Q?B5q/Bgd9sAvjrWMGS3C4z7Nx6Glxy0/7iLQb78ZzZeylKrqRGowvKW/QI6lj?=
 =?us-ascii?Q?tUgAh9TFRZQZ0ilY68JkcZtMI4Ns55bWPmD1uAKlc63mCn+RWW74BcxrER3A?=
 =?us-ascii?Q?/4y5OnRGVgzROmtcs8UwCy+psIGg8n90lRvATwPIR+v1bm2ezJhKr5SQqD++?=
 =?us-ascii?Q?WENpuS/Map6L9DN73nLlZMsxo+ivzjU7kywSBb02xFxuSuSo7ZbRIgXUsFNe?=
 =?us-ascii?Q?4sQ3Loo+EkeDnA6vBefY+HhCEA2V9oja8/F8J0FiS9DZwvGvFt2e9Ixwiyo/?=
 =?us-ascii?Q?3YSFtTgPcWF+RflLwCJ9dD0lUS45PKXyNXEr0iyJ/vD/cb9mKqeaP1pEBFFE?=
 =?us-ascii?Q?WzyviEVFi8aoiTPIsGPPTf6/dQ0wXYLU9WPqJZtxHR1tK45P1xRX6IQTrNZ4?=
 =?us-ascii?Q?JqCld9aUxrIQg2cX80fjgaDSyK0x924BTHocCd2HfscsSHv9k+87O6oIQPmZ?=
 =?us-ascii?Q?5pgRVxpQ+2FsQxt3YJF0l+9rmWAgQUzVm0pHpztnzPhqMtpwROTkEFjN+2VX?=
 =?us-ascii?Q?N1wLifzajBqh/bwvieFa/09R18sLrm4ICFw/jffbjqI8e1eVvKNBl4C40tsL?=
 =?us-ascii?Q?SEYqwpnWbu20y8GG/V7DrR761QjcHgPyCAxKbcwen0j3dGiC2zzon3DYnQf/?=
 =?us-ascii?Q?3xl+OJktRNpo9JFgGaK1/iHlQqwM+C96ixeVs5g2wW2uQHugNPeWnKCSy/U5?=
 =?us-ascii?Q?kvyq/01MPkZB3PA2szzVp2/8AkqG/STay8KteYCKbSIs0PeaGPnIWkC0xDFy?=
 =?us-ascii?Q?zLzicqZwy8rLAF6fjZQ7p4pzdR4ilMn0vyHF+RqnOb2rBBTvju8wB8CE0n/T?=
 =?us-ascii?Q?90xDOn7cq7o5YMfqeNmI9fpy3RiDybaEFvt4nIz6o7FMFUQKNzqvHvU3/sIl?=
 =?us-ascii?Q?1Y8pnCxWiA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72933b89-2047-4561-1c09-08deb0651d08
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 20:29:06.1381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DN7zrM7uOo0T2+mgEcJXEfX9R7lJXaz8Ve6KluxVViREl8S+yQBBK1JblyOOKIvZ2rK2VPxA9m4yy8YoMM2ErQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10914
X-Rspamd-Queue-Id: 48A425297DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10382-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,renesas.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:12:02PM +0300, Claudiu Beznea wrote:
> Once the interrupt is requested, the interrupt handler may run immediately.
> Since the IRQ handler can access channel->ch_base, which is initialized
> only after requesting the IRQ, this may lead to invalid memory access.
> Likewise, the IRQ thread may access uninitialized data (the ld_free,
> ld_queue, and ld_active lists), which may also lead to issues.
>
> Request the interrupts only after everything is set up. To keep the error
> path simpler, use dmam_alloc_coherent() instead of dma_alloc_coherent().
>
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Changes in v5:
> - none
>
> Changes in v4:
> - none, this patch is new
>
>  drivers/dma/sh/rz-dmac.c | 88 +++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 625ff29024de..9f206a33dcc6 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -981,25 +981,6 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>  	channel->index = index;
>  	channel->mid_rid = -EINVAL;
>
> -	/* Request the channel interrupt. */
> -	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
> -	irq = platform_get_irq_byname(pdev, pdev_irqname);
> -	if (irq < 0)
> -		return irq;
> -
> -	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
> -				 dev_name(dmac->dev), index);
> -	if (!irqname)
> -		return -ENOMEM;
> -
> -	ret = devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
> -					rz_dmac_irq_handler_thread, 0,
> -					irqname, channel);
> -	if (ret) {
> -		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
> -		return ret;
> -	}
> -
>  	/* Set io base address for each channel */
>  	if (index < 8) {
>  		channel->ch_base = dmac->base + CHANNEL_0_7_OFFSET +
> @@ -1012,9 +993,9 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>  	}
>
>  	/* Allocate descriptors */
> -	lmdesc = dma_alloc_coherent(&pdev->dev,
> -				    sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> -				    &channel->lmdesc.base_dma, GFP_KERNEL);
> +	lmdesc = dmam_alloc_coherent(&pdev->dev,
> +				     sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> +				     &channel->lmdesc.base_dma, GFP_KERNEL);
>  	if (!lmdesc) {
>  		dev_err(&pdev->dev, "Can't allocate memory (lmdesc)\n");
>  		return -ENOMEM;
> @@ -1030,7 +1011,24 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>  	INIT_LIST_HEAD(&channel->ld_free);
>  	INIT_LIST_HEAD(&channel->ld_active);
>
> -	return 0;
> +	/* Request the channel interrupt. */
> +	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
> +	irq = platform_get_irq_byname(pdev, pdev_irqname);
> +	if (irq < 0)
> +		return irq;
> +
> +	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
> +				 dev_name(dmac->dev), index);
> +	if (!irqname)
> +		return -ENOMEM;
> +
> +	ret = devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
> +					rz_dmac_irq_handler_thread, 0,
> +					irqname, channel);
> +	if (ret)
> +		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
> +
> +	return ret;
>  }
>
>  static void rz_dmac_put_device(void *_dev)
> @@ -1099,7 +1097,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  	const char *irqname = "error";
>  	struct dma_device *engine;
>  	struct rz_dmac *dmac;
> -	int channel_num;
>  	int ret;
>  	int irq;
>  	u8 i;
> @@ -1132,18 +1129,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  			return PTR_ERR(dmac->ext_base);
>  	}
>
> -	/* Register interrupt handler for error */
> -	irq = platform_get_irq_byname_optional(pdev, irqname);
> -	if (irq > 0) {
> -		ret = devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
> -				       irqname, NULL);
> -		if (ret) {
> -			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
> -				irq, ret);
> -			return ret;
> -		}
> -	}
> -
>  	/* Initialize the channels. */
>  	INIT_LIST_HEAD(&dmac->engine.channels);
>
> @@ -1169,6 +1154,18 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  			goto err;
>  	}
>
> +	/* Register interrupt handler for error */
> +	irq = platform_get_irq_byname_optional(pdev, irqname);
> +	if (irq > 0) {
> +		ret = devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
> +				       irqname, NULL);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
> +				irq, ret);
> +			goto err;
> +		}
> +	}
> +
>  	/* Register the DMAC as a DMA provider for DT. */
>  	ret = of_dma_controller_register(pdev->dev.of_node, rz_dmac_of_xlate,
>  					 NULL);
> @@ -1210,16 +1207,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  dma_register_err:
>  	of_dma_controller_free(pdev->dev.of_node);
>  err:
> -	channel_num = i ? i - 1 : 0;
> -	for (i = 0; i < channel_num; i++) {
> -		struct rz_dmac_chan *channel = &dmac->channels[i];
> -
> -		dma_free_coherent(&pdev->dev,
> -				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> -				  channel->lmdesc.base,
> -				  channel->lmdesc.base_dma);
> -	}
> -
>  	reset_control_assert(dmac->rstc);
>  err_pm_runtime_put:
>  	pm_runtime_put(&pdev->dev);
> @@ -1232,18 +1219,9 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  static void rz_dmac_remove(struct platform_device *pdev)
>  {
>  	struct rz_dmac *dmac = platform_get_drvdata(pdev);
> -	unsigned int i;
>
>  	dma_async_device_unregister(&dmac->engine);
>  	of_dma_controller_free(pdev->dev.of_node);
> -	for (i = 0; i < dmac->n_channels; i++) {
> -		struct rz_dmac_chan *channel = &dmac->channels[i];
> -
> -		dma_free_coherent(&pdev->dev,
> -				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> -				  channel->lmdesc.base,
> -				  channel->lmdesc.base_dma);
> -	}
>  	reset_control_assert(dmac->rstc);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> --
> 2.43.0
>

