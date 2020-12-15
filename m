Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39592DA903
	for <lists+dmaengine@lfdr.de>; Tue, 15 Dec 2020 09:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgLOIJi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 03:09:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:64200 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgLOIJi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Dec 2020 03:09:38 -0500
IronPort-SDR: kiR0KP5n+IpCKISS9/4U3lPobBzMB6w5waNDTkSTPLjfIUkUpOTbPeMHlADCTzZcQyusw622++
 Ck94CSbxCBfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="174072158"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="174072158"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 00:08:57 -0800
IronPort-SDR: rhXizBFD8kpBoGibNJ8GBnLPC5a3d2UpDw07xsblWWGNbo5UQ9orp7ocJL3pB1BI7nLRDJ6VI/
 LGuBBMIq66lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="383291931"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2020 00:08:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 15 Dec 2020 00:08:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 15 Dec 2020 00:08:57 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 15 Dec 2020 00:08:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1fez52U1R59KVeMuqkOK1ekQcez17j7T7d8GAgWtoVOzU2gVu1e3d9VsfeAkGjfrZzDYMx2R/7LA2lHpxDxUpBtlp+u1nn9IJ1kSQPcuEiOMJpNt8KT6c1ZQK8LPa4gnha8LwXTDph9jF+X4MNuM138RP4uFx7MejHpnodS9ssyzfyoe6G/ziv+rkWtnGxLE5WDu0RJV4h0fs+tV61J4NBn/8w1ebDBCz0FY/ibj8bE26GLb8vmVTRS5+0kC64ej/Pflc0JJ64H0ONJqSBbc04N3pFQdTpF1GvvHmUsHTUkr9TCTEplbAUTNyfKjol/WZBfSZOROPBXD9GNvzg+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqP3iUJsRl9kNDMEYkOh72jcRH/hhzuvEBMvp02rL+Q=;
 b=HhqadDFFfCRZxzpLhZ6nGxiz5yjCtFY/2qCkdtXBUjbbA9aYZpEQ9cxnbkY5sTxR7sYyodZBA0KRwZ00lPkpVe7USKsuNx42trSzxyBR4WMj+IROfyLmWMO8MGYQRcF9Fkga/vvSGLgBgeKa7roybsG7bKx684n7mdE1jB8kxAlioEZiJPoI2VuyghS0LmYmYkcBEGaUtFeZwnakwGxWHL5hKxR2VbOZUBq/IKIfcm7mzEPiOeswR1urhls0a0ePLylq7Io30/+FdbJcKAYxfQBan2am75NrW+2LZjpBr44TAfUEXItxa5Ot8VfPGLUu3z8q554Cyj6jLPo9pnKaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqP3iUJsRl9kNDMEYkOh72jcRH/hhzuvEBMvp02rL+Q=;
 b=LJWERaN0bzEj6luSio+IG397BpLpZI4TysyyN/hK184eM5T3uyn5eBEq6YAP1CJ5iKC34XQJq1OSnrX1sYGrEqHPsU1/3YrTCJFwtizqY2T7QKuJgo8wfCFs7R6NvYUvtGREbbRQmm9HUxPOOpiq4Pj5by3une6o5ttOzkj+zOw=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MWHPR11MB1454.namprd11.prod.outlook.com (2603:10b6:301:d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 15 Dec
 2020 08:08:55 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f%4]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 08:08:55 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 01/16] dt-bindings: dma: Add YAML schemas for
 dw-axi-dmac
Thread-Topic: [PATCH v6 01/16] dt-bindings: dma: Add YAML schemas for
 dw-axi-dmac
Thread-Index: AQHW0mvNhKu2snl0SUeg5ahzlza7gan3yMHw
Date:   Tue, 15 Dec 2020 08:08:55 +0000
Message-ID: <CO1PR11MB50268AADBCB64D9B2C786EA7DAC60@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201211004642.25393-1-jee.heng.sia@intel.com>
 <20201211004642.25393-2-jee.heng.sia@intel.com>
 <20201214225211.GA2525287@robh.at.kernel.org>
