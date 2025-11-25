Return-Path: <dmaengine+bounces-7342-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D66C85E9A
	for <lists+dmaengine@lfdr.de>; Tue, 25 Nov 2025 17:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDEDB3537F0
	for <lists+dmaengine@lfdr.de>; Tue, 25 Nov 2025 16:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF94238C36;
	Tue, 25 Nov 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EwxM/Icr"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B44236437;
	Tue, 25 Nov 2025 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087275; cv=fail; b=ae7WxoX3rBzRPpfoN+7Qko2BbS1QZuZ8TsKq/zuy7imk+5q7J2qmiJ3LWbuRPUgFomkVJeFqoKgzxlW7UjIum296JGZoWRA7RMY2TvDRx7Z51cQjqdQg0J6gq6cjLuaOkMkAcvDGgLjgoL+aqTx21E8Ea2tuZbVnHpG2SVoccKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087275; c=relaxed/simple;
	bh=VAsQKwVxc5pB9g7FEz+0J9Jf4dmgoMZ1ODeH9zYdACw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LrC5g59bblBgGjJQh/ptLFc0xLKPLXdXMIXbSoV93+k1joYdmVsG42yAs8eORob67snmCU3g/lpwf7s13N95mMmEuvAMXWxlfeyrXwqU8lrliCsV/6ZjPbtnEepo99JR+IysLN1K7e8DwI+H5+CsckyqmUSsJDf5nUmfeNSzVSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EwxM/Icr; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIXCLA0hSHQ61zSQCkaXn3zkyKT841pXKeJEnxwmll329jgrdgsfS9AySZ2Ssx+mg4qYCSpdMtIrcUpzks1TyEhIdlMaJeY0s0+VASInF19lCj6t0O8YiKeYS6/sz02JZTKd+Esch0NYNjOQpEKsMoYeZf0KMXhHCfudMzbh+V24gaVSGny/gazkBCM3vkQo9d3m0rhH1tt6StNVFHXCtZ3LyihbebuNJK0OLsSgySmDoKulvnLB1IYwpBkYvt0MU/x3kyuekclV5ENVyOdPNW3ODIg0VWdQ25I0hJ/ovzW71bw1oQOV//Zsq8Abrv4KbEWJJO1Xmi0i2u8WzY32Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6kNm7Tce0IP1GVOZ+eo7e6u2b0+ZqJcmE/N1bhliPM=;
 b=NmsA3ssUD1QdG1WNJSn+BbdOPWW0/aASY2Xq+Eh7EfXoB4EwmmmgZ9+V2m7T2eAqUnLiX7Fkmw+jvqyHxXfn9KoUmanmJ8X1p3Q1zcdY+cIs7N9w6u2vu9/CoqAcWJlgJHD++bpugTNJ2Smpm/RfEs2DqlhSqXQtpWHdHeKvJ7z3WmILxcdf4KQpmbGyHoafMhQtUWvWD/MGpnlLXU5A+2aRjvTo3kJtwSDtXofzgpSIv3C6Kvyzo0yrLCvNwrHMHf+/dG7pHAKU+AcG9WmqCDQZAI3f7AdSO+sk0VKp5uU607U2xm7bpT1apqSl0YJvryOd0TJ8G9aereZFzNGJ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6kNm7Tce0IP1GVOZ+eo7e6u2b0+ZqJcmE/N1bhliPM=;
 b=EwxM/Icr0cNsZqvFua8y1T4ajB5LGwaOveWCmAUxeuBg4p7AA0O9RCujM+neiWjTrGyMQbf5BkRKL6CsicCVdh125Vy8Ee4XA32WIrc+PpTotykIYXWP2XduYnpr9sTXqJe9LkIPWaeRkmT/kX60kl3RW+Rmmqmd4Pr4/5Hinfv8pqQli5MhGHmK0Ybrcf7cRL8Q3jWcuEBIlCdHXEOr3zvwoQIAwtBDbS0OS5aWy/2dBeYpr+6eLUyUdapKVPr82vEJdJ5MF7Ftcoz+Dwr1IMqd4ODRM9nrNxHTmSuFN9d91DyOfw3cEcIkcy+PsZT2tIt/8zKypDIMYDVXsOGt6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI2PR04MB10115.eurprd04.prod.outlook.com (2603:10a6:800:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 16:14:30 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 16:14:30 +0000
Date: Tue, 25 Nov 2025 11:14:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Vinod Koul <vkoul@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] dma: mcf-edma: Fix interrupt handler for 64 DMA
 channels
