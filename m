Return-Path: <dmaengine+bounces-3709-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E429C426A
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2024 17:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA3BB23CF7
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2024 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A03189BBB;
	Mon, 11 Nov 2024 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JKRF7Suq"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6136E4C66;
	Mon, 11 Nov 2024 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341608; cv=fail; b=brngaWRslB3Ls9OW5pSzMem39T4bq2bn8VUiHQHEIN95MUott1HkgCChRRYQK7/pjCeQiISc6rgS4MBp+++sgKGZSwod1zGwWFh/4W8/kzijf0kMRmZFTXuPeCqg1EFuO+Io9ILRn0odEPDCiMzi0srdYopC61mofieK6H0ANB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341608; c=relaxed/simple;
	bh=P/+KEjQL979YpesVeDfxd24RbWOwdGHyTIu6Zf+ax6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m8x6DOsM9FTIAlyG1qWe86Xp8h5nnStTDVz/E87oIwRiCPMiuLre3vAY5tTVmJHrQ6GUvv1nEjGnJ7/7HA/cHl4witIXhMvPleKKqg4ewBn8Ls7fw9qR6++Uc3HV5le48kwqhazvpMClaEvxcIQmHZj1MYRwhFiD9qB5v8Y7MgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JKRF7Suq; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ck7+2n9aWSedU+vSKKi/dzb2eK+huek54PlsZKv83g9GGWwQK/XQbvgPR3zSI+FzSd9uqTTocftu2skpVYe42j62VLJeN9TtPYXLhyKX9A3DSx1hYWK/I4uq1FE9A6aOQW/yaB/dPsJ4C12pL6lGDTiRfnDjaFMXW4VJ5aL+EtdWnzKC6Qzw7sGyj1dPy6zQmCOAi27+oQXMNyso65QVFUNmFjQve0nouougQn2wak4/Q6+wNEn6+LUFI/JAxTUZl2Y6sczKxC4r3eOVwikmc2p/6F31mo9lKCT9bclaSELheknQhNQNO/viimcMVWhRIuWhd95wzPn3rlcR34JGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1d+ei6dvoZEpzvMEKtovENAd+12utvU7l7D/QAIte4=;
 b=VhQ46adlbI14UPicBM83F/bsxSpsKFjc/HP9gQcPoKJEa9w5jCcdWaXlDgA+KlxjcbedQLGIZYjlq8EyXwJVqIazro6aMyeGu7J6FEw783/hQ7w8JsYKZoKuqqBruDgp+3ydITF50vQsl1uI5iCWYw/OOvUqAqUlPsX1slmqnw70tXxLo1TCUfwW0aRw9J1N3J28c4EVtiFbmqmgLuRWDcyJSy4xHFg2S3yN5Gmjh5wdbwfh+dfWF7nXPlZrDrY39U1nnKUv8X8YRku956FuMs3+Af6fWwVkv7F7qeqVNJ4KufJe6M0Y6kIvoxRpXsABg00N1oCzOAfX/hcBqxL3GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1d+ei6dvoZEpzvMEKtovENAd+12utvU7l7D/QAIte4=;
 b=JKRF7SuqG98Ta0HRRrKKsAfBxtrjgM9WMxTpP2UU4w5xn/v5JhdeEEBVPSfcvTs9R5KHPzKEI9Frdh/2sQFKxCyz8XT2gMCtYrfJ3fx6LXCflKuNdCgCtCpoTa0vEwbgTFziK7tevVIkh7JtYaBx+frkv34MzmOmU14UtDrw6SpyQGPmMvOR1cBsGhgr+wtH8l+PYlQ2bDtai1r5Z+LqStcAsjVkmnuZLCusw0znpLtowazneIYR7ipUZrNxZX6exCT5znomVsAoZXUT5EWt0W8OftPn+EBK/XJ40fPM5OlVWcF13/eAuJoahxh2hs0T/E5R4GKw1NSrGhSJ8FUA4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GVXPR04MB10873.eurprd04.prod.outlook.com (2603:10a6:150:224::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 16:13:21 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 16:13:21 +0000
Date: Mon, 11 Nov 2024 11:13:14 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE eDMA DRIVER" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 1/2] dmaengine: fsl-edma: cleanup chan after
 dma_async_device_unregister
Message-ID: <ZzItGgiRW5abcsYq@lizhi-Precision-Tower-5810>
References: <20241111072602.1179457-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111072602.1179457-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: BYAPR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:a03:100::20) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GVXPR04MB10873:EE_
X-MS-Office365-Filtering-Correlation-Id: d728e973-94b9-47ed-0fee-08dd026bc2ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6I+eEovN796izhI+gLECk7IDmIaH3IRfLJl5n11dU5DN+wBtTPz0C/ZyXqpU?=
 =?us-ascii?Q?hU11mDC7jTDMQ+UqakljkfD+McGGfDALJOi/G/oj5hj9RhJVw7PY/oL9w7tl?=
 =?us-ascii?Q?nHi9JcxfZbUmQCiKNyOutxlvY5cK20A2X10UQ0Z2OeWi5LFZjzYuukL8YbzA?=
 =?us-ascii?Q?MY0DIHkdCFq21+19VcllAtz4KfXP9dA6cSK2ZdElK5LX86+CVv/y5Cn3b4FQ?=
 =?us-ascii?Q?owqxcHT3+y4FsKRPU+wCkE3PzwZ2cVSG45qz9PQxK3oZjoEBvoTaKUSNrulo?=
 =?us-ascii?Q?9dC5XV3rtzzgK9ECEl3PQZd2rj5Lt0ckYG+gAk+jzse0EZMgfj/wHuOwKYcw?=
 =?us-ascii?Q?QCdvWQPM2jNprm+KXxCSacsnJugMBcz+yAfjSgzuaZLV8y/bI9i3V4ay2HBP?=
 =?us-ascii?Q?gN3e63sy0j+SXPRuM4G6cM9DgP9Funjx4GqMqaLA6ASxBPHJdQZa/fPby1Cv?=
 =?us-ascii?Q?Gk+ukuCsKt+m3IPYWpgX1BboIgAoY0pWYBVBcsobaHcXSZyEbE2JxS4R6irj?=
 =?us-ascii?Q?mgVV/cqbfl1RKv/D1QGA9pHjEXapM7LjkWUmmXJBlKNIiA/5GL7ejjfIT9Nr?=
 =?us-ascii?Q?B2pfptHM8/MJwXuqQ0do7l8e+WbwtRm8Pom/czYpQQaa7MmeyCuCjyJsnmQQ?=
 =?us-ascii?Q?MZe3F7RU0rWchVacH/rM4H4Cyi/IpRID0AgUsv9Hc7DWdQeLMaZ7DM86/C/4?=
 =?us-ascii?Q?w+b77G0IHsmT36DbrxXo6aqwG3WQ0IdmY2RWdq6WMDFWxTjUzMDMtcQ4mSH7?=
 =?us-ascii?Q?v1/ZlatC43k4KYFP95OHaqmwjqSk0sbud++9wFH2GhzAt68RvITYLK+W8Xu0?=
 =?us-ascii?Q?/jHnknBztxr2JLdu3cPIODFfxHQJhI/UmSZqG2af0nPUYpLN4gBPY+zNEUKF?=
 =?us-ascii?Q?jBE7Fsb3m/gUis0xNaeVRCM1mZU5HJErwDDwIXBzc99dSaYCE3zBJ1NVZfXc?=
 =?us-ascii?Q?PrpAkVRc4gR2Vd8bIjdPWa98tbpEhb9tirygi57uF1f2HmM7Me4i74jXhr81?=
 =?us-ascii?Q?m8A49fL9vwCZRukiPkrpQo1SVZp72Bk32X5WTqURLNblEEWpA2H9XQCbvx3o?=
 =?us-ascii?Q?OhxXXSUiI6Xpcc61+im5oJjm83Ak8v4qCeeIBEiEXCYi5ivOIXOUOT5qTl+3?=
 =?us-ascii?Q?ACe5hDkgDahM3mWWUCdtbGEBvkR1oCKCjfpHBAuKHQYr975PYXe8j7C0MTTg?=
 =?us-ascii?Q?phsw8vbfFEzBTyIbDa+GfuAe51A5Jub/TRZAaP4l94C9uZo3k5JOaV36nSyG?=
 =?us-ascii?Q?cKaEEWj1AdQKaIJhFAO1gbdY/WkquT2ujtzpSA664hZ5Otc2E5nnfM/yZlUO?=
 =?us-ascii?Q?rtzPOf39q5eBFOmJoQ5Ef/QRYWKR8C5fBWV7k+GApBphFgYI71zpgqMxPPq5?=
 =?us-ascii?Q?IDs5P0s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vlt0paywU3IVXfpZn4lRkHAIY+lpjshDpvj+rQiTIYmDoE6Fct9xzVIF+jMg?=
 =?us-ascii?Q?CoQAcvnh60A+/rsYZFc4Zqt0Fe+AsvqfAz5lhj2Kh2B96fKaZalS9Tu2xq0/?=
 =?us-ascii?Q?m8rHN9mL1KQleQj5Llpxp0Z0ddpkKCvLDm9pYCXF0qsi7kQzutckYo5LwsTi?=
 =?us-ascii?Q?75rAdTQYsGG5i5ePErM17ZoEMxZFP3sBZykkwine/1Fogu9A52JY3kAEYrW8?=
 =?us-ascii?Q?oVyNHPcx52ye08JxEJ/wvy8kZUzxGgHdhYHjgI7vilNQe5kGSXO1AeZL8BMJ?=
 =?us-ascii?Q?jAVa7f9wIBHP+5ctMtB5TbIuMPckGR3Ml/1PbQV/y1cTG1T2TA6KDBMuG0fk?=
 =?us-ascii?Q?RndGF2TXnb7u3x8B/MUbcL1aK2k6JE/xWclxWyijc4tsM4p/OtpC3D3DeSIf?=
 =?us-ascii?Q?8N5aPd0awG2d689/A2Eow9T7oAPG30bUDbtpB9znNZkbP1NQZHmOlzDDGN2Y?=
 =?us-ascii?Q?zHz/a0tQTqaYqDkl43UMDhef81MtLxDQgocuID3wUj4H534kamvhf63L97Oh?=
 =?us-ascii?Q?tVBqCeAxN9vJG4QbF3R2sGI2OA+eCYbsFWmmi2b8o+3M7Rtv/jkFUC3nBxAp?=
 =?us-ascii?Q?Zuvgg40QQ33pIiMqfYZDdNfSFCfeIyamUECgFwNkMRYkE3QgoL7YZyNmtsu4?=
 =?us-ascii?Q?uj+otLQAZkJXvdvGgytjumSJKDssbzyK6i6sHTNHr9J74U7S4OZSzSzW4SVU?=
 =?us-ascii?Q?sb8R/HjRHEqQQ6DMbbD/3mQr+M0k2iWIIQW0zBDM1i5Q9nxxYmbt7yR3k8Xi?=
 =?us-ascii?Q?jlcNRL1MD9nlwgifLL1zPUcnJYojWdDsOAwO0EFEy/aEAWkvL+uZx+LWqvjX?=
 =?us-ascii?Q?PCXrs77fgya1RavaUzyHr47hG68Mn8mNnxj/VYBuqF1zoCJ0oAUbmtMPYYi+?=
 =?us-ascii?Q?Mo2efm1g2P5oE1I2t2DFXujOulzpWAr4fK3T5GRpglahDjfIeHnzrJ4Rrepm?=
 =?us-ascii?Q?SwZXZvyuns9Xro1V+tt2G0ViNpJxJoSYIrY8drgrNg0R81F01xbd0SEYeurw?=
 =?us-ascii?Q?qVT8uOSe0IDQ8TeBxucRotNvpzeLLzoE274dhp112UrB/lBOGgSQP1lJQjY1?=
 =?us-ascii?Q?zPQfxMNUz0fJMmtMWC7oRQVvUgShJU7QIYpi3Qr5cJBc+UaoxjzbjOTrKBQV?=
 =?us-ascii?Q?CTy/rT/ESkej+FBncXVI0vU+Jx4ksJye6GnVd+VNwTFmJKSO4BSpYPjkqmyt?=
 =?us-ascii?Q?dPQmVe4WOjDcZ1XcD7VhAe/blU+wYE4al69QCG4FF/pt8wlABJiyhlJndsI2?=
 =?us-ascii?Q?NuwrL58sQb2ddm3IMWR1I3cuzsnhcNbjeV4dgfWWG2ut+KbhRKwxvH22aYn+?=
 =?us-ascii?Q?/fy6Dlk56GWwdEbAEFneanBHJwZPATbA7jpgJUJbnUBnY2sBWhBHQHiQwZ+b?=
 =?us-ascii?Q?BklgssAFYTfRIjtU7Hy7wUHoAMBUzpML9jPmdD6du9BvoRwQaj+uCqvjWOHS?=
 =?us-ascii?Q?lkffNcXJJtqoTxFALmMDBs7761hTDr4ImztHDMFSspMR7gnUO9VFYnReLcUP?=
 =?us-ascii?Q?u5Zp8H+4C/Tbwkno3hAIzyDRzfCIav9ld36B7BBzBP7cd5IZUF5qiY5iqbcj?=
 =?us-ascii?Q?J3iOw4FLuS64BrZV6TEIT5lFdZ0pIrGPpCtBJ8XM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d728e973-94b9-47ed-0fee-08dd026bc2ca
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 16:13:21.2799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHkwkUVN5YuwZDZWtebuGSTrgG3j0K8SrXP81+4J0tAm5TRPD5kKkIc7gIksAGWmgUNyIWXiqx6tgRz7ZxvYiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10873

