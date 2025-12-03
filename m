Return-Path: <dmaengine+bounces-7489-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2BFC9F51B
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 15:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A2D6830000AC
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 14:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833BF2FF657;
	Wed,  3 Dec 2025 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="fWMxOIQy"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010043.outbound.protection.outlook.com [52.101.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC52FF649;
	Wed,  3 Dec 2025 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764772811; cv=fail; b=VEr8CqgEqCnc2d7fti50R+TcXdOrvyxo101oCfM+ff2kYoO1q7i0GY86oF/n+HTwc3tbJk26yH/IsAk5VLlFmsQe6f0llFxyJkoM+kyrbNGtUia1pVw4ti18fncEt3uTIfhcIVBG9dGNKb1JjMJM8PrYqFzhCShftaZO7HD/Yp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764772811; c=relaxed/simple;
	bh=7x4h2vqIOPBjldHZaH/gdelVeTo//F9oMUGG+HCPXeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=owr9dxoZsHl7w0n237S4/Bn1f8HI5kGSONB9aeTGtI/0aisUMqCwS6HTotzJ1Dh2VrTwL0EDOWfXV6pGQGnWISwUYK08oLRfeYfKv+2OICIYdpMXbXv2VwU3OT8E+X8SYdLr7kb+Q/8yF3yg3YzmN6peBH+WDKnSLvaPSfJrym8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=fWMxOIQy; arc=fail smtp.client-ip=52.101.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2H1mife5fGJNd0nzHmWRmEGr8FbYtmKgD0eJK8QFGJ2QWsXpw/M+H/9wCkYirhlQEdPIJijjRqpy32sLiOnP5jJi/sENaBYN9NueR6MC9zfsMX6Mf31yr3N8qmkOIepZEAb/FkMCq+kU80YmWcszsLd9SsYhZgyHOn+2lsIlaZGhigBH5uXLTFipBTBM4N4QLmze4ZukfRE/Gg6BvJOPv+pS7jHjSTiJNUC8zfF/1lsJOZ+GKZotk49+D8C9SCDp71z1noJAihdFxxLbs682mKJXjLY6xo3XQ5gTSAzJc9km/bbjhyfWxL27UXnCOnO5935kC2VxZ//LoMhJ5/PDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOQTT/TZu1H8mkLhHgmRNyH+cMZZK7f250r9tFhzJis=;
 b=cHuWtwG2eecbUlJN4FoTYq4RXosathE6e7NwBgP0MUd5QIGwnmMf4NXuMPAuUc6uBawiRQDR90QyYNrrmo32JL7+cxrR2T+OiJP9OHSHJKffej2065FdTIz4Tih5l577G68OjpFoibDp8yk3ykh6L2CcZILksXF1YTOKjs40YjYGp1VClvaMdsrS6FAH3xhqBpBiZrVJ0KQPT/qNHw9tGxhjIqQvuEhltiOteQjYNtwqXWG3HAJ84XcrIOqw3Pe+53on0QSOz4lmLolnym685R+L6z5Ro1kg/R6jC1eROzC9omaa+gfMFd5BlREnj5vO90sD9IeVCWuqe9gLY/6dYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOQTT/TZu1H8mkLhHgmRNyH+cMZZK7f250r9tFhzJis=;
 b=fWMxOIQyb59VYyT+QwCKtWcH99t10eR4ST+gwcwe1KlwmcaB4c0ZjwRonnL1r+fWjThhBCpihphJktSjVb5dmuTB4QVC8XYjR0RUUsdslPRQTfa3I7neE6cFVfBGrwRFavEAqeZpahOdZCnQgS0aJf4knwaSSbZMPuj62QQu86Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB1732.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 14:40:05 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 14:40:05 +0000
Date: Wed, 3 Dec 2025 23:40:04 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, ntb@lists.linux.dev, 
	linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	corbet@lwn.net, vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, 
	allenbh@gmail.com, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, 
	kurt.schwemmer@microsemi.com, logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	robh@kernel.org, jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, 
	pstanner@redhat.com, elfring@users.sourceforge.net, 
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <65awiacvfnqrkjhq6p6zozwnae3jrdqjrz5ownsoyef7bizfc5@7iccbiijl4bh>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aS39gkJS144og1d/@lizhi-Precision-Tower-5810>
 <ddriorsgyjs6klcb6d7pi2u3ah3wxlzku7v2dpyjlo6tmalvfw@yj5dczlkggt6>
 <aS6yIz94PgikWBXf@ryzen>
 <pxvbohmndr3ayktksocqhzhgxbmvpibg3kixqgch2grookrvgq@gx3iqjcskjcu>
 <aTATWZaiqwNfwymD@ryzen>
 <3tgotybip3qw66kyw23po2q63nuykajmus3dtjzs3rw2r34sxb@p47fj2m65kxw>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3tgotybip3qw66kyw23po2q63nuykajmus3dtjzs3rw2r34sxb@p47fj2m65kxw>
X-ClientProxiedBy: TYWPR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::18) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB1732:EE_
X-MS-Office365-Filtering-Correlation-Id: 5211f918-6121-443d-a556-08de3279d995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?otNf1sFoTmQTApxclBsxVr4Y2ZA9DBvx21POKLCTwLHUutCwfp61iw/TDCDD?=
 =?us-ascii?Q?WNgspx10u27MdrO12cr85NeKNmR6offETdfUrEg4ygNjcn3tIQCDGLhTU/ZY?=
 =?us-ascii?Q?OIsY9FPcSxHQp7PQuUghNZK5Nf9ME06GDkUtfbSaa/k1FhFutKmAUTxQGjBY?=
 =?us-ascii?Q?k5GQv6gS0QZc1r8QLXyt2mtlug+u53LXaXrxwZ2OgXiIFaZ30xbYs9UcAJQ6?=
 =?us-ascii?Q?GlVulDfv8y3L0GB8MV1iVa/EISNd79pz/fl+qxN/4PCzZlDX7khb3XTlVsWd?=
 =?us-ascii?Q?lnpEjVJFeUsJxM9tQNtQtW9X2QYlteYKM9JklndWAdN3dmhO9xsNcGGHeZa6?=
 =?us-ascii?Q?EQwlMe0Lqh4mKKShswKWNNw6xOG7ABYT+DyaQhLf+cskXtcS5cPelTkpBgzk?=
 =?us-ascii?Q?fXoKYNgAGx+pWdG+O2RXEL9w3p3WUlyXpnsLL889i83cumYKBaNRP02BWySi?=
 =?us-ascii?Q?Ib48jzc/BnY9se/UlpORCN9zF27kdvPVwR9Dxt2bs0DdPr+ZJ+Q+59J/m6Cr?=
 =?us-ascii?Q?omh/AsxBk1Sb+O06MgG1GreIXzigKkOL0eBN/hwW6Rj9uRmGxuVlE3EmvyHD?=
 =?us-ascii?Q?CPfcmm0Gg0HmfV2y3FHH+CTT4JT9a2V7DKpN1msbsEHlaoM59Sf7qHEDx8+x?=
 =?us-ascii?Q?B77LyAWpHUytDMDeKRv73hgIsOLvexA2ep2RP8/XRaKY1JcDO4qM7GWIs20B?=
 =?us-ascii?Q?9F+UJi/NhpOUOO6QPDZAFflS+IeEjzkQejEmfkGQVrLXX15wQ1k48BtBRzJ0?=
 =?us-ascii?Q?lJSrmLDQrqVjgoohijHW+8Js8b4MtVik14ErF7KyZkIZ18VRg1BPruS9Zsh5?=
 =?us-ascii?Q?VV4gTL41XP/4JMouCL18hGJijfPAcJToKTl8Kj4Jxyc8fly9cWaUyiYmodvr?=
 =?us-ascii?Q?JHkPPtZuTfJzROP5BaXByHSsAGhfhGNwq9+NvwpWX8gwL5J8CXkacFWMIuud?=
 =?us-ascii?Q?3SPcWaMRrQHlolZxvcRPcQT9ZrjNn85NGMNyN4Ub1NPvvtknQsVzzsVeTiwU?=
 =?us-ascii?Q?XNyq1Owb9lFnrCJ4FCC8eQluBd156dv2cB4WXRfCeLRwo7AnxyR1fE9v/5S5?=
 =?us-ascii?Q?y/T0/TIzHJCJEV094A8g+f+HS7FC5pbvfZzGvqLPK5i/y0hAnSUQlTgEfxPS?=
 =?us-ascii?Q?Q5GHJSFbd2FN0ef/rGN9rcHHMmZf+IIRCvBqabYydlK96wdqoIVKsAJBkr5h?=
 =?us-ascii?Q?0uCykmz3Qdj9MBdnGILlS2HBJpMkxhpW+EwJeNlojn5NplzH0mzI80Wl0P5X?=
 =?us-ascii?Q?2INE1IOdj+a2KBOx2s6cDMw5cFLCOG8pV7EB6spFn+KxXbXxfEKqqAjYmC3H?=
 =?us-ascii?Q?AL88NmF/CGKFPqW5y3oIdb57QuIGBVJw+6dGg8XJUkurAHyJtJdWmW48GsE/?=
 =?us-ascii?Q?cmOPZvACpHtnkpX82P8yif04xRDUhFOx7wAYqLJR8Kxg+fsMNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9156iX3BWUccG4Nh3/fXWPOMa5jUsr3znO0AM5tqzhULF813ZpHJl/CbN//v?=
 =?us-ascii?Q?aDHvmBkte7jO7sKGmnqeBCJeRtGe9wFTS1E4uj8H2V7fKQpFkzAO3ti1K806?=
 =?us-ascii?Q?a8grrVzE0jI/TKNZ2jF74H+PGkoTBnpXoT9PA/MUw3Wt4+bElkInMWV0UeOb?=
 =?us-ascii?Q?EPs+TH8H4dQe6399bNV9ZrVzghpqo8hV4bwuijbFRPCEebjiFw6J+2p9jDtm?=
 =?us-ascii?Q?lnCKPEL7E7BF9XiQOOLo5ApTrZ8eV9gBMWQABTduatJp/QSLGaEPKyuMihbf?=
 =?us-ascii?Q?InUmyMJ/Vv2Vbft+L5Ja3yP35sezXhF+MTEb8tgzd5Lgy2qS1Pz8Cy5pmp5n?=
 =?us-ascii?Q?jz4YDmJ/VisfCzicw8M1Zv6rAaPLAlN2pynCYATom5P8JNJblTtODnJlj49g?=
 =?us-ascii?Q?UfcbAoW9939TsFlvfxQUKkNTsA7iD2a/2TJ+uNWwvtMmRw1yY/ds7cEUpyya?=
 =?us-ascii?Q?jadqNeTg1HSea/BASu2EgqkETHumLyEnMqc1RVdaPqYh4T8k8PvEFG0p1G/b?=
 =?us-ascii?Q?n1gQbDDnGv3fG+Z9F5uQuKS9pBbSrHZKRwdwdRdQFJG3qT1g7QqX9Is40EN2?=
 =?us-ascii?Q?xeFklb6K+W4tnwY2aHo5yPmeOypPdd8K3IIT4hYpPvji/BHNWGaMwjPUmgVz?=
 =?us-ascii?Q?km4x7wXTMxLz5AvF6T1Xf8vQQXhKd8QZaNOJNQJ7JFeOeP117fQLO/WlKJ1C?=
 =?us-ascii?Q?WC1phRcNysgVOx5phi3jOhvhyhm5Zp/fTzadlJCiuarJ5XbAuou8GhuVpyuF?=
 =?us-ascii?Q?FIegd/QdQv1KcRM5DVnkUMV8tKFajJ/345tjcrHmhGCS8DHDAf6jeICKE1Rn?=
 =?us-ascii?Q?FeUF2WJShpMBwdHIng/30VDtcYvDQYj8zbkXui52Q+JFTqUHidj4aOqRPWTO?=
 =?us-ascii?Q?2nVY0VLeeq0siY8Yo5o/j+UWGjwD3PZScBFk4hFybk8v7o2mk6qdDKbfFCvs?=
 =?us-ascii?Q?kfEHWoAcaKwdvtAUHMdFSasQf8EtCT5HzsL3MWe0P2LL5wpTcu0VKNzrUsF+?=
 =?us-ascii?Q?bh7FAkpo1aSDVcdZDmTB4KaFT3U2Mv8QWwlSvzOdmQ+p0lREdr4hm/YV9DAG?=
 =?us-ascii?Q?cll2wNx7bEXltpXSoBlasAvWXywbbjcHVACaWTPnpA0hn7CdrGV7txvqVo8M?=
 =?us-ascii?Q?5OK3hwBw4zVkNJR/vSCSY73CJL05OuMxd2zxH+ZNP85aIBhOxhCv1HUWRslK?=
 =?us-ascii?Q?KtaE1hGiHTEg3nY/fBhGvFom0PjcyXW0NMbtVUEi3XPlu2Hsa6a1BhzRUHQP?=
 =?us-ascii?Q?V38XhM0P4GE7ie03gEIATks5zQxnwX0BDS5xlWQxf17nti51aQodkdcc0wOU?=
 =?us-ascii?Q?SYF6p6t2v/SaxBWPQpFnybOMPWLIWRU9IvRuxxLYfvvmuMb9DCHkAwOkeJup?=
 =?us-ascii?Q?/GgJSlrPLsK9jk9c3YvGZYu3T+7mcD2QQ8/g+keAG4X2iCdVH6qsO+0UXBk4?=
 =?us-ascii?Q?7teoM8N+68EVnl0IT/UwHksGb015lj0ZnCaMkZNCryBF+3M1IHdHlwgYb+a1?=
 =?us-ascii?Q?n+Uv2RK+aBL2jaERjqTxNORfp/Q3ESYk3ME3MOBwAFITGrdqc3Y18nRASVYt?=
 =?us-ascii?Q?ZMalY9TnR1nnca1bHdVsMI7ME/psYf78vW0Zwt9jMPQPkva3sypKa5YvIx1V?=
 =?us-ascii?Q?cUz+REl7QgbZ7+UZSbD5SbA=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5211f918-6121-443d-a556-08de3279d995
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 14:40:05.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eaQglUfpxh77gv1Bi9CGtl8Zo+aNDXSB/x5bazwkNdmT4t/BX/rehvWsidpJbKd2JgnO2GrCSyfwf8dLr5UPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1732

