Return-Path: <dmaengine+bounces-2069-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC4D8C8D89
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 23:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA73282645
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 21:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B223C489;
	Fri, 17 May 2024 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Aoi8VpKP"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE167E76D;
	Fri, 17 May 2024 21:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715980176; cv=fail; b=rGb131KBXWbQ0l49/XXXnhwN7OISzeuTn3VBWr0myK4cSXqIOzTMfjESK7oJhAMIoc3FSl1BisY520ymMvdxEyHYKWtm/TdJngH1KyFMt+Wqx0i0B90L2ZRqoeBQlsosREHnmvEfyO6L1+OqonL0ScVVZZetcuqnCEg+p+FwKWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715980176; c=relaxed/simple;
	bh=boFMxbHIy1XB30+eFCCeqYI50shUL0zNwPLxcJAyxT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=doUQfdtxutyKIOVLEZkqMflaPenqkSaiG4/DMvJZ3Z7ABSsD4Djw6SH28Bf69PZdX2m1D/YAhnObCxCbhbCR4OlRwFiYIqY/9fyJx4EfsjZ/TAkIi+J+UkvFv49lc/3VbgmFT7SW/Xk1J5oHsdFYV+pVSXg1LmlGwi5s7/C+muY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Aoi8VpKP reason="signature verification failed"; arc=fail smtp.client-ip=40.107.247.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6XbpmWB6A1ZkvABxOjhb3ol7E95vYBsz/J68Gi76OFvP9/yKYM89ztwnKDiPH85GFL1CcO673Jn84yf+5CZmYcBsOyRBSYDdByOrQUR8IlU2Y/+cw01dz1ndBhcPrqoNQfZjRY+xvD/WRig3YXXnfrppUsFHsqxSI4n0dt+dxm9uPAyxg56npOg7cpLSKpPJuhrp0183lVPKENTNHRuE4Igj2Jfd08G2BwdyMNUH7LIi9GognoRKnIow1G/oWamIXhJ3inYIIhoE7BmCSDfrwG4hXlGhOoAj8N7ekx46YHXRHqGRLe+SUUwWNsHxYe01WR2gshLnWUtQtHCaIFWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqNPSzCRMHWx+5iWddn8r1TvXQ1QU7NJ2NJRGs9zZF8=;
 b=ZEUJI35VwtA37jcbKFp7zYHqSBE4E9WuWjmTSmjYDyRgk3C41iei/XuALpdct6j4IP/1/JxNUJQJaNmAgC1l7PN21+/mV25J3Uc8mT0nyFeJ7EV9maefAZQOk0mA4xBUAvR0oOFh8UUMHoYRAeKsBIGeIcjWhVzQgmLTQPt+b33pS/gdoFnNDwVkqT9cK9Ivbi50OJyi2GJuSngBdgtvT0OsF2VCigY3TdMKXpo4c7pDAZZp4znkfdwKKHlQPEbFl5PSNuBOtoMR4sYaZGmxM5uXD59tpKlhkUoDfp8RSkpwNKwp82uv8ziSdp7ClIVza7rilYuXdNzQwscWctnefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqNPSzCRMHWx+5iWddn8r1TvXQ1QU7NJ2NJRGs9zZF8=;
 b=Aoi8VpKPrc80L8TiDLAPFumD2tztn4bLPHrfHbWBQeaeBhCyMD2ZMNdkNlzLLgPnsX8kgDB87avGV0AIfY5X5Ps5/chQsxBVCJ0JeB18pXYD7RCvy8uzh3D2TMtadsfSrWwhwGt3WlDKTWjbg+Ar7BVH/iQfAvTMqz0QJ+rd40A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 21:09:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 21:09:29 +0000
Date: Fri, 17 May 2024 17:09:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>,
	Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: mtd: gpmi-nand: Add
 'fsl,imx8qxp-gpmi-nand' compatible string
