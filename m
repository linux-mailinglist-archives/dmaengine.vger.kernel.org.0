Return-Path: <dmaengine+bounces-5830-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D6B08512
	for <lists+dmaengine@lfdr.de>; Thu, 17 Jul 2025 08:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0053B16E14E
	for <lists+dmaengine@lfdr.de>; Thu, 17 Jul 2025 06:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3C31A5B8D;
	Thu, 17 Jul 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4hdCoOen"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FFB72635;
	Thu, 17 Jul 2025 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734351; cv=fail; b=sVy0S+I35pW3FD+05WX3d7E5YsM6fjsZFpjLKqPCkNVM332uuRjfI24fcul/hzbVf6Bei3dYk3slBlYyUHYGHSJlilNfsdGSZLTZEGP3oDbWkzZ/yLiZauatIZcez9X6TZWQf0VJkVFduHA8eSi90HLSwiHTUHwpaJcr+ZBQ9Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734351; c=relaxed/simple;
	bh=aLqvNTJd6wdvIgVGXnhMGP4neko6ABXlsHhXNBIpfAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qWPUZHxIrWSISEgFTqil1ETnGIcRLGIIKA6Kbp7b+Gnqq5KU1JnaGS1XEP+cNoDgvZeS7ljGypNrB0AYwpsc27mYmnBiqfoaYX96iDODK8zfbMhSLxvLzVRLfZ8Gf4Ni+Tt6sfNaSi2XpErJAk1yv+v1ZxhvRgkaOpahHxPlDoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4hdCoOen; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gj3zkSXfpDivBKBO+qF1KEAPA8LQEsE24DJFh3k/vWZE+wF43kSBg4a5cVbTVTbpty7r0n4Au8vZciWCads5DJBICdmkqJyIeL/aQbZnjnPZHNvHdnZzGrlIqv+ypRHwOb5k7NdUPhfrwm/jACFoeoNiJcIlAQr01h2QagDwAX95fYFv6efaNJiyQYw1nXXjqHe7L77Uy7aGuNtlj6h2XDEIQFWJix43glgq3t19v8TbR2Qyr6fO4aQK44/8f2/uemDT391JsCNlHe/Dz5SS9lXM5s7YQkrSWd9jsN/I0DnFAlx7FAivC/3m1leMuj1/UETHXMWZlzexic3LgZBtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlJ8Rr/MWZMUxav8xaVaopF/z05HrXEXw5vwAWhTUiY=;
 b=lP8g7Gir9b6mLFA0bq9Ojpo34Zq5KXq01Z9kN6zSAuWLbHuwmPjwlTBO4kaCQSStIvc1AlMNEBeuq1km4R296xnpNoRXAMjk0wl6nki5WYDc+N8nNekMd2m9IUkzc6qW8tYQ47YYfLAowofQDJ1bLyZ18ZwVViFUtc4/IXnnehBxFRheqq0wEfA/O4sBlW4tGU6KFoDLLNoYFTbDhfHfze5L4kQwAPR9h668413+v+mBHCvcqCD8OttO9DnV+NjY5J6wNy6injczFdAqnN56cq9QR+z2238wjcj8oyCNt4nSQiUWfN4afpbgAq+k7dRbf1+7LePCY8soAnXCZAdSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlJ8Rr/MWZMUxav8xaVaopF/z05HrXEXw5vwAWhTUiY=;
 b=4hdCoOensDK0hyoQ2aO7AJvxfdyuP+xKI2Kkkeit/PFLwF421RXGgWGaz/I4Ya/Oc8OoRLbFBpLA0dpa4OK+ektPEvJfsIPRvH9fXqb9wfOIU6XLrggumM3hOYrtN7XnlXCNMRD4O33+//JaaqeOgKzdJUmOhM4aBpQOKun2/B8=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 06:39:04 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea%6]) with mapi id 15.20.8901.023; Thu, 17 Jul 2025
 06:39:04 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Vinod Koul <vkoul@kernel.org>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mani@kernel.org" <mani@kernel.org>
