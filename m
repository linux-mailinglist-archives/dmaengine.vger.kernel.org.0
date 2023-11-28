Return-Path: <dmaengine+bounces-277-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302FA7FB96C
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 12:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF90282AE9
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 11:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090D74F603;
	Tue, 28 Nov 2023 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PUfBwiHr";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NZ+TH5RP"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3063DE;
	Tue, 28 Nov 2023 03:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701170973; x=1732706973;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JxYcsvcr1ILzJwMkDRbf/mn7s1U+mPLMXFdP1+XMCd8=;
  b=PUfBwiHr9wKOuCSDc3C0HKhaLOETHaH5IC5gUiazJg4Iw+Qx0/nz8Ks8
   iRTUkc/5BLXv71LvmFqwYFEk4+SE0fv7wuScLrXr5DVew/r3n5KxogBhl
   9s0yhTOlWOa7bJ5nDzHwSCMYW3IkvwcUkM3lgq5YBM1IFsXu05vD5++Ey
   mmna2SpL6ynMmTbXc3czKjT0sRHfZPdvCA3DnGKvyTQPPpUm7+xh8j4TH
   zOrNsW11rxfCBoSl/4vSKs+NLC/C3yKhW0kM+f1PolTRkBNkA9ZnwjOVR
   8d7StfWyHH7m+Il51U+U3iD6nRG0H2EndqY37lWdOKb24xrInfMEqR+Ux
   A==;
X-CSE-ConnectionGUID: /CdIFC7uRNmtXXO6CQIf3A==
X-CSE-MsgGUID: gx+mIcNVSyu/cf3cym1HaA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="13173219"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2023 04:29:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Nov 2023 04:29:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Nov 2023 04:29:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lczJu4p/Uzg4UHRWwESedvqj6hP4yCyTdUfhOdSpNTBBENNNPplgyWzhSvO1kSAVwzflYKnDv36ea3sMJ8wnLJr2IYYuntYmuXB7LNDdnCl+ZH33kBr7KCQXpAjVJ/vrVhQu/CGX3PJKGo0LolpeGv+C19EiFGOcHOWa7KeIGfCJAPf+Cn/5Bjr0YeyfyNH0FmrZc2x4eaisMTNLxp7CHLbG5r8ffKAU8wUucp5YuQUmohpUr1rE6mv8jy8A2+bFVUeyLapIwu5R0BexuPBzTCU8MSSc5KuPioFSRc1mPdf2wc4EHX+PMQRH2Cri+H2QwFLY0YUi/GRTCc4xhK17pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZmJyHhYpktdVJ44+bI13v7J/s/GboZBMl9zLmMLOzQ=;
 b=CDT5Bp19QJI6It/0UKm0+VeaGpYnHr9EBazAMIMe/oZcm01CLRhgsMLv1DYB+RBVR/AYPavwiTrRZW1ex6R5Ly42HxNpQXLH9hObl/6tw3LiHR1hhxoXAD+1G8eoGmrOX2/zgwNtb6ZPqQcXjvO4mETrQkl0Bry+rHBOw+Yl91DbjpLJF/ufdB09z7mfyaSxdgNNywq0kn3vOmJmRdwl8DI+DTBRwjRvqayn6YPnPvnWCx1sQ6ZT+W/dOwj3zgoL2y0oGEk92Ju9A1/E0WVN2PibSRvDRd+FOX+jVz8RIBsXhXxbkSJhUOt0b7Tkn09oNjoLTSfSyzgFDadMiWGAeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZmJyHhYpktdVJ44+bI13v7J/s/GboZBMl9zLmMLOzQ=;
 b=NZ+TH5RPOccKEcMJ1f13/Ih07XXpaKD6HUX42LWp0RvkQOHg0yvsP873kS4bzq35F27UjvJy3znW3JGE8XfKBZPXuDvFufhCDvWXAdw4IlqBYXbJnIachcXgg6mEcNkLy4Om/A3+o6afobaSh7rGkOfgAFknwixBArGWbGOEoYtqppqcWR2ngNi9UZ7P3u2pGjk5x8EGFwIKgJBaBH+YcyghPHtzhUXcy1mWrg8LaYMWXzELXI2gdS0yaYdKYcQJihHIsCFjJt4R176RNSTNykLccxg8Ep+DjoVrRZBazTYwsWS7Vu+CkScwhUI3qiF7N8AWiF3eFT7ayIEyhX9uMQ==
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by SJ0PR11MB4815.namprd11.prod.outlook.com (2603:10b6:a03:2dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 11:29:12 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::447:632:a9ce:152f]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::447:632:a9ce:152f%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 11:29:12 +0000
From: <Shravan.Chippa@microchip.com>
To: <vkoul@kernel.org>
CC: <green.wan@sifive.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
	<paul.walmsley@sifive.com>, <conor+dt@kernel.org>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<Nagasuresh.Relli@microchip.com>, <Praveen.Kumar@microchip.com>,
	<emil.renner.berthing@canonical.com>
