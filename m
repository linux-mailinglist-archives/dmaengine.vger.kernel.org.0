Return-Path: <dmaengine+bounces-918-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3222844324
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 16:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484AC1F2AF0B
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EFC129A97;
	Wed, 31 Jan 2024 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cFbJC2Cy"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF312AAFD;
	Wed, 31 Jan 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715233; cv=fail; b=BEwwswuLmO8cVz9CVJfdgCV62VR56a2qDyEi7uZhtnZmkJlb13ZfCXL7P+FoC/JDGpYjXkQDgRKxXkcghoGFrCSEZY7O2IlHtRbdUH/3XUp4GXJrfM6ZblaV39BOEjijTPIo42MEkoa1SeyKGUPXKmGqIFBu8hIMTcqWTOB6VBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715233; c=relaxed/simple;
	bh=WAUd4tFS2O8fSB7vNHelt/r3NhbaaLjhCyQfzbrCvVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uV8QoV+vguZlv3PhUzm1Wv8Q2lPg+XSMiQoTVbeYCgZyVg6dZoM1nyooxN/501frSNZCcMHElSiUHHlXihsy4thwyf7IGhXZSR2bXAnuGX3in9VF+nL+2+USRA47Vy9W8b/HmmkN+I8asSc6TSR+k6cQyWMcVR+wVFrcEYQUuB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cFbJC2Cy; arc=fail smtp.client-ip=40.107.13.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Is6ibetbbCzsjMj4V2jFeF0dHdjpaUU/fK9BFAFrUQdt52GEZ7Ub/OOfus2xp5CCyfldscZN1xtjcQqGLvB9OK1C4IOOlUrGR+KP0uHYpTL9AXVpN8I8DRP2AKVEZIJ6MjOaCIsivNBFVvkYK5Cq1EhlZQrtpx6M3CT2ZZ7E2Pqf9SzIPF90OXf4typKgrRtEsd4M7IeHdKJ6xiH0nlYp+dFCKeY02ghi41aNYMKpi6I1AIclIikPFo0trsz2zhM0YDs+PSH3SoLiJS5XvMHCTI2tWWuk/W5BmWfMhGu7zIOhVAU4pk89V20UyOYQsj0SJiO7BlaPhJKe4iItBNTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+U1Ti+lC9m3FBSuaYrvvjx7lzWX2OlmWyhqzKOBPS8=;
 b=Rb1a062NF58MNdPR1BRkqGcVs53XAozZXViSBRczk97m+sdaAuvCPHt5A6yqOE9aWio8SXQfW+eJF2n4pwxGuFwivdlnBkUN4FgowyIB2eY3WuuXX3yFR38BU+IIk8DONtt2p838lapEeRTY/BIFZEn5vT7rVkffpboiHLQYypFhCvLVyK0E6Togcye/VxBHVG76CnjDSBnEPDnmsJFN5HLo1BJ96E9403IbixMreF7DcjzcttTheq/fjmGPV7Zjqpd3LPbf0SLC+DH/wKVPfPeyDqB5ReFeWHtrWT38RH0hgoC/zcjLuXY46Z4Kuvl9UzfbZ7jgCQRnAo53kw9Y7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+U1Ti+lC9m3FBSuaYrvvjx7lzWX2OlmWyhqzKOBPS8=;
 b=cFbJC2Cy672em/zWwtMl2mvh1ZUEIgebfqRPozOahIqqg/65IjhDku6GWj0W8+6me+lThNbV3Sxlsi8K9jE2Je/j0b9BAsVV26ssznoBKvY3Kww/XndnGJbnop+zPpIIRFVBQ3FtFkwAUiScGU7NkucKBbxDgms7gLqF6WgP+ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 15:33:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 15:33:48 +0000
Date: Wed, 31 Jan 2024 10:33:42 -0500
From: Frank Li <Frank.li@nxp.com>
To: vkoul@kernel.org
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
	shenwei.wang@nxp.com
Subject: Re: [PATCH v4 0/6] dmaengine: fsl-edma: integrate TCD64 support for
 64bit physical address
