Return-Path: <dmaengine+bounces-8009-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F6CCF2FF8
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 11:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A88A3084383
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2505B316185;
	Mon,  5 Jan 2026 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G+sCDgHa"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B9313E1C;
	Mon,  5 Jan 2026 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609011; cv=fail; b=kIVBrYHUKxKrEhEWbJJThifIzTGju+lV5Q8y94SGRNAlKjDHAPAFrB5GFfOGleq8Rtd0KaWSRjiEgIeKxhqdIez0+YiVhKHbAnr/E1eycH6OTOSqlfBLirD5bCS53IHKC5uSiInvTLpf1S9MdBGCxD4vSX3GFNzOnLvsPhNn1uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609011; c=relaxed/simple;
	bh=5OTELLNnfiOAL0dvjTpBNC1Z3AZRIABCnHUlD8YdtNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LldZLw92z/YVwvAkl9cEpP9MlMQb8K/qQq7Oh2Z6AMGyQvyE7Q8RkZqDXhY0JH58y8Fc/U4Kf9Z4WGVcqkhpscQh0VdOhKAvb4tN24jXk38JpTlsskI74WSEL29IYmPHJWc7I89Fvyi/2xAXBFEStY2+T88C4n+fTYyiB8/40ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G+sCDgHa; arc=fail smtp.client-ip=52.101.52.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kd0sWjY0gg4ETw76tyfHjuAtG7VaMfWh4XDeNjW12u582KDJfv568y96/qxJaCWf4ZmMffrFsKNtrURTvAkd+03/sE4mo5S//6jdctmu+KZvEsbvC5O8nHts/gnrLbJ+o8ZRUbyeVxWtHiuWjXDBxIXrL0C28PdklW4OSFGcoErSvrYj+aGXcBs40TdDqT7a4fQtRVqTgOU8utPgeWUWwQ1u3iVrjA6di5LILTTPJU0/+ffdDvPiDyHqcG92epfkyhLSu+GO76Z7BoJG1KAhYYu+X9o82PTOkxQhmTV22blu718PlA9E0DXc3jn3dwuNJS9oJYQ4YYgJAVL8O573rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0lF86hqnOP+A6Er97eZmpVQ11MmqmvYUYu1NZBDgOg=;
 b=ajj9x4V6hsvsBp5766TUMBJ2bEPtHwWhLMA/RjMe40oLH+YFZTrA1pbCvC1YoqISUmbFn5LGCvLCQSIp21B6k6czrnrIHnPdzk08yvGyZr4FoIdLWhIZExb/WD+mQ5QQbuJJ/r0vfhnrxkbgzEQ1d9pJTcEZTkg4qO0QUan78kqo61P1HNNF1+SyzCgDpNKd0ZI6rieTDI7YE0QMVqSIEZo53FPUs3ftPa2a8nUaxdbrIIJwxZTwdMNg7pvi0XzREq/CnDt289nFYFvQT3a8KJl4xUWwIf3vAMV2/eikRj5pxGMro0GQ3pZyI9dKfjE9Ty9w9eCr61LFgIQmd3R6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0lF86hqnOP+A6Er97eZmpVQ11MmqmvYUYu1NZBDgOg=;
 b=G+sCDgHaZUkx3szeTWE+UQgFPBAussyQMW3lor3hpx4AhkXGoWUtoP8Fx1+Rj+3Wq1RkQEuc6BRaXVWTC4xPrJ0XjIsXkO93dKG7nwQj7vJ4D9I7hiEqkeoGHkOHQ1OPL8YHbniUjR0nA1dqfjM1Wr4cysTWmYoBIyW6BCn43rg=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 10:30:06 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 10:30:06 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v7 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH v7 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHca2HPzgtqx97sLEy+fRS/FbbYFLUeUYsAgAV6cSCAC6+nAIAUCbjQ
Date: Mon, 5 Jan 2026 10:30:06 +0000
Message-ID:
 <SA1PR12MB812096C7393E4E218220DC439586A@SA1PR12MB8120.namprd12.prod.outlook.com>
References:
 <SA1PR12MB8120306AAE9B655A8F8273B795AAA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <20251223162842.GA4022246@bhelgaas>
