Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21712D386F
	for <lists+dmaengine@lfdr.de>; Wed,  9 Dec 2020 02:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgLIBxn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 20:53:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:48633 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgLIBxn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 8 Dec 2020 20:53:43 -0500
IronPort-SDR: ubxPVOlpTzJOiSklyJd8zHcDjDbKmp3NHxSaCQpj0oPheFX9VtW51oZPD499nM8xTJjaGMrfKq
 eP/CNgoPXDiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="173243698"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="173243698"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 17:53:02 -0800
IronPort-SDR: KYvZoxPyRwlOOZ8QXHwidHpQuTb3rrBasrE0/EqcVwfvwaUqz8abgVtpeVBqsxxAtYXoAXm80E
 fIt/YadmclQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="332751431"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 08 Dec 2020 17:53:02 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Dec 2020 17:53:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 8 Dec 2020 17:53:01 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 8 Dec 2020 17:53:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3658BSIMszG44gEvUgdoMwa1vcUaxbmLMKCG+Oy6XlQJ6+KzS1H4MuLHZ3UWMPi/tTkszSseZCWdF6YFuhfVuz/Hoa+nAKjQiJaKbfz4ubhM9M512Q6msdIQzGCFcflFUughEx1f3XqLGhH6tUto2H8FE1nsgszLu3vGGzITBc5+Fyi6d0Ov2jVn7IV8e7djklGZA2cTEfPrRqGmfwgwr8X5WcocxVAWGHrlcyF+CPkcRpS1+VFC8baDlI2WaCXbeYc9AfjNjYD/H6Ltx730cwvaZ2Nw0QHJdPGpNchePpR4lA+oi9JaLm9+U4y4T0PJfkfrw9vaaQ4DFLm3n/ZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89sAK7eMX0Cd1MpBJA5l4eQndbve87UqLvQGagowlzs=;
 b=UyeKLL6dNdrO7i9E7AxbFzhN6faKvTuigV085oS2oCkmV4XwMZfz392uEyYBEaukX8+DM4zmdVPgfK58D9PsDa1jgNldzlizS3BQ1GTLGu9bBHRZbs2IjRB3678mR8s8sHPDyNPX5vFqFA1SIQL1rE6C6NEdsF4GWqmKEKXu+knMKg/pTbLPc2WmeAN/rZ/luYxOWe/a19m6rjqEogtLL72JiRPCTmGdi31XjcDUZ7XldyBmjd3fq4iRzPgoPkENa1mxAj+Ex0MhYl8H8AdJ/TXK/61bya8rCEANbZY0Avy3/bUPEU6Ea8DDmdQMlKEF5m+o+ufIrNT0nY6Uy4vCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89sAK7eMX0Cd1MpBJA5l4eQndbve87UqLvQGagowlzs=;
 b=O/nZdQ/fKGLhOblSEd9ML1Ui46DEsWo6m5iYYrK1++cFThTcp40dq0onB6AkADkJAWpyEUBtQB+Vuvo/dVHzdqNYI/j3YZjr/HGCm7kzXW4sUi8v8c300/7x8aryqnvvlpk/G7DQp5xR1qdFIXyVwgeJVISfcxngAZLtacHRGQ4=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MWHPR11MB1295.namprd11.prod.outlook.com (2603:10b6:300:2b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 01:53:00 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f%4]) with mapi id 15.20.3632.018; Wed, 9 Dec 2020
 01:53:00 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 10/16] dt-binding: dma: dw-axi-dmac: Add support for
 Intel KeemBay AxiDMA
Thread-Topic: [PATCH v5 10/16] dt-binding: dma: dw-axi-dmac: Add support for
 Intel KeemBay AxiDMA
Thread-Index: AQHWx2hI8Yw8RptSb0yigarW3N6LYanuDFTg
Date:   Wed, 9 Dec 2020 01:53:00 +0000
Message-ID: <CO1PR11MB5026959BF7099588C163DB5DDACC0@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201123023452.7894-1-jee.heng.sia@intel.com>
 <20201123023452.7894-11-jee.heng.sia@intel.com>
 <20201130222916.GA3146362@robh.at.kernel.org>