Message-ID: <ZkfHgGhc5821c9Ma@lizhi-Precision-Tower-5810>
References: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
 <20240517-gpmi_nand-v1-1-73bb8d2cd441@nxp.com>
 <20240517203621.72b8b9c7@xps-13>
 <Zkes3n6ZLjIFFQUK@lizhi-Precision-Tower-5810>
 <20240517215055.02622324@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240517215055.02622324@xps-13>
X-ClientProxiedBy: BY3PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: 0236998b-f49b-4c1c-7794-08dc76b5a3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|376005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?3JNW9WxeqDyK184yCywP2dh/sqNDlvKnpjOsa/tBmNmXRSj633G8TiCdcG?=
 =?iso-8859-1?Q?sXopiIWDftNQqZc0Sm/t1ocvREHTY3eFVEIED+gt95FE3ImRFUgBo6aHWt?=
 =?iso-8859-1?Q?gv3PT/nvN0exfNg71WugqZbxheEfN4fSsVFDucImon6+S0E0hu3yF89T8U?=
 =?iso-8859-1?Q?fHrhuyv/yalNy6XQF/2y4f5BY3HId9x3oq9AThKnElHewZTmgDelBnXo88?=
 =?iso-8859-1?Q?mP33AVNAtQRK1OoGdE5Pw617nnlqlSZnjxOmh6p1do7YUkQQcUxi+nA6RG?=
 =?iso-8859-1?Q?s1X+AyEjSjeaKTu+btXezB5X7mYtM2K45vzzFA6APvAz9duwvuHpMZYCwE?=
 =?iso-8859-1?Q?pmjsWLchtwy5bWIaQKJ7eEBVwDdamb8SymtnD8MxRA4je+iz1+8NAhLhbW?=
 =?iso-8859-1?Q?WuK/DwlbTZpj4Ej/243Hti11PND8yBSrxZ7/84fx5DO68v8b6ATr8XRrkQ?=
 =?iso-8859-1?Q?bSldOJJ4aD3X3qDWkd2SUltmv3Gd5CRMM0K52oylnjtuHZBXIDktsBE6G8?=
 =?iso-8859-1?Q?ifFewRh/Cf3gqTBuzOV3mTPj0Q4GoN83OxgdvkAD1jIS0y7a9vzygb53Fw?=
 =?iso-8859-1?Q?ctE2SvM4mwkylEUGoaElKoduUyKY+mWMiuMIXYh76i5xDwOQkigFIHLSom?=
 =?iso-8859-1?Q?JHXCJuebfFs59ISHu9nT/BNpJhbvM3cZ6ibgDytUJSP65L6JmkMcIlVqS3?=
 =?iso-8859-1?Q?6O/y+N2OZb936/r7Roby1DTfxUAAntEE+HxYjBkOH6/f83hnntKnimzbRw?=
 =?iso-8859-1?Q?AEvgzTkuFE0BYDgRV/QhqLGXKjzgUhUIzKfLsKaNecSJyg2mp3y24yC5C0?=
 =?iso-8859-1?Q?wLPCyBB2mV7okAWtezRaCCDnnrxHi6yvIlQ3zxPqW3MMlxdmlhodTlCnTz?=
 =?iso-8859-1?Q?+plpuwOJUKyYCFTUeqK2Hw82pp9dGl0lmhvfaRlYUFsuaAJ+KTMR8cUyLJ?=
 =?iso-8859-1?Q?MyvxHKc7axcC9zzdbp2S3dDesh9WYgbbYXSUOo0DFgzNfqvs+3To0vj7N7?=
 =?iso-8859-1?Q?bq5we9h6K3J86NsIYiLQa2orDMZwN87zfvNCJMiqRAyY8exXRK2ExukT1C?=
 =?iso-8859-1?Q?tdYEXD/5pq7NBUN4pqmmWWG7tkCTpACmowBuJDXOa2icemhqktfI/YOh03?=
 =?iso-8859-1?Q?cU0QWN6LRwzY1PAkDJucZJN0F5FRXsDJ6WVAWiztDOv1KvytxaF4AFJyp3?=
 =?iso-8859-1?Q?ayE6BNnVhpoI2Sdu4WpgntT7OPBI3N7VAY+54HTl08lUJxOxCJMgYpm55j?=
 =?iso-8859-1?Q?9ynsyHI3LkZAyH81TiGEOrYoWSLgtLAP8TahFjs8HRpxfugr+orxrVu/39?=
 =?iso-8859-1?Q?WR/4i01+yqXnk01GupvpzBTBnzfOkA4pighs8kD3kiCwPqekZEtD9w5JlO?=
 =?iso-8859-1?Q?2JxngFaXeE6M+zA/vrzRy2H2wygFyGCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(376005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?AHxWyhhk754Ho2y6jukQ+kGkvwIhpYS3co2e92QxIr80hsxduXONj6Nco4?=
 =?iso-8859-1?Q?b/1EIqauwfDziTh+t8wYCcfrXpemGI2+Z2Ppd7I4I28YG1Sazd7LqeRmp8?=
 =?iso-8859-1?Q?KPAZSLDH0oJ5rK1omfRjZF1WlHDQFuefZ1D+RQec0pfHEh6xQ7rLHnLpbU?=
 =?iso-8859-1?Q?tFjZHm+slEPNf6qp2sajD0uqd3qEogFaNQeS+F4XE1RHV0LaoYt9zqJ5Ki?=
 =?iso-8859-1?Q?gDmRC7djDfdTm+fNO+hja04nt+MyA8w9t4ZumiTJxw8SwIMeQzEro0cgii?=
 =?iso-8859-1?Q?hkmyddiZbxjEfxmasQrERJs4Hb7r0VWYXYsfsd9V1SpF9iA849ZWDJcjaW?=
 =?iso-8859-1?Q?1IuhcskILCEMbOd5wsGtP3VFJP3R8Sik7ZQrwgea+/zBmYx15QWolTMJFV?=
 =?iso-8859-1?Q?HqKltGDDREqoaVpd+J2S0gwN9+3Y2kUDumcWob7NKogvhPERmsfVsryEYM?=
 =?iso-8859-1?Q?cJzrNzdW0iz1tiqJ4wzJxEZhP4lJXqZHEaUkZqzAr33f2duFQzB08pevha?=
 =?iso-8859-1?Q?Aui89I1TYlahVYT7gmxH2CPknC7PbOxnQuN2HF35yqapcgEZT34M8Oba1h?=
 =?iso-8859-1?Q?9lGhUpS7XTqPC93weHAW5VPfZWtcJY7hLtOhD1yODDffs5IriXNpGwVjyN?=
 =?iso-8859-1?Q?UG64KkGzMHB5Z+9mwqrhGaKIiRPwU2hysxymmTiLxvu7SecsvYf0psJlKp?=
 =?iso-8859-1?Q?B+B5smKwUxJacqXVVnLZ8FOJK0fVeSxGqenST1OXwe65FMBn+YC//GFVb4?=
 =?iso-8859-1?Q?RWyGKRlnVieYpVlPSJhVCVU2ScFTx+j43GlKrf7LQGlsTYFUIVs3Xm2o4Y?=
 =?iso-8859-1?Q?QJb7CCNesJWvwqxEBlJDY1PU1JPZExa4kuqVEYukn7J0nb6vbd/IfiiHf/?=
 =?iso-8859-1?Q?DFtKLo2w4qt2ul7fuc042F1DDuo1yHmQMinqXmkPkH8NiSs8Oo4rfVAKa9?=
 =?iso-8859-1?Q?bRbkAzlrQ29BkpJZ9tBahxZEqR6ymRBK2Lzogu4MJXnGNmYFvC4iQl9PUT?=
 =?iso-8859-1?Q?XgbQSsvdOmjVwrQwtJXmxq9xcB/If0H/0qY64KPioRNjNWRSOxvsGoy45i?=
 =?iso-8859-1?Q?jEN7x3KRXG8+iVjR+/50ASie17QY1U2rZ848hqYHeo3AfxYMsm7yCEbhGv?=
 =?iso-8859-1?Q?32bs8TEwDLCmt9cCTCHEZlIt+WEUIv+2CxpH3xhi5Tb55179WpBizLH+jY?=
 =?iso-8859-1?Q?NYpIg8yxFzMyM/iNv84fvRwiHN3l2SwhJ+XNYxdcjGg8VqOOkDs3q4LCLd?=
 =?iso-8859-1?Q?7/l4u9K28NfHh52pHo95VD5G4TpB4f38RdWwUXpoU/RokRg/pJtMBpwSxl?=
 =?iso-8859-1?Q?cqvet2EdiZWM/Igr4BvKyScbhViazuEM3eaKXLyiBfxl9O0lpxOCfsBHHR?=
 =?iso-8859-1?Q?8XvhwyG4srpyLHIOGz8qShJs4IQTiAQ6ahbTh/v70pRth+rR8EaSkAspQ3?=
 =?iso-8859-1?Q?6202Oa4VvJ/kYAflU4ylKu1Y+XTmb0Ydz3e/roWmzPyMSma9oK98K9m3LL?=
 =?iso-8859-1?Q?lGV9gTntaH3xQD5lmLMKWHC+z7rOTf6FQMKDhrEHItc/pnAb14TzsnAB/6?=
 =?iso-8859-1?Q?hV5nLQxxtbgHjZZWfcx2wW1m4u/g7CF3ldgvx9UAFZZ1Hibhm3Ijk08ZBc?=
 =?iso-8859-1?Q?qcY4Mr/8ooIWQpNwBJQyudE28p3KSzaPRh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0236998b-f49b-4c1c-7794-08dc76b5a3fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 21:09:29.3745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQxRNba2UrgUhoSFThYh9Yxm/R6V6t6vrOa95pp1IS62i6fc07iHVY+DjJAC+5nes9AAfcjqo99F4SIG3585rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

On Fri, May 17, 2024 at 09:50:55PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.li@nxp.com wrote on Fri, 17 May 2024 15:15:42 -0400:
> 
> > On Fri, May 17, 2024 at 08:36:21PM +0200, Miquel Raynal wrote:
> > > Hi Frank,
> > > 
> > > Frank.Li@nxp.com wrote on Fri, 17 May 2024 14:09:48 -0400:
> > >   
> > > > Add 'fsl,imx8qxp-gpmi-nand' compatible string and clock-names restriction.
> > > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  .../devicetree/bindings/mtd/gpmi-nand.yaml         | 22 ++++++++++++++++++++++
> > > >  1 file changed, 22 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> > > > index 021c0da0b072f..f9eb1868ca1f4 100644
> > > > --- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> > > > +++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> > > > @@ -24,6 +24,7 @@ properties:
> > > >            - fsl,imx6q-gpmi-nand
> > > >            - fsl,imx6sx-gpmi-nand
> > > >            - fsl,imx7d-gpmi-nand
> > > > +          - fsl,imx8qxp-gpmi-nand
> > > >        - items:
> > > >            - enum:
> > > >                - fsl,imx8mm-gpmi-nand
> > > > @@ -151,6 +152,27 @@ allOf:
> > > >              - const: gpmi_io
> > > >              - const: gpmi_bch_apb
> > > >  
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - fsl,imx8qxp-gpmi-nand
> > > > +    then:
> > > > +      properties:
> > > > +        clocks:
> > > > +          items:
> > > > +            - description: SoC gpmi io clock
> > > > +            - description: SoC gpmi apb clock  
> > > 
> > > I believe these two clocks are mandatory?  
> > 
> > minItems default is equal to items numbers, here is 4. So all 4 clock are
> > mandatory.
> > 
> > Anything wrong here?
> 
> I'd say that the two "bch" clocks are only used if you decide to
> configure the on-host hardware ECC engine and thus are not needed with
> software corrections, but I'm fine keeping the fourth described in all
> cases if that's simpler.
> 
> Also,here the diff just shows that "if we provide a clocks property
> with this compatible, then we need to provide 4 members", I believe the
> "required" property is already filled somewhere with the
> clocks/clock-names properties?

yes, before allOf

required:
...                                                                 
  - clocks                                                                 
  - clock-names                                                            
...

> 
> Thanks,
> Miquèl

