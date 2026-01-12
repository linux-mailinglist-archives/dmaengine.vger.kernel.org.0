Return-Path: <dmaengine+bounces-8224-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C4FD1531F
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 21:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 339073015034
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 20:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D987301489;
	Mon, 12 Jan 2026 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M2EFPI1R"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69780284898
	for <dmaengine@vger.kernel.org>; Mon, 12 Jan 2026 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249324; cv=fail; b=Y7gPzb0VZzPb6HanqiYwpvu+SUBDv7XMLDxlmGLw3a8CtVKQW6kR3lebq4o1EwjlfY6Yqf6Gpv4UGQimC2BNo5qX6tlPtejEEHZu/TEIt5hbxOKwj1XNvldaeyFnnfmj5tRJZhpw+ccYeIvvgkfj0u4rg03heYZhH4dDSkE6F4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249324; c=relaxed/simple;
	bh=LxMs9J29byxQGd08LFdx97JDGMVNF85rbX4rEHE6H4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oMqR8P8WJimYvnhUUhfesc2Bv6c1VJzpTgsw/TtPyn2ty9B+r1pzmH7+LQAq9aLqMnkf2eUBoVepw0yvx3qpg1BT3Tm/co22DFPNB/LfSchu8jlP74ZPwlztcFIXY2pgd3a/ju8ZYcxTWE3b1FNEq9SzERPhhdpgT2ZY/qXKnyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M2EFPI1R; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/FqNVyr4DxsFYcPWn/77keC1Wv0uB6sQQzvQP/00z2T1WFymDBM13yDA8g2mrjidmTvfeqS0rnxY8UkQbjzwpKhvbQDPMJAyPDs8JuczN5POglp51vZKlY/NsINQHuZmNmAxyRymENZsJ1mFvmVocAueTQGQa7iHmMikPjGeICHl7oHipPS6rgF0+tkB5jWuKoOoNMIdqYQ31kqyb1ym6YW1uJ6yCgV6K9lcwqiQBJO8uYw8iUQjzIRdrGKdx+r+MBGTVdlUP0knNZeXZxCO86zA6+uZMgw5sDfxnLbtdoVvFrQ5uHxyf4r7x2YjV2PzA3TA7Ow9/8O7awhCkYFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+4w7i6ygVMyfPwd/veuGVIvqBe1fEotY9aGVfgZ5pk=;
 b=oB79F1F5pe9hqevN2ohU2SY3POw08jUQ5AULRVzYfXtxjaskuMUCpejPGHE05h0o/wCGgzbT7zTEUbVW+o3AtRblQVVeRt+DbSXumEgljHGcR4FnazeLIBTaiC9ayl9MfNTHA9uxa1q+ObVZnVFttir+xdhp1+Ogzo0ztsk8dSUFdGs8Ev9UMmGuBd/Tc2u7ktESF8zCV0A7LVAYwxNdBAn2+Ad5pn/xw4rVPioFQ+uHHjZkGARoNX2hxPEOBvQgNLBhNEocwC464PS43cWVx+d258iKLcuoQmHpilFTe62rcMliT/BM21tLnLYv4jo307giEVKH0EslVmCdhiSvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+4w7i6ygVMyfPwd/veuGVIvqBe1fEotY9aGVfgZ5pk=;
 b=M2EFPI1RU8O8CwTXPzJGQ26RcKIN2QZc/+VZT1lTfsS+FSSXDbSC7uNauIElSvq5M734IaUrId9QHCzx3ghMg9gn32hXEiW8709pMelxIqaas4gnngkftzum0wUE0BGCR9C6tRs0XR3LEqhOXA1MLSAPIfCUCZ6JR3UMeleEK62OZTue4eI2zpS6c0dAurOZcHp4E5QjCfr4EifC6YckpTUwqF3qydhl0ZHCA1SVZi9aE3V3wFXTTb4g2d8+o8kr6ID1f+AsUDDRLcbT5lX4aq1yG2mCUlmrSSBBoixCCd153vw3QCc7wX+0W5VmaOzWanS9Tygc48ZytG7lbjwOxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV2PR04MB12216.eurprd04.prod.outlook.com (2603:10a6:150:336::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 20:22:00 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 12 Jan 2026
 20:21:59 +0000
Date: Mon, 12 Jan 2026 15:21:53 -0500
From: Frank Li <Frank.li@nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v12 3/3] dmaengine: switchtec-dma: Implement descriptor
 submission