On Wed, Dec 03, 2025 at 11:36:31PM +0900, Koichiro Den wrote:
> On Wed, Dec 03, 2025 at 11:39:21AM +0100, Niklas Cassel wrote:
> > On Wed, Dec 03, 2025 at 05:40:45PM +0900, Koichiro Den wrote:
> > > > 
> > > > If we want to improve the dw-edma driver, so that an EPF driver can have
> > > > multiple outstanding transfers, I think the best way forward would be to create
> > > > a new _prep_slave_memcpy() or similar, that does take a direction, and thus
> > > > does not require dmaengine_slave_config() to be called before every
> > > > _prep_slave_memcpy() call.
> > > 
> > > Would dmaengine_prep_slave_single_config(), which Frank tolds us in this
> > > thread, be sufficient?
> > 
> > I think that Frank is suggesting a new dmaengine API,
> > dmaengine_prep_slave_single_config(), which is like
> > dmaengine_prep_slave_single(), but also takes a struct dma_slave_config *
> > as a parameter.
> > 
> > 
> > I really like the idea.
> > I think it would allow us to remove the mutex in nvmet_pci_epf_dma_transfer():
> > https://github.com/torvalds/linux/blob/v6.18/drivers/nvme/target/pci-epf.c#L389-L429
> 
> Thank you for the clarification. I was wondering whether there were any
> particular reasons for covering such a broad window (i.e. from
> dmaengine_prep_slave_sg() to the end of dma_sync_wait()) with the mutex in
> the nvme case (but it seems there are none, right?).
> 
> > 
> > Frank you wrote: "Thanks, we also consider ..."
> > Does that mean that you have any plans to work on this?
> > I would definitely be interested.
> 
> No, I only learned about the idea in this thread. I also think it is a good
> idea, but I would be interested to know why it has not been upstreamed so
> far, I mean, whether there were any technical hurdles. Frank, any input
> would be greatly appreciated.

Oh sorry this part was to Frank. Please disregard my comment here.

Koichiro

> 
> Thank you,
> Koichiro
> 
> > 
> > 
> > Kind regards,
> > Niklas

