Return-Path: <dmaengine+bounces-11007-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNmYBKhJGGpSiggAu9opvQ
	(envelope-from <dmaengine+bounces-11007-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:56:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1725F3302
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 644FD308145B
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F869283FE5;
	Thu, 28 May 2026 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="nNOvkdbJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011013.outbound.protection.outlook.com [40.107.74.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DA9282F17;
	Thu, 28 May 2026 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976229; cv=fail; b=n7LqjJkkjgF6iwt6iBxswxS6OOOq9Xk9wUYmHI9rOOv1pW4B6EsTwqUpqL28rp26kol0xkiAE3dkYROs7NGsU7t+Vc6l3EH6PdCbCWA9tsI+HyXa9uDRpnNnvmDhMMBrpEyJbNNsxQt4rBju2WqjxRDShp1IidLEoa/IH/GAeC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976229; c=relaxed/simple;
	bh=gB8UhJtE8WeiXh1RzVUeWz/xbQelrW8T60YE0RJMZsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nvs3WIDktTOHLMyTYoAO5XM1iUQpY2czyXJPt0CxrHhDXROIkDkQh0uKrQbV6gDGO7uAi0TugpbYhMXXPZjBZmccU8Ze25aKZHfEc76Dn3raMZHQha5P49BeNrVkg7E79L65vv8T409Uk4fVcYTpE2KMRzYcdEsFmPzypNywr5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=nNOvkdbJ; arc=fail smtp.client-ip=40.107.74.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyw97GBE2zVz35fBHh22RRdI7koC7wgFmkdVfFTY8NgITnMUGu60YRrDi0B+vh/DThoUYM9/bnXwmAmMvQ+2AlfiQSgapSOVszVG8NTPpdvykJmAW1IGxBN2ql+8+TTjCuK2JOsdAElQd1w56mdPELeh2kYaOQh7EY5mlqKaVzrqEeot4uTFVDjLRA4y0RXuqi+ocRAX2mfOvX0qHCP/bmXgRL4dvUX8NtEVi6aOHpf+6eJBq7VdPy0MO8UA8ZTSaFoMOxJOCn/U1SK/MhseiYUG4Qt+cfRA0DZCbAqEegdJWULDXB3opjyN1AFWjkEY//nIm3pHmt1cTvqlyOcHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8Ich4ZFxulQofNLdXznzAAonUJxI4Eh7GpnroTz+ZA=;
 b=gueU1aBKjSiFDDCI2tlNQmi9KJbYShTBiocPGnRa81rEtUGKPYzb/iB0RYYZuCmElU0Kld8cT8R6PrqX0udXGP+7ipmCtiVQxE7vmy0tsSzN/Y/EXNoM/CAxXLuqsPT1l6kFha1bDiu+zgjszmjlGMq1dROI0APJthFSftWBdgvVJCmWmQttwmXz4w5BcYsigbUEm7tyBB8KDFbFhb9HZU3spWgtEMIzhWtVmUtRNvPEO4Jv7DZyDlGU7cJZf5hHxfGesAHLLYL3y6sB/VcEQZENpiuUXUDbG+vMtbxGI1mkEUl/eflEoa3+cNyUPJLFIKnrY9imn2Nwp76UUt/J8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8Ich4ZFxulQofNLdXznzAAonUJxI4Eh7GpnroTz+ZA=;
 b=nNOvkdbJv1SjdywEcPIIvKGkXeo6BQbxbHcvAPB782rp/zEFk/4LgUSnwNrNw2OhpBBWLExBlGKWqonVvqFNbbfDSNvADVRIxzU/Bc02sQR56WCL52JjCqWtAQY++cPx/eqUD5IDO44Nc3r0jsZjNX2z0JiI343wlChQ+vNR/mE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSRPR01MB11420.jpnprd01.prod.outlook.com (2603:1096:604:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 13:50:23 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:50:22 +0000
Date: Thu, 28 May 2026 15:50:09 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de, geert+renesas@glider.be,
	kuninori.morimoto.gx@renesas.com, long.luu.ur@renesas.com,
	claudiu.beznea@tuxon.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: Re: [PATCH v6 10/18] dmaengine: sh: rz-dmac: Refactor pause/resume
 code
Message-ID: <ahhIEQKMlxFL2VWm@tom-desktop>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-11-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526084710.3491480-11-claudiu.beznea@kernel.org>
X-ClientProxiedBy: FR3P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::19) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSRPR01MB11420:EE_
X-MS-Office365-Filtering-Correlation-Id: 031daf30-bfd7-4c73-b0cc-08debcc01041
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|18002099003|22082099003|4143699003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	zclv9tQwtNX5OKPui8e9/mteL+EO79F7BqHSK/RGxtdMqXlhY8QkV3DCryvd/+WzywqiTtqaqIjSIdOiSwown1ww1QwEAjHxx59TqPNgG7VIbBjTur97S/Re2keKqoZeOQk9vXA23rW1DTpNPD9yXDy6FEUyWFFQG7KVl/U04IGE6vl+O038nwK6hQlqIoX49sCmLykNpkPEN4EAxc3YlJ4QtpmflgqMYXwcdZyR4hxFkANYsFwZzcxUFBv4FcQcLOhErUVm1kNcZLMb89UkVTygRzW+SUZBOPR8SJYfvLSGWalCWLxQ8gTp9HOJmmAPbrqiy2wrOQob6VPLLhdLZePo9BYLoOERYjFPNNdeVqhnHA89Y91vJlXC8VPO7Jli28/ERR+kItMNSgFc9gjwDtkj38hheNDbeOhZy6QhquQ3FBNPOkpS9PiA8qBHag/z/JzIK+triRmXILUjt79++rSaATvoUJBfurSskiz2nv18uqwSGgQ54A1A9duk4WfLSqFdyCE1OoCiVKAcwn5zZF3oJ1MHh7z5taKfgQwzJBDdGJNNaHWZWb7mUtU+Rq8fC/ulZx8qL6zU6g3dq+20F+R+UIYB4BJNHTMggFvfuMqL+ImxqTd281tp7C9Cb8ijJF6UNBU3NGQXQCv/pNPnk0PH2PJ4nDUXRT93TfgMRmgHmmxIE1NyY0GxLCWjBtgvJsX9xnaY3/JGP0dUxCIAOIctQkvG1WUW955DjRTZf+QKCb41aCrtpVyxZyfyXap9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(18002099003)(22082099003)(4143699003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dyD/jSMGZysjB+Tmzp/T3eODZUkjD6m/2/ec1Sl/4RZWkehPUkAb6jc5Rtq5?=
 =?us-ascii?Q?pwza2u/L2QWhrjSzK0h2pEWLsFntI1Byy3uDkS+Adlm23vct7p4gnu/GHcDw?=
 =?us-ascii?Q?upp29Ci5mnLCvWawVRB0vPjJrxpEfP0sZr4iFO10xXswhZE+BHancTeQDCoA?=
 =?us-ascii?Q?zAOTaol3JcXc30/XfeJNo1jEJdXgGB7N1lmkz7pTl9brnYtH9yUKCLSrrH1m?=
 =?us-ascii?Q?RSTaI1dZtMLs3m0oZUlUf/4xDcMTQ6IdVzpPatOGwDmNWN2h1xgwaLOSwMds?=
 =?us-ascii?Q?CegyGirGVVGn1cC+BC++Y9oZxrKmApE/pOjXd6SY5uI9oAdmjmzoAmICxxfo?=
 =?us-ascii?Q?KDFCt9Xmtj6EePhep8CAraJc/4hi8wNyCMlL2Kn/aQ+vt+bo2Gu3p0EZw/zk?=
 =?us-ascii?Q?EYmPhodE+1VeVIVGaz3AWem04ivYXgcI6COyQrFrTP0y9ld9ZR5q/GlcnCSu?=
 =?us-ascii?Q?AQeDpmdzhQp1wbByMyMHwgbfb9tmEhWAbFev6wIkOa+BqAKCd47vdtvs67Dm?=
 =?us-ascii?Q?4jUGN9Dr3m3+rcqB6Bwo7mmdx9UYFkWJHyovUUb1MYnetPKq53mDrCGRqK+T?=
 =?us-ascii?Q?spAUReyfKE98WlrrsFlodMfFrO2uQB9PSPWHbjVu9KshUqMxXh6SL1OQ0LPV?=
 =?us-ascii?Q?FDonbVIpu8MR+2+ypElmXKSLtu4r/jEAVJkITPsQ9UltbDNhdUVrM520d6Vk?=
 =?us-ascii?Q?8jlbukA8IKsXRBlhLZB+onzH9N9Ay6WXO00ln1DgxHwuZDeJv5l8rSdy3wmH?=
 =?us-ascii?Q?L+F6h0WATNbP66Vt7gpE9Sk2Ly8t/KAXQJeTWXV890EEQG2IYXR7QhX2+V4B?=
 =?us-ascii?Q?n1iQ3s6Pg7cMJUi1XiNxFzZKFSJrGVWUzxRCPOr9awDKbiqGwXOQehIHvNGz?=
 =?us-ascii?Q?q3KDJYrmmXMGIo5FsnduD+Qf+HrPRAiuG7L2u2PV0rWi2I3sm1+3QpqiYqlu?=
 =?us-ascii?Q?xNFTCFiZo8iyFkyt05xLVkX9RYXiAL7A+80A39RPeUSuzDOTX+m8sNQtA1PC?=
 =?us-ascii?Q?JuuClMpAWIHD3RuMWGmsm9poXFlFsAXjSLqH3zctauXMv+F0oCtgQTjRhaoT?=
 =?us-ascii?Q?yN2rRYAzq78UNvYYp89B/YILqmfnUVVlGBWs3jyKd2dm1R/HwtA54Bn/Wcrt?=
 =?us-ascii?Q?3AJ+nJfAYYYhkvIEVUkx+IT18K93kZDtl+dBwFuf0AGiUa/2Xiwklx13hrkH?=
 =?us-ascii?Q?3eIuABIMXcQdA1loj5V8F2AWmkTUqd5Gt2vixZgAzVSXpMyOoI6S6Eb+xho6?=
 =?us-ascii?Q?km1DrhTHuCLgC03dsaMmJFIUDxo5yLNaAJbdmYlwLlh+jZG634LqjOcO7N5H?=
 =?us-ascii?Q?agbv2u7CW01A13RGidU1B24gQFBHfjeXg6bF9HmYtD+YVO2wxhmVhFIt9w7b?=
 =?us-ascii?Q?+CNBoslglznzx7gyzGdeF0V7rVqCr+B9PO/WMXczRizU4CZmy2fBRyFTAjlE?=
 =?us-ascii?Q?XMxfL17p3peV8yEqLPGLW5A2k7dMSvASOU0FGp4Fd53or5V4eQBgSpIH6wyn?=
 =?us-ascii?Q?Q612No/DN/aU13vwCOkEwKBF6GnC7W09DCJIAiqn6m0aVV/sCkZHa0IdwkvW?=
 =?us-ascii?Q?UzpgTpg2iq3kYgfbnZimgIWb/97aPD3fxKM6SPuMuNkV2vp3wHdnIqtY7IRy?=
 =?us-ascii?Q?YdwynK4suTgFfxk3P6+NY3zY2Z2p+I+FjmLxQIMqiMM7iAMDjifmDzPpb2Il?=
 =?us-ascii?Q?8rDoBGme8WUH+9UcpTu1zv6G5BjLQNFx5nuucFsGhmwNX8d1u6fWs7y86Fo2?=
 =?us-ascii?Q?kmkXM6++yCnDWSAz2pMtUCvHZ43QKnU5uz3FIsvV/qtdFHqNU+QE?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031daf30-bfd7-4c73-b0cc-08debcc01041
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:50:22.9152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgQJ2v2CvIrUmZo07cLhaiUCmphX81aMJGhCfeJvpnbWraxqukBM5kaGS6HyHQb52BP2pLEpHQIdILALgxh4E5EeNsfk3WCx66dCTPiF1B2CpU6rQhp7GUmf0Ng6Bw7+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11420
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
	TAGGED_FROM(0.00)[bounces-11007-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,tuxon.dev,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:dkim,renesas.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5B1725F3302
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:47:02AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Subsequent patches will add suspend/resume and cyclic DMA support to the
> rz-dmac driver. This support needs to work on SoCs where power to most
> components (including DMA) is turned off during system suspend. For this,
> some channels (for example cyclic ones) may need to be paused and resumed
> manually by the DMA driver during system suspend/resume.
> 
> Refactor the pause/resume support so the same code can be reused in the
> system suspend/resume path.
>

Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v6:
> - collected tags
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
> index 1f884ec101f8..557364443a5f 100644
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

