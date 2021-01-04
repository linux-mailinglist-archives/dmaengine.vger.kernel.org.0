Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E22E2E8FB2
	for <lists+dmaengine@lfdr.de>; Mon,  4 Jan 2021 05:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbhADEJi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 3 Jan 2021 23:09:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:13736 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbhADEJh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 3 Jan 2021 23:09:37 -0500
IronPort-SDR: CpNCf7ERW0s2PV/Zi+6VHPmmly3fAwCBW+mpjm4wplDccbIljCjXWTURnaeOHzwEUUans/vJgB
 ot92ghsvuzuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="173400326"
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="173400326"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2021 20:08:56 -0800
IronPort-SDR: lcCwafBMoupLIWC4weJyDTowi0GMNy7kj+rRNrAyd8gUgpfPLVHJ1UJ7JoX8ZFjNSWD/SVMxRl
 gEGOLniQlPJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="421215185"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 03 Jan 2021 20:08:56 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 3 Jan 2021 20:08:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 3 Jan 2021 20:08:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 3 Jan 2021 20:08:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 3 Jan 2021 20:08:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIGThTGJoDYI37sh8nEXu5/9sYL7ZyO3HsaMR8IDpiFxtGuJDUUPDRQkreUXHzHA6Odgip9xbAUIYgMvrjPoBqJy9FSXb9Px3HaB2uG2vgOXZHUkStdL4KY5vJ7kjXFRlj51I+8+9Q+3l9Y7GJGQ4iJpqIIqqsCEchKEd6VXDctw/PlG+PKGmXtFK00mbH7jev6eroaa94+6KI8xKPYC2eKnE08w1wSVKWOxMulnfy0E9wxJ5S1qO9J6XBstA9CP8qb4K9eIjDBcYtPwrBrfc0Yco3RWE9D6ph/iH99o5p8gXPWtxGpo0l5mlmbwNbiqfPQd+1QikUjGTDFhb1N/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGj0HgFd/JSmSMqtyHmsq7PXtbdPS2d6iBkpyS1SzCU=;
 b=Kkrdo7GB/qkk7yDzwlyvCHU8+pJb54Y+XaRq93o4mj3XAGe28cDKnSO8LnRT63c6FAG/MyengGK4OhDkYitJmj+8coilXGWoQjruGivOryaYrSDqxr1a28TFltMw2kDxj6GCviHYbtPmNf4jyKCbVL9gmNlTHjOHYlZUhACiYv4yR9DRiqp0FTUk7gyqmhuK61Uux7VBoTreLbfryLs40a9+dCKP52BErEd3agbFpdEGM9HSzxMHdKVj6yh8sjcnj1ungkznAIvEpj35/GUK3+C25IvKICX0RmqMqYdyGDYT7WqzQo4vhnvsZeEtF56yY5PfTqqTHLK878Mc04gHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGj0HgFd/JSmSMqtyHmsq7PXtbdPS2d6iBkpyS1SzCU=;
 b=W1KhRhmmgEiuj+BZJfG9mV7P0aq7Rl0Y6ZYIVEIsU7IzNxis6g0wbALGXl0skVkGAW3yvCqu4KF1mZWynWN08Jrags7sQb9Y25jnSqOatd2Zaa4WmQZ90uyTr71Z8ZQXduBW3IEXvFQDuj4Qb6TjjHHcK4fEEjJHa8zow93k7NI=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MWHPR11MB1648.namprd11.prod.outlook.com (2603:10b6:301:e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Mon, 4 Jan
 2021 04:08:50 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f%4]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 04:08:50 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v8 13/16] dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA
 handshake
Thread-Topic: [PATCH v8 13/16] dmaengine: dw-axi-dmac: Add Intel KeemBay
 AxiDMA handshake
Thread-Index: AQHW3aAioccw/TUNekO0DxIVg+IMXqoRJs68gAWp9KA=
Date:   Mon, 4 Jan 2021 04:08:50 +0000
Message-ID: <CO1PR11MB5026C99B44D055930A6EB63EDAD20@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201229044713.28464-1-jee.heng.sia@intel.com>,<20201229044713.28464-14-jee.heng.sia@intel.com>
 <MWHPR1201MB00297BC4BB351FA85FE66A12DED60@MWHPR1201MB0029.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR1201MB00297BC4BB351FA85FE66A12DED60@MWHPR1201MB0029.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4e23e42-997c-4bd0-a725-08d8b066710e
