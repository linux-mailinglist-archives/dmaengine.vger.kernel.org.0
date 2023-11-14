Return-Path: <dmaengine+bounces-110-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09707EB328
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 16:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB3928115E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B3441227;
	Tue, 14 Nov 2023 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="beXjEUf5"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D64122A
	for <dmaengine@vger.kernel.org>; Tue, 14 Nov 2023 15:11:59 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C5D100;
	Tue, 14 Nov 2023 07:11:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qkb6X/5Nhm9vP1xy/R8jvU7XFTrwwoT79jJRIwJrM0R0OWTujsm8D5u0bqHzy0xLIwFMJOqCU0hbgfodhkzgvpmd5DilLNh2I6thLu6mGyEZvhfZ9o+r302M5CRBnN0rsYYyg3vOhTqecCh2r7N1aoOS7PSbb1eQfZ1oqOAOY7zzJbC9JFaAsY7jiytu5o7Qw5flP139l7HmT1hy8Fv0Pal0XAtT7T8xYE+YxefW3x82cFB1uVHAKS7fcvIgjNOla4GTK4umts0iymPxolHflQFTI+TuOwQ2L14RBXQyVW8HfeykGj/eo27UKiU+BQNjhFYdMiYfzUM/2QjjpeH+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SAU5x7X14RGLZmCU1oRp7TgvU4QRnu3vrTZva+yBoA=;
 b=LQIIf30/tDTkKCCQY8PBuudLllbkExLAD8kergo95nT3QoeGT2GL1t0Bdtw6oCg9s3HueD2pU2QVPfh9z5Yri6AGLWbZgi3F8x2vv7IBKkxF6ChCdLQg+OQuEoc4QxUzzTbmGWo121FaLoSvYsHzwfOEucES7JMhENuKAr9zvsKLnI8EZTKm3kWlrXtN5VbB70opes31KCSOX1C3w919rxDexTIHHpsVjzsEYW+hBv4lZgNgvzMxujOhRfEGS2+BdL0/6ed7YHc4125NYYXP//QVFS3LGOhtdg8mVUr8sM6ifjECkogfUKUM43D7soZidHVN1Ftscc1hA6KmMiLaSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SAU5x7X14RGLZmCU1oRp7TgvU4QRnu3vrTZva+yBoA=;
 b=beXjEUf57K1o7Qu31Vqjr95jDx8pwA3+3Cvkz9+F6/5Aj4z+VDt2yw8BAzavnrFoKu+mnlt6lsbrWccif4hxXRoE/p7cB3IQM+Hn46IP4M+q9dznJ1ZvtPdMBHcroE0sGvd23Vy+bxkGRpNacjIWn6Wjq8MoDWpSj+xM9+ZYTzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7493.eurprd04.prod.outlook.com (2603:10a6:20b:293::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 15:11:56 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494%4]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 15:11:56 +0000
Date: Tue, 14 Nov 2023 10:11:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: fsl-edma: Add judgment on enabling
 round robin arbitration
Message-ID: <ZVOONj4Ham/Ez1Dm@lizhi-Precision-Tower-5810>
References: <20231113225713.1892643-1-xiaolei.wang@windriver.com>
 <20231113225713.1892643-3-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113225713.1892643-3-xiaolei.wang@windriver.com>
