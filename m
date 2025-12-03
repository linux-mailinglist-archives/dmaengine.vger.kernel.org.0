Return-Path: <dmaengine+bounces-7478-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0EDC9E44F
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 09:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80E1C4E10C6
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 08:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371F12D6E7C;
	Wed,  3 Dec 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VhqfBiEU"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011009.outbound.protection.outlook.com [52.101.125.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2E02D6E59;
	Wed,  3 Dec 2025 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764751254; cv=fail; b=B6vFuR/z1EFri6PJFOy7nOM3qvs4ViFMeoxPhIuxamG21Kw4fn3QEeETCP4sGZA9RhAWFgEVjBLwF6ZVML9o/GBaeMl3aHhtSkiMppRGSpFKPb0tvLHCVfVnOOpzF34kDAZgI8uLiD/yR58lZBsj0SdUqZDw4Be7IDf4sUQcBuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764751254; c=relaxed/simple;
	bh=SAeZPiuQhuD36jiIgpfA+78Yu1t6G5sQf1S9Jm357Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iIJT74qV2bHTnd/qdS1hwgKo3QYM7WDvHRydCt5/ErkcqIFM6FfGqRgB3G6x/+IhCy+lqDtVdoOkPg5gdTzDAiXBWwqxVvVyA+Th+C59mFtJBI4C+eezRunPz/lAQgRSL5svddHLMWQd53qIcfpiZH0UipBSSzwiYK70E/COrmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VhqfBiEU; arc=fail smtp.client-ip=52.101.125.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyRIVARU5t0DYbloLNUE4Mpj65JiJvZ8e4QNPaeWF0GclM3a+opGi7DtprwPDlbQ0CJouPJ1JWcURRZZzBYUx2Bn9RbAoPnICylVVNVLM/l/Vn4J6x1qNntTPwFA/jjqDPjEyOu5pZ4RX8yhL0XfkWa4trv8Y901MAMXZVlHyORe9kGtQ6yiCS3dqSAeNLGs5zWUJK9yeasr4BGur/PvYVd2jUuEpmhw0DPcFX2SKb0vbcp01Cy3EEHTU1jM4xx6JBDzEwzyyBXAKt7JNtMcF49VnQnOvCAuv54rQ1Qq2mYXoVRcOJO63NOpetsTkpXCGW1gfVdQTEdeVZWGdLNeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHmQclE2WnFGczkb/wdJ/HHwWnfB0wU1QP4n6TODnPY=;
 b=OF8paEirvLtG9VAK0ZmhgbYTxfmd+uBpZ25nsi1UL3yqvtFbiCfVmR2jnoYXh3hs0YDnsuDkTh+47wrJQjSXy1IngluAgJ8yDP1on5NVuPpVbKq1aXTrdQdKsX4w5Ng+pOw6sraevhqSzC2r2530wsW6+MVyxQ24pR7SEq6KeNk4leJ1V8/8DupQvWQCNAu3cZ2KjC2bl59HyX0vlaZuDF+AN/7J4rNVdLVhl0UtlO54w57KTzr6yrGYOxt27ZoB1QmWhKmBUBKkvP/kreI768Pr5fX7R8c5cgdwO/Gpu97axJMKrKoswMA4rAGyTAHYrl2N6airgyu60vmP/ngGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHmQclE2WnFGczkb/wdJ/HHwWnfB0wU1QP4n6TODnPY=;
 b=VhqfBiEUQPmpjf1RFnaq21ccC0sPBXQKAjp4qYiykT2XMsSRSkmxgh4Cz0tFgE/somjeCMZeQGggNceQbk56peYUvkp4y3PykEij3RGzP73DvNVzmeKy5yOjfMBMEmAF5XU/8JQK4dPaA6Oz+Ui5DGR8jFapTfdGQgVt79Yf27Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYWP286MB1990.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:165::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 08:40:46 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 08:40:46 +0000
