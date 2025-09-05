Return-Path: <dmaengine+bounces-6402-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E597B45C78
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 17:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E923516454A
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983CF286439;
	Fri,  5 Sep 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="EV+WNql9"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011033.outbound.protection.outlook.com [52.101.125.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BBA31B811;
	Fri,  5 Sep 2025 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085795; cv=fail; b=LiuNWfdDsdoZ81c3r+bWWSeYEGudnFbGt48udcuL66M2Co5lZJaT4lAJL2H5kCaxAafVeI4tBCLAhEL0S5TnB9g0wkghnsXwuW1RUKwxhlz2uM4WVJI/q2/Gdh2aGEvjaYYx+6Qxv7tGnapqGPUABGpRafzmfQCbRM+gUQOd8Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085795; c=relaxed/simple;
	bh=azvX/hTTaNcn+jpcY6opG0DAdDwMNGTiOWjq25Cx83E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EtKrKdWgD+SUuLmJ8fN3b2oka8cECZRfYs5pgMLW9gvCJ1qyfyk8gwdPZWig7QEZBmq+8Iy38+W/xgrGVBfu1mz+a7IiL4/uGROanDDtz486uwoKCKniLmtmy4X11j9Qxa81idrn7NjUjprADXKeBh3vYleAO0NCVHqT4v57V/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=EV+WNql9; arc=fail smtp.client-ip=52.101.125.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+Ko8gYY+TLchenkiutgTkrW0J6kkzSR7ZdZAZS3cmYmrlYDtAe//IhDNQrKTshT1ryn9pmSYXGwWanCpOvx+Xw05uYbE3g7qSAm0mtQpvsFk7yPWkvKsX1Xef2+z5QCwkY+LD6TZ7kIzbJWaQOpGd+6aPELp9BCQrXQXZMChiFPXv4GQhiC5JGo+xDQj6K3sq7fJ7m8FWSi66pCf6BWCwK85cviF37eQoDN3y45o+n0TbtDragTszsRXc7Uu7DItjtmAc+BVjEIZonJLat6gjwljHtnr3MhuV7Z/+/xbbBRxKKLSxDP53+lOaOxLF4bOyBhH3EAN9f5q5/K6B+TRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnhYkCCIlmCp8dxvS1bzx3fYsfB+hdWABA+mJHbcRDA=;
 b=YGlrJrBkZulffjZCvf3LnxKxPkyPqAmKy4hDUz0ZoE/DnE/fW2nA/fZMxNIRiVxlACVGV8ZH7HmUfaCliZhx8DajuNckGF0Mcl+i115kGidXiKpG5K6bMcJiDuHsPdncFrGpV3V10y13N5FJv4AkO7iFxFZGM/8jrkQjlQ/Jl1syJMV0g7X9YRd7yroGsPTCLWcYu8mp44cFWFOlFq5jiM0poo4dlSpe7fZQDn0HvqGSZtOveIeiMWLEHwjYOi073ossJFB0Af6lPVNYgl0IxkNVfgHVVWnF+Pkg5vTo4S5nbHXlLMvDa/5wgsOdl6fgPFq/JXwLbaiThN3SyvTSaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnhYkCCIlmCp8dxvS1bzx3fYsfB+hdWABA+mJHbcRDA=;
 b=EV+WNql9bYJ/I7n86FC7oBHYRSa3npaCaVaPXsVJKWw9rosf6N3df9UN4AJ+brY62KdimORrUkRP/kXKH7RrUbkSGbH/DVfM17sogXx+dp54Qc7/bcvOTfN3GZl11osz5PgTA2TIU4+lclQptybwTsI0Ko5wEtABfoNKxyb/bUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS7PR01MB14572.jpnprd01.prod.outlook.com (2603:1096:604:38b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 15:23:07 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:23:07 +0000
Date: Fri, 5 Sep 2025 17:22:53 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com, Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dmaengine: sh: rz-dmac: Use
 devm_add_action_or_reset()
Message-ID: <aLsATdoqct8JfgYz@tom-desktop>
References: <20250905144427.1840684-1-tommaso.merciai.xr@bp.renesas.com>
 <20250905144427.1840684-3-tommaso.merciai.xr@bp.renesas.com>
 <1b2d2410dd9c300da1ffe015ed4835208416798b.camel@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b2d2410dd9c300da1ffe015ed4835208416798b.camel@pengutronix.de>
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS7PR01MB14572:EE_
X-MS-Office365-Filtering-Correlation-Id: 84aa8417-bc0f-44cc-96a0-08ddec901d87
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T8vhbt+KAPBROfRLaQmVsKyyOeLEXD4/vrFIcnI1FQ6NC1DT6VyRXY0JG8fi?=
 =?us-ascii?Q?l16AcDY6SZcSdWYQr8hdggQcMoybJTB/PsZxHsfAJ6wznu0HXyH3NM1rwasS?=
 =?us-ascii?Q?jjONUPjXou1QzdcZXEoF18UGZd0UamWm4Kfrzmxotuok5Yv9CCnzQpxcXopT?=
 =?us-ascii?Q?7uBRNCQjjGTTvrXhylLEYa6wZOZca7OcQVS0uag+AoxwYsKNIGoVWGfSlP7A?=
 =?us-ascii?Q?EG+lKlFS9HuqxhGNPGqyKyCHI9NWlIXz4/j5cDfzPdbqGINOO2mWyZMwpRZz?=
 =?us-ascii?Q?bNOFvrqSkn6O51GgYP58f+MEeVQsLhfmArPRmS/OxG6lN4OHPlC4zqxTO+bu?=
 =?us-ascii?Q?S4txH18/mwW7vm4cS4gMhc24rZquXoFG7iEOKi7VrUGY9p0zHVpvSDaut7O5?=
 =?us-ascii?Q?Dg51Sm/M2tNcSEJBy87fdR6iOG46vQ5Je4ifNMeCxcu4g48XVK8Bp+hs9rdQ?=
 =?us-ascii?Q?TBFAj8VX9mZpjiHzNjHhEuhueat5WHUS7xXyVLXVbV4A/dqFNETCsLW6FVh5?=
 =?us-ascii?Q?5gQgCZoeYUvRJOtALs16ykafjzWKoMJZTLFUpHu2KsNH2/0bl34Ol2F/LwhS?=
 =?us-ascii?Q?etK6y8+aD/Y0jcDPVytaDX0OInVo9zm4qKHpD/QuygmiOqryzoTZVnySQdg2?=
 =?us-ascii?Q?7A1dcrqNQixj8omLlDPmMbBkDSG+46B4MQ1LZtYt+KwRyueTfgIy2Rpxx4BW?=
 =?us-ascii?Q?7ee546rVPvvlxxir36YG0nojts3a9jv5dFJgOoIQ6izZ5ETzd/RseTlUkP86?=
 =?us-ascii?Q?N7qBlAlu0WQ9n7HGXGHxmYcWuSVllZ5lzdvnLJVtfBln9Kia8KGY2Yiudc5G?=
 =?us-ascii?Q?UhDBcrx37RDnPRnb/Pvqy0WIbnNEMTWE3y+l5x0KHKnnbAdi9dfplBJnW7eY?=
 =?us-ascii?Q?Mn/DBOxvCBYIfN0cvkFrm2VCt70wZay6vVmjfwqK/afpxEAMlTKGGzI4P8PN?=
 =?us-ascii?Q?L/+50MO3wG6rqzx7GonZe1Mz3kfQLMVriiKW1NKaeL3FSmaex99QR2C/wy10?=
 =?us-ascii?Q?BIaBfxKBrwwzd/MeYYCqljGHSITXxUpGS0PgkW4JELkkZEKb1EolwEVZvpgq?=
 =?us-ascii?Q?/rnj8uTLwDLMdM1BiymafoCasiOTRfnUslh7pM//mOkQv3wv6+v8XCewvqJ4?=
 =?us-ascii?Q?55pZzqyKk8/h/OI4TCz+3lhfuFOMver8kV5dNdIJBz+dUyaWG3qydEMzj+Tu?=
 =?us-ascii?Q?C61Or56Az1Q/2GfY/1fIQS4OXWZ/LjfxqGEaOWvawWpVirxqcZT850xejnHb?=
 =?us-ascii?Q?1Ki3rUgaFQLFhm77Vc/UJ07N6yayIFtCrsfHHAosFotWBTyqVkLC5xCNRezP?=
 =?us-ascii?Q?kLQXXE5j1yrpPiyal6zi69HB0DavZB2ozMEUvjm6j/mycTRZPhy8SpZk+GlY?=
 =?us-ascii?Q?UfBCZkhQ5eIvaCmpUmwJToo8+5CAcNDqn8Afxakq1y9b3vD067dwGw7rkXOb?=
 =?us-ascii?Q?Wf3K3SeEDN1O3n2XshEO/G5p1XR/gXIA3LBSwW7nL9Wd/MJV8rZmcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WE2MyiONUcYuHo1KMU0XgOPMbUiaBGJcEkio9r55j5Xipmk/LnJhl/zmktrA?=
 =?us-ascii?Q?J1wQUBij9IkJh5hK+Qh4qbb4DG3ML9YRUG9tX2U/FynLa64bnljXhJbLpMyo?=
 =?us-ascii?Q?17E9QmPvPjpFgivOJA3uOfGSU9K18jnyVzvjv+dpU0ZgyYKGwk1PZL1p6UvP?=
 =?us-ascii?Q?EgOp/PAq6Fyu4FP89HvtwT/l8A9GziOMg8W6dhKZtYZHaNEw6BpRV/sumDgP?=
 =?us-ascii?Q?d2ZCtPdQToBHvPTMDRFEchkCUmvZd1GU5rsjjBIJSHacTGEgjonvU0hgsMvx?=
 =?us-ascii?Q?56b9IpgbOzfY15iqPe47IXv4T8PcV9vG/j5Tot0GW6KS44p987sGakRo/ehZ?=
 =?us-ascii?Q?OQfm+yUbrx5TYCitcRjTgoud5Nnzwtjk+SBwPhjfCaZvpRis8aX37t7Rz956?=
 =?us-ascii?Q?zX3gMBIfgX7AOq9QLUWit3WUPOlHZ1rRCpkmx/NCpugnGpO5BsZ2DabfMeAs?=
 =?us-ascii?Q?CS+2ZNwztAHVgO2LVQkp8JjrfRCsTgRf9fbSRHC2d8lynlQ/G0CuMlPYAa//?=
 =?us-ascii?Q?GeMBrP2McQsEdNWdffXvg3Rdtzw53fF75D23mx8e1ZF5CxyRKwe6wgjRvc63?=
 =?us-ascii?Q?i3ns0DsLQB6T+hXYk8uG8UoZ7zQHHgJBOitvOC9DvDuTINd17lwkV0Mm238b?=
 =?us-ascii?Q?KSuX3GrlgKmQN3I9hI4LBEGZ+6xDtjUZ4KNAzOLVnQJeYeZt1Kf4Wy5qmfhl?=
 =?us-ascii?Q?H/5rK3VcJM9EbCt9Gv7UVEc7ZdY2s1U3AGLDsDK3s47y+Euul/ZomO95Rf0L?=
 =?us-ascii?Q?1vip0buVT1FyrBRuuINMb761XI/+e9EMqggLmaQSWHsKtRW+H0ijO49I8e6o?=
 =?us-ascii?Q?4YwG/OksZfyFuXlKAv0aFr2qp0p7yHBY9EB9tM/jgONYU29CHDK1OJfgwi5i?=
 =?us-ascii?Q?ePej26+XQRsPekVhZVehJEdNs3cf+KQrcmLrmQ09IIvRhdCCnpwb6hhTOIsZ?=
 =?us-ascii?Q?o3kVQFDa2hQkHMCyvqdb+1WXDV2Zdkz3S5Datu7dur6a+jY/Z4zfNdQl+76q?=
 =?us-ascii?Q?+w43aY+OBL/J7/o4Gd/kknSaC+x0XB7Fz+czpjqLWj28ujzGKEJUEpvatKhD?=
 =?us-ascii?Q?rBVQynUk+i/U/x0J1HAExFdpnPdyr9QRFBPj7PhWgJki6+Ymb3CL8+2+eRyx?=
 =?us-ascii?Q?JR7kC42cee69JbfMFf1LDhLXTdTkeZqr/RkThj0bW1d0zBMLMOWWZNRKdfKj?=
 =?us-ascii?Q?6ruNOFXOWyljkUcZ8PXb5YMulQ51oNWseTwOeI1zaTrgtlDKcYarWMW/n/eg?=
 =?us-ascii?Q?X6ohgMrm3jxJ0E65A554v10SCG0tEz+e9XIDQ88etlVqsZejNeMFAmUu011u?=
 =?us-ascii?Q?gyYUM9bVO9gshJ+pOhFk8jVa/8yahB//i1CDW/kHip0vzk8O7/AfVh4ScHSV?=
 =?us-ascii?Q?RTM8Y03qlIwRsddx4EkJ8lxrSJFEBl56tX9x43dqnSOiIx6dL/K8RoVwYwYU?=
 =?us-ascii?Q?XsoVtGowbCWJH9SGOrEvOUwGgposS3WbrVSjNp9UZ7VXYbklmHpv1Sqcqyuu?=
 =?us-ascii?Q?/uv+Zqza2BxeS4vxmgu/KJq3SoqEnaHvnE/W8hFhTLPQ/adeHOCS2nM1bHYQ?=
 =?us-ascii?Q?U03i2U4zbWT57QbBevYEmsVVzSyXWWWs6IsDRPPRyPzEz2ciz5sfhQ9/fNdu?=
 =?us-ascii?Q?LB/nbCX8RagEJnni2kdf67s=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84aa8417-bc0f-44cc-96a0-08ddec901d87
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:23:07.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGNhGixeYgaX2ZNWx6z71FQuT7dSLVA7B/VCqqZsxVC8SHVUKiv4zMR/+nQI6yqdNow5AYF9sRWf1DXvnyszzJWdwwP3qNnwGvQvOgvmdg0x/RODt4577ew0Rl73w8JU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14572

Hi Philipp,
Thank you for your review!

On Fri, Sep 05, 2025 at 04:53:54PM +0200, Philipp Zabel wrote:
> On Fr, 2025-09-05 at 16:44 +0200, Tommaso Merciai wrote:
> > Slightly simplify rz_dmac_probe() by using devm_add_action_or_reset()
> > for reset cleanup.
> > 
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > ---
> >  drivers/dma/sh/rz-dmac.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> > index 0b526cc4d24be..0bc11a6038383 100644
> > --- a/drivers/dma/sh/rz-dmac.c
> > +++ b/drivers/dma/sh/rz-dmac.c
> > @@ -905,6 +905,11 @@ static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
> >  	return rz_dmac_parse_of_icu(dev, dmac);
> >  }
> >  
> > +static void rz_dmac_reset_control_assert(void *data)
> > +{
> > +	reset_control_assert(data);
> > +}
> > +
> >  static int rz_dmac_probe(struct platform_device *pdev)
> >  {
> >  	const char *irqname = "error";
> > @@ -977,6 +982,12 @@ static int rz_dmac_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		goto err_pm_runtime_put;
> >  
> > +	ret = devm_add_action_or_reset(&pdev->dev,
> > +				       rz_dmac_reset_control_assert,
> > +				       dmac->rstc);
> > +	if (ret)
> > +		goto err_pm_runtime_put;
> > +
> >  	for (i = 0; i < dmac->n_channels; i++) {
> >  		ret = rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
> >  		if (ret < 0)
> > @@ -1031,7 +1042,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
> >  				  channel->lmdesc.base_dma);
> >  	}
> >  
> > -	reset_control_assert(dmac->rstc);
> >  err_pm_runtime_put:
> >  	pm_runtime_put(&pdev->dev);
> >  
> > @@ -1053,7 +1063,6 @@ static void rz_dmac_remove(struct platform_device *pdev)
> >  				  channel->lmdesc.base,
> >  				  channel->lmdesc.base_dma);
> >  	}
> > -	reset_control_assert(dmac->rstc);
> 
> This patch changes cleanup order by effectively moving the
> reset_control_assert() after pm_runtime_put(). The commit message does
> not explain that this is safe to do.

Agreed. Thanks.

> 
> If this is ok, I'd move the reset_control_assert() up before
> pm_runtime_enable/resume_and_get().

You mean having in the end the following calls:

...
	dmac->rstc = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
	if (IS_ERR(dmac->rstc))
		return dev_err_probe(&pdev->dev, PTR_ERR(dmac->rstc),
				     "failed to get resets\n");

	ret = reset_control_deassert(dmac->rstc);
	if (ret)
		return dev_err_probe(&pdev->dev, ret,
				     "failed to deassert resets\n");

	ret = devm_add_action_or_reset(&pdev->dev,
				       rz_dmac_reset_control_assert,
				       dmac->rstc);
	if (ret)
		return dev_err_probe(&pdev->dev, ret,
				     "failed to register reset cleanup action\n");

	ret = devm_pm_runtime_enable(&pdev->dev);
	if (ret < 0)
		return dev_err_probe(&pdev->dev, ret,
				     "Failed to enable runtime PM\n");
...

Right?
Thanks in advance.


Kind Regards,
Tommaso

> 
> regards
> Philipp

