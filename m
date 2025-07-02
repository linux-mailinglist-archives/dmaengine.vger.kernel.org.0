Return-Path: <dmaengine+bounces-5711-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A70EAF1029
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 11:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BE877A9802
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93D24EF8C;
	Wed,  2 Jul 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pmOA0xyq"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF38248883;
	Wed,  2 Jul 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449132; cv=fail; b=BLHgxI84tR4KoHzogmKFwLJUQmv8ypgZo/lrvN2pKmmRJC9Oshzq+ClFH1GSU2Fs7lvcygZh5Uzra/FYkShkWF94Velfm1/Uzp7LOHomMiIj7bNvtQRcctYDpWumull4IHVev96BJSaQZTb7va04KtLcjSQIFNj7oi22sDIyfto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449132; c=relaxed/simple;
	bh=1xPzSY6gzDqXOnsaI29A/TRIZwhLeIX8/3mZACwb4as=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rXfpi3ZJGxoA01/Casz4r7fnyc1G/KwyBoDEaLyJdyxETSTfFyB2juHH4w1hNBpOh9eUHJOcslbb8Q0IMUq3yXGTwDcJ+Bsr3F4rM8iMflC4z8EOoY+NerX+x+GhCK9TNib50t3iNVLtedgQjJhP+j7JAa/pgQBYhol55MsJxI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pmOA0xyq; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSNpLvg6AW9db4BxEYiBamM242+r+JnNL8BhMvqrXT4rzKi2rQcXTji2nCKjP7T1ojoaU+r3gdRBAxdZWuBZLJ9TpSpnuvz12bhbekSOgXuaw5gzHiRf8Pq04PhOrMAirVjA1dhmQGRsqNCb79bedbEBjEuaEWA0dZw8WygcsAwIEurefTBgN7XmiGoM2rLxm6zvxDMNztrjU1yNaZo2vawse5xZL02aai7kvRdi7RkKIHK74XpsgKovvA6UxenNhs5YkkFDj2lC+Okhy+9l1rtJsmVeX/t6B9g4K/l4oN50qwgjn8VlfborJm2i10BRLE8kXwnyF3gBsrm1A9P8dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYJX267Hegu92Pk1e/ognHa6ZFMAVn1h8YDxyU54wYc=;
 b=NFnGvSN/jGkLgATp+JYnSQGiLoq9AkXEJNG9AH7J7D7dNF3MKDqyeKximv2wLhRFkR0WGpg8cyR8OiJHZIdz8rey5cuC4zezU0LBUcL9pEQmYYA+GPsyAGkQY1HftgMUpLwR4bwnZ+C8kbYYrk4W6bvHZ7hKnp4KdUH0mT+iADGBHwij2eBqtyQeOxNNqHNaI1f3S6diM3zloK+yTXfTirjSbPlaA1J6ZwEIroQ06wWbov58sAN9NGeU7PQsDTfWlkEC1HKUXHTtIGjq2O96vVVGbrHoykInLtcrvR2HTo7W7FqTXcAsuZikF2LvyAbQCpZlCTyT7dN2hcWmXnQmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYJX267Hegu92Pk1e/ognHa6ZFMAVn1h8YDxyU54wYc=;
 b=pmOA0xyqgIX1geTQ4C3nUrXwIItcNx1Fz3Gz+CxMJFGJ/u8iRAkWBKrQ0iU/agu2rwBNzigMFRyIoAzjpcLx0z/rbaELsqcF8K73mbXMb+pLjX25V8cj+oE4PD1C2lF80ORzbTnia7JrrPLpg8zpkEH/ssbFxnCtBsk59qF6+pE=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Wed, 2 Jul
 2025 09:38:49 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 09:38:48 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Vinod Koul <vkoul@kernel.org>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mani@kernel.org" <mani@kernel.org>