Message-ID: <ZbpoVq/JALpmGv4J@lizhi-Precision-Tower-5810>
References: <20231221153528.1588049-1-Frank.Li@nxp.com>
 <Za6d/lSARdxpqU4e@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za6d/lSARdxpqU4e@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f5c0d9-f933-4364-a208-08dc227204c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nv9eG6UqyIXJ2928m46tz5XOY+wopkAtvRNYL1PDWLsKlRLFy0fz89Rxey6JehNGDSj/n9g/kGcVbiqKHHMlQ3DwKnetgNFy9EO31MuYaiHYjz6K+wwhY3LseqL4r4MDRRU5qxjTOsxCRI/csRIexJ3aj0wKL0QfvB1B8Dm9+5brwKBLDRW6i/1OavCbN4e0kcead/dQZpE1lLQcsqRDs0Qio5zghxi+8p7MCIJUvrgT/1unD8Iw6gZFn+cXoafXmZ1OccQ/rkBdrmLT9xzabqAi2Ah9nXo6tGHVSDVPr0M0CsLgDFXTTDo1sxb3Q3PGQqLS673U/8EeF92VQZevevGvYONUDEidDXVZ60hQp/jJYjlxkr2AJLCVQkyRjmboIIZm+uEGyYXSZq1zPX9dBZYsZ3tIqljByI/jJOdnUKIad7MuDtcdeIgQwX2NEtOzUQ+Tzx8nh8dJ4ZibLHi9Z+i70YHgIrUH2YRMlHXr9J1He9wWTCDblfUwHC2NYiWY75XJuR1NaWBUiwBP3F56RffvXfLIr4E2fkcdpU6RYiT7wV11tWk34X7jLw+KxJIZAa4S+FqJVMd1AqhDHNQZPY5iX3EbKVjKyt6YNxRfZlQhqy1y1m/p2aOJ6Sactxz3/aZJ/zXSqkmAmEPT22w0wIOhMFcreLtYqn6AlISBM8o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(376002)(396003)(136003)(39860400002)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(33716001)(26005)(41300700001)(478600001)(38350700005)(6916009)(316002)(66556008)(66476007)(6666004)(6486002)(6512007)(52116002)(6506007)(9686003)(83380400001)(38100700002)(66946007)(5660300002)(2906002)(8936002)(86362001)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BmAJiqnEOnflTEqHDWfY85rYj2jlc8YiKpinRyvXu6bpnQljXWML0q+2Tvs1?=
 =?us-ascii?Q?iQ2PbFGUirfbkJEyyxzPHRo9L2CCbE1i9p4qDOsnhgBRMptpwr8MnuSAM1/K?=
 =?us-ascii?Q?C8p0ON8cfvCNYY6hgX1b5eVrzIX1c7klniP+bkmvnZWw4nW2ViOFx71d0KUh?=
 =?us-ascii?Q?i/9xWIi12VphiF1Gw7SHGD/qWgStE1sK25q7xCv3POTlT5fLvKx990MiEi1x?=
 =?us-ascii?Q?qDZblgBuYXIbW/kzoHokR8yOU2hNiVh1J9ZhtOmCcQLTWqYpSz7gPyma+RNf?=
 =?us-ascii?Q?20eiY+jU58/HV4FQ/8QpiF3tapPPlWiGfdY3vM5XvgQePBvmKvxK+7vEJRws?=
 =?us-ascii?Q?onSUGPc/V/Bc+eyY2kIRj8XfSnB3EqPgCQQeV23z+QfM/Ulx2FJ5nj7MKRsX?=
 =?us-ascii?Q?8Zq26/QNIeJJrrmHMA8CZ2D2dqBQOj5jraJsJnJZ1nB27MIFFlFz6dR6Yggb?=
 =?us-ascii?Q?AJ0txp7iXMfoWaQCtaQvEGIrCal2xd434WVJQCqc/YGl/dEHabmIOHX/CMBC?=
 =?us-ascii?Q?y1zPxT3qVaINRSgsrP2Y/RHu2aEwCV3pwxK/veGu4FFR+vAcP9rFxs+sZd04?=
 =?us-ascii?Q?2UBJDL480bdRtfuob4y7GMM8Mg/tR28gljWCW+nNR3iMEm1vkAOoHhIMBrLU?=
 =?us-ascii?Q?278QI73JfKTyetynpr8CVo915SjxPJTqta/dB1xztFAMOKs9eyllFwNcdbIg?=
 =?us-ascii?Q?HtsBrUkJ76dtk55v944PVzlFS2yJERQv58X5qADka/rj3xLpiRPMfVsYTfbR?=
 =?us-ascii?Q?59p3qX1qVgcyWCkowfbZf3TvEgjA1ZlfjMudqwBXQLXmuvI4kXqRnbt80lLz?=
 =?us-ascii?Q?d1G9KKrGaat71037BjyzEvlEqZV51BYPdDm0tiB5LiLbe3BATidugojTa/hQ?=
 =?us-ascii?Q?B+BVbxVtqmVW/1BF4AobwDSesdoyqXSPpmQIB91Qh8OmebOGIDjxEG2Sh7mi?=
 =?us-ascii?Q?M8zS8TDxSAxk3r8n/ilQXVq9A0XgtYmmTwDe3Tybi69YgMINDGXlIVYQhfXf?=
 =?us-ascii?Q?i+9iz3vi5mAdSWiPfbbSzz3MXRs28Xq5WpC4N6erJlYe+cn/1S0XuUVB6eW9?=
 =?us-ascii?Q?UPIs5o5ZDxJd1jhoV5CxByoWYF4qyH4o7c7kQZxmluo6wRfbG7UFD+bBZ47j?=
 =?us-ascii?Q?3lAXeFoiN8xcfaMlyvmpdBWIS6RPC+3+43OVi3HuotDH7TE+bEydmEDrNqRJ?=
 =?us-ascii?Q?xR7UXfBXTb2osYLT8fmHF7EQVP5S8q2rO8NpPLGsot8mTGuvmxK+CUAN7LeF?=
 =?us-ascii?Q?ZWqnAOD9Ch1ii1pbm5i9i6R9mhb5p5Wl/c82m3l4UhI3QPKHUucjfmsFr6pG?=
 =?us-ascii?Q?pPPXJ8sGHYwKn5svOxFqfQfEYzhoJPYRSF2nYNmabk/K8aWA71gIPlPKkQac?=
 =?us-ascii?Q?BZlnoY1VWr89TpcYCnG8M51fIWXflo92qrtEtIL+MV6opSZr/sBghmXdq54L?=
 =?us-ascii?Q?ODaW/SMgR3Cn9XzXAqh8OaaHJ9nIwjbE4RZ9VsNVz/6B/7C0TqqXu4Ilr6AR?=
 =?us-ascii?Q?E8HuljHrtkUOidfmsUNCDTdEIRR8mbWMEhAGdR7Ys+jqEBznpUzKYZAHBa43?=
 =?us-ascii?Q?1kp54ZkhxDGFnEikJi12w+MksMCIdmkNhQxL2UWz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f5c0d9-f933-4364-a208-08dc227204c7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:33:48.3750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YC5M9tKje33CZE0NcxACrFLCyRCAeX/XRGLOTf8EMfJmqkmJOmNsHnnmQ0O1nwdqJ6cLHIsJB/VmKOHx+MxpQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

