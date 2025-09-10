Return-Path: <dmaengine+bounces-6446-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834FDB523A1
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 23:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D16848513E
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 21:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A629312802;
	Wed, 10 Sep 2025 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I+oEKE2+"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE27330F81F;
	Wed, 10 Sep 2025 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540497; cv=fail; b=n3HPU2fS8I0CG3BMTZcElMlk2enkKN3RlXKQNFfAo4Mew6z3cqXtjPUeHswSKaZs9X4xMB1ZO+4B9a4mjcR8ZYfPxSxXIZ0/yyxA+bExerpAdopptHjH17yurQDbxonzXrhxCYu8oI22k0J4RzrAPKUI0aXgnCBPi8qpfbfYYd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540497; c=relaxed/simple;
	bh=WtP91hv8JcAURqNmg6VQlAP3x3myp8ZE6KuyDPI19zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BMiryg8Bcf+BEavdApUzj2L1RyXWtb5j6DyLiELprhmFVbybPuZYZn7a94AnMA6hCTEEsE+GFXsgQJLoL+3Q0/N4c3q3ZSZkEpJzrSvbxd7H8DwX9EqVPBWMMwgYvnS3B2h0tJyPwwjVXDMpLh01lCeC2NZqVk6rhcdM4E0V9uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I+oEKE2+; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaVLIgWUciN172NiLxi6/MPmEcYS78Sdsz8I0Z7gHJ0Sx7w9Xc03MA5xvUf4PjfV7b4No/zn31Bfvd/XiG8/NgbfvKKt2LFkHnwRbnZAQWKqDeBxMwixlog2OVtSciYgjTe7x/y1Z1FWTcRJROCRKOVBwQbKbjF/7e0jo9U+8zPYUNZ98nVDOyAJhUEJs7sdX/wqs8739QoX/2/xPrDNgamfV0tmADJ8P4WPzgq9N5WGiMncC/HAsX9urZuBzuPc9aqvh/Edrc6AaXTEVqAK/kYxtQ/2aDsqxbWoWVNn9ZE8vQ6KhQHll7TYplEgcDEG86ba9e8Fn1bwYSfqSGWFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af/+S34Rq9rvt6mkttHIDDUTIFa8qM8jHz201WxTzfA=;
 b=Xh5kwnMpfnRtue5vy3qBlSD3Nfl2KLf5Abv+60CSScQSZQHVrviCaaHu6kVLVnCzpdRHT2ETU4wyeHt3yFGsPq5FwiXF+BOCNKWDNb+6aknL9KophiOazIt/VHgbQrmdqJScyhry3eQKxXnCwKYOMKQDGg6hQsBuHlK5n0pNLs7nvUrqe+p/IbWpCY8xGo9Eaz9IygGcjTrATNmqLRSDUZZgRZGkLosgZM38jx13BZedy7xaBfrVmxhWNBFMlxD4RonURsSwfB5t3RIU4aDnZFRNq5qLm8Hzwwy2bpQ7cmZVxvyu7AaMuSaldWocx9anwNT2/+NBj0qzPU0WJUNlAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af/+S34Rq9rvt6mkttHIDDUTIFa8qM8jHz201WxTzfA=;
 b=I+oEKE2+kEfGZ713ZB49BYS3LPJzr9uJpMA3TPWcLK3hprA7wKwGIQEV/I15S8I4wcphJZ8i/i8yX0GCrKNoa7Km3CduV4v6M8zKEkqWEPM43kKnKIRuNCtshyNivxs+faE4QWxwyiQGbQGCPpJmYy+W7f8YZLlfjF+cUMRIyd5VMlRYWd8Wn0x1eSq799yyHUXN7/plXG/xhdxFsc/Aa3FxPP8lSomaMA37LJYYgBgwlzCzxS1QYmEEVMIwfG1aTm+avadJEovdpHO76aKj5kQtHbBqwJzl6N4ASlpj4dOQT0OQnvTW3g7yXuL5f22xhDxKwnGeZH9TSP/te3NTgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DU7PR04MB11091.eurprd04.prod.outlook.com (2603:10a6:10:5b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 21:41:31 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 21:41:31 +0000
Date: Wed, 10 Sep 2025 17:41:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] dmaengine: add support for device_link
Message-ID: <aMHwbogOA6QTc3Dm@lizhi-Precision-Tower-5810>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-9-ac7bab629e8b@pengutronix.de>
 <aLhUv+mtr1uZTCth@lizhi-Precision-Tower-5810>
 <20250909120309.5zgez5exbvxn5z3y@pengutronix.de>
 <aMA88W/rDxFesEx+@lizhi-Precision-Tower-5810>
 <20250910193545.gx3qoyjamoxlncqd@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910193545.gx3qoyjamoxlncqd@pengutronix.de>
