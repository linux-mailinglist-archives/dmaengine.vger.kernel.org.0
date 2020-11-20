Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0606D2B9F5F
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 01:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgKTAkc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Nov 2020 19:40:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:25671 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgKTAkb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 19 Nov 2020 19:40:31 -0500
IronPort-SDR: GRI1rFvy8gwpyPqiAlItFG2VFJFOlnZBG3y1ztQNLANKxVnyNFRPGI6F64qzj9DxNEFkxO6QWh
 04VQjl93iDdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="159161000"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="159161000"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 16:40:30 -0800
IronPort-SDR: MCqYrc4bG2F9oBFdH0uhk4R4p+85eCBAuYzGoHGOvfo+rRyfeUrE2LmOsluk4oFmeXlGn96imt
 w52g9aQGbBhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="331127325"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 19 Nov 2020 16:40:30 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 16:40:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Nov 2020 16:40:30 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 19 Nov 2020 16:40:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8yUZ7l6T+kEnMxfdLB1lPAyV5kRRKc9fkbli73iDK+jgytn04zMEWzhjG/DCQeli+r2evtB4q1tLEfLAixOjF+fIjKvAuWF2NCTWAWoW3oNMf+tp9i0SbmJrPMOsBsJE1/jcGxABIC3ZQ8bPPmta/iXH2+g29Oac7axidaUeYtDfe6pHYjmp0GdGtI7NZks2WAl4ZPSfIiRRGVpUKG3IdraAmdtuHOeWc6eWy9QwkTF2sI1ViysF5Zb3utjgFzKipgepO9ILpI8VniBzhVb+kz1ol19kGDOcTOZHEhsOyB88G7QWOLEm1LikD8W/15WaMjJE4Uc+1iQ1yV26YOC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKAEXRt4ZxGkIUGK6sKMBs5tp5f9ECjR+5j04RJ4Afg=;
 b=aRw180PZGZZdlgq9UBGjOEfBivNwO8leMrHGDoZSib1ygHeXta2DY6FIHT56/MUONP5ap4VyXK/8QyCU41m9AWZ4CwIbBUN7GKyi8VAsuSKIsTmtV1KBMO2jbBl6ToZw4k/jtsEhI3QsxKuY/XLnybwepkvAPk4WnNoCcycV/a6QX8GgPlInCKj+IV8Jp7lSsXshwfjk2KIJFImHpMeoYDD2N162pVxF7c/AD5r1r1oygfSAlWm0CuLWP48HZlPRkPRYMqGl6Y5GOh+9l/XJun9vwtGKNBqNGakODg8qzF5Io+aHi2Rcyast25o9/UTlPgvhcMF35fVYuq0/dJfn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKAEXRt4ZxGkIUGK6sKMBs5tp5f9ECjR+5j04RJ4Afg=;
 b=ZrC/ZzDba8Pj5PfMG5SD5GV0M7UXdbZ6zIuBBFXI6HKuKPXSfuuSfxvpBt8DnvEq/5brswn16vUawuPf1s/kPNwXRWUtjExz9SMjFgt23HNKcPto4H+pArybeCSavMC793cwqu7txGVVUJDyyDlSnkXmFVZS6xEDN9avBX3GEVk=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MWHPR1101MB2208.namprd11.prod.outlook.com (2603:10b6:301:4d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 00:40:26 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f%4]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 00:40:26 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v4 11/15] dmaengine: dw-axi-dmac: Add Intel KeemBay DMA
 register fields
Thread-Topic: [PATCH v4 11/15] dmaengine: dw-axi-dmac: Add Intel KeemBay DMA
 register fields
Thread-Index: AQHWvIrXLAM1xxfy7U+r4CcYlOAdA6nOkDDRgAGguhA=
Date:   Fri, 20 Nov 2020 00:40:26 +0000
Message-ID: <CO1PR11MB50264ED208E2BCB9F5BA8B68DAFF0@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201117022215.2461-1-jee.heng.sia@intel.com>,<20201117022215.2461-12-jee.heng.sia@intel.com>
 <MWHPR1201MB0029278F2808FB55CEB8B3D5DEE10@MWHPR1201MB0029.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR1201MB0029278F2808FB55CEB8B3D5DEE10@MWHPR1201MB0029.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fe18a9f-f5db-44d2-4832-08d88cecdfaa
