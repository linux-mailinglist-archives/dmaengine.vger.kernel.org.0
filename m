Return-Path: <dmaengine+bounces-7455-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D09B6C9A507
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 07:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6342D3A5D02
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 06:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E931F2FFDD5;
	Tue,  2 Dec 2025 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="kASaG0RD"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011059.outbound.protection.outlook.com [52.101.125.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3612FD1A5;
	Tue,  2 Dec 2025 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764657148; cv=fail; b=q66mkCHZKf8YhgA8UwKjdeFJYzpN5UwU4d2JvDwrL7uKXLYiFPp+8tEWDmpY9DrX1buxSRA1ufpu1Pg8ireDe9EMWmTGy1Bz5cjxmuzmUj8vug8oft/rz0jYUh9GBlIM/klk4vr4yaqd9DvSxAR+oiiNBsj0zZUM8hqYiuMymUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764657148; c=relaxed/simple;
	bh=xczG34zHg+m+xA+vrn5v7/vw20W1INd2nfvO4CKfUOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sTXIU4KGKOFGgrekREdmh8DujcvGmFC1Wu/cUIr2CYqCN8j4DKA0Vr1lXJLDvmOjkrqUePVOGBi3rJ5HOARGgCRuZLjrqzSxB99Z45I+werrYC8R4TJf8Re7TgOm5IA1flmIST+U50vUCx2MHDw03SlrQIICNra1Ir14MnPyx1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kASaG0RD; arc=fail smtp.client-ip=52.101.125.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZwqVxY6vnVkinidAR6daGg51Qa4NKTHDt4kpzYupRAUtgLGMYj8ikj0KBn4gUSFovvJzGZv4KitJ0K6S8m3t8OaMR5bP/NuVGM7dszXl2+Kk+nlckgp38JbhIoAZZ4L01y1laAmpRS2u6dP7eT6lxmd79Hjlm49CCC57xRaLpRhNJRd0oAb+FgvB2yC1zaHWo7S0QY68YCmY40CiybZlYaHW+D9q8faTDb4uyVUZO22+feJmsAHDAaC+lEONu21vo3pKFWBWPqw61OXtHifnVl1G70OB9C5bLLUHBwQ8lwMDhwA4t0BrsuwOPEQl2GeKrSlAuNkFBQ+nR15Nm991Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRqKbz/LXe/anZWVVm/kdZEbb2AVZvOE7HTx9Qk3qbs=;
 b=DctdbLZV9OYkbFawz0EYT4LLetEZSbeVistRbz571zxvbORzsFzJPw9gmmkPeIMXa8kF5H6dS4Qhk1Taw/GdO6/iJufzjhD6luE1Ww0w/GfCbA2qHeDP4jF+Zq7FfGyS/fb4n7uB4Er0fe0oX7N3d9lcQWfU5U4lNiRPWLYD22qUDQJiUKr7sG81ct17earewgi0VXBA6Bn/uFJ9oAICy5f4lNPjxDbMs2osGll/4cPfVVr+MupJyDvWp+gvSn/QeRKSf9h1lUi3nozVEV2iZdMpHmkGSMBcn+djPCSrV1PzM8AizejMz5TfJAutHHQ85kBjnLJoQboP49cJiASL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRqKbz/LXe/anZWVVm/kdZEbb2AVZvOE7HTx9Qk3qbs=;
 b=kASaG0RD93/3fJoQClRtnehJgpPPuofpIKTe0mqMQ5Evzj5qYc8ttKlo4dvzyhi9wJbqK7280jhWAobuhw5kOLtxQBEMEBOABljx17FUyM3C0h7+k3rrrZSy0LDcYQLIJwCZWe2T0FBVjNgRT54Yw9rvhFEVRLonaMouwSBwJpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TY4P286MB7525.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:351::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:32:25 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:32:25 +0000
Date: Tue, 2 Dec 2025 15:32:24 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Frank.Li@nxp.com, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, Basavaraj.Natikar@amd.com, 
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, logang@deltatee.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, jbrunet@baylibre.com, 
	fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 10/27] NTB: core: Add .get_pci_epc() to ntb_dev_ops
Message-ID: <f6jo2z4dnk23dun7g7d6d4ul2rw7do2cugb7jtq4tfb4vixzsw@lmpl5p4kqxc6>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-11-den@valinux.co.jp>
 <8b209241-99a7-42c0-8025-e75a11176f1b@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b209241-99a7-42c0-8025-e75a11176f1b@intel.com>
