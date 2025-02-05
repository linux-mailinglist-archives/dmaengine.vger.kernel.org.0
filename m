Return-Path: <dmaengine+bounces-4311-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E996AA296D2
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 17:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA23161475
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555A1957E4;
	Wed,  5 Feb 2025 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nF890Lp+"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD714B088
	for <dmaengine@vger.kernel.org>; Wed,  5 Feb 2025 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774513; cv=fail; b=E/c7RZb4kg7mReiE2cSwB1Zhpnaj/1PIxSiww9bgGDrwxGNCW5QxIhxU+gdyNgX4lA1Kv5YOKR4r2Luokl7GbSXW2HCSbLLZaXQqVzK33bjxg4tVcFum5I9lH8h7Uq7oKGwVKFXuiYFHov65HK2ScAASyRn56jkxewQ9f8fHtyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774513; c=relaxed/simple;
	bh=Uosc2GAtpDdMb1WUsPfGCaNB++wYu2vLB31oeJ8tkY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u3QLrnOExkbD/kaVxgYKoqvl5L2n5Ar+kmgWXgKWqwLwTyrIgUTyVHXZhH8ZPz1Thd0u5iNaioFLvTemz/ehbqsC6/Cgw3CT+2jd0c9TEAU5LNa0ZuopSQl9YW0iJD+YZpg/2uhuV8sOc/a94wOii+TTY+eEZTnWodRA8QDMb1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nF890Lp+; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCG8dDMK4dkbhmXs71dZx2DeF4zYu0ierI7poRiuIgM6EzlDr3AmXqKKmXhG7KzhszZk6B+bMBZ2U0EcJGAqXn7NgyY4UoxeiM16erniWjHtabxeZPHxF6Ogal1v/5DBTpcd3sUJ9zeYnDTTlMnwYU/4cOsRz0shhFIpfPsivKoK30VfIL3Hg1zGGKQk8DHEGsC1OJMxIdAZkshExiIR53Jv9s03glBd99ElZv1X9XH6DKaKEaO1bPJYzxtPVo1SmDLXY7zzjYNHlE/I0GrOMrUCwHIlU5BfK+/h1JN1lcIHXoGCGC+DhVhZMaTQdAYM9KokVTTu018XGwNBrD4Q+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PWd3Mrjtf6ePZY1ycnS4L0YuY0NlJfOS91V315Wq58=;
 b=PwNIWfECl97sUD1y2WC+1RQWYcaR8Qk/DGLWSbNEBYNcLlbZ9YGDo0N+8/QkD4qqeI9k+stV9/IhL/Oa3qe+dwUTq8cp6lvYGLqKlWUyb2mcJazRBaA0Tuux1xAYIVKl80DAgzQTIanEeMACfaLmSat4MjJ1VJTf6rtLR53ikb77QSFau3+O5mFXl5cklPs6I0KuD7/HR7h1Tg1qYdHR7I+tt2v6xkpk8bx/rgCSMcmD5kI6R1qflZ3iwSDre2InyssdxVFxsrzKIS20fAjY0Qe69m2jI6+C1Nx/ov0PMFphDe3D7KnJso6Ql6HHWm2/+Ge31DQcmFU/Au8v/hQqsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PWd3Mrjtf6ePZY1ycnS4L0YuY0NlJfOS91V315Wq58=;
 b=nF890Lp+N1XqwX65vGwgfGr+aRagB0zQzxOh657JRrWWqp3wZYBGXePDLbHCL5mi2r1GCylHBZccOMCRxeh765Xgvo7M1t6EClw5OadwSBz6fUCW3FU1mni9Smw45bzDpfXodbQ7cv1qW8g0jenerQeSXudmgROga0bUoKJItXN3naEpz8Ih0ADy2PY+2O34rsKPLKHkoNL5OaQWlrtFjkgnYornyF0o5pjnb+ylJ3tBHuuIODBM81s+JNy8MqbeAwIu1jcP+5XgKrKYQodRajzupTflxAB1Q469rdyySJTZOXLxahHJ5iKvJ6562BmvfSzZlIydCrGyaVCKQcKQ7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV2PR04MB11166.eurprd04.prod.outlook.com (2603:10a6:150:279::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 16:55:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 16:55:06 +0000
Date: Wed, 5 Feb 2025 11:54:59 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Vinod Koul <vkoul@kernel.org>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: fsl-edma: Add missing newlines to log messages
Message-ID: <Z6OX47CASlYp1bXA@lizhi-Precision-Tower-5810>
References: <20250205091455.4593-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205091455.4593-1-wahrenst@gmx.net>
X-ClientProxiedBy: SJ0PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV2PR04MB11166:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db5cd69-2249-4691-71d2-08dd4605d756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wyWdxhQhqOn/1rN5ioIxl8u/53HdbDPrlENmGaNj+5rbKd32+JtKs3Otkf9W?=
 =?us-ascii?Q?zME5U0m5oApPW463VPo9oehlyydKb8ka73otKjwB5dLKcZV9KPVD99NaFagG?=
 =?us-ascii?Q?GhKobWEUZhgowZ+hDuPoVeodvv3UbxyvDG0yB8Pg3dHs1+XepwBQX7/iz+ZQ?=
 =?us-ascii?Q?UslcdhhrzVxJR86mYamYJLoSFToHA+VpLWehimkw23P8f1dteSQlOzf2vK3w?=
 =?us-ascii?Q?K03ysMSQd/J1YZ+/9nA43WqqHMsFpaQWeALZ5orEGuVxaEw7GyY5NR7loq+5?=
 =?us-ascii?Q?rwSVWX+1TPPppAQb2GaOioBwwtCDBawvKxgX5TAFALAzfW6hezS8kWZuyoFF?=
 =?us-ascii?Q?vR5NCRLwZBIfakm1CCAc5i+1C2d8DN6rin7a5Qq7Xm22N+vS1EuGWtkmswUH?=
 =?us-ascii?Q?LIemHd1Z5vljiDN5AHINgHiLms9D3e5iaqrNU57GcB7R5bOErg4diJ6Hs7Jq?=
 =?us-ascii?Q?heKYxR4RycHX4DetZDR9ncn7fYREwJRmE4QSCb0W8iVhQCXx6QuILlSgqAtu?=
 =?us-ascii?Q?wgTqHJo4DGd8uv4rbGrnvRqBOyGDrAqedVr1AJznCyW9vuRX1NDeLXjhGk1r?=
 =?us-ascii?Q?x6Fbjo2rkpCZAuUC6hE+99H5O9s57EsuwkYliSy45xXafPVrNcxiX2nyQxAp?=
 =?us-ascii?Q?RgIy+92JUbNfx0uoKn5Kmr8fWQddasyeM3obLaNddg0BEUL/DYhW9UXrvHcz?=
 =?us-ascii?Q?p6S3VkPwnx5ABez2FVMy+Xe9z/VrB8R135Vi0OtnquG423CtZO5p/JAz/XTt?=
 =?us-ascii?Q?tvRSAjYkhoSx6D/nR11UEt35baZlqoVnCzb5d9l/oISFwzt70Xi1D/dlSQZn?=
 =?us-ascii?Q?M+TANHgRUYU84/CGk9yGZPdC/sz0AaF2ckY2MZs0Y62YnacmmHMoZLq5yQkY?=
 =?us-ascii?Q?D/QwCPVWmnhuf9JhbOIHrQQUfsNxO+yFnmeA9pkQA/jk69KtUY20TioZ03ux?=
 =?us-ascii?Q?BrpbwjMN2aDHkXzL9j7F44fCVkaqO1RxXH3eqIjxlzwGezcdmL6gRFPUr2cy?=
 =?us-ascii?Q?NuJGNPGKSJMvgVBh4OzTgJQ+0a8ASwr301L3Jd+RLBLUJUnCU5XYkpx9ODjk?=
 =?us-ascii?Q?CIRR44K/sMC6qnKee9qeWmQYBner2bM7ibZSNCWW1U4bcxSDWwu9ei+E2T9k?=
 =?us-ascii?Q?58aQu+UgE52Y9kb5BdUOWqHFiEzU9EM8nHJ+OBaf1ACClD09UtlUhmg+GvLq?=
 =?us-ascii?Q?R8gUlXEFzzDMpd7iTounQ3/LSuqo33Tu1YHlc+QsTdO5+GFO7jLbwD8FMbmQ?=
 =?us-ascii?Q?Q37eOmUm58BlHnXACUcG9pCvYKKQtz6UcYWJUDSm/5KpAHuzOvv6R1ANQ6z3?=
 =?us-ascii?Q?CCFZZADh5IBqVNXRT8gMMVO3EHP1KsnLmB7k/R48eEANWJPbLLIc8/hw3Xuj?=
 =?us-ascii?Q?fsziRM6Of8VsMHk9kDFc3lQgbOR8/rXi4uhlSIsEeULdLd3RFYM/g0XfWFhT?=
 =?us-ascii?Q?nG8h91odwXjHEUKyd8bpjp4IV7XdC6Kn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kh8hRfF99nayYcsZeZtzgAedWVzFhd5eTOvDLRnI0w1y3Y7VkLfNMmgkOpkk?=
 =?us-ascii?Q?I0f7ggYe81PsDhxqoZHyRcx9qUdAa/wTw1hnohkT6KvAkXeI3+DW7vzMN+eR?=
 =?us-ascii?Q?MFgmPeLJzwmD4KON+svx3JH5dhAx9O1HMPV3xrvoj0inJNpzZ2NkO2SjyWi8?=
 =?us-ascii?Q?TEy8kqcp9TXmJsXZ6p4/6NDBt0E8cpnRg5iBAW9iBiJxZ2CNb3UyzNH22A9e?=
 =?us-ascii?Q?mrlvcu/peWu0mbMT2ykPO0y0bwgAU/KMW7oSykg+osnbs9yZ1BbhaaNf3pHM?=
 =?us-ascii?Q?6qH8b7wAhmc9VZLndsWEuNJIReogEeNjOY0WcUE2iAF55enQXc6d4uiSuXQ8?=
 =?us-ascii?Q?TT63iZw/Huh6sEX9RUEZc1pT0qHvZ5d8dZyM1eD19g0d+RfV2AZqEjhDAWKy?=
 =?us-ascii?Q?T2MHfEXW3riQfHH7NGLO5EaG3YlvnLiQM+psLWzXHQhRbNU37InwnJCEyiGJ?=
 =?us-ascii?Q?3jFBMR4yDQoPnOgay2DgHgPdXju9tF5UmJW6CdSiZbXf3/+ACmCEiFuxwPk/?=
 =?us-ascii?Q?0OoGKy4GBkPVof76LinF8gpzs/C7gyHBKZBGFxuQx5VQnbb8rEUmVR7EzQtK?=
 =?us-ascii?Q?e1XhrBK4gr7M3vW2uajtD/Ovqcy/IQpGVssnY/g5jcJ1k72BZfXghr0kM956?=
 =?us-ascii?Q?WC0p0WdFVFZhyOhN84SRwNaDur1lpUa9YzdKRzJiILbbk39n3mYSnpABlqPR?=
 =?us-ascii?Q?dOmbT/rrYzRBBjTJvMQihqTaicgpqXF2+P95Cw1xAB5OEHQqBAk1KudncMZd?=
 =?us-ascii?Q?h579ZrCstwLJTCtPnXuTLhf4vmI9fkjOHil5uc98IWbANDrm3jF4qkLuG++S?=
 =?us-ascii?Q?JVCe8gK2mZBDUUsMOP9e/cmAfCkpOuN+LsRWLHCmkj920PzP4PH4s08i/pUu?=
 =?us-ascii?Q?svPuLNsysRB0K5OR+Tp80KUDGmi0JOI8jlxN0+xulCfGYCvVin32+/eGSBN1?=
 =?us-ascii?Q?/Kg0Ldm79Gq2X0CQcfbmRuKJV+QNniN11bi3KopVMHkx2ldrr+DbSUwiYbS2?=
 =?us-ascii?Q?ID4xu/JeB3CXmd0Yu6jNNX3L9xgw4rLJnRHzW0QhdKLqbPwPx7KwiHcfjX2E?=
 =?us-ascii?Q?zrQ6DV0h9yeFLq4q6qEfM9yCB65pWoPgJ3lfIvzU+Q/4RU7Pdogprei4KQvP?=
 =?us-ascii?Q?4iZ6RsQeLb5nRK+B6mOvtDkCTAQFezLKLgp3xbyzhlYbkW6kw1HZeOTpc6IO?=
 =?us-ascii?Q?cphEgS084GbXbya1qkAouXxrYNqaC8rlV637YjKCXcjGIKUB+f+Bb3n9v1yV?=
 =?us-ascii?Q?x7tLnoPpI7dXE+jb5R9dyfNtJSf/rWXqi5P8TvY3QjyxCqd+v3YI9rf00HTI?=
 =?us-ascii?Q?NPxNJmFkPC1BxbpzSjTJW1qZHPAmNAONogvz2gHEr/D2TLeXfUvg4YC2WTcJ?=
 =?us-ascii?Q?BazyVQs7SI8/BQJpEJors8dqyK93EJpUrmOtn+1Yp+AbJN7ouu3KaH9u+6pD?=
 =?us-ascii?Q?cWhi4W+qdf3Q6KVZ59epzlKVHLGSEIBUaSXOVeJbTzAgHioRcqEYv49EsKN8?=
 =?us-ascii?Q?VdVSdu/WHPz43SUqOLK2466abGph7h0nK2NhVUF3OiII6LHajnX6u2sAuh4O?=
 =?us-ascii?Q?DU7PW5GdRb9d3BEdzGiZ1bBw48IKIPXgILT/Qg2L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db5cd69-2249-4691-71d2-08dd4605d756
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 16:55:06.1214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qR7cBPa4wDX2ds0+VmULCXlyXqwmZ14adfxZg39U228rgD6MjJ5tNuyCYvI/0Eff8/dX9efpS9h8Iiuc3v7wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11166

On Wed, Feb 05, 2025 at 10:14:55AM +0100, Stefan Wahren wrote:
> Not all log messages have a newline at the end. So fix it.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index f989b6c9c0a9..760c9e3e374c 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -164,7 +164,7 @@ static bool fsl_edma_srcid_in_use(struct fsl_edma_engine *fsl_edma, u32 srcid)
>  		fsl_chan = &fsl_edma->chans[i];
>
>  		if (fsl_chan->srcid && srcid == fsl_chan->srcid) {
> -			dev_err(&fsl_chan->pdev->dev, "The srcid is in use, can't use!");
> +			dev_err(&fsl_chan->pdev->dev, "The srcid is in use, can't use!\n");
>  			return true;
>  		}
>  	}
> @@ -822,7 +822,7 @@ static int fsl_edma_suspend_late(struct device *dev)
>  		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
>  		/* Make sure chan is idle or will force disable. */
>  		if (unlikely(fsl_chan->status == DMA_IN_PROGRESS)) {
> -			dev_warn(dev, "WARN: There is non-idle channel.");
> +			dev_warn(dev, "WARN: There is non-idle channel.\n");
>  			fsl_edma_disable_request(fsl_chan);
>  			fsl_edma_chan_mux(fsl_chan, 0, false);
>  		}
> --
> 2.34.1
>

