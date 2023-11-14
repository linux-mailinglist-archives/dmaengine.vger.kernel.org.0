Return-Path: <dmaengine+bounces-109-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F04767EB31E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 16:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0F41C208C1
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 15:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A1F41228;
	Tue, 14 Nov 2023 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C8hjEUDO"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6C241227
	for <dmaengine@vger.kernel.org>; Tue, 14 Nov 2023 15:09:59 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2048.outbound.protection.outlook.com [40.107.7.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4608199C;
	Tue, 14 Nov 2023 07:09:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfS/SVUVMRyNDICrDBsS6nlGoQg3cyaY1a9PuAQhzqlpgOq48c9CssuuR2sk5zeGikxBl2DbMhmcAlzp1fNmKlxwuYR7xGs/zsmKKC7WAfZM3a+YY6G2jx3sbXGijG0ICeVkmRGkU6oEeeVUPljU1cPZOD7eweAG8xk2k+vMG7cj5DVLpnRlVyxzEjaZdSNjCTgbQnrrSHGfXMbMuEHOOqZMWZOMozhxvjsWgou7u6xY51+47/GgE2QWq7vie9GbHEAlnrYHONS03vbARtKSiAUXklsJtuClVJ+nWOwClBucHW7H7DxAOvnVQ+wwVoFrTS11/stZWGM1qqbhArbqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SAU5x7X14RGLZmCU1oRp7TgvU4QRnu3vrTZva+yBoA=;
 b=ob3ftlcK4CAnJxmFgXaGPBvsOmZqvejUTFNkdWgiKZy09jKn0hn6BU86x/rMu2V5Bu5ysQKApzzH/eAbhU4Qb45rP8uXO6i0EFyObe/1q6VEwT0xwLFjy49C99+09IvkMCPjYoAEpg/ZLC9IlQzt61c9FzqH9VlNMcpy+GGhxzOrYwTZLOwrJih+b5N57psHunKYnqGREOwrrrclTyMkBuCBURcyqOSsBWuOffcuCsdLL/Yv5tom4FrtMMN+d0SoNDwIDgZZ+qklvI6+fQ1Hm2nHTapqjsBMMk0IlRhEkA53iYuvFTY/sor7pq3kGfL8jKXkkQcTdHyEdHXTyiBw0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SAU5x7X14RGLZmCU1oRp7TgvU4QRnu3vrTZva+yBoA=;
 b=C8hjEUDO/54pNbuGYPisvQ+C2ZLmIwRHUf2XSWNu2Le3iAsqczscaLbVeulyUfcmGYzXOL4fe38DLSL0quACr1MHA7i20x8rbWrPH5B32bY9Aha3B5E9R1pVxxU1xHswCQQrRIMnouTpVUghJ2QLXaz3S/6lwOVtl5T9h2iU1K4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7493.eurprd04.prod.outlook.com (2603:10a6:20b:293::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 15:09:51 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494%4]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 15:09:51 +0000
Date: Tue, 14 Nov 2023 10:09:42 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: fsl-edma: Add judgment on enabling
 round robin arbitration
Message-ID: <ZVONtnCSK2owAhbd@lizhi-Precision-Tower-5810>
References: <20231113225713.1892643-1-xiaolei.wang@windriver.com>
 <20231113225713.1892643-3-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113225713.1892643-3-xiaolei.wang@windriver.com>
X-ClientProxiedBy: BYAPR07CA0056.namprd07.prod.outlook.com
 (2603:10b6:a03:60::33) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: f283bcac-74a8-4ce9-d41c-08dbe523bfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D1vnrpJ24PtbrE8nalyyB42LR6nbpBh24Ddk554vJYlIv2dCu4M5ityeWuAACIEgS0usgkdBDY2AdOsAGz1L7Cd4Pkx591vp26NEDY25xNYlu9pJmW8zDAhRFxYfmNf18v8AknRjGHCMXamliTX872I/a6KyiKAEyWAnsSu3Ykn5fhOHZH7gec3yJeZM5LTRmDb0aCgfsLu66WlfclTUab9HFwK9Nfj5wjrLLUGztbezNqftZCWC9PWyusZQ//2loOsE0fR1p/hGRv3/ni9BvUGaseGwy3q4EBxXhrr1owAq8MZulz7yCHIuSF8Ua37DNLEyVRH7KlmCdZgAJjwEUwGFCburmoQ+JyPApNxQuIALBlxetkGCUu2V3aG/QEyE/TEBkXnxbIkF/rHCemCQdsIVBOB3/EGpQ6DV7N5fl7gKpHHo5/RIAN+9pFkV6uQWsJPAhrizRgJtfHSAwQhvh+69irMDEjErB5nLRDaHC2tsMXioPm8QvEl+3sbEELS37uqyj7u8iNid7N+YyFHzXlXor1Uh+QJ72x+Gx6WFRvr3eLJsTR0i3Wa4XajvEFD4dnScv7Wz2azYDR/hpEFfQ1rJPOxxLmYiKr7CDuSaS7RFh/gwHUmJLRoSvhbnimNw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6512007)(6666004)(6486002)(478600001)(9686003)(52116002)(6506007)(38100700002)(86362001)(33716001)(66476007)(6916009)(66946007)(2906002)(66556008)(41300700001)(83380400001)(26005)(5660300002)(38350700005)(4326008)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aQzqgfaU6eH+UhbX4eLXvkXbI2Aoc6CFUHnyzpEwY3NKPl3t+R6e+vM2+ku5?=
 =?us-ascii?Q?h7K2NhCkhRfmPjKj0WVMlQ+METyMdnOdJmfC62V656kfugRz6/iZqqN2MBby?=
 =?us-ascii?Q?cClWL40ODba0pzJyCLsdMZoCrgAHLBINyk7RBZYQtW9BI0iM2s/Hvg8udeVL?=
 =?us-ascii?Q?qr2Y/DXMD3KEQoN84SEs41U3XulxEZru3XRZ/QrYXcMqPf00cnbl4VFukrTp?=
 =?us-ascii?Q?mFb1g6B9El6UP9i6xf4edKcKAP/EIU44EljM7g8wMo255miYlwCu8YHyyOt1?=
 =?us-ascii?Q?XF20GD/CsJyVHVlbSiUEqB6166ZVG+44uYb9PZPCcRZg1hDVyzXMdaEkt3vY?=
 =?us-ascii?Q?hlZ/oqL6eZTgwjm88lJMLNzsRbFBE8MkAYq+Zf9aMalEVgSBUJncJu6lAn5P?=
 =?us-ascii?Q?CVkHEiiHtzlUzNVmBDTkmHM2dBn8DLL3qQ6Rbs89RcrePhub/3r+TLgmjtPx?=
 =?us-ascii?Q?SSSphPq0Lg4kRxXNvQBEut0hoXjKGN3yiHGw7/tIUShn1UvO88lyEMeHJanG?=
 =?us-ascii?Q?RGH0BuRolM3Vg9kdzf0tMxKC6Ke6tOmGgAh2jNvgU5HjH9FVJoUYhmI6zyLX?=
 =?us-ascii?Q?G2W+LLpO64i01d4Pmn8Z4KpxOA05wkScwr/HWp2NlPSVnlMnWpskDvOUqbjO?=
 =?us-ascii?Q?A7RT5wREDHWau0jeabdce2jVpozec1WjXm+Q0+3ll7wpkdSouck5/p+Fudw3?=
 =?us-ascii?Q?DeGRvcwQ5+e//slbF/7bKETEVp7F4mlnpSchVIVz9CLLrh0iEfNUF/OtIA40?=
 =?us-ascii?Q?e76iZ45HUJfKbKWVuu6TIfzVTv0ZjShL92uxohtQgo+AWs/kWJYNfHFjYzFp?=
 =?us-ascii?Q?wnwFCVCKUyp/pNcqiugOBaa4ILqWY4LWY+5ViDjsUsoyLm3z40PZBwGVvhmc?=
 =?us-ascii?Q?M/sUneen7dVFwzDTNKNLG38KZsP2zzDoO6tkVNE2Fwa0QHsvXQcUWSzncUQl?=
 =?us-ascii?Q?4XbHlPtNCZPT4hw0gycwVYK0YcACqOksMYIZmig1hmvPG7Os0DdvsYtZ2Rup?=
 =?us-ascii?Q?MJXddIytTPJr9zs9GmcJhyRNUqUUI1nMeWytqBOdQZGS4EI1lvx4oyCFzfbT?=
 =?us-ascii?Q?Aj9WYMnvxB/4G57JuSYLa8oWE8hbjIwboxL1yDQBg+5rf4i4IBPlrYzhrQ06?=
 =?us-ascii?Q?CcMKJ8MYXROwDTwHxlAY/BRmENM1Uthxknp1qZ+YTaDB6TjoL6/1xb7A9Xry?=
 =?us-ascii?Q?MWvGYwqzAB62f6UTe77lrnt3O8/bxNS4sfwIG635ZIO15qrKfRB/A4ZfGqkl?=
 =?us-ascii?Q?JgF0U/Lr7VbmRKQCCmfOx9wRjdBodGc9V6jo6x4JdtPU0RCXDjWHQt3+xDiQ?=
 =?us-ascii?Q?OboiKlBoPQgPF57aR/UunLxb8lV8jmbvfmdd7Yvqdr4jFkL/H6a0tS4OnocU?=
 =?us-ascii?Q?bNtUQnu1bAoGX9DPFmnFlZZwRThP7nmm2l8hLoUJR3BqJoz0sUuvj/sW9tLl?=
 =?us-ascii?Q?ejS+0fin3qCQOreoj+ruRec3tvlfRAlAcjWB49LxrQATCIm9PB4KEnRUu4wk?=
 =?us-ascii?Q?cy9l/1ULbyQ6O1SG6AXtgieMMMn1gQpGrSlM8r3am8LFEvbZSC9Wp0Z0MHq2?=
 =?us-ascii?Q?kUryKRQNefbGQzYo/fUzIqqYtkXnQo4NuYC6ys8a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f283bcac-74a8-4ce9-d41c-08dbe523bfd2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 15:09:51.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TC+LapF+kFn8v+OzItbGRSzC/LNy2UqTEJkLyuf2R26KoRaLscgh3A49Q9CPOJ5cWPDdIyVwPyM86IMQ0mnsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7493

On Tue, Nov 14, 2023 at 06:57:13AM +0800, Xiaolei Wang wrote:
> Add judgment on enabling round robin arbitration to avoid
> exceptions if this function is not supported.
> 
> Call trace:
>  fsl_edma_resume_early+0x1d4/0x208
>  dpm_run_callback+0xd4/0x304
>  device_resume_early+0xb0/0x208
>  dpm_resume_early+0x224/0x528
>  suspend_devices_and_enter+0x3e4/0xd00
>  pm_suspend+0x3c4/0x910
>  state_store+0x90/0x124
>  kobj_attr_store+0x48/0x64
>  sysfs_kf_write+0x84/0xb4
>  kernfs_fop_write_iter+0x19c/0x264
>  vfs_write+0x664/0x858
>  ksys_write+0xc8/0x180
>  __arm64_sys_write+0x44/0x58
>  invoke_syscall+0x5c/0x178
>  el0_svc_common.constprop.0+0x11c/0x14c
>  do_el0_svc+0x30/0x40
>  el0_svc+0x58/0xa8
>  el0t_64_sync_handler+0xc0/0xc4
>  el0t_64_sync+0x190/0x194
> 
> Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 52577fffc62b..aea7a703dda7 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -665,7 +665,8 @@ static int fsl_edma_resume_early(struct device *dev)
>  			fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
>  	}
>  
> -	edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
> +	if (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
> +		edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 

