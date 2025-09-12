Return-Path: <dmaengine+bounces-6496-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 776DEB554D0
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 18:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82FE77A18C6
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4E431B126;
	Fri, 12 Sep 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OeeeP4T2"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE671175A5;
	Fri, 12 Sep 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695208; cv=fail; b=gTzLc0oWYwXR0KOuNvFALijYFL4CURtQQoHmiEY2FDVN5Q5MjNb2pox39VH4oigKBcKPyzVEwvK0eyrugRoOFdms+uRxa8fXXktiJufVirFut6YLTPBTB2iw7BjzdQH4SIpnKC1Wkc/PcEUvvojQz40x78TCbdRCVIFh26APrMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695208; c=relaxed/simple;
	bh=MTtnwdU0aEJZKrkg703WP0cFv4QYs0reY2/jDrqaNNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rx7yPT9PTtgMd8tozyPbx29bYaF3Ff4OcdWZPP8GqAqK7yFOT+Gl+VNT0tTp735eF/BQOKWSrIQDUZHiS8IgYe2lFvD1rL8c5+PlPFPfoii3QU/iGHbLGw32+Y1dRq6KRwz3Vwv33vAjZxzT1ZsK/QmwEjO5xBN78MEdFqPTDvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OeeeP4T2; arc=fail smtp.client-ip=52.101.69.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nfr2qR6UOV2AMe+lhR9xQZ/6n2/vFKDfQtQOc5YecOM5M+gZMHfI+IpXvI8H7lZ5gRiRPAC/EpiF8exRrJCbZPbNRvINeFibWdf/DfYxjJARaTC72YUcnUd34+LNjYQWpemmL+Ob1r0dhhLD1juoBNZomyH4gFp5ubh/YRuFSAVd6qRlxfV5z7JKK5vqHizYohtQPHD+dCWPnf/j9h7iqWJ4E/lHDtcE7U8xBiGE7FYZZgLWq0DeYno1X/D3Zz1sOKspc+fYs9FTrq6TlzbvO8jYGT1GVr0iZj2UxQ+rfZ502ZbX/IdqrYPpoRFbycU0z55zEOuUZVD8gntR9fvs/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGtYlSntMeKKbhW4nC+fQ8CsC1Hlrz1PAGnmvUirS64=;
 b=Xz2CpvTwetjLXsOp9eEm0QF3Ts5zCMgJURpl+sm2GjAgPincTkdgZmZGozx0pg91s3ldUfXDONZREz4kBW0+1EuMYI5b3NdUr0IDMCdkwBKmJZEQXI+L7D2gXo2F2BYudGtP81eDwE0OUQ+a10Rrm1tA070f9SEgFnZmnoHHlOupo0B/TLfujV9faM8WUe9lyRqTskpLSoYD3K4Xir/X/GtXW6nNfxv+4y7uOvPSC1y4V5A4BvebBA//G62/6RxGNyUlRaI86bO9hmJIqirmk/hEHlBj+s1uzhXu8D57737XoQRWoIPX3mhcsF2vHajCaXb0GzKNQTQSNSFxHAxC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGtYlSntMeKKbhW4nC+fQ8CsC1Hlrz1PAGnmvUirS64=;
 b=OeeeP4T2hVVmrQH/KihUGpO4jdSTCDMsZutExw22ET60xuhhW8sMF8kOUXhSpNgboVO7TBXHlrPQDb4gySbzopAWa0DvQ4i/ndxZIsl+VY/kUJ/3vVErxbBKS37n7FHc8jnjZtiK8aW005l6k11UE30oMsLqb1QkFIDmLuLfHDJM3uRbBRlJjMtNNK+ygujMw3fZFLw6o+yz9EDVqdGF4QDg2QUt3KiKq95eRvTbP56PGKAI4dPOCpKhosuEbozo94bO4wy8Z4kyek1NfupzHZ1GeaQv+3KbZcXTiIVa6xCxkfGwVvqq5k0LffUfCXaloCL7sYOEihzPZ2krcplwhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10589.eurprd04.prod.outlook.com (2603:10a6:800:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 12 Sep
 2025 16:40:02 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9115.015; Fri, 12 Sep 2025
 16:40:02 +0000
Date: Fri, 12 Sep 2025 12:39:55 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] dmaengine: imx-sdma: make use of
 devm_add_action_or_reset to unregiser the dma-controller
