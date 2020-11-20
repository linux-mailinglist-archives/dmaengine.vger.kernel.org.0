Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DD22BA53F
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 09:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgKTI4k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Nov 2020 03:56:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:64567 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgKTI4j (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Nov 2020 03:56:39 -0500
IronPort-SDR: m2eGyCc2z49k8d0DDH/+htGpZ9bmqqWDBf0Cu9Sfc6kQ5YWVQyBWY82kAxGqUl14wp5TF3oqRC
 IC817ZEfr87g==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="167929965"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="167929965"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 00:56:39 -0800
IronPort-SDR: pr7YBjOONhgkk0kXi1Chlf0YQXl5MlE91XeE+xN+57fHuJXMcrVi+cQgIBpP6KpywGcuFQBWDE
 XpQ6zWucd7mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="533484301"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga006.fm.intel.com with ESMTP; 20 Nov 2020 00:56:39 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 00:56:38 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 00:56:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 20 Nov 2020 00:56:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 20 Nov 2020 00:56:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zvv2UTNoWA9RachenIg0tkjHN87xEiTqkWZjZFuoBsqCuE4E9VL13s4GMxYGd28NhHPgxbuGxFZDIHymn+9BmsvE++FNqWeWrMq4kubzEQAdu5hBnBOUPh1+pKXB/G3HQIQzA1bBNNPfUNoq4A++qkllYOqy91GLrlswElS37iJ86jBC2l/oDZJQP0y9oka2cE+XLx/9p6WirgenIzh5uzap2aZrYgW1/9BuVpI0DOY3qiK/Dp0ogy+9FTH5U4y5jLuDevmP7Ex/A/OFqfB53kOCEqyzWRUPGmKTdKMDr7wyFmFykKScl4lHlm3KWBoAF2wgUGLPl1IXBRPHywXeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32TEqE5FSttrSXfMwmC5QwNe/Q4YIiiDgBdzKVzf/xI=;
 b=JzKBWQO/SJ4v5XkVLLJ6zMdB//ZfIDhKt49U1O1TCEpKt5uf8LV09i1eSKlufkiygVuFJeojDibNm3vnd7b/sMM6CdIWbk7uI/vVCLOUbNZBvM8ppW9VURNibXSoJKaxhnNUt2tZjTQt6BVl3VfVg9DR32Bhlbe9uN0mt7diAZla2whg5hvrlNAeEJqlB6qePue6futMbWslSLXJaMRbDeRvQnIgpWQE24D10BZVLIr2tIxx/OzjRVMwKk+PNpTas88tk4Frdw3n7tu+frZq4GTKPwYjrOridcMK0ObDI0TJ+EQPRrxW1TdeoUVc+06gXtIURcf1XfuZ5mc0J9nbHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32TEqE5FSttrSXfMwmC5QwNe/Q4YIiiDgBdzKVzf/xI=;
 b=fNNgdLoRjHTw49SFn6MhkonLXnB3mSCtu/jrlfev9RBuJdiXDybItF/oyJBNUIWUKWXME/lTt3gVqZ5GQ9ObcTA04wHXeuN3WtVHTdGIczohl3kUL8ix73MXs90bdrrCOzBvAKCxkexLjSXDQw0VHYUEczaJ3x1n8h5alXDBDh0=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MWHPR11MB0063.namprd11.prod.outlook.com (2603:10b6:301:6c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 20 Nov
 2020 08:56:35 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f%4]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 08:56:35 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 13/15] dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA
 handshake
Thread-Topic: [PATCH v4 13/15] dmaengine: dw-axi-dmac: Add Intel KeemBay
 AxiDMA handshake
Thread-Index: AQHWvIranRliWUyoiUC041c/U0Xoy6nOkjKOgAGhikCAAIM/wA==
Date:   Fri, 20 Nov 2020 08:56:35 +0000
Message-ID: <CO1PR11MB502626E7EE93B74E20BBB437DAFF0@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201117022215.2461-1-jee.heng.sia@intel.com>,<20201117022215.2461-14-jee.heng.sia@intel.com>
 <MWHPR1201MB0029177B655D2B57D636CAB0DEE10@MWHPR1201MB0029.namprd12.prod.outlook.com>
 <CO1PR11MB502675222991EE9CECE782F2DAFF0@CO1PR11MB5026.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB502675222991EE9CECE782F2DAFF0@CO1PR11MB5026.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: e87b6b0a-c358-4835-5fbb-08d88d322f44