Subject: RE: [RESEND PATCH] dmaengine: dw-edma: Add Simple Mode Support
Thread-Topic: [RESEND PATCH] dmaengine: dw-edma: Add Simple Mode Support
Thread-Index: AQHb5AaGsGs5kTrW3UWG39W5gh/nlLQWBTmAgAiaQpA=
Date: Wed, 2 Jul 2025 09:38:48 +0000
Message-ID:
 <SA1PR12MB81208BAD2A5D264482333FF79540A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20250623061733.1864392-1-devverma@amd.com>
 <aF3Eg_xtxZjZTEop@vaman>
In-Reply-To: <aF3Eg_xtxZjZTEop@vaman>
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
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|DM4PR12MB5748:EE_
x-ms-office365-filtering-correlation-id: 59cd0dc0-8e2b-41c8-3c76-08ddb94c3f5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SPaXSPnI3iLpjWagGcNJR35KC3eVIZVoJ0GUeqo1nTrtRAQwNwZvVlz26fob?=
 =?us-ascii?Q?vH6Yu8wnuUbtFF7ekvDzt6OUcw+yrCCR4MxO4Xrh59lZAUf5p8saRun41mok?=
 =?us-ascii?Q?IVWyKDNNfojYO6PJ8zsm86LpburubsEDMfw+JMwIJ51/xyNJETSoQML7UAWC?=
 =?us-ascii?Q?83ieCCOJ27Qb5kmHW2tuNJGtsLAJHnH7k5pi/Z39TNDd6rYiHVQzECSv55b8?=
 =?us-ascii?Q?P9b8HpDUt3GdmYC/LIHudgSehwmRqM1rugZLFWJmq4/RDwBv06YZqCvC/VDY?=
 =?us-ascii?Q?yWcGSIMFs0aF/O3/kF8yu3xf326JyJ69cRkEhYNqZg/zAnHFfXcXB6dMzMsu?=
 =?us-ascii?Q?Fh1P6iBTxun7SBZ1/wPj2/frxPEc27sTo2EN4xThbSLi6I9z+KH5VRmoSTGC?=
 =?us-ascii?Q?FSmmLDjSLkBCil1DYlgTcBjfqjWWRjPSeXP2M8G0XK8wDJMWBZeKt0JA0hlh?=
 =?us-ascii?Q?DM4lQiL6egQT47Gv8xpUfk7lYSJBceJX/CYgcQE/CHazMcHUACkjhYS4sy36?=
 =?us-ascii?Q?Sf31i7x7/o1Q4fDzUlyY7ExeAUBsq0ATDFhqFtAsXdgkX8JUZgjOqc1vJF4w?=
 =?us-ascii?Q?tqtJTq2EQTF1esbpaVucfZ6/in7yz1vi8E9Hit/cMw4HZt48fSlxeqDuLf0k?=
 =?us-ascii?Q?bJRlUNZ60u+g/G66P2A9ytYYtYUOWNRFz2W4mZuarW4/KO2llDG8JaZrTkzr?=
 =?us-ascii?Q?u+NNkoF5dNAlF1gOZn8OgndU1hQ+mELivhHphDj4zUByq6+Gmp/gcso4w9DK?=
 =?us-ascii?Q?bz3u9LwU4I/AWuMsw54FUSrb0T2y+Tpf8cJse3dydSaymoIsjCnY1Z7K3wNI?=
 =?us-ascii?Q?EHSPRsVtaxS9iv/3TpBQVEDC/GYApziZ5Ef+2uRD6e3F7CY6N4ZmcwhCw7i8?=
 =?us-ascii?Q?0bilbuMu9xK/NMpcmOUq2wjPivbkB7xkdTXPZtXxk5+O9FAZXf1D8IQo13AK?=
 =?us-ascii?Q?hBXagUXpjlh9FbaRPxkjfXB7X/oAuoSafDXBt+JUDb9idQfmsQzNTLpe/y1w?=
 =?us-ascii?Q?6Cm4HyL9k2EaGo8fXepGi36VOK4c6KM8mchcsge+/qzaZW22pe5XIsAOEJsB?=
 =?us-ascii?Q?pMEdz1f1y5P3BhiOyz3ZWmXl0U0+fvSzmT0pkw35fIq1xweqzGRgiV40s/o8?=
 =?us-ascii?Q?xGSD0zmtCMlCyZFN2ijw178isdAESgJt2znCZDC5pa4zIjr2x3GFTfiu79o9?=
 =?us-ascii?Q?dHUhiyLc2jX8xwO1CnW8FyEJ27hT0pNcLC0fryJKG6RHqJZcup4B8HFqN+AW?=
 =?us-ascii?Q?4EazGRFxJF2wTkLMnEVxPIglV2v4spMw+wrhawEfP/aOOHehApnx8vQiku8i?=
 =?us-ascii?Q?guug2XxSzy2N1IexYNSN7kncSwpsGecCrTHbQlBnjVpL8hpdksHF1GdLf+HZ?=
 =?us-ascii?Q?CXnb3A5fKKotIN8BCUix//diXlXISyAEeKEaxLQ0pEx+A8zk3dj12CJiUZL/?=
 =?us-ascii?Q?D01DmE1IQtEoGQu2rsTU58IJ8/KDjkr2yjhK/XLqdOAReN9uSnFnDXMUZR9n?=
 =?us-ascii?Q?t3dKuhiBOmAjgA4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Pq+Uieq+3/4pkgPR+jF2DgsvW1NZOCR5p0uq8H/Sn0ce7pFtrkLYHnTCza9c?=
 =?us-ascii?Q?fuXnvOHBReoaG5Pv+4pb+kx7Vc6POALTag7VBVu+6+3TLylxDx0d/lLLtvHL?=
 =?us-ascii?Q?jvOEMrbHDv+EOibyD9Nh8SIRmQLth2Qke2YiAW//I5ravYHuaLZkAzMjLjvG?=
 =?us-ascii?Q?QtEb3NS51AQyuKE7zfRBXxyVlQaTAVAR46YQYgXn2OlPDf0kNpFw4XJpFYl5?=
 =?us-ascii?Q?S51xtJqrDJUckhdKeX3vAl1sGWY19LnLfGpIKH95Ifczuhp8y79OqGRLf2db?=
 =?us-ascii?Q?BeLd/sDIU6banOXcwib47V0lXx8li74Qup2JD7h6kvKbxPqV3ruVltSIyVa3?=
 =?us-ascii?Q?iGYr+K/RSrNi21j9FkzrKzXqxJoFLPCX/pOf1i+uajyuaBGUCpa4KRkPIBeN?=
 =?us-ascii?Q?aa9Fk18imvPK4xDlcJnNP6LuCd2imiaM2nMKPKd84vbkpLlwMUXR+chtY13f?=
 =?us-ascii?Q?LfHfJy4TF2kdD+Me5GmL1dp1ZZ/i2588h6ZXo24tz77zO/9D2YZq2tOgJjMM?=
 =?us-ascii?Q?YeOn3Sv47s+nlJzsGQiqBwELmw8zdRFuFjMWZ5TwfjysFTcAJR3cEFakzPl0?=
 =?us-ascii?Q?AmdxpnsuYb7Qys86Vyx3fz60kjETJPAD4rHpe9VPzNaycBOqDLMH/p6ISTih?=
 =?us-ascii?Q?yIRwR8/HerBQjWW7uKr9WcQGOtC4t6o1bgYEkQiOtHYclYStfbsFt5a5R/N5?=
 =?us-ascii?Q?kxIQOaLVZGeqGN4cJtUa7mxvsnOUq3fiGX6AmzJGeRpsvym2xJZuhVgxhGvB?=
 =?us-ascii?Q?5jn1ZG4WKxP6fCHUN123Awo5pFsVOUqGARXm+dL6ZOKINynI6SQQEf30ZlGp?=
 =?us-ascii?Q?KXZKPEkpfnzuqCTsx4vBmWx6D+prhx9ECG1VAOJtX8OiFGK90TXfHpeihL35?=
 =?us-ascii?Q?MYPTY9JxvchwwJwDST7Ba/dpO6eja+5ZJqbJ15DO9E8qtxiHXF0lM5gtj00R?=
 =?us-ascii?Q?OvIexg6CEtTcz9ix77mRQp6XS5rWWPp10kbowTB8Plb19MQVmOeiO8vRl7rZ?=
 =?us-ascii?Q?a4d1Bz4XvYFgtj3s0JmguIOowp194LtdN6TG1qItTwFEJyeWYwgs8cBcbgTe?=
 =?us-ascii?Q?MpRR9D3S31KN2LRqXoqRu4iWfuN3Oz/bhk08COfwC4fV0qT0vbXdXkTIpWJf?=
 =?us-ascii?Q?fXYaiuxwbvQah7Wf3EIvLFz0W8+9yzrgOcaRL1uQAwmELNT977/NFhCykm4p?=
 =?us-ascii?Q?6Y2tmzh1MVbB64khSGbeDY/gBuimn6HCpWtrlV5xeidhSnc/ZDvHLdetudOX?=
 =?us-ascii?Q?g8aNpo6lIIlQym/d6dgymNDucdl7XVkRzEGn03ZCxbhWUZkJhyK/q9yeJ9ss?=
 =?us-ascii?Q?uVT1youXhm3rNDj/MXvF6EBCWuGoRqice7qc49H04r0wkcoAvJjKnrbDKv2n?=
 =?us-ascii?Q?W5JK0kOT9yaBYlyfSd+IqacYUjHa0HJcH/1ajnFkZ8hqkV1ouq8ZALi3uHIB?=
 =?us-ascii?Q?ZxgKz7zZ5y3vhwJ+Vg0UCWvxxYxDdbYPRRmtXRPOmaj3TbMpg96fF3svC6WN?=
 =?us-ascii?Q?JpSdtnVicCiZAcAHUVYZ/ct2MFJRh77rXBUWuTbvtoPfBR9DxPmGlLF/4H1Y?=
 =?us-ascii?Q?Q4s1v2ta6W7j6vtIBGI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cd0dc0-8e2b-41c8-3c76-08ddb94c3f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 09:38:48.8203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2CDtM+erkJ+BIoOqH9BLKUvpmYXDXY+VPPFKvt//AjwuGgWA0r/RfVifIuDqRkwNW6ooge3t4sdnGgfm9TfWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Vinod