On Mon, Nov 11, 2024 at 03:26:00PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> There is kernel dump when do module test:
> sysfs: cannot create duplicate filename
> /devices/platform/soc@0/44000000.bus/44000000.dma-controller/dma/dma0chan0
>  __dma_async_device_channel_register+0x128/0x19c
>  dma_async_device_register+0x150/0x454
>  fsl_edma_probe+0x6cc/0x8a0
>  platform_probe+0x68/0xc8
>
> fsl_edma_cleanup_vchan will unlink vchan.chan.device_node, while
> dma_async_device_unregister  needs the link to do
> __dma_async_device_channel_unregister. So need move fsl_edma_cleanup_vchan
> after dma_async_device_unregister to make sure channel could be freed.
>
> So clean up chan after dma_async_device_unregister to address this.

nik
  So move clean up ..

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Fixes: 6f93b93b2a1b ("dmaengine: fsl-edma: kill the tasklets upon exit")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
> V2:
>  Update commit log
>
>  drivers/dma/fsl-edma-main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index f9f1eda79254..01bd5cb24a49 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -668,9 +668,9 @@ static void fsl_edma_remove(struct platform_device *pdev)
>  	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
>
>  	fsl_edma_irq_exit(pdev, fsl_edma);
> -	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
>  	of_dma_controller_free(np);
>  	dma_async_device_unregister(&fsl_edma->dma_dev);
> +	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
>  	fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
>  }
>
> --
> 2.37.1
>

