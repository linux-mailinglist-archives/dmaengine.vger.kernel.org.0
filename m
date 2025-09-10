Return-Path: <dmaengine+bounces-6438-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68829B516E4
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 14:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A1EA7B3C4D
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 12:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7E23191DE;
	Wed, 10 Sep 2025 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a/pRHGLZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD426AAAB;
	Wed, 10 Sep 2025 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507326; cv=fail; b=D0BOD8KV/wr5vPSX0jiWoxma+Q9jrO9RM4n9RKfxu+QySrf266FKU0RIRSUoPJ8qtsuh7eEE4sr+ujo/2MrR1ENxR/lVBI+UaMZ/N/PlrsCjYOjawEQaU+dB/qcjQm5CLW1I4lNuKHXotTvqkVIcZOzJ22Kf31zRLS+1ACJ0Hro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507326; c=relaxed/simple;
	bh=opedww242jl9UbNKkoB6201KTDKZN7E6U5+rVO+av7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CCy383qFsG4PmIAi1WLrf8wMLHwFgIN+hMSAm902luMVQVLxjmJPVaj+fCE9rLBhlUnxRYZQFMYI9aO/J31T9NOxzK4rc3HsMhHw97SL8oimYFRtoAXu7ypBFcbDJYHt6GEznXVsEUGb7uK/U50jAGHhAQPCBh8WNP0JXlaUxVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a/pRHGLZ; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWvMWbP3ucGuD2eNAysA1K9zvYmZXBXOirA1rx0JaU40ighiEdg9gEj/GhpWxjpz6CfJhxZpfbfPlfjU2l+mnTFiP6HqTA5kTtqbmfHr8MycLBTp5ZfgB/TdQQh9mp/shctjuzQbi1TK1blU3V0+uyr3+SPSYetQWSsRaoix4K1RmqiQL4g+NuRUqag7kCzTpmju+LPjLRVHfnzK1jq14J/tdWOiTErqLsb5ax/RyJ2k6k3DNSwbuJ7cyTa99/VTInkNKFqOGQwE0yqXTigZ2rq0lKUixyVApMIOo+zjJzVpQHsJrHBoxZhH3j7lVrSZQyggWAWmuvvtkIQHVdQjsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaToFPD3w5GcngIb1bX1xPbnhfzn+HbCJOeVoPyJojw=;
 b=wWDPVOkE9v+SCAZ5mC8W0GeL04havmc6w/RtmBFj/6afoT8pLi8XyIceJbz42A67yQ4AGFcCJNQRwz1+HfKImnEyz8FCz9AGs3ZI16iVHYUUp94I4ek+fkqRL80RzmrUSXa+i+UqNbFlVSLt/oIgAr0okB2DVGZBBFmZQR0ZRrrP1gp06ogTyJAyJsyzsPXf026mL05p4tXgqWxL8vIYlKLyicMcA5V+QyKGbttB4cjMfsTnJqDitOjDM3luCjdHqid4D7kcQbU5K94X5BWUhQYGtVZ4XqrIAy63AV0TauCSLqd0ld3gPnX/ofB8Cy1sGXHktA+ZC1T9g2IG1BP3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaToFPD3w5GcngIb1bX1xPbnhfzn+HbCJOeVoPyJojw=;
 b=a/pRHGLZqiu4iJaJkwlaQM5NSnVb/tg8k4vKGHFNqphFdgsxJhKiUKh385f6NbCCL/vtKvrUQt38ZjwnugsRRlSFfBP572xKWCYE0XRsiggcFcw64ZgWt4ueHVxQGyg+4MEPKGgI745U/zzDpiy5/Ose+qdrL1C0yZu7LemPXFs=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 12:28:40 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 12:28:40 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>