Subject: RE: [RESEND PATCH] dmaengine: dw-edma: Add Simple Mode Support
Thread-Topic: [RESEND PATCH] dmaengine: dw-edma: Add Simple Mode Support
Thread-Index: AQHb5AaGsGs5kTrW3UWG39W5gh/nlLQWBTmAgAiaQpCAF2AAUA==
Date: Thu, 17 Jul 2025 06:39:04 +0000
Message-ID:
 <SA1PR12MB81205B80D32E62204E9244B69551A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20250623061733.1864392-1-devverma@amd.com>
 <aF3Eg_xtxZjZTEop@vaman>
 <SA1PR12MB81208BAD2A5D264482333FF79540A@SA1PR12MB8120.namprd12.prod.outlook.com>
In-Reply-To:
 <SA1PR12MB81208BAD2A5D264482333FF79540A@SA1PR12MB8120.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-02T09:29:10.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|CH2PR12MB4088:EE_
x-ms-office365-filtering-correlation-id: 40ec2cd1-10f6-435b-944f-08ddc4fc9f8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?upaZ1Wdl+FNFzEnTLeBDnQ1rUbb2lfEp3kiZNGvpoQD0yZYcZ1/QbF1qYv0a?=
 =?us-ascii?Q?ZaQZvpfWrvGn03Hkr55eQK6ck6zeMMrbABYoC1L3aUfPNcS68VhyDbJ+b0hj?=
 =?us-ascii?Q?bNWlpNIuDctNlplJkS9KyUTWS0h/oquKctv+x5zLGXaByU7EfYlwZbExlutN?=
 =?us-ascii?Q?zgC1U1QyrJ5bmWO4cslUCqDwDjbfmw22bF2w2fbljrbTSyvzfg+VNxdQvm3h?=
 =?us-ascii?Q?3JLLG52CUW3lxW8lUeraejPeR4+SfAlF9nnMrPtbbMY4YMTDvGO7imRIZ6uy?=
 =?us-ascii?Q?GouRS2C6J3pDmBJ2Xz6ETfLwgIp8OQGIXrhwLfgfefLqvMfBYM4YTE6PvHwt?=
 =?us-ascii?Q?3qphkoXJWg2glbkp455qHKxfcgNF9B6ABcINQs6d/NEps4phCsIZAE41Q9K7?=
 =?us-ascii?Q?heXhz8EhYiyJMPNPbavGz6ZWuH4lsmRU5yGqclYgC/QARR70NMs13Wfq4xE7?=
 =?us-ascii?Q?B+Xd9hH3V0x3eZ7HmvplBdX75+CPWBHmWaFQ1jbJpkWYbaJnwV0ryyGS1Umy?=
 =?us-ascii?Q?BsC3uSmmKUtJmaugbCeB7kxH68pDXvAVHmdnNG/hTBQyp338k05zcCLQPnli?=
 =?us-ascii?Q?QpbcJ/18OGmzP2bbQ6WXdlAwWLLcQ3+HXgYdfn5ZlgftHQ9Z76JEcc0UWa8i?=
 =?us-ascii?Q?6sIcimB/Nc//+dHEKFlmPNWWkw7s/ozyDvQXNJN5F302Ecps8L/MtH8o7nNv?=
 =?us-ascii?Q?9AFiFfY6A4NoQ0qnHwHEyVG88QESwpKe3WxHmCjLaRxBnAqoHWpj9YFsp2Ya?=
 =?us-ascii?Q?YTzfgAiQXcycWEnOITn93UtqPzRvmLaStQqi/gDvRw2eI/3f5BflLUomngtI?=
 =?us-ascii?Q?0iGOINqzqagBqsthPt3Oth6eNhVkPbIBmGCBMbH/6T97GxgkCkq6s+kE8VO8?=
 =?us-ascii?Q?GuPibUS2PKnLrne8JqjitbcXYGmrThv2Cg+zZOdOWXt9o2gq7IU7H0mnNT1D?=
 =?us-ascii?Q?y+sH9q5mhlFcmzmyRfUakwHYKxxzHQuUanZmJPtTXFNF3gTMG25Xz7X53Szm?=
 =?us-ascii?Q?iLVE8esrQeo7BFB8cRPIWjYZRzJJiqSQI0lmtm+bL5vDBAVNw2uiHtwmLwm4?=
 =?us-ascii?Q?TTsmCD+CGX7MzKKNcHv37BBekJJkXuhBVuZiGOHZ652QsoK/w72uUdP5eNEx?=
 =?us-ascii?Q?x7J1WPfYhqf7Mf5UxrxszKt2VGreQldMims/XZCajJw81ckYsSPwBJ7YboSk?=
 =?us-ascii?Q?PdRxJjDgdWOn7ZvcdJl/bzlgKPJmeibO5Ov3KJkd7Lf0yi/o44IjuQ/wCx36?=
 =?us-ascii?Q?N2dIis9lOwimeDWsl++jl8BF9VDHk5zn8s9r8QqzZYPC/OltoEbZkt/JH99E?=
 =?us-ascii?Q?t3zv0LQPakT1JQwpPBj/8pZWiGdHhwW4NS3tRB7zwrNlkQZ1LR8XKSu5m4ni?=
 =?us-ascii?Q?rzWBBpCHneDSxYaeL3h371MTemDKKN97LCw6XCjkTDUh9+cy9GVSwM08glWV?=
 =?us-ascii?Q?nAuBJOuCGBfRye9lXm/pzE04+z8PtC2D2lKAGeRyH0WH+8fFCOGt0A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+qx2cQvsexOHv2p8l/lJzpDLUXBu3B6i9N7HmFffxmC475eSX8pDXlIekCWO?=
 =?us-ascii?Q?XzWUmwVK5lCFjJjvMVAKLFPwgUPjZegsKYH1XU7m/+0fG8O+Z1T/sviNKJsX?=
 =?us-ascii?Q?V0Zk9924P0gKVEofMCVvlVsT2+R8Bw9FZoFRjp3gcrKFg1TZPkQ4t4x6l4Tt?=
 =?us-ascii?Q?ai3/gQAL5JlrW0NKXWX3QVz9/kiQtvImJiF8DZ6XSFTPPkPjLxiV+3fuCUtQ?=
 =?us-ascii?Q?kVGQT1GwoSDAK0ar+t0ny23GvwcfzcxX4/Yd1ul2Nnua7gZNN0UGriajRuml?=
 =?us-ascii?Q?n0Ohw0oNGovOHCkYuvxSJOnDvrkw68QZcinxDjnBrgKUK2fmsTxsWRHu2kZz?=
 =?us-ascii?Q?vIz8kJWPxF19TNaI0XOqojf40psptGMevuO35EAuwIxRq5/Ozbt1LKlN3opb?=
 =?us-ascii?Q?M2YlF1hM4oDWbDt9PSFn9sz5yw4Mq8aqz4a0blwEG68nZZOwnSckPtQsjwT9?=
 =?us-ascii?Q?GkKPUgUhonc/rON/9KB3+0PaUcVIML2z5AMsUcywGDF0nxjUFFIulw5fNAH3?=
 =?us-ascii?Q?+S1+0V/gtl98uvamLQghwYYrBy8WUDuBolwJg/9+2lxFe4WlRuT+LQ3cFOX7?=
 =?us-ascii?Q?gBKJCDoSwg48AtGRsz50urrH3vSHPcu7DCsejPgAykGhPU7pY/aHodVa0WFc?=
 =?us-ascii?Q?0PCRXCdkza0IY7zIfnKoiQBxbVgFb8LtfTAr9JGj8o9FCIw3NfvVTADDgcwJ?=
 =?us-ascii?Q?xjZyl1zAq67hwQ8VNWF3IIcDxR38DNGFOc97LhrjsJ8XAL4EbRHcX6o1RwmZ?=
 =?us-ascii?Q?qtaPnFJCJ0RawjmzF4C+o6L/aWiXcy6e7WwiCLq/SJD5mYVirPoUtkWoCOpT?=
 =?us-ascii?Q?V8sgV+Nj4flAA9aenQost5ODLe6Z1ISiGP+cRH/F3lwomZOkokfjz+M9/w7s?=
 =?us-ascii?Q?MUlyO6UKYNQF0zRHFxBf1dPg7Zsh72rS41LOtHCxOF+MlkSDRB7RRBZJZ2CU?=
 =?us-ascii?Q?aGtWuyGJspm6WOp0bLPGGKgFmBZaEPYd+F8CJtKxa92eArTM2r+mQ8+1Ltex?=
 =?us-ascii?Q?TmvDb93BbSfgF38zDGtxgqlpbOpKFzehoMVeoV/SC0Cl5duXqgUapL3ssl0H?=
 =?us-ascii?Q?I/YbBH51X3mI81Q5xDA+rI0d48ha+f+JvBDhIC7SW4ZMlUU5lrEJwn58Qoz7?=
 =?us-ascii?Q?TyjxuBVSrX7HXcxfzEdB9UGFhldoEIDWVsBckMnPO5ZJOj1Kai7a50Hi5S8c?=
 =?us-ascii?Q?CEHMOMvk7px0sKuthqvOgq7sGY0QTqpJVNz6QHSCrfvyRRT1m2rgbinSkJsD?=
 =?us-ascii?Q?OELPH/gPkFwTCryYNuVAr4XSmRyNHZSWhIpRbcisCVPQMSpbQNaFz9CGZ4wx?=
 =?us-ascii?Q?6Too+VRcAfqqbLpi8ZUrlisr+aDd25UOuXLc+w6AruvO0TuD2VOw5S4l9ENj?=
 =?us-ascii?Q?bVAJt/Oa0X9MyVkfdWRXcZtrTl+hf++JFtAcE9KiueaVQaptAKxwushYDk86?=
 =?us-ascii?Q?bIXCNE5XBElaNNeccUFvP2NnNSSPpKGgx/NFXIJiJVMQSnXTQkimwSAz0Nnk?=
 =?us-ascii?Q?xrpOu6PvZr4aSEVRCatq/e7oyBdrepxSd9zTFNpp6iy2Str8dLhGHZPL25CA?=
 =?us-ascii?Q?TvhUpjq+Vi3Vhl6f3uo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ec2cd1-10f6-435b-944f-08ddc4fc9f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 06:39:04.3722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28QncwAlE4LIOPuJz3FkzA0Lrz7MRjfOCPfn83qdxabS7tktImPe92shxmXDwttEvlj3kzLIZ9bmLVW6KT4EYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088