Date: Wed, 3 Dec 2025 17:40:45 +0900
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
Message-ID: <pxvbohmndr3ayktksocqhzhgxbmvpibg3kixqgch2grookrvgq@gx3iqjcskjcu>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aS39gkJS144og1d/@lizhi-Precision-Tower-5810>
 <ddriorsgyjs6klcb6d7pi2u3ah3wxlzku7v2dpyjlo6tmalvfw@yj5dczlkggt6>
 <aS6yIz94PgikWBXf@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS6yIz94PgikWBXf@ryzen>
X-ClientProxiedBy: TYWPR01CA0040.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::9) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYWP286MB1990:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbea632-70e5-4dfa-1b65-08de3247a76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DnyYGtYuSWg4eI6eZWnYqiHz5NT1EdpfU7Tnxc8rBWgTsRWPqs4Y+5MrjUzt?=
 =?us-ascii?Q?G70DKt2Zv3l+LO41fJzQw8fxFiO/4MTrVEFQj9t6WPMWFv2qHRhr0Ocj35mH?=
 =?us-ascii?Q?irpW4D6MZWRbx7g0C9PHp4TqAApKlrF7qXm3G7Mo5cRJpt2gNAWe6pw45NXg?=
 =?us-ascii?Q?573v/ybXtd0ITiGFmrsFocZChzJ0m3+tRJ6XoXDe4/vhR5PZJpCJM2ahTiCz?=
 =?us-ascii?Q?2nVGYS8gSNDkr9LNWKqi+pvZZcg5qhY7bc1pMBHxDMOwvX0YYQZof/IcEgr4?=
 =?us-ascii?Q?kFYyByHmZR3/ecNp5aHdMqR6TmET2k4VoRjMkVzmverzAOSe717omiGn/Zuc?=
 =?us-ascii?Q?A8HsTUzZXwRGGximOLcJZEnbyvJ7K7Pnto1D0UYvo3G/Ti9lX+ZrURyYlueh?=
 =?us-ascii?Q?pQ+xPrzD6NrPKwt0oEjIux8HEY4HuWjvCHvZu/LfBapbo8RNVdC4OEF9MUwi?=
 =?us-ascii?Q?BDXIwW5jgnDiIjzo2tj4e+GcVvUs6aLMsFvPbo/r+LaTWBTna+N0p2r8RiNN?=
 =?us-ascii?Q?Z1yjmdRLLSxiIdVC/bs5u1NdrJM1tbe9e4jr8yUnxsea1aJHQWSiv0Uc2/tL?=
 =?us-ascii?Q?en0qQpYjIDTP3NJ4rDB+Z2RsPl1/95l+3BsoxPX3mfKNl1NdwhvJgekoBfBI?=
 =?us-ascii?Q?3qCPrfZp44bomTdCgNnarSuxy0dBp3vumynWKkr2/u3PTGbQY5WuQ4Fp5Wkh?=
 =?us-ascii?Q?m7Et6aNhMAA66P/Bi1Vsv00pInq66vA9gQMmaFP2Fs+mHfB+1Gv0EjYtUOKD?=
 =?us-ascii?Q?HfPQYlIL+P4dmDBaeL6cUqJNkMses5tFN52RlPEf3s0541o1iJq5eadOlRGi?=
 =?us-ascii?Q?Je9ek8qaMmCDBbnEiGZVMj3fJQcW1ZufP91/hhTGqi3XjnmP8Lm4QxZMdwju?=
 =?us-ascii?Q?VUkujoFDOl3Lugm737FrnKPYkk83Z6vdzH5TrhTGf0Sf267elJgBuLRTrZUI?=
 =?us-ascii?Q?RGydO7qOLhiCxx/xNy5ANHKniAumg/Xm/dORTMiOyotVeZm8lAGD92S8Kt9h?=
 =?us-ascii?Q?uygzN/DLpfwX+N6TxsDgCMgL2MyFVAnFxweCLB6BRy91swwFSdAA1tBCfHRT?=
 =?us-ascii?Q?bapNwnNauHteCdLbLP9b+FTigZY498z8WcK9FR4v3U7L7I7Fvpjslj42506/?=
 =?us-ascii?Q?/TlDJdshCupSyycBqY6PxdIdWpRdNLNtaw0QS3Tk82ijJnyzDZDC6xo9S6zt?=
 =?us-ascii?Q?hcBDbfHQNm/kp6feNdS3rfdCkpVf9lKo2Y5fArRdzP4NmUnLCjksu1Iee3Ez?=
 =?us-ascii?Q?/yWzhjtEt/Oyec14WXtD3vQzdCLsCLQE46FVO9lEzNdW4ksNErSkE0ztHldQ?=
 =?us-ascii?Q?9YNPuGlnXoneo+i6UQ8mXcPnyU1VrS1zgN4inBkjFX/acRCVX+25GvyYOFk7?=
 =?us-ascii?Q?H/p6yUzpW7TUxwJ/L7jGNrdQrqGVU4YNUkgmkXWzRDLhRT5wrA26UIZyHChN?=
 =?us-ascii?Q?4nCFyFMasmo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ud4n5zVA0bpOU+zk+rM0H7ptuGTMPQ7QdKiD48XEUT87vYZ8DQsvtGiIDDTh?=
 =?us-ascii?Q?yijBqoJ9JhrVvv73fjU99QkCtl/XjyeSDpok47X5MY8jsnutE+ZdQEGSsPnN?=
 =?us-ascii?Q?pXnOEMOYoL+UAnErc/N69fPQfAd7+5E4qXEAGGVJAj5Vt2uoUUinl6hP9WX4?=
 =?us-ascii?Q?YneJ+L2ksklExx4MBXdql6mNERbojJG9qHmKNNBcEQCbXocWsqVhrXj/QVNB?=
 =?us-ascii?Q?2DsQi/NDVN5AVUM2YIhNZ23i25wd0YmjV3nBNd0ZoHu3ZU7ZbKFR1wSfo7af?=
 =?us-ascii?Q?LAiesFSzfJMdjnqKHJ/VFP/CckZ9y05M/RcyXaozyXZruPQ6IjGwXJOdDTk5?=
 =?us-ascii?Q?AXTpSARQmPjBDl6GR8Xq4ve7AZEQysFdEugOxY5RoP6TJbDF+y/S4ADTuXit?=
 =?us-ascii?Q?LlD6fDAqf6e3fLLK6J3pQB//SsT/egAiMEOdzDFCvPPRYBupi70JG6d3D5/w?=
 =?us-ascii?Q?fGx7XiQVbq4zTOe7nl1mGba8ITK7yej0ioJ8fpWyvqUz9cJpECQacxfot8ZH?=
 =?us-ascii?Q?MsC3VgBA5aBHWNZfwzRmcTtxptpq63eRZ9WAZx4deYhb6HoIEfjeFYTyd8Nx?=
 =?us-ascii?Q?o5pt87VOyRCvpNWmn+I5WAYPwg1u7jd9scVt+Oz2yyizrBaT65oIC+adT1cl?=
 =?us-ascii?Q?kY6AmJhOszB9g8cT/x6EDzz74FJxN+MkbnAx3N+Wu8YocrCqixFmngVkQf/V?=
 =?us-ascii?Q?1Wa3kfEtrAaPkJxgwQhoLbng/oV2A8y76Lio/94DAF1ODS0rRYxmdADNHzne?=
 =?us-ascii?Q?eNdA1KlyNgmMleLvy5keldyR+su6EVNp8dcYd9H20CZemhXszVHpcPB6UCdo?=
 =?us-ascii?Q?1+YQLXdKWMzHO4dmh/zv/RR2NN1CO/nHY5Ytf4kHhbJW4Iz8mPNaysmd3TKc?=
 =?us-ascii?Q?dfpOR/IAZCIboj552GkSZ1rtcfIP0EsXd0NjoZv3t0O3KPouSno4vtGfAu3G?=
 =?us-ascii?Q?+40yysFduecduymaBXxrWTjr4R+vT3tNbrW1YgfMmzUlPH9ZeV0I892dDaLx?=
 =?us-ascii?Q?p6MuTXakiZ4XaOvZrxpcGwaPSp4M9pRmAjxQZsY6jkL3mvevs6E4z27VMoSa?=
 =?us-ascii?Q?ZdKxm1HHxEVaY1eRu67OfkwMHe/KD3A+y7d+qtakeO7RGbyr/acIPlMfy01f?=
 =?us-ascii?Q?n4iB1YCkbH38eGZnpH1vp3t5zJamGWUwcmRZYbRnEIcGbApXyZE+Uuh1+XqE?=
 =?us-ascii?Q?U+h+jw9a8nwWiVKV3M39Iq2tGDvanOjy4l0fObVODMC52uL9kSoCp42RbCpk?=
 =?us-ascii?Q?7Vtu3xVqSnfR7yiIPEWFGtG4UhmEDvxkaYhPAgrn8MVU4YCRig3fO0ec9o+G?=
 =?us-ascii?Q?LHGVObGJwhRRt7tPS2lD77VUhp52d2EZaCd4p/t7YWISo3u4VjUp0CiaD5Rb?=
 =?us-ascii?Q?2dzldAdSn6bFcnrdEe1CKAHCuuUGlHo6YQJlpk0Sfm9rsduXmut2Tv0iQckO?=
 =?us-ascii?Q?N+bKc3ZCu6DxhRrreY0FkO5cIRHCHZiNctlp/S5qJtf5m7gVV5lN2IG+vm7j?=
 =?us-ascii?Q?lV7McJiunXK1BrUt2zRVeJFwnif4YklpXxRADPFS9ILLY0iuEs7NYP0+/mLn?=
 =?us-ascii?Q?5mSpXmKiGiiD7AFp3Z/o3Z4K1Dw86SMI0Df/QPjCdjvqAaj5Y1LW4Q5N80MG?=
 =?us-ascii?Q?LDhejQij+36VGtEXH7iISrA=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbea632-70e5-4dfa-1b65-08de3247a76f
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 08:40:46.7360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4CGGpd8iij9T0D1t2PKi3tao9/G8tc4aX/BXcLf1/LYnpwfqYZ2afL4weQabthd6S9mP5YS0L4CvLmtl4Ge+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB1990

