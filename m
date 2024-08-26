Return-Path: <dmaengine+bounces-2968-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7A695F9AA
	for <lists+dmaengine@lfdr.de>; Mon, 26 Aug 2024 21:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13DAA1C20FBF
	for <lists+dmaengine@lfdr.de>; Mon, 26 Aug 2024 19:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8F91991A9;
	Mon, 26 Aug 2024 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TTumur8c"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013001.outbound.protection.outlook.com [52.101.67.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C1B5644E;
	Mon, 26 Aug 2024 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700477; cv=fail; b=IN+2xBy/n4IIAc9CGsmjRRI+HAb9WwAnc+tkMym4TsA33rdfno+D+Vdr7cEXPdNaWV8PWYllWIlG4eCtfSbTGnzmWoA4H7+PQXcEMcZphbvOUDm7RnysKCUZzT2VRGs+7KUOXMT1sPJgykOUx/7rzvQNHHinbDf2a5eXiTYRfEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700477; c=relaxed/simple;
	bh=LC6EZqQoGlJUWqFoKQSmbWpqmqbDnqNvnKv1xbSPN7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mcpyh+QQpX6gDOLIP5XBjc/JuhLZs3WN7J8brOlb/AKT7LEIL9JnRP/h3yH2Ued47cLQ2BPItf2dsr1riiXH/A+LoicBLoO9ffC4SUC5t9GMf54IEkyk47LDcvpFD8nWdXIG32KA+R6b+R12R3Zgvj0M832lNkMEKvWIWj0Ciyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TTumur8c; arc=fail smtp.client-ip=52.101.67.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5R9q7L6KmaFhlQKZniW23UhW3TN3UPvmedVKoQWw0mn/1pXAvF7NkBO5k3hAbFrPeaeh37OOvdNc5Fm+ZXjDBTpDmCfyIev05I3YifTKq+k9cLnnEFY03BSWsYHPEnMOsNrvHyFlHFK8Rb0ZZ5zTwp+DJEBnW8+zBW0baJx3gecRdLls9BNF5C+/DQQQ21Hr5bzMIkJICcjRr+v2+ro5mHvNn7OfV9mYtTKLX4mcIcPIcQtwCA528V9Dk8RMoMJTtB7JVUs+LW12DG1ldUis+QydzjRft08uzM/tKNvlWmu0KsptVQolVbsnmE8eWS+anKQZsOOPq7MFYeMW3d12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT+EcuhHDxnbm9NQuLt2bgSSb6YRha162ctbp58vb2c=;
 b=W3lYkrjRsYDFVUYnN71RaHrCt/1ofp5jFdsJGcFCMIBmnHTlEvgcOBNg6/22eBFKmqqO9+iO6rTAFERPcQdLj+h+7QCUdZ+PHn+xLZNYUgiGPtDl8lvRjJ0XzSFTk/BnKjNn4fJyovsHMUyNXlJtM5aXVrmf1HRwlJjZUMk9HR3AJt2ZFnQ4zA2G/fn78euUQtGqlg3vUdfcwnlA5Qh21vLDv619WREQMTM62O8fGasU3aizEzY6j8rePJA6E6GYXQoyUcFyKYlZ0E0QNPz5dUZcuJIh2sImt0ErKWDkSb/3JgGs+Fb+U1+nR9hRFuOVklY+g5njvoNIIpfeTEcIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT+EcuhHDxnbm9NQuLt2bgSSb6YRha162ctbp58vb2c=;
 b=TTumur8cSyFMhSI/HL4bLLCu09viLOadXQrIOi8Jz3HiY7+y+VAkXUBINpCt+sELS1Nm+9+yQK18yKwdfJw2KILEZ6+iDdE2R/h4lrdw54kHoHIfQibN+SZYUSm6Cl/MWO+2NVBfh2fNSQzBQdOx7sEUcpkUwHr42eiY09mMUXC3xHeL6YTUbz4IfmWlii8lxnuWuft5j6MHxZhi5WizdmdiGWER73qf1wXi3nOzQ+EZ0mN229oHCvOtKyiRkiNGXdnWQsOOxHBfcr0e2Kmq0+msGy7f7xKLEtpS75JUFQHiLmo0PuSN4s/Ej0AuPNGJTGnlhCm43wNHvnjtz6lzBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10376.eurprd04.prod.outlook.com (2603:10a6:102:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 19:27:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 19:27:46 +0000
Date: Mon, 26 Aug 2024 15:27:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>, vkoul@kernel.org,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dma:imx-sdma:Use devm_clk_get_enabled() helpers
Message-ID: <ZszXKz3RX7FJNQ05@lizhi-Precision-Tower-5810>
References: <20240823101933.9517-1-liaoyuanhong@vivo.com>
 <20240823101933.9517-5-liaoyuanhong@vivo.com>
 <20240823130835.00003495@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823130835.00003495@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10376:EE_
X-MS-Office365-Filtering-Correlation-Id: 086e8be3-a89a-4031-c719-08dcc6052a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/49WOMFjjg6sBIaN45JxRR3wQiyjqh0D1ubTF/+ux7PnLpBaj2HkBZ8b8RyH?=
 =?us-ascii?Q?wkid4JR1rAW3+lxE/n8PuVEtHhg4KsRHI5AmO0+39jIv5VvzwfSnpFRylLms?=
 =?us-ascii?Q?0BfJZ+V2/F3PNw7uFFKJxWThCchlCClyN8MaL/RvWqozoMAwqJN9JBxpCOPb?=
 =?us-ascii?Q?MyJNr29sMIy4AvI2mj+PzGeMwMHf4jV+EHgWrhV2/pT2vxgZgf0glLouWXbh?=
 =?us-ascii?Q?NQdS2PqABWNJWNHCz6ybpxsSMOS9TEB9VuoiEWYYQJcbgE5ZqMarTkPP6JQ3?=
 =?us-ascii?Q?FuZQ2VTImJNI+KQVt5yLW1YsYwmcV55RRhp/QWsKdLu0K2s5AV69APYkJebF?=
 =?us-ascii?Q?5Wcf9AaiVFMylM2njRxv2dhtvAsa9NnJl4poXmOjr6XaZsH+XhKU6metkef4?=
 =?us-ascii?Q?uOEeuom+0IOngse62PwgYN8UXhQ3WzlhP98gEKUunIB3kzsOIDD/Wm/EGW/5?=
 =?us-ascii?Q?XOl3cwmzetjlSIFhpS0osOhYg3jKTybyh+syS0RBHZP2RcbIFKaoxxptpZo9?=
 =?us-ascii?Q?i/37ADwiZaOl24fPHLTQ64gDnsbqhqfzgAcO7Nb72gPkFeUr7ulBeoZnQXSf?=
 =?us-ascii?Q?K00gapkVzkQB4MMtVrrStjSvEtCa6Jrx9Qz3NUHnsKw+biM6W4rSwtXQ2JgY?=
 =?us-ascii?Q?BDBjNzq1fX7psWrxmyYTbLvXBQx+86eNhGOBKeH7Sk1s8Hypmj7Wg4UG3gtk?=
 =?us-ascii?Q?Xci1qng5KRIjsMMu5crP7Uix1Fx4tp0JAGTiU8pcOLhwu/D59JboAsAhPRyI?=
 =?us-ascii?Q?9Qtb5xqU9fc6F0VTgDUuAsV7EhcAeWjGOXVl+qC6TORX8D2Cd2qgxe3v0Pzi?=
 =?us-ascii?Q?8wLKNM0Wms39mhEFfzI9GLD7JQB0ZNXVVUra/XyPcm/Uw1tM+aoqs8p3NlF4?=
 =?us-ascii?Q?UzLQ8csb39xZFzg68KsVe9I3Lnzw3qaMLH3r9kEWQd4Io1NaUg+rVAbE0x1b?=
 =?us-ascii?Q?nArCc49aa3X7nwyayx0vavvG95wntfYMEFtmIfdCkkvGZIUHkQC3O7cJY5oy?=
 =?us-ascii?Q?h4K+nG2PvT/9sHagaiTSNKyZSGYEuyOy3MQh8Tade51GzuvQplaHnvlukBTv?=
 =?us-ascii?Q?xmswNvInXCzZtnUnM7er74LLTfqkxoCRomk3kjsHcfbkl0m/Y8gTTqqTxInA?=
 =?us-ascii?Q?adjbds4FV5es6tdaLlZaPWkVYyiGpv0Xci1kbDnqcU2aLbnOEitMTtcRZjjl?=
 =?us-ascii?Q?8RE4HqPOTI3ZdQonfd3Dk/Q01a/N1P0hca7hso71u0CnJukyqncYGXS+z5oo?=
 =?us-ascii?Q?Zx024N8hhJY7LNbqDhoBSxOy+TqGI5WrOVQRrXRFrEu1cxotS22c806nM7xt?=
 =?us-ascii?Q?NGl35JCwY+2glYcHSryWiniD4yB5feyhkdU1+hq0S3TxqWT6C4Q18fAgewAo?=
 =?us-ascii?Q?q3aQSc5axY2xEU7WugSRM/jldR9r7xzVAgM69HAWyS01HJUDSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DjaeqCr5wYRYlcmfx/SzlVuayaU7wbzS712E/tVI4Wr83Antag0C8ig6/urA?=
 =?us-ascii?Q?PwFMqr/kwxZ3cXkk9SrUvi1lSONa02h+M42+om7r6AZNXwhbr8yMrqFthmLf?=
 =?us-ascii?Q?gT9X5ijn0diuGFtvFFpySx8FAOnOAZATrYzsfD7yQH10Nazju8jhXXI+uQNZ?=
 =?us-ascii?Q?sHQXu2lgAQEfxtnY2VZk1Pp39I8tpsPqlXB618DIeZT50AcxAqJ0L19pYM16?=
 =?us-ascii?Q?3gko9Lsin9DBhBia0D3Lbp0N3xqhtv+8hpeUtt42rMbgAYzSS3euO4STMyLX?=
 =?us-ascii?Q?wY4RmUyXjBClKPvvO3L6wMlyxyXsU4TNxK5VEYJIRxEE4Ic3bwRF9XOSqH5F?=
 =?us-ascii?Q?eCoopt2AAKPPh8ch8Bdlg6WuNvlVxHyXxSB7mkVJPyglXS5qHw9udEQnFh0h?=
 =?us-ascii?Q?65+T47EMdbjba9ZlZD3xRCBq0I/fpn2ViM7zvEQOMa1mtlLv61xOpEIyiDND?=
 =?us-ascii?Q?kykSkIM0nBdfvzxv3DOYUgVxpQI5ofu+MDqBcijg4kuIiYSsa1W12iolKRJU?=
 =?us-ascii?Q?wI4MExgWj2v9Pvg4rqJz3jdDaT/JjAixyiS+g/6lCeEC/W3JldEGpiYkTqHG?=
 =?us-ascii?Q?uKM2J7vN0A92y/CXdWjpvJTTzovOZeBlR34CtVaoy4CgFIzqF6Yqe2znTMtd?=
 =?us-ascii?Q?53490TB0o+KzgWEtbmcPfhs2nEhQlB7rt5KqPqZtjdbsPUFJ6JZQsRSIEBTl?=
 =?us-ascii?Q?K7iYGeKJigKJWcdVUnZAGiG+W3aITxgiw0wO8JYRuCoChI65C18Bw+Qutv0i?=
 =?us-ascii?Q?X8qIYTmbSXqXD32kLr3+gwyt1PGiS1DaZHzophRfo9h2dNRm5Uo9xJQVcH0t?=
 =?us-ascii?Q?+7mgHfJHGMgSjHFETYwBpQlRoHmYVi3PuCZmsCUcgz0h+9Qqz34WxXVmVpa8?=
 =?us-ascii?Q?CSCgcshTfC6Co/kUdYKMB36v85/mQcMDsrV8+Y8yXFfHXVyLmGlQT0FxbOy1?=
 =?us-ascii?Q?A1AHbliqXNfMP665cACr65ZVoSnR4yd1f//0wjnZWaDAVTAYcb6MjX/6QI31?=
 =?us-ascii?Q?6nchhocOASb+55TGDLPLnOKkGyWcm/nkGVxzmQY98vISYawje/U90unLRTCt?=
 =?us-ascii?Q?DFLJ3qTVK2tfumWRvY3qINx5nhNfz8MuLzSfDscM3Rt6cRn4RErLGZbWTqJ1?=
 =?us-ascii?Q?ocRX8nvLOEdEKH0FDJAMUwGo0WL9dTnEZ20fWIiMqOuDEPzq3ckS4a/iq/Tj?=
 =?us-ascii?Q?fYoIUXYKf5Z+WQssjgySZmzVYXP8uiSH+ZBp1XykWIFLVKLeYwtHHY1oljCl?=
 =?us-ascii?Q?g3v90LOUJn8nwXArG31xPaIy1iY6hTG8CTe7wxtzuZyB52IXyQ9UVdsPY8YU?=
 =?us-ascii?Q?fyqvgrs2vT+QHspesBMq05YSEYA4+b9LDXxYl+CM0RJ1uVb70tzRsak8k+rV?=
 =?us-ascii?Q?pU7VZUjB45QoWFzQWZQmAr82EBA9F6xGGawf1P12BabAufonJzlt/CcspD4A?=
 =?us-ascii?Q?NfrZGqafogZCNs2EB6Qn8n10RS5Odcj5x8aEENDz4NaKNqhMxlkNQtCUODCH?=
 =?us-ascii?Q?3brIXxFwCLcTDw0mMhA+/JdNZIeyDb8onkWkH/KHi+L7vbMKVbwpZIgQHnb5?=
 =?us-ascii?Q?3bQNS3rLF5p/Xa+qKJU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086e8be3-a89a-4031-c719-08dcc6052a1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 19:27:46.4369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OXHNqUOmETHxgANWxEpwy+4H3/hpoeFb3nLGTBVKozBSi/GdZVrD6Ho7JRxElIwrnY+DMygD2PvONr8U21jQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10376

On Fri, Aug 23, 2024 at 01:08:35PM +0100, Jonathan Cameron wrote:
> On Fri, 23 Aug 2024 18:19:31 +0800
> Liao Yuanhong <liaoyuanhong@vivo.com> wrote:
>
> > Use devm_clk_get_enabled() instead of clk functions in imx-sdma.
> >
> > Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> No.
> Consider why the clocks are adjusted where they are in existing code
> before 'cleaning' it up.
>
> > ---
> >  drivers/dma/imx-sdma.c | 57 ++++--------------------------------------
> >  1 file changed, 5 insertions(+), 52 deletions(-)
> >
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index 72299a08af44..af972a4b6ce1 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -1493,24 +1493,11 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
> >  	sdmac->event_id0 = data->dma_request;
> >  	sdmac->event_id1 = data->dma_request2;
> >
> > -	ret = clk_enable(sdmac->sdma->clk_ipg);
> > -	if (ret)
> > -		return ret;
> > -	ret = clk_enable(sdmac->sdma->clk_ahb);
> > -	if (ret)
> > -		goto disable_clk_ipg;
> > -
> >  	ret = sdma_set_channel_priority(sdmac, prio);
> >  	if (ret)
> > -		goto disable_clk_ahb;
> > +		return ret;
> >
> >  	return 0;
> > -
> > -disable_clk_ahb:
> > -	clk_disable(sdmac->sdma->clk_ahb);
> > -disable_clk_ipg:
> > -	clk_disable(sdmac->sdma->clk_ipg);
> > -	return ret;
> >  }
> >
> >  static void sdma_free_chan_resources(struct dma_chan *chan)
> > @@ -1530,9 +1517,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
> >  	sdmac->event_id1 = 0;
> >
> >  	sdma_set_channel_priority(sdmac, 0);
> > -
> > -	clk_disable(sdma->clk_ipg);
> > -	clk_disable(sdma->clk_ahb);
> >  }
> >
> >  static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
> > @@ -2015,14 +1999,10 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
> >  	addr = (void *)header + header->script_addrs_start;
> >  	ram_code = (void *)header + header->ram_code_start;
> >
> > -	clk_enable(sdma->clk_ipg);
> > -	clk_enable(sdma->clk_ahb);
> >  	/* download the RAM image for SDMA */
> >  	sdma_load_script(sdma, ram_code,
> >  			 header->ram_code_size,
> >  			 addr->ram_code_start_addr);
> > -	clk_disable(sdma->clk_ipg);
> > -	clk_disable(sdma->clk_ahb);
> Why do you think it is suddenly fine to leave the locks on here and it
> wasn't before?
>
> Check all the paths.
>
> >
> >  	sdma_add_scripts(sdma, addr);
> >
> > @@ -2119,13 +2099,6 @@ static int sdma_init(struct sdma_engine *sdma)
> >  	dma_addr_t ccb_phys;
> >  	int ccbsize;
> >
> > -	ret = clk_enable(sdma->clk_ipg);
> > -	if (ret)
> > -		return ret;
> > -	ret = clk_enable(sdma->clk_ahb);
> > -	if (ret)
> > -		goto disable_clk_ipg;
> > -
> >  	if (sdma->drvdata->check_ratio &&
> >  	    (clk_get_rate(sdma->clk_ahb) == clk_get_rate(sdma->clk_ipg)))
> >  		sdma->clk_ratio = 1;
> > @@ -2180,15 +2153,9 @@ static int sdma_init(struct sdma_engine *sdma)
> >  	/* Initializes channel's priorities */
> >  	sdma_set_channel_priority(&sdma->channel[0], 7);
> >
> > -	clk_disable(sdma->clk_ipg);
> > -	clk_disable(sdma->clk_ahb);
> > -
> >  	return 0;
> >
> >  err_dma_alloc:
> > -	clk_disable(sdma->clk_ahb);
> > -disable_clk_ipg:
> > -	clk_disable(sdma->clk_ipg);
> >  	dev_err(sdma->dev, "initialisation failed with %d\n", ret);
> >  	return ret;
> >  }
> > @@ -2266,33 +2233,25 @@ static int sdma_probe(struct platform_device *pdev)
> >  	if (IS_ERR(sdma->regs))
> >  		return PTR_ERR(sdma->regs);
> >
> > -	sdma->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> > +	sdma->clk_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
> >  	if (IS_ERR(sdma->clk_ipg))
> >  		return PTR_ERR(sdma->clk_ipg);
> >
> > -	sdma->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
> > +	sdma->clk_ahb = devm_clk_get_enabled(&pdev->dev, "ahb");

