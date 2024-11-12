Return-Path: <dmaengine+bounces-3717-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EB79C5EAD
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2024 18:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D581F23611
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2024 17:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2094214434;
	Tue, 12 Nov 2024 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GloFRP7D"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3512144A0;
	Tue, 12 Nov 2024 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431862; cv=fail; b=ALaQ6U/s5bQPvj5LyL5Dp7ec84ohJapD3VhtBC1HnusmPWx7ajqCKlu2HmGpGqVD7plnQld9x/DEsXF2k7ZRjxqVFZRaJz8C6iBUVcmeq+En9gDoK2SJtr2lD6cSkLGaYBoCvu43D5gvSZVhj86aVPGLvOTDZPbQGWBOQjnQFZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431862; c=relaxed/simple;
	bh=kDyDHar1QLlC7v+3wLIKhrLezbYWpXNMJxaIcxx/LQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=njxdTCKIgm0AhgXi7Vy0FGFYYwCOWigYWOlSm8C/apJhLsDgkobnp8JE3v3sf8bk2xNi1ytTNYMF0qUd2BkwrQkh9kThU4ZBSeqdD5vFYDthdfxoquolMyhvfSMif+LLkm61gFa7Ef5LH+NYmVQ7H3ngrs/I6pBzmV0g3aCf4pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GloFRP7D; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOa88Bc4PnkgeyYUjrAMGY/o44P629a3yriGee1SKr2MZCaRZORGPHuwmLUiczIZmpm3304A40VSkf0rdZdJSglgPidsQ4o6L47F1OifVYrlwkhSEOd3yAdovauVakvcZlE3GPAp67uwAjxKHXamwJZFceZ0Tr49T5OynPeoO+zxwFz/a81+TgOoWTBPoHcc6qqQFQygeHK8EUbQ3Gm5blaIMAf4NtMawfNNX6X82Fy7APmqzO7FyA/y37FgF13fwweJE67GO+WwxEyKIxGeadL6hVmkCq9elUwHbK666Fwk3HUNj2Rq4HBTGE3bdWXISGTXjVfEC1gXRMfmsYoDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDFQSMaRmvB8vN2fXu5MX16VD2AzyCVjydJ5ZBgfUsY=;
 b=Qnp9PHl88Vn7rY51dk4v3hw0Uuxi8wXyfQX14zhzGHD6EUrNcV+Xaxzvkb7f3DHKMHQZihJQTK9dUCkTqp3OOrWkpxxi/huT4YDx22hV02rhR5wfzZr1fNZqI80OgytXeuFJhxKGzlodxn2uvzf7E6XOWZ8JcKHuXPXVJsqZyz62It54Of9JkEwj4TpM2kNNl7eVSqE2Y5yofpd3w1p7cOvjKrTjBG2p7mDTuOjOT4wh6LxoKt+dRGgp6wtFWw03ENKYe7m+55b3ltx9Avllq6lNcEb2l4cJ89NEQOQECghuQk7i3wGuPRZ9vF7Go1eGhXIjkWeGNCSz4UxvgrABXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDFQSMaRmvB8vN2fXu5MX16VD2AzyCVjydJ5ZBgfUsY=;
 b=GloFRP7DozD+DlGAi5vrzaInHr+pw1Pa2HoN5dabvrQ5MWM9/0uLJ1pdiR6t2540K9uTvMhVG3ZIjnUorikFabTT4LJBgIw+C8iFaFu+IaEZEzgkfRg0NfTWIDhGJqmsglOPDLV7N9wqZSd1m/6TOxSNwSJr1bnjLCC4alXPm5/h2/WxCf/TOPNFIECOOJnKWJC6kjroFTsshTq8fCKKsuWWX+1/2BhZpMJAyAmMORbKRPKMdyxOV9RJM3Br6XcnPx3YH2byZXrw5SzkhCp0UQiE9h6E14z4bAHqHyivQ1CpqkHHYzAGUOTJYxgRIRhqDo6KEj+V9OruXC9osYxiiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6831.eurprd04.prod.outlook.com (2603:10a6:803:135::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 17:17:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 17:17:36 +0000
Date: Tue, 12 Nov 2024 12:17:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Vinod Koul <vkoul@kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE eDMA DRIVER" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] dmaengine: fsl-edma: free irq correctly in remove
 pathy
Message-ID: <ZzONqV2hTgTk7xiT@lizhi-Precision-Tower-5810>
References: <20241111072602.1179457-1-peng.fan@oss.nxp.com>
 <20241111072602.1179457-2-peng.fan@oss.nxp.com>
 <ZzItm7l9pGfrUSK8@lizhi-Precision-Tower-5810>
 <PAXPR04MB84598E5B79A7115A2540A5FF88592@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84598E5B79A7115A2540A5FF88592@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5caa6f-b816-46a1-27a6-08dd033de76d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A48tsTWho8rarWg7xZ0nm87N5cjwPoN1rI0xJi8tSLDvshWjsxu2l1h8d9kI?=
 =?us-ascii?Q?NJpE32WF3EF+Aq2N96lswNciF5gw/kRcYRNlTF7yRPRy/EkdXxRgAuT21+4q?=
 =?us-ascii?Q?fXxNd6KfYAcio25GrXtPGC1jU2ESpMovigZbMOSTyNtJsD/xeMT+3KzYQtWI?=
 =?us-ascii?Q?6NhPVzA8ehZ3wZ3xZa1DdHxi8plHu7MkDTQBZMEM1ftJw94p3uMFu67r9s7H?=
 =?us-ascii?Q?/yBP/pUez46Ab4Y/cOwipVCsNCkmkW9VZ7xQVSdpJ1rwq8wV0vUYXp4g+plI?=
 =?us-ascii?Q?4TjibHhJPASa9GY7DIn4+hLqtbXKMdxAUo+gEgYFqkvZMoWOQG60LSEFSgFb?=
 =?us-ascii?Q?59y18ufwx3H6+riy+G2CPMYsRRbSEQDpln77FGAIIGJtpSLMRDM/v+Hc1PQ1?=
 =?us-ascii?Q?N/pVPPNFbdtnI5oGCjNFyXzG/2+ptRbp9vTScMOK8hFjI3677jYIyVTNH2oR?=
 =?us-ascii?Q?ohIIRSmkSG7jxk3ENq5oUYXBHGGznqHyfob42dEUCYtO/rhOIP3EMLalFBT/?=
 =?us-ascii?Q?PGafR40K9ZPg5D/ju2HE3nq7jCjJcavv69Vx1+cuF3M+GPcbzLnHL0SeZ9oN?=
 =?us-ascii?Q?FMLD9YQw9KR0DL4bEmo7/yznyzjgq3SYMoTU5+HV5Y6zymWBtUZJSYY4PGT/?=
 =?us-ascii?Q?GsHguaSWjA+q+CNjXnI9jFA/LzV+8/mkDs6d3JS2Qo5BxlhevYuDCBadmFSV?=
 =?us-ascii?Q?CNqxV/zauNERa8q7vHcc+f68gcQOQXzIEMEnKdiZTDz4WtSJe3/sCY3OoyxI?=
 =?us-ascii?Q?3WebyAou3Pq4Hxu3bYCy5rXfQMBDSXLpV0rIsWblIUYJI1Y/gFGzdco8PNzq?=
 =?us-ascii?Q?sFjAoakM30OXi7VixwR//nH4Y4x1Cfjutr/NGgYpw/MKnxRpbH7MKSL9mE9X?=
 =?us-ascii?Q?ORTltByN4i+9bXVu0imNu/SAgX83RItDunKb7PmaVl182QeL3ofAmXuU2a5m?=
 =?us-ascii?Q?dRDtSOY3IYKT+uABuFHtWzpGwq+G5mNiUCux4wPRCxWUhrQs+G/J7iWizGHn?=
 =?us-ascii?Q?A1knTOmVJVC42D7NZJtmuBHHTsPKEB71e8ZSwlgDYdGDoP83yv81aSBZwWfv?=
 =?us-ascii?Q?6+AnqrrAo3UP+gNRxlHqXeegkKmKjKQNrX1F7lVTWru61Qn053mngLnIFVFJ?=
 =?us-ascii?Q?yP6u3GlDt3bgNWku2pqSPAxXiS3s/88qDmvVkb5ZTZ0+RC15K9tt7rwyvi53?=
 =?us-ascii?Q?XWu4rLqFBqpxGvDDxogsBFWjhVjq833+VgtkMrAlCKItfynOY4Xmz8bqgAUg?=
 =?us-ascii?Q?EuWJURItbED1Nzj+IcyNuPx7dvbl/GRCWgCizScUio6+u1qz7ryrVUB8jRDf?=
 =?us-ascii?Q?lapR/ehFS/LPKgJQuEXd+MLnhsWAOqQe4iP9bGdJaf7Ni8Pfrpduml7YAIUv?=
 =?us-ascii?Q?HbjNhGI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ERE9PBTXSq2ZMYkVND89zSahnYEAvyJ1d3UtsDhLTWy6K7fIjz7d0PEIZZJ?=
 =?us-ascii?Q?9+9rj/IoOhUhGACUagjKyBaGIAdkBIhbaz6zgyPfkxjhkBbtckucDuZDLwGJ?=
 =?us-ascii?Q?QXjOe/2crg/vEiUJOdp/0g9MRDAlQIGahFhAcRVVPRODQlXo2BlKFPdtFoyS?=
 =?us-ascii?Q?O8oOSgjqmgUWk/KjvDihHLsEtuDvrjmWlPiWIV3BovFxs2s0k4ULI1Rsf2mR?=
 =?us-ascii?Q?50eSb9vjXJsw3dhPMu4Bd0bNvxG4lv2a+k+p7+8CTEUZUzB0VJT0RfbjTBUB?=
 =?us-ascii?Q?bZfOoWA9d4SJypwINoj9C9tJGdSYDKgDZFgVo3+2h2YoWzuWd1IXT2AjFHxK?=
 =?us-ascii?Q?WNNm9PYWeRw6odylmlurw8m0Rv5B/yZosaN3XFvTy+hUuN68ZEsw9IdGKXYY?=
 =?us-ascii?Q?Aw+kU1jvq6HOFv2jnl40ghwOPreBp4IfSUjL2a+QPdAhfUfrDNucxdNT3T5x?=
 =?us-ascii?Q?Hys3z6TiEhivoabhw9+pwrnF9AXmLCpSt1ISoz8ZEuF5fw9jwD6j1UTiZVqq?=
 =?us-ascii?Q?3Ib1BmVMqe9mPhIih2+3YahKJRy+sE78/8VtV0O0Zh35SWvMF1+RhnvLRdcb?=
 =?us-ascii?Q?IE9cMqjUitgCa78dAwJQpJrCcChxTYn2MzdeEsjVNB4aL2dLcMbDOIs8uUst?=
 =?us-ascii?Q?XMRO9llaVv02u0N942uAqTr3xHD3KLSSCxj0MY/j9NPVLkrdgzyBUG2aKXG0?=
 =?us-ascii?Q?qS6+Si3OKiVdYywNF1nZov3IQsWcvt4h98sYrMIjdpGgsGNrTkHabHTCCGPn?=
 =?us-ascii?Q?BIZrXIYclgGPic3uMR23sOOzEISZir+AGgox+EEQb1ytfz378Cv7EawzySli?=
 =?us-ascii?Q?/DwfPm29xLtidbcrhPakuskaOZHn2vBatb+rdUchaG18zj9GpaUexEAiANyR?=
 =?us-ascii?Q?hvG0TY/sfGZ+bKiID9+1C640wpvZEE/rqyqr6CCTqeg/ZFehQgY55MkMuVf7?=
 =?us-ascii?Q?cDwmVzIstqLGBddOETNeXdRLP0zfkzt+58/ZWfvC8aOvdtqhOMo85nH8obli?=
 =?us-ascii?Q?BdhDj5FrcxMjH/Q60s1+P5m7CLtFPHoHPsF+536UfcY8JUSXWOSKa6u7Um0F?=
 =?us-ascii?Q?uyUV37WvCIBRBBnsusAmbprIqen7ojWRnvhX83prQYVqs9X1gn9TR8A6ERE1?=
 =?us-ascii?Q?aO0YmepwvuT1LV1xqELNp/SSWaw5WevWpjgQCD+a2mwal90roA+2z7YegtHu?=
 =?us-ascii?Q?H5O8ifBPZnHEftzNhuzhPSis5x5YtCt/tm5lnifn84ud+udlG0Q7JgjgmtZ6?=
 =?us-ascii?Q?xfEKPgffTEiVAXuN7JiuVX7ku1x9OEQ2EzpjYUirVKYmOue2lhDPb1bUeXpk?=
 =?us-ascii?Q?g8vd3owig+LvH5RQBpXOeaJG0BHAXKQwohT0SUvMvYnnmF6N6eYvnpGvrFY+?=
 =?us-ascii?Q?qHA5W9Xa5Va8Aqp6e0sEvx43nYpdb6lxW5qxRqGEa279+TkJpFk+oajMO+dN?=
 =?us-ascii?Q?L7GfKxi6WJXHG2EHmJChcllz2TB45asvv+5jJo673auPHAYfpJTUDuJMj/PY?=
 =?us-ascii?Q?I/mhizzqaDPlRbd3SW03xVMYwJi/bw9bw0fdWaHAOjnkzqLoPIfpv5gbTyem?=
 =?us-ascii?Q?tghzynFt/1H2sUY4/ng=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5caa6f-b816-46a1-27a6-08dd033de76d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 17:17:36.8988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFY1o7+9qFnxCrhveV9tPV3+iSV9w1kVRmRbzplE5OmidzLi8mjQckIi8kRUQtAMoxpYxEZ4OIondIoZWUFViw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6831

On Tue, Nov 12, 2024 at 01:52:41AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH V2 2/2] dmaengine: fsl-edma: free irq correctly in
> > remove pathy
> >
> > On Mon, Nov 11, 2024 at 03:26:01PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > To i.MX9, there is no valid fsl_edma->txirq/errirq, so add a check in
> > > fsl_edma_irq_exit to avoid issues.
> >
> > Nik: can you add descript about what's issues?
>
> It should not free an irq that was not requested. So I add a check here.
> You wanna to me to add the kernel dump or log in commit log?

