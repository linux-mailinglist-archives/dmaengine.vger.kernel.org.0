Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BD02B142C
	for <lists+dmaengine@lfdr.de>; Fri, 13 Nov 2020 03:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgKMCMe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Nov 2020 21:12:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:64228 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgKMCMe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 12 Nov 2020 21:12:34 -0500
IronPort-SDR: b8NHag+Yl4fwJEbXg+kbXUw32vA/UOUiBu38x5WQ1C4llqibfSq4R2VH/eRatGLpCZqQTTPJ6O
 NqRyZ/AkpmTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="255124140"
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="255124140"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 18:12:33 -0800
IronPort-SDR: lhQaDtiYD5QTwHsKDflNoO4Uf8hm9c3qI0Z+yXcqoI+4Ugnxedda6XCa6nP2T0dIFtWbjDtyY+
 OR9589kNzF9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="399605585"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 12 Nov 2020 18:12:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Nov 2020 18:12:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Nov 2020 18:12:32 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 12 Nov 2020 18:12:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcyuop++hG44TmJm7HQu7ykkeCA+6yN1iNFn1b4zAtXdEe0mCyhIjEJrzzUl8HQPVG4EeoNHD1XGLe0lVKnxtHjqOnqxu27uYVAAmWlx6NjGKBNmI3oN39U7VirP7AKdgYohFiiHBL+zgP+9/km59eHBt92QbHGJ2wR1Xlw7QI/AyUvgt5EBzVv+/OPMAqr+DexKQgUPd/A6NnMh0i7YDZyBVXKtia+7zSw18sSUu61P+jxGYAo1+Zpv5z8smrV6SytV/T7mgIIpPnpSOx/rXPiJAPOvESpY81xwRrgEiXdvlV1UmV9kkNrL0TdOvzMBVVgBwrHbuj0r6JRS/ABlAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7zUTgIgEYe+OIGlNRyzH0P35wkG83EGkFw3pMziv0g=;
 b=WumH0qfyO/Y3zWkhcz/HkFQU6/zuzKMwd6fKs4CMzcT4t6AiKJQhr5i4SBS4artpTmlMuOMVVOf2qb0wMlOBoqzzP1IrQbqPjRdipq3r82m6lzVEukzt2eeyzkoCYldfSI079Mgwiuj+M+Ycx3EW+foNU5i61GAcMiRslfswxrZSqTCLuQOlTO8eghlL3Vmbqa6PySzIdwajZ06Gy01rJGzfnZ+dYQ3z4hpVUz+XkYU57OMyrEiJ50VZYAqJIvGUjHAObJiMBQYSgRT0Adk16f/p4jCvce2GRQFl2Tl5kTVBgu81qmKRK4JT6Av/VJqCkYOO+PPlcHhBYoU+DLDsnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7zUTgIgEYe+OIGlNRyzH0P35wkG83EGkFw3pMziv0g=;
 b=VWtyOaojwkK3HfgiveuRVVE3qJTKrQFSSztOo9MnEtrHqfvk+mBv9Zu1i32dKwXY2tlBzoUhcWrARfa9BXBnkwSs4OBPCuJvIfGFqF0c/26LFjBjx0LszD2H+8DfcJyVliISU5kuAPsvXwTHNaFq+2wwrHkio3FlM40oZxorw0k=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MWHPR1101MB2157.namprd11.prod.outlook.com (2603:10b6:301:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Fri, 13 Nov
 2020 02:12:30 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f%4]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 02:12:30 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 10/15] dt-binding: dma: dw-axi-dmac: Add support for
 Intel KeemBay AxiDMA
Thread-Topic: [PATCH v3 10/15] dt-binding: dma: dw-axi-dmac: Add support for
 Intel KeemBay AxiDMA
Thread-Index: AQHWuQQ2tbhfyVk2xESCGm8n37pqB6nFUm5A
Date:   Fri, 13 Nov 2020 02:12:29 +0000
Message-ID: <CO1PR11MB5026867ECF7693C7DC86571ADAE60@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201112084953.21629-1-jee.heng.sia@intel.com>
 <20201112084953.21629-11-jee.heng.sia@intel.com>
 <20201112145800.GB3583607@bogus>