Message-ID: <aMRM2x7dN3UWn/FN@lizhi-Precision-Tower-5810>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-9-d315f56343b5@pengutronix.de>
 <aMQzNDE8QuUZwGkt@lizhi-Precision-Tower-5810>
 <20250912152809.nj3yk5wmrb7ojjoo@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912152809.nj3yk5wmrb7ojjoo@pengutronix.de>
X-ClientProxiedBy: PH8P221CA0058.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10589:EE_
X-MS-Office365-Filtering-Correlation-Id: cffda36c-2605-4a3a-8ab8-08ddf21b0565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3oYI43CySIBxL9hsnUp4Tbe8Tk2TEdbEZePvR/FPsKTh9gPYUpv36Pyr9VHl?=
 =?us-ascii?Q?plyvbPDp5XOP0Htn/Bpcl+kZYoQl4wYLm3LwKbJaDzbClsgivjwVZwWxjREh?=
 =?us-ascii?Q?PiwQO45sPyRuTvLpsMPi/PYq/cwQJbt+ZVgg/Ae02mWv3J8gwNgEKfO57nad?=
 =?us-ascii?Q?8jzt4lleFQlwyW9z+pMVKbFCyglNTsYPbLuNhLrEsCyFbVzTczj/2m7M5mDo?=
 =?us-ascii?Q?YiTUc2QlakPI7AwZis+LNUCcIkeZorFwJV0JaVttJBLUwCLfV00GuOx4uq1m?=
 =?us-ascii?Q?8mNS3X06dbHYoaMgcGiPLJ63CssqXZVVV+ERic7a/vOpXip/DKTnIqQLSL4t?=
 =?us-ascii?Q?tPpq7lPwvbgybfma3pmvGOr39MK1GPmqIdB6OCD5R1hOQr7YaC9gYuCQcmnR?=
 =?us-ascii?Q?bjheFwgMx4cX7WugYhLxws+/YD2xMwJ34H8fWdIyPpMsh/tFcITmlXoHE9N2?=
 =?us-ascii?Q?jGaZ6t8OUII+Ao1eEODnembRTrl4rhWyJwADqcna8CuqNDEGcWMnaCCSF3xK?=
 =?us-ascii?Q?JSEY0aYDxmXVQwrnOSafNZZZngs7TbINnFMssOMKIjLBKXRzDwGlMs34a9eX?=
 =?us-ascii?Q?uIXvGW59FbSr4LjAdrMtUJgrdIulKH6K2nYA1IhRQ7+/QaMTyM7x1nP8GOdX?=
 =?us-ascii?Q?7+sEjzw0huXIwWjdVDiFUOE92YVnvIm2y5m1HEa5j4An3o999FO9/dQ076lz?=
 =?us-ascii?Q?qgGGsb/lQkYN95t8K5zAsfM1cc8mMDvm1h8+2ulHSpdpQ9jvnNIK6VmNM+qw?=
 =?us-ascii?Q?MJGyucUl/OoN4YyJkQEfYk1I+DXce3r3YJ3q7APkJrxmpJHDSxMFsZMpZQ7N?=
 =?us-ascii?Q?L8gDKWOAkD2CRL6sKyxH2MgR4ZKFdcphCv/fE9cy15HjAB6XFBCcq016XldV?=
 =?us-ascii?Q?AaCCPavyH5vtaLC1HxNvsSJE8sRdeQwdLHoP7HyXHvggkAofERmQMEY9TlHo?=
 =?us-ascii?Q?RquD4eRb901R5FizGVRCIto7IqK6Hn8zJavRJuAGKc5NKk6vS1kLRtLAZUXv?=
 =?us-ascii?Q?IH4BVuCMW7XD1xxW7gc6MY1IHYsU87GWVjg0z2UNAGPFaMtPzfXDKeQITH28?=
 =?us-ascii?Q?2CGNwim7UEavBD8LH55i9m1z3QbrsXLZA9rRSBaEoxY2bo2FgHj3Qmq0e9zo?=
 =?us-ascii?Q?ZqweKi4JHE6R8xoPz7b0wV5+LPuUp6NcvWff4dCtDBdmSisAm4tP80XezTiJ?=
 =?us-ascii?Q?+rvgTqZ9lVf9vgn4C/PVjsyGy0rV7xlVqXfVw8jQj6EepFN2b0yDhtgTWwBK?=
 =?us-ascii?Q?oJ+XFAR8tFGib2cDo96MPoohoXiKcesKunHtH3dLnpyrjuiZ+ROrGsUF+jnc?=
 =?us-ascii?Q?Tt2kMrdkmj+8qlL/9VOeQ12cV9MZ1g1YRVTT9YcYReEnL9SjHfazTdD8MHqB?=
 =?us-ascii?Q?O5s8RttpnT3Yj89CzlpgkSiZbj0WU0JZ054g2BX2x9VgsJCt0GLVMbaKamGK?=
 =?us-ascii?Q?ySC7qmXKOBPyvnKuNl+1DyvOXLQeq5Cu1n+9C5cmw+iSeBBGDvEnGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M02YuGGogdNn1J1jxOXQ3HGWHPlUZsRQVjPxlttdxSqsboMTgXzHlpSsE87b?=
 =?us-ascii?Q?WOxhBSPCFPyurF52yeN0KrkFl55NEphE8z6EVcoxlj8edyKwX+/4Z+53ML6G?=
 =?us-ascii?Q?4mweZvouHKAriBu9PJEco9QIeVRl0J4nkblk9FwcGpo1Aq6ZsfIcYHvGFWxe?=
 =?us-ascii?Q?ig+//u4Msv+xFa7IlR3bVHaH1kDls+S3QPJhVpSAA7rq902nFNrz+Pxk6yG/?=
 =?us-ascii?Q?eujudw4qAcviHszXh3eB/qvY7h9RQgMi5tNPT5iMFG674JiHt3MjbBSdxx3R?=
 =?us-ascii?Q?vfGaKHZ960PtF33IoiMkh5SYHrxdC+LOxenlh4rkno0lxdDjgYB0m4+dL7P8?=
 =?us-ascii?Q?yWDu/Kcx9bgpGhfR0sGsUW10Y3r44qRUaOt6AXMkNRGCucL+7qrIc1FwDRJu?=
 =?us-ascii?Q?+6iRSi6fuMaPKSWrpl+a2eWNNMej9fl7CEm64PnqKjggpB1tOLzv/2iKKTND?=
 =?us-ascii?Q?NHTXv2AHn4zQXqO2t/QxKEJZZ2UjjtQH+D7wjFVDY5GEMJAYG6htvwjB2c9s?=
 =?us-ascii?Q?T3VP7u0Ts9IQLGyecYyBHutEMjY6XNWYDUC2DmI0bgnVujU6AFGQ+/mZhoSW?=
 =?us-ascii?Q?UdDwqRb2TS2N/XJgardH359oBf8sskWtGWltjHV9bYC2fwr2pIJSbV3S+iuP?=
 =?us-ascii?Q?1DMx5Iie5eCFZiwr4OO1kLqvvdlRluns0eOtcKAfv/CQ1PQVFpU7lc28C0rG?=
 =?us-ascii?Q?ZzBSEuQwFlsIi5ExKMPW8LoDn6Fazq7OyZdLqzCfJp46JGurqebBcqObcRcU?=
 =?us-ascii?Q?WCYXGOh+UvV10aa06pOZcgWU2GX2ipJ59e2heXxYfgDSddY9sSmYY+baDTFw?=
 =?us-ascii?Q?hykGqx60lEFEccqu6vvDHv+b52cbPrNDvdpQeUGQqRYqDjfb+pUhUPmn6QSr?=
 =?us-ascii?Q?ozn0NCwT4Qy8uhyh9+6kjhm2GpfBE6AmKV60d0QIRumfbb/Rcv9VRcIt3T7g?=
 =?us-ascii?Q?zWrc/JCdCKi/mqojEkCS4wtvwu9CkNhqcrRIut2vQaLtSpciGuDRKthbIz9U?=
 =?us-ascii?Q?MM+VamUdi99D/6fMgMTTEvVjhjmawXmkToNDqor+byCDqqyexWy8HDrhTKo6?=
 =?us-ascii?Q?2fK5+rEl1N5dX/l4T9rgwamqISVM4AN1rw0diBvsS80MDkSNiPM6YH0xQ47z?=
 =?us-ascii?Q?isGtrUeFfSBg7ab1dPcxVbzoEkFTMz/Kcpq7gglGwHUa2aIVZ7v5obPa0MNG?=
 =?us-ascii?Q?ZoP4BHtrBrS0qlllDWeslS5rou1yU1KP0elTpdp0AbUTr6EIhsZVZxIhvkxF?=
 =?us-ascii?Q?WZCgfpzOtGE6ktDnGslInMbssxcsx4NT2mFWaRAw+8O1WIkCf1pMNGEvXKeh?=
 =?us-ascii?Q?4biOaY47qRGO2R2O2JSt6tG8ILof861Wihf4Agntb+u5xbI1AG6k/BS+kxSP?=
 =?us-ascii?Q?oBUvhcaqteO4M5B3k+2rh389QF7sAUZ28FE5v97W75h+r1BkE2VB5AYVDHXS?=
 =?us-ascii?Q?OCZV4gIvMWSKqLwo/YHhapqomquStr+wY1X9vjaClqRIlMg7v2apMb2Se65L?=
 =?us-ascii?Q?+zT+6EuMQmU2uAkYAqYwl1JSQv78b/1moktf97xrqMULUhHRm/Zas2M2QHBO?=
 =?us-ascii?Q?AK2s02aVplt9ei/Ao5gZM5g4zmL1G2A3flRD6kDt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffda36c-2605-4a3a-8ab8-08ddf21b0565
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 16:40:02.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNoM7WaVp0X/SUUgT1o0ErtngTUGHepUt71069RYUu3AcbGF4FI+QBULZaD8po+jblKkY9XARttrdqNefC1dJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10589