X-ClientProxiedBy: BYAPR01CA0056.prod.exchangelabs.com (2603:10b6:a03:94::33)
 To DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DU7PR04MB11091:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf72505-42bb-4a8a-0e8a-08ddf0b2c37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iYIfiTtilTKwK3zGgX9QYLHu4po3bmxwefaOfKomtZOUZlRRd6E4xptSUtbJ?=
 =?us-ascii?Q?YANz72gf1wfzo2fsfEN0Wa+Y3v00SqcKahb9guwyNGd35ymGiZs4TxOkkgP6?=
 =?us-ascii?Q?llpRjHWcBqCwE4eRo/It/6iKVIgtogbYedIMXM+HBKdsAJokc20mZR6rQtoc?=
 =?us-ascii?Q?G4/7Pd1/xJ5F562vnp3oaBht5Hhegfve4fggT6WLQGyyPde+tqt+04b4nidL?=
 =?us-ascii?Q?j/lhUsdL2GYAvTjwVlhJW+lrtJXwu71mNk8uxR7IcH88Xpu374pJK34UgKrI?=
 =?us-ascii?Q?8hDGqSDvPlCExzIYGaBfPAVAv5nOW86zWrs13QJe/WmhqS9dxs29NCOQ/qrx?=
 =?us-ascii?Q?JiTrvHmCRKbPxzCeL3oQl+PLdQQ5IRBS0WqiIA68QN8Rftm1LskyNAxP62Um?=
 =?us-ascii?Q?D9MSjBvCpFOdea1o9SsM/KQISXgNbneSVEQ4gN8vxXhr9aYytCEeLysbkNlR?=
 =?us-ascii?Q?aJvLIaXIvRQ/vRUlQKZqFZhSorUNxQmD+FDxC2IRw8moJcUQPNc+YJP0oh1l?=
 =?us-ascii?Q?OlprHLMPnWMjY/xneXYfMb4JdyUX2iCcZaMfUtotqyBsgQJGocc62yLshHlD?=
 =?us-ascii?Q?28UxPAxwDi0dxARAM51RH/2M6SMyANtLay8q/DKVkMQ71MoQ/pZjFK1E8wJe?=
 =?us-ascii?Q?uqydjmmlt4LIMk9kR8JS+csg3WQTQKRQQo06arrAAuy85pnUlKMlrOkvp8QU?=
 =?us-ascii?Q?cL8AmULUfqq+hd8XSqDUOVOVL0LlD6zAlKkTZPR1KRFOjXzgV2SzcuaAOJmR?=
 =?us-ascii?Q?BO935bagEtd/l0eRM1Sezpy2xDqamqESOBLuvM0EEcpq/MwaiUcpXSE5TDLJ?=
 =?us-ascii?Q?RbOT3zk0zwTEpt1ZqOVrKCFo/yrNDYJrqJLdvtrmrDMOzdRWcN3yTBoh8GNp?=
 =?us-ascii?Q?VK6ojFs3Qk2NQD006QPR+Pye+vnbsM84OrDkXO2wggGZB2/rVxIwtJn9fUmm?=
 =?us-ascii?Q?0oz8IDY5cpexLVERsMy4Yv8SImRCNp1I9wFEPGEmaUc08BtW6XBX6ox+TDgU?=
 =?us-ascii?Q?tmUIKhsYSf5vIyjMVEEm+eaubx5YQZujRFRDun9hkW/2yT2avzHJOJDrvbpA?=
 =?us-ascii?Q?zcLywKfppf3HvjmXisPatioBqyVdqlW3kXO3V8o+rAlgePWId8w/yBcb2qEp?=
 =?us-ascii?Q?mFylYg1gUgEyeBuZ4MOMuf5N36MWweFoO+s1uOD4ZTmm1ih6c75fsREhlpuG?=
 =?us-ascii?Q?aXpPM3YmUDb8voWDfXcOyuhfahlBdQCFWV8Ly4ZPyNKC8qun1Qm01Wj2PKqQ?=
 =?us-ascii?Q?vZ8XMduC/p4dRWvqrCnGMtwuXI7UAUsIfGhhzqkWQdNlCOlVsjy8Jql1/uHN?=
 =?us-ascii?Q?BJkSlE084oHp33P82GgjJG12DWnZpHjTSYGOy/tAcg39DJ5JKn/6RtYqkz32?=
 =?us-ascii?Q?q54m3C96sCjOE7WpDna3RAol/0EAmdnrtVsIsGKGMDeGddk1HwDOq3cIWqgQ?=
 =?us-ascii?Q?4+ZmLehJk2Upkpum8f56ZEdXgGAtFqiDJ/j+cwq8S0zqEKfgsZQyW7aUtfMd?=
 =?us-ascii?Q?NGLYSQzr6CTIoDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?msuGYIoDXhj9Dz3GuLGsTdYMFuMIfgBMek2HQXAfILtXzbtm/63le7UHZ1i0?=
 =?us-ascii?Q?/N/Lwcw8bjah7Evdib5BU/+5cLIpNM4vsJqPFK9a7Aw+FHDdx24czYJFklKA?=
 =?us-ascii?Q?JquPsvlAvh9mTXZgaBu4iKDEugMe+WtIkC3VmjBJW89uQM6x+Xg1S32F3L2b?=
 =?us-ascii?Q?jKD9E8SgAdsgrr1z5sGVrjd9xcGDe8nu1ehQUTARS3M92CoccDQnvqazm2fu?=
 =?us-ascii?Q?M4XLlErw787ce6dJKY3Mg4W8WKbLYFpNq2xrg/Wzg+KE2Bjrf3J45lsWHGgs?=
 =?us-ascii?Q?1R/7T2wzRW8rEYRW/ObMGfm4FyELH0DfGTHy8MFl7ah841J5Lj61zHJ4MK68?=
 =?us-ascii?Q?DV8kZjn2JXq5g/ckv4mlCr+XnJrtYHDKLZj8gugTto45MEcwRf2y1fCyb2Dg?=
 =?us-ascii?Q?MuusY0AuGolcjNMAbmLpGWfkmpMDiZIYRNF3zdD+bcDePlFedj9qfZPwPOfp?=
 =?us-ascii?Q?oJlxaBS0jwPElKxywGDRBCPgk0IPH+mEuPnbyw8FFSvATdr+OKd1PYBfgqxa?=
 =?us-ascii?Q?pHo/nkMVIcLoenwz/M4EZUlKPHr6VejWkNZwZNqAcs2fg/5foAilwIkNoCcE?=
 =?us-ascii?Q?0vOl3Z6XbDk7wV6n171HocNc7jhmNucc77QB36z0K4OGc7XVmimyiX7djWy/?=
 =?us-ascii?Q?4jo+2Pk7m6iCJ9j/BaHUPjgDSnwsg58CkIGRQ0zK2Ju9pv69GnlZ4NtECtQZ?=
 =?us-ascii?Q?8U4gNWsXJj9cpOKBptHnPtfN7p79g9+eVk/SaOdqwSxcssn7NcpPeDMmK8x6?=
 =?us-ascii?Q?YH3eQiSbaSxiOc0knot4FXbhEwBStygfkcC8tZog2lbtY5TwLR8bF1OM9fGC?=
 =?us-ascii?Q?ABJWfJnQlAvK3WKZ0SM1wdjCUBWehaaIZJ0bOvUS5bde/eTrdGmWNDFXVrQ8?=
 =?us-ascii?Q?vjbJnkJvDp32iQ6o4U4kdYJuR0gjxewIx3QewdLYbaEZ/NIGxJhptvs67sqI?=
 =?us-ascii?Q?RmdHUREt+G9pFs+z1I2S6ug5p4NWkaNd8W4+kddb8OTvGVtXUyojsT9QmLcd?=
 =?us-ascii?Q?ecmAHKNsvkAM9SNupvDlFU4Qcehru5BzprsLJaUqck3tNwPFDuQbP6JW9Gg7?=
 =?us-ascii?Q?BHCt+nRRwP5yYm9F5h8kcLR+Dk6uYD9XKkmB006CldVDZFz/wPIQdwQBlzgW?=
 =?us-ascii?Q?9MEdLngYSQwBYWBFHva/XuGZw4aNs3v0AkHHGRQ3/Jcdx4d2qztppc0WukVp?=
 =?us-ascii?Q?b6xKjm5GX6niMPTT9K3mkfvofI4DnUWBrwixlMzYx0YzzrELsxZxYTEEEtSz?=
 =?us-ascii?Q?PLMVACvtXNrQjzY88dppmk1pMpl+z1nyrsPHGGGGtT+9pZVvDBjAYRS+VDbc?=
 =?us-ascii?Q?lN2uyHZnwUccj/KeQz1rMIOX7mVPSPqjXG72CKehOIRt1/okczhZrFfSAWCu?=
 =?us-ascii?Q?QBNhAiT66fF1GmSB3hqF9/eQzmgfkw1d4/0e6HbHjN7iwmWLAVkF3aV53O3d?=
 =?us-ascii?Q?JdurO6uxsKRVce6EoWWRL/LtodyrqWG/ElMeMhthwVg7+oTsOAkjlr9kFKa6?=
 =?us-ascii?Q?8iykJPuuITtldYu28DFCWQxRDq/g0HjFKlgwLESjaU3OL3pRp/IzVjQhYQb0?=
 =?us-ascii?Q?rUSY7tkUybUWXdZ6vDcPvhTRsVP84iB530PpqSU2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf72505-42bb-4a8a-0e8a-08ddf0b2c37d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 21:41:31.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vG3hnDOqrUuK8A7CG8wjFs0JnjWXpICIYfrCYKLizw4Y/V0KdLKyjCDbur7RrEh4UFwk7wbAQjagF/D5y3JSfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11091