[AMD Official Use Only - AMD Internal Distribution Only]

Gentle reminder!

Regards,
Devendra

> -----Original Message-----
> From: Verma, Devendra
> Sent: Wednesday, July 2, 2025 15:09
> To: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; mani@kernel.=
org
> Subject: RE: [RESEND PATCH] dmaengine: dw-edma: Add Simple Mode Support
>
> Hi Vinod
>
> Thanks for the review.
>
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Friday, June 27, 2025 03:37
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org;
> > mani@kernel.org
> > Subject: Re: [RESEND PATCH] dmaengine: dw-edma: Add Simple Mode
> > Support
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On 23-06-25, 11:47, Devendra K Verma wrote:
> > > The HDMA IP supports the simple mode (non-linked list).
> > > In this mode the channel registers are configured to initiate a
> > > single DMA data transfer. The channel can be configured in simple
> > > mode via peripheral param of dma_slave_config param.
> > >
> > > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-core.c    | 10 +++++
> > >  drivers/dma/dw-edma/dw-edma-core.h    |  2 +
> > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 53
> > ++++++++++++++++++++++++++-
> > >  include/linux/dma/edma.h              |  8 ++++
> > >  4 files changed, 72 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > index c2b88cc99e5d..4dafd6554277 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -235,9 +235,19 @@ static int dw_edma_device_config(struct
> > > dma_chan
> > *dchan,
> > >                                struct dma_slave_config *config)  {
> > >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> > > +     struct dw_edma_peripheral_config *pconfig =3D config->periphera=
l_config;
> > > +     unsigned long flags;
> > > +
> > > +     if (WARN_ON(config->peripheral_config &&
> > > +                 config->peripheral_size !=3D sizeof(*pconfig)))
> > > +             return -EINVAL;
> > >
> > > +     spin_lock_irqsave(&chan->vc.lock, flags);
> > >       memcpy(&chan->config, config, sizeof(*config));
> > > +
> > > +     chan->non_ll_en =3D pconfig ? pconfig->non_ll_en : false;
> > >       chan->configured =3D true;
> > > +     spin_unlock_irqrestore(&chan->vc.lock, flags);
> > >
> > >       return 0;
> > >  }
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.h
> > > b/drivers/dma/dw-edma/dw-edma-core.h
> > > index 71894b9e0b15..c0266976aa22 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > > @@ -86,6 +86,8 @@ struct dw_edma_chan {
> > >       u8                              configured;
> > >
> > >       struct dma_slave_config         config;
> > > +
> > > +     bool                            non_ll_en;
> >
> > why do you need this? What is the decision to use non ll vs ll one?
> >
>
> The IP supports both the modes, LL mode and non-LL mode.
> In the current driver code, the support for non-LL mode is not present. T=
his patch
> enables the non-LL aka simple mode support by means of the peripheral_con=
fig
> option in the dmaengine_slave_config.
>
> > >  };
> > >
> > >  struct dw_edma_irq {
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > index e3f8db4fe909..3237c807a18e 100644
> > > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > @@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct
> > dw_edma_chunk *chunk)
> > >               readl(chunk->ll_region.vaddr.io);  }
> > >
> > > -static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> > > first)
> > > +static void dw_hdma_v0_ll_start(struct dw_edma_chunk *chunk, bool
> > > +first)
> > >  {
> > >       struct dw_edma_chan *chan =3D chunk->chan;
> > >       struct dw_edma *dw =3D chan->dw; @@ -263,6 +263,57 @@ static
> > > void dw_hdma_v0_core_start(struct
> > dw_edma_chunk *chunk, bool first)
> > >       SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > > HDMA_V0_DOORBELL_START);  }
> > >
> > > +static void dw_hdma_v0_non_ll_start(struct dw_edma_chunk *chunk) {
> > > +     struct dw_edma_chan *chan =3D chunk->chan;
> > > +     struct dw_edma *dw =3D chan->dw;
> > > +     struct dw_edma_burst *child;
> > > +     u32 val;
> > > +
> > > +     list_for_each_entry(child, &chunk->burst->list, list) {
> > > +             SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
> > > +
> > > +             /* Source address */
> > > +             SET_CH_32(dw, chan->dir, chan->id, sar.lsb, lower_32_bi=
ts(child-
> >sar));
> > > +             SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> > > + upper_32_bits(child->sar));
> > > +
> > > +             /* Destination address */
> > > +             SET_CH_32(dw, chan->dir, chan->id, dar.lsb, lower_32_bi=
ts(child-
> >dar));
> > > +             SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> > > + upper_32_bits(child->dar));
> > > +
> > > +             /* Transfer size */
> > > +             SET_CH_32(dw, chan->dir, chan->id, transfer_size,
> > > + child->sz);
> > > +
> > > +             /* Interrupt setup */
> > > +             val =3D GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> > > +                             HDMA_V0_STOP_INT_MASK |
> > HDMA_V0_ABORT_INT_MASK |
> > > +                             HDMA_V0_LOCAL_STOP_INT_EN |
> > > + HDMA_V0_LOCAL_ABORT_INT_EN;
> > > +
> > > +             if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > +                     val |=3D HDMA_V0_REMOTE_STOP_INT_EN |
> > > + HDMA_V0_REMOTE_ABORT_INT_EN;
> > > +
> > > +             SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
> > > +
> > > +             /* Channel control setup */
> > > +             val =3D GET_CH_32(dw, chan->dir, chan->id, control1);
> > > +             val &=3D ~HDMA_V0_LINKLIST_EN;
> > > +             SET_CH_32(dw, chan->dir, chan->id, control1, val);
> > > +
> > > +             /* Ring the doorbell */
> > > +             SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > HDMA_V0_DOORBELL_START);
> > > +     }
> > > +}
> > > +
> > > +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> > > +first) {
> > > +     struct dw_edma_chan *chan =3D chunk->chan;
> > > +
> > > +     if (!chan->non_ll_en)
> > > +             dw_hdma_v0_ll_start(chunk, first);
> > > +     else
> > > +             dw_hdma_v0_non_ll_start(chunk); }
> > > +
> > >  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)  {
> > >       struct dw_edma *dw =3D chan->dw; diff --git
> > > a/include/linux/dma/edma.h b/include/linux/dma/edma.h index
> > > 3080747689f6..82d808013a66 100644
> > > --- a/include/linux/dma/edma.h
> > > +++ b/include/linux/dma/edma.h
> > > @@ -101,6 +101,14 @@ struct dw_edma_chip {
> > >       struct dw_edma          *dw;
> > >  };
> > >
> > > +/**
> > > + * struct dw_edma_peripheral_config - peripheral spicific configurat=
ions
> > > + * @non_ll_en:                enable non-linked list mode of operati=
ons
> > > + */
> > > +struct dw_edma_peripheral_config {
> > > +     bool                    non_ll_en;
> > > +};
> > > +
> > >  /* Export to the platform drivers */  #if
> > > IS_REACHABLE(CONFIG_DW_EDMA)  int dw_edma_probe(struct
> dw_edma_chip
> > > *chip);
> > > --
> > > 2.43.0
> >
> > --
> > ~Vinod

