Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60F82D3935
	for <lists+dmaengine@lfdr.de>; Wed,  9 Dec 2020 04:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgLIDWM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 22:22:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:52693 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgLIDWL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 8 Dec 2020 22:22:11 -0500
IronPort-SDR: y4mIc8hzQmgekU83paqxMqKkSP0wlzkKq6Z3v4tVNhqtgHgXsrIMyM2WfSiJsFbsPQvZ08XbD/
 pPJ4ve8sv3lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="170501112"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="170501112"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 19:21:30 -0800
IronPort-SDR: odtRbVqNRajcnRrphupOd02Kr1gXhZRcFVsJpacrP4mcRhYBNQFHuHCaEi2IVeIpFCm2sCxDLh
 ZskE2UEe9NPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="318098388"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga008.fm.intel.com with ESMTP; 08 Dec 2020 19:21:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Dec 2020 19:21:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 8 Dec 2020 19:21:29 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 8 Dec 2020 19:21:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyOmXM65fqDj0sxSAjHkUJ1rLTvOnQkj5MyYE98ffoWftPypWs2fI5+M/AvgAdZuYKGObgpb03l3vuqTeMaQr0QUVEdFdDT/iZiv7UGRDUcQGfqubXiX2rvvMEtln/HKZ4Ds7gazLuvaZ+5g2oOwwiAN3Z4TFTvXxt4Sm5wMwvxkEOWsWHPcFhnjJa0klAHgN8o5nd1cCpK5fDMOfxlXeBo85jEJHekLnWNf6oOKtAgPTRxR/LDTWuT5juN+rGN00WXamdvvLr0O/XL8Ss27t1PeJmyTxi60TBp+n5r+EnB7o128o0FaXtouRwMA9c3Dz0p5g8NyyuqdvDGKypYo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZgMrDHaBSXbMYYOYxYHLe5Km4MjFjxkTh6uJFkFOts=;
 b=ViSUhj2C3DW4Sjm6FQNWI1+ZnEJ7rypBYMmg41PKYvW1gb/lBWF5G2WcUGvjUzdAjwMJqTEPyFvQHZVaZTd0teGZIS8xZqTbgiXCdB9oJHyzBR1HhrWVS+VPPAiEP7qavARen0aZVA7AkGAAy0gA4kfke/5nkZHuqgEvzk9WQ4zvkXwQY4BQUwkVKT7ftO4dd6XK8XXqhqamZZvyMwsLBcVYMmDFFOgZjhzFNHUUNvqS1U4v+qiNqdQwNOXcEHYW6lku6PZlmCdOTxXk4fQ3k4lbFC1/mt5TGN64KwJ89//xmxRF9Sp8pq+h9WXYDiWerkiaSKtARZxuHHfcUu4qDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZgMrDHaBSXbMYYOYxYHLe5Km4MjFjxkTh6uJFkFOts=;
 b=hVqJlI3i1I4G6RWyvbWxK/74Zuh9kopekzPzMNNxPSNHMbAAAMyAWah0xYCtw5LxTQsDX5+DuK2AwsrXlFgJKjmuH06MBS6PO/A+4uYBkbm2vLGZnBjx+1leyw9Jbybk/5rpiRxs0c5MpdmfAyy/TBaj6hC46n3bI7sKHFM1GYg=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by CO1PR11MB5187.namprd11.prod.outlook.com (2603:10b6:303:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 03:21:11 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f%4]) with mapi id 15.20.3632.018; Wed, 9 Dec 2020
 03:21:11 +0000
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
Thread-Index: AQHWx2fKbqfRLAl8MEqd0Cuha40uEqnuI3UQ
Date:   Wed, 9 Dec 2020 03:21:11 +0000
Message-ID: <CO1PR11MB5026A74BFCC2C4896C0294B0DACC0@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201123023452.7894-1-jee.heng.sia@intel.com>
 <20201123023452.7894-2-jee.heng.sia@intel.com>
 <20201130222547.GA3123716@robh.at.kernel.org>
