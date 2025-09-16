Return-Path: <dmaengine+bounces-6527-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E23B593D3
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 12:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AF6162BD5
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D035627F171;
	Tue, 16 Sep 2025 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZGhDJ2ed"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F52BE7B8;
	Tue, 16 Sep 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018847; cv=fail; b=UDdBxQkcRIVD3KsgbfEKoidxbK04v5yDU6yeq6rtLGo8NPuxyr3nryVMkHC9gzqwk+DMpP+F0P7BHT9ZRgotriqnLgS5WS+CS7YlgZf2sNo0UZXU+uy6pVa9y1wDHNoQYkgnWYK1RWVLlkDIumn/cWsHE10ZDfAYuWS83oUFIvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018847; c=relaxed/simple;
	bh=xvbelSUhjsp9qcD5kir7uKhOFLIJFLtjQOQWXlZfs0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mtN+CpvFKJu5nUBsajzsIs8kRIJbiNm3Jeq6fUxoaOYF6uiakSHddDcbOpSC+9pmNQ5UonohMW/hNny63ewymvTmkNcrx0pTM9qoCE/xJZkndFyn2O/3kZ0soei3oIP8n2twsJnCqvrrJsZS8il7ZnrVzzhjAcLTnK5lp4x0zew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZGhDJ2ed; arc=fail smtp.client-ip=52.101.56.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btZkIUZJSPzzhAZXJQ2fXnS6Z0KaYmUEhgD0HtI5rYsF9VsyZN1xIRvsMJLCFu4KELs+3YTjfnH48UuvsGI8SLF4LPGblagbSrW0kpvAv0tFJFmApaJqRVFBJxXmfk75J6+7a8g7UgKRQZ3wfPFF2ZtR0qHRl4iogzJWUmBIM7kWCsmpIXepqbbCGjJT0hI6vIlM8NRknrT/lQpqzJsbYbKZU0VqYqTum86YBZ5PADZ/3ZOAcN3amX9LsWWtyZbEEirQ7GParasdAUslUPS7tdu6qwbQI5CiKFtp1s+F/HNw4CUGSgTFAM70hMpNmuPf5Qa6xS3vF16pqJbIL2Fuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3mJzNA6trUZ2V21jdV5EIpJ2Nyu+fdmwFCdUyCQ05g=;
 b=jm6Q4E1BPxDDJU/Rl6fQ22JdkU31d1wLWCqQpvO8ctjerubFR+W9Hx9u46i8Wis8Z7kqiEzXt6s/e+DNrVZIQbZx8Z7yi62l6jhQhvh8fOzr7MZM5ETwQc2gkYdfmO0/5mVtGQLyaKtV+psHcsmHJDDL6jypj+FRnEfbxNAk5bW5ZpreekAG0bwtWkTLxW4zIMnWeuFevoX8VwYscWpvzl4zdMoEqsjsneNIH/USpQzYIOVDtuFN1pk6/jweae2R0FvEnsh7+vEKLY0zF952K4nMhWSimS0JT8afPZf7uvWbAeVamLRhSTGtKUHggZNE+4UKPxNXiCJrMlol+YfaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3mJzNA6trUZ2V21jdV5EIpJ2Nyu+fdmwFCdUyCQ05g=;
 b=ZGhDJ2ed6bsb6yKtODfvV4DtAQ+C32Fc4IQQbFsN+xFVKxqAcrz7AITKeG6nb5xJXikrgL0/P4/u+nJwcL286/tzpwQj2vgTfOJmrio/eJ6u9O/a1LXI3mgFelHUUns+CL+mGSE+/DTyhdzaPvujQFhCmHtvkpGX+ajPtGbnmFY=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 10:34:01 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 10:34:01 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>