In-Reply-To: <20201214225211.GA2525287@robh.at.kernel.org>
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
x-ms-office365-filtering-correlation-id: b1ab10e9-191b-4310-1db3-08d8a0d0ab32
x-ms-traffictypediagnostic: MWHPR11MB1454:
x-microsoft-antispam-prvs: <MWHPR11MB1454F00EB8753198C17D2E1BDAC60@MWHPR11MB1454.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9AYl/vzmVvzGp73VMuFe5UIfB3U4bMnE3sl+Twls9Ltp7dTvzfkLmHYBvZxhvSgqCVyUJPcMhp6H0XO6BkRhyNRW7a4Rzhve9nOA6mXBe4KHWMY1yTPiBlRs8C6o5XjsRdHRxCa95Zqy60dMg6T+Qq8JWMldk9n8xlSS9Al5eqFr0C8+vP6GwZADnwPvCktDzYJ3Ncp+j2aj3psaXH2OgLxNQLbsTaSEZG143fP9yxMrf2Tp6gooZ/gGpbxAcvV9SG29M3G4EyvLgIonJfgNeVDr1nm0eVzmDHj8MoztR/TmNYIH7nH/rxj3iUYiFUHT/Q+f08x7di88mLy+Ut+WsDqYxMDigFuow94P0Oa3JEaSQ+axL9Eoo8rnsKtr+psk/ZhwHO93XG7Zr5oEBPYGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(55016002)(2906002)(83380400001)(966005)(9686003)(26005)(76116006)(508600001)(4326008)(6506007)(53546011)(66476007)(86362001)(54906003)(6916009)(66556008)(5660300002)(7696005)(186003)(66446008)(71200400001)(8676002)(66946007)(52536014)(64756008)(8936002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gEMlwbcUAY200FUJTIfdvMIHOMHFuNqBnymklSWTHDT+Pv0DTFUBRgbwBUsE?=
 =?us-ascii?Q?yzGSYXTtU+zsUUTQVqMgXOmjp1hxYQM1G+wYU+itwd9wJC00y83G2QadgzfR?=
 =?us-ascii?Q?+XdUC/uuI++v3K2MXayKhJmU3c43GY96Nd+2e+ghLyBXYdMdOlHF0vq2StR1?=
 =?us-ascii?Q?Lm3ZM1+RU1H1W7o707YTwea4SsZWorzdr3zj3i0spMtZMPQjaYsXpF5Ily9b?=
 =?us-ascii?Q?woI0lMJNCB+oGo3hro8evzyZRPQBBc+PPDgQPDANga6hUoruNg1JwEl6xE1a?=
 =?us-ascii?Q?DY77iQ8oP0UHVfkMohxML0ThxCVR9ev0Bbh2JIz0GGODNy5tupKPcWJU2vd1?=
 =?us-ascii?Q?fkI1U/SJSOD6ZUFLRr5hM8NlAtbAhCgY8J4R/TDtmXACUEwWtUx4PaKbzMbs?=
 =?us-ascii?Q?2nGgNRlX36ZHA2fp2YfZ2pMeOZK4PskDBr955fEprV1EZJ1mZat2SRlHWNny?=
 =?us-ascii?Q?Z0FRV2V0a4gqvGhUfkmJHH8mlWwhy/EVwGVHjk3vnMtsTR4UVAF4pKvFBmAf?=
 =?us-ascii?Q?thJiqxdup7Da3X57CUiEAaK7Kl1PFUv0RZ3RpDk8j2QjuWdPKZlkrcWvMkOO?=
 =?us-ascii?Q?mzMowE4+97YQ0yH0rE9bcqMhSZgPvxbtPgdCSRRi2n4W50VpYPax7fFQhKsb?=
 =?us-ascii?Q?hvLQyC1lYTdZNCtD3Qco8OpkiT2gWrX/DwOw/tJ9+86cn3rYc8rUSj55bNPN?=
 =?us-ascii?Q?WZggaADDkMzAnQc8l/61zFQdNjVuTkZmeIB9N+Dyj3j+CrpXi/jNHbL4gTw5?=
 =?us-ascii?Q?Ile+C0b/h8zAqU8WzhFVX6KYE+eYo0YKY/nIprRij0fpdCNEHxgQxq09SDd1?=
 =?us-ascii?Q?8wto8xLVI9ZM/g8CPWtg40SmKzfTx9DFQ458ipqyZBWlbpo3kU/zOhO54gNc?=
 =?us-ascii?Q?28NpLO+V3glp0Ileu8litKe2Cb6zuz2OhM1vZnkVxApXUnmsP5ouTdr8JDIa?=
 =?us-ascii?Q?ksyRcQI/NuEl2rwA/pOlW9duLEU71C3sagGJyKJGzuA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ab10e9-191b-4310-1db3-08d8a0d0ab32
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 08:08:55.7610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kegkVAJM1Q1kSXAv5NuAyZDV54myqBZXFAkaE3jTKOzKZMlkfz5kIlr3vXliGmkCG/9mvOprzrjgAln982b83w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1454
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 15 December 2020 6:52 AM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: vkoul@kernel.org; Eugeniy.Paltsev@synopsys.com;
> andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v6 01/16] dt-bindings: dma: Add YAML schemas
> for dw-axi-dmac
>=20
> On Fri, Dec 11, 2020 at 08:46:27AM +0800, Sia Jee Heng wrote:
> > YAML schemas Device Tree (DT) binding is the new format for DT to
> > replace the old format. Introduce YAML schemas DT binding for
> > dw-axi-dmac and remove the old version.
> >
> > Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> > ---
> >  .../bindings/dma/snps,dw-axi-dmac.txt         |  39 ------
> >  .../bindings/dma/snps,dw-axi-dmac.yaml        | 125
> ++++++++++++++++++
> >  2 files changed, 125 insertions(+), 39 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-
> dmac.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>=20
>=20
> > diff --git
> > a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > new file mode 100644
> > index 000000000000..61ad37a3f559
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-
> dmac.yaml
> > @@ -0,0 +1,125 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/snps,dw-axi-dmac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Synopsys DesignWare AXI DMA Controller
> > +
> > +maintainers:
> > +  - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > +
> > +description:
> > +  Synopsys DesignWare AXI DMA Controller DT Binding
>=20
> allOf:
>   - $ref: dma-controller.yaml#
[>>] Thanks. Will include it in next version.
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
> Already described in dma-controller.yaml
[>>] Thanks. Will remove the description in next version but keep the const=
raint.
>=20
> > +    minimum: 1
> > +    maximum: 8
> > +
> > +  snps,dma-masters:
> > +    description: |
> > +      Number of AXI masters supported by the hardware.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 2]
> > +    default: 2
> > +
> > +  snps,data-width:
> > +    description: |
> > +      AXI data width supported by hardware.
> > +      (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3, 4, 5, 6]
> > +    default: 4
> > +
> > +  snps,priority:
> > +    description: |
> > +      Channel priority specifier associated with the DMA channels.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 1
> > +    maxItems: 8
> > +    default: [0, 1, 2, 3]
> > +
> > +  snps,block-size:
> > +    description: |
> > +      Channel block size specifier associated with the DMA channels.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 1
> > +    maxItems: 8
> > +    default: [4096, 4096, 4096, 4096]
> > +
> > +  snps,axi-max-burst-len:
> > +    description: |
> > +      Restrict master AXI burst length by value specified in this
> property.
> > +      If this property is missing the maximum AXI burst length
> supported by
> > +      DMAC is used.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 1
> > +    maximum: 256
> > +    default: 16
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - '#dma-cells'
>=20
> Already required.
[>>] Hope the comment "already required" is for the below properties.=20
>=20
> > +  - dma-channels
> > +  - snps,dma-masters
> > +  - snps,data-width
> > +  - snps,priority
> > +  - snps,block-size
>=20
> How can these be both required and have a default?
[>>] Thanks. Those are required properties, perhaps I should remove the def=
ault field to avoid misunderstanding.=20
>=20
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