x-ms-traffictypediagnostic: MWHPR11MB0063:
x-microsoft-antispam-prvs: <MWHPR11MB0063A77EDFAC46A3DEE1DCC9DAFF0@MWHPR11MB0063.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bLkhtynce5rFXyIDHtpipqyLey4Y3lDLP7yqLSU8ofP/I1IzOP/yukCwAZd0eh25KBmTEmxhjWuIBmf8RPiMxO4VEaNVsJNU3XJv3E+c7PfPp7bOw/vocBtnVvxM7S1BwS022JH0XaimijVtojIhzmsICjNAbuydx/68GunOZVtQlebZorHC59bINQAiDbOifhgyyYunyyxF2pULQcsm+o50Ow002UipV932Z6IXo1gp+EVVL1a1s/FMRBi1QL9s7CyV+1TingjL0DrwzNvv8MkUMjBJv/upzy+g5CsQv+sG2InzozLvi1Mk3OeSD+nusQAbeYQdl85dQOKyNvit/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(2906002)(6916009)(8676002)(186003)(8936002)(6506007)(26005)(83380400001)(2940100002)(33656002)(9686003)(4326008)(52536014)(54906003)(55016002)(478600001)(71200400001)(76116006)(53546011)(5660300002)(66446008)(66476007)(7696005)(64756008)(66556008)(86362001)(66946007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5yo9HgKvtKS1dRWWtXD2I9r240Miy/u+aLPJDVD/6FRQ36xPIK+4W3LyCiZUgTrk5qAyf9Yp45a/e4PUW+2MnVr6yqSAdtg425c9WBiBamXcD0N/4PkP7cwy1n7hbr5zni7iu4mOR3HW8SZejRIpoT2f1KDA9y/av9amuSVX2NUGgjrToLXrIjUO9jkY+etNu6ikfxfzARKXJYJRdjwFnYyF1Rc371Et/ILGdJZJVh7UDOA1+sCPUr+cr5LVWFJFxVi77j+Gwe9VXRXvo3b5EOF5ZJkAi5aeCAYJq8xRe7XgdVFfHWJ2GJMt4F9dM03+P4wjjyCml20lMKp2yBApcRTZ+wtONY1dWsWl3FmCRFI+kcWyC/DKMPfQmZThz4XJxlrzp8TtHWoAKm95iSxqFVMjgKlDlbfiQNQRSo0vtZ6f3nQxUG7CJlNb8VQRQbYlEev8qTsmew2SRftui/j85cpXBhbOPI64SD8pU/XnIO5pMOtCzqs87qtCQPpt9LqWSJvDT1/FVmDgjtau2PKMcu1t2AQBd4E0N6i3hAACryP/RuIL+8/aUhJFS/rtQkH3yvT5nnc7Wg79HcGS+1jSHbskRwXbxJpk35a1/hR4ZhOcRFvdzD1pphxv+cEFL7ThNh032flH6nuf3vrCO0Cj1cqicHiAmgpwUZnQEMUWF5b07HsP4xi8gNP83c4jgST/oGcYOduQOsKviQyJyIXwDGvr39I+R4RLgPfgsARbCzEshsgRebdl59jnpA4JW6cxs3TS5zxeBzFqh+a9VPk69VvXGnhfUffmvyWR4Vj2qp5OirvFiUsY1ZHGbTaEx4Xh13uozQkleFMa895XJpm7PF9ONuQ6Ef5wVZTa9Ed6grwvEJ1eiYyS6u8gHiqD5aJvAEtTbxEndjSGMj8QqvcHFQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87b6b0a-c358-4835-5fbb-08d88d322f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 08:56:35.2442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQTU6HG3qLXQjB5T1SYbu/ai0QowRd+Fq4kbitRjoyAkda8Zq4olnnvehrwy9OUpofvX9n/qqKQPq9HeEqSwDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0063
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Eugeniy,

With regards to the below comment
> > In some places you check for this region existence using if
> > (IS_ERR(chip->regs)) and in other places you use if (!chip->apb_regs)
The main reason of using IS_ERR() is because of the ioremap() function retu=
rn an error value
if the mapping failed.
And now with your suggestion to add conditional checking to the compatible =
property, the chip->apb will
remain NULL on non Intel KeemBay SoC. Therefore, the "if (!chip->apb_regs)"=
 condition will be used instead.

Please let me  know if you have other concern.

> -----Original Message-----
> From: Sia, Jee Heng
> Sent: 20 November 2020 8:47 AM
> To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: RE: [PATCH v4 13/15] dmaengine: dw-axi-dmac: Add Intel KeemBay A=
xiDMA
> handshake
>=20
>=20
>=20
> > -----Original Message-----
> > From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > Sent: 19 November 2020 7:59 AM
> > To: Sia, Jee Heng <jee.heng.sia@intel.com>
> > Cc: andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org;
> > linux- kernel@vger.kernel.org; devicetree@vger.kernel.org
> > Subject: Re: [PATCH v4 13/15] dmaengine: dw-axi-dmac: Add Intel
> > KeemBay AxiDMA handshake
> >
> > Hi Sia,
> >
> > > Subject: [PATCH v4 13/15] dmaengine: dw-axi-dmac: Add Intel KeemBay
> > > AxiDMA handshake
> > >
> > > Add support for Intel KeemBay AxiDMA device handshake programming.
> > > Device handshake number passed in to the AxiDMA shall be written to
> > > the Intel KeemBay AxiDMA hardware handshake registers before DMA
> > > operations are started.
> > >
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> > > ---
> > >  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 52 +++++++++++++++++=
++
> > >  1 file changed, 52 insertions(+)
> > >
> > > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > > b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > > index c2ffc5d44b6e..d44a5c9eb9c1 100644
> > > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > > @@ -445,6 +445,48 @@ static void dma_chan_free_chan_resources(struct
> > dma_chan *dchan)
> > >         pm_runtime_put(chan->chip->dev);  }
> > >
> > > +static int dw_axi_dma_set_hw_channel(struct axi_dma_chip *chip, u32
> > hs_number,
> > > +                                    bool set) {
> > > +       unsigned long start =3D 0;
> > > +       unsigned long reg_value;
> > > +       unsigned long reg_mask;
> > > +       unsigned long reg_set;
> > > +       unsigned long mask;
> > > +       unsigned long val;
> > > +
> > > +       if (!chip->apb_regs)
> > > +               return -ENODEV;
> >
> > In some places you check for this region existence using if
> > (IS_ERR(chip->regs)) and in other places you use if (!chip->apb_regs)
> >
> > I guess it isn't correct. NOTE that this comment valid for other patche=
s as well.
> [>>] Thanks for the invaluable comment, will make sure the consistency in=
 the code.
> >
> > > +
> > > +       /*
> > > +        * An unused DMA channel has a default value of 0x3F.
> > > +        * Lock the DMA channel by assign a handshake number to the c=
hannel.
> > > +        * Unlock the DMA channel by assign 0x3F to the channel.
> > > +        */
> > > +       if (set) {
> > > +               reg_set =3D UNUSED_CHANNEL;
> > > +               val =3D hs_number;
> > > +       } else {
> > > +               reg_set =3D hs_number;
> > > +               val =3D UNUSED_CHANNEL;
> > > +       }
> > > +
> > > +       reg_value =3D lo_hi_readq(chip->apb_regs +
> > > + DMAC_APB_HW_HS_SEL_0);
> > > +
> > > +       for_each_set_clump8(start, reg_mask, &reg_value, 64) {
> > > +               if (reg_mask =3D=3D reg_set) {
> > > +                       mask =3D GENMASK_ULL(start + 7, start);
> > > +                       reg_value &=3D ~mask;
> > > +                       reg_value |=3D rol64(val, start);
> > > +                       lo_hi_writeq(reg_value,
> > > +                                    chip->apb_regs + DMAC_APB_HW_HS_=
SEL_0);
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  /*
> > >   * If DW_axi_dmac sees CHx_CTL.ShadowReg_Or_LLI_Last bit of the fetc=
hed LLI
> > >   * as 1, it understands that the current block is the final block
> > > in the @@ -626,6 +668,9 @@ dw_axi_dma_chan_prep_cyclic(struct
> > > dma_chan
> > *dchan, dma_addr_t dma_addr,
> > >                 llp =3D hw_desc->llp;
> > >         } while (num_periods);
> > >
> > > +       if (dw_axi_dma_set_hw_channel(chan->chip, chan->hw_hs_num, tr=
ue))
> > > +               goto err_desc_get;
> > > +
> > >         return vchan_tx_prep(&chan->vc, &desc->vd, flags);
> > >
> > >  err_desc_get:
> > > @@ -684,6 +729,9 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan
> > *dchan, struct scatterlist *sgl,
> > >                 llp =3D hw_desc->llp;
> > >         } while (sg_len);
> > >
> > > +       if (dw_axi_dma_set_hw_channel(chan->chip, chan->hw_hs_num, tr=
ue))
> > > +               goto err_desc_get;
> > > +
> > >         return vchan_tx_prep(&chan->vc, &desc->vd, flags);
> > >
> > >  err_desc_get:
> > > @@ -959,6 +1007,10 @@ static int dma_chan_terminate_all(struct
> > > dma_chan
> > *dchan)
> > >                 dev_warn(dchan2dev(dchan),
> > >                          "%s failed to stop\n",
> > > axi_chan_name(chan));
> > >
> > > +       if (chan->direction !=3D DMA_MEM_TO_MEM)
> > > +               dw_axi_dma_set_hw_channel(chan->chip,
> > > +                                         chan->hw_hs_num, false);
> > > +
> > >         spin_lock_irqsave(&chan->vc.lock, flags);
> > >
> > >         vchan_get_all_descriptors(&chan->vc, &head);
> > > --
> > > 2.18.0
> > >
