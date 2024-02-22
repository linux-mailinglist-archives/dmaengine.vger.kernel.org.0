Return-Path: <dmaengine+bounces-1075-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D4F85FC48
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 16:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7AD1C24022
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 15:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB93614D42B;
	Thu, 22 Feb 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kOjpaDuq"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D51C14A0BE;
	Thu, 22 Feb 2024 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615516; cv=fail; b=G0GKsZWpYk+bixxonBceI8NVLjCTyFIlWCdVKT4+Qac+3EUs5whNAo0hHsaMBfNQUTDPDRtix7YuUxMA2PsugFFSrkwbtm8vf1LolVFffCcWMu7pc4bX/WAC/Yxb2X+QDlQJF4nYTftssQMpd1ZR1TqVkxyrq8s6W2vr2pTAmVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615516; c=relaxed/simple;
	bh=MOfKgJfdKcmDfxWISs4ZlXKwodmu6I/cg9/j6O++3Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gDyo8Ks9GW1F87vwanC9rkpYkEUHq6mmhJS9H6rfPCHAMK2h92aDF3T02qoNZ+Cq99uzL6wwCjszjFnc7Gdy7B+MskMgsSfZrdp2evxpsIH7l+TIH4LNuIiKYTG4TXHV60B5XWEdKHwH3lCADbFyKfvYTgWsk/J+HBaBRa+o0Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kOjpaDuq; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC8wgk96sBr7paLunmteUZZXmvCEM9JOmjbMMKDFJvSadp9Et7CT08GIXiKI4UqqHabS/TPFmCy9TtK9lUteoq89GN/bSJnPpzz+CODhlUqQmzXOY7rIh2O6HUrdIGl/YQm3zqKO8X5q5Xmm/ogbsGy8SwwDnZyteCwzx48tJwg2Qi34umm2utq7pMVCX5Neb8LPIf2fU7bnvvrJLm7tGZpklhe1Pv1CPo++5yvMGXfCF0q7/QY2sATEO8fBUZ+yETqKnT7ICTUY2ofy6aileacZTOuGZPoV7ulbyPgX8DU4Url9BA3A6hHuHATe2b0i8tppONBWTn9pJ+uZZ/7t0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0ZfXFodBmqU5uYzcAquknMAdhTGkUtF7UwyDC9iPHE=;
 b=Lj5fmqbostdUTH/Y91xUnpkxR8PQJXDXvw/gifyt7DemaygMOoO7CKPpj/UoTEZT4o13P2Nhrv+K+UiYKjBNU/qGt08mIkhoAiZtaLjVHwHq32ib5PlLmf0WPVuBDd6vS1A3X+i+Oyr05bg0HQfylGBjlInINx3wVumSOOnsZKKbqT7eMyqDMJ4paCy2zyZpZE4uOigkpLaychmbJGxLTKpsGDaI/f30UIl189CKZeycKT9wGeXO9Co/goZAwy9J9om5aahpqodiFAbPdif8M2AFvGdjSj2RMBzR3lbkh90y/5jSiwq0WcaMjZtZTwQ1RvcCrzFL/HZ59oRYxaLRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0ZfXFodBmqU5uYzcAquknMAdhTGkUtF7UwyDC9iPHE=;
 b=kOjpaDuqtxpAQ5rxwAjHFOWApkCjgKpmitCIzoA5E4v9oECt6WQwzbpKn66kiLMfI6V+oR2+iqkXnqaOHFr1LVBJFy5l2vv9Ch6FqN58mNfMMVu3qPG8C+O6AM8yhgt8NpYPPZlhM1WAWfzMsdYrcizglpBpSmSSXEaDv6Mo/mY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7253.eurprd04.prod.outlook.com (2603:10a6:10:1a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Thu, 22 Feb
 2024 15:25:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 15:25:11 +0000
Date: Thu, 22 Feb 2024 10:25:04 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dmaengine: fsl-qdma: add __iomem and struct in
 union to fix sparse warning
Message-ID: <ZddnUPjrsrMb7ooJ@lizhi-Precision-Tower-5810>
References: <20240219155939.611237-1-Frank.Li@nxp.com>
 <ZddTmwh82K6biJSx@matsya>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZddTmwh82K6biJSx@matsya>
X-ClientProxiedBy: SJ0PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: d988e645-da86-459d-f210-08dc33ba757c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hGabDC48yYlSaVOH1fIMxKGjm++N6UB+Kv/wFtimi+3g9jM2wS/djx4mJO75vN/rpcjh2FJewtGOWTFeE/Bmu+yI/1GBRWuymmKDJY7QZ8K4aNWZkyp+vYf5LbRtIryshl17qCFNWrC2onM7jFo58DTp3sM1/JaVF6v1dckDJUkDPfMeh32MXRhfeGy1/FZIPit75WP0P4ToGpnO4R7ESMsNj2zADlGAsqvCvv9HN/IgfDWRjnjc4f7n7z4GkyO/r8sJ6myCDpAAiB57Sa03kkDuKG0gSevI4XteCT0EaIGp4JvmXVsEGt4X3Q5WLWF7B9u6KYzeNvIaX+0vWMuI8UOKYk3+CR79Bheoc1bICuDd1s/9EPewDrGNI7J0S3OZDG76m0DZ2KJj1Jzm48xj+OBXvzRUqkGnCP84RAXfF/7sOPNMWAHPWuu/9gZRj43bXL06qBOlYjWwp2VXIGLB/1TvyaQyZi02kOO6P7+q15PO/qVfUKtl3ePdrNzofiWcoo/tnEhVC1vpnRhHZwq1dXUbk0TMGRimbASRVdD7iaa5ErR1F5Bb1x/LPLbwFum31k191g9Bih1NA/1XFnKzhI4PpHCf/z8zJ1b/xOKwOAU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2VkVktsOUkvU1lBRmZEVmUxcUZXRmRndzYvRkN0ZnZvd2JjK0IvTnlNY1VN?=
 =?utf-8?B?TWY0S1c1VzBhd3ZEdy9RTTJBUVJsdkNZTXZ4S29nY2RmK3ZGWERSWW51QW90?=
 =?utf-8?B?ejlONWJVeDZnT25pWGhVVTJldFpXbElMaTVsYzlkcEdvZEpJeFcwY2ZyVE1K?=
 =?utf-8?B?Rm0yNXpNZ3d0aDdLSnVnOHJ1aGFoYkpEa0RTVnhyUVdTbGtuckhUekZxYUtk?=
 =?utf-8?B?YUR2ZURrWjJXRkhwcFJxTU8wL2NFSE1VV1pkcjMrbitiUFV6RUI3bTk1OXp4?=
 =?utf-8?B?UWd1elNwbndUQ2RXenlwZWdqeEJTaFlwcVJ6UStZaVN1N05SRThZZlh4Z3lB?=
 =?utf-8?B?c1Z2UlVDWUtVSEEzSnhmNWRVK0ZZa3hXMlVibXpLdmovZUJTaSs5b2VaTzNw?=
 =?utf-8?B?aXp4dWxKbTdLM2xWL212amVlMG02c2dQakhtNDZhMklYdHRHT2ZYK2RiY3Np?=
 =?utf-8?B?K0NRclo3K1BWQkp5SnkyczdLNnE4YVRJWWtLZUNCUGpWZ3dYYjdRMnUzeXRj?=
 =?utf-8?B?dXEyaCtDWkQvYUFpQjdzeVgveTQ4THZWNU9xSUlzN0VWS0hxdldlcE1SZHBZ?=
 =?utf-8?B?VWJiYUZ4Q1RReGQrSkhoazdDemx3L2dLZ2VxWW5mUWdxdGg0L0I1b3huMGcv?=
 =?utf-8?B?a3NPdXlpbVVrVmxuOExIWjFNcEpvV2NFdENyT1Zkd2RjQkVqQkk1TVdsYzgz?=
 =?utf-8?B?d2I2QWpKTnluRFErei9uaU1qZi9pNHBhVVNGa3VqaFlRREk4aDBjaGdGWWFF?=
 =?utf-8?B?VFQ0RkJhaGpmeEcrdTJwNDN4WEdIVXJHdHRoR0pkYVdaRHlpQWpseEtoSERw?=
 =?utf-8?B?UG1sNU9WRkNMeHBPbnVuVXJGeDZjTnJBNDVkR0JqNzBiU2RSR08wZ0RESXRM?=
 =?utf-8?B?WHVzN1BLRzlkelZnMWlpblZ1cjlXM1ZnUGRvTWE1S1ZsSTVXbml2VDNGRWdN?=
 =?utf-8?B?S09HbGxnZUZHNno2cGpNdFdpQlZ6WVB5RFFKNjBVdDFrcGg2SVFURWpQaG80?=
 =?utf-8?B?UUUzK3BYUm8vVXpmTGlwQlRzanpTTTVkQytZZFFBcEFsWXF6Um9MTzFickhH?=
 =?utf-8?B?Q2VnWmo2SXltRGFoL3dXUmlWY09HMmVRMm5HQkJJR3hGMlI4U0ZOaUk0cEMr?=
 =?utf-8?B?SzJPSUVTb2VPa3loYnFXNUcwWHZVa1Rtek45RXlnVEtpVXM5QVh0c2RzQ0RJ?=
 =?utf-8?B?MFEwb1RzWDVIeFFpNmdHRVVzQ0pZTWdBMG50aXV1MXNTTjRBdEo4QmRoV1h4?=
 =?utf-8?B?TzNuOFBFZFBJMDZPcXdrcmR2MjNOb0gwREIwWlpxWC9TVFJWNHJ6S3k1QmE1?=
 =?utf-8?B?QkZzc2cyYllmKzZ1VE50T1pjT29FK2JkUzF5VzE5dGYyRDZVRGZqS0hEN2sy?=
 =?utf-8?B?QU5hdVpjREwvbnJtaDQxc3MwYVhZR2lNVUxGSldRZk55R1Jhd2I5VyswbUlR?=
 =?utf-8?B?SUhNdjEzdHZlZ1J6cDBKZUxTWTBGRnV2ZW9OS3ZIRHZTb1AxUlpOWU51azYr?=
 =?utf-8?B?YTlFZ2RUbnNleVZvMDZid01jalpuT3Z2cnJ2TVpyRTYzb01jR2lUVmlzZm9L?=
 =?utf-8?B?YWVDM0txU3hFeFlGYUZVZHZ0YlZkUGJYdVdiYVhrK1h1RzNHMGFFVFF5djFo?=
 =?utf-8?B?a2Y1MlRFOUNWWjZ2K3IzLzNFQTJCMWdmc21GdjVOTVd0NGp1cnhSZVAvdUU5?=
 =?utf-8?B?SVFTS0VnZC9xdnFQMDZaRUhRQmYzS3FMS3F1OGhObitOS0pvOHRjNTl0K29h?=
 =?utf-8?B?MHFwamZRVzhxdmRGYmpjTVFDZ096V3o5TnR3dGxaSjlON3o0bGhXUnVXMWw2?=
 =?utf-8?B?N3VOTGpkNkZ2UnFCbEcrL3hPK3hTczlNWVM2VkxNeGY2QUk0YmhwYklDZVNx?=
 =?utf-8?B?WlpDR0hOM3ZGbjJZS2owWlZRTzZuL3pVSEwrenVBTjMyWG80ME54c2ZXOFZZ?=
 =?utf-8?B?UmViQ2V3Y2l0Y1cySUNWSlUrM01JOXRtVHZ2MjV5dHh4L0ZLZzVueVlvSXB2?=
 =?utf-8?B?endmSjFVclpxNkZZZWtqSGhkOWFuTDFWVTU5TDRkR3ZSdmNzRWliVG1COE9K?=
 =?utf-8?B?OXJjanV4MkFYcHRBTGlVZ3IrNXExS0tlVXRUQUlVMFdGY1hCZVhqYXQvZ1l3?=
 =?utf-8?Q?KXl9o51s2Vso0c8TaUVQj/uy4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d988e645-da86-459d-f210-08dc33ba757c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 15:25:10.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xS9XA8OgXOBo68ZWwQ29LlwsooDozW5kELunupSyGTzJLFq4QP5MaZSUk1uOyYp7knbQM1xAKtav6q9dbU4Rew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7253

On Thu, Feb 22, 2024 at 07:30:59PM +0530, Vinod Koul wrote:
> On 19-02-24, 10:59, Frank Li wrote:
> > Fix below sparse warnings.
> 
> This does not apply for me, can you rebase

Which branch do you try to apply?
This one is fix warnings in "fixes" branch, commit
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?h=fixes&id=9d739bccf261dd93ec1babf82f5c5d71dd4caa3e

Frank

> 
> > 
> > drivers/dma/fsl-qdma.c:645:50: sparse: warning: incorrect type in argument 2 (different address spaces)
> > drivers/dma/fsl-qdma.c:645:50: sparse:    expected void [noderef] __iomem *addr
> > drivers/dma/fsl-qdma.c:645:50: sparse:    got void
> > 
> > drivers/dma/fsl-qdma.c:387:15: sparse: sparse: restricted __le32 degrades to integer
> > drivers/dma/fsl-qdma.c:390:19: sparse:     expected restricted __le64 [usertype] data
> > drivers/dma/fsl-qdma.c:392:13: sparse:     expected unsigned int [assigned] [usertype] cmd
> > 
> > QDMA decriptor have below 3 kind formats. (little endian)
> > 
> > Compound Command Descriptor Format
> >   ┌──────┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┐
> >   │Offset│3│3│2│2│2│2│2│2│2│2│2│2│1│1│1│1│1│1│1│1│1│1│ │ │ │ │ │ │ │ │ │ │
> >   │      │1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│
> >   ├──────┼─┴─┼─┴─┴─┼─┴─┴─┼─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┴─┴─┴─┤
> >   │ 0x0C │DD │  -  │QUEUE│             -                 │      ADDR     │
> >   ├──────┼───┴─────┴─────┴───────────────────────────────┴───────────────┤
> >   │ 0x08 │                       ADDR                                    │
> >   ├──────┼─────┬─────────────────┬───────────────────────────────────────┤
> >   │ 0x04 │ FMT │    OFFSET       │                   -                   │
> >   ├──────┼─┬─┬─┴─────────────────┴───────────────────────┬───────────────┤
> >   │      │ │S│                                           │               │
> >   │ 0x00 │-│E│                   -                       │    STATUS     │
> >   │      │ │R│                                           │               │
> >   └──────┴─┴─┴───────────────────────────────────────────┴───────────────┘
> > 
> > Compound S/G Table Entry Format
> >  ┌──────┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┐
> >  │Offset│3│3│2│2│2│2│2│2│2│2│2│2│1│1│1│1│1│1│1│1│1│1│ │ │ │ │ │ │ │ │ │ │
> >  │      │1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│
> >  ├──────┼─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┴─┴─┴─┤
> >  │ 0x0C │                      -                        │    ADDR       │
> >  ├──────┼───────────────────────────────────────────────┴───────────────┤
> >  │ 0x08 │                          ADDR                                 │
> >  ├──────┼─┬─┬───────────────────────────────────────────────────────────┤
> >  │ 0x04 │E│F│                    LENGTH                                 │
> >  ├──────┼─┴─┴─────────────────────────────────┬─────────────────────────┤
> >  │ 0x00 │              -                      │        OFFSET           │
> >  └──────┴─────────────────────────────────────┴─────────────────────────┘
> > 
> > Source/Destination Descriptor Format
> >   ┌──────┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┐
> >   │Offset│3│3│2│2│2│2│2│2│2│2│2│2│1│1│1│1│1│1│1│1│1│1│ │ │ │ │ │ │ │ │ │ │
> >   │      │1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│
> >   ├──────┼─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┤
> >   │ 0x0C │                            CMD                                │
> >   ├──────┼───────────────────────────────────────────────────────────────┤
> >   │ 0x08 │                             -                                 │
> >   ├──────┼───────────────┬───────────────────────┬───────────────────────┤
> >   │ 0x04 │       -       │         S[D]SS        │        S[D]SD         │
> >   ├──────┼───────────────┴───────────────────────┴───────────────────────┤
> >   │ 0x00 │                             -                                 │
> >   └──────┴───────────────────────────────────────────────────────────────┘
> > 
> > Previous code use 64bit 'data' map to 0x8 and 0xC. In little endian system
> > CMD is high part of 64bit 'data'. It is correct by left shift 32. But in
> > big endian system, shift left 32 will write to 0x8 position. Sparse detect
> > this problem.
> > 
> > Add below field ot match 'Source/Destination Descriptor Format'.
> > struct {
> > 	__le32 __reserved2;
> > 	__le32 cmd;
> > } __packed;
> > 
> > Using ddf(sdf)->cmd save to correct posistion regardless endian.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202402081929.mggOTHaZ-lkp@intel.com/
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v1 to v2
> >     - update commit message to show why add 'cmd'
> >     
> >     fsl-edma-common.c's build warning should not cause by this driver. which is
> >     difference drivers. This driver will not use any code related with
> >     fsl-edma-common.c.
> > 
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