Subject: RE: [PATCH v4 3/4] dmaengine: sf-pdma: add mpfs-pdma compatible name
Thread-Topic: [PATCH v4 3/4] dmaengine: sf-pdma: add mpfs-pdma compatible name
Thread-Index: AQHaC7rsFK61Gcrk5UGSzfsdrL5RtLCJh0cAgAY9ATA=
Date: Tue, 28 Nov 2023 11:29:12 +0000
Message-ID: <PH0PR11MB5611079D8DA8B6F389BE187E81BCA@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20231031052753.3430169-1-shravan.chippa@microchip.com>
 <20231031052753.3430169-4-shravan.chippa@microchip.com>
 <ZWCS+ECGTgwVPR1u@matsya>
In-Reply-To: <ZWCS+ECGTgwVPR1u@matsya>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|SJ0PR11MB4815:EE_
x-ms-office365-filtering-correlation-id: 3fb850ad-972d-402b-2a84-08dbf0053ef6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /hbRkjT5UjMYzXsb65AmLdSN4jTLZ6iLGkyDPHIxU25koI8gjYpUXF7apiWLHURiost9PUONaOFQH/Ryw20zy856tWfclvKRZVRZlSPehBGIlnPmJUN1T3CfAwJxZFyGpyWAJIDlk4trgn3pq/Z5HBdM0NEJ17SD2YFd1SShEei736zdfn7TUPqYTfJ4sUqWbYPWOy4fhvpj1BaVjobo9kwTX6Fx/pAEOZ0M68Q/rQliT30keOb+WIAqpvUVtHr+PegFv5VFhXDdWG2GAW4Br3VdgfeDzZFZ5OysW6dM2z2l7OZHFhNrbnGuDz/z2soDsKsRp6wNU6Zlund4gTed3WAZM5sk6lzWcgp3NrOr12Hcm0kGpCW/4F0hCYHEhsJ2oV5iI2or23km8lFWNymdCIgXFDp8SGmqo2hxxq2Kym7EZ3csHMc+fhc+pvBh5kWSTqCZ3/+Nld3/4mk0SQOnpDaAnV0pyUhr4Br6OTe5UevAM86RKPtbF44GDAgQE7aOdotGoW2RhLIczCzdMtNRqH2qREQOnE8QmsuVejpQ4wG7vmzY6SNkjIq2mZ4UXiV8iM9zofr+dMaQJqo8bQ8noyK6MYNIqoM8uEVVHKi9UtHX7JxblpbYLqNnntTFl3Vvyzr2XdN83Lhb8Dj4WFrckxyFHJi4/E23I5rLVtQQ3us=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(230273577357003)(230922051799003)(230173577357003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(55016003)(26005)(966005)(53546011)(9686003)(7696005)(478600001)(6506007)(71200400001)(38100700002)(86362001)(38070700009)(33656002)(122000001)(7416002)(2906002)(76116006)(66946007)(5660300002)(83380400001)(6916009)(64756008)(66476007)(66556008)(66446008)(8936002)(54906003)(52536014)(316002)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rg4klz71oCrE/MjMDbrzjkOsdquSdIZrfVnhz8P01WXt7j1yyES5XPcqXFkU?=
 =?us-ascii?Q?Gao+4vPfA/Cfsqmey0n2fJn2FaZStCpeSki+kS/1Ln9JOnCZmNbxiNf9Z3KY?=
 =?us-ascii?Q?Hogw5ItWjcix0K/jzHSes59h0LRCjkXroY0eFSgsPe3EXXGwbWFywmNJKIqQ?=
 =?us-ascii?Q?WskiOQGm2HWOINpdI9+7jPbzc7gWbJVNEcy5r1rGgOcijqayN5VXie2Lq0TY?=
 =?us-ascii?Q?TgRN07RtmZjv7aVwb+kgYuwI9djLE+uHCT5AYoYcJyIoV8mIVEZj9c4Bmeb/?=
 =?us-ascii?Q?S/gucKe5CuLTLaiL1jmh5TyEqepxUy2yNznudrhjuY+dC25riEFwmv8X65FM?=
 =?us-ascii?Q?HobjXrFsWWgcJuas2UfWr8yQLdLVNqTXt9/UXW8nSJNAG1Hjn7k6C/SUrOJd?=
 =?us-ascii?Q?7fKahuPv0vqTMQ+0inobdi50toyIT721DUuXQcOT+NJ05Nmy/9kLhdljN+Y4?=
 =?us-ascii?Q?RHygC4glJIW4WgBpW/j/y8L8kkZoAZX1zRHuqXbL870lI0r8iVnCbWd3Ue3B?=
 =?us-ascii?Q?WcyLFcyVMXdgmImupFZ/vy0dYDENDf9ziswUq5ChGSxeNRZla4f+n8KmDTI3?=
 =?us-ascii?Q?6eFyJy/vU1axAbnEckgFnNbTqsUQjs/4HBkwMd0c3GwX4H9DQWI7k2H0I/bG?=
 =?us-ascii?Q?AxTnrwLyeYyYUGFNATbvc7sWJAgL0ZQQ5im4aJObIuZ0Vg7UkVNbWSRaznEC?=
 =?us-ascii?Q?+NkmfzN5tL6IAQOXSzNi4r2GnqeZnJzDLBGtkbeEDonO7l5Q19jqcbww60KK?=
 =?us-ascii?Q?DQ4d3GYNNDDCnodyThz8tzA3hJ16iCERrrl2TB2ZW/M3yRfXxDEDjz0Dh7SO?=
 =?us-ascii?Q?ZH7OoGPO1CQS3yCscFh0iRbSrIIpt9Cf+WMQNGlqXWZyghH/NEihZjinLVfz?=
 =?us-ascii?Q?+fmVV6u6rth1nOp1thAkEhIO5ZiyMDA8OMh1ZrNU8y0VnbH+L0NKsxmQaOWC?=
 =?us-ascii?Q?8tvgSKDD7NQ4cCxl5gzk/vmobQ7YA5ykcmMaVEwrjJ+P8Hd198TP6Sam2pED?=
 =?us-ascii?Q?naWTvxstPX89KyPDiF+pMM+Y2dC5cj1NndIS2F5tB63fDq+eKY5my7ceruit?=
 =?us-ascii?Q?Nhw3fJ0moMyh/wNzq39VmsVH/iNN6KNa3o8QwGSK6X3mYUITxX4uBEar9eMu?=
 =?us-ascii?Q?A+c2c6JgO5bPbXm0tHKPfiXhDtRW8BqEhjf7e1+jbCpTD1Vt8FWFJv3fT9iw?=
 =?us-ascii?Q?PDdhysirZUXwZZ9SPnr5LoaZFR0e9/LCeUTO2wwR9kg1z6GW+0kzsrxfW/XU?=
 =?us-ascii?Q?+enrhEQLv3pZheMVB8h0YmqeDUGFZo0zgUkgUl2PHJ/FfVdrKdzuTENFD5xy?=
 =?us-ascii?Q?LM8maQlCZ4rAwTUzvvf+mWVWw21KvY8KkPuewb1M+U60FUVGTo+WI8w2EzHc?=
 =?us-ascii?Q?W4jcPa+QcgadAbKsAZLkimKFGuncA6775Jl/xeB0Gr+c042DGrG8ESA1UfXN?=
 =?us-ascii?Q?mNyoGrrNMEjc8MGYV95qoZCV9o5/TAdlRm88CeR3mFp2ZtO01Q8gB8IgBZaS?=
 =?us-ascii?Q?04D4QNQAdbHPpwBnfudRm2a1yiwWCaQws3/6VNrFcPqkve8ZcNu21UwBfH5c?=
 =?us-ascii?Q?jPmnV4P0XXG5j6tR8sRH7W7LAncNSl9bZWkW2cfZeIAJfQU4YYuSLhCAo810?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb850ad-972d-402b-2a84-08dbf0053ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 11:29:12.4698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZ/YKEUPu9SvvyYHMyySujPWAAez7dXQ8HD6yGxIkhUx285xiDdNNRdaFIES4RXq/EcMTmOQxNT4XmAC/NeTHg9poRz7VBasBZ1MTph9vzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4815

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Friday, November 24, 2023 5:42 PM
> To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> Cc: green.wan@sifive.com; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; palmer@dabbelt.com;
> paul.walmsley@sifive.com; conor+dt@kernel.org;
> dmaengine@vger.kernel.org; devicetree@vger.kernel.org; linux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Nagasuresh Relli=
 -
> I67208 <Nagasuresh.Relli@microchip.com>; Praveen Kumar - I30718
> <Praveen.Kumar@microchip.com>; Emil Renner Berthing
> <emil.renner.berthing@canonical.com>
> Subject: Re: [PATCH v4 3/4] dmaengine: sf-pdma: add mpfs-pdma compatible
> name
>=20
> [Some people who received this message don't often get email from
> vkoul@kernel.org. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On 31-10-23, 10:57, shravan chippa wrote:
> > From: Shravan Chippa <shravan.chippa@microchip.com>
> >
> > Sifive platform dma does not allow out-of-order transfers, Add a
> > PolarFire SoC specific compatible and code to support for out-of-order
> > dma transfers
>=20
> By default dma xtions are not supposed to be out of order, so why does it
> make sense specifying that here?

All the DMA transfers are mostly in-order; however, sf-pdma IP has programa=
ble configuration:
we can select the transfer type either in-order or out-of-order.
=20
Sf-pdam IP will only support mem-to-mem transfers.=20
=20
We got better throughput in the PolarFire SoC platform if we use out-of-ord=
er DMA transfers type, instead of in-order configuration in the sf-pdma IP.
=20
test results for in-order:
- moved 16 MB from 0x89000000 using pdmacpy to 0x88000000 (chan: 0) in 0.06=
8962 secs (232.012 MB per sec)
=20
test results for out-of-order:
- moved 16 MB from 0x89000000 using pdmacpy to 0x88000000 (chan: 0) in 0.03=
7020 secs (432.199 MB per sec)

Thanks,
Shravan

>=20
> >
> > Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > ---
> >  drivers/dma/sf-pdma/sf-pdma.c | 27 ++++++++++++++++++++++++---
> > drivers/dma/sf-pdma/sf-pdma.h |  8 +++++++-
> >  2 files changed, 31 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/sf-pdma/sf-pdma.c
> > b/drivers/dma/sf-pdma/sf-pdma.c index 4c456bdef882..82ab12c40743
> > 100644
> > --- a/drivers/dma/sf-pdma/sf-pdma.c
> > +++ b/drivers/dma/sf-pdma/sf-pdma.c
> > @@ -25,6 +25,8 @@
> >
> >  #include "sf-pdma.h"
> >
> > +#define PDMA_QUIRK_NO_STRICT_ORDERING   BIT(0)
> > +
> >  #ifndef readq
> >  static inline unsigned long long readq(void __iomem *addr)  { @@
> > -66,7 +68,7 @@ static struct sf_pdma_desc *sf_pdma_alloc_desc(struct
> > sf_pdma_chan *chan)  static void sf_pdma_fill_desc(struct sf_pdma_desc
> *desc,
> >                             u64 dst, u64 src, u64 size)  {
> > -     desc->xfer_type =3D PDMA_FULL_SPEED;
> > +     desc->xfer_type =3D  desc->chan->pdma->transfer_type;
> >       desc->xfer_size =3D size;
> >       desc->dst_addr =3D dst;
> >       desc->src_addr =3D src;
> > @@ -520,6 +522,7 @@ static struct dma_chan *sf_pdma_of_xlate(struct
> > of_phandle_args *dma_spec,
> >
> >  static int sf_pdma_probe(struct platform_device *pdev)  {
> > +     const struct sf_pdma_driver_platdata *ddata;
> >       struct sf_pdma *pdma;
> >       int ret, n_chans;
> >       const enum dma_slave_buswidth widths =3D @@ -545,6 +548,14 @@
> > static int sf_pdma_probe(struct platform_device *pdev)
> >
> >       pdma->n_chans =3D n_chans;
> >
> > +     pdma->transfer_type =3D PDMA_FULL_SPEED | PDMA_STRICT_ORDERING;
> > +
> > +     ddata  =3D device_get_match_data(&pdev->dev);
> > +     if (ddata) {
> > +             if (ddata->quirks & PDMA_QUIRK_NO_STRICT_ORDERING)
> > +                     pdma->transfer_type &=3D ~PDMA_STRICT_ORDERING;
> > +     }
> > +
> >       pdma->membase =3D devm_platform_ioremap_resource(pdev, 0);
> >       if (IS_ERR(pdma->membase))
> >               return PTR_ERR(pdma->membase); @@ -632,9 +643,19 @@
> > static int sf_pdma_remove(struct platform_device *pdev)
> >       return 0;
> >  }
> >
> > +static const struct sf_pdma_driver_platdata mpfs_pdma =3D {
> > +     .quirks =3D PDMA_QUIRK_NO_STRICT_ORDERING, };
> > +
> >  static const struct of_device_id sf_pdma_dt_ids[] =3D {
> > -     { .compatible =3D "sifive,fu540-c000-pdma" },
> > -     { .compatible =3D "sifive,pdma0" },
> > +     {
> > +             .compatible =3D "sifive,fu540-c000-pdma",
> > +     }, {
> > +             .compatible =3D "sifive,pdma0",
> > +     }, {
> > +             .compatible =3D "microchip,mpfs-pdma",
> > +             .data       =3D &mpfs_pdma,
> > +     },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(of, sf_pdma_dt_ids); diff --git
> > a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> index
> > 5c398a83b491..267e79a5e0a5 100644
> > --- a/drivers/dma/sf-pdma/sf-pdma.h
> > +++ b/drivers/dma/sf-pdma/sf-pdma.h
> > @@ -48,7 +48,8 @@
> >  #define PDMA_ERR_STATUS_MASK                         GENMASK(31, 31)
> >
> >  /* Transfer Type */
> > -#define PDMA_FULL_SPEED                                      0xFF00000=
8
> > +#define PDMA_FULL_SPEED                                      0xFF00000=
0
> > +#define PDMA_STRICT_ORDERING                         BIT(3)
> >
> >  /* Error Recovery */
> >  #define MAX_RETRY                                    1
> > @@ -112,8 +113,13 @@ struct sf_pdma {
> >       struct dma_device       dma_dev;
> >       void __iomem            *membase;
> >       void __iomem            *mappedbase;
> > +     u32                     transfer_type;
> >       u32                     n_chans;
> >       struct sf_pdma_chan     chans[];
> >  };
> >
> > +struct sf_pdma_driver_platdata {
> > +     u32 quirks;
> > +};
> > +
> >  #endif /* _SF_PDMA_H */
> > --
> > 2.34.1
>=20
> --
> ~Vinod