In-Reply-To: <20201130222547.GA3123716@robh.at.kernel.org>
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
x-ms-office365-filtering-correlation-id: 50b6fe97-1d63-478d-95f7-08d89bf17a3e
x-ms-traffictypediagnostic: CO1PR11MB5187:
x-microsoft-antispam-prvs: <CO1PR11MB5187F80D9EAE7DE31C3E2EDDDACC0@CO1PR11MB5187.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RWpiNwLHWOxQ4ggeX/tSYrgfhnrw2vefC5qjGURd6jKJwp4ChYFCJNUQPu35zSwJheYTPXAQH6lbceLKMcWbG1QkbFDaHSKo17gTkUg38Zx3R7E9ddj2u9pAjp/sDoD2DWqL41VvzcxiJbgH2VkKylKvpOS3LJUqQUMRG8rr/2Aer9DLbFLvYyCNam2drDxtGhI2v6aJRsO1p8Zusr0ZbUy84VsSeC3jlMgSjFDBqnsAo5YxThhAwPWTlsSSK4DWUXjF74e7nx9gEBWynGNpJvldfFWeuHrAAJHFaExzGoVz0r7IIOX89gosOo3NvLZuOYsVSnzevzu6K8vIHQpSSc/AKoZBpmx/6iAcNu0pyV/d3GAWC5z2R+tAWt552FVk5npJooxwSHjC3uaVU29ZGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(7696005)(186003)(71200400001)(66446008)(4326008)(2906002)(5660300002)(83380400001)(55016002)(6506007)(8936002)(54906003)(66476007)(86362001)(33656002)(53546011)(76116006)(508600001)(6916009)(66556008)(52536014)(64756008)(66946007)(966005)(8676002)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Sqv93hbyevnmuG8HYe72MUNIEDji28J8YMV5b/P7T7bE3w9B5E/8pjluswDA?=
 =?us-ascii?Q?iU/3Vv4GWv89pm2MdQzM6rCaW0XAgGiwDAW7ddzDMzmeTj9rlTVOym/wzSpU?=
 =?us-ascii?Q?Qmq93M1vXJCjIkSnvF4d5pbismcGtc0Bd9UrpXk1ZB/LZsWw78MUxW+zszbz?=
 =?us-ascii?Q?agaqvQXKXZvLYuwVkxAwcegdMo80kH1H4GQn110XNShBMHZ19Rr4gbz4HV/W?=
 =?us-ascii?Q?fJk1qI9K5va/kUsA/zm+GGoR/8F+zyZyH6eSUjvoznV75xxH4CN4AR5vxNHM?=
 =?us-ascii?Q?HX89GEP8RXFh0QufhDQd0LaGpxbjLTxyv3BB4U0Za+MquNscUc837RqijsOW?=
 =?us-ascii?Q?g5aOft1xm3sEfILReSFehVEBE7ipIFupyWIQ/7ZJpRrkTzd9eF1fYMcb5ah/?=
 =?us-ascii?Q?MJ0hIhk7DcL3/dF77rbzvpk0wIkzrwKmiugTBQfmp0LSuTWyiloV7JmpkPIf?=
 =?us-ascii?Q?3HmKwwE641Sdz2KjmjB19AD9VGxHReRX9OVBwZRLywYqDejpBfchhf3lwjYv?=
 =?us-ascii?Q?dy9ftsdFmdDBCD6rlDFQ/S6oYyo4dapowLiI5/JL9S6/g8N/7QDx5y30yuBJ?=
 =?us-ascii?Q?6omROC5Qb3wXQJtM7yL7efB+1Q2h5SY1gzsAoh6WYeS8RMp1U7TyM2Qzr869?=
 =?us-ascii?Q?I1Tqgxjco4LnAndUfodTmL/GxMTk9ibUJ57ODQ3LOounhxXKdds5/7cfvmmB?=
 =?us-ascii?Q?PfZ46kCin4qWPboE/LgTQ/39fBbdClkO8YLAl77ox2ea8El3d42NyBUD2wbK?=
 =?us-ascii?Q?igC8iE3T5OCqluLCS2kn7IfRax6xgjHr2IVlupLDg/nENJDpe2zp0VKt8ktc?=
 =?us-ascii?Q?qRH/m0oPTliuxxD3P52R8OB51N7cb2I+OER20ZJT8BYtJEFHnw8jIPD/0PIh?=
 =?us-ascii?Q?Fkk4plmM5Oruc8P4YTMpZg8/RlkgNjewsN5U/kDlhH+/Czi/v0R7enOTDg3/?=
 =?us-ascii?Q?Ez5BPNzDWeBuEqcqK1MF7PR5DjaDlXsee3KXe+ClGlM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b6fe97-1d63-478d-95f7-08d89bf17a3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 03:21:11.2066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPG4ym56OjLCoXQi53kGwbwFsyb/QustxP6eVob5xE2ISSoX0n3PSBNzf3zVGJT6VuYMjSpJty7xDl0xRMtt0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5187
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

