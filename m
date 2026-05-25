Return-Path: <dmaengine+bounces-10874-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAILNepYFGofMwcAu9opvQ
	(envelope-from <dmaengine+bounces-10874-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 16:12:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7045CB9BE
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 16:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5A443028EDF
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 14:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F07E35E1BF;
	Mon, 25 May 2026 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZnjctMiF"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020137.outbound.protection.outlook.com [52.101.229.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CC838642A;
	Mon, 25 May 2026 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779717824; cv=fail; b=MNTJJoosxsOOyODTfBlYj5Szaf5cmxKD15zO6C7l3z8ajLFMobNIg/qgKgcSZGDe/7k2zd6NHKnfeBZJHjs3aUxyJ1Y6/97GAQ/1sNGC5xL8SSipNZM6nriCZGAOvfWBtUghjScnTG5+JCoH4shy4ixx5r61PeC+hi8VskKEnJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779717824; c=relaxed/simple;
	bh=HHD6glqpD4k/VBrB38g8fRMwVliR9p2GCUUaRqV9rPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rBDakS4nmStNS1feB9wYcSlCrTUP99hU/p8++bH8Qb53pmDP615HhoCB6LoVyMonwNvLeUy3GGOGCCxp1kULcgIuqxC0xnvqLgfhd0eueRdDAfeN1S4TEF4ldE2BCPXCeX58jiDSL90hzFGHTKUQuTGg2dFbqYjQkI1sZ8QveoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZnjctMiF; arc=fail smtp.client-ip=52.101.229.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6w++yTb46zzx0pEmJP2fEmeTK3C0Zvx0NZON5/hVP1fdYRoi1v5ufZlLLUFMVH6i4dyUcGKPwWGYWG0rvGN2fEII+TEvXNnqMzNYeemrir/ML/2qNRtYOIm9ntdCv306WMofKVM/0HMOmufjQ+ob6oDV12nxEqcTfocAmqa7A0LGEzq/IEq0ddGYhpWebyA8G8ir5ff//lO05mWQ1nopTDhmetaKJOnJopq5tqpyLIk2CqvDQO+aTK8V9tRbkUhDZ5fr1+UCZ6uSiCjoLq3sLCaSRUhx738FNgaYD1a++Mh8n9pCs/LE0dtaeLiE5ifVllscguUTttyelTemTP5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tORnXhkv91dWwGALTNn1f864aWvDre6LK7oUGhqXdzs=;
 b=UqGMnvkZiw3GIFYB4RHaskgytaQ5ltHDnWhpm0kqKHX9AnVgwY2+qUrxcbqyMRtpZcy/5+8pPlTRTMQba0vsrfmZl+dBfAyFNumrEfvQxG6E5nGRq6ltMfbRmK+VyyLb7Qkx7xOa/OToKJ7pM4dITDhn9Tz6/bBU+N0BRcAiYlK7ynU8FY4h7F2fHc/ZhGwTJW+dxz9ppxUi0Rlbn6sNMIsPv53WluHGQi1ChJP3dq+lSd6+GyGbwIzBJl3Uw47HkJ6/zimH67bZAh72/Zzr97qgS5OjyFQWcrPdgj9tPU/ZX04Jl8rhzULuXDmYenlwuVe4gG0u4QWb7rKrcTmNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tORnXhkv91dWwGALTNn1f864aWvDre6LK7oUGhqXdzs=;
 b=ZnjctMiFp0UQiN1hA+lIHT4Rh1oIDtUV7pU88bjdmcwBl1fZNIkpqYNt7SdJ8xHcn37ZqlULLfyEgOcPCjK9SrFQZ2mjaBqqSYXTc89YPRvFIW27VpGSSyc5/X75SpMdtoRVETr22zOWo55D47oyFuko71PA3GEw7doucGOXcls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB3234.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 14:03:37 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 14:03:37 +0000
Date: Mon, 25 May 2026 23:03:35 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Add PCI DMA endpoint function
 (part 3/3)
Message-ID: <3dkicfydmrlm2i6ks34kwjdmlvb22ryftkfw2yj62o4rtj5xvl@f4gby5vlwtdf>
References: <20260525063456.3317509-1-den@valinux.co.jp>
 <xnfnxv64hpil6if4ikyohxnarvsekbmjcc37k5zej264ix46z3@qtu6xj2uy3xi>
 <ahQJ4kuaBKMhj52L@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahQJ4kuaBKMhj52L@ryzen>
X-ClientProxiedBy: TYCP286CA0169.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB3234:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4f21a1-2233-4a56-d387-08deba666a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|10070799003|366016|56012099003|3023799007|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	OTf1X/AhIp2WKYuXGYIXgPQ0pSjcsT8a7265yPnaUBWaCSt3XEXvFRHwjfg/jTtcg5mTlVakNlA6Zl/UgZ7jmyBQdrQsQAHaPBbsyljc6frixExb/SL+4cpmDDrbyWYDcroPRp7NkjvxwE8E4clrNT8tPVcmJRIJU6OA7b4HRJQDU+Ba+Jdi4yFVX1l5avpDX/ALSU8qmdx7P7MO7wz8o9ZEw6Zj6AOBJCxA4jVSxS0QaKXqO8p+k6XdY2ynrs2nH54KCdrI4f5C511nqBCh+lCES1LyPI46tLPn+T0ESMQKZJ+5Fnku0I6ApCbSWN+yx87lUbD1P3sQhqSgMUopIwgeIdYGI2Tp3C9ReUZlDs/S//zRIrS2XgpqdokTMtNAcDnDRVcigMJe8BTScrG8B8kKIUUhz1yjhbezXaRu9scsJ/8V3pngWBz2hUF55NR8xS6pPgzyeiwaEx+mZIPlpfll2wkLjh9vx6qIqz2PaDyUdD3NhEcPo0tu8lT6H8tNopZ5b94+ezVxenN3qcf+6vTLQrOpstCDoOLnsaPwkNq78PyueoLHuh5IxLUWLTjk/T9RWXhVXcBkD+kiOc5JCU70Ee1cYxoPL5v64PgslY+Oho55jxSurlMGmNpdRhbGZYHsZA0nlyqESfqfK4TQmZaNVBDHkt1RZ3phhvVZOQPomwZ3Q7/zzMz8lYM0wdHSOU0iRCMW9uOUhuo74kSLiw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(10070799003)(366016)(56012099003)(3023799007)(4143699003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3JLeh94EdqwPNueE7YnMjIuZvCD518ms6/XRJ2vQ6iXGsYbH7A/uNH1fsbzf?=
 =?us-ascii?Q?kS9TM9vF25xFJSvEnx44fcjq8ap3mhC2ckRNtlNVYosuwKMG1ZDbTuG4sgBI?=
 =?us-ascii?Q?wX4294a2DbjivTgFEbU7Wi37r9hajgO3Tz708GGR8oX3SVCDErsD52MAqJeh?=
 =?us-ascii?Q?Yqun0gu58b/ZoISTaF5D/5b6vpWU+5s054WeggICx+Ser5GpcWLyfvDTkEyd?=
 =?us-ascii?Q?FDgi2ia2oIo4kInKQpaQEZ2ZcUBe5u8WoBcEioUGxT7xhnMw0IiFxEjiEjW5?=
 =?us-ascii?Q?X0QISr+GToqJQmKVzj/5yEQHdVPVroV7x+H1gCDUzSVowFhu3hq5Sq8t4WCb?=
 =?us-ascii?Q?VTlaH8ptjLC2M9JCfDsR7KXwuaytkPQ3y7upcYSzGr/Npe6sfm27QuKorH8h?=
 =?us-ascii?Q?eC8ZDHHPocNluPNifPFBalb9yg1bA1L7V9ne0YSoUFYCgD4KRR24HcuHj9fR?=
 =?us-ascii?Q?arU7bAcEGoz48ZOQvI294L2w7H+yXQMUv8KT4xga609xVAjH1Jcyp6ocHeVt?=
 =?us-ascii?Q?WNi1PS+fFu4yexaXktnX5hG3r3n6v3bd+ivo9ALqN/8oI4OoIZkNM7tWUUF0?=
 =?us-ascii?Q?Q8Qce2PcwiJahRJdfSzkA+F9+GDQ/nE4dg5MyzMj0g1X7rMKZBzIOhmiMDL1?=
 =?us-ascii?Q?qP9nRNjmJL1Id+KTLien0lCpx1KfxXGNSs4KoweYp+kfM4rH0SzlRlLCitdU?=
 =?us-ascii?Q?dSP6c7d7LmTKw44fZ1v/SmLD2W1+jWACjpEKa7XEa6NuzXtUmX81ZVWaS+l+?=
 =?us-ascii?Q?V7fDWgeH8FXZVSRx80m1mYg4xb5HpPDwRJjN/oygOl0OIl6G0TRIBRw/njSz?=
 =?us-ascii?Q?EI2zd9hjrJcEQB1WOrMNrj3pwZMIc+9dj6l6pc+N3JZeHvVrWWu89loN6bES?=
 =?us-ascii?Q?pSRYapVEsHwzoVobMvoUnPkJj1br/RIcrm0DA0fhX+m/5KXeIVXk8V0Z6gPL?=
 =?us-ascii?Q?ZtCILgiwJT1BV4Rj/5li6DzNq/Nqs38ytmVZXiuHHQXfqDE6Jm5sZNIShXcw?=
 =?us-ascii?Q?pv8m6y+jJblXb+mnlCwvjUJuNiMXVfqFVazkCjfktrm2KG7vM8zGHkiWDsyi?=
 =?us-ascii?Q?nizBwWmr4etLpAnp6+ks5mdBKA0L9TZBcXQVxLihUHZ5fiYG+1gUyqLpJ25L?=
 =?us-ascii?Q?Xjq8V/TsVsHJPA9HMeUR10Rm1FYSAx4RHfaqsjiE3d2Ola72X/hYLtgBWjY8?=
 =?us-ascii?Q?D4pddakRy9uAXbsWgdKqZSUc5cNKXkGaZmYh6n8QVEC8ninVnqLRdWvNQQ2W?=
 =?us-ascii?Q?53a64j7IuMK32HeY23F3rzYjdRSq5abvU9lHrwdvQs/GtNqu5irlZpcwdUwo?=
 =?us-ascii?Q?UFOIvgFrkQulZThIoro/mlzXSny6qNOP9QjeaBSsNa5drb5NNfGnOhDASc1H?=
 =?us-ascii?Q?UjQiIT+GxWnWElb2faZ3ABQmTj8wenH4+dfpyitxRbUtk63dDPHp5lzzPbm1?=
 =?us-ascii?Q?47VyF1y0TbRAZV5ikaeGczXLi52QuHz5AaSFqVZ8J3RPanE3z4bXocA7z3b6?=
 =?us-ascii?Q?PapvOT7yStSLEC8xZ9ORdU6U9l/KiuJxJg5QrKfUJqrnukr4bYuelTiGWILu?=
 =?us-ascii?Q?xNK4SUs/HbHoszBkPfsqTfRKjCCny7UhR+yBBG0irlxILSuTMd8QmmqeBNfk?=
 =?us-ascii?Q?DpVLkOw1jo4mGPBrXK00lQXCZHwoETH08F1v3SYBrvn9KoC2DIZRmUsQIcFd?=
 =?us-ascii?Q?Ju/oduegSWJJqPECXaU5YsIOa2GxwI3pAQ8Y10+/J1WYNHoRnxIa2I9DwsOd?=
 =?us-ascii?Q?KvdrMyMmh2ItuFjsm12fRfb2xD14PfRkVs4MO6Ws74FpbOuT/AX6?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4f21a1-2233-4a56-d387-08deba666a75
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:03:36.9834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIrkbCU3bYwYxPHOYqfog0Yh6+U4S9gl8VZSZ7q9L5XNjOzq5LNmEuUIfheQR3ayWor5Ew7siKEO+VYPNMi6Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3234
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10874-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 6A7045CB9BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 10:35:46AM +0200, Niklas Cassel wrote:
> On Mon, May 25, 2026 at 04:05:02PM +0900, Koichiro Den wrote:
> > 
> > I would like to ask you for your high-level opinion on the direction of this
> > series.
> > 
> > Previously, I have tried two different approaches for the same objective:
> > avoiding the extra CPU memcpy (or local DMA memcpy) in NTB transport on both EP
> > and RC sides.
> > 
> > 1. Put dw-edma-specific handling under drivers/ntb/hw and let the (new) NTB
> >    driver carry the metadata needed for channel delegation.
> > 
> >    [RFC PATCH v4 00/38] NTB transport backed by PCI EP embedded DMA
> >    https://lore.kernel.org/all/20260118135440.1958279-1-den@valinux.co.jp/
> > 
> > 2. Treat endpoint DMA as a first-class part of vNTB. The RC-side ntb_hw_epf
> >    would create an auxiliary device, and a new dw-edma-aux driver would create
> >    the delegated DMA channels on the RC side.
> > 
> >    [PATCH 00/15] PCI: endpoint: Remote DMA support via vNTB
> >    https://lore.kernel.org/linux-pci/20260312165005.1148676-1-den@valinux.co.jp/
> > 
> >    I added an ASCII diagram for the overview as a follow-up comment here:
> >    https://lore.kernel.org/all/sn67hi7kljh7cgmgodatb3naz2astlaklqfobdbxyyzgoohxqb@4nnetbhqwba4/)
> > 
> > Now, this v2 series takes a third direction. It moves the DMA controller out of
> > vNTB/NTB-specific ABI and exposes it as a separate PCI endpoint DMA function.
> > The host then discovers it as a DMA controller function. The initial host-side
> > driver is the existing dw-edma-pcie driver, and dw-edma-aux is no longer needed.
> > 
> > My current thinking is that this is the cleanest among the previous attempts.
> > But this is mostly an architecture question, so I would like to know whether
> > this direction looks acceptable to you.
> > 
> > In short, do you agree with the direction of this series, that endpoint DMA
> > channel delegation should be modeled as a separate PCI endpoint DMA function?
> > 
> > If you think the vNTB-integrated direction is preferable, or if this should be
> > modeled differently in the endpoint framework, I would rather adjust the
> > direction as early as possible, before building the NTB transport on top of it.
> 
> Hello Koichiro,

Hello Niklas,

> 
> I think it would have been nice if your overall goal was more clearly
> described in the cover letter.

Fair enough. Part 1 describes the use case:
https://lore.kernel.org/dmaengine/20260525062420.3315904-1-den@valinux.co.jp/
but part 3 should probably have stated the overall goal as well.

> 
> AFAICT, you goal is for "upper layer NTB consumers" to be able to use these
> DMA channels.
> 
> 
> Since these DMAengine channels will exposed on the host side, I assume that
> these "upper layer NTB consumers" are also on the host side.
> Could you perhaps give some specific examples of drivers on the host side
> that will use these DMA channels?

I have not submitted the first real consumer code (= NTB transport backed by PCI
EP DMA) yet. I plan to do that after checking whether the direction taken by
this series is acceptable.

That said, the consumer would be something like:
https://lore.kernel.org/ntb/20260118135440.1958279-27-den@valinux.co.jp/
although the naming "ntb_transport_edma" is no longer suitable (it would be
"ntb_transport_ep_dma" or something similar). Also, the old RFC holds
dw-edma-specific handling under drivers/ntb/hw, which is what I am trying to
avoid with this series, so the whole drivers/ntb/hw/edma/ would no longer be
needed.

With this direction, the NTB transport would use a DMA engine provider exposed
by the separate PCI DMA EPF, while the data path would still be very close to
the old RFC.

> 
> How will these drivers on the host side know to use the correct DMA channel,
> i.e. the DMA channel that is backed by this new PCI DMA EPF?
> (And not some other random DMA channel, in case the SoC has multiple DMA
> channels.)

I believe the NTB transport client driver should not request a channel by
capability mask alone, even if a specific dma_transaction_type for this sort of
transfer is added. It will need to know the specific PCI DMA EPF device to use,
for example through configuration. One option would be to let the admin specify
the PCI BDF of the DMA function when loading/configuring the NTB transport
client.

> 
> If you need to configure your endpoint SoC to bind to the PCI DMA EPF,
> don't you need the endpoint SoC to bind to the pci-epf-ntb or pci-epf-vntb
> driver? I know that some endpoint controllers can bind to multiple EPFs.
> Is the intention for the endpoint SoC to bind both to this new and PCI
> DMA EPF and pci-epf-vntb ?

Yes, for the NTB transport backed by PCI EP DMA, the endpoint side would expose
both functions, vNTB and PCI DMA EPF.

> 
> If so, but do really all endpoint controllers / endpoint controller drivers
> support binding to multiple EPFs?

No. For example, R-Car S4's PCIe controller supports multi-functions, while
RK3588's PCIe controller seems not. So with this scheme, RK3588 would not
support the NTB transport backed by PCI EP DMA.

That restriction should be documented with the new NTB transport, which I will
submit if the direction taken by this series is acceptable.

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas

