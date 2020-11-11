Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFAE2AE5E3
	for <lists+dmaengine@lfdr.de>; Wed, 11 Nov 2020 02:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbgKKBgv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 20:36:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:7621 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731657AbgKKBgv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Nov 2020 20:36:51 -0500
IronPort-SDR: 5uExQCmq21NZSjhGuXSTUMFv6KXbj9Z6n+1deuTYaJ1a3s+uOiGbslXDtAtLoLaIkyMrjqXucc
 YIayPIlYzAIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="170236267"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="170236267"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 17:36:50 -0800
IronPort-SDR: V75zVzrxZflfjwgblQfn1EFEnFo3u+k7+4UeEUR5DF1GEe7rFuI4dOogDF8MPWZo9kifP4Klt2
 J1E2zd0b/nfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="327907542"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2020 17:36:50 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 17:36:49 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Nov 2020 17:36:49 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 10 Nov 2020 17:36:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqPhvmb9e63L1d7/d0tBmAUL725mwhu3tei8iP5ePomCbPBEpgiolLAge3ZRavnkD2pC9oVbZiAb4UaSGbCczdWL/UR/uq4A+aOeE2qukEIVWOSmoDo5bbi8dbes4ylh/lcaVhcrhHU/2CWX1PdVTBaTnhAm//4An0pBqctgm8G01EMnPkVwBBURPz3TT2yjHG3XN/xKDc8E9hW4eWuIqqhLrPGce7NNLd+yYB1+hIOm4+WWWW/HhTo1FVdAsQ1beejZD4bhj+70LBIZFPWjbeZP+eHh2o5VxZJDW2MTY43qYDSl4QeomkGlXNTHgyOU5Y/jyYkAAbPfja7w0gK02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+IsKPvNjerszLwlCqGA355Xu+TbMJgXxyEgKQDIgmY=;
 b=WLIuvnPUw4O8jVUxFNhkpo4ZeHI2DofsEDTMYOp8pl3TTRazJBfsQDm+jKdS9/NWkixZk/HTh6oCr4+MQXgHUAwWVkPHF3wci/oO9L4J+RNgcmwYWNHCc8pR8lF5hMaMLOsM1+O7RGk5hIItxONAJ9bTLPAqu1vs+LTmvTnb3Y5s8BA0vr/Rdx81JES9RUoeZLTgoKpKJwNfiboxPnbIjxEM5vRMUtRIDZlvRiz827OvGws0SZJcM3c0u2NcwcGS6fBF4751456l0zC4smoN9guRB/beGR+o/cAIP7OSm7By5M/BwFtxpccHICPZ9jGsqY3IkVW7DBW7yhbCzzFOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+IsKPvNjerszLwlCqGA355Xu+TbMJgXxyEgKQDIgmY=;
 b=is2/zpgrYTcN5pYUXmooD/WfMfsLotFrMhK1KpL+HEMlrEXckJPP98K5qPoXbZoOC7H7PIS/OfqQBgyEeXTu9wD0owR11RA4l4aDSvbvYpkTKIHxweY9+BegjhIsOjHavgX0ppQD5AKsRBYK5m8fbnyYfWGafj/4QP0jlyKBQ8w=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MWHPR11MB1806.namprd11.prod.outlook.com (2603:10b6:300:10e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 01:36:47 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::40d9:aa4b:73e7:3d60]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::40d9:aa4b:73e7:3d60%3]) with mapi id 15.20.3499.032; Wed, 11 Nov 2020
 01:36:47 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 01/15] dt-bindings: dma: Add YAML schemas for
 dw-axi-dmac
Thread-Topic: [PATCH v2 01/15] dt-bindings: dma: Add YAML schemas for
 dw-axi-dmac
Thread-Index: AQHWtnp3naUJQzS9J0iOWt5vJAFyWKnCKP8A
Date:   Wed, 11 Nov 2020 01:36:47 +0000
Message-ID: <CO1PR11MB5026F31F062C12D3358B2288DAE80@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201027063858.4877-1-jee.heng.sia@intel.com>
 <20201027063858.4877-2-jee.heng.sia@intel.com>
 <20201109092640.GB3171@vkoul-mobl>