In-Reply-To: <20251223162842.GA4022246@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-05T10:28:41.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|IA1PR12MB6091:EE_
x-ms-office365-filtering-correlation-id: d8918747-aa1d-4f51-8aa3-08de4c456504
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IPNPhXsZMwIXY7TsPKvKzncHbyhW8Q7oLMYApj3D5JPDnTkA8551zOoCXvHb?=
 =?us-ascii?Q?oqUMM/CmXyQYzczU9r8rOD0VA6ZQgc78CprAMZtMejufSqr+yy/qiIziPq9x?=
 =?us-ascii?Q?VIrjQ68gCuHbJE4t5WKD35aGBISXbFnByIZNQQc0kRLhOf4zti2n7KXgoyZi?=
 =?us-ascii?Q?xol1kvlZd/ClJTQ2TkJIuQJtAEZbyNwIp8OPtki8/s9Dbohqdfn7uut4k4If?=
 =?us-ascii?Q?ePaZ5Xp084rFLQRBYqoE1YnEAk34gUsXYfJqfDQtrTQ0B35tu3aVX9Wpg/th?=
 =?us-ascii?Q?5J3bOzra4xQXvbu5wABPAM1GGVx7z1LnEKe6dCxerm+SmtELjhXBlMdMNOnn?=
 =?us-ascii?Q?JHkgODl9w+PU7cC0kvbPNu5GAjZ/SuN2VRQHxs4hIGSfpI2p0dzZh8COUwDl?=
 =?us-ascii?Q?4nFdtzqO5qbDrWdHRqTOvxdsSFmnTQ4tVzwz0fzdlXW9SNOlnTt0sEVr4wEI?=
 =?us-ascii?Q?mPDGFVJhHifR316TjexbiYL2MKJb+ZE7WXHLNbd669uJRYtnhA1IqOqtMn55?=
 =?us-ascii?Q?8oKOl+l3ZupXC+fzn0+Xv+L5dlBEr8IC6Xz6wOmr8V+c2QGSkJc/14PTRAco?=
 =?us-ascii?Q?gcFrQPZdz8cKb56vucscTVag4obd614igwDj1Z6flmiYrU+BejFvXiyVsX1f?=
 =?us-ascii?Q?cZn11imtQ3zBFZUKYiHuCkCdfe5GpsMK1/JZ6PibzsUIfUZWPLlQ5gomPaNn?=
 =?us-ascii?Q?7cplQbuKRVfXfnyRDYyNGxJUARBU5yPm1ik1ETQf0j38XXQJZBfVN+XTMXot?=
 =?us-ascii?Q?oKnp0RBelHZjj1oEkTJMVLF/ZH9lEPErNZwV0bpcfbkObGyuX1umtubcFK/B?=
 =?us-ascii?Q?ZD9WGBoNmgbx5sFKvaaIzUPWk4+ARP+GSjexzvSxVcWIfwUg7nu9h0cIU/Ib?=
 =?us-ascii?Q?IEZKeqKNf292iZbL4gDjd3sRS5qoGdBUY0QSZ3aCkNW1AoC8C2cMbcfJNMyv?=
 =?us-ascii?Q?M09uQe1eTzMhG6StwRlJFaiQGBkYSAwMuJcjiDzp16z5AxexBOCCDzUSwshs?=
 =?us-ascii?Q?4DxiLWleabGxDk3U+GGgpLJ5eAJNxf4vfCgqI9qUYUcxyBBUdkU29xSk+Wud?=
 =?us-ascii?Q?hrLITvNeED58rccxt1TF0HQYovq3Cjy+H54SLb2hut/jcYpYqu5SbTaGtC04?=
 =?us-ascii?Q?giDBoV/akOutyb/0f3ZkfYfTEyGreJXLAPSVbe6Jpx+U2+GTlHhHs+4uTlTO?=
 =?us-ascii?Q?nHF5Z7n0RjsnMh3vDC+vXbAiDcRCa1ZEz8pR80m+RBqCVKCqmjb2p+4i241p?=
 =?us-ascii?Q?/7x1Wpn5RV2MXOH8xcIk2BQe9eD4we10go38oGWLJ6ZhWnnixVZITzeZsfu7?=
 =?us-ascii?Q?yaA3Wg0y/pzQR29xX0Rgf+l+aiYmkctglFrpPIPPg8sH4S/BVKYUSHi0EYwa?=
 =?us-ascii?Q?3ze++te4lbaWIhlDU7jl5RyVQ3jwiiCBTpC+2evH+BGtrX3q55kBWa7b3aHI?=
 =?us-ascii?Q?aLhigtLgAI7kEK+8I9mJfwPeD6rzxRnufa1X2ihBHzCeqZM6LDUre4F5V670?=
 =?us-ascii?Q?JeV2N+KRz0LrhNS17ABkVxwUk5bAYBx+YtmL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gkyn7BWKf+aTW76SQLa6/exH54MmBk+70DaJ+I5m1ZrA5yD0MSZEqlLTf5F/?=
 =?us-ascii?Q?tBIwGh1DyDBFJAKE/13KjmSdovmZiCg4K7+eKv628jSmVtu82Sz5Bd4/oxba?=
 =?us-ascii?Q?9lcYzONW22tI0nq1wZBWhPmkTHq94OigR3wEDSE5IPla/V1iPXMOZ24gSdyS?=
 =?us-ascii?Q?vRm3mZtr6rgC+IhnBk/jkYNlguxG5EdG1JhgQaa9WETg0RpNjQVPCRh9xN4C?=
 =?us-ascii?Q?tpeVosa1sHWVP9ji+LFXf3h1gHbN7V3y8pvJmSJFHJ3c3hhMDMLTPpYidV0A?=
 =?us-ascii?Q?0sROnVFobtZynLbckYcypmwJ7oKStj+5k+BgYFvCSLJteqWdYZYWUoODadfO?=
 =?us-ascii?Q?7aXryLqTV/7dAxh02DnNito2AA6SbmR3t2Ke1CL49ErmQP9LiecDWjloXowY?=
 =?us-ascii?Q?U6cqr/CVasX/ERsMGRuj+4Isuvwu+xPy4pbUFiaaUZvPjZ0Ov6PfmNcCZfMI?=
 =?us-ascii?Q?FZofpVB5vRd4rS0S4eQJQVDUXTy3JvCUkllLJWj44cFWAktRR8JSaP0xOTs4?=
 =?us-ascii?Q?kPbAh+K8/EXb6je+dR+dqmDMf//4vWIJXAtKmCn7d0kGcSPXVY4gFn+Gsks7?=
 =?us-ascii?Q?mNHhKL3VPClSDJSLVgVbF5dcZ/70NGtqf1tanLwsp0Mys1yT8gP+nRHiTbH5?=
 =?us-ascii?Q?IAyj+W4klmftTvFi0qIOYVXd4YtqUpFZFVfEKFMYod/Dj/Nt2VLkjeOeWeia?=
 =?us-ascii?Q?o3mVfRy4jpYh5Cc4rIhl7r1VeO1k92/NxyyX6F4j07kHLvzBVymCnDEzaPWV?=
 =?us-ascii?Q?VaffaPExxwE6SyZeNvhhz3TZ/e/YM3MJzTqwYoebjeqIkYn1ZzoytzU/KyS+?=
 =?us-ascii?Q?NieaDE2oAK64wM2MhloDUhqV1licYiJf/HJq790QtlSU752ZpGPPfvU7m+/z?=
 =?us-ascii?Q?jCFsJ/wFLU98+FnP/upBfea48pb430m/ffu9HQcA4v6oCncfBb3KvEd04M48?=
 =?us-ascii?Q?c+iCrZR+weUIoZvhF/TW187oyiyPWd4+JdY1Gl/6Ai5hivEZnPUOmUTtk0kL?=
 =?us-ascii?Q?FKEF8kLQRflNNm4j4mUctLpCZsPu59S5JQuzhjGS3A4mvx1Y6b2kMnTdxLNC?=
 =?us-ascii?Q?PBJ+JQPT4mqsKjn4B8FVBRHpkt4B8Eiut79na3RRHMW/QtsTcVq3TB4KF6Hb?=
 =?us-ascii?Q?48rlvvzi31TgVKfDNhT/IdUm+Mi5ysZRZcfnNwxleX3nUfPt8NjRxsSrnH9N?=
 =?us-ascii?Q?tW8PEwor/ezJ5C0T4PHQFJA+fByj7v59pN6uuOVw2FSdXcI/W4UBad62Ac2h?=
 =?us-ascii?Q?uMs64oJ+HtLz2mw23lcT/jkyq/vockFx/OTk+kjdPzqZjwaDyXe0k7YTMxB3?=
 =?us-ascii?Q?z+p8sx7UwVkHe7k9p8yqZqvxWvVhY6FOd/+OZX0cj1Tmv0TmWbvXHVDBy+xh?=
 =?us-ascii?Q?bZzCEoXphRpgbXSQO/2uVhWB95qTCoOdkeZNp+MNTjiRqpZd3QLARmgtTm+W?=
 =?us-ascii?Q?oApfjzJrXfOiJ+vveNUntuST8aB96SdvfacxeHGQ9tTkS6psV0zeNQvZVadm?=
 =?us-ascii?Q?0QEvjWIKC7ZzG+C/TGnXfDoVsgyRBUX0rDARx13MNznFcMom7eYjJzeii9NE?=
 =?us-ascii?Q?zFzx6/wG+reO8s+FYxrPSGPJONAqGSTpE7EHq58EtyG/KZi7cCgVZBijJGAc?=
 =?us-ascii?Q?nwFVOJ+zUJHi/OFfztE3cTCGInd8/Ejx2eCoPemB1v6jztkB02hmkQFCwZxj?=
 =?us-ascii?Q?PPECYsMpW+U7Ufv251rLT/lS4Z/XI9xuzaXphqJZ6K+MoXr0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8918747-aa1d-4f51-8aa3-08de4c456504
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 10:30:06.3896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anltktHuMko1i9s0gLyLf/mqXgjwHIiOVC3Pfj/h/kpjbyUGKlw6e6VH+3wTOGwZyl18hZwnTdI9H8mXzJRBSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, December 23, 2025 9:59 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v7 2/2] dmaengine: dw-edma: Add non-LL mode
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Tue, Dec 16, 2025 at 10:15:34AM +0000, Verma, Devendra wrote:
> > > From: Bjorn Helgaas <helgaas@kernel.org>
>
> [snipped pointless header quotes]
>
> > > On Fri, Dec 12, 2025 at 05:50:56PM +0530, Devendra K Verma wrote:
> > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > > The current code does not have the mechanisms to enable the DMA
> > > > transactions using the non-LL mode. The following two cases are
> > > > added with this patch:
> > > > - For the AMD (Xilinx) only, when a valid physical base address of
> > > >   the device side DDR is not configured, then the IP can still be
> > > >   used in non-LL mode. For all the channels DMA transactions will
> > > >   be using the non-LL mode only. This, the default non-LL mode,
> > > >   is not applicable for Synopsys IP with the current code addition.
> > > >
> > > > - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys=
,
> > > >   and if user wants to use non-LL mode then user can do so via
> > > >   configuring the peripheral_config param of dma_slave_config.
> > > > ...
> > >
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > @@ -223,8 +223,31 @@ static int dw_edma_device_config(struct
> > > dma_chan *dchan,
> > > >                                struct dma_slave_config *config)  {
> > > >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> > > > +     int non_ll =3D 0;
> > >
> > > Other "non_ll" uses below are bool, so a little bit of an int/bool mi=
x.
> > >
> > > The name also leads to a lot of double negative use ("!non_ll",
> > > etc), which is hard to read.  I suppose "non-LL" corresponds to some
> > > spec language, but it would be nice if we could avoid some of the
> negation by testing for "ll_mode"
> > > or calling the other mode "single_burst" or similar.
> > >
> >
> > Yes, non-LL is being referred in the Synosys databook extensively to
> > differentiate between LL and non-LL mode.
> >
> > I agree with the concern raised here but, at the moment, this is the
> > only suitable term that can handle the following cases:
>
> > 1) Choice of variable of the DMA client to use non-LL mode,
> > 2) Establish flow for the non-LL use-case in the driver.
> >
> > Before, using the term with negation (non_ll), the possibility was
> > explored to use a term which does not result in double negation, eg, ll=
 or