X-ClientProxiedBy: TYCP286CA0327.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::20) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TY4P286MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7b8ea5-c9a5-4a1b-4d12-08de316c8e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YqOiOkCzYvWwc2aCgFuNCmV3q2tgGw6lrq3EJ2L2xyhiwOAs0JPdNKVikpIs?=
 =?us-ascii?Q?4IMpTr4nQGjoGRZQWplyLxYhM57fSea/SvIV+5Om5I/Jo0Edf5GBKi+6Kz8H?=
 =?us-ascii?Q?e+IsNCNbfU6AF1JNhPtTrrQw+NZmozHZLP8XHzMX1pnU34/jeeHAzzm/gCbm?=
 =?us-ascii?Q?D5gXVQ+3dpYA2Mo0g9dg13ZjjGjITLp4HPMs/EDoAh/Pl95GNdQ6GRz0/L0B?=
 =?us-ascii?Q?GhF7JXSBM6f0LhR+PrU4M/G8gMMMStcU1iInIUjcHcAj7GwVFBTGknueHoKP?=
 =?us-ascii?Q?icqnr/mFOj9fAmHSfjL84ceJZqoCRtLf8rj7/tu8gj/A/C1tztiFgAFEUYY4?=
 =?us-ascii?Q?+ZF8qhRH48aAB4T6ZNOpgM19WkigxUJo8UuFYGenBQxuaUde4R9dLlZln9WH?=
 =?us-ascii?Q?6MfybcZI/yDV2LAP+VT0o2+k08ayc0Je29k8D1D3eRhqtT5PqtF7fjv+9CzA?=
 =?us-ascii?Q?GM9ouazSD/Z2myYuTYEgRA0DJ/IgHXtHHqkJ5A0MVzpA5b9Qw2bZnMqDtBl3?=
 =?us-ascii?Q?g5bCLg0RhuokzQWeAr07vWBXDN2JrePMRftsb24aVBW0Nc/qNjYz8U1anxHK?=
 =?us-ascii?Q?b0PBsj8xnHSHEbfPm8XdVGcZYY30Sacbus6lfk12aCldBt5fAibX3RnH8xDE?=
 =?us-ascii?Q?dpRIfN2FrLaxGyD2ud3vT87307RNVlt1Rf7xNIRirBNlwnpYIgyg1vE4hBFT?=
 =?us-ascii?Q?njO5+dheTAvrtKz+OMHWxDU9q5JTp5u/E7+4/wr9IO3NcGGXES71ndW+sUay?=
 =?us-ascii?Q?ex/vQZoYtnZQr/0WLsq8aXt3XZ4vVu5oNFZpNIrUDQ8g4WaS4x8+pRDka7Ow?=
 =?us-ascii?Q?ctGbJ+XyCZpI7eJ7ssdQHIq9WPBY6oMHMk139YPq0nNiTWlXu2y4bkbME1Vy?=
 =?us-ascii?Q?GpRSemsGvdwV2uhuXE0tPn07MZJ1pSnCFWnCooVoFg3x9m2JQIoryFBGYnah?=
 =?us-ascii?Q?6cwtC+0afAhIcV2iCPkh/tR5itzXhCf7f4yMrQergxRPxQe/f/hH3LkwyX0A?=
 =?us-ascii?Q?SH4LgnUF2v9drVr6ePM/prv+OWITvBo/kGN25APKz3b3aYibIvBBi+iXhRe0?=
 =?us-ascii?Q?WFMqYyAq6t9DlaZPR12LL+tdKM/HIfQWgksIpEOuyq32JXTyOE5WdTUJH3pO?=
 =?us-ascii?Q?v6DtW1L+Wnh84nlBFzsDAOZsmQggbCIGy8J0uYYLGpVUUS4cKNLELoHqW7s+?=
 =?us-ascii?Q?2Qr456zC4Vr+1ttXyDSCerVgCSVdyqa6wZsofgKHI97Xb+bSK1BUC+CSGbAy?=
 =?us-ascii?Q?Z/04RtL9EmltTgCHf+fBK3jnBf5ljg+SCq5v6JayWZnIz5EmqlQ+lDiLrGs3?=
 =?us-ascii?Q?AQavjXPMlBI5PwntuMw1j5uXVzo5Ts4peuNLGwILcjhXtidKfOkERRH4lVS8?=
 =?us-ascii?Q?J8sHZ7aPzgCSBPuSCe8ibTaTc8V2PNWqDNTQUB6FjwAr73vYyUCv1op50+zk?=
 =?us-ascii?Q?ng11IVgjs38gq9jCxrmKovn9Vwe2TiCP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?anE3IpArWkfScIwKr1N9xeYMgp8hmnS3tZwUHk5CEq50EwKTSQnR5qVtD8tl?=
 =?us-ascii?Q?upFKb3rmT6LOC0pgmOvASHFjINRSDYYViLufJhGq1Lxtse+6iGRImyT3UbGV?=
 =?us-ascii?Q?wCH1j26qmxOgUVbREfc//eWbv5Lnp1R17PL+SedZrZZKJWrtJ8XZpxy+9b35?=
 =?us-ascii?Q?ME0EbvHnWvP4rGmfZsD3MX/5qgRyZqT9qlbOSmF3Sl1RUy2T6G8pGI6QEk9I?=
 =?us-ascii?Q?JNNxaZtUF7UMv1bYcxLBllAK9EyzxzZ9c8aIDxCKYTko9E8g3MV0IubcOuVh?=
 =?us-ascii?Q?j6G29q6SeDbaYL3M7dURzNMRMGBy3phxEkc2jeG3wtDx92IA2Zqpgid1nQ2p?=
 =?us-ascii?Q?0HRJUVErOmmYSCr23VcYU2vqvg8KXDM5tgm1ppwPQt3YiPXHRNHcH6TLWbyQ?=
 =?us-ascii?Q?66QBR/spluEqMmIEksHkvukTzMHV5irS75qaaBnH424kzs44wNEAR3VShfn0?=
 =?us-ascii?Q?/Wvgm4xXmRVs4dR4n109aJ96vyReMXdJBTNue/VqzwKWEcaqo7FLkCJz28kI?=
 =?us-ascii?Q?X1+ta+t0opymxllBqO4SLEvVrcvJPnc3m3oJXyx/FsWqHFicL88Sk+m2Wc60?=
 =?us-ascii?Q?NFsrE8Vp5wk9RQvpT6h60RqA6KhphG91U1fT3LGw+W6p5eKWUOvp96NAP30J?=
 =?us-ascii?Q?IaK7PSd5D8By0DBCUlWGLYvC9vkbrhu55Txtz2N+0+0pSwfF/A1KZQeexGLH?=
 =?us-ascii?Q?FhtgMMPXhO+RTp/15m7tZLRSwZL9b73UmZXAnpfTiqPDFqYaceAuIpwfD8wq?=
 =?us-ascii?Q?uV1BK8cVgQUH0VcKIzjxHoUU0jCJae4wkhVnMBhOAngnFtJpMBnvEvfR1JKw?=
 =?us-ascii?Q?dEuxo94okmGa64aNo33Z+ERb6gPZRpv+75xe2yE4dZjwDH9dMN0wiWSJaaj/?=
 =?us-ascii?Q?9VRONV81JHfK1tEE8BWPkcmHrIvNd9BtEU7CoM93JG5+Yq4lGxngjnkA8YIR?=
 =?us-ascii?Q?8peLGjyjtyv2dhfQn7Bvc83K/tGz9jJXDzAdpUhjwTtnMGGBiTAOKkpwY0cJ?=
 =?us-ascii?Q?9Dc4qFOLLdwOwx6lrO9t4EABTNgOmQB07v+d55dd3/i4I9zhUu8x02hius08?=
 =?us-ascii?Q?zRmnnGl+6NgQzzwK3sV0wQDUE8yo5jFJ0jyLKeTyQFkgc6kncxVaQKMJ0Hbb?=
 =?us-ascii?Q?c2BjGW/j1c47BQIkFkl0bnMEQ0sGYAPnQGaNrVE3+ORQCPwVTxWaqnnXdL0f?=
 =?us-ascii?Q?A/tESFas53UKlrFnLCPWo+NDzFTWt7dzWErFpDJcQsAvEx7jD5BCNEMMsDyd?=
 =?us-ascii?Q?S36+4b7nznThvCWA7idRbOC/7gk6hVClD+jtWcs7hGD9MvjAdN/dnW1ez+Gz?=
 =?us-ascii?Q?X2oDkaoFKHHKvnRioLP9e+gsDttnsvblSBvfHItffjcpwpt8xdwfvTaHpwfw?=
 =?us-ascii?Q?RREBHt6mo7h8aA31ocRKHZspYSYjvWcx+c3yRI5g5S7FmNo9Y33n7L74vch3?=
 =?us-ascii?Q?114FMXlYTv4SeakmsF9FW0samwQBjAki3gz7N5VMkJurFEJsOvu/yuFu5r66?=
 =?us-ascii?Q?Pf6tDlupyQAv6AwfKyZwo6EQkBR6NsJ/kU+JteERDMJsdjXJEb1UDJ5Zjcnu?=
 =?us-ascii?Q?nEXZuQfMxU9y3ki5tqUa9Mh8WHWaJdjTQNgmIB8jqg1COvZ5aD/Bk3b8lQXN?=
 =?us-ascii?Q?i8YQ/BGj0JhdOGM5qdqXASI=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7b8ea5-c9a5-4a1b-4d12-08de316c8e82
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:32:25.1548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xj4ZWAAwJWKK4jn5Zg03m2GeRpeRq7obe/y/PGDFEkqYF3U1Q/DY9BJO6G4t4Dl+U/6GnzGVB/iAqrtEYLld9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7525