Subject: RE: [PATCH 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Topic: [PATCH 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Index: AQHcHoXBqFeEWD/5aUGDdjHQzqpmerSKuPpQ
Date: Wed, 10 Sep 2025 12:28:40 +0000
Message-ID:
 <SA1PR12MB8120B9D69376F56AD2540E15950EA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20250905101659.95700-2-devendra.verma@amd.com>
 <20250905165426.GA1307227@bhelgaas>
In-Reply-To: <20250905165426.GA1307227@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-09T11:15:13.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|SA3PR12MB8045:EE_
x-ms-office365-filtering-correlation-id: 1b7fb0bf-4a42-41d2-f9f1-08ddf065930e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kTSuepgwUYs9DLMhXNigwHThxnbZbprgw1Uxkt6SneFervk1cqZXtGxR1nFH?=
 =?us-ascii?Q?+Ls/ECOVBDhffutBH9SIvoH7nfryd/9GNX1FKOdR2648TeBv221djup3GXa2?=
 =?us-ascii?Q?m0o24WEe6RVvV0ePM/Y7hsAlJgA9dE9a1bomPW0RzQNUXb1rfWDjuW5sndJ/?=
 =?us-ascii?Q?SkwUdhPy4x7oACWK3w/nR64IUwcm46LkI5RFbt9e1Iblc5K9643onLCSvT74?=
 =?us-ascii?Q?QJuzFRfiROA38EBc5iTBygXJEJ0JCj/veyb/lk2708hCw4yIoNc42G6kF7bd?=
 =?us-ascii?Q?SF2UUuKS++znqYOg9l/9HnNlm7V17+qtzvQElVRE9zokikqXlihpOZbqxFWm?=
 =?us-ascii?Q?U6PUUQAvVlWHW2UpP10HefWu4HcdjfsGncTBtQ2jMVsir5PCxzAOaYUNi/dt?=
 =?us-ascii?Q?cUa0EL+PypehKa7A1SwO+cA9XvvINj7NtXkmeL8TIJSexL2RbfL0C+lIxrq7?=
 =?us-ascii?Q?237Txn++U7RvOf+AnWpXt1z7+mcf4Czs035vMBV3HPuBGMsMLT0rYqYQw/xg?=
 =?us-ascii?Q?svaphqwNHhAtP9Dc0oMeqfGsUAsc239t4JrvPNSVr81DfXHkq/2NNB9Y3Q67?=
 =?us-ascii?Q?nh5eaBJ1ecBpqbt7bulRhqXJ3eOnAH+0VvaA5CzYmXAvHn+CUh1rWeJ+SHrC?=
 =?us-ascii?Q?Lhz4AC+RrAjH7pllKMEDPePilOgBkJCiI14ou1T87Nyzh/OLRLMBn5GfM+bQ?=
 =?us-ascii?Q?7dPxcFS75XZox/HNgK+tJ4jQO4B8Kc0ZUcSSZmpK6uD7EuOgOyTro0nQKy3P?=
 =?us-ascii?Q?cexb1K49ZqKR2XyHeIopyU9NDOr5wx7jLL+zOkhCTcINhtf8QSs3FLMbtjmk?=
 =?us-ascii?Q?f6nkPxLypaOgKwE+A++F4eElI9oRlT5tHcaii1+xySyTAYAHmwO84WhPF/Jk?=
 =?us-ascii?Q?O+ayxly4l83oOwVWscGJ7f4lbVHhrm/p75yMLRAA8+sVNb8ClLr2+DK51gh1?=
 =?us-ascii?Q?mi+UxXymQCo8DJyROESDaEr/q8t/2yCcnUauFXD9OLcGR+6ZfTiOYpxlrkX5?=
 =?us-ascii?Q?XiceTabjlFb7U0NT1mnZ1uzXFW5rfFeNTBa8KtQJHbg8wbXnJJ9roHCsbYIf?=
 =?us-ascii?Q?ZIokLxUxjO4PBbfWYQbXH5RtOpbZ1bABCLSL1KqCgu03qnzU2YGvPHgse8sm?=
 =?us-ascii?Q?BAkt9thwzoiHr3nFUvrkGIFuqFliFrQDvHB4UNBJ23PrCwyvjDXjHdU2/siL?=
 =?us-ascii?Q?iTCfIMxcPzs4cCeDa1C05v22ENx6/a9b7cJQjuPmOS9hIIy5umGKtRzc8Uvq?=
 =?us-ascii?Q?8lJSZKe2vO973npe1QStSFzdpy/nWQK0yPK6mneDacFlTuw2FUJ5cVz62+T8?=
 =?us-ascii?Q?lqLBkT5oSXSHfD2k/NbrCbXWOkwd8zlSjEybSbfoqeKQkumwww/5XJkTkLcn?=
 =?us-ascii?Q?JnyEAB2vOYqR+l1FIE85Rle1yHb6fc4Z7kEV0s2jwdiMNCwika4kjsIPKTaf?=
 =?us-ascii?Q?smGzDgxOfjEwbjfJ/k0JI+hTfBvMalwXxr2JK+wJbt4nMQqEqkNIOBmUt1HC?=
 =?us-ascii?Q?gMERllwc5i5fFP0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WdUSwnyqRF2bI48Ji1pjsnEByAnP3OsF0PpL/mgW46gnUwkQSX0Fg6+ZwQF2?=
 =?us-ascii?Q?Hp+X0wxOMUsoYkISybEf+1YLVT9demsOqM8+j2iF/g8/Y8IrZm/dq/rn1FTj?=
 =?us-ascii?Q?CfSitrj3w7mIZaMY3wyuALrkkWHBQenX4hpBStjkgtwwKRbH0HmAcjl2MKTP?=
 =?us-ascii?Q?pUtWI5Hk6PP1Tuiz1mqK0wnWfYnJWiC5fOjaW0UfPxMgWFlh1jwlIPnfpKn5?=
 =?us-ascii?Q?ISDAPW/No9zxw2waXMYfVq021DGLkAebfBYKiTfwDKlzStyNBMNWK57IQkcK?=
 =?us-ascii?Q?W6/4zN9T/AUtlQHSn+XgKxMAKVvr4pZ42GAkyrCjUvJ41U/5aDqYLMmy40Vz?=
 =?us-ascii?Q?O36ouzwjg1tReXG+6hvvu1o1g0wQExKG2Da2+b255vh0FPIyOTAYe5i/yogA?=
 =?us-ascii?Q?B/S1gXicf8uMxXU/AuhFmv0UgXJKMvo7pnQNxKn8+FcZEi7B4HfGwcF/Jwht?=
 =?us-ascii?Q?HvCPBxQqNUi4HQaMp8ZG2Q2LvE/FmiVT0SppOyAEItVzEjcbvrI+C15GA7zY?=
 =?us-ascii?Q?CI+/gHBmgMgp4t/IdnqPvRqis9q1gkLuSu01qKFmCauqPYWU2DJS7H2667ts?=
 =?us-ascii?Q?x/LmTpFXLUG2bihV/SZNvFed7Fbs24L6oIFCcFvNyOeHKTpGPXL2hdCjwJmF?=
 =?us-ascii?Q?EdYtAgFZ2vTODK08SZCVH60JmRBVoPrIoCLSQwktukWAHr741eGe8PxEk2gW?=
 =?us-ascii?Q?aVGBwofL/IGwoWTunccYldf2IsO6mo3sw2+R0TIwrpkwZ2oP+lF7EJbpfjEc?=
 =?us-ascii?Q?Q95sgmff1w4+fpqkxaNHQbGaNvR/fYYba+PcR5RtW0Ld1QkrHK7eLQSXsc5Z?=
 =?us-ascii?Q?qxV0yOrJsha1t9zIO8SY0pJran75VOuW/dVYMajckEWi9y7974N3y+yV+D71?=
 =?us-ascii?Q?IFfxySlwFKcVZfYAE4okzhAk+rjPjduPKxqow+3o88d/sdbzQu3vx6QnJn7J?=
 =?us-ascii?Q?nJunpXzKLFpEBKRReyAgYuXFYlPTvswSrQCfS8Acd6zIC3tvbiX7Ten9T82+?=
 =?us-ascii?Q?zcvoIClcnncCo3EnKt9SqgCjFlpHFEaPhhHfMpIewdLkVyBWfROXP9HbGFJb?=
 =?us-ascii?Q?Cv7j6ekduRMUj44TBqy2CMklvjHsakaNHmPwaZWqlKlvG/s/tqhJ4GuAHMib?=
 =?us-ascii?Q?DbaFqxkAScsi0Ufxj9fsXeRKzxREIoEEQDwM5pw52sI72cTiurifZXmJoZh0?=
 =?us-ascii?Q?dkNw1Hk8OSDH//t0HZZFHyaSWj70ZbWc8r+ivZj78QYQztiGYK1HnRWesoUW?=
 =?us-ascii?Q?4zhQWc5m2DxVJT1y764saUn//Zf8sCuT+NGRVbUyIJsv0KZYcN2hNwKNGBCd?=
 =?us-ascii?Q?69ycPefWerQOpSvDLhJ8DpNHJ+K4LOj5ctZiMuF757bCuhuv6ZrYaFW4JlGH?=
 =?us-ascii?Q?PRvI7AYCc+tKBbPzhAj1n9AguunsEU0CH4fu7L1R1YUuAb9aV7KKAmgHfWUv?=
 =?us-ascii?Q?rUeBwMtf2KY0b45r0ILta5omgVERzwrXY0Ei3hTb+Tbuon4cLoXWWAJWBLoz?=
 =?us-ascii?Q?qc04CXLg88UP2AZJHkdBnvULzfS5STBSCgrzFxydTVY+C3lSkqS/qPPuATfu?=
 =?us-ascii?Q?a61hO986Nt4u5WYXbGE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7fb0bf-4a42-41d2-f9f1-08ddf065930e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 12:28:40.5522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ua4jL2ditZwkRqzd18DV5fCLjNm2TS3SLMyr/pnOLWJP7n9IQFWE1gqxlXYPjepP3Ppnc2DMR5BmoFt6PO9fug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045

[AMD Official Use Only - AMD Internal Distribution Only]

Thank you, Bjorn for reviewing the code!
Please check my response inline.

Regards,
Devendra

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, September 5, 2025 22:24
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Fri, Sep 05, 2025 at 03:46:58PM +0530, Devendra K Verma wrote:
> > AMD MDB PCIe endpoint support. For AMD specific support added the
> > following
> >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> >   - AMD MDB specific driver data
> >   - AMD MDB specific VSEC capability to retrieve the device DDR
> >     base address.
> >
> > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > ---
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 83
> +++++++++++++++++++++++++++++++++++++-
> >  include/linux/pci_ids.h            |  1 +
> >  2 files changed, 82 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 3371e0a7..749067b 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -18,10 +18,12 @@
> >  #include "dw-edma-core.h"
> >
> >  #define DW_PCIE_VSEC_DMA_ID                  0x6
> > +#define DW_PCIE_AMD_MDB_VSEC_ID                      0x20
> >  #define DW_PCIE_VSEC_DMA_BAR                 GENMASK(10, 8)
> >  #define DW_PCIE_VSEC_DMA_MAP                 GENMASK(2, 0)
> >  #define DW_PCIE_VSEC_DMA_WR_CH                       GENMASK(9, 0)
> >  #define DW_PCIE_VSEC_DMA_RD_CH                       GENMASK(25, 16)
> > +#define DW_PCIE_AMD_MDB_INVALID_ADDR         (~0ULL)
> >
> >  #define DW_BLOCK(a, b, c) \
> >       { \
> > @@ -50,6 +52,7 @@ struct dw_edma_pcie_data {
> >       u8                              irqs;
> >       u16                             wr_ch_cnt;
> >       u16                             rd_ch_cnt;
> > +     u64                             phys_addr;
> >  };
> >
> >  static const struct dw_edma_pcie_data snps_edda_data =3D { @@ -90,6
> > +93,44 @@ struct dw_edma_pcie_data {
> >       .rd_ch_cnt                      =3D 2,
> >  };
> >
> > +static const struct dw_edma_pcie_data amd_mdb_data =3D {
> > +     /* MDB registers location */
> > +     .rg.bar                         =3D BAR_0,
> > +     .rg.off                         =3D 0x00001000,   /*  4 Kbytes */
> > +     .rg.sz                          =3D 0x00002000,   /*  8 Kbytes */
> > +     /* MDB memory linked list location */
> > +     .ll_wr =3D {
> > +             /* Channel 0 - BAR 2, offset 0 Mbytes, size 2 Kbytes */
> > +             DW_BLOCK(BAR_2, 0x00000000, 0x00000800)
> > +             /* Channel 1 - BAR 2, offset 2 Mbytes, size 2 Kbytes */
> > +             DW_BLOCK(BAR_2, 0x00200000, 0x00000800)
> > +     },
> > +     .ll_rd =3D {
> > +             /* Channel 0 - BAR 2, offset 4 Mbytes, size 2 Kbytes */
> > +             DW_BLOCK(BAR_2, 0x00400000, 0x00000800)
> > +             /* Channel 1 - BAR 2, offset 6 Mbytes, size 2 Kbytes */
> > +             DW_BLOCK(BAR_2, 0x00600000, 0x00000800)
> > +     },
> > +     /* MDB memory data location */
> > +     .dt_wr =3D {
> > +             /* Channel 0 - BAR 2, offset 8 Mbytes, size 2 Kbytes */
> > +             DW_BLOCK(BAR_2, 0x00800000, 0x00000800)
> > +             /* Channel 1 - BAR 2, offset 9 Mbytes, size 2 Kbytes */
> > +             DW_BLOCK(BAR_2, 0x00900000, 0x00000800)
> > +     },
> > +     .dt_rd =3D {
> > +             /* Channel 0 - BAR 2, offset 10 Mbytes, size 2 Kbytes */
> > +             DW_BLOCK(BAR_2, 0x00a00000, 0x00000800)
> > +             /* Channel 1 - BAR 2, offset 11 Mbytes, size 2 Kbytes */
> > +             DW_BLOCK(BAR_2, 0x00b00000, 0x00000800)
> > +     },
> > +     /* Other */
> > +     .mf                             =3D EDMA_MF_HDMA_NATIVE,
> > +     .irqs                           =3D 1,
> > +     .wr_ch_cnt                      =3D 2,
> > +     .rd_ch_cnt                      =3D 2,
> > +};
> > +
> >  static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int
> > nr)  {
> >       return pci_irq_vector(to_pci_dev(dev), nr); @@ -120,9 +161,14 @@
> > static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> >       u32 val, map;
> >       u16 vsec;
> >       u64 off;
> > +     u16 vendor;
> >
> > -     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> > -                                     DW_PCIE_VSEC_DMA_ID);
> > +     vendor =3D pdev->vendor;
> > +     if (vendor !=3D PCI_VENDOR_ID_SYNOPSYS &&
> > +         vendor !=3D PCI_VENDOR_ID_XILINX)
> > +             return;
> > +
> > +     vsec =3D pci_find_vsec_capability(pdev, vendor,
> > + DW_PCIE_VSEC_DMA_ID);
>
> The vendor of a device assigns VSEC IDs and determines what each ID means=
, so
> the semantics of a VSEC Capability are determined by the tuple of (device=
 Vendor
> ID, VSEC ID), where the Vendor ID is the value at 0x00 in config space.
>

As AMD is a vendor for this device, it is determined as VSEC capability to =
support
some of the functionality not supported by the other vendor Synopsys.

> This code assumes that Synopsys and Xilinx agreed on the same VSEC ID
> (6) and semantics of that Capability.
>
> I assume you know this is true in this particular case, but it is not saf=
e for in general
> because even if other vendors incorporate this same IP into their devices=
, they may
> choose different VSEC IDs because they may have already assigned the VSEC=
 ID 6
> for something else.
>
> So you should add a comment to the effect that "Synopsys and Xilinx happe=
ned to
> use the same VSEC ID and semantics.  This may vary for other vendors."
>

Agree with the above suggestion. Will add this in next review.

> The DVSEC Capability is a more generic solution to this problem.  The VSE=
C ID
> namespace is determined by the Vendor ID of the *device*.
>
> By contrast, the DVSEC ID namespace is determined by a Vendor ID in the D=
VSEC
> Capability itself, not by the Vendor ID of the device.
>
> So AMD could define a DVSEC ID, e.g., 6, and define the semantics of that=
 DVSEC.
> Then devices from *any* vendor could include a DVSEC Capability with
> (PCI_VENDOR_ID_AMD, 6), and generic code could look for that DVSEC
> independent of what is at 0x00 in config space.
>

As AMD itself becomes the vendor for this device, VSEC capability is chosen=
 to support
the functionality missing in the code.

> >       if (!vsec)
> >               return;
> >
> > @@ -155,6 +201,27 @@ static void dw_edma_pcie_get_vsec_dma_data(struct
> pci_dev *pdev,
> >       off <<=3D 32;
> >       off |=3D val;
> >       pdata->rg.off =3D off;
> > +
> > +     /* AMD specific VSEC capability */
> > +     if (vendor !=3D PCI_VENDOR_ID_XILINX)
> > +             return;
> > +
> > +     vsec =3D pci_find_vsec_capability(pdev, vendor,
> > +                                     DW_PCIE_AMD_MDB_VSEC_ID);
>
> pci_find_vsec_capability() finds a Vendor-Specific Extended Capability de=
fined by
> the vendor of the device (Xilinx in this case).
>
> pci_find_vsec_capability() already checks that dev->vendor matches the ve=
ndor
> argument so you don't need the "vendor !=3D PCI_VENDOR_ID_XILINX"
> check above.
>
> DW_PCIE_AMD_MDB_VSEC_ID should include "XILINX" because this ID is in the
> namespace created by PCI_VENDOR_ID_XILINX, i.e., it's somewhere in the
> (PCI_VENDOR_ID_XILINX, x) space.
>
> This code should look something like this (you could add "MDB" or somethi=
ng if it
> makes sense):
>
>   #define PCI_VSEC_ID_XILINX_DMA_DATA               0x20
>

Thank you for the suggestion, will go with the DW_PCIE_XILINX_MDB_VSEC_ID
similar to the format already been used in the code.

>   vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>                                   PCI_VSEC_ID_XILINX_DMA_DATA);
>
> > +     if (!vsec)
> > +             return;
> > +
> > +     pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> > +     if (PCI_VNDR_HEADER_ID(val) !=3D 0x20 ||
> > +         PCI_VNDR_HEADER_REV(val) !=3D 0x1)
> > +             return;
> > +
> > +     pci_read_config_dword(pdev, vsec + 0xc, &val);
> > +     off =3D val;
> > +     pci_read_config_dword(pdev, vsec + 0x8, &val);
> > +     off <<=3D 32;
> > +     off |=3D val;
> > +     pdata->phys_addr =3D off;
> >  }
> >
> >  static int dw_edma_pcie_probe(struct pci_dev *pdev, @@ -179,6 +246,7
> > @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       }
> >
> >       memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
> > +     vsec_data->phys_addr =3D DW_PCIE_AMD_MDB_INVALID_ADDR;
> >
> >       /*
> >        * Tries to find if exists a PCIe Vendor-Specific Extended
> > Capability @@ -186,6 +254,15 @@ static int dw_edma_pcie_probe(struct pc=
i_dev
> *pdev,
> >        */
> >       dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
> >
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX) {
> > +             /*
> > +              * There is no valid address found for the LL memory
> > +              * space on the device side.
> > +              */
> > +             if (vsec_data->phys_addr =3D=3D DW_PCIE_AMD_MDB_INVALID_A=
DDR)
> > +                     return -EINVAL;
> > +     }
> > +
> >       /* Mapping PCI BAR regions */
> >       mask =3D BIT(vsec_data->rg.bar);
> >       for (i =3D 0; i < vsec_data->wr_ch_cnt; i++) { @@ -367,6 +444,8 @=
@
> > static void dw_edma_pcie_remove(struct pci_dev *pdev)
> >
> >  static const struct pci_device_id dw_edma_pcie_id_table[] =3D {
> >       { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> > +     { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
> > +       (kernel_ulong_t)&amd_mdb_data },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table); diff --git
> > a/include/linux/pci_ids.h b/include/linux/pci_ids.h index
> > 92ffc43..c15607d 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -636,6 +636,7 @@
> >  #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS              0x780b
> >  #define PCI_DEVICE_ID_AMD_HUDSON2_IDE                0x780c
> >  #define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
> > +#define PCI_DEVICE_ID_AMD_MDB_B054   0xb054
>
> Unless PCI_DEVICE_ID_AMD_MDB_B054 is used in more than one driver, move
> the #define into the file that uses it.  See the note at the top of pci_i=
ds.h.

Agreed. Will move this to the file where it is being used as no other drive=
r is using it now.

