Return-Path: <dmaengine+bounces-282-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5027FC8DB
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 22:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2346B21141
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 21:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6959481A8;
	Tue, 28 Nov 2023 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EpxOH/eB"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C749197;
	Tue, 28 Nov 2023 13:58:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNF0f3F6laCOZhs5o93IEcGCicpQQJT5HFzxLf1prs26ZbCEoUaDvb1C+B/BluvWoTv+mkPeATKQcv+k2X+yadoVh0mXGtBWun9wK9fX5+7Qsjas+AtxEBnuOx5Nykwjw7UKnM4BwZa6zYkKlpwweGq2XvDUOa2FRUL5DhKADKdZzJGX19YYQV6XJYeLZm8NHagmvRfvxMMdQHxXIvluglqnn+lVFsmWU3Bno3EppxyaMiCpqEdM4pkHt/LiHYMMBvIvxOJmHPf+9GxXeGOqHmfnfP6hbCuS2TYaPWWUoib1rdLStHqNH5UGajL6eerF5DrASd3/PTpZlH6BEIGgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWjD3b7e+Wo1Gyp4U1J57AVQ6mICM9SLtWlIoXVePZ4=;
 b=VULKqLowyhl7nQJilXgnMYrhe1YWcIqQL5umeie9V+wD1eOeHnF/zWio3jTJ7XSdRKghqUlYSJxL7rS4VDqWbehabfV6pBq6jhyijGaRNllX2l1n67RLreHRAvWqoK1qxk96Jgt6ClWdxHVc0kBGklu5G2dlXg8jxALbWcAhXf5igb5iRcYqCSsGHKunkvf+yJ38SY2yc3/3Tc0Bv31MV4SP74f4UBU5EcHWJdYunqfyHawzc/xvSgu57xk6M2L1Nhx+WRyllJB9sTjBkSZfxUYD5zGwu1KN4DIVMeFkktIY1Jcvly3KZFfNUkF3GSQgI+YZOaEl9CvYron6b4QkKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWjD3b7e+Wo1Gyp4U1J57AVQ6mICM9SLtWlIoXVePZ4=;
 b=EpxOH/eBJWVz2XK6aSlYkMrfT+mOROB44In/2YEFJ+xnq2OKaFkyVlZcxM7mPzHDrdqNTc1s/C+IFyW1zEqvRBcJbajdzsc9sOefWghTVDZNXXOyqk9QG9fLOnTVvzeXZHqaCU32JhtmrHKHsGGWoe2FDJKXlnMJJQuUela11Hg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB6965.eurprd04.prod.outlook.com (2603:10a6:20b:104::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 21:58:03 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 21:58:03 +0000
Date: Tue, 28 Nov 2023 16:57:55 -0500
From: Frank Li <Frank.li@nxp.com>
To: wangxiaolei <xiaolei.wang@windriver.com>
Cc: vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dmaengine: fsl-edma: dmatest timeout
Message-ID: <ZWZiY4Cy/GP8L+Px@lizhi-Precision-Tower-5810>
References: <64cde245-0e53-6559-0a3b-ffe0a5415519@windriver.com>
 <ZWYJgc/S8xMofmWw@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWYJgc/S8xMofmWw@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR07CA0075.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0c4c24-53ea-4a63-e645-08dbf05d1805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iuShHfhRthVWQ81fnhjkcVf6muTCjlxKwL7ff96+ZKMgpBRQtFulE790l2tZ5OOrKT4UP1vBj8H0+F/UUMNDGhT7WJ/eDL1PgzoZPApkzIfkvFnf2mxGZrbvn6usRcEOgSwZSZRfLhXn4+L46suOMoe1yhJXdmAyf566wkZg2XWT9OfkHzmzVMDwdn8zqvrepONnEjncYVh3obnhdYJLIp4fzDewf2XipmBB4joWs2ETVdCU/MGIzDTu9/SNvZ5HkEZSHslC3tP/5rJ9OOe6gbrGdsYpjHOcxD96KtCyAbenxgTuRSVSCJd9JEhcgG0E/cJHIAlBdbnkQss+4hbP2BL8P0BrdIIe5btvf16fW7kTn5p7lVZYC2vF/mc/DcMD9rLn7xtXOZR3aAwtrY/Y4uWRAO/97wQkmjqBuD7fuSguKAff/JqJNLp1iYPGNjxUB5YyyUn7ZMvVKD7nZtbdQ5EG8ZO6uob1QQRmg/i+r7uc2iDgGPzv/UrcgwyJ2ayXL6dJGAoZMPo3XOncoQJdpj2JSrR3D7GWRbwyLgFFpd2K//54V7qsnHxJQB7MBeR45VCLHIDXpfi59Jm8Hamm03zqzhFMlUB7aBZzc8MrhKpo1vrSxIl+87/C0NNFskZ/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(33716001)(41300700001)(5660300002)(2906002)(66556008)(6916009)(66476007)(8676002)(8936002)(66946007)(38350700005)(316002)(4326008)(9686003)(38100700002)(86362001)(83380400001)(6512007)(52116002)(6486002)(26005)(6666004)(6506007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Os5RrxnXXnbJpF2nXo/jonHgzl/aE7+WM2mcfUTDQgZEHHnpyzfr/UMerPt?=
 =?us-ascii?Q?+qlm/RsBNulTt5RNVcSstuKj5xC+nbmA4irt1mPWcAYk4eAk/mXaajlcx1C3?=
 =?us-ascii?Q?Yl865FNNUxDdRssVi5W/kuWcnnC8w00gtH7wPTwBJFjQzQN1ZdUjSeRa/trZ?=
 =?us-ascii?Q?qPpac3cP1/oQVUZZhZ35LwzhCfZT09zz9tnqgZ+BgIhhDyvrN5wI2tEXvV5L?=
 =?us-ascii?Q?PbpT5bZuIu12JAwHucd+8mz6XTuhKQGD+7CO7A6y1l/omctdYwGbf5WArgbB?=
 =?us-ascii?Q?DqEyi47qQ5ULfyp6MsrLEx+riAP8QeRpj77NrGCJbyavecWYDNvyN875ZK5F?=
 =?us-ascii?Q?X3MBR84xeu3aaCt+CUeKld5zdCGmw+KdhyQGzRbXI/oX6RwJ6mLy0Opst34f?=
 =?us-ascii?Q?gBcpvI4u0NcXXFvzNiZW1ziaPVDU2hBj1Lp+k322U685f0Ji/te/1H7mDItq?=
 =?us-ascii?Q?ixPq4JAz16vyUCUATFkhJ0tpBFS+JqUvzZKxii/Izg1CzUhyWxNaqg7Jhm9z?=
 =?us-ascii?Q?RacQfGD1QmY5yntKHUsQHJl+C66PKCYcfSSMihlDw71dlXvd8syANUPzvrJr?=
 =?us-ascii?Q?eP2L8U+V1vY80q1rZ0h0oQ8m0avVm5zqClEWSSBYNPzcSko366oZosfBnwZq?=
 =?us-ascii?Q?3vyhPVKNh1FkVmm5YPsoILo/y4D7ps+DcL9aCX+25v/z7XdwXrXKPzx6u9Bd?=
 =?us-ascii?Q?fSnaBdYdvSF1H8l59GhNTz5+oCZrgxS8L9ZxzbUhDQox3ArOiMkr33xr89dA?=
 =?us-ascii?Q?RpQPm6A5XHkVZeYMLF7ciOQqqyPypklD+nsCnW19F5MzYwxTARsqZSZ0oBs8?=
 =?us-ascii?Q?BVDLHE0Ll7KSLs9xVRvheuVzzslrkaBoJHcuLpX+GtQgeSmg4yxFEHiG6tyQ?=
 =?us-ascii?Q?rIK9WN0vvGuqA+u6DduGyOYdLffi1H/RIo5iznQjiafggSd5O9jJ+dgUPuPN?=
 =?us-ascii?Q?km5AOsgn1BpQfrxMqe3tWHqtZsXDH5NotLbEXflZAnnkQWeD9nFjownuRuFW?=
 =?us-ascii?Q?5hvXdd6MulhufkiBqOwraEzWvA3p6Ut/wuNKDOWkL1ZZWC/2uG3UABbNPyVc?=
 =?us-ascii?Q?GDCYUe6x7gsxOtyz4/c9QgXk9+VQybBcabZlyWfhIbuUE9MUJnXy5V1ijQhY?=
 =?us-ascii?Q?1cExIszvDSHOw0eU/UppmAtUu7M/FS1sFt3vEufVxjx55xv9dtcLJ051n8Bj?=
 =?us-ascii?Q?PCeJWmuHsuoPo9wlZtglUgTmbdBmSzaycyWz5jeTo+sIT5qAPy8ltiACZA9r?=
 =?us-ascii?Q?P1BEw4VCuueqcgg+iJyL3LBvjcmyz3SY4Zp0H2pp7Exr6mh49rBFzGVKWnmD?=
 =?us-ascii?Q?I6TuP7Yf5M6YWa8H75SdpCmmrzCcok2ji2CTsM0VjpfPlYoArTLkCAx/ZqoM?=
 =?us-ascii?Q?8LfSzH7gxd56taXPayOaKpmu9FXLmpL0YXyfY5fuEhP7AcSIyD1J9Q+uWQbC?=
 =?us-ascii?Q?KUIYeU9gbm+pZMaNpd83AnZStkxwNlJUqvwaVoBnyiH/TAFxzrSLkUcpzJAw?=
 =?us-ascii?Q?+3Ggn5MXYi+BoJG660g9tOuKzoJS0f5eGjqMZSLXXBFdaJfjaoI+zVHzR1aO?=
 =?us-ascii?Q?T9/sy5CfuqK8C6d9AIA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0c4c24-53ea-4a63-e645-08dbf05d1805
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 21:58:03.0455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynO2pQ3wt+4GhLLh7B5mM6hVOCOr28lpzSGXgv7WQs8WB7d7yg26yyLoIVUjzppAAeONYFBoMh8L3Tv3vJOuYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6965

On Tue, Nov 28, 2023 at 10:38:41AM -0500, Frank Li wrote:
> On Tue, Nov 28, 2023 at 12:43:59PM +0800, wangxiaolei wrote:
> > Hi
> > 
> > When I executed the following command to do dmatest on the imx8qm platform,
> > 
> > I found that the timeout occurred on the current mainline kernel:
> > 
> > 
> > modprobe dmatest run=1 iterations=42
> > 
> 
> dmatest use mem to mem transfer. It seldom used at actual system. Let me
> check it. 
> 
> Frank
> 
> > 
> > I found that the completion interrupt was not received in
> > fsl_edma3_tx_handler().

I test at imx93, it works. I supposed it is the same as 8qm.

echo dma0chan0 > /sys/module/dmatest/parameters/channel
echo 2000 > /sys/module/dmatest/parameters/timeout
echo 1 > /sys/module/dmatest/parameters/iterations
echo 1 > /sys/module/dmatest/parameters/run

I add debug message: 

[  154.090765] fsl_edma_tx_chan_handler
[  154.094711] fsl_edma_prep_memcpy 8d842340 8d839280 7104
[  154.100063] fsl_edma_tx_chan_handler
[  154.103949] fsl_edma_prep_memcpy 8d8419c0 8d838580 4288
[  154.109265] fsl_edma_tx_chan_handler
[  154.113235] fsl_edma_prep_memcpy 8d840ec0 8d838340 6016
[  154.118573] fsl_edma_tx_chan_handler
[  154.122508] fsl_edma_prep_memcpy 8d841c00 8d83a8c0 1920
[  154.127791] fsl_edma_tx_chan_handler
[  154.131738] fsl_edma_prep_memcpy 8d840040 8d838200 14784
[  154.137272] fsl_edma_tx_chan_handler
[  154.141171] fsl_edma_prep_memcpy 8d840280 8d838080 15616
[  154.146716] fsl_edma_tx_chan_handler
[  154.150598] fsl_edma_prep_memcpy 8d840e00 8d838f40 4928
[  154.155915] fsl_edma_tx_chan_handler
[  154.159858] fsl_edma_prep_memcpy 8d8419c0 8d838040 7424
[  154.165203] fsl_edma_tx_chan_handler
[  154.169140] fsl_edma_prep_memcpy 8d841700 8d839380 2560

Frank

> > 
> > I didn't find any special configuration from the manual. Can anyone give
> > some suggestions?
> > 
> > 
> > thanks
> > 
> > xiaolei
> > 