x-ms-traffictypediagnostic: MWHPR1101MB2208:
x-microsoft-antispam-prvs: <MWHPR1101MB2208A26588213F81FCB36A7BDAFF0@MWHPR1101MB2208.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yOc5NqatrjwFBG6vf0xmnNUlLpExbzItqi74uflmZiVLlaZxNMs0M0Goj5T4qLv+vq/3vD+9GE3anfAZiNSUf3PxqJGUw9Zlokc/zgNb+YLW2cCSOfwHKkI5RRincIWiuk3JIBAxhUHlRFNUKIcfBiy0ZCxbH8QZ3Am3xlJHaU+/yNE7Mrgc5+jQ0hID3xxJ55jAIM2S7d8zwQVD5dXWYGwQPQ3AeuwiVtqpqoTivUEnGPmCP1mZdQo6Takwg/J3lYKezoY6CybELGtalB4MoVuOcYxOId7DfcrIy0mRmLaLMgMFddEe3lFYbPtLi00lL6TWA5mAp4M0/RgKt54Y2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(7696005)(478600001)(8676002)(8936002)(53546011)(6506007)(66946007)(86362001)(4326008)(6916009)(66446008)(64756008)(76116006)(66476007)(66556008)(52536014)(9686003)(33656002)(83380400001)(71200400001)(2906002)(186003)(316002)(55016002)(5660300002)(54906003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vbICqFwaCU1pdk1vLydEFjRv2GWxxr+a85d5/3skiqfTmDDQqQLtzw1R+bNqgA9KgTfmR8/+9Q3bCrd+IQRia53L61WJB4KQMk9UFtOc4XnhvudUlzgyzbwVrFTLzM8jTj0MMcaaYL8YtW03awobpMauIkpkAWl0ZSpcz1VZBnUdLkhNxCn7pqyHeoMO2q3sOK7/FtP+aGIMOPWwHOMk/UAi6WzxCFmZocsZrysQApFaak63iUVxcywjhCNvoP9le4YqAEGnbIIT1JaatsTgqOK6if61Rym66RSx+lNqBsys++vVXMmXBUCoCtogD2IG/DTYKy0bRLqvGu7p1ZdTx4VwLhRZNu1c8/UrxlN/SzWxFMRE9Xks/vuR1qmRBthbtw/wXWNIk8COoJKYQfffYG63BkVc9LMYMsXSHRXk2KbXTPJI1r2SxcjDZAPX0HvVxVil8VEY722q4l/1ASYvhU7gKj6ZB7togK4tQi/GGfmRtGRLkzf/lG5KzRoM6tqvQ7RjeKk3zFWtNpebR9OgKitTJgpWxdIHGY/7KclL5mWzGQqUgREYmuL5SBztMbRvYrSLAQazKToWWLgZh8G8+nsQCisL7eIl0IB62Kmm2C5kVQy4iAiYQbmk5VGzxR39uCZT1eDsgp5fRUkfSNTCS3WrZqzNADEYOoVgj3G11MvMpZD6sbiq5GXS+r5n/jb2ogDgo0wH83g2Q+HO0rniHwYgqvs0/96BmK3Q2CnKmeXayTGYtiZ6008BmQCEdp4q68UpmWC/x05ghsySno8pQOnXAbyqilRTetwPXu6XasDeO2jobj6YfXCW7CBGTpWH65OazpE5o+6THec431lYGTY5N3eYIISlGn5PRA3UrnM/banJxiwg+PTwISdBkgyN4Eeypl1Yrp0DV3HqFk1kkw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe18a9f-f5db-44d2-4832-08d88cecdfaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 00:40:26.4180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfs9Z/+uzznKghjiJlFolZx6uet/InabSA4VjsPuCZhnuGG6sIMle6gh6V8brKOv9B3mMJJjo3LaM/GdVTmPAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2208
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> -----Original Message-----
> From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Sent: 19 November 2020 7:58 AM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; vkoul@kernel.org;
> robh+dt@kernel.org
> Subject: Re: [PATCH v4 11/15] dmaengine: dw-axi-dmac: Add Intel KeemBay D=
MA
> register fields
>=20
> Hi Sia,
>=20
> > Subject: [PATCH v4 11/15] dmaengine: dw-axi-dmac: Add Intel KeemBay
> > DMA register fields
> >
> > Add support for Intel KeemBay DMA registers. These registers are
> > required to run data transfer between device to memory and memory to
> > device on Intel KeemBay SoC.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> > ---
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  4 ++++
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 14 ++++++++++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > index 7c97b58206bf..9f7f908b89d8 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > @@ -1192,6 +1192,10 @@ static int dw_probe(struct platform_device *pdev=
)
> >         if (IS_ERR(chip->regs))
> >                 return PTR_ERR(chip->regs);
> >
> > +       chip->apb_regs =3D devm_platform_ioremap_resource(pdev, 1);
> > +       if (IS_ERR(chip->apb_regs))
> > +               dev_warn(&pdev->dev, "apb_regs not supported\n");
>=20
> There shouldn't be warning in case of compatible =3D "snps,axi-dma-1.01a"=
 and
> apb_regs missing. Could you please try to do ioremap for this region only=
 in case of
> intel,kmb-axi-dma?
[>>] The intention is to fallback to snps solution in case of apb_reg missi=
ng. Yes, I can include the intel,kmb-axi-dma condition check if this is the=
 prefer solution.
>=20
> > +
> >         chip->core_clk =3D devm_clk_get(chip->dev, "core-clk");
> >         if (IS_ERR(chip->core_clk))
> >                 return PTR_ERR(chip->core_clk); diff --git
> > a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> > b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> > index bdb66d775125..f64e8d33b127 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> > @@ -63,6 +63,7 @@ struct axi_dma_chip {
> >         struct device           *dev;
> >         int                     irq;
> >         void __iomem            *regs;
> > +       void __iomem            *apb_regs;
> >         struct clk              *core_clk;
> >         struct clk              *cfgr_clk;
> >         struct dw_axi_dma       *dw;
> > @@ -169,6 +170,19 @@ static inline struct axi_dma_chan
> *dchan_to_axi_dma_chan(struct dma_chan *dchan)
> >  #define CH_INTSIGNAL_ENA       0x090 /* R/W Chan Interrupt Signal Enab=
le */
> >  #define CH_INTCLEAR            0x098 /* W Chan Interrupt Clear */
> >
> > +/* Apb slave registers */
> Could you please add the comment that all this registers exist only in ca=
se of
> intel,kmb-axi-dma extension?
[>>] OK, will include the comment in v5
>=20
> > +#define DMAC_APB_CFG           0x000 /* DMAC Apb Configuration Registe=
r */
> > +#define DMAC_APB_STAT          0x004 /* DMAC Apb Status Register */
> > +#define DMAC_APB_DEBUG_STAT_0  0x008 /* DMAC Apb Debug Status
> > +Register 0 */ #define DMAC_APB_DEBUG_STAT_1  0x00C /* DMAC Apb Debug
> Status Register 1 */
> > +#define DMAC_APB_HW_HS_SEL_0   0x010 /* DMAC Apb HW HS register 0 */
> > +#define DMAC_APB_HW_HS_SEL_1   0x014 /* DMAC Apb HW HS register 1 */
> > +#define DMAC_APB_LPI           0x018 /* DMAC Apb Low Power Interface R=
eg */
> > +#define DMAC_APB_BYTE_WR_CH_EN 0x01C /* DMAC Apb Byte Write Enable */
> > +#define DMAC_APB_HALFWORD_WR_CH_EN     0x020 /* DMAC Halfword write
> enables */
> > +
> > +#define UNUSED_CHANNEL         0x3F /* Set unused DMA channel to 0x3F =
*/
> > +#define MAX_BLOCK_SIZE         0x1000 /* 1024 blocks * 4 bytes data wi=
dth */
> >
> >  /* DMAC_CFG */
> >  #define DMAC_EN_POS                    0
> > --
> > 2.18.0
> >
