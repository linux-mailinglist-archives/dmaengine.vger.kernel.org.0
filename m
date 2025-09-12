Return-Path: <dmaengine+bounces-6484-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73E1B547F9
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 11:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EBF188C455
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 09:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD0326CE02;
	Fri, 12 Sep 2025 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DREDYWrR"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6402848AE;
	Fri, 12 Sep 2025 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669762; cv=fail; b=FbRbLS7RATWdJ0HrL27SEAtqWZd4VGtO0HkW3kmCD5vcjRHjMQBne5d6wUKLCAZ3YNixVS6CFgdqYubfM9/0Wpr2bZR2mvRuN6rcJr+50Wg7ClovVqcY7cUYr6Y06WTuY1BvQSFOBaCMpJaQu6meqmOTcZHgECtuuf5frwP8OZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669762; c=relaxed/simple;
	bh=lqjRl4bdpZDxaJlcMp78RZfF5YX/AJxsYQ2IzJXW8jU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IMCoMCy4YwV3NRyeVDeXOHfTZpRoFn+SvV+9wNGMYNmlLOSNf9+Y07bhTvTMoVNcmOFI1VZrJ/aHkvuzLv/l+tNLNCwordA31bIwOlSxhD5SrpGyCWsf+Ojf15hl7uqViaL4mWIOT+BtcW8OT8IfOfYBK+gN1NdfNMizdcRfoZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DREDYWrR; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCFKN6l9sK7df0+RZ5VWN5qPSfzPDOApSaGYz4yZr9ZFCSunhWdkFGp9eZ6aHsXAAldO6CtDtk2Gh3A7H+tRfOPuQPsZcVoVIerpyOo57mA0G42j/ftijZ9SzRa40NjPOxNSXJu8IaWmG1wWD4GUT6AqJ6fxqdLWq4p/CVrocqbjMwOoPn0SMsXLXV7dQEgmfi3FnS4MtHZ/rpmhSVGkfqKN/dLzXSrY6PrirjngPDlvo4kI96imcM2rJtplOiKA171QV4+43KM81tZlWP6ZzFFDiN9+1GDddfbsvsIFZCvuZzqpcCaVkcPx3OS5JLCri8O2nsQYHh1JawUy6749AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01dKBeXR+VKcd/4Md54QVpH5HztQTD77lg5gY0uyfGU=;
 b=ol3ZfqMQ6n1fWTmE4wemBzDnBNU1Sopn0yBky11i+0GRvHhZGRJI96ICS9k5Pq14ns54r37y7NrEiIjEQ6WIbPExUtG2fkMEdDu8CTxAsLP56y7AECdWzXSRaGQZTHh5+diZGgYum6Cdotsx9Le2PI0H2QnGyRm2Flut3EImuzKMvcf+sR53rOYJ0hItnZt8rfBNCfIcKLD2tb1p2D4UIX+c7dU1A95Qp88Jk7nyA0E+0ipup2PqkmT7PmAMkKhOq80+i4z17SpnHOjr9Feo+anmRRd7FfuJ6S1LTuXdGBllCFnAKO7APUxPe0bx0bF83kW+d8UumWsC5qsH3v4uUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01dKBeXR+VKcd/4Md54QVpH5HztQTD77lg5gY0uyfGU=;
 b=DREDYWrRChmIxzebCeDUo3n1XwMJis2RKmm82a4gyAnI2d0a0yaBjD+gElKo+KetnNP9MruhXXnH1Mm2synQ7eEprTHNjzrMno36Izc1YvtTUXmmHA2fuaZ10KVgKkxL+sUu9BPuWp8kxYeV4obhbp0Fh124I7f00Z235whzhJs=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by IA0PPF80FB91A80.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 09:35:56 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:35:56 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>
