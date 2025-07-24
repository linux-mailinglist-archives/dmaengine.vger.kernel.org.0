Return-Path: <dmaengine+bounces-5859-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DA7B106DE
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jul 2025 11:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDAC3A9B7B
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jul 2025 09:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1601624677A;
	Thu, 24 Jul 2025 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HhVFIR8N"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626A2244677;
	Thu, 24 Jul 2025 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350318; cv=fail; b=bl9lm3cCBGPXTeaTqunSqePmIvAXXegpL7lkQC8Xld5ZikoM6ydgWENkXCbirhu4Wp9KVrsmlEzrNv4ddJOpaJEOhogniYQDzMJyn/0hRYuQB+1h89REKqh4ELcgFz5DJW4ezJrBDKypFQEofMUHK7k2p62zcEHEmCJ5N4boMHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350318; c=relaxed/simple;
	bh=AVNz1LcqFrmJ15+Y3aJ24lRyRu47iNkGIvuNUbckTFA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rCpViURnUtHzSHvT3zBb6S/oRj8i/2ChqcSf+e30PYy4UoDRj8I+XFvx1ur7sxgG5C66dvv7qWWY8aBMgdRjvYTAGlrGZx3NQz+KvtKMswrDbm4FGXfBkC3/9J5ZfYRyyKUtPkVrSw4jVTKe/61cvJIMwxAaIfs1ug5KjSOTdeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HhVFIR8N; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzkAI9KSODI/jqcDnfRVVN6cm+Cn+italKDIi49Gh+n/EOUjbxVkbb1zb/GQ5ZsIoTwKet3xRa3Emf34qgtrGRbxx7VH++KIc5JIuco2lu8v6atk3ARdvY5byKCXDcL7yMc85OGdh8ENF7PgRelVUlQFK9mHDuZtXMDyV+0lyWqZksPyAjVb9RyaYyGbeGkpj6Wml/VuCwGbigOiyJ21DZ3EvoBjp2lgHQcgwh6xE2j/+2YNWbvLrZflPhDwosiuu+j6MRpyCsC9UVSUsWxqel9KDGHNCDHysm500M/o+Aq8tIaIXh4Es7J17BwIIXc7n0TkXpklrZIEa7PWRf0Dlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GftXEo9mV+V63LskmuCpJZWDg1WWdATgpUhzf++TOdA=;
 b=tS0xtSRG8QOSJRi5ypNmckAkfvdhaTbrsgK3T+ugTzT46LrLjhPXVZZZXnZbyuHkY14U7l6A7t7lNUtAufJvdh9h0udd2aVEToCBfkzxfyteBu2phyDC4gC9dJONA47HPhsTpODRVOA+jhLQsVVT6itn7n4Z0JKKQhjBXz4AMdrVjG7SOfhBilnpPAS76awDerWZvbmsTRR2rKpiGiqFt2RPQSQHJgJzkCzPY95czdBieTkNMeyJIcTmW8DKNERYXZ5KdzDfLF8ZeL/5GQAHMw05qw8BLpC8lYCEe6okyMO3l38e8RJXg1voy+vjdmYUZST2S0Idya54TcfyeQCdfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GftXEo9mV+V63LskmuCpJZWDg1WWdATgpUhzf++TOdA=;
 b=HhVFIR8NEu1b7zwgKgnzWAd9LhJ2j70pZXFHJo2GpZFT1E2UU4F3CiJX20S28AzAvEHf8lCEPPpCrlMbsQIj1wMwXGFg44L3k+sspTiNlc86lMDhXDRR2kHXqQ+Uhnj7Nq26KmsQ2Vcb3YgWTG9POBdu4eFSd0ZcRTnsbC/qX+o=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 09:45:09 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea%6]) with mapi id 15.20.8943.028; Thu, 24 Jul 2025
 09:45:09 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Vinod Koul <vkoul@kernel.org>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mani@kernel.org" <mani@kernel.org>
Subject: RE: [RESEND PATCH] dmaengine: dw-edma: Add Simple Mode Support
Thread-Topic: [RESEND PATCH] dmaengine: dw-edma: Add Simple Mode Support
Thread-Index: AQHb5AaGsGs5kTrW3UWG39W5gh/nlLQWBTmAgAiaQpCAIN0GAIABs9Fw
Date: Thu, 24 Jul 2025 09:45:09 +0000
Message-ID:
 <SA1PR12MB8120E7DFF29A8EDF96C14946955EA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20250623061733.1864392-1-devverma@amd.com>
 <aF3Eg_xtxZjZTEop@vaman>
 <SA1PR12MB81208BAD2A5D264482333FF79540A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aICNQuhw3SrZJrYS@vaman>
