Return-Path: <dmaengine+bounces-1034-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 056A3857FF7
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 16:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260771C22858
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6718F12F373;
	Fri, 16 Feb 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W5vs9+uo"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527D12F36C;
	Fri, 16 Feb 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095621; cv=fail; b=BxjmsMe3q6m2kwMaow/yQym2GpxEdkof8qkdjLLvYimC3dfZ4VTS0SQ9zTI2bTK9Hk+9714KW14r4pt/AK5Zo0MHWj12zO65AfM1iGykcF6vt6/wJ/HupOzGZz6gvtEOMiNxvm9cJbQsCpExvxDTKgvgOeN9Pdqj+mlYZzKhrKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095621; c=relaxed/simple;
	bh=MaSA6Vc1UWaEU3RXFZiTQGhIl+wPmjSdEn/3a47JyiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z5tK8J5TwJE8yNUPqt730io+9HnauoYpODnEIx8z5U4Vxmhb0JR4Q7jdHRsZl6ASX3B31J37nkRX8oLF26RsMEcpgbQu17xI1a7JDVE3w/a1RTxz13QBgo3I9zKa4VE+Ox/y81Mc+WlJkoNzGNk1ZCQ/Zyw/siJWKcfzWTKUKHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=W5vs9+uo; arc=fail smtp.client-ip=40.107.6.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h03nQg4Dc3WxUAkOe1kZzsJiEiZJpMJEYXYylRwMReH2ETO7sMNZiRAfJYBxBRck4nW60fpiob5dVIuF+j7DQv/w5NyHR9uwjCkQYmhGTgJPaRUg2xyvgULRxNAAz8VjAD/v1wTD/5BHrBjmGt69+5zk1rzbr9+UirK0JNzgHjf987fVkLcsQgGjD+guTaC++BCKB+9P0DrsDCtqSaG0IcGXCwHJMDAtOQaNNJKHz87BWnmEsLSrfkFVZhgzv59I+ZSiuC+nzxfStxsxK13vuKfamH4WgoKw7/FRBMQdkeNTrPQq1eMNaXqDZBYFgi2EHMWR4fwYRRds7/59d5+n4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utx49Jwe8hW1w8hFoRzOoVXaUW6s4tcYlg7R/mZMxpA=;
 b=G4sjDx+q9tt4vcwcp037Vl+PWg3h2Tjr1w9vxppW5W4FUYp9lDQMY25e6EarlXI9QRMyUimhwcXJef8TmF4wXc53h8tB8t9awR+61IRn20486aEbgJiQ0D6R1l0IKRqywR3JMmCHVfL+AnobZPzyV347eF8sDGh8oUJmtXm/+yHe9fBjAaOHgVJqQW/M1v8cJzhvTzaaQgh2JIFjFNnzH84ZnQj4n5u5fYhR9GqffnHwh3VfsJaD8uRdbEvrsZ08BsIg6/FIl38RByZkNQ9URItJ4FubvLnejo34RG5EHwmN7xJBa0gaE5E++frcNYnzfwaMGSalMJp1XS5RlrGqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utx49Jwe8hW1w8hFoRzOoVXaUW6s4tcYlg7R/mZMxpA=;
 b=W5vs9+uo1c9SZhaidqL6cnWW0QcSwPbwvdFB4qaMXGwwLlg1BQTzxdPA6wYijyhEVT/E7u+SVEVaTQh3/9/0kvu0izHeFB0u+tHExWYtjn8lkR56gMQYJe5h9F53jJzrYWhgF95Rfsy4sC2R/bUFYV7tHnqh/PI0vF+x7mvTd2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Fri, 16 Feb
 2024 15:00:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.027; Fri, 16 Feb 2024
 15:00:15 +0000
Date: Fri, 16 Feb 2024 10:00:08 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dmaengine: fsl-qdma: add __iomem and struct in union
 to fix sparse warning
Message-ID: <Zc94eDQf77fyS/k4@lizhi-Precision-Tower-5810>
References: <20240209210837.304873-1-Frank.Li@nxp.com>
 <Zc9WGbgscNeqmuvk@matsya>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc9WGbgscNeqmuvk@matsya>