x-ms-traffictypediagnostic: MWHPR11MB1648:
x-microsoft-antispam-prvs: <MWHPR11MB16489D09DA12288EF87A8F36DAD20@MWHPR11MB1648.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDsx+jQjpD/QVrp/SxDnFEGwCPQlmxrqKfnD/eQJ//SP3nu362JWbtgJOdOP1eI1ByvuNnjStzPasOgvfuaH688lzNuM8gxPtu/XvdVyDkXS6iGpJkJRfiJUNsfqd5qPeX+0YI4BHgNOCLmcIfEUhrKbhJpLEDd7Q1DoWQtdGKvVO4InsxhOIDtCFw6tZomVan1V+x2fc8b+yxG2Zd+RKqjicoGmbT8k/Twgd7/lYBMpGr2qfzFwcdxvKQY3ZpJP/96SnRjHtHXflRnw8opM3K5/hGaMRjBp+Ssp3EENweymV3zm/8Ja43rX52SeIoqXrz7pALpSwpo9jmeVBLb3LJOWRkB5EfaOvqqAV/dZf6IuNoCJCoS7h5LvfGtG/RvNC7wIa5+vMEKZUOovJTfNMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(478600001)(4326008)(33656002)(8676002)(55016002)(9686003)(83380400001)(71200400001)(52536014)(316002)(26005)(110136005)(5660300002)(66476007)(64756008)(66556008)(86362001)(186003)(66446008)(54906003)(76116006)(6506007)(53546011)(8936002)(7696005)(2906002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uLo16jwUpp7aIoyxY5Uz1ohymS3ObK9sjwPkEYMU7DD9OnVJ0ABGedUwZoai?=
 =?us-ascii?Q?Y4xDxlb0BQsxUIo2BjNNYdRBOewfv52T1quSsDiZJGN9G9eLUBI6hiTxahxw?=
 =?us-ascii?Q?C5LtQIwe/4a1sosP2dS7me7CsYbxsvVnHZ6rAU4eC5hIcydhnqEddC4gGZVO?=
 =?us-ascii?Q?odnDYE/Sy9UMT/QLRUkkJRQ6PplTQ2ipIoHMJznBAuqXRNkqKyc3QmcJcpFt?=
 =?us-ascii?Q?WaY1MF/lBTKlujdskW9HQNOeHGOyIlKJGJ23DxyhlHKOndDrr6BP9M5UL9MO?=
 =?us-ascii?Q?SHyD+226ue2rZ+Z0TnSz3IGcTfg9QHP+Mmx6z7qbZ4x8wkWz8trMWIdw3rcA?=
 =?us-ascii?Q?2JP2GfrrhIV1/Ozhk88c7QOp3LwokDLdKOvVy+j2LnOXFQzXN8bAjlyFcWcM?=
 =?us-ascii?Q?u/9Mz0YChcDnJO+EssZo/fSM919NGLp4MyJ11T54UN788EhQ/e9DvUkYIO+N?=
 =?us-ascii?Q?TMP7Hed+7v8NQOYRWXo8iLXFmhUpbphfElO4MBmbrV7bb3u2q3A/A8IPEB/B?=
 =?us-ascii?Q?vzcRZT/JlyjrRbUlqGG22JdhUbJ+fxqGOKZGHdhIhjfEdz2B7CgIxLmuOIRq?=
 =?us-ascii?Q?CmKZt45FkzwzI388IdwsSUnYciSpLk8Jqzy40PL1LHZNdpfiiJu7ySRHaIxL?=
 =?us-ascii?Q?yi0epKs+uAhrq8PVjS8KmRO91LJORNmcCxgxAO9oWjb9wfkeS/2HZmoyl/3v?=
 =?us-ascii?Q?FEC0tmkx6lVa7CYwf1PT1qL8vtEp5UosF7CyI4mNDEi3Z0p+Rwf5R8ia0ob/?=
 =?us-ascii?Q?WcnGqBi0eqI1+dkxEubDg6ItikVkTuAR4L0L+kHCs5G5hPhtpHt+OPcxou0O?=
 =?us-ascii?Q?fIdRmuuVQMIrcwXXL5NzVtE6hEmEWvcIUIm1wZac7h62VYK6QdGXVhAjSHlA?=
 =?us-ascii?Q?fXvl3h2eZsTZKE3WlPsOkol70tGv13T6JPi4INO0ZPk+LO7o3m+dhCUetBP6?=
 =?us-ascii?Q?oIUfRBl4kP2qb0CeXTzVgFtf3eaUCcEk3HhMd5O9bew=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e23e42-997c-4bd0-a725-08d8b066710e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 04:08:50.1828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ruurUJkG60g8hy8+VzYmP3SCAbg62e/SjJIB51pbYY+kDszB/DKTYQ1URxfqLpk7/jKA97Ll/nqomyYdQhFvZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1648
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Sent: 31 December 2020 8:44 PM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>; Vinod Koul
> <vkoul@kernel.org>
> Cc: andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> robh+dt@kernel.org
> Subject: Re: [PATCH v8 13/16] dmaengine: dw-axi-dmac: Add Intel
> KeemBay AxiDMA handshake
>=20
> Hi Sia Jee Heng,
>=20
> see my comments inlined:
>=20
> > From: Sia Jee Heng <jee.heng.sia@intel.com>
> > Sent: Tuesday, December 29, 2020 07:47
> > To: vkoul@kernel.org; Eugeniy Paltsev; robh+dt@kernel.org
> > Cc: andriy.shevchenko@linux.intel.com;
> dmaengine@vger.kernel.org;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> > Subject: [PATCH v8 13/16] dmaengine: dw-axi-dmac: Add Intel
> KeemBay
> > AxiDMA handshake
> >
> > Add support for Intel KeemBay AxiDMA device handshake
> programming.
> > Device handshake number passed in to the AxiDMA shall be written
> to
> > the Intel KeemBay AxiDMA hardware handshake registers before
> DMA
> > operations are started.
> >
> > Reviewed-by: Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> > ---
> >  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 52
> +++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > index 062d27c61983..5e77eb3d040f 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
>  [snip]
> > +
> > +       return 0;
> > +}
> > +
> >  /*
> >   * If DW_axi_dmac sees CHx_CTL.ShadowReg_Or_LLI_Last bit of
> the fetched LLI
> >   * as 1, it understands that the current block is the final block in
> > the @@ -626,6 +668,9 @@ dw_axi_dma_chan_prep_cyclic(struct
> dma_chan *dchan, dma_addr_t dma_addr,
> >                 llp =3D hw_desc->llp;
> >         } while (num_periods);
> >
> > +       if (dw_axi_dma_set_hw_channel(chan->chip, chan-
> >hw_handshake_num, true))
> > +               goto err_desc_get;
> > +
>=20
> In this implementation 'dw_axi_dma_chan_prep_cyclic' callback will
> fail if we don't have APB registers which are only specific for KeemBay.
> Looking for the code of 'dw_axi_dma_chan_prep_cyclic' I don't see
> the reason why it shouldn't work for vanila DW AXI DMAC without this
> extension. So, could you please change this so we wouldn't reject
> dw_axi_dma_chan_prep_cyclic in case of APB registers are missed.
[>>] OK, I can change the code in such a way that dw_axi_dma_set_hw_channel=
() will be executed only if apb_reg is valid.
>=20
> >         return vchan_tx_prep(&chan->vc, &desc->vd, flags);
> >
> >  err_desc_get:
> > @@ -684,6 +729,9 @@ dw_axi_dma_chan_prep_slave_sg(struct
> dma_chan *dchan, struct scatterlist *sgl,
> >                 llp =3D hw_desc->llp;
> >         } while (sg_len);
> >
> > +       if (dw_axi_dma_set_hw_channel(chan->chip, chan-
> >hw_handshake_num, true))
> > +               goto err_desc_get;
> > +
>=20
> Same here.
[>>] Sure, same method described above will be used.
>=20
>=20
> >         return vchan_tx_prep(&chan->vc, &desc->vd, flags);
> >
> >  err_desc_get:
> > @@ -959,6 +1007,10 @@ static int dma_chan_terminate_all(struct
> dma_chan *dchan)
> >                 dev_warn(dchan2dev(dchan),
> >                          "%s failed to stop\n", axi_chan_name(chan));
> >
> > +       if (chan->direction !=3D DMA_MEM_TO_MEM)
> > +               dw_axi_dma_set_hw_channel(chan->chip,
> > +                                         chan->hw_handshake_num,
> > + false);
> > +
> >         spin_lock_irqsave(&chan->vc.lock, flags);
> >
> >         vchan_get_all_descriptors(&chan->vc, &head);
> > --
> > 2.18.0
> >