> ll_mode.
> > But this again breaks the above either one or both use-cases.
> > If using ll_mode as a variable, then with this, DMA client shall
> > either provide ll_mode=3Dfalse or non_ll=3Dtrue.
> >
> > When ll_mode=3Dfalse. This option would be as good as passing a valid
> > reference to peripheral_config pointer as the value of ll_mode would
> > never be used for ll_mode=3Dtrue due to default mode being LL.
> > On the basis of ll_mode=3Dtrue, the DMA client given option, no code is
> > impacted with these patches.
> >
> > When DMA client gives non_ll=3Dtrue; this causes confusion, DMA client
> > does right but internally ll_mode as a variable is set to establish
> > the flow for non-LL mode. The different variable is used for
> > establishing the non-LL mode inside the driver code.
> > Also, it uses the combination of double negation variable.
> >
> > Though, the use of non_ll, raises concern due to double negation but
> > its use fits the use-case from both DMA client and in the driver to
> > establish the non-LL flow. Additionally, The use of non_ll also aligns
> > with the documentation of the vendor making it easier to follow.
> > Please let me know your thoughts on this.
>
> OK.  It's good to match the databook.  Maybe there's a way to restructure=
 the
> code to prefer "if (chan->non_ll)" tests over "if (!chan->non_ll)"?

OK, this can be done. I will update this in the next revision. Thanks!