On Wed, Sep 10, 2025 at 09:35:45PM +0200, Marco Felsch wrote:
> On 25-09-09, Frank Li wrote:
>
> ...
>
> > > > > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > > > > index 758fcd0546d8bde8e8dddc6039848feeb1e24475..a50652bc70b8ce9d4edabfaa781b3432ee47d31e 100644
> > > > > --- a/drivers/dma/dmaengine.c
> > > > > +++ b/drivers/dma/dmaengine.c
> > > > > @@ -817,6 +817,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> > > > >  	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > > >  	struct dma_device *d, *_d;
> > > > >  	struct dma_chan *chan = NULL;
> > > > > +	struct device_link *dl;
> > > > >
> > > > >  	if (is_of_node(fwnode))
> > > > >  		chan = of_dma_request_slave_channel(to_of_node(fwnode), name);
> > > > > @@ -858,6 +859,13 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> > > > >  	/* No functional issue if it fails, users are supposed to test before use */
> > > > >  #endif
> > > > >
> > > > > +	dl = device_link_add(dev, chan->device->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> > > >
> > > > chan->device->dev is dmaengine devices. But some dmaengine's each channel
> > > > have device, consumer should link to chan's device, not dmaengine device
> > > > because some dmaengine support per channel clock\power management.
> > >
> > > I get your point. Can you give me some pointers please? To me it seems
> > > like the dma_chan_dev is only used for sysfs purpose according the
> > > dmaengine.h.
> >
> > Not really, there are other dma engineer already reuse it for other purpose.
> > So It needs update kernel doc for dma_chan_dev.
>
> Can you please provide me some pointers? I checked the kernel code base
> for the struct::dma_chan_dev. I didn't found any references within the
> dmaengine drivers. The only usage I found was for the sysfs purpose.

static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
{
	struct device *chan_dev = &chan->dev->device;
	...
}

>
> > > > chan's device's parent devices is dmaengine devices. it should also work
> > > > for sdma case
> > >
> > > I see, this must be tested of course.
> > > > >         if (chan->device->create_devlink) {
> > > >                 u32 flags = DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER;
> > >
> > > According device_link.rst: using DL_FLAG_STATELESS and
> > > DL_FLAG_AUTOREMOVE_CONSUMER is invalid.
> > >
> > > >                 if (pm_runtime_active(dev))
> > > >                         flags |= DL_FLAG_RPM_ACTIVE;
> > >
> > > This is of course interessting, thanks for the hint.
> > >
> > > > When create device link (apply channel), consume may active.
> > >
> > > I have read it as: "resue the supplier and ensure that the supplier
> > > follows the consumer runtime state".
> > >
> > > >                 dl = device_link_add(chan->slave, &chan->dev->device, flags);
> > >
> > > Huh.. you used the dmaengine device too?
> >
> > /**
> >  * struct dma_chan_dev - relate sysfs device node to backing channel device
> >  * @chan: driver channel device
> >  * @device: sysfs device
> >  * @dev_id: parent dma_device dev_id
> >  * @chan_dma_dev: The channel is using custom/different dma-mapping
> >  * compared to the parent dma_device
> >  */
> > struct dma_chan_dev {
> > 	struct dma_chan *chan;
> > 	struct device device;
> > 	int dev_id;
> > 	bool chan_dma_dev;
> > };
> >
> > struct dma_chan {
> > 	struct dma_device *device; /// this one should be dmaengine
> > 	struct dma_chan_dev *dev; /// this one is pre-chan device.
> > }
>
> I've tested your approach but it turns out that teh dma_chan_dev has no
> driver. Of course we could use the DL_FLAG_STATELESS flag but this is
> described as:
>
> | When driver presence on the supplier is irrelevant and only correct
> | suspend/resume and shutdown ordering is needed, the device link may
> | simply be set up with the ``DL_FLAG_STATELESS`` flag.  In other words,
> | enforcing driver presence on the supplier is optional.
>
> I want to enforce the driver presence, therefore I used the manged flags
> which excludes the DL_FLAG_STATELESS, if I get it right.
>
> Please see the below the debug output:
>
> ** use the dmaengine device as supplier **
>
> device_link_init_status: supplier.dev:30bd0000.dma-controller supplier.drv:imx-sdma supplier.status:0x2 consumer:dev:30840000.spi consumer.drv:spi_imx consumer.status:0x1
> device_link_init_status: supplier.dev:30e10000.dma-controller supplier.drv:imx-sdma supplier.status:0x2 consumer:dev:30c20000.sai consumer.drv:fsl-sai consumer.status:0x1
>
>
> ** use the dma channel device as supplier **
>
> device_link_init_status: supplier.dev:dma0chan0 supplier.drv:no-driver supplier.status:0x0 consumer:dev:30840000.spi consumer.drv:spi_imx consumer.status:0x1
> device_link_init_status: supplier.dev:dma0chan1 supplier.drv:no-driver supplier.status:0x0 consumer:dev:30840000.spi consumer.drv:spi_imx consumer.status:0x1

It should be similar with phy drivers, which phy_create() create individual
phy devices (like dma channel devices).

> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 51 at /drivers/base/core.c:1387 device_links_driver_bound+0x170/0x3a0
> ...
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
>
> As said, I get your point regarding the usage of the dma-channel device
> but I didn't found any reference to a driver which used the dma-channel
> device. Also since I want to have the supply driver to enforced by the
> devlink I don't want to use the DL_FLAG_STATELESS flag.

Maybe add DL_FLAG, link to parent's device driver. Need some time to
investigate more. PHY driver should good example to refer to.

>
> Regarding your point, that some DMA controllers may have seperate clocks
> for each channel: I think this can be handled by the dmaengine driver,
> e.g. via the device_alloc_chan_resources() hook.

device_alloc_chan_resources() is not efficient enough, most driver allocate
channel at probe, so clk of this channel will be always on. ideally, only
when consumer devices is runtime resume state,  turn on dma channel clock.

Frank
>
> @all
> I'm pleased about any input :)
>
> Regards,
>   Marco