X-ClientProxiedBy: SJ0PR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:332::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: fae122ed-8f75-48ea-41f7-08dc2efffbd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w3gcxfsjTRWCHsZFFNVRZrQWrRVkdVTR5NFLZbf4Bf3ZhbnbArOfEt7Zt5iCK4jZGzjk8aXJl1zdXDKaklZ9G3A6x40sB7/WXMl56IzYBnVANBhMEox//67dPT3719mOVF/zDjw0Igh469UmxwSg+TmhvNdKYVCESD1NxdSfgeSLkCKj3pa7GT/bdLXrEybF5kYY3OSYl+n94JqkxE8HGZp734WynWPpgAtp6WD9/6mfRPLPTPbDrM9c0uLUHukhjekS7g8a99042yC8wf0YVEKaOIbnTB1zW1rSX9STXi4PQwnihBMRXYe8qvYF9Cq8zHXzDd2dEM9C+SKr24rP2HRgYoGfCtapPaZTxE6LNvr1ZS4TKF3hSIHrOO1bznKJIP3ONAB2ctVP1oTymxHzjIjy/HJCKmhghv3yvC4N9RHCkMVdcw0vkYYuhoGTZRB9ATQeww73ARSRCG/B9MtS+WmSedIW3cxS3/b5bEw4IJmp12xwhiKtKhrGfCwsYyBebgZg4o6n1BWR0yefPf+aIvbfnzWOn7Gy26YorqCYqr5jHwdjzqEbDpAXqbhZMO/VMFMYydHd9swK8ECjjOUHmSoLIjcwiybcEBKx+LPYV3w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(376002)(396003)(346002)(39860400002)(230273577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(2906002)(8676002)(53546011)(54906003)(6666004)(41300700001)(966005)(52116002)(9686003)(6512007)(6506007)(6486002)(478600001)(66476007)(66556008)(6916009)(4326008)(5660300002)(8936002)(316002)(26005)(83380400001)(66946007)(86362001)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q+EaZzv07XPemZKAGYxZfI3E7N4oS7PU8MWffzoWXhRMc8hMUnzZHjfhb52t?=
 =?us-ascii?Q?C1yrHhqFyrQWAf1HcKh8skbOlWYjWKmoiDTUG7LCwz2JmYp5mTbtRz4Nmjoo?=
 =?us-ascii?Q?084NuxPp/z7tQBqeLRcif2ac6fYQemDNDC55mL2MkZ5hBvXdSo2/QFQua+Id?=
 =?us-ascii?Q?8ixBbPBBlpyP2b1eLrUcZqO5ha5TKI9v0RMNH09Po0VVwYQgUkMKmdGHBsmR?=
 =?us-ascii?Q?tYSRiH2dMEl/fRXIzW4mCONC0PpwGWiSVzpGH+KEuyp3oXkHJ7Q9/6b/lk6I?=
 =?us-ascii?Q?6eLXws0rWQnj3N+6c7Q2kNCt/5pKLXhaRZj/9OKPGOHKg+5NlyeKv8JmP3ln?=
 =?us-ascii?Q?2WqOGgg9Iklgd6Or5nZlfPIXAgPNdXzKdCxc9DBq/H8Wt+oltkslhTyPccCE?=
 =?us-ascii?Q?lF9NZxPFMaEXNExvUOGPRiVS9IzXeTyACHpRSr96uhtsEhDpcJqyS+ZlbCWm?=
 =?us-ascii?Q?eHvq1+AHOReHaLvNlMSy8uKPJiTbRU9Vx4Gs2pQiaUnK+X2OM2t64yMkuePy?=
 =?us-ascii?Q?kikk0+/9IvuLSXyRG9UDRPsYNWpruYiYIJIflr4Ad5StmIoVNO87SB1uchQW?=
 =?us-ascii?Q?F51/OqXgCsjAH5sSDS5tU7LPYZoQknhK3kWIDjhRdKmrmZaQrbEp7hK0AZ4D?=
 =?us-ascii?Q?i9VcRTnYUko6psj7eMeSuvQgCN2uHWFUge6NGDME3g8VSrGrB2jrgeHz6o7t?=
 =?us-ascii?Q?aYaiZoUH/6Kw4KW8W9hO2VU0HQi3gOT6XMAdcpZAplJGmTH912xivEDneGhR?=
 =?us-ascii?Q?G6i0nVvwX8MW8yoEI4Lym3VJXwR8f/bMC3TQpOxXqjRXwKuAB94WwkF8FzMJ?=
 =?us-ascii?Q?vUIet6TNdOmmhEfrAuYvSJ2CmeLSa0zmTGtVdI7gIbFEwxLchMeh9dd7gsro?=
 =?us-ascii?Q?XqIgeNckpWIEGnliy9cDTbQPQXW+370vT7Gig3khh3k+liTV7o0PJnSwnVzg?=
 =?us-ascii?Q?XW6fgZ4KCMF8ZtdruF7EafvQeAAiEuK/ngsnCQB5xTv/QHH9YAw78qxwgjuA?=
 =?us-ascii?Q?HXwjSWL27BP1MR2LukIzo+WCx3xcN/shD1RglZG+Z+atTeqRxDUfdtBHUClG?=
 =?us-ascii?Q?5lMcyQx38Umal5QNZUXl6TnmDFGPZmhAKNcmjQ1lnxHZ/k8uI1vsTCcX228w?=
 =?us-ascii?Q?UmpSpvu+UyVebgtzfFRZtQtT89Jwj/yLKGwB7FvjTy2eWM4yEgBJSYAr0Cb3?=
 =?us-ascii?Q?GQ2RwIjn0Kp7nTBew9WXHylRzH0opDAaF945n+tI1hfLsdz847hhsAjAyB8C?=
 =?us-ascii?Q?FY2jF/WNlbpkrSJT5molQoT5rgrYoosrYVA/dA87dm3qJ8Dkh9wZIXTxMqsL?=
 =?us-ascii?Q?aU+NtR3f2ubNa6t8239sxZZXOos6gj8f/GP97gFU5QCZ5GfyezFVkGjn+Osr?=
 =?us-ascii?Q?u7m+TzkNDJKeFsMxBAF67CyrJ/8qFagaidyCpT0tdVC6qBI0YJPBqsH0W8/w?=
 =?us-ascii?Q?HFLqmRroYu+a+4AZq++jEQJ7vedZRboIgn78kOskBgU9+Ep2gh3cWwyhBlyS?=
 =?us-ascii?Q?Riri/vaU2CzeGEu6qTrsdOLHRzF31FglC3Ai5N/cJmXJq6WW2qM9CCEjFJQq?=
 =?us-ascii?Q?WU4z5bspyQSoKYdlrnK+sH8JZoprqqABC9vVqYG6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae122ed-8f75-48ea-41f7-08dc2efffbd5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:00:15.7529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raTBpeyilJSoApW5cd/3vqw4tx6zwpGY0ILcu9mAktiGpbbz7NaVU3od1Iiw1pZLmniyvAH1YZS1JVjPkEve6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689