Message-ID: <aWVX4bltwS8I7oos@lizhi-Precision-Tower-5810>
References: <20260112184017.2601-1-logang@deltatee.com>
 <20260112184017.2601-4-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112184017.2601-4-logang@deltatee.com>
X-ClientProxiedBy: PH8P221CA0060.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::9) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV2PR04MB12216:EE_
X-MS-Office365-Filtering-Correlation-Id: eaeb6c7b-e146-4aac-b430-08de52183d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YfLgO55ck9WosAWaHBL1dRj1Age1aWGNht1Z1zMd4gbu9iqWwacgUglr7RBd?=
 =?us-ascii?Q?gZ/tESHIrDmJCp5yyvbo8lo/8I9PdxGCqlYWSoCJReCxRjIgXkO/+5n4wYOS?=
 =?us-ascii?Q?8eKqQR9dNemKV88kKuHh/tZDioH9i/UJkMFK8Q3eM6PyqcEVlXTc6rWNbCsf?=
 =?us-ascii?Q?W+tTG4bIP2axeQC8A+ZIEWvLUfBnOCvXgF6DzxqdOwsBHKB+WnBjjkbpqJsF?=
 =?us-ascii?Q?ocfcaAPf/+YaE56IvX6tcXNHzo1QjiIKTC8ZUrmb6rpk1qxO8vXSphjtqvGV?=
 =?us-ascii?Q?8ESL8T342uwemZPOGdMzRStS1aFyHc1iIeRdq5vrih8ORrhBk2Xp03LiNTg9?=
 =?us-ascii?Q?sPG8Y4ndo7y+WWVcZnfQ0hs/TXMAUtB/WELPouV80TEKky1pzZbd2Oct3S7R?=
 =?us-ascii?Q?1zsN7+pmyu4vk4Ni12K01wv8yWUq1XtTKWOTij9y/oEPcBb4WZvFCwlWhLi1?=
 =?us-ascii?Q?ZKZFMmzvZ3EHOzZyMWRj/11kklmenOUCYzkoi5GRkSmA4RPw88A35SxAh1T9?=
 =?us-ascii?Q?2zl63ZHYnrwo6J8AzXW21La+iYrPWtOblXPV0Y8f/C3bqkJ6Xt+4rTk585MT?=
 =?us-ascii?Q?gOVIPBBEq22Q4+SMA2hhUxAI3iuqU0sBRK5GkNuIK3rtcSVxBoaWUZlKbzl/?=
 =?us-ascii?Q?vd4+X1hiX4eZNw1mm+jVI9kIYcGlj3Bqdl1dM6baCGgU88+oeGI+hu+hUQ8r?=
 =?us-ascii?Q?jqRct6Ywig0drOO2PTAszX9B5DgDCZbyicfd1c+cIrARDFBKW06Ods3BoTl9?=
 =?us-ascii?Q?Gf4ag9/i9gFcLcs0OTVskdQSu2J2bfPniK364q/EfegO+s/PrLBShKTKclLA?=
 =?us-ascii?Q?7GfTXSxSCAkTr8fWmm6S+bB5qD9PsBl9Tk6/nBw7z1hTyS7rUYOZSvCHBzn+?=
 =?us-ascii?Q?R6HeFh8mC414DNfiEwZwMyK7nAIvw/aHpxIkcnSE2MWRakzlTe0XsKhLWu3B?=
 =?us-ascii?Q?osoHxFylZCQcwQ6gvslFMQQROaf3839opZUVkxzdRLgHP00VdviPWexlbVMk?=
 =?us-ascii?Q?USJDxDXHYd/R7nWvuKBTBhtP7M6Dqm74WSNgstZX9RXP0hxr9pwMFUefK6va?=
 =?us-ascii?Q?i1SwlLZUhMcmyu18mt1lCpnpgvXA3ZIpjpxzbaWUK4uYniMz74jVn5lUBvpy?=
 =?us-ascii?Q?Aq1eJPUdpjnhheaaWm/CCUhy/FErV6nkG4ZEF/b8PGL8xtK9Ilupcz/JMRYk?=
 =?us-ascii?Q?++KQ3iN6ic7r3iFuZk0kY7Pg86VYVFlQ/XPrm5qsbjw15BHVNPrwV3Cg2pK+?=
 =?us-ascii?Q?LZbyZOOHDpHJ51Vh65Hxcx6/GeqWaBSK+4ORsGUxmnb2biMvkZVdUMyefxdN?=
 =?us-ascii?Q?ZmHQDkc+B14kk+WnvjEqjkWi1y5o8bFQpUzvV9JFLqgAPklMjGGrArkZYGaT?=
 =?us-ascii?Q?SnPOUiL4Fbukr7n2OK4E3wl9+uZ8eLWRS0ugx2VK88hpxiSHVzyM4S3sxZpX?=
 =?us-ascii?Q?bvS3jyNZ3WOdkw4pSFXxZLaL7L2B5VXzBZBc7e10TkS9pGb4DW/ZC9U+nBBX?=
 =?us-ascii?Q?2PDwjF1j8Z8BDiXZqgfiZ0+O/esD2HC2Ox/i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zrr2DC7tTGVaEwOLDXb7DIGpHRpuiRzkhwuJP0g7GNaKfAzNme8BKKW6ow6S?=
 =?us-ascii?Q?rdRum/chcB8tJguIdD2wPaAMgzBqW8UvEyOScFydmSm8RQMFF8VoxG4tNbWY?=
 =?us-ascii?Q?Ddz6PH74qUpNtbRBDyYEEOac9l7Nw1QaKtrwQn5Hweg4LMBU/Ea2FbNc6Jha?=
 =?us-ascii?Q?ryJzRlMFQzCIY8tPjyty1tmy/nXiUuLxQmmXC4GhcUzWz1AyQYCKL34mPiYJ?=
 =?us-ascii?Q?zdkbhSE5ugY+4iTZpbel8TjNU4fNXf2M9vp+NNyf8H7uZtEZuQ+SLExxg6UD?=
 =?us-ascii?Q?MwUWstgHukBioIrEH2DUAQdS8WiQPBLBCAEsX7sqv3rZwq0MrzODE+DoUF1k?=
 =?us-ascii?Q?vOfG2TRB3kmHpEkm95W90sOm1JdHsT6Hj39LCvby+tRjU2dsYrplqYBGxuI/?=
 =?us-ascii?Q?WYiIJUwFY+6dXymad9dTl3v5+2Qo/IfbjZCW2AbgwKvqWPdn+oR7tOrNVqNC?=
 =?us-ascii?Q?xoYIUkwNVBt7NGEDZfJ1cYwCwr3ef5FACi9V/BXh9Eb0808Udkz7HpmdS52R?=
 =?us-ascii?Q?iy5mXlMxLuxr6PpfvviwTK9n2OQM1VMtegn/bZxmsU36bFNiwgoE6VIUy68U?=
 =?us-ascii?Q?/bMwxK7Q2VXUQQXrkovJD58iDWGNkUlpkDBnCZveqQVXLai6Fe2vT68bd5mQ?=
 =?us-ascii?Q?7Xdq9oL09f/XnGjgXTzUshbzCrk8uGgUkZQ6JepnU7oTzozozCW+nXwuo3rf?=
 =?us-ascii?Q?g+ge8rqX/ESepOgd/Igb3xMHoPX2VYXNkULIS1hrQulLEZKDw9SCbNTEufLD?=
 =?us-ascii?Q?GUZvdtfsUDuyLu/dfP2Vb+7sMyOu1udpqofgMFbn6ObKr6dWKUORrTyae8nD?=
 =?us-ascii?Q?/Zse+NvEFo7nGMQJRDr1XYbcEkgLYe+fK2CAw02JyHYKW93lMCkf3RjsVXNF?=
 =?us-ascii?Q?GRDtHrhvI46HhSKATaLOAAckKcyCKjnfT0mTxq6yBaLCnJkvuheyGMPgFjj0?=
 =?us-ascii?Q?YN4qYyBJ4WZstOwrGKc9gtw/r41j2LA3bLkQ86aLueG6LQwtBnk2QLFZvq9L?=
 =?us-ascii?Q?8hCFOBgZdN8La85t1K542y+jqAZz1ASkuIVJkSTXZgJrZvdF3r7urs6/iqdw?=
 =?us-ascii?Q?yhkMUkSMoFmdat2lkomx6ojp+zgAYuLaTUDSBMWa46jaxc138n55VOS2eRYM?=
 =?us-ascii?Q?EJMFYTc5egMU4wlWMJfZsqFYpMya9BFt0uwEnptxaEmKEcbCRqnWmsQp4NyM?=
 =?us-ascii?Q?lrve56VYSDF3FfHnQlLVtwPByq+Vqv7W70bS+4+DM/kwQcyNshDDnWq1IlQ4?=
 =?us-ascii?Q?Vga73krw4kAPC6eH9KOsvXWIEysNuuvqETVC0AqMooz60QO1SptzQxp6X/BS?=
 =?us-ascii?Q?3kkem3dEXMHBNFEEcjhtmrB6N0gglTcBE+GaLAZCyprFrHzod23iJjWjdm98?=
 =?us-ascii?Q?i9JdjN5wIZXG+vZWJSKLzRxERU+0g6QFiXyrxiJxwWRF7yxlOlEYW0y2mM6N?=
 =?us-ascii?Q?5PQVWbgbV4Fu+U9b+11WU97zkWUqsrcLVYzlPnSXzeun6zQs0QfQ9iCF6sdY?=
 =?us-ascii?Q?jU8nU6cEp8f95Wx1dMWXgjIQtnQa546fYjpb7uFI9ihOrG1z4I5Owe6BJj8Z?=
 =?us-ascii?Q?LaApItBZJRo4vVdxCHPlPBY1XZeYCo7VMeL7n3br6rjW9JlsJR8MZjzsigDO?=
 =?us-ascii?Q?6bVpwSD2r/b2JjMBV2TOPJY19xMGyoiAXAlsnMT/BxFlJW9mwvriiQlDvkFz?=
 =?us-ascii?Q?EzCKM2eRMVhn9wqWIsK4X17GeO45JCH4Xvyv2+cmreaLGh0aJ4Fcj2krOU4N?=
 =?us-ascii?Q?G+4g/NYfMg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaeb6c7b-e146-4aac-b430-08de52183d6e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 20:21:59.8022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTbV9/t4RY7yELj5nYnBKX3DrWOGX3EpBaCHX+352Z9SUan3uXuj5sVoiOkfgndVNkE9iDUTjQvms3Lhwd2eLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12216

