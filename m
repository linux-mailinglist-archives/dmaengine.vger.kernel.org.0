Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF12AE60A
	for <lists+dmaengine@lfdr.de>; Wed, 11 Nov 2020 02:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbgKKBug (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 20:50:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:17633 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731657AbgKKBue (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Nov 2020 20:50:34 -0500
IronPort-SDR: tdt3LRiePbLIDvk1SqzT4YjbcfenzAUI9KaubHHfgwqfBDiHn1+fZxB0H0OmFdhXNPouWMYefX
 kxdqHwIPVtbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="167496153"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="167496153"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 17:50:33 -0800
IronPort-SDR: yq77fjCvk+s6KyrD8J8g/hlbp6bTUxGB1RCt6PbQ0q7dguthJaGsLY3A4cN+1AoCSD/eJ/4rFn
 P1Z1En4POF3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="360356642"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 10 Nov 2020 17:50:33 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 17:50:32 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 17:50:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Nov 2020 17:50:31 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 10 Nov 2020 17:50:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTLNL6/7aXvGsP6rR6/13VmtlRYZuXgcJYC2pqjS6LbJcKPkhZEhuHJ+3kmsQ8GwHWjGf2/EwKcz849ra3NqkE08ouae4UX7yBLCTcAgJv5OKbXugqKQBPCxw6+xTBodx9EN0HvJ5MjsE9aJ99BzAAWdiBsfjw9zrwQKkl+T2Xd9EAJwfkoJbknSXys9j5q2BVGUccFJJBY5SW/qRrY7349nL76OmiwKoFvZ4jJMQYL5fz9mxxQmipe9zF2zAdtbFXYl8sCgkWawijD9tA/RKPu0+ym3XaBi5+XcFJM2ncGyNnIM+GxNeM1VTtYSM576Vuc0fyw/AOlKntFypvDC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wShmwPwYz/ZVCruLS4qVaDpPckPJ0qpP37p9COd298=;
 b=hj+GePpuoBzQpTFUiDgVMHekGP5/pT2bI6mk/h5YtGGexP+930x0As2FWAkgAyHVc9xwMhFkYtM7Vp37gvHv9fU+j6mriWbguxaUhUuzbxGoax7WM2oyMyHzuKTZmn3/oHPWjPvT/pAtoqKfBJYUJtORpVySGxfn9N9LdBnkuH18s84IVw9xLxY+stJvj40StePnPSvN7XEuFVP3qR8qYBEs5RWK6We7bCsi6VeWd1e8/VLcmA1nn0cKlUZrXqlAiLcjurwFidJNsVLAJdY7WzQhFIMOwa4h663yUXynjGh/rpLj6wigNsN0fR0c0n30v530fRtxAIWq0kHK6wd+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wShmwPwYz/ZVCruLS4qVaDpPckPJ0qpP37p9COd298=;
 b=CxYi4+bDbQS3i50qRw8WtkfHCejgKIr8u5nWvHfWG0JPel7slwhZnniuTm9ggrPqWebOSwcpb1Ccg9Kzm/dcwdHNZc5XAefS209AOu4SMe3mlNuj+50T5M/RjjgI7oS9UHvXcVfsTdk4SazzKVVBEs+hvRmJwyGDHjoOoTnQtfM=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MW3PR11MB4619.namprd11.prod.outlook.com (2603:10b6:303:5b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 01:50:30 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::40d9:aa4b:73e7:3d60]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::40d9:aa4b:73e7:3d60%3]) with mapi id 15.20.3499.032; Wed, 11 Nov 2020
 01:50:30 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 11/15] dt-binding: dma: dw-axi-dmac: Add support for
 Intel KeemBay AxiDMA
Thread-Topic: [PATCH v2 11/15] dt-binding: dma: dw-axi-dmac: Add support for
 Intel KeemBay AxiDMA
Thread-Index: AQHWtn5SHAIYN+GEPUuGhLznFrN/dqnCLJ6A
Date:   Wed, 11 Nov 2020 01:50:30 +0000
Message-ID: <CO1PR11MB5026F2C46A560D125AFB5241DAE80@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201027063858.4877-1-jee.heng.sia@intel.com>
 <20201027063858.4877-12-jee.heng.sia@intel.com>
 <20201109095417.GE3171@vkoul-mobl>
