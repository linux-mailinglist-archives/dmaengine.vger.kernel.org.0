Return-Path: <dmaengine+bounces-10391-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPbfBjWfA2pL8QEAu9opvQ
	(envelope-from <dmaengine+bounces-10391-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 23:44:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE1852A846
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 23:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA51D30BD726
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 21:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1674F387341;
	Tue, 12 May 2026 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WNszb+0/"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8B0383C6F;
	Tue, 12 May 2026 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622206; cv=fail; b=MFOuRL3sjLLNIla9ajLn8/uoAyVnpYOLPsOvToZ+zz/YNmuibqb/CsjPiLDW1waVnOhzqVhNmsyRKykP0gKCERy8Ot8v0s9uWUCqWGjS7GscoZPSFCq59IZrYmZdL1ckwE82gRRtqXcVAGDIELj7yURFQo13p642tqp9uj01qmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622206; c=relaxed/simple;
	bh=JzWc2pykAmy7b6+dorzNs0Vbsp+0XaYvTAeJsk7xqMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nRgapjU682nU57Gqh/3YnkNMeVNnsPBFz/LWm8M6A116pZtK9WDwEltCSPcDc/7ebaTSp2xQKVoMveox8mLgJx+0LbWEWRGVCXgKkhG1V7IggZ2pUO5lJw4XR45859OTvBgLdppEWG+m7MgFScKbPjCEvTXk+KjVIIjckLRCtZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WNszb+0/; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qp6Dy3nMmgTOTbSNe8KO66727kiIfJnWgYd7vkb0QY9YhynFkeStfzPKqm5zqE1d9Ucxo5Ab0mGpGnrTwg/9cEDwgd7o2j0HejAnrv2QyC/aFqAZMzf5IkntGjpz9DxlL6AlAubM3MbKQ5aZaAKAU1iEmxkCZIuJ42AVbbxCOl89JKnat+0PlxuEPoh/4sZqb2kbLPAFynK7ibjgWmZ043O6pwhbPSYo4YhmogVO9cG0ik9nyaS/7oWqxS4r3a37p5GWjwlz70BvBPyocw9mD3b+eNBqX2ueHMXIM7gQjkC8hFRNG1eiAjfnZiknQB4wzsk2ShN3aFUC54/UlQA8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xBpwED5UMuQVG2WqOD7GT2eFvwItlAOY3ulmusCafE=;
 b=tBrvCTzZpCyvKGWzFedRKwT+DBn7c9AhWfC43oNzuDIYMDuNFVvWXsHn8oL80rMmVodjhLfKou9Dnuqr2jAnSAdSq1URJ68XUpAMWIqM/yFK6BqEtq88JHxYv7LvGvwc9SDcVFGS3Gseyuh/M7w5SKb8xW0CljSSe+R64Q8KxQ7XIThQpUF3uYIM7wV58A9QQObWFIm3G2hzASmo+KZTBvF8lPBcVE5e2L99ljj4XSI9FUrnGjtVA8tqyFCrFZ2S1VJ9vIwlGkCMHQHh281tkVi3SdCOHLrra3c0vom5pK3DsDKbygd9LgT5aCgxEa/8LFK3flc3F4J4yC3P7OQ/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xBpwED5UMuQVG2WqOD7GT2eFvwItlAOY3ulmusCafE=;
 b=WNszb+0/Fo5OQJjCLsMXuSwmRgIaFUyKO30EC4XvDsjVKdqL2wgFJg4SfRcQw2PL2CaxQfmuEPsQQ55+lFB0tpZvqmEiz5R0Gz9HO+VZldwhY5uxi81AWIqv42vUTqS7mcd8SFB3A9DzNctOf1t04fsrkTgpvnTDkvaWeFGpq6W+dsBew6ZgUfNBmEL02N3dx0/0U6rbU73l0V4UE+QlwPCDjl2jPPFxVb4suCzV0dm4git4sTxNJbYneIxnfNQgbKw/4ZsXBv6kAc2h3rREa0e4xrewgoKi0y+xzDb/wTJEq17lgREyR4SYY/36bY6t/ZfGP1s/4RWv1Kg1in7OkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS5PR04MB11370.eurprd04.prod.outlook.com (2603:10a6:20b:6c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 21:43:21 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 21:43:21 +0000
Date: Tue, 12 May 2026 17:43:14 -0400
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
Subject: Re: [PATCH v5 10/17] dmaengine: sh: rz-dmac: Refactor pause/resume
 code
Message-ID: <agOe8ibuEjDPklKt@lizhi-Precision-Tower-5810>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-11-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512121219.216159-11-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: SN7PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:806:f3::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS5PR04MB11370:EE_
X-MS-Office365-Filtering-Correlation-Id: e4bc2e85-b4da-4cfc-2a7f-08deb06f7cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|18002099003|22082099003|11063799003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	ufpkiSjV9Vn/NePsw1fL7D8GPXX7ng1YIVtLgXZEomifiIs+lbg4jII8eAgAeGN4kcI7q7vEsS5WY7d4gHERuMrSox6eWZiH99h/jHG4mRYfnpo4FWRJ3W9wQzeLzMQmNYnOpIEQOt+wU9b1t6f1IEQCBD2Sq/cylVvx6UjN/6zDljKOycT4dgNLO8LFiSDNsSFaI0lUH5gE1mg3M18c4rNcEzR60U/6FsD78v8yPz6WRBPPBSZ3XYeyx3rg3BEYSCvDOLMtFp0A51rUe9lZbOE/Na8QEw7G+gwgcCKgyNEB9jnoH6j/D5MBi/ZC/lwCBGypMFOKi3RcANqwcdm/moMW1RucZvaOI02P/6UcBxYuWro/HDu3cNXbiA6hN3bVokWNYbVgJM5FZYUxRO/g+vEadV1nXpdgVop7vVmeX5VTYXIO45QgGM/7aNkFMRwoCoWKPTNLX4JOFBCtktrVQIjBUMJ0D0i0aG1HmOf1fIwCM9tY0xrD2qm4wdltwBbvPdV1orU8FamlR6QCFABc8Hsoo1GueqRuBvqax5dFRmfJiq6lXwK6OffOsIvJNFJauh1Gd4zo2KtiGLVlMV8n6IlGetwZ03R9b8AnCI1Qi1Q0k+z9T9zQ8DrT+gHgyLT+S9NYTjk824xZ6mIjdWCzkUcnuzU6V5snUHV2mowsJ4VWP68yar7rPt1Y+zPgGie9z0gtsqSzF8FoZhPnSJNNnk/oMNtMFVinkSC5m8xP7ERlDoBCkuw3cx0tlHUFRw1Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mfU29tZV/cnByYovEX3Z7PRU4u7BqAcFM05us0nNbD1csuMhpfevvW+A12G3?=
 =?us-ascii?Q?tid8pdeCDCCCLVyqTKwUWS7GyJ1x8WS+w4uhruFugv3Tlc9uMufg/GLJD79t?=
 =?us-ascii?Q?/OZ7+xtXiV4khCWeoi3LFiSb5bXeH35UPz44vc8G3L4Sp2rz31ZTzbDtlBRh?=
 =?us-ascii?Q?3MLc0pWM3/pGk/bO/DG4frVWByWmd1PUe5mpJZdOqv/bZHE3UdWKVhT+14la?=
 =?us-ascii?Q?0Ml+S6+19HICrdEGp36z9wjyUXuzYA/a7hcADF0gORrvKN2XWY9A0YHt+9m5?=
 =?us-ascii?Q?pBfepl+jS/kF7QTFtaZ1cirvFpnFvcttfaRkbxkqyDktl9xrTiuNRCRUQ4Eo?=
 =?us-ascii?Q?Htz6G/8d0AhOMEbrmrCq1ABkHQNd2HGcTMdJM01VolhDHNvfxw5D0hanWfZj?=
 =?us-ascii?Q?Ia+B8esEVYGkBnmU0X+Pff+zEUIOOPFBS5L3yywGeGcSvO+zF1EXvCIVba5V?=
 =?us-ascii?Q?Uf6rVji60f3baJ5/lYyXf6I+DhUJMpjSWOSilg3cjoKqAaS4/1I54ovCS+X8?=
 =?us-ascii?Q?VtwcpaXC8a8Evor1wpyPRUtqYlhqPw1izZwwSuXBBqrBZzz2UfubqfrGXumA?=
 =?us-ascii?Q?5VvNCVktpQN9IjFijWFebiXQRXu889QzL+G4BzjCYq9fr5+Mg0jJPC+odWU+?=
 =?us-ascii?Q?jsEbP5mk7OwCv+Y0tqur4FjuOmtllNdaaJgNC+9Ak4MbqK4dBGsi8kIbmX/Y?=
 =?us-ascii?Q?VCAt6NKu+SUzRIZgUkrKbSzucgiaNkx1bdu83pQlzwmWOmoKTTCFNZwuGtNT?=
 =?us-ascii?Q?9nWDi/wXxu6seXowzUV9tWgYcPlraT/wEPp+qpzSzUFiOo+z+M3YxdUqjUy2?=
 =?us-ascii?Q?RtxQHEgjIPK2+rEeEZ5MLchFN/BCZL7cW23ODlAwRM6co3jKWi0lDn7mOmjX?=
 =?us-ascii?Q?uSo1b8qx77vWZHGNW/HQEBmA5OXoJZDYDnNDcSsYlcwmeYEWGftM0wQIka2l?=
 =?us-ascii?Q?/f33N/vSnH85+KMnT/X9GgcBaQqpbVK/2AxQVe5eWcKmg5gqupGUxMytd8HL?=
 =?us-ascii?Q?e/g1cbbCneZqPcn/ocQPSBRDES4IrovNgWxJiULiOKL1PUAB10+Yx/WZi6Jv?=
 =?us-ascii?Q?P6/GumTbZ1oa+Sxo/xcd+Wb6FJzh+M3heknku9efNvvN4QdedWbLPKyJ/9di?=
 =?us-ascii?Q?IVMebdjBOqDsJg/VCBodbTv78Ki1bBDj6qU1e+GITwBQA4RM1ftCRdlyc/e4?=
 =?us-ascii?Q?vkyQKxznIeZdCtP9aKMVH4rWmLhxmpN5aGftOjxasme+sLOT5LxL9TbfhctO?=
 =?us-ascii?Q?vt2akCNHgM4nzcHiCZZZBYgncJIalMu1NJqLfvONPr4pSRlKMZgvzj0FjmYW?=
 =?us-ascii?Q?G2PIAaJYbgiBa5p27YP95AUdFFNgTadyP6fzlTSmyAR/k5TCBIE1BrBV2xA+?=
 =?us-ascii?Q?93nlkQPgr9UhVke+LFqH4FCCn3ChrF2JWf0MzovATzg2tu/d9KxUNlLaxChG?=
 =?us-ascii?Q?EnqqV9c+WIikJM6EcGKcTrEnhM+nvA0eUgNHdtyl8z+AredO8mGfrWipepIs?=
 =?us-ascii?Q?z6bpOENUiG8nV/rNxgXrlr24HUsyOKRzi5rRHPapIucESGiLhws4CQ4rux78?=
 =?us-ascii?Q?yTEysL5eUY0504we0iixGggzHxIRQSVVA2Yq/mP7y4u6Q9JvUa/nDjcfgsci?=
 =?us-ascii?Q?Flgq7mLl/AmqKH8jO8WAKcbx19QdA6QdBJa8B7wgGzcMyFCuP2TUHKQnu/D9?=
 =?us-ascii?Q?0beqE4QzBIrXuMMPCfVxRT3AO+Z7Xp5FhisTf17cKg3c3AAtK+CNbF8b6fXQ?=
 =?us-ascii?Q?539DxshH6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bc2e85-b4da-4cfc-2a7f-08deb06f7cb4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 21:43:21.4958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvdobaGICRXHsfDQ180BpimWChgSUZCGqDR2R19dR+07yB0D6ol0mVEhtmado5iAgdKaI/yLBE1LK4jH+1gxEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11370
X-Rspamd-Queue-Id: AFE1852A846
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10391-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:12:11PM +0300, Claudiu Beznea wrote:
> Subsequent patches will add suspend/resume and cyclic DMA support to the
> rz-dmac driver. This support needs to work on SoCs where power to most
> components (including DMA) is turned off during system suspend. For this,
> some channels (for example cyclic ones) may need to be paused and resumed
> manually by the DMA driver during system suspend/resume.
>
> Refactor the pause/resume support so the same code can be reused in the
> system suspend/resume path.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v5:
> - none
>
> Changes in v4:
> - reset channel->status in rz_dmac_free_chan_resources() and
>   rz_dmac_terminate_all()
>
> Changes in v3:
> - none, this patch new new
>
>  drivers/dma/sh/rz-dmac.c | 73 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 62 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 53ee9fe65261..2bf796dcc5f6 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -18,6 +18,7 @@
>  #include <linux/irqchip/irq-renesas-rzv2h.h>
>  #include <linux/irqchip/irq-renesas-rzt2h.h>
>  #include <linux/list.h>
> +#include <linux/lockdep.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_dma.h>
> @@ -63,6 +64,14 @@ struct rz_dmac_desc {
>
>  #define to_rz_dmac_desc(d)	container_of(d, struct rz_dmac_desc, vd)
>
> +/**
> + * enum rz_dmac_chan_status: RZ DMAC channel status
> + * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
> + */
> +enum rz_dmac_chan_status {
> +	RZ_DMAC_CHAN_STATUS_PAUSED,
> +};
> +

Not sure why use BIT() for each status? suppose only one certain state

Frank
>  struct rz_dmac_chan {
>  	struct virt_dma_chan vc;
>  	void __iomem *ch_base;
> @@ -74,6 +83,8 @@ struct rz_dmac_chan {
>  	dma_addr_t src_per_address;
>  	dma_addr_t dst_per_address;
>
> +	unsigned long status;
> +
>  	u32 chcfg;
>  	u32 chctrl;
>  	int mid_rid;
> @@ -491,6 +502,8 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
>  		channel->mid_rid = -EINVAL;
>  	}
>
> +	channel->status = 0;
> +
>  	spin_unlock_irqrestore(&channel->vc.lock, flags);
>
>  	vchan_free_chan_resources(&channel->vc);
> @@ -589,6 +602,9 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
>  	}
>
>  	vchan_get_all_descriptors(&channel->vc, &head);
> +
> +	channel->status = 0;
> +
>  	spin_unlock_irqrestore(&channel->vc.lock, flags);
>  	vchan_dma_desc_free_list(&channel->vc, &head);
>
> @@ -795,35 +811,70 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
>  	return status;
>  }
>
> -static int rz_dmac_device_pause(struct dma_chan *chan)
> +static int rz_dmac_device_pause_set(struct rz_dmac_chan *channel,
> +				    unsigned long set_bitmask)
>  {
> -	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	int ret = 0;
>  	u32 val;
>
> -	guard(spinlock_irqsave)(&channel->vc.lock);
> +	lockdep_assert_held(&channel->vc.lock);
>
>  	if (!rz_dmac_chan_is_enabled(channel))
>  		return 0;
>
> +	if (rz_dmac_chan_is_paused(channel))
> +		goto set_bit;
> +
>  	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
> -	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> -					(val & CHSTAT_SUS), 1, 1024,
> -					false, channel, CHSTAT, 1);
> +	ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> +				       (val & CHSTAT_SUS), 1, 1024, false,
> +				       channel, CHSTAT, 1);
> +
> +set_bit:
> +	channel->status |= set_bitmask;
> +
> +	return ret;
>  }
>
> -static int rz_dmac_device_resume(struct dma_chan *chan)
> +static int rz_dmac_device_pause(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> -	u32 val;
>
>  	guard(spinlock_irqsave)(&channel->vc.lock);
>
> +	return rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED));
> +}
> +
> +static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
> +				     unsigned long clear_bitmask)
> +{
> +	int ret = 0;
> +	u32 val;
> +
> +	lockdep_assert_held(&channel->vc.lock);
> +
>  	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
>
>  	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
> -	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> -					!(val & CHSTAT_SUS), 1, 1024,
> -					false, channel, CHSTAT, 1);
> +	ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> +				       !(val & CHSTAT_SUS), 1, 1024, false,
> +				       channel, CHSTAT, 1);
> +
> +	channel->status &= ~clear_bitmask;
> +
> +	return ret;
> +}
> +
> +static int rz_dmac_device_resume(struct dma_chan *chan)
> +{
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +
> +	guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED)))
> +		return 0;
> +
> +	return rz_dmac_device_resume_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED));
>  }
>
>  /*
> --
> 2.43.0
>

