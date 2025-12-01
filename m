Return-Path: <dmaengine+bounces-7414-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4ABC96881
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 11:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B55C344147
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EC13016E8;
	Mon,  1 Dec 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KNa+tGWC"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF902301018;
	Mon,  1 Dec 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583168; cv=fail; b=sOXyi8J8gCiq6v/1TnTvBxwT3NaLsGNXyL2F2rwvPIRmZpaQSQzAMCAV1lyxdiUnCpEruiQWLcaqFSCQb+PUf286pysg/Zeg9Q3ZN0/LXveeQtOZLW0BnAUEsI8ugcRmOxKzm7qYC8d5PUdYVNSHWxxD+PBdzhV5zUvwSkwGkKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583168; c=relaxed/simple;
	bh=9tyFHU+n6Gznmrb1oVyOHNZlxxRyuIP40CvPvjHI7Ms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JfQmvxkLtKAbp8dDcZxyLPey2vrdGkdLaieuvKq2eBwBGIhCcuyTe+4faCTeZ+DMJMffipXTIPKxpYjHnUsgJtfoIwVKNVSZQX/ApsjjvIn/9npiTU5AtMqXtBECCbd8SxAUjYDDsfWcxC1QquiHBy7w109B5dLZY3BWu8zf9Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KNa+tGWC; arc=fail smtp.client-ip=40.93.195.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skp42sJb3povm5PqIeqUlb/31DdVoxY3LbW9D86RJAfaj+4RCAj5EzssJ5dyvIeSjoQnJi3B5lJhsESEoZxk27AuONIzTG7bXEvztPlE2PTv56Ki0quihKg85I3Dv1jmQELDsaXaIq2XXpHYEZWkcv7/FE7rNi4HyJr2UxnwEq4kQOjZk72QmTJOxlCPRRLyBQFOHUEhpIrpbGckN+uzED4NncaZFYzMvVJvGxwQgSZemD6MTkdjapmx7YVg5EEvGG8Wq+qy9gz8MYW+CY4wbTRgJBb7UWbiphJ7YMznx4nGqRlxl4iLY76r2Y1oPnKhEzANVPPKp7kv7H78tFjKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebj0vl89kxAs8ar94I0TO8xB9M/kW4knJTFeZVOP9zI=;
 b=XpWzoe3h07gP8Qsb5vuvRrUdFxU4C/sna434QEOaVwn5oS9BsOC2J8aKhzNTYlNnet7VrsN2NOcTD5O0plrei/i8IQJ/ybb+VnAOaDTrdDDSwhL2nfdC1G8DZUaka/C8tcM7kz+0jaIi1Sw0jiMezgCkJpNjUN5n8Xzm+nVEmNZmUQtI24Rry7Ik3BxrDIzEN9ttNdYFMkLndZVFUrM2A77l+zy66EVHVy2es9Rx2uzo3EHh+N2oykbWq6HOJXCEUrHjRBWj9dRYnl8JFqq4gtokIQrtyZLOQdlI9fOzLuYD+B/jyD1CtMUIFK4VYeM+hdbUYv5NeN0OIn01O0R8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ebj0vl89kxAs8ar94I0TO8xB9M/kW4knJTFeZVOP9zI=;
 b=KNa+tGWCpb5V2+rnW3nWQcd0z3m54OwM1iKD8mmWIqZdwVjhA2LFhsvd0uyiLUwut0iABdGhyqUECtG7R5x+yjhAorT+myqrdZp0jdXUvrov5Tu8VJh+E+28q5VSFKqYpJPvA+0cdXebJEGfmn2XU5mAFe4aXOKiZe0acTR+YlE=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 09:58:06 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9366.009; Mon, 1 Dec 2025
 09:58:06 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>