Thanks for the review.

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Friday, June 27, 2025 03:37
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
> On 23-06-25, 11:47, Devendra K Verma wrote:
> > The HDMA IP supports the simple mode (non-linked list).
> > In this mode the channel registers are configured to initiate a single
> > DMA data transfer. The channel can be configured in simple mode via
> > peripheral param of dma_slave_config param.
> >
> > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c    | 10 +++++
> >  drivers/dma/dw-edma/dw-edma-core.h    |  2 +
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 53
> ++++++++++++++++++++++++++-
> >  include/linux/dma/edma.h              |  8 ++++
> >  4 files changed, 72 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > b/drivers/dma/dw-edma/dw-edma-core.c
> > index c2b88cc99e5d..4dafd6554277 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -235,9 +235,19 @@ static int dw_edma_device_config(struct dma_chan
> *dchan,
> >                                struct dma_slave_config *config)  {
> >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> > +     struct dw_edma_peripheral_config *pconfig =3D config->peripheral_=
config;
> > +     unsigned long flags;
> > +
> > +     if (WARN_ON(config->peripheral_config &&
> > +                 config->peripheral_size !=3D sizeof(*pconfig)))
> > +             return -EINVAL;
> >
> > +     spin_lock_irqsave(&chan->vc.lock, flags);
> >       memcpy(&chan->config, config, sizeof(*config));
> > +
> > +     chan->non_ll_en =3D pconfig ? pconfig->non_ll_en : false;
> >       chan->configured =3D true;
> > +     spin_unlock_irqrestore(&chan->vc.lock, flags);
> >
> >       return 0;
> >  }
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.h
> > b/drivers/dma/dw-edma/dw-edma-core.h
> > index 71894b9e0b15..c0266976aa22 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -86,6 +86,8 @@ struct dw_edma_chan {
> >       u8                              configured;
> >
> >       struct dma_slave_config         config;
> > +
> > +     bool                            non_ll_en;
>
> why do you need this? What is the decision to use non ll vs ll one?
>

The IP supports both the modes, LL mode and non-LL mode.
In the current driver code, the support for non-LL mode is not
present. This patch enables the non-LL aka simple mode support
by means of the peripheral_config option in the dmaengine_slave_config.

> >  };
> >
> >  struct dw_edma_irq {
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > index e3f8db4fe909..3237c807a18e 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct
> dw_edma_chunk *chunk)
> >               readl(chunk->ll_region.vaddr.io);  }
> >
> > -static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> > first)
> > +static void dw_hdma_v0_ll_start(struct dw_edma_chunk *chunk, bool
> > +first)
> >  {
> >       struct dw_edma_chan *chan =3D chunk->chan;
> >       struct dw_edma *dw =3D chan->dw;
> > @@ -263,6 +263,57 @@ static void dw_hdma_v0_core_start(struct
> dw_edma_chunk *chunk, bool first)
> >       SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > HDMA_V0_DOORBELL_START);  }
> >
> > +static void dw_hdma_v0_non_ll_start(struct dw_edma_chunk *chunk) {
> > +     struct dw_edma_chan *chan =3D chunk->chan;
> > +     struct dw_edma *dw =3D chan->dw;
> > +     struct dw_edma_burst *child;
> > +     u32 val;
> > +
> > +     list_for_each_entry(child, &chunk->burst->list, list) {
> > +             SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
> > +
> > +             /* Source address */
> > +             SET_CH_32(dw, chan->dir, chan->id, sar.lsb, lower_32_bits=
(child->sar));
> > +             SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> > + upper_32_bits(child->sar));
> > +
> > +             /* Destination address */
> > +             SET_CH_32(dw, chan->dir, chan->id, dar.lsb, lower_32_bits=
(child->dar));
> > +             SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> > + upper_32_bits(child->dar));
> > +
> > +             /* Transfer size */
> > +             SET_CH_32(dw, chan->dir, chan->id, transfer_size,
> > + child->sz);
> > +
> > +             /* Interrupt setup */
> > +             val =3D GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> > +                             HDMA_V0_STOP_INT_MASK |
> HDMA_V0_ABORT_INT_MASK |
> > +                             HDMA_V0_LOCAL_STOP_INT_EN |
> > + HDMA_V0_LOCAL_ABORT_INT_EN;
> > +
> > +             if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > +                     val |=3D HDMA_V0_REMOTE_STOP_INT_EN |
> > + HDMA_V0_REMOTE_ABORT_INT_EN;
> > +
> > +             SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
> > +
> > +             /* Channel control setup */
> > +             val =3D GET_CH_32(dw, chan->dir, chan->id, control1);
> > +             val &=3D ~HDMA_V0_LINKLIST_EN;
> > +             SET_CH_32(dw, chan->dir, chan->id, control1, val);
> > +
> > +             /* Ring the doorbell */
> > +             SET_CH_32(dw, chan->dir, chan->id, doorbell,
> HDMA_V0_DOORBELL_START);
> > +     }
> > +}
> > +
> > +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> > +first) {
> > +     struct dw_edma_chan *chan =3D chunk->chan;
> > +
> > +     if (!chan->non_ll_en)
> > +             dw_hdma_v0_ll_start(chunk, first);
> > +     else
> > +             dw_hdma_v0_non_ll_start(chunk); }
> > +
> >  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)  {
> >       struct dw_edma *dw =3D chan->dw;
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h index
> > 3080747689f6..82d808013a66 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -101,6 +101,14 @@ struct dw_edma_chip {
> >       struct dw_edma          *dw;
> >  };
> >
> > +/**
> > + * struct dw_edma_peripheral_config - peripheral spicific configuratio=
ns
> > + * @non_ll_en:                enable non-linked list mode of operation=
s
> > + */
> > +struct dw_edma_peripheral_config {
> > +     bool                    non_ll_en;
> > +};
> > +
> >  /* Export to the platform drivers */
> >  #if IS_REACHABLE(CONFIG_DW_EDMA)
> >  int dw_edma_probe(struct dw_edma_chip *chip);
> > --
> > 2.43.0
>
> --
> ~Vinod