On Tue, Dec 02, 2025 at 10:32:19AM +0100, Niklas Cassel wrote:
> Hello Koichiro,
> 
> On Tue, Dec 02, 2025 at 03:35:36PM +0900, Koichiro Den wrote:
> > On Mon, Dec 01, 2025 at 03:41:38PM -0500, Frank Li wrote:
> > > On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
> > > > dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
> > > > for the MSI target address on every interrupt and tears it down again
> > > > via dw_pcie_ep_unmap_addr().
> > > >
> > > > On systems that heavily use the AXI bridge interface (for example when
> > > > the integrated eDMA engine is active), this means the outbound iATU
> > > > registers are updated while traffic is in flight. The DesignWare
> > > > endpoint spec warns that updating iATU registers in this situation is
> > > > not supported, and the behavior is undefined.
> > > >
> > > > Under high MSI and eDMA load this pattern results in occasional bogus
> > > > outbound transactions and IOMMU faults such as:
> > > >
> > > >   ipmmu-vmsa eed40000.iommu: Unhandled fault: status 0x00001502 iova 0xfe000000
> > > >
> > > 
> > > I agree needn't map/unmap MSI every time. But I think there should be
> > > logic problem behind this. IOMMU report error means page table already
> > > removed, but you still try to access it after that. You'd better find where
> > > access MSI memory after dw_pcie_ep_unmap_addr().
> > 
> > I don't see any other callers that access the MSI region after
> > dw_pcie_ep_unmap_addr(), but I might be missing something. Also, even if I
> > serialize dw_pcie_ep_raise_msi_irq() invocations, the problem still
> > appears.
> > 
> > A couple of details I forgot to describe in the commit message:
> > (1). The IOMMU error is only reported on the RC side.
> > (2). Sometimes there is no IOMMU error printed and the board just freezes (becomes unresponsive).
> > 
> > The faulting iova is 0xfe000000. The iova 0xfe000000 is the base of
> > "addr_space" for R-Car S4 in EP mode:
> > https://github.com/jonmason/ntb/blob/68113d260674/arch/arm64/boot/dts/renesas/r8a779f0.dtsi#L847
> > 
> > So it looks like the EP sometimes issue MWr at "addr_space" base (offset 0),
> > the RC forwards it to its IOMMU (IPMMUHC) and that faults. My working theory
> > is that when the iATU registers are updated under heavy DMA load, the DAR of
> > some in-flight transfer can get corrupted to 0xfe000000. That would match one
> > possible symptom of the undefined behaviour that the DW EPC spec warns about
> > when changing iATU configuration under load.
> 
> For your information, in the NVMe PCI EPF driver:
> https://github.com/torvalds/linux/blob/v6.18/drivers/nvme/target/pci-epf.c#L389-L429
> 
> We take a mutex around the dmaengine_slave_config() and dma_sync_wait() calls,
> because without a mutex, we noticed that having multiple outstanding transfers,
> since the dmaengine_slave_config() specifies the src/dst address, the function
> call would affect other concurrent DMA transfers, leading to corruption because
> of invalid src/dst addresses.
> 
> Having a mutex so that we can only have one outstanding transfer solves these
> issues, but is obviously very bad for performance.