Subject: RE: [PATCH RESEND v6 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
 Support
Thread-Topic: [PATCH RESEND v6 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
 Support
Thread-Index: AQHcWtriEx0Zhgd8hUGLg65M6Bj2QLUMm8Bg
Date: Mon, 1 Dec 2025 09:58:06 +0000
Message-ID:
 <SA1PR12MB8120E42BCD62469B275102BF95DBA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20251121113455.4029-1-devendra.verma@amd.com>
 <20251121113455.4029-2-devendra.verma@amd.com>
In-Reply-To: <20251121113455.4029-2-devendra.verma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-01T09:56:15.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|IA1PR12MB8223:EE_
x-ms-office365-filtering-correlation-id: 84f4fef5-46a2-4229-6c22-08de30c0204b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?maQzUatINtMXyEK6tALLq6YXdE3Cx4Jcy+bM3XZfCKCBUY6uzdzSQYFiea9T?=
 =?us-ascii?Q?3MbbOb8I3xE4nDj/bC1ejzMvSF6RpOWnte3xbr0l63eyMXpGTLhTbqC3lSop?=
 =?us-ascii?Q?4YNOkqXiw6DQa0kdfvo7L+PR32iK+7mrW+YKu0uGFlNi8Sz5nQXjvzh6jK5B?=
 =?us-ascii?Q?spPtf6pXIUIgVbFxo6LhqOXkvsmOonGkxNH/d7Ka32fnq6o/6xfnoRvdi+zG?=
 =?us-ascii?Q?VAtyXxw2n+8FRGpmwtBSxyleKPhIAfEw6dHh+hB8lt2NvDSYmaUozI2PdfET?=
 =?us-ascii?Q?KRU3ss1zBoYsrNf83hRDglLGVWR3qYpofv+dIUxguRZ5fcGveTc5aNQAXV/I?=
 =?us-ascii?Q?qMDwrQJAcA2KxKOiK8KKfRW+Jufk/LbeEodEkY/tKY2Y1jTZ2ujEvn3nlqwE?=
 =?us-ascii?Q?sDvitSd7tFaQxLGklCEVtpF8fqSZ7HvGa2LmdfMdPn5tRoQ5SWxZX/rQVz0j?=
 =?us-ascii?Q?5jqKj0uJnILX3o3q14dC4Ynbi0FefmtRY5np5up/FQgsSTsAPXq//Irla5wS?=
 =?us-ascii?Q?JFqtqzW3OIEyMMnzs+pyQa85ilUpQcoJ5HhY4tr8h9N6L2/RDg6THmVa3Kdl?=
 =?us-ascii?Q?jc7x+dsn0R13wSd9wcC+WZjWv58ttJ24d8obbGLqK/isyeOJGgJHkVbOrr1p?=
 =?us-ascii?Q?i2YgYGis0PRKFPadt/Own16HRwz+pQk5axjZAkqn1NGbYYW6ZbtPtmYumtdj?=
 =?us-ascii?Q?SUoqd6fOqSvD8CK3+ZoiTTzGDVUhpULOCkgWYrY9honLcM4e/7mUXHWjyVHL?=
 =?us-ascii?Q?9iwh5OZylPtaQLvri191e598KYwwxcoD8w8oeZAsDrfizWE/nwdYys2iMBg1?=
 =?us-ascii?Q?WQaDkOn5nx0x2nOaRieOpk0dn463l1qr1HeFcB1rf6E24EofXFTaJBs4Nizc?=
 =?us-ascii?Q?KemqkAPGe4gS4vM133vhmP6y1WjMkoDkh89jg/aLxyhMVWs5ued8is/FOlTl?=
 =?us-ascii?Q?vGhS0KIM7bkmysZdBdWwF3gku/lnhVRx7Aupu/Ltl20TERwHf8PMBqaUz9Km?=
 =?us-ascii?Q?MAT6RNzsdMbigFoLLa2wWbT/D90sDR/J50MTTum3LFalYTtRyIwQMjbuMy9W?=
 =?us-ascii?Q?EfWIkjPyB/K6yKIpOnKXlJJgTL//bJ+H5f9Qf1/0vkm56Magey/PjywLUBnk?=
 =?us-ascii?Q?+oO7wGIdIJK/oDT6gPKKM6R3tx4yfuZwmYS/8kH0DTSyM2io0qWEfbEzRkI4?=
 =?us-ascii?Q?NwFD0GkFJQrxTmWMAfoQGkHtoBv7CQZUUBUhX2xM1zMvshzRoUjYnJLyKGRd?=
 =?us-ascii?Q?rJkFVxiZOnKQkyPe4fjhiBa6747bkrKVrfmSgRKze0/aF1UtSg0ToFIbw0Rp?=
 =?us-ascii?Q?p/FPqPBHVKMoC7tsMB3BESY0h9ouSv6ddFTTf+xyaxD3owCkdytq8MKlKPSc?=
 =?us-ascii?Q?jlurUIwsWxVOqZ865lb8himRUX8gajkNplf3RSNAo+iBsas9RtR+bkb3myVs?=
 =?us-ascii?Q?npmFqA0BhmPgdryuPSIt8W6pgAPWTiGetCmYEyb6dLpi+FcY6kDv573UyHB5?=
 =?us-ascii?Q?mJJCS+AZBsVwWnoO39ia5hmC7hurGncPsdsM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/ac/bDy3jAy/Fyb+UVTyTNRtfAnaSOTDnYrEVmFtfFCwvFxZVu8Ws0hH0pRT?=
 =?us-ascii?Q?NCzyOvIoDOzY19IipXmyG6zBQPFvM2WjoY9Z2dvY/LdknmzQSaEtrYtx7JCh?=
 =?us-ascii?Q?q/eEC3LgGrBaO1A6Ayw0dFEsvjS5Rq60GfxfYt+gulVtIHjnUeSkFbwEl6ns?=
 =?us-ascii?Q?nPU4n0hIjF1J+u+4qbtED1/NnAlpgRKznZ+2iPRSw4hp7e1yiuRQBTX/Hj9F?=
 =?us-ascii?Q?gIj42d1nN2yrcfZOY93hMH5usBOvsZIdPeM9z5vRlEE5iontzP/wkSxI11/7?=
 =?us-ascii?Q?IX41wqL9BWCdmnzqCgyFz5E7ocaA6u0b3tEF0wrNcwDqB5AUBBVC9ym0qP7b?=
 =?us-ascii?Q?nIgI2vfFdRDgBSsABxYXm2iKyaEaU1VtgP7Z6zxmqyyb2uKki1/qChtRjkpK?=
 =?us-ascii?Q?Xqr4cIfE22jWuAnip8bGK4ZYiu4W/cpN+LEunaxrokSNC/FoDs+MCPZKVs0r?=
 =?us-ascii?Q?vzura4ApJuIaZe27F0OXN/ieRrmJNRjZ7NSqFBv7e02NkohoKFHFkkLOyltn?=
 =?us-ascii?Q?pnbSR9u89rmpTv5qvxREass03A2CY11z5GNRX7VI9o1MILzJ5o3/j2xz9P5i?=
 =?us-ascii?Q?C2Jdp1CsDW3Nr94fBpKvDBSr+YKQy9YgXhFSq9Xc8DiJKAkIXU3DzsgPupvx?=
 =?us-ascii?Q?GJV+WA3ZI98zIyF6i3sdUPKUssA+SFsuZ5sZfhBWHQZPmUv9gMVKpj2XFcm8?=
 =?us-ascii?Q?yJBKL+WcYkAcmkTZDTd/apgH5xQo+fCnVANQ40q4NKj11xaQGvbmDZifJ9w4?=
 =?us-ascii?Q?bdY4mu17UtbXA3oe2BCr+HLKBH5leBIBV6mGsxY5O36MUa1Ocz/1VMCg3dSb?=
 =?us-ascii?Q?nPGrt4B0IVK2825aw2PM+Kp086EbtzCj1rs3ASrfAqIdzP0GXvhZoNBcDENl?=
 =?us-ascii?Q?tnAO21lmJ0B7DSTXgjfxnZcp0B0Skc0iiuZxIWRvMYODMByG802Z4CkXRbMq?=
 =?us-ascii?Q?+LAJav3u2WzfH0uj4yV+HZGFplVE5/roXmO1gB66+gMYbmob8AFe6lsx0T3Y?=
 =?us-ascii?Q?bRzHaRTamHvD4a8MiNviFiYhPzl6wL6XVpiS7p87rM2RIM9Ip1tb27h7AtG9?=
 =?us-ascii?Q?AHN+CDyv1jmjdiM6UWQ2GxpmTaMTpoa+brtP5QwuVvkYy/n+L/OB7RzvaGMI?=
 =?us-ascii?Q?IyTktXs4VMtOnpC3Navw/kNZjbwQKxx6wOlElzgnio5XQ0z9EpIfOrcRuyfh?=
 =?us-ascii?Q?yZICsoayUmEr8Twk0XhLjSXOqPNQrc+p4E9GlHhOJfzLShKHFyLBuT+/8Chr?=
 =?us-ascii?Q?J012FHqRFBRoOHk3hjWvzlUR4uUuc6l0HUi/YbL6FNt+iXjZ6kC1kdD1jpSk?=
 =?us-ascii?Q?c6v9+noG4lfpPneSn1C8jjBrtiGqTbVBEY2eyXooY4nYJnu4EZY1Qz+uAF3H?=
 =?us-ascii?Q?UpHelHt2Wh4JahqhvNSlx8YJDn/kQED/a3K2S2cofG0CAZiEn+dHJcy4giGs?=
 =?us-ascii?Q?8j9DR9xjL0vcN5mVAVIKJnmY8j1BxLm32u30NjzBEY6qwSEcxptN4CrCpX0s?=
 =?us-ascii?Q?UQi6KOEUlDRX2Z7ZGWKffQQkbuX79Fwnw9Tyzc3eUHYmE46HPy1++wQ5e3gd?=
 =?us-ascii?Q?t6yrw/1tl56iCs1KJao=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f4fef5-46a2-4229-6c22-08de30c0204b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 09:58:06.6423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7AWprojfjAuqC8wUdqFTa6Q7q6qf31N89zMsSappZyrtESch7fMssD76akcRCWQjvn5mK/x/s6IUjz9P4XFUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223

[AMD Official Use Only - AMD Internal Distribution Only]

Hi All

Could you all please review the following patch?

Regards,
Dev

> -----Original Message-----
> From: Devendra K Verma <devendra.verma@amd.com>
> Sent: Friday, November 21, 2025 5:05 PM
> To: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org
> Cc: dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Verma,
> Devendra <Devendra.Verma@amd.com>
> Subject: [PATCH RESEND v6 1/2] dmaengine: dw-edma: Add AMD MDB
> Endpoint Support
>
> AMD MDB PCIe endpoint support. For AMD specific support added the
> following
>   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
>   - AMD MDB specific driver data
>   - AMD MDB specific VSEC capability to retrieve the device DDR
>     base address.
>
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
> Changes in v6:
> Included "sizes.h" header and used the appropriate definitions instead of
> constants.
>
> Changes in v5:
> Added the definitions for Xilinx specific VSEC header id, revision, and r=
egister
> offsets.
> Corrected the error type when no physical offset found for device side
> memory.
> Corrected the order of variables.
>
> Changes in v4:
> Configured 8 read and 8 write channels for Xilinx vendor Added checks to
> validate vendor ID for vendor specific vsec id.
> Added Xilinx specific vendor id for vsec specific to Xilinx Added the LL =
and
> data region offsets, size as input params to function
> dw_edma_set_chan_region_offset().
> Moved the LL and data region offsets assignment to function for Xilinx sp=
ecific
> case.
> Corrected comments.
>
> Changes in v3:
> Corrected a typo when assigning AMD (Xilinx) vsec id macro and condition
> check.
>
> Changes in v2:
> Reverted the devmem_phys_off type to u64.
> Renamed the function appropriately to suit the functionality for setting =
the LL
> & data region offsets.
>
> Changes in v1:
> Removed the pci device id from pci_ids.h file.
> Added the vendor id macro as per the suggested method.
> Changed the type of the newly added devmem_phys_off variable.
> Added to logic to assign offsets for LL and data region blocks in case mo=
re
> number of channels are enabled than given in amd_mdb_data struct.
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 139
> ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 137 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-
> edma/dw-edma-pcie.c
> index 3371e0a7..3d7247c 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -14,15 +14,31 @@
>  #include <linux/pci-epf.h>
>  #include <linux/msi.h>
>  #include <linux/bitfield.h>
> +#include <linux/sizes.h>
>
>  #include "dw-edma-core.h"
>
> +/* Synopsys */
>  #define DW_PCIE_VSEC_DMA_ID                  0x6
>  #define DW_PCIE_VSEC_DMA_BAR                 GENMASK(10, 8)
>  #define DW_PCIE_VSEC_DMA_MAP                 GENMASK(2, 0)
>  #define DW_PCIE_VSEC_DMA_WR_CH                       GENMASK(9, 0)
>  #define DW_PCIE_VSEC_DMA_RD_CH                       GENMASK(25, 16)
>
> +/* AMD MDB (Xilinx) specific defines */
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID               0x6
> +#define DW_PCIE_XILINX_MDB_VSEC_ID           0x20
> +#define PCI_DEVICE_ID_AMD_MDB_B054           0xb054
> +#define DW_PCIE_AMD_MDB_INVALID_ADDR         (~0ULL)
> +#define DW_PCIE_XILINX_LL_OFF_GAP            0x200000
> +#define DW_PCIE_XILINX_LL_SIZE                       0x800
> +#define DW_PCIE_XILINX_DT_OFF_GAP            0x100000
> +#define DW_PCIE_XILINX_DT_SIZE                       0x800
> +#define DW_PCIE_XILINX_MDB_VSEC_HDR_ID               0x20
> +#define DW_PCIE_XILINX_MDB_VSEC_REV          0x1
> +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH       0xc
> +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW        0x8
> +
>  #define DW_BLOCK(a, b, c) \
>       { \
>               .bar =3D a, \
> @@ -50,6 +66,7 @@ struct dw_edma_pcie_data {
>       u8                              irqs;
>       u16                             wr_ch_cnt;
>       u16                             rd_ch_cnt;
> +     u64                             devmem_phys_off;
>  };
>
>  static const struct dw_edma_pcie_data snps_edda_data =3D { @@ -90,6
> +107,64 @@ struct dw_edma_pcie_data {
>       .rd_ch_cnt                      =3D 2,
>  };
>
> +static const struct dw_edma_pcie_data amd_mdb_data =3D {
> +     /* MDB registers location */
> +     .rg.bar                         =3D BAR_0,
> +     .rg.off                         =3D SZ_4K,        /*  4 Kbytes */
> +     .rg.sz                          =3D SZ_8K,        /*  8 Kbytes */
> +
> +     /* Other */
> +     .mf                             =3D EDMA_MF_HDMA_NATIVE,
> +     .irqs                           =3D 1,
> +     .wr_ch_cnt                      =3D 8,
> +     .rd_ch_cnt                      =3D 8,
> +};
> +
> +static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data
> *pdata,
> +                                        enum pci_barno bar, off_t start_=
off,
> +                                        off_t ll_off_gap, size_t ll_size=
,
> +                                        off_t dt_off_gap, size_t dt_size=
) {
> +     u16 wr_ch =3D pdata->wr_ch_cnt;
> +     u16 rd_ch =3D pdata->rd_ch_cnt;
> +     off_t off;
> +     u16 i;
> +
> +     off =3D start_off;
> +
> +     /* Write channel LL region */
> +     for (i =3D 0; i < wr_ch; i++) {
> +             pdata->ll_wr[i].bar =3D bar;
> +             pdata->ll_wr[i].off =3D off;
> +             pdata->ll_wr[i].sz =3D ll_size;
> +             off +=3D ll_off_gap;
> +     }
> +
> +     /* Read channel LL region */
> +     for (i =3D 0; i < rd_ch; i++) {
> +             pdata->ll_rd[i].bar =3D bar;
> +             pdata->ll_rd[i].off =3D off;
> +             pdata->ll_rd[i].sz =3D ll_size;
> +             off +=3D ll_off_gap;
> +     }
> +
> +     /* Write channel data region */
> +     for (i =3D 0; i < wr_ch; i++) {
> +             pdata->dt_wr[i].bar =3D bar;
> +             pdata->dt_wr[i].off =3D off;
> +             pdata->dt_wr[i].sz =3D dt_size;
> +             off +=3D dt_off_gap;
> +     }
> +
> +     /* Read channel data region */
> +     for (i =3D 0; i < rd_ch; i++) {
> +             pdata->dt_rd[i].bar =3D bar;
> +             pdata->dt_rd[i].off =3D off;
> +             pdata->dt_rd[i].sz =3D dt_size;
> +             off +=3D dt_off_gap;
> +     }
> +}
> +
>  static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr) =
 {
>       return pci_irq_vector(to_pci_dev(dev), nr); @@ -120,9 +195,24 @@
> static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>       u32 val, map;
>       u16 vsec;
>       u64 off;
> +     int cap;
> +
> +     /*
> +      * Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose
> +      * of map, channel counts, etc.
> +      */
> +     switch (pdev->vendor) {
> +     case PCI_VENDOR_ID_SYNOPSYS:
> +             cap =3D DW_PCIE_VSEC_DMA_ID;
> +             break;
> +     case PCI_VENDOR_ID_XILINX:
> +             cap =3D DW_PCIE_XILINX_MDB_VSEC_DMA_ID;
> +             break;
> +     default:
> +             return;
> +     }
>
> -     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> -                                     DW_PCIE_VSEC_DMA_ID);
> +     vsec =3D pci_find_vsec_capability(pdev, pdev->vendor, cap);
>       if (!vsec)
>               return;
>
> @@ -155,6 +245,28 @@ static void
> dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>       off <<=3D 32;
>       off |=3D val;
>       pdata->rg.off =3D off;
> +
> +     /* Xilinx specific VSEC capability */
> +     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> +                                     DW_PCIE_XILINX_MDB_VSEC_ID);
> +     if (!vsec)
> +             return;
> +
> +     pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> +     if (PCI_VNDR_HEADER_ID(val) !=3D
> DW_PCIE_XILINX_MDB_VSEC_HDR_ID ||
> +         PCI_VNDR_HEADER_REV(val) !=3D DW_PCIE_XILINX_MDB_VSEC_REV)
> +             return;
> +
> +     pci_read_config_dword(pdev,
> +                           vsec +
> DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> +                           &val);
> +     off =3D val;
> +     pci_read_config_dword(pdev,
> +                           vsec +
> DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> +                           &val);
> +     off <<=3D 32;
> +     off |=3D val;
> +     pdata->devmem_phys_off =3D off;
>  }
>
>  static int dw_edma_pcie_probe(struct pci_dev *pdev, @@ -179,6 +291,7 @@
> static int dw_edma_pcie_probe(struct pci_dev *pdev,
>       }
>
>       memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
> +     vsec_data->devmem_phys_off =3D
> DW_PCIE_AMD_MDB_INVALID_ADDR;
>
>       /*
>        * Tries to find if exists a PCIe Vendor-Specific Extended Capabili=
ty
> @@ -186,6 +299,26 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
>        */
>       dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
>
> +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX) {
> +             /*
> +              * There is no valid address found for the LL memory
> +              * space on the device side.
> +              */
> +             if (vsec_data->devmem_phys_off =3D=3D
> DW_PCIE_AMD_MDB_INVALID_ADDR)
> +                     return -ENOMEM;
> +
> +             /*
> +              * Configure the channel LL and data blocks if number of
> +              * channels enabled in VSEC capability are more than the
> +              * channels configured in amd_mdb_data.
> +              */
> +             dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> +                                            DW_PCIE_XILINX_LL_OFF_GAP,
> +                                            DW_PCIE_XILINX_LL_SIZE,
> +                                            DW_PCIE_XILINX_DT_OFF_GAP,
> +                                            DW_PCIE_XILINX_DT_SIZE);
> +     }
> +
>       /* Mapping PCI BAR regions */
>       mask =3D BIT(vsec_data->rg.bar);
>       for (i =3D 0; i < vsec_data->wr_ch_cnt; i++) { @@ -367,6 +500,8 @@
> static void dw_edma_pcie_remove(struct pci_dev *pdev)
>
>  static const struct pci_device_id dw_edma_pcie_id_table[] =3D {
>       { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> +     { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
> +       (kernel_ulong_t)&amd_mdb_data },
>       { }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> --
> 1.8.3.1