On Mon, Jan 12, 2026 at 11:40:17AM -0700, Logan Gunthorpe wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
>
> On prep, a spin lock is taken and the next entry in the circular buffer
> is filled. On submit, the spin lock just needs to be released as the
> requests are already pending.
>
> When switchtec_dma_issue_pending() is called, the sq_tail register
> is written to indicate there are new jobs for the dma engine to start
> on.
>
> Pause and resume operations are implemented by writing to a control
> register.
>
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Co-developed-by: George Ge <george.ge@microchip.com>
> Signed-off-by: George Ge <george.ge@microchip.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/dma/switchtec_dma.c | 231 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 231 insertions(+)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 78cfeffed9a1..3b75a20e83c9 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -32,6 +32,8 @@ MODULE_AUTHOR("Kelvin Cao");
>  #define SWITCHTEC_REG_SE_BUF_CNT	0x98
>  #define SWITCHTEC_REG_SE_BUF_BASE	0x9a
>
> +#define SWITCHTEC_DESC_MAX_SIZE		0x100000
> +
>  #define SWITCHTEC_CHAN_CTRL_PAUSE	BIT(0)
>  #define SWITCHTEC_CHAN_CTRL_HALT	BIT(1)
>  #define SWITCHTEC_CHAN_CTRL_RESET	BIT(2)
> @@ -41,6 +43,8 @@ MODULE_AUTHOR("Kelvin Cao");
>  #define SWITCHTEC_CHAN_STS_HALTED	BIT(10)
>  #define SWITCHTEC_CHAN_STS_PAUSED_MASK	GENMASK(29, 13)
>
> +#define SWITCHTEC_INVALID_HFID 0xffff
> +
>  #define SWITCHTEC_DMA_SQ_SIZE	SZ_32K
>  #define SWITCHTEC_DMA_CQ_SIZE	SZ_32K
>
> @@ -204,6 +208,11 @@ struct switchtec_dma_hw_se_desc {
>  	__le16 sfid;
>  };
>
> +#define SWITCHTEC_SE_DFM		BIT(5)
> +#define SWITCHTEC_SE_LIOF		BIT(6)
> +#define SWITCHTEC_SE_BRR		BIT(7)
> +#define SWITCHTEC_SE_CID_MASK		GENMASK(15, 0)
> +
>  #define SWITCHTEC_CE_SC_LEN_ERR		BIT(0)
>  #define SWITCHTEC_CE_SC_UR		BIT(1)
>  #define SWITCHTEC_CE_SC_CA		BIT(2)
> @@ -603,6 +612,220 @@ static void switchtec_dma_synchronize(struct dma_chan *chan)
>  	spin_unlock_bh(&swdma_chan->complete_lock);
>  }
>
> +static struct dma_async_tx_descriptor *
> +switchtec_dma_prep_desc(struct dma_chan *c, u16 dst_fid, dma_addr_t dma_dst,
> +			u16 src_fid, dma_addr_t dma_src, u64 data,
> +			size_t len, unsigned long flags)
> +	__acquires(swdma_chan->submit_lock)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(c, struct switchtec_dma_chan, dma_chan);
> +	struct switchtec_dma_desc *desc;
> +	int head, tail;
> +
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +
> +	if (!swdma_chan->ring_active)
> +		goto err_unlock;
> +
> +	tail = READ_ONCE(swdma_chan->tail);
> +	head = swdma_chan->head;
> +
> +	if (!CIRC_SPACE(head, tail, SWITCHTEC_DMA_RING_SIZE))
> +		goto err_unlock;
> +
> +	desc = swdma_chan->desc_ring[head];
> +
> +	if (src_fid != SWITCHTEC_INVALID_HFID &&
> +	    dst_fid != SWITCHTEC_INVALID_HFID)
> +		desc->hw->ctrl |= SWITCHTEC_SE_DFM;
> +
> +	if (flags & DMA_PREP_INTERRUPT)
> +		desc->hw->ctrl |= SWITCHTEC_SE_LIOF;
> +
> +	if (flags & DMA_PREP_FENCE)
> +		desc->hw->ctrl |= SWITCHTEC_SE_BRR;
> +
> +	desc->txd.flags = flags;
> +
> +	desc->completed = false;
> +	desc->hw->opc = SWITCHTEC_DMA_OPC_MEMCPY;
> +	desc->hw->addr_lo = cpu_to_le32(lower_32_bits(dma_src));
> +	desc->hw->addr_hi = cpu_to_le32(upper_32_bits(dma_src));
> +	desc->hw->daddr_lo = cpu_to_le32(lower_32_bits(dma_dst));
> +	desc->hw->daddr_hi = cpu_to_le32(upper_32_bits(dma_dst));
> +	desc->hw->byte_cnt = cpu_to_le32(len);
> +	desc->hw->tlp_setting = 0;
> +	desc->hw->dfid = cpu_to_le16(dst_fid);
> +	desc->hw->sfid = cpu_to_le16(src_fid);
> +	swdma_chan->cid &= SWITCHTEC_SE_CID_MASK;
> +	desc->hw->cid = cpu_to_le16(swdma_chan->cid++);
> +	desc->orig_size = len;
> +
> +	/* return with the lock held, it will be released in tx_submit */
> +
> +	return &desc->txd;
> +
> +err_unlock:
> +	/*
> +	 * Keep sparse happy by restoring an even lock count on
> +	 * this lock.
> +	 */
> +	__acquire(swdma_chan->submit_lock);
> +
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +	return NULL;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +switchtec_dma_prep_memcpy(struct dma_chan *c, dma_addr_t dma_dst,
> +			  dma_addr_t dma_src, size_t len, unsigned long flags)
> +	__acquires(swdma_chan->submit_lock)
> +{
> +	if (len > SWITCHTEC_DESC_MAX_SIZE) {
> +		/*
> +		 * Keep sparse happy by restoring an even lock count on
> +		 * this lock.
> +		 */
> +		__acquire(swdma_chan->submit_lock);
> +		return NULL;
> +	}
> +
> +	return switchtec_dma_prep_desc(c, SWITCHTEC_INVALID_HFID, dma_dst,
> +				       SWITCHTEC_INVALID_HFID, dma_src, 0, len,
> +				       flags);
> +}
> +
> +static dma_cookie_t
> +switchtec_dma_tx_submit(struct dma_async_tx_descriptor *desc)
> +	__releases(swdma_chan->submit_lock)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(desc->chan, struct switchtec_dma_chan, dma_chan);
> +	dma_cookie_t cookie;
> +	int head;
> +
> +	head = swdma_chan->head + 1;
> +	head &= SWITCHTEC_DMA_RING_SIZE - 1;
> +
> +	/*
> +	 * Ensure the desc updates are visible before updating the head index
> +	 */
> +	smp_store_release(&swdma_chan->head, head);
> +
> +	cookie = dma_cookie_assign(desc);
> +
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	return cookie;
> +}
> +
> +static enum dma_status switchtec_dma_tx_status(struct dma_chan *chan,
> +		dma_cookie_t cookie, struct dma_tx_state *txstate)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	enum dma_status ret;
> +
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +	if (ret == DMA_COMPLETE)
> +		return ret;
> +
> +	/*
> +	 * For jobs where the interrupts are disabled, this is the only place
> +	 * to process the completions returned by the hardware. Callers that
> +	 * disable interrupts must call tx_status() to determine when a job
> +	 * is done, so it is safe to process completions here. If a job has
> +	 * interrupts enabled, then the completions will normally be processed
> +	 * in the tasklet that is triggered by the interrupt and tx_status()
> +	 * does not need to be called.
> +	 */
> +	switchtec_dma_cleanup_completed(swdma_chan);
> +
> +	return dma_cookie_status(chan, cookie, txstate);
> +}
> +
> +static void switchtec_dma_issue_pending(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
> +
> +	/*
> +	 * Ensure the desc updates are visible before starting the
> +	 * DMA engine.
> +	 */
> +	wmb();

Are you sure need wmb() here?  suppose writew() already include dma_wmb().

Frank
> +
> +	/*
> +	 * The sq_tail register is actually for the head of the
> +	 * submisssion queue. Chip has the opposite define of head/tail
> +	 * to the Linux kernel.
> +	 */
> +
> +	rcu_read_lock();
> +	if (!rcu_dereference(swdma_dev->pdev)) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +	writew(swdma_chan->head, &swdma_chan->mmio_chan_hw->sq_tail);
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	rcu_read_unlock();
> +}
> +
> +static int switchtec_dma_pause(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto unlock_and_exit;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(SWITCHTEC_CHAN_CTRL_PAUSE, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_PAUSED, true);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static int switchtec_dma_resume(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto unlock_and_exit;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(0, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_PAUSED, false);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
>  static void switchtec_dma_desc_task(unsigned long data)
>  {
>  	struct switchtec_dma_chan *swdma_chan = (void *)data;
> @@ -721,6 +944,7 @@ static int switchtec_dma_alloc_desc(struct switchtec_dma_chan *swdma_chan)
>  		}
>
>  		dma_async_tx_descriptor_init(&desc->txd, &swdma_chan->dma_chan);
> +		desc->txd.tx_submit = switchtec_dma_tx_submit;
>  		desc->hw = &swdma_chan->hw_sq[i];
>  		desc->completed = true;
>
> @@ -1047,10 +1271,17 @@ static int switchtec_dma_create(struct pci_dev *pdev)
>
>  	dma = &swdma_dev->dma_dev;
>  	dma->copy_align = DMAENGINE_ALIGN_8_BYTES;
> +	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
> +	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
>  	dma->dev = get_device(&pdev->dev);
>
>  	dma->device_alloc_chan_resources = switchtec_dma_alloc_chan_resources;
>  	dma->device_free_chan_resources = switchtec_dma_free_chan_resources;
> +	dma->device_prep_dma_memcpy = switchtec_dma_prep_memcpy;
> +	dma->device_tx_status = switchtec_dma_tx_status;
> +	dma->device_issue_pending = switchtec_dma_issue_pending;
> +	dma->device_pause = switchtec_dma_pause;
> +	dma->device_resume = switchtec_dma_resume;
>  	dma->device_terminate_all = switchtec_dma_terminate_all;
>  	dma->device_synchronize = switchtec_dma_synchronize;
>  	dma->device_release = switchtec_dma_release;
> --
> 2.47.3
>