Supposed it should be devm_clk_get_prepared() here because below code use
clk_prepare().

Please cc to imx@lists.linux.dev next time.

Frank

> >  	if (IS_ERR(sdma->clk_ahb))
> >  		return PTR_ERR(sdma->clk_ahb);
> >
> > -	ret = clk_prepare(sdma->clk_ipg);
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret = clk_prepare(sdma->clk_ahb);
> > -	if (ret)
> > -		goto err_clk;
> > -
> >  	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0,
> >  				dev_name(&pdev->dev), sdma);
> >  	if (ret)
> > -		goto err_irq;
> > +		return ret;
> >
> >  	sdma->irq = irq;
> >
> >  	sdma->script_addrs = kzalloc(sizeof(*sdma->script_addrs), GFP_KERNEL);
> >  	if (!sdma->script_addrs) {
> >  		ret = -ENOMEM;
> > -		goto err_irq;
> > +		return ret;
> >  	}
> >
> >  	/* initially no scripts available */
> > @@ -2407,10 +2366,6 @@ static int sdma_probe(struct platform_device *pdev)
> >  	dma_async_device_unregister(&sdma->dma_device);
> >  err_init:
> >  	kfree(sdma->script_addrs);
> > -err_irq:
> > -	clk_unprepare(sdma->clk_ahb);
> > -err_clk:
> > -	clk_unprepare(sdma->clk_ipg);
> >  	return ret;
> >  }
> >
> > @@ -2422,8 +2377,6 @@ static void sdma_remove(struct platform_device *pdev)
> >  	devm_free_irq(&pdev->dev, sdma->irq, sdma);
> >  	dma_async_device_unregister(&sdma->dma_device);
> >  	kfree(sdma->script_addrs);
> > -	clk_unprepare(sdma->clk_ahb);
> > -	clk_unprepare(sdma->clk_ipg);
> >  	/* Kill the tasklet */
> >  	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
> >  		struct sdma_channel *sdmac = &sdma->channel[i];
>