On Fri, Feb 16, 2024 at 06:03:29PM +0530, Vinod Koul wrote:
> On 09-02-24, 16:08, Frank Li wrote:
> > Fix below sparse warnings.
> > 
> > drivers/dma/fsl-qdma.c:645:50: sparse: warning: incorrect type in argument 2 (different address spaces)
> > drivers/dma/fsl-qdma.c:645:50: sparse:    expected void [noderef] __iomem *addr
> > drivers/dma/fsl-qdma.c:645:50: sparse:    got void
> > 
> > drivers/dma/fsl-qdma.c:387:15: sparse: sparse: restricted __le32 degrades to integer
> > drivers/dma/fsl-qdma.c:390:19: sparse:     expected restricted __le64 [usertype] data
> > drivers/dma/fsl-qdma.c:392:13: sparse:     expected unsigned int [assigned] [usertype] cmd
> 
> Please document why you are adding the annotations

Okay, I will add at next version.

> 
> Also I see this after the patch:

Strange!, it is difference driver (fsl-qdma.c, which will not touch
fsl-edma*). the below warning should exist or invovled by other patches.

Did you try antoher patches
https://lore.kernel.org/imx/20240209213606.367025-1-Frank.Li@nxp.com/T/#t

what's command do you build to see below warning.

Frank