Regarding the comment " You don't need to use allOf with a $ref anymore."
I get dt compile error after remove the allOf and $ref. Error message shown=
 below:
                '$ref' is a required property
                'allOf' is a required property

  snps,dma-masters:
    description: |
      Number of AXI masters supported by the hardware.
    enum: [1, 2]
    default: 2

Thanks
Regards
Jee Heng

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 01 December 2020 6:26 AM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: vkoul@kernel.org; Eugeniy.Paltsev@synopsys.com;
> andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v5 01/16] dt-bindings: dma: Add YAML schemas
> for dw-axi-dmac
>=20
> On Mon, Nov 23, 2020 at 10:34:37AM +0800, Sia Jee Heng wrote:
> > YAML schemas Device Tree (DT) binding is the new format for DT to
> > replace the old format. Introduce YAML schemas DT binding for
> > dw-axi-dmac and remove the old version.
> >
> > Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> > ---
> >  .../bindings/dma/snps,dw-axi-dmac.txt         |  39 ------
> >  .../bindings/dma/snps,dw-axi-dmac.yaml        | 126
> ++++++++++++++++++
> >  2 files changed, 126 insertions(+), 39 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-
> dmac.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> > b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> > deleted file mode 100644
> > index dbe160400adc..000000000000
> > --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-
> dmac.txt
> > +++ /dev/null
> > @@ -1,39 +0,0 @@
> > -Synopsys DesignWare AXI DMA Controller
> > -
> > -Required properties:
> > -- compatible: "snps,axi-dma-1.01a"
> > -- reg: Address range of the DMAC registers. This should include
> > -  all of the per-channel registers.
> > -- interrupt: Should contain the DMAC interrupt number.
> > -- dma-channels: Number of channels supported by hardware.
> > -- snps,dma-masters: Number of AXI masters supported by the
> hardware.
> > -- snps,data-width: Maximum AXI data width supported by hardware.
> > -  (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
> > -- snps,priority: Priority of channel. Array size is equal to the
> > number of
> > -  dma-channels. Priority value must be programmed within
> > [0:dma-channels-1]
> > -  range. (0 - minimum priority)
> > -- snps,block-size: Maximum block size supported by the controller
> channel.
> > -  Array size is equal to the number of dma-channels.
> > -
> > -Optional properties:
> > -- snps,axi-max-burst-len: Restrict master AXI burst length by value
> > specified
> > -  in this property. If this property is missing the maximum AXI burst
> > length
> > -  supported by DMAC is used. [1:256]
> > -
> > -Example:
> > -
> > -dmac: dma-controller@80000 {
> > -	compatible =3D "snps,axi-dma-1.01a";
> > -	reg =3D <0x80000 0x400>;
> > -	clocks =3D <&core_clk>, <&cfgr_clk>;
> > -	clock-names =3D "core-clk", "cfgr-clk";
> > -	interrupt-parent =3D <&intc>;
> > -	interrupts =3D <27>;
> > -
> > -	dma-channels =3D <4>;
> > -	snps,dma-masters =3D <2>;
> > -	snps,data-width =3D <3>;
> > -	snps,block-size =3D <4096 4096 4096 4096>;
> > -	snps,priority =3D <0 1 2 3>;
> > -	snps,axi-max-burst-len =3D <16>;
> > -};
> > diff --git
> > a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > new file mode 100644
> > index 000000000000..6c2e8e612af5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-
> dmac.yaml
> > @@ -0,0 +1,126 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/snps,dw-axi-dmac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Synopsys DesignWare AXI DMA Controller
> > +
> > +maintainers:
> > +  - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com
> > +
> > +description: |
>=20
> Don't need '|' unless there's formatting to preserve.
>=20
> > + Synopsys DesignWare AXI DMA Controller DT Binding
>=20
> And should be 2 space indent.
>=20
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - snps,axi-dma-1.01a
> > +
> > +  reg:
> > +    items:
> > +      - description: Address range of the DMAC registers
>=20
> Just 'maxItems: 1'
>=20
> > +
> > +  reg-names:
> > +    items:
> > +      - const: axidma_ctrl_regs
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Bus Clock
> > +      - description: Module Clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: core-clk
> > +      - const: cfgr-clk
> > +
> > +  '#dma-cells':
> > +    const: 1
> > +
> > +  dma-channels:
> > +    description: |
> > +      Number of channels supported by hardware.
>=20
> No need to describe a common property. You do need to provide
> some constraints. I'd assume there's less than 2^32 channels.
>=20
> > +
> > +  snps,dma-masters:
> > +    description: |
> > +      Number of AXI masters supported by the hardware.
> > +    allOf:
>=20
> You don't need to use allOf with a $ref anymore.
>=20
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - enum: [1, 2]
> > +        default: 2
> > +
> > +  snps,data-width:
> > +    description: |
> > +      AXI data width supported by hardware.
> > +      (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - enum: [0, 1, 2, 3, 4, 5, 6]
> > +        default: 4
> > +
> > +  snps,priority:
> > +    description: |
> > +      Channel priority specifier associated with the DMA channels.
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > +      - minItems: 1
> > +        maxItems: 8
> > +        default: [0, 1, 2, 3]
> > +
> > +  snps,block-size:
> > +    description: |
> > +      Channel block size specifier associated with the DMA channels.
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > +      - minItems: 1
> > +        maxItems: 8
> > +        default: [4096, 4096, 4096, 4096]
> > +
> > +  snps,axi-max-burst-len:
> > +    description: |
> > +      Restrict master AXI burst length by value specified in this
> property.
> > +      If this property is missing the maximum AXI burst length
> supported by
> > +      DMAC is used. [1:256]
>=20
> Looks like some constraints.
>=20
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +        default: 16
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - '#dma-cells'
> > +  - dma-channels
> > +  - snps,dma-masters
> > +  - snps,data-width
> > +  - snps,priority
> > +  - snps,block-size
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +     #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +     #include <dt-bindings/interrupt-controller/irq.h>
> > +     /* example with snps,dw-axi-dmac */
> > +     dmac: dma-controller@80000 {
> > +         compatible =3D "snps,axi-dma-1.01a";
> > +         reg =3D <0x80000 0x400>;
> > +         clocks =3D <&core_clk>, <&cfgr_clk>;
> > +         clock-names =3D "core-clk", "cfgr-clk";
> > +         interrupt-parent =3D <&intc>;
> > +         interrupts =3D <27>;
> > +         #dma-cells =3D <1>;
> > +         dma-channels =3D <4>;
> > +         snps,dma-masters =3D <2>;
> > +         snps,data-width =3D <3>;
> > +         snps,block-size =3D <4096 4096 4096 4096>;
> > +         snps,priority =3D <0 1 2 3>;
> > +         snps,axi-max-burst-len =3D <16>;
> > +     };
> > --
> > 2.18.0
> >
