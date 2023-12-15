Return-Path: <dmaengine+bounces-534-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6410581411F
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 06:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CAB2841E3
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 05:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D74B5697;
	Fri, 15 Dec 2023 05:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fHdM8lVo"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2075.outbound.protection.outlook.com [40.107.104.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7725F568C;
	Fri, 15 Dec 2023 05:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idZULi7Of9CCZ2hiQCub4SBy0JrdObw/Tl6QlS+atbIcdnS1R1yzPf95RshfOV6v57fbzvxtEv+yRHBfn7qR3OEdnPkgVHwIeJJoGXkmKi0lRJ2XiNE+wbnrhbuXiXxmtLDRQ4VRGcFkwG4+4NL0yobYEHH7SvPjCjXJlVV0W6FZZna9IVZX7J8r0KLIT1OvFLJsOxTHBOQI39EmCdDBH0d14UG43dpftEibXQJ6eNvF+D9XeuTx8VEPsKc6Kd1fPDiKDYrWMV1UAWMAmPRZeCje2XSLkp8DUfySwAM0Rt5Ub3675WeCGJm1zDw8duSYRSN+4tpqoLxIIUYJtjoDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+Z0KMEgY9mk188TyBhhqCnmZ9Z1niI5ahCrn69K+jQ=;
 b=l37gXC9HCLPWUoJEJMa4926zAYjzpcj2p2yrVkVdQ3/YS76VtmgnFoYs6jMbb6vtWSv11YDYiCQPVX/dEODvTkoWjreAlrtNF06yFpaX6jvWlsKqDZFTvnfizfgQX8ep3O6hKAsMaham71bOqR64UnUB8gw1TZ61H4Egn+VZu2ltZCw0w2qlr9Vq23rCEu5NqTB8D9gwXaNS79FwroBkwLEoDcOYUv5Us1Ef2K6r5D6qkB+4XIWEOifVI3i4QpveWETmMCxJpKI5rRK3y2UXoCT6Ciy8ovO0nUMGp3qB4+lyD1gPV5tLr+R+ZNFUzVs21a6IBpBorqcDZ7MuPKqSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+Z0KMEgY9mk188TyBhhqCnmZ9Z1niI5ahCrn69K+jQ=;
 b=fHdM8lVoB/tTiYzBE1bhpyj77QBTJ7wnwOQZtoh6JbiePSZTUGZ47oEJayycD5Shbk9xeTK3hCYeDC42VwmJOlRftSww7fAouI5FWEarpN2KuveDWc8GWGTvevq0lkjBpHhpcSeMCBeEscMdj8gMb+dgWZuSXXgYhl/ZT4ssqm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM0PR04MB7025.eurprd04.prod.outlook.com (2603:10a6:208:19c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.30; Fri, 15 Dec
 2023 05:04:55 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 05:04:55 +0000
Date: Fri, 15 Dec 2023 00:04:45 -0500
From: Frank Li <Frank.li@nxp.com>
To: krzysztof.kozlowski@linaro.org, shawnguo@kernel.org, festevam@denx.de
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com,
	vkoul@kernel.org
Subject: Re: [PATCH 0/4] dmaengine: fsl-edma: fix eDMAv4 uart dma loop test
 failure
Message-ID: <ZXvebWSmOhHRIcZc@lizhi-Precision-Tower-5810>
References: <20231114154824.3617255-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114154824.3617255-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BYAPR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::46) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM0PR04MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ef390e-d369-462e-1828-08dbfd2b604a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rQwtQc5l5/tiG50+vWG3/JNNUJcuf20MNmOgoOv8hKiXNnDLjCTdgW0cEtOYejpscMb8mGATa55Mhsm5XAsCKDEkzXh/31MKEWcCSen+2SsMqd3ae+7tK2sDM36wmjQTtonBMlwcTcpJBSgy22eti9g3pNV6SQXRpaMvz+yGvEoHYacwYlt2ajTKxeYhEjwWbpUi/oy9eUMWCtvDSdH3bjuQTqMGs1LTEWCtu8K1bp4VnubGnA3bjxrXVC+3gYWcl2a6zi1iCivmKeFdvEs0Uzad04Y5pD+JxX/uNOdu/zKQQgkxNSDu3wlO/EUoe7Vkb4dtZEH6wNif7JD+a7hllXLJ159AAQ+7klgv33w0C3kA/gvdNqgSgPATiugNh7/+0wTRwSzHKMjUMqgFEgEYpEbyoXXTqtVzUSH9UnSxjbZIw1Gj2GfAQMVsK1UlhG+H4Mv/7GWPJmtvi1Fd2VpgpITkrQ3E+S46iK+1M2lppCNHydGsG9HR7v7bDrfQrhUdV4Pqq08kAMZ/P1YRjuiPooLiH/SeRbQm3YgrwygqkVmZNk6z/KR03lrN6KP9mJFoiC8wERUbg3ggmnuTQ6kU1w46x4rl1scHGbMviKgiSTdK5AOQKhGkumGZya6x9Pu5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(4326008)(8936002)(8676002)(2906002)(7416002)(5660300002)(478600001)(6506007)(6512007)(6666004)(9686003)(52116002)(66476007)(66556008)(66946007)(316002)(6486002)(33716001)(41300700001)(38100700002)(86362001)(38350700005)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cuCklYpZ7n0k8fvHOG3AHqev+vNEKpCZnY0uuVCEaX7pOi3vMore45tnuj1l?=
 =?us-ascii?Q?cC5h3ty86S538rl7+fNRD0VfNjSTBDMoaVALea5L3pf1AowkqS2k18UTWKJk?=
 =?us-ascii?Q?nALq6VWPZfkjH5PY8I+RKzytxuNZRChKYSjxsC19EYEzOQvwe6idM2lolN/Z?=
 =?us-ascii?Q?lCbEKnrZqYmiilHWYZHmHZShQ/2IoCU56ce8jUIf7o6Q1J6ciGPlmkhDDYDB?=
 =?us-ascii?Q?44c3Mk83LcBlabCWiC2XmCHmVcjHOv3+xn6Wkdev57PXAoWXajDMEgPrhNhU?=
 =?us-ascii?Q?OnjrxmXDGXhV1Ff44FzP2TD2VuNq91WdQfoe1gizCBMZHtpXiy9McBO9Hon6?=
 =?us-ascii?Q?LKi2oHQBbNLh3JQfUqhNPUWkbIq5JeQnfHSGMGOtL45PkX/awJkUEQArEJig?=
 =?us-ascii?Q?Odmf4cXtVhHaeUiHwa1tE9V+HhneaxdDHaPSJs3DX+WSXtdvrvcb9T/zYFQe?=
 =?us-ascii?Q?tmtVHzneuqgZoIPKDnTFu4zuR9zKKp96pC5uI0vqfo+I7USU5jJHYqyWyTZP?=
 =?us-ascii?Q?Z06LCHD2OlEcF47urryBIBjEAreW5af3o1JJ1IHTyM7wLl5ZwkksYA2tZgh4?=
 =?us-ascii?Q?43PaM2aglHCJWFafKw8+/srU3t4k28T8WTINEOszRjia7ZAABHVYeT/7+Xfv?=
 =?us-ascii?Q?souvQNXwc9qiGfBJ8+iDiL5jfgyZQscnyUxYcH8vruk3bEil9whnqi4OpLhA?=
 =?us-ascii?Q?y/j02+gC2LewmOV4I7c2JWk+cCshJOXTD9+gA+VQ8/u58LqhaOft1lqr4Fc2?=
 =?us-ascii?Q?dNcipHY9XO4lB1hIrDk69PSwpanRKZoSvoQ3WGjtypWfBu/RksL4XAOeOFrf?=
 =?us-ascii?Q?LuoILqz+yXIvYxXt9c1JxqmKkN6pUfiJZXgoWTlzfBXx+cNxpgZedagxwtjp?=
 =?us-ascii?Q?cVaHqn641GKGercPPGljYL9+IfDk89dq0s4AeodccXY7apvTMypkmV4lbvbG?=
 =?us-ascii?Q?OzREArZB8GnH/RZsAZekfwjf6uehTY9U9/Ncl2g1jMkPbdy+BgX1SejfIvVS?=
 =?us-ascii?Q?LssaBSQ+W0oAkVzqeG2vHZ093V0BpD2/r0WQ7xqYQ1F+x9BN8LteX1KkvoRO?=
 =?us-ascii?Q?qCvirR3RE0EUY8hFHZo3DnBAlLqduXMC9ZPfZZEiLawBoR6WvT5HJZEr4RlK?=
 =?us-ascii?Q?1OyefjIijSCXxZJ6YzKzW8gy5H8FTPiPIqvjT+m9tvAOQ2jiULF8XFcqyWoB?=
 =?us-ascii?Q?5VbmSWmimFBftkkzEY5ZFl2ZNno+p5pC4eZ7FctCtS6L+ydKAZz2cdedqj65?=
 =?us-ascii?Q?RE2pYxXpqZbMKhlOhBfGpTaoHTO5KGvh2E3r/C3VsnvhaNy1+UPCsQg+Qi7/?=
 =?us-ascii?Q?rnsMmlGPO15tkRtu2RRACkYMNNDwjq/YCDLlbWhWHeGxdsxI6vOUqG9h7Sf2?=
 =?us-ascii?Q?qpdbVItrcf9B1Wxc13r9AmIduWpdWbQYqVIrJXI2kjlAURSSzIsT8SWhvpXd?=
 =?us-ascii?Q?vnuyHLH8sTDvGST31d+/LXBgiZZLXG8bKSMO+gTk3IKgNTmbgfaYjOI52Psk?=
 =?us-ascii?Q?vcpWHuAU0LX9GsCBWAW8TiFQYcFD9sSXdJiBdV8Y/BaQgvq+29SfHW+Xx24h?=
 =?us-ascii?Q?e6LWZfyMdv0023kI7Wo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ef390e-d369-462e-1828-08dbfd2b604a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 05:04:55.5435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8mD6zCkjjugoKRKihtGZp41PecBi3JFmQB2L/30bkMC/tp1kh0KQDt7gayq+lss1ZnAYvhBVQw+Lclv6+4TqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7025

