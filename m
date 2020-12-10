Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30EE2D5046
	for <lists+dmaengine@lfdr.de>; Thu, 10 Dec 2020 02:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbgLJBXS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Dec 2020 20:23:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:35389 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgLJBXN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 9 Dec 2020 20:23:13 -0500
IronPort-SDR: c018dPD/MOpEHE0ggjJAr7vhPmFCEPAuuPvZFjptpjVI0Jz8qot4DKHqo4RQXBht3z/SkASo++
 fOuRjrnpKIEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="170670229"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="170670229"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 17:22:28 -0800
IronPort-SDR: lpPYxl82sveq51DKPP4v/d5Xs8JXLfs1jeDd4mzhMxlXKc98/4eUxhnTlp9MorZvlyPAExwimO
 ishh5bGCSAWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="318972908"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 09 Dec 2020 17:22:28 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Dec 2020 17:22:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 9 Dec 2020 17:22:28 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 9 Dec 2020 17:22:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrfkOpPeGcgfUrvMAcFIl15qQSBQSC47wNkrDbtw5tIeRGhfGhMR+X1IiS2W4aGr+RVaKm7huC3WP4eYgFQY+qZCnx3GyrIDy88biAZ3T1pKqcS0mWFKKiYXynM56aMGwJoNTyei6fT6LpsB+K0Q2nfa3RA1uBC9CkAKiEkH2K49cO3vDFASWRq7WgYKmwqTc/lzgKlCdFaDOY0kjlXCBH20VMaaVu25Se3ynk+hNLPHkxm1qHMyD4h8KpWBfQN1psQSyAAPzk2TxPQdj9rkmkN9lk/nYLgxvZypvwTwpYXp++h9dWz98JEYTamVytY/wmpvZL9t1RmTFBbIw2vn5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGV/IXcrftXn1L+wL36S4obzNDA5llQizVAfX1eQcyU=;
 b=cmT0FEkxTVVxeSgubqG29l2YU2HDx1AO0piB8D5T5S1L8yHMDhnyk+758mgLrkR3krpnzq3fQwsp27TYzl1i6WtEWIIeWQrd67bBYg8U34Zb7YtijTrYi7curqXGJVFWlPoojjgG/BMqJLSthaNY1R4h/h20+URpclVzFeNN8nDAytavkAmSzm0uHWbYz5ORZZsxcf/V6hJnHpPRMjHaMuJ+lgy1MEDH728kOrOJWXXwheKeeHloXh0P5OH/XmlQasIfhmpO2CJ3ipSEK9P+ALI6J+k1e/IqSeVxUd3xDTWdfeUSEcmDV4acBkG5/1f4Og36L8cvEeVZuBi0T760Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGV/IXcrftXn1L+wL36S4obzNDA5llQizVAfX1eQcyU=;
 b=JOYRHOI8y+a3mqrXiMtqyaWNPu7n9pdzMw/EeGVkEKRfYVvCr+CNGpVS8HjPcOsjZwX8vG5XQhIIZUtdLn1O1vjG3HnhlgZQKTqULFa+CR21N9hEAqB+RplFVCpf03jtD/flwGqXmApYeIBb1TKqhTFxw8HX/a7iG4AtM9/4jmM=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MWHPR11MB1646.namprd11.prod.outlook.com (2603:10b6:301:c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 10 Dec
 2020 01:22:27 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f%4]) with mapi id 15.20.3632.018; Thu, 10 Dec 2020
 01:22:27 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 01/16] dt-bindings: dma: Add YAML schemas for
 dw-axi-dmac
Thread-Topic: [PATCH v5 01/16] dt-bindings: dma: Add YAML schemas for
 dw-axi-dmac
Thread-Index: AQHWx2fKbqfRLAl8MEqd0Cuha40uEqnuI3UQgAFzNyA=
Date:   Thu, 10 Dec 2020 01:22:27 +0000
Message-ID: <CO1PR11MB502699E1F6DA186CEEF5B287DACB0@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201123023452.7894-1-jee.heng.sia@intel.com>
 <20201123023452.7894-2-jee.heng.sia@intel.com>
 <20201130222547.GA3123716@robh.at.kernel.org>
 <CO1PR11MB5026A74BFCC2C4896C0294B0DACC0@CO1PR11MB5026.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB5026A74BFCC2C4896C0294B0DACC0@CO1PR11MB5026.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1ef3207-0e03-4048-7d52-08d89caa0e6c