In-Reply-To: <aICNQuhw3SrZJrYS@vaman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-24T09:20:24.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|IA0PR12MB8087:EE_
x-ms-office365-filtering-correlation-id: 4a027040-0d82-49e9-18cf-08ddca96c76a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8EhxvmPnMN2ob9QGhVHC+cXbYanywt9OVgjrvH48GvBcGY1dhzmo58Ar6qOa?=
 =?us-ascii?Q?fXDvUGb96fThieBWQ4dZn6ZIoZvV7LDGv0JUDL64W/gyIs+DrwTlBOldFG/G?=
 =?us-ascii?Q?Q/iaDGY0LPOoNXo8bAs5JesECLG/Lsv9Z240nuHepX/mebomC4eMtnpubzoo?=
 =?us-ascii?Q?CKHFiaRIpT13huWjVVpHTJYbAyt+3bV6+idFC4hqSWdzH6HVL7kNi7tn0d6r?=
 =?us-ascii?Q?PEIm6ZxGeQCw15c2SHvIxktaIu5FcOzZ0tTOTbY8r6NFo9n5YnoPlYngEZZd?=
 =?us-ascii?Q?ZvCik0bHV7tS7FO8idqCnk90BHdIhbKlMF5HKcYg0gUyz4wfcTsHcD5hQg1W?=
 =?us-ascii?Q?ZhXzhdJe5+86XCOK/dhAHNMQNBrihMipZlvDNVrZrSUPXSsPu9Uz2jiV3yhN?=
 =?us-ascii?Q?cGxlJQpx/h51joFr7WWGcCbip/+J0xT+E1OMR5EAEuegfb5msNv39qQcRXZD?=
 =?us-ascii?Q?JYrQNtWFittRwN9uxRN+0z6cL76AtEfhdjvIJbAZDjGT786f5yvEj1LsA9y3?=
 =?us-ascii?Q?49DaCGlOHbiURPDkwLetqWR0io2XdUUXdUbaJ/tvyL+izVijNNNuPtv1VZpA?=
 =?us-ascii?Q?zUeNOP52CE/WCDEtZFAsPDxbdZteLWUF+mNWPNxOlqTXd5dpmYYmLobr7+g8?=
 =?us-ascii?Q?5EMS5P9c8gXvHRdDIuRKtQp+iGGa0e4tadNutrp+2P8rHA1D29//uFz1gzOe?=
 =?us-ascii?Q?l40bqYbr26cDVIgKwBXCWQBIvtvCHFXiCql3FnuyTC8F/M/Sqxzg42QrA8jR?=
 =?us-ascii?Q?sraKDTIONSsS1LEva2ltYP6jiLdndLxQwhkanMQ8kTK34aP2DsaqDEUIbS4w?=
 =?us-ascii?Q?D3yxBQhMlKGwwLV48vESu4aZLlCYSTbzOx6V2ePMidrPJ2O4jCU/0PecFW5m?=
 =?us-ascii?Q?B4KJnASYzVWPJhnZnI57mx5jvt3pPYVxQEe6ecL281KXn3dU8ddRGqvceGDW?=
 =?us-ascii?Q?ZwlNlVPI1wEMxpOvZN87yOkRFnvh8b18uxxAmVcgkGcmP26mZHFY8AF13Tz/?=
 =?us-ascii?Q?p18nOsOC9W+Ul1442J3bKK0q4Rp2S7LvFk5alEyQBEvPLeYTBr/kUN/VEQyu?=
 =?us-ascii?Q?Rtv2ze6Z6cmbjU0Avcdyz4ZlG1SoRVMl/MwP/hfvKHqoOOp7t2cJnWHPQa+9?=
 =?us-ascii?Q?UXtSIGbCrZ1aQm36K/qpMlDXcqs4OQu0OqlenU1wQbLDIhFRuJ4+gOKSg2Us?=
 =?us-ascii?Q?XwyLJRxpO+uZnmiUDmNyHyTRacgi6gUfUNrgyF6+8BozBnB1ZfPvzlMOUwel?=
 =?us-ascii?Q?zBX8oDFluIryck6O89SiYpVs1TASVm/AIKUU8oUDF17P25HidxrO+13ykM0P?=
 =?us-ascii?Q?EDLNif0hHE4PpfznWPDnX5L5Sjm4HqJdxajsOMq6e5CqsztNNmpXU9PEwVtE?=
 =?us-ascii?Q?56n5u073YfX1+3YVXTW1vExvDGz/gwlxBjnvxmiQwyZ1lkg8muet/H+t+uZ+?=
 =?us-ascii?Q?5BOHNWcobBLaLWEre2hErMY7EDuOZ6lHZxd59lnpiSKmb1OnsinfWGA4HzbG?=
 =?us-ascii?Q?jYEjJW0p+dcNiEo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uK/bDkRMTKw1ubODXYlxVpkd6K24cZiMxQIY0U0vQqCxiHWvUYLkZ1Gk/rRj?=
 =?us-ascii?Q?UCmfjNuf5QQXWGMEqLRAlepNYQp6LScOYHV6cQHneldhmPYX2yenSDSTxw9U?=
 =?us-ascii?Q?STvziHVZVRyisNwvJDKbkZqE+jqB/URsDdAEjMD4gk+BK3gUwWGd/f5ZIUX1?=
 =?us-ascii?Q?ZLaR9Tbs/OYOJNi+AEEoZFPCalHL0VZrBNHK/G1l0kip4E0TW8d19BMEavaa?=
 =?us-ascii?Q?tPR4lYs/iCmi/ZfjQWLp934ezClP+ioGV4TFnysgd7s21evAwk+zG1vIkAe7?=
 =?us-ascii?Q?7urCiqmw6O5xXVdxJzik34T+eNy+9eoZi05h2Xofmm4VndK0b5jsw/25wr6G?=
 =?us-ascii?Q?O8u06JhH4UHFaQMoV6PkuBlQaqI5TJOyals5jP6ksue0skRoJ/21jIQ2g/BH?=
 =?us-ascii?Q?trmVG9AjsZrm5W2ZCsXVm0xurQTwXaNAVPDjSo6oKPLaAaU8zFVp6NfvAYuR?=
 =?us-ascii?Q?Bw9HHq+GkfNq8MrZzgmMXKjs2x9w8X8Erf2Cu4zODiF1OSyi8oCHLKtx480s?=
 =?us-ascii?Q?FYYe1OJ5ta8zufiYx4PGm70aCINlOaopVqv0xstzxuo7FJSyBk1Dy0SdRI9j?=
 =?us-ascii?Q?Gi1hgbOV6ylCv8LcrMoZGw33UYG/v0mXy4EpYwayLzhMsVrL2n2dyVgDqjON?=
 =?us-ascii?Q?+HDhqd0mkRE70A/s76bu4xCaF3QiUJC6k8q5Kcf8ctc7LsQ8bY3KMleR3abd?=
 =?us-ascii?Q?Pbys3io8mGudN7Y9hcTsCAMcoR0MO6V7tijOGwwB6T5HEjF0XX/VG+rkctNk?=
 =?us-ascii?Q?2EyFcxQZmGYya0F556b/prapxqdsYdYF+dwt2WJ5hIPlx1Av3zo4HaAG7hf1?=
 =?us-ascii?Q?q7IsIErfU06YRMcJ3fXjjudt+OqjQG5JBjWEfYD5u4Tyf6d5SnrTLJrzB/08?=
 =?us-ascii?Q?NyS5OTNonx1LoClh9Rjf4QLcsZ46dUkg4EHHq8+39uhZNXfqrqwAmHGYR5tb?=
 =?us-ascii?Q?Fp7ua1qs3XOHrRJdvJHdZrctsOVU0uQQH+mqx02HA3awRTwo8/FXA4w9QVM9?=
 =?us-ascii?Q?VvLNF+CkPU6BsYjfAKimsp+BkrsWMr53o4/XHdRTk7f420zcHe6pHU0DKobe?=
 =?us-ascii?Q?h+2wCyFsdSGVxoPe39czqf2Qb0nUGG92SWCzFpAREAKyuTWVg3q4ghjGJWNO?=
 =?us-ascii?Q?8qUCNw51HmchusDkRdC7chgRk3+w80dvovTQSdafTPzaXdXl92g9iN1UmPJD?=
 =?us-ascii?Q?w9+kA9Yk27O7Ni+vyd/pBesNI+oPxPPht9KWBwlaA9AZqNvBr+n8AaF2d3uh?=
 =?us-ascii?Q?g0b3Lr2nFRcIs7Mv1piIei5+1KLHbW0X56S8ttC8/e3sUcQgp+WW8j4/9rpp?=
 =?us-ascii?Q?VpWEegp0dy9S6YvrmNzj/meOoRuPReoOSfLJhv0RmZLNBrEOMNK//3QcUrl0?=
 =?us-ascii?Q?mToT3wnI8AKUq/iREvmXA3h2qZD2quDBfptE+YYq6p3FwucJITuURmyD3MjA?=
 =?us-ascii?Q?Yh/Z9LD/kdPPD++XIxvwsPvqzIw5kTz9RLDeOcXGh5KcA2eG8DpQ+dVf2G2v?=
 =?us-ascii?Q?FgvTBDnoy9vLbNycGH/GOloX2szI7fxIzEw9QrAjcycltd+ViM9/0ufET2/q?=
 =?us-ascii?Q?fvdp62Z42+YR+9MpyI4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a027040-0d82-49e9-18cf-08ddca96c76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 09:45:09.5724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGxLWfjl4zcp8cUfqszJnP5gtpANcNwjaxJtdZsQ+PfI3AzO19zjxZaxLskNQgWljvqh5HQ2aok32Hpfl7V8JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Vinod