In-Reply-To: <20201130222916.GA3146362@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [218.111.111.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b67ee28-9704-4e2a-1dbf-08d89be528c4
x-ms-traffictypediagnostic: MWHPR11MB1295:
x-microsoft-antispam-prvs: <MWHPR11MB12955B0702574BA38C1C9C2CDACC0@MWHPR11MB1295.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gFmyTga/hG7c2EtFIcGtsZHE8nT1OUmbn7m3+sNfkbwmWWdr2dbie/q1WwxwuxZHJXmnSZbI8yoIlm3kqyEUXet63THKoXI/cUJMVd8VJ5NrWVgr7YdaX/0zLYjimBF+4IMKTyDirK5Um11SKEkbdYWiJRMJtVw9ISbUQ3+Mjx8Yu0HHZDapoNMzgfWP3m/cTdZmzifFjRTJ0Ya0YkHMVktQZJC1ygtxXQpc/HV04Tf7sKfcj2xHn+9mw3xknaGL7DT49h43ndeEAHE0ssPeCbYIayUgm7GgeJXymUt6KqRYOv3U0Ir7F1liOslZG9LOC8b14a7SYWVQfAyq+1cbiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(66556008)(71200400001)(4326008)(83380400001)(53546011)(6916009)(54906003)(6506007)(8936002)(2906002)(5660300002)(52536014)(66446008)(66946007)(66476007)(508600001)(8676002)(9686003)(55016002)(64756008)(26005)(76116006)(33656002)(7696005)(86362001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?H/U4QR61E5w91cYG5mC++c7MUpjUHDiYax50lzaoVSYutXvc4V2hCk9XmZ/f?=
 =?us-ascii?Q?M0B94li+bZcxyXeixVq0STclOTbK484pXxPgFK2QWA4vgsnXa6wLqJUq/onF?=
 =?us-ascii?Q?UneIN4IDqxOBjOydaWs4b4Fqk2L4eoTntBlk4JQuHiFrT8iJh2aASXkgaes2?=
 =?us-ascii?Q?PHtK5zxPyD7404pQeHIhhoql0DkWRo8By8d8nalVzt6fVtNT91yQxi1M9mCp?=
 =?us-ascii?Q?ksVZm4Sx1OO0P3kVd0tajcpISG+A4gfSB42nrn42WCXeD0jPnXfifPfn2+dj?=
 =?us-ascii?Q?FidLFzNxFQu9cNA5/K7i8qoLr9MQHNynnpza+26PZsXBLxYL+GiN+sO+Vb9Y?=
 =?us-ascii?Q?Uw7AEJ7QpI/JqtkgCMZga9ItEqHqd5wtr3uaZw4LxFghzH1rVk+pJ6UtiWh6?=
 =?us-ascii?Q?lTNgNXeXj4OR8sdhQ5LkiCA3CRX7y4U4E4xW+pQPYWxf676O1Bi92yx76ao1?=
 =?us-ascii?Q?Fdv8yP6D7LufG8+NE9KWQnkdJga48PRHH4s401hyllxWHBoNP4hPNzpCHOMd?=
 =?us-ascii?Q?X8B6rW/92yCZWejz40Q1S2MjN3PL6BwuVZLH9lIfebzDmMBpfcVIVBIua+5p?=
 =?us-ascii?Q?idWkdqwsv1MlOBUomWjPXXpEXXDO47CGfmEcgJ5NeBMf69FWY57TWSHei1n5?=
 =?us-ascii?Q?pUoz6APUP1GilGdQBaMYv3j9uiiT3iFCGxAcqthuRW064hhA8NrdJb4/3tsN?=
 =?us-ascii?Q?ZR6QRDcLS1/BOebf4q6XdRm5kLI+U78+AWHbqh3pBcV+HIQhEHkoCf+zkZcO?=
 =?us-ascii?Q?JUwHtMbTucpcVqLbXO61Y4FS6cGK7K5fgij/ayEJ1/Vf/TjzJh0LWjr4L4QI?=
 =?us-ascii?Q?2QSljiMdS9UHao326/RUxxmkDBIj2vtWhExGG/vpBq6t00Qft0l4x1+Zvn4E?=
 =?us-ascii?Q?bQD4DFzvC2rsNDZOMiKVWxg3lomrEZ1jMXK2WJx6PmWmIaWKO6xq7tyxiKMk?=
 =?us-ascii?Q?lEg7Y4tYKEvT9Ubus550k3W3GxVPuKPkdKMFARgfz2s=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b67ee28-9704-4e2a-1dbf-08d89be528c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 01:53:00.5358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orI/irgt9EkivIwUbzFTIVghPX12EBHI0nbtTBsHY9kVmTtdS/Au/wTTqN5S4TXJrDeDZ1fuGtBGwX0y9drKDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1295
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 01 December 2020 6:29 AM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: vkoul@kernel.org; Eugeniy.Paltsev@synopsys.com;
> andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v5 10/16] dt-binding: dma: dw-axi-dmac: Add
> support for Intel KeemBay AxiDMA
>=20
> On Mon, Nov 23, 2020 at 10:34:46AM +0800, Sia Jee Heng wrote:
> > Add support for Intel KeemBay AxiDMA to the dw-axi-dmac Schemas
> DT
> > binding.
> >
> > Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> > ---
> >  .../bindings/dma/snps,dw-axi-dmac.yaml        | 27
> +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > index 6c2e8e612af5..9e3ca9083814 100644
> > --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-
> dmac.yaml
> > +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-
> dmac.yaml
> > @@ -8,6 +8,7 @@ title: Synopsys DesignWare AXI DMA Controller
> >
> >  maintainers:
> >    - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com
>=20
> Also, for the first patch, missing a '>' on the end.
[>>] Got it. Thanks for the catch.
>=20
> > +  - Jee Heng Sia <jee.heng.sia@intel.com>
> >
> >  description: |
> >   Synopsys DesignWare AXI DMA Controller DT Binding @@ -16,14
> +17,18
> > @@ properties:
> >    compatible:
> >      enum:
> >        - snps,axi-dma-1.01a
> > +      - intel,kmb-axi-dma
> >
> >    reg:
> > +    minItems: 1
> >      items:
> >        - description: Address range of the DMAC registers
> > +      - description: Address range of the DMAC APB registers
>=20
> Nevermind for my 'reg' comment on the first patch.
[>>] OK.
>=20
> >
> >    reg-names:
> >      items:
> >        - const: axidma_ctrl_regs
> > +      - const: axidma_apb_regs
> >
> >    interrupts:
> >      maxItems: 1
> > @@ -124,3 +129,25 @@ examples:
> >           snps,priority =3D <0 1 2 3>;
> >           snps,axi-max-burst-len =3D <16>;
> >       };
> > +
> > +  - |
>=20
> For what's just a new compatible and extra reg field, I don't think we
> need another example.
[>>] I would suggest to provide the below example if you don't see any harm=
ful.
>=20
[>>] The reason is because those compatible and new reg help customer under=
stand the setup
> > +     #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +     #include <dt-bindings/interrupt-controller/irq.h>
> > +     /* example with intel,kmb-axi-dma */
> > +     #define KEEM_BAY_PSS_AXI_DMA
> > +     #define KEEM_BAY_PSS_APB_AXI_DMA
> > +     axi_dma: dma@28000000 {
> > +         compatible =3D "intel,kmb-axi-dma";
> > +         reg =3D <0x28000000 0x1000>, <0x20250000 0x24>;
> > +         reg-names =3D "axidma_ctrl_regs", "axidma_apb_regs";
> > +         interrupts =3D <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> > +         clock-names =3D "core-clk", "cfgr-clk";
> > +         clocks =3D <&scmi_clk KEEM_BAY_PSS_AXI_DMA>, <&scmi_clk
> KEEM_BAY_PSS_APB_AXI_DMA>;
> > +         #dma-cells =3D <1>;
> > +         dma-channels =3D <8>;
> > +         snps,dma-masters =3D <1>;
> > +         snps,data-width =3D <4>;
> > +         snps,priority =3D <0 0 0 0 0 0 0 0>;
> > +         snps,block-size =3D <1024 1024 1024 1024 1024 1024 1024
> 1024>;
> > +         snps,axi-max-burst-len =3D <16>;
> > +     };
> > --
> > 2.18.0
> >
