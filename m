Return-Path: <dmaengine+bounces-6482-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6CAB547E6
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 11:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524D9A04AA9
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5C027F006;
	Fri, 12 Sep 2025 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3eg1vy7g"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F98280A2F;
	Fri, 12 Sep 2025 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669476; cv=fail; b=FvoMScrSjkbxN/HkfD8nKWcu5Ikgrf34qcCsllDcpE/p0Taj3q6Tu38oSGwoyXdQIdLPblgDxvwJDUjxVeUn+ZlNtZkfwHwobMdJswTEyLSY5ep+TWgio00jSH7Q9X8scpV5XyWbi/sXQsSOFJCXUmVe20U0bli3/JJZorOM9wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669476; c=relaxed/simple;
	bh=0FpPAc4nlNYLsJCyoTfIC0vvvBZCK162Q6e+h+0V6/A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o/iblxTRNBj2ERPrwIGK6/3ahf41zvsTV1P5SC/Z7mnWHciBrPDh5Sl6jEaO8MfXRN+zitmvStdwQieVMISRojIBuFvsVkItCkJa7LxqOVbsVZqjH7X1yFXEySwWuv73gCqdg6QnCBSVQ2c2CFwwz7xBcZMfTXjGsVG791JaCdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3eg1vy7g; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsZsqDvpJNkzXrwqdcd5PNk5LRi9bPNK7S4ZXSGBh7zh8NayfTNSptup1HGiLyAYNaY0QVqBSnk80mBn1YnBc9iNu2KRC/uBGZqP87eypcByrS5n+mTWsUx2P5fU8g2b+YD6Igqkqm4RAfZNzsc7j9eUv2LJkTbc7Z5PLMRlU99Htz7HeoOSgn4vXclZ2p7tXmcJHoPWyuDKGRWJZ7bblxMHdx+8hZQBTQEnBysYXnkLcXwSzBbh5EkHtzBSx6WcrEmxta4uJmiK8rE5vGNuIAPresznJ8HHKGhyUxNYue/qqAr68pIVrXA0k4jFLPeDCwz10ZACF7uFhyQPBlC9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBTCxCwEm+mJ0u3HwuZ3tuxjH6x+GBopy2Go8MCBCXc=;
 b=p3dUKzzlFBN7MpmwQvojQC3P3o4y2OlRqIWMdfNL3wB1+r7KTnVD2mXGP52NWSpNXc9hgjTh3wKEhRTMeUzzN3r61PIZCKLCElmw7t7CudcPCaOEW0tD5AJCTF1rX44USi++JwatjXZH0IeWO/9hJGX1IPzIdTR/gzKy7Af5nrwpr42W/g6+vWvr51c9FWjdh8FTQoT2GL1uDQ2lwH4vC1/d6l7MJMSXE8N34E25sU4nspVFoMlCWONLmGZ/ryLidKOGvyQQI9qdJiVQSGf8HyUKJy9stS75rXcalrAXdFpYRmfuVcgHBJjcK5K/LQJjjQZOg+6R+PszivjoDr1nOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBTCxCwEm+mJ0u3HwuZ3tuxjH6x+GBopy2Go8MCBCXc=;
 b=3eg1vy7g73uouvRQS39hGHVt1oxmAAWMft7DRlb+ogsA/576hyHWaRPtOLHn8Zt2UvlC25pOwoBn64eWP1vBJwBBQOvSLdyzA5bwSJZX/I/iDEReMbnCkXExSMdoWR6iMjn35mqkh3gPP4sKK4dsQUsQxfAkTIgTTMZys15Ctbc=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by IA0PPF80FB91A80.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 09:31:10 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:31:10 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>