Please check the response inline.

Regards,
Devendra

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Wednesday, July 23, 2025 12:51
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; mani@kernel.=
org
> Subject: Re: [RESEND PATCH] dmaengine: dw-edma: Add Simple Mode Support
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On 02-07-25, 09:38, Verma, Devendra wrote:
> > > On 23-06-25, 11:47, Devendra K Verma wrote:
> > > > The HDMA IP supports the simple mode (non-linked list).
> > > > In this mode the channel registers are configured to initiate a
> > > > single DMA data transfer. The channel can be configured in simple
> > > > mode via peripheral param of dma_slave_config param.
> > > >
> > > > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > > > ---
> > > >  drivers/dma/dw-edma/dw-edma-core.c    | 10 +++++
> > > >  drivers/dma/dw-edma/dw-edma-core.h    |  2 +
> > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 53
> > > ++++++++++++++++++++++++++-
> > > >  include/linux/dma/edma.h              |  8 ++++
> > > >  4 files changed, 72 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > index c2b88cc99e5d..4dafd6554277 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > @@ -235,9 +235,19 @@ static int dw_edma_device_config(struct
> > > > dma_chan
> > > *dchan,
> > > >                                struct dma_slave_config *config)  {
> > > >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> > > > +     struct dw_edma_peripheral_config *pconfig =3D config->periphe=
ral_config;
> > > > +     unsigned long flags;
> > > > +
> > > > +     if (WARN_ON(config->peripheral_config &&
> > > > +                 config->peripheral_size !=3D sizeof(*pconfig)))
> > > > +             return -EINVAL;
> > > >
> > > > +     spin_lock_irqsave(&chan->vc.lock, flags);
> > > >       memcpy(&chan->config, config, sizeof(*config));
> > > > +
> > > > +     chan->non_ll_en =3D pconfig ? pconfig->non_ll_en : false;
> > > >       chan->configured =3D true;
> > > > +     spin_unlock_irqrestore(&chan->vc.lock, flags);
> > > >
> > > >       return 0;
> > > >  }
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.h
> > > > b/drivers/dma/dw-edma/dw-edma-core.h
> > > > index 71894b9e0b15..c0266976aa22 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > > > @@ -86,6 +86,8 @@ struct dw_edma_chan {
> > > >       u8                              configured;
> > > >
> > > >       struct dma_slave_config         config;
> > > > +
> > > > +     bool                            non_ll_en;
> > >
> > > why do you need this? What is the decision to use non ll vs ll one?
> >
> > The IP supports both the modes, LL mode and non-LL mode.
> > In the current driver code, the support for non-LL mode is not
> > present. This patch enables the non-LL aka simple mode support by
> > means of the peripheral_config option in the dmaengine_slave_config.
>
> That does not answer my question, what decides which mode should be used?
>

Simple HDMA mode is useful when there is no need for scatter-gather and
one big chunk of data from contiguous location is to be moved. It saves the=
 effort of
preparing a linked list of descriptors as DMA channel registers can be prog=
rammed
directly.

> --
> ~Vinod