Subject: RE: [PATCH v1 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH v1 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHcI2aRkcXSEDz8T0WQWVSYvwF0+bSPSTZQ
Date: Fri, 12 Sep 2025 09:35:56 +0000
Message-ID:
 <SA1PR12MB8120288197801A3F6C41993A9508A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20250911114451.15947-3-devendra.verma@amd.com>
 <20250911215347.GA1594166@bhelgaas>
In-Reply-To: <20250911215347.GA1594166@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-12T09:31:24.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|IA0PPF80FB91A80:EE_
x-ms-office365-filtering-correlation-id: daf5c20c-dd9f-4eb0-4bce-08ddf1dfc632
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OEJz2kA4HN4za7MbVbIVTOz7cdsghHU6X7qACcfZbxMyvs0Ql9y3VqIabil2?=
 =?us-ascii?Q?GXHryuCpjCn66NNI5TlApUjs3lcnmc/EiVmsSKBEokF+J+WsNk7DLGcOzAuZ?=
 =?us-ascii?Q?tYoxclPFsS1By9SFwi1QkYIirhmZbXCtpfxkaCZXBnCNwjHm+ZAzd0T7PB9B?=
 =?us-ascii?Q?MrbAJjiwT/pWkFSDfGqBqFWFawB19fTfEPfJYwFLkJWBQ3zl0Yd6yOFpTCFp?=
 =?us-ascii?Q?kMxfh5r1ANFl5yChSkm0+W+Ax3UJl409sNq1s2ecy2tM/IY9LX1kLBqz963N?=
 =?us-ascii?Q?nFj0YZObxeb4Zp96Zy4oUGEiYA9mC91JY0o+xqlg99DTFXNbwptXKrwMhgXh?=
 =?us-ascii?Q?QmbFj2lsNrid+kVhwaO1LgJCuoTvpipwRZkT/pFAF7bu5qqgW8YlJF0Sh9RW?=
 =?us-ascii?Q?zJodtLY+c9p+4Ts/GG0SW/mQsBKjqCHQnRtGTwGtNawnIPb/YpIzhrb0BboQ?=
 =?us-ascii?Q?WL78gMmH11Lr9RT1V5N5aR39beb0kG6Z1w+2v+MSPrz+AsHtMcG4EHxdwsDW?=
 =?us-ascii?Q?QDJRq7ZbfNbqu/ie18ZAe1LMRkRxr5xjdfBRt2z1F8Dr+d5ept3j0LDhlJas?=
 =?us-ascii?Q?Rqvj/AIVYo3MifTVs5M0QEaT+/r7i3MWOpWCwn/KI5RJ5yt2JbhPaqxMVGYK?=
 =?us-ascii?Q?chReEWUSPwItRE5llo/v3tQuISzFTTEyP1/4p/0NmIl0bI4DRuoFyeKaTNk4?=
 =?us-ascii?Q?bItmJsFFIlMmQrPlWGIPMPOwAR68x7bewegqI/4pCk2P43tB22RzTfauJOzA?=
 =?us-ascii?Q?TJ74AFcBcIrCYmBDCcxk+cGBhwPUYS2/VFz6Q6PtEoOfrJJw4zZYNtZAzfL6?=
 =?us-ascii?Q?K/XW0t+n+bLgajKXwaeLYEorJHcAhEsyr+JoBIYFM1TeO83brsG9ofRpLhV+?=
 =?us-ascii?Q?dQr93KMpk+cPv/az1yXE+Cy6Hypq2jwaZntRxzkxEOYiviL/aQk6fGxfAbuW?=
 =?us-ascii?Q?/lvEdZv5cweOWsIPuIsvXDb6DckdplmB6vbUHggE03ZOh/Y2L4SPwoGO5fSx?=
 =?us-ascii?Q?AVnXcRdCK0Es4hOzMU9eLPArsozqJAnNGGT/Vq4/JTCtSVOgdaYhd5Gnbe9o?=
 =?us-ascii?Q?em9SwvJew/YPEVNNLDFlEobdeZD7L7BIPPOiXSiOQrpe3Vvn+lFGkGq03xeh?=
 =?us-ascii?Q?L0lSuwuI8m8Xtf1q1Q2pU+q4cMPupmGn5eYLgF7ieUGLFpZzLFgkGM4d2nY4?=
 =?us-ascii?Q?Oh0AOc5WSCGLX2Cd+1AIV/DsMKvIB+bUjngYibtdLRcKW40TIyCgU6lbluV8?=
 =?us-ascii?Q?kNlqSROqbHvyKOCAkGIw90jOJylwmARJkhpDpNjYFmRMx1qrU9UHStjMoPLf?=
 =?us-ascii?Q?nI8MKeahCOTpqeHi3ObkSnPBka1W2DrsIuLQ/JQYl4HEoP9MIR9OXtdqdyZO?=
 =?us-ascii?Q?d9hmKwUgTbu3hUosXdnVjURm+r8egQpZD3nfDVMh55gYv7tgwPipwsrjoFrZ?=
 =?us-ascii?Q?xw5l1aGY5Hz0/KqS2Wt9PE7qfxsJm6276e1DnmtOyBkLCVU8lp41OA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?b7lXtpJYNp6KSr7RUTFuicyD/RUE6KNmA/e4RDuj58qSDjiMbQn9mnQjs21X?=
 =?us-ascii?Q?OC+8S08AVxF0FJhBo6KkCDoYCJqb/8PIPN7sgQjCp9EuCg7b5MJjr0lCuRmS?=
 =?us-ascii?Q?Zky67ox+kagBaes4Xo9HdzVwnUeiAT/HPmdFVylTkO/fJuFJrLWA/9tr+Q+c?=
 =?us-ascii?Q?6ccgYiTPTtPO6abTzu84v17COsdgEpAa1Xd0TOfvEUPSLddzpdXK+yGhN0cX?=
 =?us-ascii?Q?30LUTb3AMxW54pgANbCKLC/t6c9jDdKFLpl+PO/OLboiBweSkFMsuMi6TuuA?=
 =?us-ascii?Q?zet+67UnG8tftyHxollh6AyHWCEbbGnwySz9JNcmsaRrWhJm2RGTHOIDXU/A?=
 =?us-ascii?Q?v5K60ngrhgyfBnFx7KpXEb08FopUbdFxxvwuqQDaYYvR6t4ibuyX0ddT/R6j?=
 =?us-ascii?Q?hYz1Eqm2Fw9Rp18hvss5wgaceG+8xu8oWRc27GsDaP0Gl+BwXf8rFOu3kZHW?=
 =?us-ascii?Q?HbZ0H+96ZUe8bmZ4IGes2OSbvlpOxFGKsW4Vk0x+nk/NOqp0i42hf9bzjSAg?=
 =?us-ascii?Q?yGGsZmCiPj3t2Gb1DDnmg2R+1FcP9PpW6lReGnDbea7uzVtcIotJcEU+ln8p?=
 =?us-ascii?Q?mCn2ZDosVqS8IB1Rkv++E6UyVaHuzAcFqMa/th1T0XGNTBl2qeD/x9CN4cGk?=
 =?us-ascii?Q?9Ztl2AfD7eEW3mQMfUEcdjKoHj12vl6b0yXOUdmYiycGTuU5xXYHloU31EIb?=
 =?us-ascii?Q?jKN5CYFSHj0LfOVQuhZ/GXflNi3htBo6A2sRZz0+CBdOvG86Nb/BOmo5/9Hm?=
 =?us-ascii?Q?VlUXCG7Nq93xlpaOa3gBOPlYoQDaFL5TmVjXaCVhL6xI8HPKzMZVeOThZsUG?=
 =?us-ascii?Q?vKxT1Dm3fBo0arn17xVNdXRrcH/ovCYQNCYztbhU2teQ+dKOh9/Tf+WKmJUE?=
 =?us-ascii?Q?Sz5M6tB59d6FlwzFSLDxJoW+kzIRq6ViXYzQI6tQQQfif+4AjtutZ9YMYZnc?=
 =?us-ascii?Q?TGmf5Fv0TQBVV9lv/3GcmtVvOoC/tG9nLkD88XgU3PyCKkX2xoIVwwpa2hXn?=
 =?us-ascii?Q?qWYVptdvRv59+vQTPtMpDnN0CDWolWN84iQi6P8VgbzuLTMoNrT1tkMp1rwW?=
 =?us-ascii?Q?xbHdn8gRcq/bbEu/dZ7IiCagGNr0ad+xrB+u/58JTDZIRTtaS3C4y94toumj?=
 =?us-ascii?Q?YOsO18SBtEEIdi1r4MLFliHltuMIkW5ypqvLfCceMVci1Oa6dG7G+f+/fScC?=
 =?us-ascii?Q?lAwJn+WAgHeDC0tVWhdXEOl5QJ5ozgE4XeLrIkuBsc0ykf5p+hX2/2IQWu+l?=
 =?us-ascii?Q?xteckU4LcuL452xAVJ05XqtMl+Lvg8aQJa0KlHef0I1cDty2PFSQSCAGpN02?=
 =?us-ascii?Q?HBzONo2/tWFXygJM+vV0vmBG73PsQ+Wcu2ddN/o1uEIQI7+vO/tZsY+gAfx0?=
 =?us-ascii?Q?I6+HIbwIa6XmrJeEB624C2IPwxrOLOgDy6OoyK8Lq0S07zRdZj1DngimHYPK?=
 =?us-ascii?Q?v/rvV+NgPeLTmgkv/OY52TP04gz46KypyB9s/ccNqZ4W9XYUuqiEPT5n0SJ1?=
 =?us-ascii?Q?hqSp3Um4qA89k0ZMbvTBcuNsMstHYhJquy+6KxXqEGf2OceR2DpBgUjo9CqF?=
 =?us-ascii?Q?SPetmh50E5lso4IMsjs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: daf5c20c-dd9f-4eb0-4bce-08ddf1dfc632
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 09:35:56.1059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4azAsSvAh0A2CIG/mdc7s4N426XPqoYux/Q63UtxasIdba/vx3GjJndtZKpntJ0H6uTyBYSSRXxck77BJH+Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF80FB91A80

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn

Please check my comments inline.

Regards,
Devendra

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, September 12, 2025 03:24
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v1 2/2] dmaengine: dw-edma: Add non-LL mode
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Thu, Sep 11, 2025 at 05:14:51PM +0530, Devendra K Verma wrote:
> > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > The current code does not have the mechanisms to enable the DMA
> > transactions using the non-LL mode. The following two cases are added
> > with this patch:
> > - When a valid physical base address is not configured via the
> >   Xilinx VSEC capability then the IP can still be used in non-LL
> >   mode. The default mode for all the DMA transactions and for all
> >   the DMA channels then is non-LL mode.
> > - When a valid physical base address is configured but the client
> >   wants to use the non-LL mode for DMA transactions then also the
> >   flexibility is provided via the peripheral_config struct member of
> >   dma_slave_config. In this case the channels can be individually
> >   configured in non-LL mode. This use case is desirable for single
> >   DMA transfer of a chunk, this saves the effort of preparing the
> >   Link List.
>
> > +static pci_bus_addr_t dw_edma_get_phys_addr(struct pci_dev *pdev,
> > +                                         struct dw_edma_pcie_data *pda=
ta,
> > +                                         enum pci_barno bar) {
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX)
> > +             return pdata->devmem_phys_off;
> > +     return pci_bus_address(pdev, bar);
>
> Does this imply that non-Xilinx devices don't have the iATU that translat=
es a PCI
> bus address to an internal device address?
>

Non-Xilinx devices can have iATU enabled or bypassed as well. In bypass mod=
e
no translation is done and the TLPs are simply forwarded untranslated.

> > +}