On Mon, Dec 01, 2025 at 02:08:14PM -0700, Dave Jiang wrote:
> 
> 
> On 11/29/25 9:03 AM, Koichiro Den wrote:
> > Add an optional get_pci_epc() callback to retrieve the underlying
> > pci_epc device associated with the NTB implementation.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/ntb/hw/epf/ntb_hw_epf.c | 11 +----------
> >  include/linux/ntb.h             | 21 +++++++++++++++++++++
> >  2 files changed, 22 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > index a3ec411bfe49..d55ce6b0fad4 100644
> > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-epf.h>
> >  #include <linux/slab.h>
> >  #include <linux/ntb.h>
> >  
> > @@ -49,16 +50,6 @@
> >  
> >  #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
> >  
> > -enum pci_barno {
> > -	NO_BAR = -1,
> > -	BAR_0,
> > -	BAR_1,
> > -	BAR_2,
> > -	BAR_3,
> > -	BAR_4,
> > -	BAR_5,
> > -};
> > -
> >  enum epf_ntb_bar {
> >  	BAR_CONFIG,
> >  	BAR_PEER_SPAD,
> > diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> > index d7ce5d2e60d0..04dc9a4d6b85 100644
> > --- a/include/linux/ntb.h
> > +++ b/include/linux/ntb.h
> > @@ -64,6 +64,7 @@ struct ntb_client;
> >  struct ntb_dev;
> >  struct ntb_msi;
> >  struct pci_dev;
> > +struct pci_epc;
> >  
> >  /**
> >   * enum ntb_topo - NTB connection topology
> > @@ -256,6 +257,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
> >   * @msg_clear_mask:	See ntb_msg_clear_mask().
> >   * @msg_read:		See ntb_msg_read().
> >   * @peer_msg_write:	See ntb_peer_msg_write().
> > + * @get_pci_epc:	See ntb_get_pci_epc().
> >   */
> >  struct ntb_dev_ops {
> >  	int (*port_number)(struct ntb_dev *ntb);
> > @@ -331,6 +333,7 @@ struct ntb_dev_ops {
> >  	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
> >  	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
> >  	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
> > +	struct pci_epc *(*get_pci_epc)(struct ntb_dev *ntb);
> 
> Seems very specific call to this particular hardware instead of something generic for the NTB dev ops. Maybe it should be something like get_private_data() or something like that?

Thank you for the suggestion.

I also felt that it's too specific, but I couldn't come up with a clean
generic interface at the time, so I left it in this form.

.get_private_data() might indeed be better. In the callback doc comment we
could describe it as "may be used to obtain a backing PCI controller
pointer"?

-Koichiro

> 
> DJ
> 
> 
> >  };
> >  
> >  static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
> > @@ -393,6 +396,9 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
> >  		/* !ops->msg_clear_mask == !ops->msg_count	&& */
> >  		!ops->msg_read == !ops->msg_count		&&
> >  		!ops->peer_msg_write == !ops->msg_count		&&
> > +
> > +		/* Miscellaneous optional callbacks */
> > +		/* ops->get_pci_epc			&& */
> >  		1;
> >  }
> >  
> > @@ -1567,6 +1573,21 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
> >  	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
> >  }
> >  
> > +/**
> > + * ntb_get_pci_epc() - get backing PCI endpoint controller if possible.
> > + * @ntb:	NTB device context.
> > + *
> > + * Get the backing PCI endpoint controller representation.
> > + *
> > + * Return: A pointer to the pci_epc instance if available. or %NULL if not.
> > + */
> > +static inline struct pci_epc __maybe_unused *ntb_get_pci_epc(struct ntb_dev *ntb)
> > +{
> > +	if (!ntb->ops->get_pci_epc)
> > +		return NULL;
> > +	return ntb->ops->get_pci_epc(ntb);
> > +}
> > +
> >  /**
> >   * ntb_peer_resource_idx() - get a resource index for a given peer idx
> >   * @ntb:	NTB device context.
> 