In-Reply-To: <20201109092640.GB3171@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [175.142.41.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7488085-7aff-4f76-797d-08d885e24110
x-ms-traffictypediagnostic: MWHPR11MB1806:
x-microsoft-antispam-prvs: <MWHPR11MB18066F3D2CF0B7ED9F61DA67DAE80@MWHPR11MB1806.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HUp0JkV7SAr2Qatss5SVAzxUYjeXk0t7dyDAEQigumOxNeeKm85+oy/zRLLiyFTAzN+J/cAD4swsdIeaoXi/BpYc32dpPO9hh8s7EFzabRfncKjqcmBbQlxdy4THKzsZ/W6j9VbY5OeIXyzRqp9mhJNW6BO3GKgOho3VULCbQrmhdwH45fcJ0gI8YsSEGOwJzcX9PVZmEgn56o3itbBvDB/mUsyi5EZcZHqJ5SAYsoFPhmBqXRqujxWvrhD/Kb7XTOGxHZlRgxQzwlTF95jZGEeyFv8vCuqP2TUABLCQvxGkMpxdbw7TdfQGUnHC/e+u79Q6+C9sFe9eQwBW8ym9YzCTzBF+unSWoxre1ZJ17kXg9nV83pHkc8qcYDrbH+YkBnwRpO1h0A7cZye3AxxPHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(186003)(55016002)(4326008)(9686003)(52536014)(316002)(64756008)(66476007)(966005)(66946007)(66446008)(71200400001)(66556008)(76116006)(54906003)(33656002)(26005)(8936002)(6916009)(8676002)(7696005)(5660300002)(478600001)(6506007)(53546011)(83380400001)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lMGxxXNZ5ey3FBsTUYVXep5H1cwL10ug/RGqSWTFiahfyzD9W/t5CaPQ8Ugzmry+MjSJr6JRa08mCaYn4l/f8bn641VWUpIZExtKqrym2F2hMCz/zMGdL+1wLBLQ96Pa/jYzsB5MSS3JL1sT6kfy9Y3i9wxmpks96W2jyIa5tas8FeoV8p+D8hW1cI95RdJUko3LY1CBB2pgP2UBeyaZFq0QNv24kBInCEIgahHyZiJy2yEtyyBGczIz+YoPdb2PkhlQD7vfDV3UYL5PPw53uyIDitsXTinchHxQe2Ri3f04vGBlUJ0/yQun1ot5gCV/dRtNh8CzMxU32oy0jOvQPahCo/utQQhVo3NYErpthCTgHqohm9lQejDqnfcnoBbBNJbrt/iNkrqQFcLfM69JJu3ZdXRpH3ALgt1wtCaetGV16bihLZjWSIZD3eijhH3YmoV7cx4A9vrA9cNWmcGzk0uiAN+GABctmYnUKlMNuqSok1hUsVW/782xkeetrVCqlVEh1r7s04aSvxE4N4xKAGIESWzxxDfzUfmUugvopfxSYoE9/R4a9dysFPve67e4SwXbnc4C7sJrGtdWIO2rVuCvmvgJUtLDrzc+4ZenPWgh5vAwMJH/qwWbQOSs68I+qeWZ2SHQqWiZOacqpKvp2Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7488085-7aff-4f76-797d-08d885e24110
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 01:36:47.1068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYnv03Vq24Z5d5hOwOrI9PhSQVLXzdrHVLhXCmENESRadVClE0c0V98xI/v1e+TltOIFiV7Yg7xRHpYrF3MsUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1806
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: 09 November 2020 5:27 PM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: Eugeniy.Paltsev@synopsys.com; andriy.shevchenko@linux.intel.com;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 01/15] dt-bindings: dma: Add YAML schemas for dw-a=
xi-
> dmac
>=20
> On 27-10-20, 14:38, Sia Jee Heng wrote:
> > YAML schemas Device Tree (DT) binding is the new format for DT to
> > replace the old format. Introduce YAML schemas DT binding for
> > dw-axi-dmac and remove the old version.
>=20
> I see that Rob and DT folks have not been cced, please do so
[>>] ok, I will add them starting v3.
>=20
> >
> > Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> > ---
> >  .../bindings/dma/snps,dw-axi-dmac.txt         |  39 ------
> >  .../bindings/dma/snps,dw-axi-dmac.yaml        | 124 ++++++++++++++++++
> >  2 files changed, 124 insertions(+), 39 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> > b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> > deleted file mode 100644
> > index dbe160400adc..000000000000
> > --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
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
> > -- snps,dma-masters: Number of AXI masters supported by the hardware.
> > -- snps,data-width: Maximum AXI data width supported by hardware.
> > -  (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
> > -- snps,priority: Priority of channel. Array size is equal to the
> > number of
> > -  dma-channels. Priority value must be programmed within
> > [0:dma-channels-1]
> > -  range. (0 - minimum priority)
> > -- snps,block-size: Maximum block size supported by the controller chan=
nel.
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
> > index 000000000000..e688d25864bc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > @@ -0,0 +1,124 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
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
> > + Synopsys DesignWare AXI DMA Controller DT Binding
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - snps,axi-dma-1.01a
> > +
> > +  reg:
> > +    items:
> > +      - description: Address range of the DMAC registers.
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
> > +
> > +  snps,dma-masters:
> > +    description: |
> > +      Number of AXI masters supported by the hardware.
> > +    allOf:
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
> > +      Restrict master AXI burst length by value specified in this prop=
erty.
> > +      If this property is missing the maximum AXI burst length support=
ed by
> > +      DMAC is used. [1:256]
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
>=20
> Pls add  additionalProperties: false and run latest dt schema tool from R=
ob
[>>] ok. Will add it in v3
>=20
> --
> ~Vinod