> 
> dmaengine/drivers/dma/fsl-edma-main.c:56:16: warning: cast removes address space '__iomem' of expression
> dmaengine/drivers/dma/fsl-edma-main.c:60:9: warning: cast removes address space '__iomem' of expression
> dmaengine/drivers/dma/fsl-edma-common.c:76:15: warning: cast removes address space '__iomem' of expression
> dmaengine/drivers/dma/fsl-edma-common.c:93:9: warning: cast removes address space '__iomem' of expression
> dmaengine/drivers/dma/fsl-edma-common.c:100:22: warning: cast removes address space '__iomem' of expression
> dmaengine/drivers/dma/fsl-edma-common.c:101:25: warning: cast removes address space '__iomem' of expression
> dmaengine/drivers/dma/fsl-edma-common.c:104:15: warning: cast removes address space '__iomem' of expression
> dmaengine/drivers/dma/fsl-edma-common.c:106:9: warning: cast removes address space '__iomem' of expression
> dmaengine/drivers/dma/fsl-edma-common.c:131:19: warning: cast removes address space '__iomem' of expression
> dmaengine/drivers/dma/fsl-edma-common.c:137:17: warning: cast removes address space '__iomem' of expression
> dmaengine/drivers/dma/fsl-edma-common.c:140:9: warning: cast removes address space '__iomem' of expression
>   CC [M]  drivers/dma/idma64.o
> dmaengine/drivers/dma/fsl-edma-common.c:473:17: warning: cast removes address space '__iomem' of expression
> dmaengine/drivers/dma/fsl-edma-common.c:473:17: warning: cast removes address space '__iomem' of expression
> 
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202402081929.mggOTHaZ-lkp@intel.com/
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/dma/fsl-qdma.c | 21 ++++++++++-----------
> >  1 file changed, 10 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> > index 1e3bf6f30f784..5005e138fc239 100644
> > --- a/drivers/dma/fsl-qdma.c
> > +++ b/drivers/dma/fsl-qdma.c
> > @@ -161,6 +161,10 @@ struct fsl_qdma_format {
> >  			u8 __reserved1[2];
> >  			u8 cfg8b_w1;
> >  		} __packed;
> > +		struct {
> > +			__le32 __reserved2;
> > +			__le32 cmd;
> > +		} __packed;
> >  		__le64 data;
> >  	};
> >  } __packed;
> > @@ -355,7 +359,6 @@ static void fsl_qdma_free_chan_resources(struct dma_chan *chan)
> >  static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
> >  				      dma_addr_t dst, dma_addr_t src, u32 len)
> >  {
> > -	u32 cmd;
> >  	struct fsl_qdma_format *sdf, *ddf;
> >  	struct fsl_qdma_format *ccdf, *csgf_desc, *csgf_src, *csgf_dest;
> >  
> > @@ -384,15 +387,11 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
> >  	/* This entry is the last entry. */
> >  	qdma_csgf_set_f(csgf_dest, len);
> >  	/* Descriptor Buffer */
> > -	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
> > -			  FSL_QDMA_CMD_RWTTYPE_OFFSET) |
> > -			  FSL_QDMA_CMD_PF;
> > -	sdf->data = QDMA_SDDF_CMD(cmd);
> > -
> > -	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
> > -			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
> > -	cmd |= cpu_to_le32(FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET);
> > -	ddf->data = QDMA_SDDF_CMD(cmd);
> > +	sdf->cmd = cpu_to_le32((FSL_QDMA_CMD_RWTTYPE << FSL_QDMA_CMD_RWTTYPE_OFFSET) |
> > +			       FSL_QDMA_CMD_PF);
> > +
> > +	ddf->cmd = cpu_to_le32((FSL_QDMA_CMD_RWTTYPE << FSL_QDMA_CMD_RWTTYPE_OFFSET) |
> > +			       (FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET));
> >  }
> >  
> >  /*
> > @@ -626,7 +625,7 @@ static int fsl_qdma_halt(struct fsl_qdma_engine *fsl_qdma)
> >  
> >  static int
> >  fsl_qdma_queue_transfer_complete(struct fsl_qdma_engine *fsl_qdma,
> > -				 void *block,
> > +				 __iomem void *block,
> >  				 int id)
> >  {
> >  	bool duplicate;
> > -- 
> > 2.34.1
> 
> -- 
> ~Vinod