On Mon, Jan 22, 2024 at 11:55:26AM -0500, Frank Li wrote:
> On Thu, Dec 21, 2023 at 10:35:22AM -0500, Frank Li wrote:
> > Change from v3 to v4.	
> > Fixed tcd64 type as fsl_edma_hw_tcd64
> > 
> > Change from v2 to v3:
> >  - fix sparse build warning
> > 
> > Change from v1 to v2:
> > - fixed mcf-edma-main.c build error.
> > - fixed readq build error. readq actually is not atomic read in imx95.
> > So split to two ioread32\iowrite32.
> >   It needs read at least twice to avoid lower 32 bit part wrap during read
> > up 32bit part.
> > 
> > first 2 patch is prepare, No function change.
> > 3rd patch is dt-bind doc
> > 4rd patch is actuall support TCD64
> 
> @vnod:
> 
> 	Could you please check these patches? I still have more patches,
> which depended on this.
> 	eDMA is used for cross whole i.MX chips.
> 		
> Frank

@Vinod:
	Ping?

Frank

> 
> > 
> > Frank Li (6):
> >   dmaengine: fsl-edma: involve help macro fsl_edma_set(get)_tcd()
> >   dmaengine: fsl-edma: fix spare build warning
> >   dmaengine: fsl-edma: add address for channel mux register in
> >     fsl_edma_chan
> >   dmaengine: mcf-edma: utilize edma_write_tcdreg() macro for TCD Access
> >   dt-bindings: fsl-dma: fsl-edma: add fsl,imx95-edma5 compatible string
> >   dmaengine: fsl-edma: integrate TCD64 support for i.MX95
> > 
> >  .../devicetree/bindings/dma/fsl,edma.yaml     |   2 +
> >  drivers/dma/fsl-edma-common.c                 | 101 ++++++-----
> >  drivers/dma/fsl-edma-common.h                 | 161 ++++++++++++++++--
> >  drivers/dma/fsl-edma-main.c                   |  19 ++-
> >  drivers/dma/mcf-edma-main.c                   |   2 +-
> >  5 files changed, 223 insertions(+), 62 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 

