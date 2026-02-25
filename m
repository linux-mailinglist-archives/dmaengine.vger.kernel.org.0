Return-Path: <dmaengine+bounces-9090-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJQWGNEin2mPZAQAu9opvQ
	(envelope-from <dmaengine+bounces-9090-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:26:57 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351D19A95C
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DA71300AB2E
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2393731B82C;
	Wed, 25 Feb 2026 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tv5PjOO2"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9F63BFE44;
	Wed, 25 Feb 2026 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036814; cv=fail; b=tMMDHm64TVpLjT08F9B4tBrrDgE4GzaAZYLkG515UGoyXOcoBRVTOBIIa78tFuT7bnUEhb68nv8lqPleYZ4oBhQyJJPq9Aa0D7TECidsxKS8CWCDLdPAvHKiIr6dGN/Fa25oJJZw9SvXYmrj+Fg3zUuZHRnH2Ehkv7G2WQ8kWKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036814; c=relaxed/simple;
	bh=uxscVv+nYo7XnEcXoflBZFHPf0KkEWsJEjtV0Uic6D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ep+WcMvZP8NYfSUnm8SmiB0wvb8VWzlEEe2iruZsN82YPur5vReE0w48JzfT7iqRKxDo+D+820mFu76/YflutELrWUdkZohKo3jGqDHN4VyRK7g28b4LlZ7t3O+7DGzmOY+ulK9NluzWjMtLcIuiTyMUzA1rokNkhtvmdOSDzSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tv5PjOO2; arc=fail smtp.client-ip=40.107.162.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0FAoKsrQuQCiVLWqKty96K9E3k4jPwMWv6uHGWn7DeqTf9ZU5ooZd4iI+/lMz+W4LTocr+JlZAnmyfjeS1XUmpMN8/ue9AWWT37DERoEVA4MpmLgGUeId4MY2KsarrZKRJGxfEe8JuQ15JgG2D93ZUvZ13AkZGb6jcmG0fxIMVMWn6X+g19ArMh2o/lbTopbrR2yt3tEji26sMdtNA8y1aZLIcXMjxGKZT16cLJBoqSQNUKNRl0G70BuYpImQBKwdDcMpbwVT8GXPFnsLXs7h403t1kUCs+udWe32gLQvApzz5g3/Br7o9ao2vVttqIogJ8Y4IK7CpibRETC9tdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSRwuVpr2W8hRR55W9CjWcslezviiJhmdEtoXNji9L8=;
 b=Fo+hcICNXMS6CnRbjtDMJ/ayzPT11me/kNF7/4dI9RLpUE/l24rqSZmqjRXIA33xy1ihEzsEDzPqtfB8v59IJmWXjMpD7N7MF/QdSy69X+n5SmMnmvXIJ8N7kxFfUeg5iaj1xv+DlHIrIWvAUlZWvT5JTZX2tK64V/RJZldfXIRnUKUr8HW5aigI48+HIfPSd2kAX3HZWYO+5WUBDztNkObsGCqe/fgXhGSdmw4RMZ0E88v6tOH8hjQyq5KsT2UXfnk28i4LOnys5oXfIBmmmQBCzA10d6NPAXhRwNIgAK+boLr/KA9bFLYJJyG5R80IuDi2p6FONnmfbxjS33Om1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSRwuVpr2W8hRR55W9CjWcslezviiJhmdEtoXNji9L8=;
 b=Tv5PjOO2UZg6CQEu/TVamb3OTA4QyL5Q6ZScfiWhFuXrXE2Z7aivoTHqNCs6CvhoLJ95yuhS71znxlfU3kp6OSO7itAPTwIAg5yaVV7cWeoMIMp3DKVAeOUXjHP9cu546JgtbW6GWo0Zx8InO2Zg0hcSbudriicrt0eEFDZFn8GqHG1FG+l0QCq8Jy7+oFdWg3oMX/3sDEgneBMWZZWCs4gRbVgVbKkam1wG7+gblwszuVR6OdwY2XpU670QQbFmCXOVicVz0RYzxZbEbSSlOzj5wIErLRjtCHAK0Z7Oi7AvM3zGMs++imsZjbd3l9kcmSyOkrSAJ73JVsIeBuMu3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DBBPR04MB7996.eurprd04.prod.outlook.com (2603:10a6:10:1e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 16:26:49 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 16:26:49 +0000
Date: Wed, 25 Feb 2026 11:26:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, geert+renesas@glider.be, biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v8 6/8] dmaengine: sh: rz-dmac: Add
 rz_dmac_invalidate_lmdesc()
Message-ID: <aZ8iw0pT9YSbELEu@lizhi-Precision-Tower-5810>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
 <20260120133330.3738850-7-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120133330.3738850-7-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DBBPR04MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 613c26a4-f575-463b-6791-08de748aad17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	l3eyZ60C8afwjqKogNJeAHAJ83qFm3g7WTSk0L+NHpxBbsV7iD7XKTas9UcUKjZqgIUuz/jdgEKKEnyHXc9glgOM3yfj0qxPTfqlTccldF0upoZY9JtmkJuAOhPkA/xJ9m+9WCGF9vzSJcVo2vJtcTsYNrAUIFMBdgv+G1aPmVNQkAws0eLS4f0peokjgW/n8+qbpUaBBNW9hsv9DM8GHLehHiIUg09CSz2PGgzd7mz6+OaO1qvpLdRv4kNtXTdhlVeTgXuTe2sI9lcyobWdkPcZrxP6u1jQNIWq5bxcFucZrGcG8eUmKWSzDrhyArXENzDVm/vj2+cktGuwPN33Re31Tj8kIQjSfrndSgXXYMAy4gNkKHM2lruuELdR4E26ny8rBULiC74n+eIAtpZqhdt3UfHMI+qxUhCkgxvIYLZpGa31MqdJmqdaAnUZOGn23FlMFSlzCuQ7ZeFIWxF/Qyw5UufFzq9Xkz0IVe6htqInP5zw8iHDBynV7/jhJscL0jPuO08yhE1PV74yt7mAwo6iibv9HvCBM5/c/QZXcYZcHdOyCqKaLNLAKW0PyBXNCb8vxXVwuF4ezSb6VK/5ni33NLNBgTYlN6uX62yDZ95WS4smTZInOlC4WU71DLhVuDE/ao6P5Eggk3b3iGlxCLP2451ECt4714tDi36vXYqaOFc+EriB3KHiA8F6LaAUa35u57XgJfusLNJRKV8AeMGIWPCEwrxXXoBxcQbezgmnmihRc4xmPUpB3JvCEtKRiaRqQWW6GrcJCk9Wjl+mF6dWMFHvlwZG2KdfD9dcJZI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9llLM7ocCVRVecKePls+ztqUfgKs4V3tleIoftldkrK5GD0kHyDgYZfgYmn0?=
 =?us-ascii?Q?Bdw5qql/W8OWgeG5iUwlqRmXh6RPMtUMCjIAbmOWRdjW7jYDicKYvEqsHoyX?=
 =?us-ascii?Q?urXVC5OKcc6Yx5ERiWrnLt42ne3HbzmUSoVMJuPfA4+HF2RzGwKuf3RbVo82?=
 =?us-ascii?Q?/9OE+EhECulV6ka1GpxGLs6NoBakniPatetwmaKsLujZFCzaX4OP8Etq5MI5?=
 =?us-ascii?Q?vYTyAVbO4D3CebeXUBk+Dk6L4MYAjjEKW92Pa8NWJ8dxFJJqwuBPTLKRtdFW?=
 =?us-ascii?Q?gv9gcT/xdi2uTHILsaDwlYFzEAv9cdZDXX2N95bDS2j3sdvbmllu5f7CFmOF?=
 =?us-ascii?Q?JDscGrlvaBCnY1Ph22YlldLO9Blu6rW7OO5dfycyD3bxKcPT3el0/efd+21i?=
 =?us-ascii?Q?oIsg/pHZ3C9hqJgUWXRWe4X0elIsPVk1OP2f0mqOt7hbsF84Uyf+6N2d24mu?=
 =?us-ascii?Q?w5eXDWxENPg0FY3JWhj/abHJhsuv5xGShuZe0nNEYCJUMSG82HDlv80Hi11Y?=
 =?us-ascii?Q?qn+HLSPxPr5quar/ta1LbSLtSz3YXt8ReZYL/kM2GdNPcbyZ4vjVObUlhDnu?=
 =?us-ascii?Q?1nEuj2fCBrbkfx55+asBlAQ4tQ9trOAa5GRInbe4bmmnv7k2TILidNzCmB5M?=
 =?us-ascii?Q?WnGvSTj/l2kTBFr8Hzczvs1YJ5t21TXEvSQ5DeypNEchG3KifcKfZkDQeHu1?=
 =?us-ascii?Q?QfsDd96cgPia0k+oO5h/PSrj+JY3S+1d7dWuL/XKVKU9ffDSUHZ3cu303sox?=
 =?us-ascii?Q?kY11sOrboAmLA9Aw2UZBw21Rt3Q8suuoIvAGOuAGndovJ0F9xi8NMogzUyqV?=
 =?us-ascii?Q?epAxgSyiciTKObJtcBp28tUwXHTVjldE3J2l9uKkXJyjV1F2Q98nqO8rADiQ?=
 =?us-ascii?Q?CyjkQoFwd9uDKHPySdRz7guj2QhZ9JbibmzRGYDTrrEKAGDg2ZreFqQVyo/r?=
 =?us-ascii?Q?z8o2B8aL3vD7rp08PGnRI1A8Zf2WLzjELs5fLapSPB5i/UO39q8ajP5tSQhx?=
 =?us-ascii?Q?6hiQL5S/r7oeO2JAesU1BDHtInncxM/rZ9M65esPB6pyBd42X0eyu1SHMwyJ?=
 =?us-ascii?Q?FugI785tXp5uEkbliw5WhWL1GOAQgPqPsEDoyGlWow2USHkhuQboAKnG3Scd?=
 =?us-ascii?Q?hfeWXJDxTVIA5UjDQfFni9LgquVhF8BOrJaHgcRCrnq9xCX9yoJvEJT+rohn?=
 =?us-ascii?Q?A0HZHYS5vaW0K9wlY0LHSNsOfXvsrx30tpttzK+8B8+dW7WOwaA0FRVxfSVs?=
 =?us-ascii?Q?jxHlkzLUCZfqj7Esx7zpuH5WQ/aMWJ1F9gZIaihgO0fzuUT+lCsDnv2jwpdU?=
 =?us-ascii?Q?TE4gL34gUndG8jBT8vNrvEUmWVGZskcaW+uRZSq64KWotRtx1BBuVpYVdmTe?=
 =?us-ascii?Q?YitpAo5nNGhXs3OCQCf91yWswcMqkg7LROpn5k83cmJaAEQbneRqQ/tf5BUG?=
 =?us-ascii?Q?38gyFVqdpvGrciGDMLUb5btT+W8sRTM3jYQwD3W1BAJbNU07QYbm9RC1p+4E?=
 =?us-ascii?Q?DbNTsUVsACUzcPgzyy7zYLAVxtVb3UUpkPsUlK7hSPQz5gfZq2Vmulau3HYT?=
 =?us-ascii?Q?I3IvaEggGlxpxE4WXxW3bJ87JLfMxxco+7LHhj1larxeSHLVJET8s3b4PKmf?=
 =?us-ascii?Q?9SiAx25UGt8/rnvHd6sD6EJ7kkeeJ545fPqAdK6elTuQry/vW7IB7j/qM0cB?=
 =?us-ascii?Q?1bvK7d+u+6nq+yX7ERJDd1LaCoFr2HbaC3l2AQK1Qukc/LN7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613c26a4-f575-463b-6791-08de748aad17
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:26:49.2894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gkmdpd7zu/uY4h6rj3nKz3KQYa/KClzsI2VMRIc+bvW2RK68sdOxa6cdnHSusuu9FOxavjHm9RpWWWoEidyAUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7996
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9090-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,renesas.com:email,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 0351D19A95C
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 03:33:28PM +0200, Claudiu wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add rz_dmac_invalidate_lmdesc() so that the same code can be shared
> between rz_dmac_terminate_all() and rz_dmac_free_chan_resources().
>
> Based on a patch in the BSP by Long Luu <long.luu.ur@renesas.com>.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> [claudiu.beznea: adjusted the commit description; defined the lmdesc
>  inside the for block to have more compact code]
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
> - adjusted the commit description
> - defined the lmdesc inside the for block
>
>  drivers/dma/sh/rz-dmac.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 1d2b50d6273b..4602f8b7408a 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -256,6 +256,13 @@ static void rz_lmdesc_setup(struct rz_dmac_chan *channel,
>   * Descriptors preparation
>   */
>
> +static void rz_dmac_invalidate_lmdesc(struct rz_dmac_chan *channel)
> +{
> +	for (struct rz_lmdesc *lmdesc = channel->lmdesc.base;
> +	     lmdesc < channel->lmdesc.base + DMAC_NR_LMDESC; lmdesc++)
> +		lmdesc->header = 0;
> +}
> +
>  static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
>  {
>  	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
> @@ -461,15 +468,12 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
>  	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> -	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
>  	struct rz_dmac_desc *desc, *_desc;
>  	unsigned long flags;
> -	unsigned int i;
>
>  	spin_lock_irqsave(&channel->vc.lock, flags);
>
> -	for (i = 0; i < DMAC_NR_LMDESC; i++)
> -		lmdesc[i].header = 0;
> +	rz_dmac_invalidate_lmdesc(channel);
>
>  	rz_dmac_disable_hw(channel);
>  	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
> @@ -561,15 +565,12 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  static int rz_dmac_terminate_all(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> -	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
>  	unsigned long flags;
> -	unsigned int i;
>  	LIST_HEAD(head);
>
>  	spin_lock_irqsave(&channel->vc.lock, flags);
>  	rz_dmac_disable_hw(channel);
> -	for (i = 0; i < DMAC_NR_LMDESC; i++)
> -		lmdesc[i].header = 0;
> +	rz_dmac_invalidate_lmdesc(channel);
>
>  	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
>  	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
> --
> 2.43.0
>

