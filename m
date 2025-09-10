Return-Path: <dmaengine+bounces-6442-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B77B51C70
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 17:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBE71602DF
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E3C326D67;
	Wed, 10 Sep 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TpSV9Lih"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE230F53B;
	Wed, 10 Sep 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519481; cv=fail; b=cdTWDdgvtmQMG1lIbOs4cuWqze7+kT6DgtIKTz5ezduh2XbC+4UmRD8V/f6DIzyXw5Dhv1SGNsRBoKqWNs9Z62R+GHBFOG8eB7msVGaHy7RplLUgodjaulP/VXnwTHwvBfokNCoQ31m6ok7lWFmY0+oHGJ653sO9YtiBDX/ippk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519481; c=relaxed/simple;
	bh=HHOGnPzFkgkngHD5FJAKSzyqCblLVaqpHHij4hJAjSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QfZyVl2KOvkmEhoUIOzZUu4gc44snNz97dASfX1Umjx39WzBM4eGqyjmgBU3tfoPy+rQCTfptHgJgbeQeA6shB4jSdFGrIixG1+fqYNM3/LCPIyv4iaq9z+P0aC7IwiS4qnBNUBju7SckA64BHbXsMGuuvqeQKU92++pHTCrcpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TpSV9Lih; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLRpwhSS/EQHGUYAFA+cPnRzebiRZ98ga1sQMFGoabu5IrcISo9V/ZvefLSBgab642RJAdE0B0ZavDKSFDRwAgZyszCf36qiBk2S2EJiI3OI4P/inyeQubKKntD1Hf7iK5EH/nYpp3GkAAQtL1MNrbKE8zOInul07X3f+iEvr+cqYb+8ojxUaX0/k2ts89MCrUsCg+YJlUKr6kdglURkMTT9R/Oh/EKCgO4a62MkFu/Y41zPWa7XH71xtjIAtbiTv14y/S2BSlK+om3d8XaVRUriTkhSMpsQKNMvC/vojsq5NvSoeKMCy8GF8YsFYknmofqpHIZeWHl7Qnib0vN23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSOgC1eeyMdAELTsK0P/GnbVA0gjGCKbUHQZOcvwNDQ=;
 b=W3JI1l5ELvnG0Tp6q67JHoz45kkWsXqwBwPYhylAtaTTv5ayTv3yS8Umsv0u31R23f5XM3NF5tQfac7rXSzqWEUepbDsy/g8mbhlOd7BgHR1YF3djw0t1t2jR71z6iFRkH98MJFXGVnwByrMNNua6+rPXWh5B4z7XQsVg6Xg/Q4sr6u3lKcDMEybJ/eMbp4JvWFp3lhmHOTJBoz53NQtRvoR6KRaxW4ldmHMcKTF2vjNxiuvd7Scqx+4MQ9Z9oKUgixLpKVg3YaV0UUslGd3bwFvmQ5BBCvU5ik+9msYzUUGd1t3glwl37rRL4AltEsTMUAC4n+47HiaYPKdYEpVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSOgC1eeyMdAELTsK0P/GnbVA0gjGCKbUHQZOcvwNDQ=;
 b=TpSV9LihiZk7fL+2fZAOr156pLF1UQ4Kg4XQJw2UcWpm2SUhi6p2wt6gji6hJc2LbH2GV0YH7Fvpl/EDR51qp07BEHGEGj4OAIBmOOYHrxTjhhCcPJ+U2VVAIui6t8TIEuIL2VTZLHuigDOi9cVk1uVZOBPxiUhW5UhNX39EAyb3wRhop09cnXw3ktPpNH6+/pbw8k6D8fge9uwBVSrDDCjnoamTDgFjXKKTTZ0yd+vmtEOYd3XT+swXr7XCE54kd1LiPpfcFI221G7z6+C/w5bfP8EEWQF+KQ0VCeJ9TxPb+eQ5IGNT2U67bAm5f5kq5NqOH1GUpEwLgDxMpNkiQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM9PR04MB8825.eurprd04.prod.outlook.com (2603:10a6:20b:408::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Wed, 10 Sep
 2025 15:51:16 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 15:51:15 +0000
Date: Wed, 10 Sep 2025 11:51:08 -0400
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
Message-ID: <aMGebFhZYrFmHnH7@lizhi-Precision-Tower-5810>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-9-ac7bab629e8b@pengutronix.de>
 <aLhUv+mtr1uZTCth@lizhi-Precision-Tower-5810>
 <20250909120309.5zgez5exbvxn5z3y@pengutronix.de>
 <aMA88W/rDxFesEx+@lizhi-Precision-Tower-5810>
 <20250910093428.qq5vskqhvumgjsow@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910093428.qq5vskqhvumgjsow@pengutronix.de>
X-ClientProxiedBy: PH8PR15CA0001.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::13) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM9PR04MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: ea973848-3de0-433c-6fba-08ddf081e002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KlPj7VanViP+d4H3+KuTShHfYk7mtZDPAryDqVBFoNRAXT6IGoXnmuywbVeO?=
 =?us-ascii?Q?zbrouXav3F952Vcym2sB1A/XBDAS5+UnH0S+R9wTZDxn4DGW7tL1d62b+X1S?=
 =?us-ascii?Q?k7eA6+h0lIjGR5Ljv8h8shZUPM4fINVwyyoWy7U/0XCJmrggwDCgVJ1FuC0D?=
 =?us-ascii?Q?1IcLjXUO8JTnSO5wu4kBJ2x1JuQLWbsQK18gF+QO4e3dQD0U1NEeyY+Q/8YH?=
 =?us-ascii?Q?gH1Huo7cFmqalC8wpa+9uigjhmlmcK/rNAsxlzyvanO0fFZ3n/b5Mh3NTXQw?=
 =?us-ascii?Q?zL1snLJjV0i4teyC89nhSql1WGwTAZU+ihvhpnv2Z9LxTcqTMQBKmcuWEbW7?=
 =?us-ascii?Q?8dT85+Sn7N6qEaJqJ/MsPE7VmS+piJ4I75Xkwe5X6qTUaYQHz7wY3Z+zUR9c?=
 =?us-ascii?Q?FJeo11CQvAJRdPHurTwGd1PRxS45r74PsOfIYUjQY+C7QCOlsW2WoMhqKlFP?=
 =?us-ascii?Q?Kv8ri/e2ScLzDz1z/rF0mfqeOB83xmkApSvbPm24aqhwrCoOPnkNuDw21O75?=
 =?us-ascii?Q?RM9AmsF4K2b4VK5Tk1BuL02ktc45qSTQeiee4ZmOhTRE4+/qo88WK/JyomDZ?=
 =?us-ascii?Q?QLTdYA0qEvT7DFUO6KbO9jEVjiFdRRKA5ScBcw4o1PzD6FYmylieUpZoEfkP?=
 =?us-ascii?Q?OdXX706u2SVtFjT7Wiy3I9RnjcbzNRB8/6tKICN/kjhAJU3gN6WRc/ocApay?=
 =?us-ascii?Q?d9RyB7XSOJMjWtL2RKhnUSU4Hffv3qn5rl9JxUMYLtZJqNwvBcjAcElQpAWE?=
 =?us-ascii?Q?Q2IP7pyjNQmUpgM6rkb1297lnMz29zbOVnYb514g7n6O3uqErYzInDboMprH?=
 =?us-ascii?Q?hWIA0Zfh3NxsSY5ebI2fLF+E/T+n7s4BWl3Pk0YAJ6g0J/FhQS+kO4Jb+avV?=
 =?us-ascii?Q?DpLnnGXKIEikUsRG5BZ5LLU0e5h9czQtUiNMcZU9+vvibAz9Y+I+D9K47dk9?=
 =?us-ascii?Q?YBCuCO908uLEX8fvvTkJuXz7v3/92n7m4bckWJBiGfG+/ZaWUXRm2w4MbUPb?=
 =?us-ascii?Q?tCFea0SdttRP/L6lASnjIjYkT0XVMswlbppMxJSPzw4SxHCd1/VKE27AqW69?=
 =?us-ascii?Q?dWwJ+a6e0AvV1RMrySAiFDAKu4dBVrf+44XO50rl5M5m0wFJ5ZKPvmkRS8Xk?=
 =?us-ascii?Q?joHngOnFkdRgoMu0hO+7ObJb4Qj8umROh4IZ2u1JQp+EQYBCpdN4gx/g5sqR?=
 =?us-ascii?Q?kXbcqgdcoUf3/9hNQdEy0ktIqop+9L1a01ITj5iInkMc0ol8k2Uxn2W6gz0s?=
 =?us-ascii?Q?5L0lIzCgijG8bWblXwoHZ23o3AHbI5AnDJyM+3tP1haAKsP0Bb9JDl79cgfR?=
 =?us-ascii?Q?0mrDf1zDRYPZPmuik9sIjNgf4PI/pI5dsycNMxswPhugZ5GA6uyC1epkP0QF?=
 =?us-ascii?Q?hQma1/qElCga4GIaVr8ZceUioziF6q+NNc28x9P4dbzpVgCKlZLG0e4YNoHK?=
 =?us-ascii?Q?KKIsyFNXQf166xpJ69i5ErZnxskPPVgb7xSOX1Njomf6n4mVJ/nFr6+kAS6m?=
 =?us-ascii?Q?sfZYm6s4+KW/05c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7AL1MGZ5z1S1VvrDOgzd5+mg/1rUyp+ZaWxJSlzuDA81WTo1v50KaSvOIRWJ?=
 =?us-ascii?Q?+rdHLEwE4KP7A0GKFAFU14OT6ppeTJ0s8dZKWPnAdxiiWDxp2y9ABgE2+ipp?=
 =?us-ascii?Q?ZYXNUotmDh9e8NhT4FaIAXPpA8wCJt+ZE5SVwfDLclZrW/t93WgbhgtkDXCj?=
 =?us-ascii?Q?TWNra923h8XotDmI1cGdTQ7dUAQlo81QTmImL8Co0PAMl0S6agKjdsY8Beef?=
 =?us-ascii?Q?QsPO9gWHsk+mlZ4RVlIuVH5lN/zBJYfT+rGwrAtocmr223FPycedLHwbmLCJ?=
 =?us-ascii?Q?HWAHv1UkN/72oaEMv1AK/1bQz1ltQ1plRUWMLsDz5LjquS2qDVTHukO5Isg2?=
 =?us-ascii?Q?L/ZSrJqiKsH6w63I6kPirX8b3Pv5UVUKzoFWzPuJ40j+pTY7FD7MtRJQvamC?=
 =?us-ascii?Q?SKbM9CtJGcKmCdSJVpVi6gibhCVZIjY4eFtSN28I8fOP3kAF4SwtdZTkgqYo?=
 =?us-ascii?Q?8mU4PcP7KbJQFF4qCG32k78hOmYUVgNgBQM8lIWOK41kT/jgRRuDFWa483rd?=
 =?us-ascii?Q?T2S825knHlaRSlP0oLafE5djL6WD86dS9gcc1iBUdJx1euHDlZQmPaheSPfu?=
 =?us-ascii?Q?jzJinObcNVgq00gIbo6+8DGVf7aWXqev7StGo3KkhQl48yneoBlC9294PQk1?=
 =?us-ascii?Q?p1nf7RLAchK+LHFp0/0zgsksVsxAvVs96gZrNtlhxbnJ09omRBY3JVkV5Hf4?=
 =?us-ascii?Q?ZJtUUB6WeD/46OUlU7aPGqMNNxj2oAJQdvy6NNBqOgHDNZn8pIc4UgUlEuoi?=
 =?us-ascii?Q?5qXKA62clygQgc4DaL/aDCdhPYmGpDpdF/C/ppiyZLloace3MXDoBVbgNRyG?=
 =?us-ascii?Q?QruV7tKU7AN+3BobsIrVlz13inCTulsAnWRZazM6Plz/u1FXKjcu5ZkkkUmb?=
 =?us-ascii?Q?zsA4PP3AxdcmJmyONwZAvT80hMWR/mRCjtYGbEdFhIiKqlclMd6v67U/E7EZ?=
 =?us-ascii?Q?uGOXXvR2fF60BhgD6ermHcik48rKF7RyemN3rAD9HwfZyys/Z80RmHJ6RlrE?=
 =?us-ascii?Q?N8s76cWgHa7QmWCp81eebV1oCbyxSY0FTMk4qarIF4aXfQNNOpZNUBHDVm6w?=
 =?us-ascii?Q?6FdKe+bXxe3Jp2barvg3pvA/WGYIvneuaJAPNesGN21McZXTha4EXfrI3510?=
 =?us-ascii?Q?7dpthKdsEiYC+OzJqvZr8ySh6CwsghePucXhuT8EyT1Cbi8AGgrXKiJuG54x?=
 =?us-ascii?Q?4pSeKSpyRiZseO/2sZ8BJ0G9zZa10Wn0oC1iJ9ipxo0o/w4xprIdtTMw5bvT?=
 =?us-ascii?Q?bX9pYU2OxkprV0rSFFi/NGH8m/HkxbR0bQcPYSjkEicHDV9woHzZsSvRb0oX?=
 =?us-ascii?Q?9fQEDqQTXUTD+4KPdkL1zpoDEbDA7+gEskJXE96SlfiWIUhKA0hhpvVSHma8?=
 =?us-ascii?Q?y2vlfyVqCNzoYNjv/Ii+fUG8gCH0AeEyMmzrLg3bTivukrCuYdLEexF8YuHS?=
 =?us-ascii?Q?ZbN8aBiORqbUvUbdQQpsR8Nrcooz3xCnFhrcwNv7zsdJcgxnMvxCvvRqWfbs?=
 =?us-ascii?Q?J2kUbtE+xm64ijkvSgAHqBqG2W6aRCwvWsbxLf01Mit89d30Smlbo72qZSJE?=
 =?us-ascii?Q?gdM7pV33suC+nLalRxpfqcqeeza3grp4yo8T+tTs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea973848-3de0-433c-6fba-08ddf081e002
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:51:15.8156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WjtQxoINz9FW8qp7PxmqSVqP+i88ejfkGNGo7C50p1H8hhhi55QzipmLvLPlHdqlpl1ZMXXiuq1tAcXEcTvVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8825