On Tue, Nov 14, 2023 at 10:48:20AM -0500, Frank Li wrote:
> The commit a725990557e7d ("arm64: dts: imx93: Fix the dmas entries order")
> trigger a hidden eDMAv4 hardware limitation.
> 
> Some channel require stick to odd number, some require stick to even
> number.
> 
> This fixes include 3 part.
> 1. add limitation at eDMA driver.
> 2. create dt-binding header file to share define between driver and dts
> 3. add ODD and EVEN requirement for uart driver at dts file.

@vkoul:
	Did you have chance to check this patch?

Frank	

> 
> Frank Li (4):
>   dmaengine: fsl-edma: fix eDMAv4 channel allocation issue
>   dt-bindings: dma: fsl-edma: Add fsl-edma.h to prevent hardcoding in
>     dts
>   dmaengine: fsl-edma: utilize common dt-binding header file
>   arm64: dts: imx93: Fix EDMA transfer failure
> 
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 13 +++++++++----
>  drivers/dma/fsl-edma-main.c              | 17 ++++++++++-------
>  include/dt-bindings/dma/fsl-edma.h       | 21 +++++++++++++++++++++
>  3 files changed, 40 insertions(+), 11 deletions(-)
>  create mode 100644 include/dt-bindings/dma/fsl-edma.h
> 
> -- 
> 2.34.1
> 

