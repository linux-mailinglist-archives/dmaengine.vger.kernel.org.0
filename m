Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E512B9F68
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 01:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgKTAr5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Nov 2020 19:47:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:62788 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgKTAr5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 19 Nov 2020 19:47:57 -0500
IronPort-SDR: tf9mpwsEs6apZZDdMyaS53nmDKHLegxuhPvAQwBtiEhi4f1Q3QP//0rxSVSJjYJz0BkoqHMedI
 8FL4D3R8BwDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="256100410"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="256100410"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 16:47:56 -0800
IronPort-SDR: fr3S7EtRmRyhR/85lOTwJgmCycRYBzIwxZY87ObagrEG6MQuA9kwYtpj5jf3RshGJSPUovYh6v
 qI6I1PpBMUGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="533380676"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 19 Nov 2020 16:47:56 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 16:47:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Nov 2020 16:47:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 19 Nov 2020 16:47:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4SnzW0GJENX8LEsKdq8FLvCXoaQtwCLLohjgwDDF2WttEHPslSkfo/5WnfSvE8igwInJ9Smy8bKK3285sAZ6qxZChy1t5s+MLE+gD6/SdE73jdM219iJ1MQgz3LA9c+ZASP1EkS96q7fPPZBZeH4nvGZKNO9xTWANpIUV1FFD80lfX+/7Wnl+1LrQ8ADlkH5EJXLcFZYwFfw1dCQbrf5Qf0gOARfKIXnLDZY+o/TeKn6C9TP1gHs5sks8IYnEPGwHdn+mwv7Ezemb5CR6WdZxyyX/xQcVZY2pCS6AiHnnGO2DLa12rWDJclcSGKAOE6c0LdroOKidTyfg2/py1lJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTgKO4xZG74wOKnqVK2IMQI+Dc6IZFleHymp8Q5F2yo=;
 b=XmEpCIsap+OymjIQcdmRQg0FOAjKT6IbC8BHCO0eU9CG4rWAqAoB+DpvzJW7EMlaC170rIOZx5gGvHCIyLKhjmEssFqRhGc3V0idyHvv8UK7DfKRrI+XzgAg/I0Puoj+AKq86F4wZQ293QQcvokDJFiIcWe29HjQ9Ms7aDCvTNCYnRAf1069EpW14dY3kx6gRH/QcmSyf/iY3oIQvBEKg5skOq7TyLbESPX/oZ24lmoSSUD3egW6bbLiPTuAcQl4oUtH86A69TfB8QerxwBC8qFZtbOQXgmpZRCKd2cVDmu8IsmWG7duaBJNl+OnDjR7ULkeyT7vsXnQiZLBknYf7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTgKO4xZG74wOKnqVK2IMQI+Dc6IZFleHymp8Q5F2yo=;
 b=K3bA4Iin2e7+Akjv2d04F9fYkS0LVGOykNb86T1ebtoM66Ypfn1j2wAmt50Ipt8pUyZnib7U3Vnanks+I2v9UQl+jYDVfiBB4oCc6sWP13EGtSoyZK0F17sXUOXxmjJm1DwK2GoXyXP7S6azy3B8lWuWzr3yShQYczTgXMyL6hY=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MWHPR1101MB2255.namprd11.prod.outlook.com (2603:10b6:301:5b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 00:47:52 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f%4]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 00:47:52 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 08/15] dmaengine: dw-axi-dmac: Support
 of_dma_controller_register()
Thread-Topic: [PATCH v4 08/15] dmaengine: dw-axi-dmac: Support
 of_dma_controller_register()
Thread-Index: AQHWvIrRlLHF5Erm206fp1n916gn4qnOlqqngAGdfZA=
Date:   Fri, 20 Nov 2020 00:47:52 +0000
Message-ID: <CO1PR11MB5026F192DCEBD5B4FFF1D2D2DAFF0@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201117022215.2461-1-jee.heng.sia@intel.com>,<20201117022215.2461-9-jee.heng.sia@intel.com>
 <MWHPR1201MB0029DC5ED96606C7C3FDDF03DEE00@MWHPR1201MB0029.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR1201MB0029DC5ED96606C7C3FDDF03DEE00@MWHPR1201MB0029.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: d787df23-8e15-4900-3b5e-08d88cede99c
