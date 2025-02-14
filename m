Return-Path: <dmaengine+bounces-4464-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B8EA3551C
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 03:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8497E3ABCB3
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 02:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E75714F104;
	Fri, 14 Feb 2025 02:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="r1UEDWrT"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013004.outbound.protection.outlook.com [52.101.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200ED1474A9;
	Fri, 14 Feb 2025 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739501884; cv=fail; b=sUziXP/31TX+lEmCVIZlQMVfGsFVu4IXikuYexTyaAgTC3SjU/S4q9NFLB3X1pT8TK2hPyb8gCbQa0k2RZ2y3OXPagVxoOs5f40cWnZAU/oWlhds9fCfuEE6ZLIgipiZj64tpVrLNYhTNw1DzdopgXf0+sEvu6kBD5dCzDJwreg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739501884; c=relaxed/simple;
	bh=h0gRQFwK33aCU5OAzywhj/kHgXLZiOEMn9btk28OSJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bQaCvYWbLuwIrv10NaObEAOA7PlBdO6TpCudRkzsG8CCxwp2oogLajeI7ADl4zhY4OHchOdIu0boxP6as26zQexFb2fWHSO/akXbf3WoYarY9wJSn1UHZq58S2/9hE/W/hFVWerN9YeYF9UPtA6gXADFvREZ7cYgrbm7Qc5+Ypo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=r1UEDWrT; arc=fail smtp.client-ip=52.101.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJRjaDy3yjujVaNHjJeS8vPaRi5CO+JrL5zi27zIk13yT7sU829os5u7s7cg/xwPIOEQQEUcxV9EJVk5KnTNqq7Vv32smES9bUuvmu9YlGulb92csGBYHRmW4YwlwpfvSEs+wlFoF36B8rObz3yuwTUVxnSxSbPVU+n5VtDRP5Cfxi1GjQhzcgaToT2ykv6+47fX6UXsy54uT+7T+Jq4sYlzkGagn9JP3qf3nnjpRvzFAo5ukTpBangcYibsVcXqLeY39UayvFWgcGtXf0tF9O4wM6zc1f/bZtFKlcKkbPA9EyISvoHtNFd3CnyXTzd2jr1zEogD8Dbr0x25iglfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqAOlXogdJrRyWQfjcZh/7P/kRow8OUt3HJHZerEFjM=;
 b=Mbpq/fz+cpO/odMASf+cbVd4F07AA8xPLE1ukmX/ka+LhpG5U+1agOBfx4ZQIJ51zF2Hts5Qp/vTAy96N1eNC3LELcEgKL1mIZF997dcPaLD/Uevu1965UbGdEJ0p/x8YlRPDwQkmsNnoVlkgeMzz1hRD2mUxLIu0b8Hhmeh6lSdUD52PcyGIZod9dqF0/Mfn5UO92UQs0E67R/iCGpN3fLn6P59AyW7xWqZRuFwfuLrvifM+9xPvPXIQSR2RHCkKIEadZmR+ohubh2aCrIHOVDBsN1ccqN3kuGFBqAB7i6trxzo5IDXdBlOu+Gclt97kXsEbim16cRLlhc1/UCPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqAOlXogdJrRyWQfjcZh/7P/kRow8OUt3HJHZerEFjM=;
 b=r1UEDWrT6pdjepItSizG0udmWM+EoYE4AZ3k9iMI0myfaNNqZkEqalkv1WqipFAyGMLwUAouMlnQmNZd1wDHYtbY8W486y6mgPiSM/ACop7iwodo3cfQgE6uQxkCj4T7LKZ3aoH/43P9zPOk4FaS/RNBYGRoBMUFiw8GTBU9ev2hPL/jH/jWICPux+ZQ7Cn0IOxhejTZeeeKlCtCFw8gvdQwBzwEaJD1MTZQIFTls9X8raHQhkhIr6tH4uBUnGuMvqZv6uKemG/LbjtqSkM2nimSnxM3a5yxuGp1ZcEM0Th30vICHZdedwqFWLbchVAWEsvIdhKSlBoxPTXKgMZnag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11012.eurprd04.prod.outlook.com (2603:10a6:102:492::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 02:57:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 02:57:59 +0000
Date: Fri, 14 Feb 2025 12:04:57 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE eDMA DRIVER" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 1/2] dmaengine: fsl-edma: cleanup chan after
 dma_async_device_unregister
Message-ID: <20250214040457.GC20275@localhost.localdomain>
References: <20241206084817.3799312-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206084817.3799312-1-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB11012:EE_
X-MS-Office365-Filtering-Correlation-Id: 5645aece-d61b-4f4d-dac6-08dd4ca363b0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ui43foWn8pqURvO09Qw23Elnr+S/+YLZhO2jRKVtV9PjhhZcjgVUwHmNzmPx?=
 =?us-ascii?Q?6M1TIc8rDxLmJf97By6yx7oEcK5bHaVSoPtn2iVfoRMPQa3mp+j87qdJb4HU?=
 =?us-ascii?Q?qb/gaFF7LSXPesvW3VEzLhi7Muos+edLDv1K/U/Vuttqa6L1LPbPw1xswRLz?=
 =?us-ascii?Q?r0i7cQJKzR/y2BTw7puRNFjb9evPnH1jgF28frnxJnjzdmELpTNRWrr/FEBZ?=
 =?us-ascii?Q?L063IJJgA/RhvFAGCdNzurWGcGnGZ64k7waQUb9C5GmzmtX7mQqGIM6K9gTC?=
 =?us-ascii?Q?MobDxbaQjrTGubXy466czkXx8mryYtWuDZ+JHGRLq+E2kSyxTne7Duo1MQdg?=
 =?us-ascii?Q?RQhBFVGgdOmP3Fi6+KsUwDPBOXp4bra+zGKWYc6JCd/CV3BPGktt9ghfhx9Y?=
 =?us-ascii?Q?DonLBMoFeR/YYcJzkR4c7f18fZNd1l1TGaMnOnz8N9BygygN6MKxPnbwj4oj?=
 =?us-ascii?Q?tAotPaGD/md/hXCuWXWHLzVfRrKQzKUL1/wkT50e4yo6EC6iWk03XsfFOtnP?=
 =?us-ascii?Q?BcODPFvDBLEoWUIg1CjDpqMR0Mu211gxq4NAiQ7gn6e95Be/GUNeIXp/75bu?=
 =?us-ascii?Q?KPdscv2L8Ir1m81fQqa+0xmmUWZODL68It0jInM712obK1Oezlus0Q4ctFRj?=
 =?us-ascii?Q?i6SlqYQdwfiNQ3WNFL0IMTfANG3KrehIhRN6SHvsrSEGJ9P3Y7glSew6ZcLy?=
 =?us-ascii?Q?dH+bnA4UlnUu/bGQFveWeUmSe3DSU4O1WWv60zbLCEFjEbsu7DNK1TKwkEyE?=
 =?us-ascii?Q?VxOisspjVd4v0oz+evET+1eKJCwLNrZ/d48cpl5/by2bnDWjtHEHdnLgsuUu?=
 =?us-ascii?Q?SshRJSDEZs4aqKHlDrQuYl1H0xUdJo/Xo57P/MBWJXocvGK1qr0rWU4kspmR?=
 =?us-ascii?Q?mN3JOe7POF8PHmddcRQNVReKQbIngF704NeB2ekkgqTMayKX2/76om+8QuGO?=
 =?us-ascii?Q?/NiosCkxvplNNq+JCcs5+520mu5dUWY6RvoaTdNwvnuz/lfx5nbStllN8RPo?=
 =?us-ascii?Q?4ELZZXnNkivCL+4HtK5CkhantKPuCWKzQvkXDIC0kHMaAS15TU0iy+qnwMBg?=
 =?us-ascii?Q?EyADzCoEzg6J7C4lhFL/jEYF72LbkUkgMbYz3xYzbuwdZ1nym4VVX922vLQ8?=
 =?us-ascii?Q?VZ+pcmNsd5tNMcFCNCnGQoxIp8AV/8Nmk5IOnewNDDkE+Q/GECD0TAg3FsZY?=
 =?us-ascii?Q?H0RlzMrcdpFXBEQHJzVWhOqpa4SgaTVDUVt2fOCWZ50AEhnG61bOmXqHdhin?=
 =?us-ascii?Q?uk1nNdTVsYsNriwimgikM0QRoR+trroUdrvShh+V+Os3DR5QPqQ81swvOPKe?=
 =?us-ascii?Q?7avIK4cRJw1fZTYrGB0fabLSi5o95dGzz23sgNr2gwP7PGCvaiW777N4Y/Kt?=
 =?us-ascii?Q?IgPii6Ie6k9aLRzIzJhZ997bgbuGgkMLWaIb9FiBNJS3U6lJoCf9O79D71pG?=
 =?us-ascii?Q?7fuRywHT9I+HEFcjZ9oVDBMppR3pt4MI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qtb5fuidY9d5ktI5stFW3O5NC0aso3hSIlR83EvN217h2Hm0glaVd7FP0p8x?=
 =?us-ascii?Q?i59sl2oCQj7NjcMIW1irg1F8eqLvaSEz6vWTQ80w5sRVBG+j3dJ+zpFzXauh?=
 =?us-ascii?Q?Htt7XE94y/yXRMyEu95weOiYVDxTCPUzScXzIMnd9MV3/ZOgPc/AadSVV6U1?=
 =?us-ascii?Q?966VrHcN969J26ITSYtOxfjr5WD3FOEbQTK+W/pn7OjgzPdgBV+oEa95Vai3?=
 =?us-ascii?Q?vzRbaCqBQkwdQpc14O8rSI6xes28pZN2vJijX1/3zOnZIoeHu+eJORpo0zlz?=
 =?us-ascii?Q?w1h3xdZ/WzHzBilc/+Fq+8x0RSxRkNU1autDDL1D3SqTFRuim8SXTTeuAJkK?=
 =?us-ascii?Q?q4IQuApoFLhojLQhV2PdfbUKmM7DQIKduypAl/7p4wNmotCIZFLSdLMcDFy5?=
 =?us-ascii?Q?WkRH15703vwct25edUK3DK3Ba15/sU0lDGcKPSF1LLUhDcpfTYeD3AXQwjOv?=
 =?us-ascii?Q?TTwgi41xoxgkDbQrUGPmjWQnur3HmRz0b+GC+YiYf8zoswgJ8nNuyoC/gxzb?=
 =?us-ascii?Q?ZqbAAjSOSOUv6G8BBokMPt4oKyZ5Es1JZm9w9hY1lQf9GWwjxc0vFK7s2Qq3?=
 =?us-ascii?Q?1cdi2LlgBAnS0SywLJYAb7S0B2SF84a0LwRz2zu6OMSoOMKKLr640SAxYPHK?=
 =?us-ascii?Q?gY0Fqk9Acty3ZzNoHAasnA0r0d6QEhUcaohbR8JyEDnC7JhmwNo131NEFvyO?=
 =?us-ascii?Q?C2ZD1IuQYTC879rNq2Guini9qpCH3xlGJVn+OfaB9J1wC0dDev9p824/lLPm?=
 =?us-ascii?Q?BDF1tWuJC7DjC9bob4H6wt0cEvw20vEmY9ru6jISN1Lb+fNCWz9nFE24jSmn?=
 =?us-ascii?Q?sRq7gEk9MTFFMbb7PzlHamtyqCDYC6dgTYaVEFPSWtv0oYRTna97MlEiQkPI?=
 =?us-ascii?Q?NztcR7Brfy3N390FuisApfo2SbhMKl8YMzTIoXT1Ti4SNMsTadaj+K+NEiZ/?=
 =?us-ascii?Q?iYy04YomfJwCagC01zlLxDhj6DNV7IMOxzuhyZqn4o40gpReaSTY0VEIMwfI?=
 =?us-ascii?Q?IbXg/NMlOjGzCGGD6pUWX7FxaSPPvZmOEOihz24pMkxz5UyS98oKVruzJXpo?=
 =?us-ascii?Q?Jk6yAAPrxnLUG/AAhEo+loJmJNMntyGZiG9YNZdFEmyPpFXDTttc32jqGDYV?=
 =?us-ascii?Q?uDRCsH0MK66ntep35kC2C8c84hDfrazmRxSqbnviCrPS4rfzss9sdkzrURFu?=
 =?us-ascii?Q?MYTrxiLm9RuIGdjDUaZ39XqRh7SEbf6UCdQia5Tyy+3t1X/bxuUwppf5fyeO?=
 =?us-ascii?Q?gtcem8KX37Oa6RxWUvX78z9vB3UGb29w0em5AcL+aHI24lR5SJLeAt9aMPYO?=
 =?us-ascii?Q?z4/r4Ak9Kl8VOcxVRDbnZV37rOa5gMGGOS/Y7xB+5tJ4ULDvccnzOrig3D9H?=
 =?us-ascii?Q?0aoF9a2IFyuemIKabcnrHYvSK7Rn4ahblFHh+Mrc7XgCZPvHW3fI/XFJsP5D?=
 =?us-ascii?Q?/RosPHpC4XyrCbTdvbnem8Bb7rxoYtUKZdQPFJQ7+zLdV2Ko8OBolFA8V0tS?=
 =?us-ascii?Q?ecbYL57ZlUvKciPZArmNty03CX5XyIdAISEbrSRqi7pqGKxiZerQj/8qAURf?=
 =?us-ascii?Q?U5sJGIUuwwKqqhX17TQVKPMQi4ojFIBX1/syVyZv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5645aece-d61b-4f4d-dac6-08dd4ca363b0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 02:57:59.3750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smO9SnFCn2JQiZHS/gZxFGkmQPunM3xYIFCt1PyIuhRJ5AacKbC4QcLsyrramRfrlzCF0pmTZqXiPr6vNrCnOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11012

Hi Vinod,

Any comments?

Thanks,
Peng

On Fri, Dec 06, 2024 at 04:48:15PM +0800, Peng Fan (OSS) wrote:
>From: Peng Fan <peng.fan@nxp.com>
>
>There is kernel dump when do module test:
>sysfs: cannot create duplicate filename
>/devices/platform/soc@0/44000000.bus/44000000.dma-controller/dma/dma0chan0
> __dma_async_device_channel_register+0x128/0x19c
> dma_async_device_register+0x150/0x454
> fsl_edma_probe+0x6cc/0x8a0
> platform_probe+0x68/0xc8
>
>fsl_edma_cleanup_vchan will unlink vchan.chan.device_node, while
>dma_async_device_unregister  needs the link to do
>__dma_async_device_channel_unregister. So need move fsl_edma_cleanup_vchan
>after dma_async_device_unregister to make sure channel could be freed.
>
>So clean up chan after dma_async_device_unregister to address this.
>
>Fixes: 6f93b93b2a1b ("dmaengine: fsl-edma: kill the tasklets upon exit")
>Reviewed-by: Frank Li <Frank.Li@nxp.com>
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>---
>V4:
> None
>V3:
> Add R-b
>V2:
> Update commit log
>
> drivers/dma/fsl-edma-main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
>index 60de1003193a..3966320c3d73 100644
>--- a/drivers/dma/fsl-edma-main.c
>+++ b/drivers/dma/fsl-edma-main.c
>@@ -668,9 +668,9 @@ static void fsl_edma_remove(struct platform_device *pdev)
> 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
> 
> 	fsl_edma_irq_exit(pdev, fsl_edma);
>-	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
> 	of_dma_controller_free(np);
> 	dma_async_device_unregister(&fsl_edma->dma_dev);
>+	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
> 	fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
> }
> 
>-- 
>2.37.1
>
>