Message-ID: <aSXV4A60wx4M7ymj@lizhi-Precision-Tower-5810>
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
 <20251124-dma-coldfire-v1-4-dc8f93185464@yoseli.org>
 <aSSDItseEjQ0VMh6@lizhi-Precision-Tower-5810>
 <aSVinMNSTEQLZxRi@yoseli-yocto.yoseli.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSVinMNSTEQLZxRi@yoseli-yocto.yoseli.org>
X-ClientProxiedBy: PH8PR15CA0009.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::8) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI2PR04MB10115:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0e629f-f983-4482-a8ba-08de2c3db6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JwhLRcEBka/C1JAta0pUX8xknLb2FtMTfXnJQMS1txTjj68ztkq4vFCPXo3H?=
 =?us-ascii?Q?d3BSTJ+C/8amClz/9ZX9xgns6juqdNnFYQmXkSQKLYcq7RhBqOfRUwiA5JJ+?=
 =?us-ascii?Q?yz00mAmsND0l7o9kCpC1ptSUWld+lYRC14C4YyKMst9m0mCbNNtqdXqIb+81?=
 =?us-ascii?Q?bgdy+mNVWGk3GgnCZeXFS0jnFV8X4hjBHRf8GCG5d6T1LxFzoXYTIGBI4DAm?=
 =?us-ascii?Q?xV+OpMltu7Lxu1OVCv1FoO8Nm6mxQsFnH2nrzsM37uyklFWw1+dwIrUZHLFu?=
 =?us-ascii?Q?zBTeEI2ccc6Ph2MLKl1KtBy3GWIIPr7SNLrMPt5yx098bNMDwILfLwLHpOEV?=
 =?us-ascii?Q?pqm2SLUZ8Ic9BCbSK4P3XYGShscYH6gRUt2NaxpmtEnIMhmK6XdIG6cdGtUN?=
 =?us-ascii?Q?2twtMX9tEambt3tLH889TohGKEFBPg32+MQQbb54vnxwkVx9j4Ie3IpFof9j?=
 =?us-ascii?Q?mmAq2I3v5mQlNKeKNMYcaMN2shgY4pXF/arPGEXgloEOaVd05irIDL5D2YoD?=
 =?us-ascii?Q?fKCnPSLxprIwkkt0tqz1qLVYm1MvSF9jCPefNv8rMi671sKgdV+liaz5NZMy?=
 =?us-ascii?Q?vgosYM90WhZ5eGRJ8wGJHdH8CCdGNKCiI7DL/gf5cauB5ZvhiP3zqKRBJO+1?=
 =?us-ascii?Q?FfkNtSt0j604erqzpe/5mZfBWrgYBTVUHYeG7fesPCNB+r57XCaUzCrUkmxh?=
 =?us-ascii?Q?UaxdQK7aA9BUEgWMBy1yEEK4M5+kQADOFmHfa79ZTS5ZHMmEZlyRqw8YuGQf?=
 =?us-ascii?Q?0vSPiTQnNbSb56hPWqG1NKUGPXCjmUDKOSu0j+7LjP8YqBi3R30Ay83uoocc?=
 =?us-ascii?Q?/BdGZja2g6nTNWmkgj5wiCuL+/Xj86F2wl/kIUCNh6o/1EPCkMgNtDdBktBb?=
 =?us-ascii?Q?3vvrxoOBpq/knIPkXKouJdl2xd++zbsjyDns/2yofhF6fdtA7kU6EwXDEh/U?=
 =?us-ascii?Q?bsyWLfgCMaG9g5gyaF2/cgVE+HmhhcmXMvFmV7ESFFVlAumyi10KcngbZ4nW?=
 =?us-ascii?Q?MraYp3VKW/WN5fAozxg8iXLvOG0GRxouni0S0X0SMmPhwEnjJQT4gnER/Kr3?=
 =?us-ascii?Q?OQ30XJf7+THsKkH+ZvhKpQo2W6OXE7pM0IVkfOYvvcXCcDHqH5C5YhLw/f5I?=
 =?us-ascii?Q?FXiwICkLbLZP1p8IJXTa+SuYz61t+jJCH8poEXtaMBKbF7JYYJvz+2mL36HA?=
 =?us-ascii?Q?ptvJhtYRiiIfmfGBeWADoaxBl+wyZjPDKxQHorthmm3yWvCqFDozYqCFEvRp?=
 =?us-ascii?Q?D5M0VHmwk02FFVPTCxRLVM2Eoihqf13vJOPDXUBEzG5WnYf9CSVEDOPPoTGm?=
 =?us-ascii?Q?y3xm755lQPD2ZOi8aEkMZNL0prInyEgAQyMBYPyfn0oKvJyp+wDOL9Z9TrpS?=
 =?us-ascii?Q?B9wnI9ffVxdlc+ASG5qKoY202i7gG19JSP0/F1A1mODeqisgea7Z353vwjUa?=
 =?us-ascii?Q?m+FpiHFosY0I0+sr7kHg90lTrMyXV9ScPZUtil/OSxVFIWL7OAioDSaKoQGG?=
 =?us-ascii?Q?ntHnf4bVV3IA1vb7llsQ1/oWKJXvBUaaxs7I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uo5yQTlIZi8lLlDOYorPETEYA5Jhtcm2SnZiYTx8jJ55toFKZJyFF6ffkR7W?=
 =?us-ascii?Q?g9XneNKdT/QhJIeJFNJgJrs2SqiNqkQMu4U8OJi2Sdf8xbuqt+GJnCIIli8i?=
 =?us-ascii?Q?n7gRLyzge8xK1JUncnXV1bIFb1nETw5b2YPz3XxorFO7oYzaxcqCxwTwTdhe?=
 =?us-ascii?Q?KF1zSJKMYH1xmEIgicECUSWGVzpEkvr2msIJCAMbpbUacEd0pu1wpfYCpZob?=
 =?us-ascii?Q?TFLC6oMmIHo/se+b15OV+n2bF6W+LycrkAmJHirtArM3oDB3W+jyJHXidebc?=
 =?us-ascii?Q?xYZuTiA9EmjoU6pVtILF7H9G5x0G/Oe6jJzhKeeDXfAsDz0NhmbSBM8ypAv8?=
 =?us-ascii?Q?l0BCVN2is5u9/OfXYkUZE7H20VmYLELaDoW8NtFkEuKh/NaLVsCui7pGJC43?=
 =?us-ascii?Q?3fyz8AlYJJTrTBkbcXwJehBqguET1DP60VCFLe3lJG416uUIuok2L/xi0iqK?=
 =?us-ascii?Q?LV6ZyblIqr/ktovIlgmmLD6omxLfgAtrY6e1zj7h1qbTethcSUR0PZL+H0ni?=
 =?us-ascii?Q?vnmTE6JXgyN73WNmMEaQbg9STZUFQbLjQkT4w+SnWD7X5kxl8ah16uwI5C0Y?=
 =?us-ascii?Q?E28LGfgL3O4OpL6PTuroQ/deRDH3IX5fBp+oxkt5225UdmoICGybSBacYdoi?=
 =?us-ascii?Q?7tmi4aoUprLrGZkAWTTITt/kFFuUunPD3wc4hK7dUROFi0h3I3hTHWJbc1KW?=
 =?us-ascii?Q?Mq0LxYC8T/XDUHKJhsmrI1uB7NhHhNxg4QfvqbOHUVbiVJKq3KxIWQyAxZ5u?=
 =?us-ascii?Q?kogZtRZ0S5tIy5pKmvHCw+VbgsaBR1Sjx+eiRQupHfZQgDs/H3WXYjQMDZZF?=
 =?us-ascii?Q?FynVBeJdJcT0szjU4DTQxdQQPktsMQSn7gkJsN5XVmUtF+5fqu83AbF3ZvGS?=
 =?us-ascii?Q?ZgMWjpdLw10pzIOQi6beNdz6zsXBK0KifSP186IAbMV1FD3fuUFFlo/fCirR?=
 =?us-ascii?Q?EeGi+WICeN+dOjOju1w9F44EaK5kuwA+/6W6Meo1pdreqh8UaGcRycohACjW?=
 =?us-ascii?Q?nwwyFS0Nc6tWIexSYa++L3SBJ83wBWzNsBE0oHcqWKxYNG93OcRF3vbGRSCL?=
 =?us-ascii?Q?hSFfk9wJmhFxAPJFDyNw716C6o7M1x60kIKMQ4KtbAmI2sjK4BRpY1eXXUS2?=
 =?us-ascii?Q?eMxQU++3jqDHd20DoMpq77+TeIxX9hqMpoESRbH4l2Zm5rxHSl8M4HezUDbJ?=
 =?us-ascii?Q?ndHig0i4oQ6lHu96jtbZ75/tTleGLwQ5JCBbbbKOodOHhdxeYqR0PNrPHCT1?=
 =?us-ascii?Q?ILbrG4E+ZsA8Gs+GKgGfaxm/pI8bhsYSHpVNCuubMqvsu7MTf87rPfkgvP91?=
 =?us-ascii?Q?xfGxHAQZTfTYTYe4ufdwzKEa6/ZGACjVgVtgoASsUtwjrL7JrHar/g5cu0cv?=
 =?us-ascii?Q?X/PGkNJqIZrJ1dU3rZMbqC4UPE07zClinWcKKlRI18xIy6kHnDfI3VEtSNdu?=
 =?us-ascii?Q?pEfvtjUzZRD2hIfelThoRZKIixwAkw+ZIuPVt4MifJSalRqs/bxIM5d4R0O0?=
 =?us-ascii?Q?OxhGybAWci2psDSXQYBX+SeO7T2deV4ce05dr35Sv1gCHx25/EDPLb9DGr/3?=
 =?us-ascii?Q?fBEUYAetvQ5YDK0Bf/cEPvf4WNmE1bFKC/B/Q9sm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0e629f-f983-4482-a8ba-08de2c3db6b3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 16:14:30.4741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXE81/z6krFpcAgVsDidwcvEA338IS2PfTLfSNNOCDe+4WDxgfFYBQqDhxKXAldOZe3HvB8uhF1zmPdHclc+IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10115