X-ClientProxiedBy: BY3PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:217::17) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d3bbab-35a8-4ba4-4c31-08dbe5240a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8nlTmMoEZy+I0a7WdjzdTtk1iFFTk1O553sbdzuTMcVXdH7qgbe8H0vSP5RAncjRvVy+Ak3L/UhLGfDihk+xH1Q5UE0oCt7mT1nkftfHnv0s/rZ0Cly5BzE/J2KEybbG2hy4zOO3+OURUV3h0myYzITF3jsAutnb1PlmPaS4k52GXzi7PogX5J/IPuHCYU8tW5pOHTx2P8JtDDCoT8/0bBJNT4Ww/b0bvfPtoaT2+2gLs+tImnYh8ARTcInuc1qfUaNSABcfQ9XaDjtCcGhCi53a00qgHvGhpoZf3uuA+rFiteVF4ROlWD7UztSFawG1e27uVuTVwRw+SCTTVs/IVPyMYiymV1/Ceijs+RySWVze8R+LEF0nbKJgGMjsKvSM2mw2lsPhsG0FlW7h0dc588inl8Vb8WwJDMZnhcNZvaLmO6nwo9yvGvcn1rs81I0Amans+fC92KcXF1+1oiLOtpbj1Y+Gvk2vrdrQ4COWmXspsdD9Vf9Om92hrDiTeHz4E5cPGUUzmjWbrvl98D5tnfsPR1lLphcG1WtbA58m2Z52IpkaWi6eYVCKcsaraPLQcttF9Ow7QfunE98rjtFX1JEibY2VAyPIsj1EJYqh/Rl648CaXciAqSc0TyXhf7KZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6512007)(6666004)(6486002)(478600001)(9686003)(52116002)(6506007)(38100700002)(86362001)(33716001)(66476007)(6916009)(66946007)(2906002)(66556008)(41300700001)(83380400001)(26005)(5660300002)(38350700005)(4326008)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZU5A2Lk6gtm2/Cd+xj05CVa88zle3arJc54oF7OfwIWJYpv1v/1HlSWgypql?=
 =?us-ascii?Q?4FxSsNtU/UhTxN302qTAIGXB/wqhQ0Df5JKA/nYWeyFU31o2kxlvJxEHHijx?=
 =?us-ascii?Q?J+HGyUPIvwwc6sdZ7uG+wUW67TIWC1Sy9ZqZqQZWmKs2yP4g9E4OkP/n/4c3?=
 =?us-ascii?Q?7qV5w6rLFJJo1wO/6jbBBvN7F9J2R8YqCnIi0l9GpLL1Qz2/R2fD6YinmmE/?=
 =?us-ascii?Q?TBB70euuP4p4HQ6Nxx821ORl1O5RCJJLDiScyjdVGrFwzfBTYOoH8yoz/YC5?=
 =?us-ascii?Q?0QkRHPgpewFKGm2tBVqAlWf3Dli1ToUjoK8IUk2wCAS7p5Io6TBbW8D9ozNr?=
 =?us-ascii?Q?IxTMSCS2x+ss1vLS7gxPPJ/YbiO8K8YjaCJb5asKmGf2P96Fw77vUOn8T2H3?=
 =?us-ascii?Q?HQR19dChrKz8+NZxCLXi5ldDy8MVaErq/VTc3dmqph0wlX/S6FFxT5aImB8x?=
 =?us-ascii?Q?nsSaWyPIb0rh4le7MFHIHTP9ulLi6MEbXLDzMfDQ9K+xO/Pg0mYq+JzFG+xp?=
 =?us-ascii?Q?iSkoVS99fTU3OUpW1XZHmi29tGoV3sD0oZnNsJodeb+PNV41raidhm2DYxEz?=
 =?us-ascii?Q?ObrdtOPJyjHZO8GYb9iAzDRzFeTyuFlmICKqEI93aCjx8VHLFpSgRas5/7a9?=
 =?us-ascii?Q?Bnrx30yUk1lIW7cQGrp8Dpf7NjtzwVeFBkgmr31RZfFU2cTqpofCtrVBFb3n?=
 =?us-ascii?Q?AjnogQbX/2wEQDG9KF0NQZiYUNHdmbHeZ+vx+O+I5OUsuahlrCFjwQ++fc7b?=
 =?us-ascii?Q?XKFQUq+OgGZ4pxL5DGtqXd39eS/gTztnqXBdSQUpRaot6oDy7FfdMkatEBLr?=
 =?us-ascii?Q?6YNlwuoZYutpBamVZJWfM4ZCju4xp9+Lqq6qCZ6RJhUQjxyKJc0Vu7OFV6DK?=
 =?us-ascii?Q?qcmUwsmoNSC2hrr9ujQyZ/+D9jdt8BjT6H9IHLuzJoar1wMRGcL7xvNjQ0fJ?=
 =?us-ascii?Q?uh37SR9R8BJAXtzgKsg6PoIITCN0nz12x0IFsmgBD51sjet6erth1j2X+WDL?=
 =?us-ascii?Q?oJ4TIoz5Ky+KjMNrFBPYb0ylKx3UIg0o/FQO/9/LAPTd0/nEDQxSQYRRkDl3?=
 =?us-ascii?Q?3Q3LSABNggy6k98EV80jG8OTSsmNb5mq++mCsufAAkSvIkak4Gd5jl1t0vbJ?=
 =?us-ascii?Q?fb5PeUh88EwfPlMKtbrTE44ZIJZhczBAU29HS5JLkLsMufIiZSP1Z1TThSyM?=
 =?us-ascii?Q?E9UvM65e7GYjQODiE67oamNOT4H6kiu7afkRcediWtIhBeHcNP4R9FcyFipR?=
 =?us-ascii?Q?uFtWDkDzwrYfk19A/ArS5kdSybJuPVaSJsi5EqPA5W54O9jZYxY6JZUboN4w?=
 =?us-ascii?Q?Cp7EvgJ2KqL5+6zC9mTmXWvRwZcEfn/M46XLOKvhYwSSRY/E0H1OAH3N//Pv?=
 =?us-ascii?Q?HfXC0mcfsmC2iHXBPGpcX7gVLx2B6bzvuEfVo7w1Ap3XqbRBTrRgKnYLL+0d?=
 =?us-ascii?Q?vh4KTbu2bDA0949FidkZCL+fwAtVWoeRvbVl6GrCOZIekZVlQXWjmWcGl6O9?=
 =?us-ascii?Q?t7cOk+ou55WHmax1Zz6Qs9BVT9m8mIATWMf1pNklodbLAbQqDmhCuSmEclJz?=
 =?us-ascii?Q?wCbqFQSKOmKFCkRZmSdrsJkfgCRBge4mLORg5+9K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d3bbab-35a8-4ba4-4c31-08dbe5240a86
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 15:11:56.2336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +C/hqyJFYYtSCCnE5ateSfZFa+lL9MrT4HAhnestf0zGaDB5FPE1HzTg9adJ22iZp2Y7uBuV0OT5dxasl7nSDQ==
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