x-ms-traffictypediagnostic: MWHPR11MB1646:
x-microsoft-antispam-prvs: <MWHPR11MB1646BE10FA06C81585999C24DACB0@MWHPR11MB1646.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qJxJvvae2Z3emORLqBiTdmVnEDZgujz20enWhpg223Wep4UZDQAlvsbN1ZbUpUUsFQPzdLZZutTWlIwLd195KjruFwZ1/nTQwjFkZ/WCpWTEjIK4HiBYFnQ04Ahs3QvahY/1CMJ9XHKiaO9RPhomCxPFyXHaZOHtm0SfArT87mYsrAH9KeHBPpDcg9kraeuWl++AtUg5u/cqVAINS83j9VCHfhJ5xQiQJfQOCLzZr12R55BlJ6Cj/aMnRp5IFnbb8VEsxpSHL+Ia0yJR/Uiy+EF6r4vqF8u8qZJ1McaTmKzZez2S6cNVNAOeqbMQf6WCYZ1ci/eoXJDws8d54LSoBae8cWVfK6oH8ZYRbm2cM3mzn5i622ryw7s82cSOlqVnW/6PwGmEtI3hCYpVD93Bkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(9686003)(26005)(55016002)(53546011)(33656002)(6916009)(508600001)(8936002)(7696005)(66446008)(54906003)(966005)(186003)(6506007)(66556008)(76116006)(5660300002)(52536014)(86362001)(64756008)(83380400001)(2906002)(66476007)(71200400001)(8676002)(66946007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WOep0/+1iIhNbosAlwgVz9590GWDHC3UzVkBrGGv4JFOELtoCLOiArruBYKP?=
 =?us-ascii?Q?LJclJUJzh31w7AqLt5Obo2i0MGuD1O8oynt2QjZjn99hq5TIzWiIiByHLLTm?=
 =?us-ascii?Q?Yo6oeTiRSjKLJzgGZrGW1aJaaeJfu8NhJ9Ga9Z172f7YCCOX4dT3agsqDatb?=
 =?us-ascii?Q?KCa6iQPTYTTURR2BsrSwfxBx/LeTm5EeVEZQJzHstbJQFptkopTOfNpXLiJh?=
 =?us-ascii?Q?fPpcavNe+kZa8vZP+pQcNDcX6l9u0miQQ2n1mmRAa4HSy7lR5rguSzsfJPmJ?=
 =?us-ascii?Q?lkXGO9rU+Uqbdxz+ebV5dJPYYoqdzzIv2CdKc0pFVyMkU4tWFzH2auZpoubA?=
 =?us-ascii?Q?oaffgGtlVRH6jm829+4rfDf59MtEzEvNqDfjAkUylQ4tr7iIif17+Huhw/Sm?=
 =?us-ascii?Q?leR6wA2gP26oi1SwSV9J5LliWIQOS1oZ/cA8+N2Ksq67xdwm+GRsl9Vi4Xfy?=
 =?us-ascii?Q?0ml04eeU8B/o44YEVV9LjVGTIeXpA/9cqEnhrdBP2If43MpIqQ3VlP730SlJ?=
 =?us-ascii?Q?aOBBdRRoz09T2Q1PjpMA0t5D7/YDGLdqyEtpBFo47oP87qGYGWvsMTaPkIMo?=
 =?us-ascii?Q?0EHgrNLYcLkkxO30j9a8joMM44fPIAS2c+cZ2EhtNbXB5P1KTqog8gi4wvPi?=
 =?us-ascii?Q?QuZiJxrVrTEU3qt3S8yn+gQ6F3Q4w6aJO6LL151HwaHC1+HHrnzV+d+9SnuK?=
 =?us-ascii?Q?HKDk5KZRAZXzvYgo8nVjI1P9PGAd+w72lubcxHZm6ikDTBg6TnwZYNav5Rdx?=
 =?us-ascii?Q?VtYFOS8x0X/Bnb+FCHH0Lbcy8p5CE+qIYPwNOCf0uSip9BxyN91r/GSSxG1Q?=
 =?us-ascii?Q?JhVzHqyeO7HS8YbBoZG284bGnrOV35kcTfxgQ98G60+rIndlSXQ1muePGu/j?=
 =?us-ascii?Q?7orEaPUIuK2XaVfr4r0fH4B8VpxzXwN0IN8CGxGbAn7JeVuYVtjVLzixUaEm?=
 =?us-ascii?Q?7i4JX20jrGLe8P3C22AxHYNni1c/BN24LCilU+rlW5I=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ef3207-0e03-4048-7d52-08d89caa0e6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 01:22:27.2114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wO8HuLQ/bW/idxrsPAJqN33U2nYYGkPnL0t8fSWiJQT3eDYo9rF4wDDpuioIbSWiOERYjgyB/ITdo7tM/qwFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1646
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

I think I still need the 'ref', but can remove the 'allOf'.=20

Thanks
Regards
Jee Heng

> -----Original Message-----
> From: Sia, Jee Heng
> Sent: 09 December 2020 11:21 AM
> To: Rob Herring <robh@kernel.org>
> Cc: vkoul@kernel.org; Eugeniy.Paltsev@synopsys.com;
> andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: RE: [PATCH v5 01/16] dt-bindings: dma: Add YAML schemas
> for dw-axi-dmac
>=20
> Hi Rob,
>=20
> Regarding the comment " You don't need to use allOf with a $ref
> anymore."
> I get dt compile error after remove the allOf and $ref. Error message
> shown below:
>                 '$ref' is a required property
>                 'allOf' is a required property
>=20
>   snps,dma-masters:
>     description: |
>       Number of AXI masters supported by the hardware.
>     enum: [1, 2]
>     default: 2
>=20
> Thanks
> Regards
> Jee Heng
>=20
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: 01 December 2020 6:26 AM
> > To: Sia, Jee Heng <jee.heng.sia@intel.com>
> > Cc: vkoul@kernel.org; Eugeniy.Paltsev@synopsys.com;
> > andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> > Subject: Re: [PATCH v5 01/16] dt-bindings: dma: Add YAML schemas
> for
> > dw-axi-dmac
> >
> > On Mon, Nov 23, 2020 at 10:34:37AM +0800, Sia Jee Heng wrote:
> > > YAML schemas Device Tree (DT) binding is the new format for DT
> to
> > > replace the old format. Introduce YAML schemas DT binding for
> > > dw-axi-dmac and remove the old version.
> > >
> > > Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> > > ---
> > >  .../bindings/dma/snps,dw-axi-dmac.txt         |  39 ------
> > >  .../bindings/dma/snps,dw-axi-dmac.yaml        | 126
> > ++++++++++++++++++
> > >  2 files changed, 126 insertions(+), 39 deletions(-)  delete mode
> > > 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-
> > dmac.txt
> > >  create mode 100644
> > > Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> > > b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> > > deleted file mode 100644
> > > index dbe160400adc..000000000000
> > > --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-
> > dmac.txt
> > > +++ /dev/null
> > > @@ -1,39 +0,0 @@
> > > -Synopsys DesignWare AXI DMA Controller
> > > -
> > > -Required properties:
> > > -- compatible: "snps,axi-dma-1.01a"
> > > -- reg: Address range of the DMAC registers. This should include
> > > -  all of the per-channel registers.
> > > -- interrupt: Should contain the DMAC interrupt number.
> > > -- dma-channels: Number of channels supported by hardware.
> > > -- snps,dma-masters: Number of AXI masters supported by the
> > hardware.
> > > -- snps,data-width: Maximum AXI data width supported by
> hardware.
> > > -  (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
> > > -- snps,priority: Priority of channel. Array size is equal to the
> > > number of
> > > -  dma-channels. Priority value must be programmed within
> > > [0:dma-channels-1]
> > > -  range. (0 - minimum priority)
> > > -- snps,block-size: Maximum block size supported by the controller
> > channel.
> > > -  Array size is equal to the number of dma-channels.
> > > -
> > > -Optional properties:
> > > -- snps,axi-max-burst-len: Restrict master AXI burst length by value
> > > specified
> > > -  in this property. If this property is missing the maximum AXI
> > > burst length
> > > -  supported by DMAC is used. [1:256]
> > > -
> > > -Example:
> > > -
> > > -dmac: dma-controller@80000 {
> > > -	compatible =3D "snps,axi-dma-1.01a";
> > > -	reg =3D <0x80000 0x400>;
> > > -	clocks =3D <&core_clk>, <&cfgr_clk>;
> > > -	clock-names =3D "core-clk", "cfgr-clk";
> > > -	interrupt-parent =3D <&intc>;
> > > -	interrupts =3D <27>;
> > > -
> > > -	dma-channels =3D <4>;
> > > -	snps,dma-masters =3D <2>;
> > > -	snps,data-width =3D <3>;
> > > -	snps,block-size =3D <4096 4096 4096 4096>;
> > > -	snps,priority =3D <0 1 2 3>;
> > > -	snps,axi-max-burst-len =3D <16>;
> > > -};
> > > diff --git
> > > a/Documentation/devicetree/bindings/dma/snps,dw-axi-
> dmac.yaml
> > > b/Documentation/devicetree/bindings/dma/snps,dw-axi-
> dmac.yaml
> > > new file mode 100644
> > > index 000000000000..6c2e8e612af5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-
> > dmac.yaml
> > > @@ -0,0 +1,126 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> %YAML
> > 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/dma/snps,dw-axi-
> dmac.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Synopsys DesignWare AXI DMA Controller
> > > +
> > > +maintainers:
> > > +  - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com
> > > +
> > > +description: |
> >
> > Don't need '|' unless there's formatting to preserve.
> >
> > > + Synopsys DesignWare AXI DMA Controller DT Binding
> >
> > And should be 2 space indent.
> >
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - snps,axi-dma-1.01a
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: Address range of the DMAC registers
> >
> > Just 'maxItems: 1'
> >
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: axidma_ctrl_regs
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: Bus Clock
> > > +      - description: Module Clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: core-clk
> > > +      - const: cfgr-clk
> > > +
> > > +  '#dma-cells':
> > > +    const: 1
> > > +
> > > +  dma-channels:
> > > +    description: |
> > > +      Number of channels supported by hardware.
> >
> > No need to describe a common property. You do need to provide
> some
> > constraints. I'd assume there's less than 2^32 channels.
> >
> > > +
> > > +  snps,dma-masters:
> > > +    description: |
> > > +      Number of AXI masters supported by the hardware.
> > > +    allOf:
> >
> > You don't need to use allOf with a $ref anymore.
> >
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - enum: [1, 2]
> > > +        default: 2
> > > +
> > > +  snps,data-width:
> > > +    description: |
> > > +      AXI data width supported by hardware.
> > > +      (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - enum: [0, 1, 2, 3, 4, 5, 6]
> > > +        default: 4
> > > +
> > > +  snps,priority:
> > > +    description: |
> > > +      Channel priority specifier associated with the DMA channels.
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +      - minItems: 1
> > > +        maxItems: 8
> > > +        default: [0, 1, 2, 3]
> > > +
> > > +  snps,block-size:
> > > +    description: |
> > > +      Channel block size specifier associated with the DMA
> channels.
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +      - minItems: 1
> > > +        maxItems: 8
> > > +        default: [4096, 4096, 4096, 4096]
> > > +
> > > +  snps,axi-max-burst-len:
> > > +    description: |
> > > +      Restrict master AXI burst length by value specified in this
> > property.
> > > +      If this property is missing the maximum AXI burst length
> > supported by
> > > +      DMAC is used. [1:256]
> >
> > Looks like some constraints.
> >
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +        default: 16
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - clock-names
> > > +  - interrupts
> > > +  - '#dma-cells'
> > > +  - dma-channels
> > > +  - snps,dma-masters
> > > +  - snps,data-width
> > > +  - snps,priority
> > > +  - snps,block-size
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +     #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +     #include <dt-bindings/interrupt-controller/irq.h>
> > > +     /* example with snps,dw-axi-dmac */
> > > +     dmac: dma-controller@80000 {
> > > +         compatible =3D "snps,axi-dma-1.01a";
> > > +         reg =3D <0x80000 0x400>;
> > > +         clocks =3D <&core_clk>, <&cfgr_clk>;
> > > +         clock-names =3D "core-clk", "cfgr-clk";
> > > +         interrupt-parent =3D <&intc>;
> > > +         interrupts =3D <27>;
> > > +         #dma-cells =3D <1>;
> > > +         dma-channels =3D <4>;
> > > +         snps,dma-masters =3D <2>;
> > > +         snps,data-width =3D <3>;
> > > +         snps,block-size =3D <4096 4096 4096 4096>;
> > > +         snps,priority =3D <0 1 2 3>;
> > > +         snps,axi-max-burst-len =3D <16>;
> > > +     };
> > > --
> > > 2.18.0
> > >
