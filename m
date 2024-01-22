Return-Path: <dmaengine+bounces-788-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E7F836DDA
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99391F27F32
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33915B5BD;
	Mon, 22 Jan 2024 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H8bgKVz5"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72555B5A9;
	Mon, 22 Jan 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942539; cv=fail; b=jMOM6/1RdDIOw2roLy4Vu9JWhw+4RLh4JEZvJu6PcjTbY6D88wHD/g9fu1goEpNzUnJgaKCG+/6hqApgu7pBzD892A9L4t4mvEko15/ArlHiSD8o+4+Vgf7ylpXtBkXGngboc2GjGHTTDLIexW1MNWEQvRjbHbbDlMcK5NEmhXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942539; c=relaxed/simple;
	bh=KQMtCfeFfzTMcvETTyJTEm3gyEPuoPRfo5x71/rga4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gCSYrb4UCxMuLJ5sHfH9y0wDvA/wwidX+r1knmmD0m5o9H+tqKDQjrtElDb2O6EJCMk7MLlkV7bJ1B8MltQX5cBgPDoTZtA5Q5ZAXiPjfKs+yI8QkLFbjR4kHI2DEe9VKikeSOYa6GTJAxjar93/5ZqXD8muZWGW+3Up7zxmz8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H8bgKVz5; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzNLTwCQS7q1Y0qaJBjDzIeicyWNhrZNUNUzIECquCWejoUnkyC/BdrKJkTqZXi+w437yjaoihUQkmbbtmVKhQmeL+fGbsK6scUu2otnddVpXNsMmvDh5FI8Un4rtaa6t/2GcBPfW6t5BKeaQXgcEBCAe0BkR87e1w8kYxVD52xtv3Pr9FLjY1m2BewWJ99EcZ4gcYKnZGZlOw3gE0jOwWdk7H6QFb59f81i/pp0r8K3SJDYlTMFMwqJ1LjiCryv6Sq9xBJ3pv0AUlxXcM/I0s0OPwdg6lpf7h+Rj3bHg4y7c2CvkJt8MxSq1g1aMQvLhTNLK04wxURSjYKtYth44A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBrDUjhysykv3/2ILyxvWwCtTHqzBv6kcWk3Ys3A2tY=;
 b=l7G8P+kFcIi2xF+NMIG7sFAm1iv5GpV96BmFfkjE5QDOYwjtPhAjYdVEZjWQSxyRS8vXPJNZRWe6HyJFoXa6a+uYx9C8wQb6BsR0I+vFmwrydMytOwEQAbLFwdy5RQ9BivLJNxjST/9mDc8s1WFeh+lqksWOgwXkXXQ6Q20vrxiUc5CXPwQ3j+7XXGLrcRdIdfWkJ+HsfQoS9RcQqHruZJ3JQsBhqpVbgM2cihgyyuY+/c4/dmKgKgUzxEMuwoFZqVe1TVvPDNTshWWcuzoH8KcFWpWrYkMssSFMxgot8TOO+sTgLf9I2aFtB774vWzeLSiqzbMceHCRmIuZ3YHDkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBrDUjhysykv3/2ILyxvWwCtTHqzBv6kcWk3Ys3A2tY=;
 b=H8bgKVz5ePzsCVh1SUNLOr3feo7+pWgBNNwkH+J5zKj5TYZf0lcTPasIFswFR+wMOQ7qFOCJQscPl2t9Ah+L2LuxZtLYey/fHOaUiSvGv9zYa/02LE/Pp5R67vUYF+OaW+S2i0h5eXiDlzlX9r29pK2Ot1IjLsDbW2AA4cZ06as=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7761.eurprd04.prod.outlook.com (2603:10a6:20b:248::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 16:55:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 16:55:34 +0000
Date: Mon, 22 Jan 2024 11:55:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: joy.zou@nxp.com, vkoul@kernel.org
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
	shenwei.wang@nxp.com
Subject: Re: [PATCH v4 0/6] dmaengine: fsl-edma: integrate TCD64 support for
 64bit physical address
Message-ID: <Za6d/lSARdxpqU4e@lizhi-Precision-Tower-5810>
References: <20231221153528.1588049-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221153528.1588049-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BYAPR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0ad954-d502-4252-1854-08dc1b6af386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	22ofuyCF70t0e/fFxXwGgLwp3oisBA3n/clWiJQhYCMs7OX4YL/kIXSvZvmuJdfTOS/bXJqE/woRVOfiAGKQc1eYzsdNcyUDe+mLWJRUpQgOcGkW9g09jY8lgD/PXzuA+Tyx4BRVEkCVHygCLfyM/kisUuPKtS/7D8nFwvqLXOThTfSiFo0+vfJNeXXZ3SpqiQAPEnauxBKjpbQgrkH5fHcTAA3uzSJLuJcriAUmJEW5ebyx7YRznm0XgSi3TTp9Hi9W6huZ7ZmWFe3rCn5n/AA/2f1UcOv+eHG7Tiiw+nT8zHS7l/0rFB27YetUH6ztf4ZEPUqmV58SpzgtPVByse8IJOHJ+Drp6Ufgaz5sIMeVATzvCVGArAGWK+hx4+TdlQzbcT2WTPU59hnmtwgkMR1/PrUBuY1tILarnO9TgILpsQoJ89TUZyyLmd8UQHHLL2HmM0oSss2Ma4FOWXJ4RwYwIkUVmNDN0QaYNJ9Eih5QBZb/pXYt4q9LIgO5L12qt3D88QgE0vu48hV4bGGQzeGvtix4Q+17vIo/62yInZB45bkD2Tmoi9shUREdlPZPATVPKiOeK2VErpSPzmbByX8trTjtpsyaKO6DYYuumuK5aJl9ZL+T+LZzSsA8mpdm0AzFfKjd3v/NM7eY+zRuGyv3ccLswkLVaghPYfuUq38=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(33716001)(26005)(38350700005)(52116002)(478600001)(9686003)(6506007)(6666004)(83380400001)(38100700002)(6512007)(66946007)(6486002)(66556008)(66476007)(316002)(2906002)(8936002)(86362001)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s+e8SSpkLhn2Yl45joReDKDQkQ94Ry/syEYag5ttZUgiLM7kHal5wMBJ2nK7?=
 =?us-ascii?Q?H1fWIVp2uJ2pgNBNijSvGt6TpmpIisPaeLbpLBTcxgMj378l0lkvr2mTo+CZ?=
 =?us-ascii?Q?XrDO+8Dx3IxTFdXL1resgAnPH39mLXS5gycXJGZ8OjaurV82HsW93Mp6nXBB?=
 =?us-ascii?Q?zmisPmLCJ1+GA675DMT68Bk6tZWeZScSr06e+UU2sIwzdwN0kdS2jvxIJuNy?=
 =?us-ascii?Q?YgtLvXdjJebQRfDRULPwqrcLn3rpf3FYc+aePCalzSS9ur2TQKwGgpGMzF02?=
 =?us-ascii?Q?q0jvDKpIC0cCvpDSPlAgs/A4sYnIXoYkoRWscYpbjnFDtWdnTSlGDy9hCJQH?=
 =?us-ascii?Q?yeGiBiai8ZllL3m1kH5z9lkbBtIX94ytX/fsQY49cMitAmKzhTXshRSXU1Pz?=
 =?us-ascii?Q?E4tM8s7hMmObFkxDr5HzeqJj3n+kRjG/kX23zqToRM1vpe9c+tON9ENOeAhX?=
 =?us-ascii?Q?6GeqSNJXrp3six8gCYJ3XspOq34GhULN6nBwJwpPR/auPcmghezntq2CSHcF?=
 =?us-ascii?Q?eZOqaRpQ9OhdsHmIFNt4saiiGXOFJR99qMVDb7CiGlX1ZhSRRwREZ9L3Eudh?=
 =?us-ascii?Q?Z5qwgaMd+9KTebY59BUeeBe1RynUk9j3nFMnWOtdx8O7SUiqSb8B/c/cYdpV?=
 =?us-ascii?Q?ERoxcCc27Ro5rdzv4wtEvW20oqv64hdoj88xkL5w4lfBKt6i9AruXi1JwlHW?=
 =?us-ascii?Q?CUxOn3owHMyPIwGeyzs81a+hUOFaNj7K4IYJnidZNx3wKox6FsV7lzETsF4Y?=
 =?us-ascii?Q?rFlKUcSilz9NwiVWCqmNvDVNPV8jKMLRlpArQ7MM63zN2dlfY6GDY4hFzelR?=
 =?us-ascii?Q?LGsZLonZH6bseSJI8pR2fbv/TyRKuiFaVnaIAH1o/Ug833oOvrwlPM16p66r?=
 =?us-ascii?Q?+u4LYiBI6K+UZdGyn8F247xTD31zOE09FmV6zO3SBYZ9lbfcxyAMWVtEmiQA?=
 =?us-ascii?Q?f0mVRwpsHe/84kJEcUuoSCrBhmRzK8iBIHyVhfg9Bj160J1aXOR2fLDULX/q?=
 =?us-ascii?Q?HxVTmMJZFx6BKHAPSQAQVn4UXJGesPcrp4LgD4yw325IkGBcr5i6u4juyBUv?=
 =?us-ascii?Q?6XbXEnmPujD0Zweh+1IvyCG14H/lp58mbJjwPta1yH3VJ/Iz8JT5GBQohMYV?=
 =?us-ascii?Q?vASrd89xfrFv+28n89RLs+vhaHrJBRNgWb3YbNY30iqenl+NuzFKOk6IAuAQ?=
 =?us-ascii?Q?ZQz3QOw4qw9KJ8OVDK53hoEt3ZinXCIyocyYCrdIRkxlGskixSMzp8iRvJbh?=
 =?us-ascii?Q?2tFsDlroXsUISbKulA3uADsR9rYpJNe9OjV1fv9oR3FBGT1dJ8XyX5KaboYf?=
 =?us-ascii?Q?cbDTbpcFCJvrxbeBwdlZoRKQ+j/E+SUsGnwfqOHWJ+lyNAtmmzem/W4W+ub1?=
 =?us-ascii?Q?z4blCCPrzQG6w2Gk0fOedh5bA3V6RdUapvEDRwzNoMuR9ed+pL/ucYSRSx/A?=
 =?us-ascii?Q?LUsBkfaUReLvb48Oo7gl1JnlIsZjKVmNne2oujC10QJTyOYLN1zYyUBp+GQQ?=
 =?us-ascii?Q?AjoeDhl7yVOtS45Pas+icUiQm8U0adHzkGAc286iMnh3zHjqTgG4/tEveksX?=
 =?us-ascii?Q?zK1qkae4YCRAP8jFbhgvrn48URscpuh6xn4rrDxo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0ad954-d502-4252-1854-08dc1b6af386
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 16:55:34.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVtydG8DQUWOxLCC7JBcX4TY6YGCw3fsbf5HVxJY9zyQ5h3dA+0dGgdAWJkCuA+03H4Nhg/lFKrEpr99taal/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7761

On Thu, Dec 21, 2023 at 10:35:22AM -0500, Frank Li wrote:
> Change from v3 to v4.	
> Fixed tcd64 type as fsl_edma_hw_tcd64
> 
> Change from v2 to v3:
>  - fix sparse build warning
> 
> Change from v1 to v2:
> - fixed mcf-edma-main.c build error.
> - fixed readq build error. readq actually is not atomic read in imx95.
> So split to two ioread32\iowrite32.
>   It needs read at least twice to avoid lower 32 bit part wrap during read
> up 32bit part.
> 
> first 2 patch is prepare, No function change.
> 3rd patch is dt-bind doc
> 4rd patch is actuall support TCD64

@vnod:

	Could you please check these patches? I still have more patches,
which depended on this.
	eDMA is used for cross whole i.MX chips.
		
Frank

> 
> Frank Li (6):
>   dmaengine: fsl-edma: involve help macro fsl_edma_set(get)_tcd()
>   dmaengine: fsl-edma: fix spare build warning
>   dmaengine: fsl-edma: add address for channel mux register in
>     fsl_edma_chan
>   dmaengine: mcf-edma: utilize edma_write_tcdreg() macro for TCD Access
>   dt-bindings: fsl-dma: fsl-edma: add fsl,imx95-edma5 compatible string
>   dmaengine: fsl-edma: integrate TCD64 support for i.MX95
> 
>  .../devicetree/bindings/dma/fsl,edma.yaml     |   2 +
>  drivers/dma/fsl-edma-common.c                 | 101 ++++++-----
>  drivers/dma/fsl-edma-common.h                 | 161 ++++++++++++++++--
>  drivers/dma/fsl-edma-main.c                   |  19 ++-
>  drivers/dma/mcf-edma-main.c                   |   2 +-
>  5 files changed, 223 insertions(+), 62 deletions(-)
> 
> -- 
> 2.34.1
> 