Subject: RE: [PATCH v1 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Topic: [PATCH v1 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Index: AQHcI2Ykjgirmz1V6kWMTP7KI6CPM7SVofEQ
Date: Tue, 16 Sep 2025 10:34:00 +0000
Message-ID:
 <SA1PR12MB8120341DFFD56D90EAD70EDE9514A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20250911114451.15947-2-devendra.verma@amd.com>
 <20250911215048.GA1591374@bhelgaas>
In-Reply-To: <20250911215048.GA1591374@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-16T10:26:32.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|IA1PR12MB6044:EE_
x-ms-office365-filtering-correlation-id: 5375d065-52a1-4eff-e1c7-08ddf50c8cf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Q6NMB8tOVqBZa87FtjhckXTL/5YpOHZqqmUzC1o5oxmAhtACvi2dggCLanFa?=
 =?us-ascii?Q?l4G8S+s8vEzg34veCybi/0cHncyECou3t7h2WquXcKqct3ri5iNIpPHR7Tu+?=
 =?us-ascii?Q?8Se0t57cGIo3uosGJ7nZGEbjf2C4snfKGqYndkW0rH4bIhOA421QQA31wxQj?=
 =?us-ascii?Q?5EcnV8dGcgkzh2C3tqkIRtxC9+h9BmBwdHTsWvAABUiAlJKQSGq22mL7ZfZc?=
 =?us-ascii?Q?kDcGQhK7WKGOKYMRxTLMX7rOgs3Z9BbM/ExR1Z1YwQzViBxrGeIjltVJgU/J?=
 =?us-ascii?Q?hXQ6iLpDODG9uquXdQSd1d+B6dGDv/zY9J/IknREWv1k+pltiBysEI4pb/+m?=
 =?us-ascii?Q?mFN4751h4sy7FFQahKBqZi8oa4kpoEHZccYZ68mwnbiI3z6C53iwXUwY7/87?=
 =?us-ascii?Q?vuOuJjXHUHMuhhwEaf7ciyA73pi6k2J2m1YfDKEo1keTyrthOYcIhbK+t+ux?=
 =?us-ascii?Q?Vi2/lJ5d22J0CjxnWfjDt1/ysAQgCL/NkEhXqV6vZ6dmMkLiiaYPdJztWuLk?=
 =?us-ascii?Q?gQnLLTPmBPt/tN9VHRRdDlFJXfmcN+Izr7iu8/DaVQppEU5isEEuUqTqD/kY?=
 =?us-ascii?Q?byYW38U0yhrrtTkf27JQwrgJnDTSQ90Bufuu0n9XmSpR34ES1TgVJsZry86r?=
 =?us-ascii?Q?CaUBNoPexg2DNVh+K3UgJ4eeCYwrzZL27oDsIMiNj8w0euPEsT75eJrYWXBl?=
 =?us-ascii?Q?EANPNjo1XluxmrGvg12xGB6dff3A/rYSnt2+1EKw1zuNDhr9pwxnbm6h0HYw?=
 =?us-ascii?Q?2qIDGOd8C9XA97BK/JclMGNApjN6ymEmts2uWzfnCeVQAE4WP+AtjQYg5tDJ?=
 =?us-ascii?Q?EBo0c0IQufucPYs0qNlTESETIE9nN6aLv9TTuUpp5RyfAxzcUrpi4t0hz2a2?=
 =?us-ascii?Q?1QTK8g4jzcaArvIW8OV/nYO4ksQPqIwJIWHT/p9KVGC/2Mlgrnnpq4duhQRE?=
 =?us-ascii?Q?CjII8Tbv8Hv7aXmhl18Qd+ObeuxSeoOJ3cmTGDcdjCzEMoCB5S3N/CDi0BL2?=
 =?us-ascii?Q?4bbnaCznPUk629wieKuw9HbVPSXHsSpnPW9lD9TWQ8rfku56dS3ZVltwaOPP?=
 =?us-ascii?Q?W2A4ibkvxkWky26JNaPWtmF3PwH5HrvMM0pSDs5hqvZKwn3EBV2vdZM3RqQy?=
 =?us-ascii?Q?ikUVwPxSiEn6PWj+kGrZhRUkaMaSjSZzMhTqnHDKDJ9oOKlM40gZSfJG5iUk?=
 =?us-ascii?Q?Wsf6ff3SkYC86gIfqWLphwpXk9jHXUOsn19j4n8JmntSp33+/IWgDmAC3570?=
 =?us-ascii?Q?Quq46t/X23J/ch2xpBkLGrH90seujZAHVNoyV4L45tairNlSBsLQYi1ojgFr?=
 =?us-ascii?Q?DGyFsfWFOPq2t5hgXAxDbA4+zFJHB+rsdZ9/E9qTmj93TR4L+C0NGWyoXVBX?=
 =?us-ascii?Q?dVYQAmfuFPE0GKr7QeKjRGyM7LSOEzv0v1Zp9Ndc3k/V4PGoZAdWmoLsq7Qm?=
 =?us-ascii?Q?MkSgjHesUt1zntybSURUbPLvimQoJrZ4uSWq+iBfG+U842TCXy/LNg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rb6iZ4GzFiHg2ZLcHhiOmTbLw9wsP4ZBU2hYa32wBQv50vrmeOAz5usYFKWW?=
 =?us-ascii?Q?DMtBzuQu2pdyEiokdhTB1W6LbWvh8Jp01j8C2T3Mp7b6idib0vsIleaxNEc/?=
 =?us-ascii?Q?7+CE8ZPdiaNRSvp9DSR6vBQHbTexw34c8V7m8qVw41HKvwP5ltf08bPgGQle?=
 =?us-ascii?Q?lD46aSJi9NCs+sJZil7x7iRI+mkE+Vd9H1PoLLjGqVylQR9Qw6X+9JA6zZUL?=
 =?us-ascii?Q?9g0DFsznG3BDvNrgyQBrQ260RS32dfuqrLITAq0NuLrsMAcrwofjkE+G3nau?=
 =?us-ascii?Q?TU91z1qIx39mFU/IuDG3Q8SLBivzWVx5aPiJcOP4qx+3reLH3mhPsASA5ytR?=
 =?us-ascii?Q?jF1CbSPs6ns7PRkMzZM6Fo1e2JUWKw9kdwIL9EfioiTe4stsBqiuFE9aEUB1?=
 =?us-ascii?Q?R14xVR3E1pYp6nrhXE54M5AIqU2P4XxegZxf2bvl0pOAUAOvCMviX21/6CfT?=
 =?us-ascii?Q?yzGcr6PNDhlD93V2o3pcne+DtQet2B7lVNa1m52lkwtvP0SLrp6hxsUpLq80?=
 =?us-ascii?Q?I0jPU5a/Y/K+kxpWc54r2YBC1sG44aPqvt2TS6cyW/OLkLAilxrA4F247C+f?=
 =?us-ascii?Q?G5Kgzha9iukGNdb7NJgQHxdFXyFUfpPtEcItrf7cY/nOYffGxOr7sMK7U42U?=
 =?us-ascii?Q?YdC4Ro1pef4uA07VB9xvzvMSt1arTlGssUElPxKYWElT7F1itTq7q1zTeKPv?=
 =?us-ascii?Q?4XRvKwHrASTqz0+5hS/RuX9SGBmdzuEpp+KXJf+ECYYYVPPe2EvGFBr9Z+ZL?=
 =?us-ascii?Q?k8A9FcH65BdoGXLy3dFXhjzjn/L4lClZeXNhyf6XGN1GkDonWpeE9DPAlDI0?=
 =?us-ascii?Q?/aGMDxYxQQmj7av80UtU5rV5j4yP/QASjecfpapV3g2bo8XQK0Gfo7YuXxIR?=
 =?us-ascii?Q?ehaKQwpD2WTsD/0/eIeFCsI+Vr9fQK3Fmdj46hE+UJRd2wL7dWqeD+znBR2E?=
 =?us-ascii?Q?8t6QyDuREAwTh40VY2IjHTXCGVDeA6/4ZyaZVJWtMWUSI9kyUmyEFYn3AA78?=
 =?us-ascii?Q?+94foIqlkjxzmPmkrEFAkugXBR0hGHqBfEqT/k7w2yAGy8qA3tmk+6zGzHJN?=
 =?us-ascii?Q?1ROs95+9IZYOqEdn/+X8M+Z3nbQTmKBJi/HHAgTkxg+4o0obeTP+rzA7E012?=
 =?us-ascii?Q?PG6UITulj9EzS+FfVz+62B6n5Xv0YpA9dtW2KUVH/ounDXvijSxhixPWiiAH?=
 =?us-ascii?Q?uK+tLgapRbHK1kwBk0RrJCtcZNK4Cv2VrllKgB96PHZuY1I0YA34x8BxwYgP?=
 =?us-ascii?Q?KiqXjFyRBlQ8PKIb942v3P5fokSTysaie5h7v9KxFLFJNKEW2oO4OSPh23r5?=
 =?us-ascii?Q?d8mf7XjtlHLr+FpWtN2nXCtVbOQ56wz6MbeAQte6AlO4bCaUu64c4+ZO58MI?=
 =?us-ascii?Q?wuFJivxDKkzBVgyAQhAZsKdURZAkhfAH1uye9qByrFhY0jsmtGw206zUYm5q?=
 =?us-ascii?Q?GFJ9d9f69R/QxjpilPR2F2GT8LpN9fGJB0Heabh9iMBTUiiTwILhuAG5Wc7P?=
 =?us-ascii?Q?EOhPmvkSiKP4xkB8yhrs9gHJHHU9gkDHImlhyYDFTf+0sCmw/+KZitBtxD0Y?=
 =?us-ascii?Q?DeD2S38KqN9AOlBDTmY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5375d065-52a1-4eff-e1c7-08ddf50c8cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 10:34:00.9089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 97kzgiQ3tHTtEKD8OOfzOEKDnZMryp5Ib0gr59UM17eIB2CSfM84XMXZZ2ozTeicziCDx1oqr40LNDvSEeMNTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn

Thank you for the review, please check my comments inline.

Regards,
Devendra

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, September 12, 2025 03:21
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v1 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
> Support
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Thu, Sep 11, 2025 at 05:14:50PM +0530, Devendra K Verma wrote:
> > AMD MDB PCIe endpoint support. For AMD specific support added the
> > following
> >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> >   - AMD MDB specific driver data
> >   - AMD MDB specific VSEC capability to retrieve the device DDR
> >     base address.
> >
> > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > ---
> > Changes in v1:
> > Removed the pci device id from pci_ids.h file.
> > Added the vendor id macro as per the suggested method.
> > Changed the type of the newly added devmem_phys_off variable.
> > Added to logic to assign offsets for LL and data region blocks in case
> > more number of channels are enabled than given in amd_mdb_data struct.
> > ---
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 132
> > ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 131 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 3371e0a7..48ecfce 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -23,6 +23,11 @@
> >  #define DW_PCIE_VSEC_DMA_WR_CH                       GENMASK(9, 0)
> >  #define DW_PCIE_VSEC_DMA_RD_CH                       GENMASK(25, 16)
> >
> > +/* AMD MDB specific defines */
> > +#define DW_PCIE_XILINX_MDB_VSEC_ID           0x20
> > +#define PCI_DEVICE_ID_AMD_MDB_B054           0xb054
> > +#define DW_PCIE_AMD_MDB_INVALID_ADDR         (~0ULL)
> > +
> >  #define DW_BLOCK(a, b, c) \
> >       { \
> >               .bar =3D a, \
> > @@ -50,6 +55,7 @@ struct dw_edma_pcie_data {
> >       u8                              irqs;
> >       u16                             wr_ch_cnt;
> >       u16                             rd_ch_cnt;
> > +     pci_bus_addr_t                  devmem_phys_off;
>
> Based on your previous response, I don't think pci_bus_addr_t is the righ=
t type.  IIUC
> devmem_phys_off is not an address that a PCIe analyzer would ever see in =
a TLP.
> It sounds like it's the result of applying an iATU translation to a PCI b=
us address.
>
> I'm not sure there's a special type for that, so u64 might be as good as =
anything.
>

Sure, will use u64.

> >  };
> >
> >  static const struct dw_edma_pcie_data snps_edda_data =3D { @@ -90,6
> > +96,89 @@ struct dw_edma_pcie_data {
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
> > +static void dw_edma_assign_chan_data(struct dw_edma_pcie_data *pdata,
> > +                                  enum pci_barno bar) {
> > +     u16 i;
> > +     off_t off =3D 0, offsz =3D 0x200000;
> > +     size_t size =3D 0x800;
> > +     u16 wr_ch =3D pdata->wr_ch_cnt;
> > +     u16 rd_ch =3D pdata->rd_ch_cnt;
> > +
> > +     if (wr_ch <=3D 2 || rd_ch <=3D 2)
> > +             return;
> > +
> > +     /* Write channel LL region */
> > +     for (i =3D 0; i < wr_ch; i++) {
> > +             pdata->ll_wr[i].bar =3D bar;
> > +             pdata->ll_wr[i].off =3D off;
> > +             pdata->ll_wr[i].sz =3D size;
> > +             off +=3D offsz + size;
> > +     }
> > +
> > +     /* Read channel LL region */
> > +     for (i =3D 0; i < rd_ch; i++) {
> > +             pdata->ll_rd[i].bar =3D bar;
> > +             pdata->ll_rd[i].off =3D off;
> > +             pdata->ll_rd[i].sz =3D size;
> > +             off +=3D offsz + size;
> > +     }
> > +
> > +     /* Write channel data region */
> > +     for (i =3D 0; i < wr_ch; i++) {
> > +             pdata->dt_wr[i].bar =3D bar;
> > +             pdata->dt_wr[i].off =3D off;
> > +             pdata->dt_wr[i].sz =3D size;
> > +             off +=3D offsz + size;
> > +     }
> > +
> > +     /* Read channel data region */
> > +     for (i =3D 0; i < rd_ch; i++) {
> > +             pdata->dt_rd[i].bar =3D bar;
> > +             pdata->dt_rd[i].off =3D off;
> > +             pdata->dt_rd[i].sz =3D size;
> > +             off +=3D offsz + size;
> > +     }
> > +}
> > +
> >  static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int
> > nr)  {
> >       return pci_irq_vector(to_pci_dev(dev), nr); @@ -121,7 +210,11 @@
> > static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> >       u16 vsec;
> >       u64 off;
> >
> > -     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> > +     /*
> > +      * Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose
> > +      * of map, channel counts, etc.
> > +      */
> > +     vsec =3D pci_find_vsec_capability(pdev, pdev->vendor,
> >                                       DW_PCIE_VSEC_DMA_ID);
>
> You must validate pdev->vendor first.  Passing pdev->vendor means this wi=
ll find
> any VSEC with ID 0x6 on any device at all.  For example, you could find a=
 VSEC
> with ID 0x6 on an Intel device where VSEC ID 0x6 means something complete=
ly
> different.
>
> You have to know what the Vendor ID is before calling
> pci_find_vsec_capability() because otherwise you don't know what the VSEC=
 ID
> means.
>
> The best way to do this would be to use a separate #define for each vendo=
r to
> remove the assumption that each vendor uses the same ID:
>
>   #define DW_PCIE_SYNOPSYS_VSEC_DMA_ID 0x6
>   #define DW_PCIE_XILINX_VSEC_DMA_ID   0x6
>
>   vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
>                                   DW_PCIE_SYNOPSYS_VSEC_DMA_ID);
>   if (!vsec) {
>     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>                                     DW_PCIE_XILINX_VSEC_DMA_ID);
>     if (!vsec)
>       return;
>   }
>
> That way it's clear that this only applies to Synopsys devices and Xilinx=
 devices,
> Synopsys and Xilinx implemented a VSEC with the same semantics, and it's =
just a
> coincidence that they assigned the same VSEC ID.
>

Thank you for the suggestions. I will do the following modifications
- Add vendor check for VSECID =3D 0x6
- Separating the VSEC IDs for AMD (Xilinx) devices.
- Keeping the Code related to Synopsys unchanged for the backward compatibi=
lity.

This way if someone is using the Synopsys vendor then they do not need to d=
o any
changes, if any were required due to the above modifications.

> >       if (!vsec)
> >               return;
> > @@ -155,6 +248,24 @@ static void dw_edma_pcie_get_vsec_dma_data(struct
> pci_dev *pdev,
> >       off <<=3D 32;
> >       off |=3D val;
> >       pdata->rg.off =3D off;
> > +
> > +     /* AMD specific VSEC capability */
> > +     vsec =3D pci_find_vsec_capability(pdev, pdev->vendor,
> > +                                     DW_PCIE_XILINX_MDB_VSEC_ID);
>
> Same here.  This will find a VSEC with ID 0x20 on any device from any ven=
dor at all.
> But you only know what 0x20 means on Xilinx devices, so this should be:
>
>   vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>                                   DW_PCIE_XILINX_MDB_VSEC_ID);
>

Suggestion taken. Thank you!

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
> > +     pdata->devmem_phys_off =3D off;
> >  }
> >
> >  static int dw_edma_pcie_probe(struct pci_dev *pdev, @@ -179,6 +290,7
> > @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       }
> >
> >       memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
> > +     vsec_data->devmem_phys_off =3D DW_PCIE_AMD_MDB_INVALID_ADDR;
> >
> >       /*
> >        * Tries to find if exists a PCIe Vendor-Specific Extended
> > Capability @@ -186,6 +298,22 @@ static int dw_edma_pcie_probe(struct pc=
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
> > +             if (vsec_data->devmem_phys_off =3D=3D
> DW_PCIE_AMD_MDB_INVALID_ADDR)
> > +                     return -EINVAL;
> > +
> > +             /*
> > +              * Configure the channel LL and data blocks if number of
> > +              * channels enabled in VSEC capability are more than the
> > +              * channels configured in amd_mdb_data.
> > +              */
> > +             dw_edma_assign_chan_data(vsec_data, BAR_2);
> > +     }
> > +
> >       /* Mapping PCI BAR regions */
> >       mask =3D BIT(vsec_data->rg.bar);
> >       for (i =3D 0; i < vsec_data->wr_ch_cnt; i++) { @@ -367,6 +495,8 @=
@
> > static void dw_edma_pcie_remove(struct pci_dev *pdev)
> >
> >  static const struct pci_device_id dw_edma_pcie_id_table[] =3D {
> >       { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> > +     { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
> > +       (kernel_ulong_t)&amd_mdb_data },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> > --
> > 1.8.3.1
> >