Subject: RE: [PATCH 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHcHpgus9635/jJ7UqyWh/j4Mmvg7SMBtGwgAC0f4CAANbYYIAA6ioAgADQFNA=
Date: Fri, 12 Sep 2025 09:31:10 +0000
Message-ID:
 <SA1PR12MB81204E8706B7EB7AB662573C9508A@SA1PR12MB8120.namprd12.prod.outlook.com>
References:
 <SA1PR12MB812027AB20BEE7C28F30A5FE9509A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <20250911204340.GA1584422@bhelgaas>
In-Reply-To: <20250911204340.GA1584422@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-12T09:08:24.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|IA0PPF80FB91A80:EE_
x-ms-office365-filtering-correlation-id: f8d8a476-1151-4344-a597-08ddf1df1bed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DODf3mpwnboKTZRuXGM2vY4hvBKTYZ29MG61doTItHapKHM6pzT3VrWvbS2W?=
 =?us-ascii?Q?yoROWZkatnYUbIRYaAQktIHLuG2EIXvhYsn3TPYbrDdW/jGve7F0xQG9BY/h?=
 =?us-ascii?Q?Q0rzKRfhT//mhisymfiWz0PFWy9CVOTTgvIdx58mmtKlSQ4scoQqE9crFkJU?=
 =?us-ascii?Q?bD1QoOojcdbVUaLZbTjJYj7W4gfdJxBwl3+F7dc1NVwJx7fKWJ367JGQRsqI?=
 =?us-ascii?Q?djtitvzzeizuuDrE/qDCgMvgAVQ40tcCdOXLaX19WZQ0GVjK22oTUxZ2VoTe?=
 =?us-ascii?Q?lqLo+UuB3HxZMJXxD7A1r9USkCy8qBviQBeM1NHbvTp2ep4/DmymRKqOe174?=
 =?us-ascii?Q?URY2g2rG/UAmZu5FBh9lEWIV7JNrGoi+93hzrgkPA3vC83aIumbedHk60tmj?=
 =?us-ascii?Q?gXxU0MePLrhDRlmRQycaFD/4zBkupD4Cxgu1bmacEhcWj3r2EQW2NHuzgZCT?=
 =?us-ascii?Q?O0tg9jreYRiaMqtnshcoV6DxsMILkfo8qeqWf676uiRYqIyKsIiajGZxmp14?=
 =?us-ascii?Q?sQ/ge9iHJS8rlF7TuNcDdcwbhdZKqwGkutZnfEd/8ipuZ8VvjIXBDIObExDi?=
 =?us-ascii?Q?1em81ppAaASfnmFSSc9nBylmYFt9numsQ0EfdEflaEEwE0AfzZyUmjxNJVOH?=
 =?us-ascii?Q?sagLtkAm39YFT5nQp891ECfWZEN/FacttGlMrQtJFrLT8PjdSafAhHNt+QAf?=
 =?us-ascii?Q?I0ofi8PcZNuS0TAKaBmntSTWI/o21T8pEJoQ0AfDfwPP13PNYdMupH/AyjHc?=
 =?us-ascii?Q?30JMjSQYGhgOo79XsqQCDUjh7PaqvBV3V4Rr2aQe2ylmt8PachkZgkgK3O+T?=
 =?us-ascii?Q?gq7b9/ucFcm3SVtUenY4azwBcjnA1VNfuEV6nuaIQuxsFuAUVpfjGOrJiUkk?=
 =?us-ascii?Q?87pdjHfM9Sq5aEIwNHebOCsD4ditfEwx0fhvF/wsl1YOKGNefTQgsKHp8s8a?=
 =?us-ascii?Q?GJnh6cwF6yy9zM+zxbo+YhDqD7/P1h14//L/+WtRdCBnrdD6Co8PZl389yej?=
 =?us-ascii?Q?UWJzq+j+naOf0EgM/U+X5JGx0ij4J0m3w5ZOl5giFWravQuVM/OhaUFB45lw?=
 =?us-ascii?Q?3qP95V+CN1BpCC7skMXKf36kMVkNpjJl3zrNJSDaCNWAxZHE/tJrcJGdZkuJ?=
 =?us-ascii?Q?o22eU+QAUC3iB0iwzbj5YKupNGhUgbCVuFJZEHMAFLScM6SkMWM9N1RpPlsz?=
 =?us-ascii?Q?G0Ofd29TS4zvBRvsjtVTbDloEC9LTTuQ00bWdaIK7VfFvyJt869PtrVgAkvk?=
 =?us-ascii?Q?I7zXrdnDY/5OQo8xmvoug/KNZPuxkCj0se3rE8639dsPISyre0ElRxlokhh1?=
 =?us-ascii?Q?SWrhwgfkswOzFSHnSChb80jdgYMGiFhBHWn470lJCV2XAV+Hfw+xGtI32i0B?=
 =?us-ascii?Q?21AhCV6hg7WMgcPBVbUzPlR9pB0wVI6IfDHxai8YgsChxvEZMJc15Ve+qfCT?=
 =?us-ascii?Q?2Z81HSsQ775nkT0C2m43lZEnrPot7fja5p4XyJssW6AzzCplP1K9bw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LJnII6JPDMEO9gczlNaJbgEyaEBbgWJ+9oHRuS6S8dzLelLLtCRWd0KNXh1t?=
 =?us-ascii?Q?PmKT6Zm5f373Ul47gxgmMqWFXHu3ZYqvo6Yn+E4k4TwXRnHKgl7IF9CICBGA?=
 =?us-ascii?Q?O8zg7KUI1E7ShTrfqxJ0mwXfi0zNwNONdG3b3xWA5Gur6fIXnxRxabULOwf5?=
 =?us-ascii?Q?2XjtyA931NxhXyCZcBuQxP+OP4ErZYg8wEgxiGaJwf3nIqGBPMXF2tfPcRs5?=
 =?us-ascii?Q?w0ZBljf6QE74OK2Rz5dXkTcEanuiNZoIVQVQkse3oMA3jTXf8P/Sk2Ls0ukY?=
 =?us-ascii?Q?JkFQYX/m9gLGpOh9sXevC58IdiGK23fldxpiDX0w6E19hOTRJQOUW+mlIyG5?=
 =?us-ascii?Q?fw2u6zeWx3G0exhudqwdL29E9jOdwfQqH1UqtpGoP0yG/2lNPuXWFGQwL8kg?=
 =?us-ascii?Q?GWHQishFdMvhWxAMFY7hYqr5wQizoo7XLVfaoJklyWofNyIEk4uR9S+KxkZW?=
 =?us-ascii?Q?USuaeolcpdWBBXKUHOgkL/bVRBJH8wPQxJTSm4Izrbz9TeaI4EAC2F4bg9GG?=
 =?us-ascii?Q?XrpyyeX8nzDvmxSHa5AKp0Q3EPSea2fGwt+pwVGSMdiLRkKdCCQhBe440d+2?=
 =?us-ascii?Q?MRrsCZZglC6KIx3Ujfv8gWhodqlYC24nfY8yvBwSpI/zy/hVRv+tsZWeu8BN?=
 =?us-ascii?Q?cRyapgB9U4sKW1wky9N9h4SlD73j3inOttLqpneL+EWKAH1D22SAxF65Jx05?=
 =?us-ascii?Q?AVXC+2436m+jKycL4CTGPIDfL0hLZPq6jChF+TR3lBNjJZRKFHPQi7SfsJ70?=
 =?us-ascii?Q?s6qv+kjQT6mS1FpT6E8rsnlv0ZLhNkNuK8nwNNql71Z0ja3Jq7nwzVvEyHO1?=
 =?us-ascii?Q?P0MeQBYqjIFx/ckbBOkLz4tzgSIvN/cR0wbuPvi5FJ5UJRo5AMa77UXLJdmh?=
 =?us-ascii?Q?bWVKLpG6FatJb3AFYUF1cZA8NGplW4Y8PDBZzyqfzkESY0pEJghfO/e2EvYP?=
 =?us-ascii?Q?1ujcPTKw3bdDn6hkeBg/SD3Vug64vxPDJQXQW8JXvFPafiyMMQAv5dpyC7rX?=
 =?us-ascii?Q?BC6RcXBDPSDskclVgU6eNUi5PvNanq41d+A1EDovGyw/8sUM/W9qcOo92P5p?=
 =?us-ascii?Q?3akgSuizikXn8WQhSvIVBKPw4240eJ2tXTGLQNXjpyH53WzzUKLa+z7IlARE?=
 =?us-ascii?Q?m9zVhYvEFfhbhUBxttz2/uDchn13vvo3M6D8bMNPbwfwLVF0DMjpNeZq5Z8O?=
 =?us-ascii?Q?qWOFvesHOfrMSJ0l7FEF1xRNuW7whBGjaDzjpljbCkqO6aP6yZ/A1MTSgnt3?=
 =?us-ascii?Q?zIRWrEWKk+M7THReW1f2ZUvmMNPd+Nv23tF0RTVNnfWoBkz6Wg2g96abffmv?=
 =?us-ascii?Q?9YFWOUopUQHrQkITCOOfcSuoCGgW5G6TJxCrO4EQmjN7e2ASErpYz2zi4iWP?=
 =?us-ascii?Q?rFjvx4Qnnt/eR2PFFPiH/25YvVB5Z7yJz0p6dWGk2Q39ZSzlwYcgrgN83pcP?=
 =?us-ascii?Q?kumtO89APQB51O+8sZFyTrYq9qA0GLN5EkTYnURjpYdYmigmvI+U5iMz0y/O?=
 =?us-ascii?Q?uJ9q5PsGy7uX6/TyccbnW3ZAusYrNGmSF0ynmLvtLr4fh7j6+ZWaMoF58gTf?=
 =?us-ascii?Q?2FLr6eUTyEzcoV01C50=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d8a476-1151-4344-a597-08ddf1df1bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 09:31:10.4863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IsmPkSIWhPzVH+xH6B5rG7+qm7tCypr0IZmca0/8f4nV66+VU0GAfeUJbYaogQ8mhxcYWN1L+jxIyLiBUGWimw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF80FB91A80

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn

Please check my response inline.
Regards,
Devendra

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, September 12, 2025 02:14
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH 2/2] dmaengine: dw-edma: Add non-LL mode
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Thu, Sep 11, 2025 at 11:42:31AM +0000, Verma, Devendra wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
>
> > > On Wed, Sep 10, 2025 at 12:30:39PM +0000, Verma, Devendra wrote:
> > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > >
> > > [redundant headers removed]
> > >
> > > > > On Fri, Sep 05, 2025 at 03:46:59PM +0530, Devendra K Verma wrote:
> > > > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mod=
e.
> > > > > > The current code does not have the mechanisms to enable the
> > > > > > DMA transactions using the non-LL mode. The following two
> > > > > > cases are added with this patch:
> > >
> > > > > > +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> > > > > > +                              struct dw_edma_pcie_data *pdata,
> > > > > > +                              enum pci_barno bar) {
> > > > > > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX)
> > > > > > +             return pdata->phys_addr;
> > > > > > +     return pci_bus_address(pdev, bar);
> > > > >
> > > > > This doesn't seem right.  pci_bus_address() returns
> > > > > pci_bus_addr_t, so pdata->phys_addr should also be a
> > > > > pci_bus_addr_t, and the function should return pci_bus_addr_t.
> > > > >
> > > > > A pci_bus_addr_t is not a "phys_addr"; it is an address that is
> > > > > valid on the PCI side of a PCI host bridge, which may be
> > > > > different than the CPU physical address on the CPU side of the
> > > > > bridge because of things like IOMMUs.
> > > > >
> > > > > Seems like the struct dw_edma_region.paddr should be renamed to
> > > > > something like "bus_addr" and made into a pci_bus_addr_t.
> > > >
> > > > In case of AMD, it is not an address that is accessible from host
> > > > via PCI, it is the device side DDR offset of physical address
> > > > which is not known to host,that is why the VSEC capability is used
> > > > to let know host of the DDR offset to correctly programming the LLP=
 of DMA
> controller.
> > > > Without programming the LLP controller will not know from where to
> > > > start reading the LL for DMA processing. DMA controller requires
> > > > the physical address of LL present on its side of DDR.
> > >
> > > I guess "device side DDR offset" means this Xilinx device has some
> > > DDR internal to the PCI device, and the CPU cannot access it via a
> > > BAR?
> >
> > The host can access the DDR internal to the PCI device via BAR, but it
> > involves an iATU translation. The host can use the virtual / physical
> > address to access that DDR.  The issue is not with the host rather DMA
> > controller which does not understand the physical address provided by
> > the host, eg, the address returned by pci_bus_addr(pdev, barno).
>
> Does this mean dw_edma_get_phys_addr() depends on iATU programming done b=
y
> the PCI controller driver?  Is it possible for that driver to change the =
iATU
> programming after dw_edma_get_phys_addr() in a way that breaks this?
>

No, driver can neither program nor modify the iATU. Once device is configur=
ed using
AMD Programmable Device Image (PDI) which contains these configurations.
Once programmed the configuration can not be changed by the driver.

> Bjorn