On Tue, Nov 25, 2025 at 09:02:36AM +0100, Jean-Michel Hautbois wrote:
> Hi Frank,
>
> On Mon, Nov 24, 2025 at 11:09:06AM -0500, Frank Li wrote:
> > On Mon, Nov 24, 2025 at 01:50:25PM +0100, Jean-Michel Hautbois wrote:
> > > Fix the DMA completion interrupt handler to properly handle all 64
> > > channels on MCF54418 ColdFire processors.
> > >
> > > The previous code used BIT(ch) to test interrupt status bits, which
> > > causes undefined behavior on 32-bit architectures when ch >= 32 because
> > > unsigned long is 32 bits and the shift would exceed the type width.
> > >
> > > Replace with bitmap_from_u64() and for_each_set_bit() which correctly
> > > handle 64-bit values on 32-bit systems by using a proper bitmap
> > > representation.
> > >
> > > Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> > > ---
> > >  drivers/dma/mcf-edma-main.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> > > index 8a7c1787adb1f66f3b6729903635b072218afad1..dd64f50f2b0a70a4664b03c7d6a23e74c9bcd7ae 100644
> > > --- a/drivers/dma/mcf-edma-main.c
> > > +++ b/drivers/dma/mcf-edma-main.c
> > > @@ -18,7 +18,8 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
> > >  {
> > >  	struct fsl_edma_engine *mcf_edma = dev_id;
> > >  	struct edma_regs *regs = &mcf_edma->regs;
> > > -	unsigned int ch;
> > > +	unsigned long ch;
> >
> > channel number max value is 63. unsigned int should be enough.
>
> Yes, indeed, it is enough. I changed to unsigned long because
> for_each_set_bit() calls find_next_bit which returns unsigned long. This
> only avoiding an implicit conversion. But I can remove this change if it
> does not make sense ?

It is not big deal. That's fine.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Thanks,
> JM
>
> >
> > Frank
> > > +	DECLARE_BITMAP(status_mask, 64);
> > >  	u64 intmap;
> > >
> > >  	intmap = ioread32(regs->inth);
> > > @@ -27,11 +28,11 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
> > >  	if (!intmap)
> > >  		return IRQ_NONE;
> > >
> > > -	for (ch = 0; ch < mcf_edma->n_chans; ch++) {
> > > -		if (intmap & BIT(ch)) {
> > > -			iowrite8(EDMA_MASK_CH(ch), regs->cint);
> > > -			fsl_edma_tx_chan_handler(&mcf_edma->chans[ch]);
> > > -		}
> > > +	bitmap_from_u64(status_mask, intmap);
> > > +
> > > +	for_each_set_bit(ch, status_mask, mcf_edma->n_chans) {
> > > +		iowrite8(EDMA_MASK_CH(ch), regs->cint);
> > > +		fsl_edma_tx_chan_handler(&mcf_edma->chans[ch]);
> > >  	}
> > >
> > >  	return IRQ_HANDLED;
> > >
> > > --
> > > 2.39.5
> > >