On Wed, Sep 10, 2025 at 11:34:28AM +0200, Marco Felsch wrote:
> On 25-09-09, Frank Li wrote:
> > On Tue, Sep 09, 2025 at 02:03:09PM +0200, Marco Felsch wrote:
> > > Hi Frank,
> > >
> > > On 25-09-03, Frank Li wrote:
> > > > On Wed, Sep 03, 2025 at 03:06:17PM +0200, Marco Felsch wrote:
> > > > > Add support to create device_links between dmaengine suppliers and the
> > > > > dma consumers. This shifts the device dep-chain teardown/bringup logic
> > > > > to the driver core.
> > > > >
> > > > > Moving this to the core allows the dmaengine drivers to simplify the
> > > > > .remove() hooks and also to ensure that no dmaengine driver is ever
> > > > > removed before the consumer is removed.
> > > > >
> > > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > > ---
> > > >
> > > > Thank you work for devlink between dmaengine and devices. I have similar
> > > > idea.
> > > >
> > > > This patch should be first patch.
> > >
> > > I can shuffle it of course!
> > >
> > > > The below what planned commit message in my local tree.
> > >
> > > Okay, so you focused on runtime PM handling. Not quite sure if I can
> > > test this feature with the SDMA engine. I also have limited time for
> > > this feature.
> > >
> > > Is it okay for you and the DMA maintainers to add the runtime PM feature
> > > as separate patch (provided by NXP/Frank)?
> >
> > we can support runtime pm later.
> >
> > >
> > > > Implementing runtime PM for DMA channels is challenging. If a channel
> > > > resumes at allocation and suspends at free, the DMA engine often remains on
> > > > because most drivers request a channel at probe.
> > > >
> > > > Tracking the number of pending DMA descriptors is also problematic, as some
> > > > consumers append new descriptors in atomic contexts, such as IRQ handlers,
> > > > where runtime resume cannot be called.
> > > >
> > > > Using a device link simplifies this issue. If a consumer requires data
> > > > transfer, it must be in a runtime-resumed state, ensuring that the DMA
> > > > channel is also active by device link. This allows safe operations, like
> > > > appending new descriptors. Conversely, when the consumer no longer requires
> > > > data transfer, both it and the supplier (DMA channel) can enter a suspended
> > > > state if no other consumer is using it.
> > > >
> > > > Introduce the `create_link` flag to enable this feature.
> > > >
> > > > also suggest add create_link flag to enable this feature in case some
> > > > side impact to other dma-engine. After some time test, we can enable it
> > > > default.
> > >
> > > What regressions do you have in mind? I wouldn't hide the feature behind
> > > a flag because this may slow done the convert process, because no one is
> > > interessted in, or has no time for testing, ...
> >
> > Unlike other devices, like phys, regulator, mailbox..., which auto create
> > devlink at probe. I am not clear why dma skip this one. So I think there
> > should be some reason behind. Maybe other people, rob or Vinod Koul know
> > the reason.
> >
> > static const struct supplier_bindings of_supplier_bindings[] = {
> >         ...
> > 	{ .parse_prop = parse_dmas, .optional = true, },
> >
> > If remove "optional = true", devlink will auto create. I am not sure why
> > set true here.
>
> I've seen this too. Could be because DMA controllers + users aren't OF
> related and therefore should be handled within the framework itself.

Not sure, may be some historical reason. I have not enough confidence just
because I don't know why optional = true here.

So I think you can post this patch seperated with good cover letter, may
someone jump into discussion.

Frank
>
> > > > >  drivers/dma/dmaengine.c | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >
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
> Okay.
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
> Argh.. mixed it within my head while writing the mail :/
>
> Regards,
>   Marco