In-Reply-To: <20201112145800.GB3583607@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [60.49.111.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2da1620-1c05-4a25-b54a-08d887799312
x-ms-traffictypediagnostic: MWHPR1101MB2157:
x-microsoft-antispam-prvs: <MWHPR1101MB2157A540962F16D583BA7B77DAE60@MWHPR1101MB2157.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Idx5YFBB7IuuiSJvsKS91S0x8DtxwFoB8gSOZjdT41UP2r94BAkHs04cXPuodYVklZHYmuvcaSZWzUNhlDVsfLEuXlNtKPGs7zo7WCTzq5V7dqA0RiHjvGs2gfkMC3pvpSiQMiZr4P2e3Wzp2dswFbC3WlOB0TzSlWiuyBz6kYKUOi18mhRCuiGS43GKltU8iGoCsMQfXFaOH5KANzGSIIiX99/xLAb3s4EdAj2RP6QEyp8oz4RgTSnUJc8yXjttkWv7Hu6aVo2Byf5fj9vP0WU6IBi1VqT5Rxcofp1Np17TFOvTXPemumEeYCrRU46wIxTzWSTH9kzRxkSBw0SeUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(33656002)(7696005)(66446008)(9686003)(316002)(2906002)(53546011)(52536014)(6916009)(26005)(54906003)(8936002)(5660300002)(478600001)(76116006)(8676002)(186003)(86362001)(66476007)(64756008)(6506007)(71200400001)(83380400001)(66946007)(55016002)(4326008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 369G1MN3kmWhyiaMUdy6bN/NXCidiDPst+ZNslnyiwbSXhJfQs/kS0d6sZdNJdyCQFMkBg0iXliNDL1txwo3CLR1xgdUzIERCc5z2ih9DaVijojxE8aKxDZ+Cm9c8jf7TExfWeHQ0xqlLpAZqhTeKTgq3laV9OQmWC9Xt8zji+Fw2OBn+VcYsF2sVbHaDv71DAFVfsZjIQF2o5518VK+ywSzFUdSt6fPmmJqupcBQgVVjDCgdoVyUSmRBLsa3LnXtigLrXAyHOuuS3g++jZOuMUBuZM6v7BvlmZfxVzwpyP11hLlFFzsVvGka4av0/sOjIj7l/LkcrtblZCzG6PKDGjS5Rfs0vZl+ZKuqfRDMk3KF9Ss9vWAuPtHJ7QuX+FB4E6iGiuBK8BrIoT5IVrKrxccgWFshrP8YoLX8EBHytv+MOlt7j2YWPga4A0R1I7vkaTJApZIixTRHUwdeIqAk2PUDV5JMQfNC7hEVsdaQG5+j0rv5VBxr/PtMT9/e9CQiYkYak6Ea6KsU0vd+Oj947iKnVqkCQPesL1aOKPzG+tLMjdz2t+UopzlCtQ9lkDdOi+HSSltAEcwp4bKsSIJ+sNd3/62u6pViVcgr18KaKh8k47E33K6dEsumMPlfiBDSK5nhOZijegG3uz2dpaGV5TfJJmxQRlI6nA4l5FAqnUnJXckSC88Osn7E1E3gZdQJHFKqw2mhX28aYGVJtgCGDeLvOvZjMQv2JKmfP6nRsaauQVMj+eXAMEMD943tu/Zzf+awhSNzAbdTuzeav1tfavy5QFesnJn9dsBQwkWOCCqf3Scgmk0CFkhpvx8yBfpJrMyoKJ/EAelxFB6BHo3zEDrDDcicMKFCiWweZecFqCjOpmU8nuCyKhN7tIGg6b2u5fxwUCLQ4xA5oMwh3/c2g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2da1620-1c05-4a25-b54a-08d887799312
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 02:12:29.9392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USJNr1KHoKNPB/qg3WL5iRRss5r8lCOtfs38RHiWoxi9L7iRuNDCVNu6jwGbSZ7XzFLPO1tjslGlMsgVwe3zAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2157
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 12 November 2020 10:58 PM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: vkoul@kernel.org; Eugeniy.Paltsev@synopsys.com;
> andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v3 10/15] dt-binding: dma: dw-axi-dmac: Add support f=
or
> Intel KeemBay AxiDMA
>=20
> On Thu, Nov 12, 2020 at 04:49:48PM +0800, Sia Jee Heng wrote:
> > Add support for Intel KeemBay AxiDMA to the dw-axi-dmac Schemas DT
> > binding.
> >
> > Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> > ---
> >  .../bindings/dma/snps,dw-axi-dmac.yaml        | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > index 481ef0dacf5f..18e9422095bb 100644
> > --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > @@ -8,6 +8,7 @@ title: Synopsys DesignWare AXI DMA Controller
> >
> >  maintainers:
> >    - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com
> > +  - Jee Heng Sia <jee.heng.sia@intel.com>
> >
> >  description: |
> >   Synopsys DesignWare AXI DMA Controller DT Binding @@ -16,6 +17,7 @@
> > properties:
> >    compatible:
> >      enum:
> >        - snps,axi-dma-1.01a
> > +      - intel,kmb-axi-dma
> >
> >    reg:
> >      items:
> > @@ -24,6 +26,7 @@ properties:
> >    reg-names:
> >      items:
> >        - const: axidma_ctrl_regs
> > +      - const: axidma_apb_regs
>=20
> You need 'minItems: 1' here or everyone has to have 2 entries.
>=20
> Also, doesn't 'reg' need updating?
>=20
> >
> >    interrupts:
> >      maxItems: 1
> > @@ -124,3 +127,25 @@ examples:
> >           snps,priority =3D <0 1 2 3>;
> >           snps,axi-max-burst-len =3D <16>;
> >       };
> > +
> > +  - |
> > +     #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +     #include <dt-bindings/interrupt-controller/irq.h>
> > +     /* example with intel,kmb-axi-dma */
> > +     #define KEEM_BAY_PSS_AXI_DMA
> > +     #define KEEM_BAY_PSS_APB_AXI_DMA
> > +     axi_dma: dma@28000000 {
> > +         compatible =3D "intel,kmb-axi-dma";
> > +         reg =3D <0x28000000 0x1000 0x20250000 0x24>;
>=20
> reg =3D <0x28000000 0x1000>, <0x20250000 0x24>;
[>>] Thanks Rob for the invaluable comments. Will update the changes in v4.
>=20
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
> > +         snps,block-size =3D <1024 1024 1024 1024 1024 1024 1024 1024>=
;
> > +         snps,axi-max-burst-len =3D <16>;
> > +     };
> > --
> > 2.18.0
> >