On Fri, Sep 12, 2025 at 05:28:09PM +0200, Marco Felsch wrote:
> On 25-09-12, Frank Li wrote:
> > On Thu, Sep 11, 2025 at 11:56:50PM +0200, Marco Felsch wrote:
> > > Use the devres capabilities to cleanup the driver remove() callback.
> > >
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  drivers/dma/imx-sdma.c | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > > index d6d0d4300f540268a3ab4a6b14af685f7b93275a..a7e6554ca223e2e980caf2e2dea832db9ad60ed6 100644
> > > --- a/drivers/dma/imx-sdma.c
> > > +++ b/drivers/dma/imx-sdma.c
> > > @@ -2264,6 +2264,13 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
> > >  				     ofdma->of_node);
> > >  }
> > >
> > > +static void sdma_dma_of_dma_controller_unregister_action(void *data)
> > > +{
> > > +	struct sdma_engine *sdma = data;
> > > +
> > > +	of_dma_controller_free(sdma->dev->of_node);
> > > +}
> > > +
> > >  static void sdma_dma_device_unregister_action(void *data)
> > >  {
> > >  	struct sdma_engine *sdma = data;
> > > @@ -2408,6 +2415,12 @@ static int sdma_probe(struct platform_device *pdev)
> > >  		return ret;
> > >  	}
> > >
> > > +	ret = devm_add_action_or_reset(dev, sdma_dma_of_dma_controller_unregister_action, sdma);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to register of-dma-controller unregister hook\n");
> > > +		return ret;
> > > +	}
> > > +
> >
> > return dev_err_probe()
>
> Please check my last patch.

You can use dev_err_probe() here, last patch only convert exist one.
Avoid add A, then remove A later.

Frank

>
> Regards,
>   Marco
>
> >
> > Frank
> > >  	/*
> > >  	 * Because that device tree does not encode ROM script address,
> > >  	 * the RAM script in firmware is mandatory for device tree
> > > @@ -2431,7 +2444,6 @@ static void sdma_remove(struct platform_device *pdev)
> > >  	struct sdma_engine *sdma = platform_get_drvdata(pdev);
> > >  	int i;
> > >
> > > -	of_dma_controller_free(sdma->dev->of_node);
> > >  	/* Kill the tasklet */
> > >  	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
> > >  		struct sdma_channel *sdmac = &sdma->channel[i];
> > >
> > > --
> > > 2.47.3
> > >
> >