Thank you for the info, it helps a lot.
As for DW eDMA, it seems that at least dmaengine_slave_config() and
dmaengine_prep_slave_sg() needs to be executed under an exclusive
per-dma_chan lock. In hindsight, [RFC PATCH v2 20/27] should've done so,
although I still think it's unrelated to the particular issue addressed by
this commit.

For testing, I tried adding dma_sync_wait() and taking a per-dma_chan mutex
around dmaengine_slave_config() ~ dma_sync_wait() sequence, but the problem
(that often occurs with the IOMMU fault at 0xfe000000) remains under heavy
load if I revert this commit. The diff for the experiment is a bit large
(+117, -89), so I'm not posting it here, but I can do so if that would be
useful.

> 
> 
> I did try to add DMA_MEMCPY support to the dw-edma driver:
> https://lore.kernel.org/linux-pci/20241217160448.199310-4-cassel@kernel.org/
> 
> Since that would allow us to specify both the src and dst address in a single
> dmaengine function call (so that we would no longer need a mutex).
> However, because the eDMA hardware (at least for EDMA_LEGACY_UNROLL) does not
> support transfers between PCI to PCI, only PCI to local DDR or local DDR to
> PCI, using prep_memcpy() is wrong, as it does not take a direction:
> https://lore.kernel.org/linux-pci/Z4jf2s5SaUu3wdJi@ryzen/

Interesting, I didn't know that.

> 
> If we want to improve the dw-edma driver, so that an EPF driver can have
> multiple outstanding transfers, I think the best way forward would be to create
> a new _prep_slave_memcpy() or similar, that does take a direction, and thus
> does not require dmaengine_slave_config() to be called before every
> _prep_slave_memcpy() call.

Would dmaengine_prep_slave_single_config(), which Frank tolds us in this
thread, be sufficient?


Thanks for reviewing,
Koichiro

> 
> 
> Kind regards,
> Niklas