In-Reply-To: <20201109095417.GE3171@vkoul-mobl>
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
x-ms-office365-filtering-correlation-id: 24269922-fd01-4a94-ad2f-08d885e42bcf
x-ms-traffictypediagnostic: MW3PR11MB4619:
x-microsoft-antispam-prvs: <MW3PR11MB46191943A4B3A5898EF8CD61DAE80@MW3PR11MB4619.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WYwvF0r65VLEnjswlj1BcscXbLegYXTCYaKJJwCnG7xmMfK7wYXxpZ1bw48xKnkfvXEc+rmEiG87RH2sRCB4YJ8JVGZ8kGu3NXpBuVOnDn/XirZwNOdV9urVNf6894PhTHzwcXsHBz90mXa6vokIpez0Dn61iBUghSojxgIIv82WDe4Zjw73UjoLAIfV3aTW+hKFu3ExSAoiGpX4Qh5cvHEoRall6dovnwnjo5yvunlE2ibwDSza/aLYD3oeK23S0Zk3fOkBLse/Lvc1lxBoIfH7m1JzVljFnQQNoIwkw7STEHIT2G/wSSOSVzJoeGgdoIJ7cZD/dssMXSYOCn85Cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(7696005)(4326008)(53546011)(316002)(9686003)(8676002)(86362001)(64756008)(66446008)(478600001)(33656002)(66946007)(54906003)(186003)(6916009)(76116006)(83380400001)(52536014)(5660300002)(6506007)(55016002)(26005)(2906002)(66556008)(8936002)(71200400001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1se3QoY0R4bmZApq79xJs6+hNYCBA85L9wLy0fLHGN08sFIT2wWkYt0+Ew32geS6M3dMRTa0bxol7zgBRhmid5L6dh4mWsjdBAceQkDpq+6kFk8vVa2DGKpKWn0O6VLcqCjwVTa1ZYo60tALtcWZpWNF57qBHb7sE+8+JxhwOZihrOV718aGaD9J+gq3RGDAwXJclLSbBwUeM++YHRZAUeXHkci7rP1RfXTByxDYp+PlojqgCnKok+K5NBDpzbSw8ul2DdZsZLFwWbVSshRnhFpyiI4vxkjwgzGiBDbSP2A/mPEs1+o9tiQat1EfVsCgml+Ffqi5Kr9PYW+Vu6ESjLdbhIjnZj3YRuco0D4FyP3O753uDBG4uBwGsBmvSiUVroLQWhp6Er8pZJkom6HQ48Qu72tmoFfiCC97DrtaWtDeHfK/1lY6WZg9tNaxiZJGJts3gEc0dRFwlaIbdKV49Ihq9NAtwNkK1XoKMjwx+zoBM7RUH4Ye3yqi5uI6OFqkKVowr+HUZHiaRoGMhmH0GtgMt4JmdRMbNWqJbomgcnguurMs+yFS6PiUwewHQ7O8u4VzgjKqyqNgzasLJ5NDbPTJCIaRnhT8K0U9kUGS6ujn7E/CDQUHbyjhblgJUfjTvH5qWJj6fRcQaMcVb/+vug==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24269922-fd01-4a94-ad2f-08d885e42bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 01:50:30.5330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8hmxmeYcdKAwGW5iqsNVVTKvjAF9P+xq71bBmpX2Yp22HTLTtUtQGaPfvY6K0FoTQChjgqOLvYWWD4BgAt0RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4619
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: 09 November 2020 5:54 PM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: Eugeniy.Paltsev@synopsys.com; andriy.shevchenko@linux.intel.com;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 11/15] dt-binding: dma: dw-axi-dmac: Add support f=
or
> Intel KeemBay AxiDMA
>=20
> On 27-10-20, 14:38, Sia Jee Heng wrote:
> > Add support for Intel KeemBay AxiDMA to the dw-axi-dmac Schemas DT
> > binding.
>=20
> This patch should be 10th one, we add binding before its use in the drive=
rs
[>>] Noted. I will reorder this patch to 10th.
>=20
> >
> > Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> > ---
> >  .../bindings/dma/snps,dw-axi-dmac.yaml        | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > index e688d25864bc..0e9bc5553a36 100644
> > --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > @@ -8,6 +8,7 @@ title: Synopsys DesignWare AXI DMA Controller
> >
> >  maintainers:
> >    - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com
> > +  - Sia, Jee Heng <jee.heng.sia@intel.com>
>=20
> That is intel representation and not your name, right! This need to be yo=
ur name
> in from Firname MiddleName Lastname <email>
[>>] Noted. Thanks for your invaluable comment.
>=20
>=20
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
> >
> >    interrupts:
> >      maxItems: 1
> > @@ -122,3 +125,25 @@ examples:
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
>=20
> --
> ~Vinod