Yes, at least need descript the issue. such as
wrong free the no requested irq...

>
> Thanks,
> Peng.
>
> >
> > >
> > > Fixes: 44eb827264de ("dmaengine: fsl-edma: request per-channel
> > IRQ
> > > only when channel is allocated")
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V2:
> > >  None
> > >
> > >  drivers/dma/fsl-edma-main.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-
> > main.c
> > > index 01bd5cb24a49..89c54eeb4925 100644
> > > --- a/drivers/dma/fsl-edma-main.c
> > > +++ b/drivers/dma/fsl-edma-main.c
> > > @@ -303,6 +303,7 @@ fsl_edma2_irq_init(struct platform_device
> > *pdev,
> > >
> > >  		/* The last IRQ is for eDMA err */
> > >  		if (i == count - 1) {
> > > +			fsl_edma->errirq = irq;
> > >  			ret = devm_request_irq(&pdev->dev, irq,
> > >
> > 	fsl_edma_err_handler,
> > >  						0, "eDMA2-ERR",
> > fsl_edma);
> > > @@ -322,10 +323,13 @@ static void fsl_edma_irq_exit(
> > >  		struct platform_device *pdev, struct fsl_edma_engine
> > *fsl_edma)  {
> > >  	if (fsl_edma->txirq == fsl_edma->errirq) {
> > > -		devm_free_irq(&pdev->dev, fsl_edma->txirq,
> > fsl_edma);
> > > +		if (fsl_edma->txirq >= 0)
> > > +			devm_free_irq(&pdev->dev, fsl_edma->txirq,
> > fsl_edma);
> > >  	} else {
> > > -		devm_free_irq(&pdev->dev, fsl_edma->txirq,
> > fsl_edma);
> > > -		devm_free_irq(&pdev->dev, fsl_edma->errirq,
> > fsl_edma);
> > > +		if (fsl_edma->txirq >= 0)
> > > +			devm_free_irq(&pdev->dev, fsl_edma->txirq,
> > fsl_edma);
> > > +		if (fsl_edma->errirq >= 0)
> > > +			devm_free_irq(&pdev->dev, fsl_edma->errirq,
> > fsl_edma);
> > >  	}
> > >  }
> > >
> > > @@ -485,6 +489,8 @@ static int fsl_edma_probe(struct
> > platform_device *pdev)
> > >  	if (!fsl_edma)
> > >  		return -ENOMEM;
> > >
> > > +	fsl_edma->errirq = -EINVAL;
> > > +	fsl_edma->txirq = -EINVAL;
> > >  	fsl_edma->drvdata = drvdata;
> > >  	fsl_edma->n_chans = chans;
> > >  	mutex_init(&fsl_edma->fsl_edma_mutex);
> > > --
> > > 2.37.1
> > >