x-ms-traffictypediagnostic: MWHPR1101MB2255:
x-microsoft-antispam-prvs: <MWHPR1101MB22553178463D59B91C41A228DAFF0@MWHPR1101MB2255.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4sxMN6ESc9Ao1EyS+W3sNmvLqB9+/3mkxT9P1O/0WZR6o0cuHzvdBQ2YAOzirAiNGmLggilCM7U3aA0EdX4OlbmR/6+X6iC2P8lct/lp1Xl/0/Jux8kILl2FjbNV8CTFwwoXpG4M2tUZj0ElIaCYXUSjzZIzIB4GLNfJFB7ztIM8FEAqF6n+dHDS870w+aHPTSV9eRQkyc0+tXq0ArfIxrdpBBrIEBhcrhGN5eVpg/vfJXRCuT+HMfLlfVzeNGOh1LWIW0RLq7mc3MJyYGT1Be3Zv7ghwqa0WvHLKqwSkjZjSBS9H/HawYMbQFi/z1d118tJmVxoN2a/24PMqvsddg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(5660300002)(66946007)(64756008)(8936002)(33656002)(52536014)(9686003)(54906003)(55016002)(76116006)(53546011)(66446008)(66556008)(66476007)(83380400001)(478600001)(86362001)(6506007)(2906002)(71200400001)(4326008)(110136005)(8676002)(26005)(186003)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5mpoJ4gHGerCwr3Lj3KwQnruaf9TZGzxMoIhvNRly1ZM+8w2BLOj+EfERmK38Ll/hL66wSrnOZBW3M6iWOyHukc9dYgbLrqM/vjvwvgMiWpL/tD1lVsfzVxZ+mkMyxQ6fLcvf5jtnASml12wddvoC3n1k/4eJSHjpiH5a/AT/IC/GEJItdhCtuAQUGtGLfg2wAPZeVfwCwplFCajPIi0x7lIBiDiGRUkiLRDlR0c0V42y0boL/3LP1VK4hvq0mOL5VkSweL6MaR7OQo6Eri6C0NpmJGXR5ef9ShbKsQm4QuK6GR2/ZT4a/c7wy7f2o+htmyXUxiioOfYgUkVjYhub9gjU/1oAhtwhucm9GMnuA2abFP50xZOlRpQxbgSUShkP4Oss261qZTye3KvG2aPjUKIJ0j8lA9egEkWF+LRNmNzUp5fDg+gBTiTR0tMMLk7nsq4MJAxcBvGTibR9TS3ADfBDGMcuZEVvey7Oo8o+Kq5Ws3ZWPUXwE9S564eWe72tRFsR9yGWmxMw+W4fS1ODdVHm1mZ7hR7+hvTr8VZC7bb2fZ0GjkVi6SA9Qx2xmkuvio3DVXivVbMi4gTbpBBH5d2dQoJO+gbhWXslddZIVTk/naYCkvGUU3KiTy2MvlUsEE6S0apfEHMScj8XfA5p7UqXYK/gE6gcaw+r1UlV3gTWipwnQgWdsYkrBVn7i8+Nh1/gSuA6DSeH0oBwB+1FKVn3Ra9EE99buANL4qQnES3fdEdPTb2p37nQif7dcr4R/xsuyjuVsKfCLnSV4fYIeW4RFeVikN45bRueYm39WSVG8igTZTSLEGNKd7JVoKoXvhwCrJvMNU8HLDiweRYn7Eb9g9jms380ru1GjqBMZ9vhXk09VMaQyrjoNMJUAbLAc9VWB144GRp2Nub5LZEwg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d787df23-8e15-4900-3b5e-08d88cede99c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 00:47:52.6218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zl3YENrc2WvUuylDKdbEM1kxMRI0MMiM4+sjvAYXFYHaNVYRbGh39fAln77HHU8xSbxn5mXXP4TWumD+NMOaOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2255
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Sent: 19 November 2020 8:10 AM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>; vkoul@kernel.org; robh+dt@ker=
nel.org
> Cc: andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v4 08/15] dmaengine: dw-axi-dmac: Support
> of_dma_controller_register()
>=20
> Hi Sia,
>=20
> > Subject: [PATCH v4 08/15] dmaengine: dw-axi-dmac: Support
> > of_dma_controller_register()
> >
> > Add support for of_dma_controller_register() so that DMA clients can
> > pass in device handshake number to the AxiDMA driver.
> >
> > DMA clients shall code the device handshake number in the Device tree.
> > When DMA activities are needed, DMA clients shall invoke OF helper
> > function to pass in the device handshake number to the AxiDMA.
> >
> > Without register to the of_dma_controller_register(), data transfer
> > between memory to device and device to memory operations would failed.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> > ---
> >  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 26 +++++++++++++++++++
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > index b5f92f9cb2bc..72871b8738be 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_dma.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/property.h>
> > @@ -1044,6 +1045,22 @@ static int __maybe_unused
> axi_dma_runtime_resume(struct device *dev)
> >         return axi_dma_resume(chip);
> >  }
> >
> > +static struct dma_chan *dw_axi_dma_of_xlate(struct of_phandle_args
> *dma_spec,
> > +                                           struct of_dma *ofdma) {
> > +       struct dw_axi_dma *dw =3D ofdma->of_dma_data;
> > +       struct axi_dma_chan *chan;
> > +       struct dma_chan *dchan;
> > +
> > +       dchan =3D dma_get_any_slave_channel(&dw->dma);
> > +       if (!dchan)
> > +               return NULL;
> > +
> > +       chan =3D dchan_to_axi_dma_chan(dchan);
> > +       chan->hw_hs_num =3D dma_spec->args[0];
> > +       return dchan;
> > +}
> > +
> >  static int parse_device_properties(struct axi_dma_chip *chip)  {
> >         struct device *dev =3D chip->dev; @@ -1233,6 +1250,13 @@ static
> > int dw_probe(struct platform_device *pdev)
> >         if (ret)
> >                 goto err_pm_disable;
> >
> > +       /* Register with OF helpers for DMA lookups */
> > +       ret =3D of_dma_controller_register(pdev->dev.of_node,
> > +                                        dw_axi_dma_of_xlate, dw);
> > +       if (ret < 0)
> > +               dev_warn(&pdev->dev,
> > +                        "Failed to register OF DMA controller,
> > + fallback to MEM_TO_MEM mode\n");
> > +
> >         dev_info(chip->dev, "DesignWare AXI DMA Controller, %d channels=
\n",
> >                  dw->hdata->nr_channels);
> >
> > @@ -1266,6 +1290,8 @@ static int dw_remove(struct platform_device
> > *pdev)
> >
> >         devm_free_irq(chip->dev, chip->irq, chip);
> >
> > +       of_dma_controller_free(chip->dev->of_node);
> > +
> >         list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
> >                         vc.chan.device_node) {
> >                 list_del(&chan->vc.chan.device_node);
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> > b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> > index a26b0a242a93..651874e5c88f 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> > @@ -37,6 +37,7 @@ struct axi_dma_chan {
> >         struct axi_dma_chip             *chip;
> >         void __iomem                    *chan_regs;
> >         u8                              id;
> > +       u8                              hw_hs_num;
> Just a nitpick: 'hw_hs_num' sounds quite obfuscated. Could it be
> 'hw_handshake_num' for example?
[>>] OK, will rename it to hw_handshake_num .
>=20
> >         atomic_t                        descs_allocated;
> >
> >         struct dma_pool                 *desc_pool;
> > --
> > 2.18.0
> >
