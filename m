Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D1E2B9F67
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 01:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgKTAqm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Nov 2020 19:46:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:34199 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgKTAql (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 19 Nov 2020 19:46:41 -0500
IronPort-SDR: Uc21DwmSYHeWzGsgajG0yBJPeUjPaTbHBzruPtnYgSHX6M6k5luARUxIjIFUxwGSpOV4cSbbUg
 nIo4vXpKq5kQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="151239868"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="151239868"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 16:46:41 -0800
IronPort-SDR: abti+3GQKj0rV71/FbxvXQfi3aVVt2blPwQYZPhL668KxHR1fqNMbjDpOE2q37dAmndEyw9LQA
 DxozNo0KsoBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="326171269"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 19 Nov 2020 16:46:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 16:46:40 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 16:46:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Nov 2020 16:46:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 19 Nov 2020 16:46:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4lBChyL4PsUvvQ33KzeL4L0GzUaiCnppyWWUed8VNLs35EW7sXIR52NmUBKLlp17hgJ0q8v+FRL2eUY1G1aRmXLkniWrNo/yuQzxBJ24BgdEHIXiOIhTZwCBZZnV69+7MFibQ+rLcvuDYnxUf+njYipaLTG6RT+ObeGVHlxyk1uJge0OaHmlYzZVfrs3zPtdfiwwFiApBUBZV2zxjqUIYtYxXBnU8zgrhD7ywwlwP0HxW5DyRfibo8tBg+29uPF3K5CdYt8T5y3y3kWm36KNw6p97qNdGwfAXjADIFM25oUl/Fi0PopM/wwFcLYVfEx6BUmVjV4oqGpdDXU5SWJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpEZk/vMTTsnsoPrcC4REJJI5+gTpDST4EdD5JCAWEk=;
 b=GM4jfpZWafMxjEFizjk47/wgRKmvWmPVafT1F/PNgeSCc5nl9xMTElvgsEVE6Onp0xlreB3hn/CmT20Umy/PXJCtFpMTIeOvpt6kG/cQAgHXGMqX7SVPnIowJcCAuVo6qWVqhWHNbT1QT6TYTaBkvPAUTVCDlxA+o9pidzGvZoJd8IripaTCDH3fRCsRg/wo663EKlHcUTl39LTLULr9uILvHhUrsj3AHJyJZs99r6xOgBhnzXsDgYzUTKPCzqhtl4OsMoDBEI5/Ssd+WOMBImaW7OU+Is652cN1F1qD20++yq9s/QH+WnDjAb016dw9zo05aM/vZyt+IY8xCTB6lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpEZk/vMTTsnsoPrcC4REJJI5+gTpDST4EdD5JCAWEk=;
 b=wP002Czcz89G6ZK9BnmSrdNJbUOMPdZNDvatXZ+3mycLgRBYRwm7uEmWqmoPbiHzv9aAjC79lr8CSDZ87+vfXMCZRDQeiuN9xnm4+Kj9RjMNabYEeM1zChuh/ePkoUoCGB+9loGKNlK0029PsddhPhE9srSQbxVReO3lH3nr0HQ=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MWHPR1101MB2093.namprd11.prod.outlook.com (2603:10b6:301:50::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Fri, 20 Nov
 2020 00:46:38 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f%4]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 00:46:38 +0000
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
Thread-Index: AQHWvIranRliWUyoiUC041c/U0Xoy6nOkjKOgAGhikA=
Date:   Fri, 20 Nov 2020 00:46:38 +0000
Message-ID: <CO1PR11MB502675222991EE9CECE782F2DAFF0@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201117022215.2461-1-jee.heng.sia@intel.com>,<20201117022215.2461-14-jee.heng.sia@intel.com>
 <MWHPR1201MB0029177B655D2B57D636CAB0DEE10@MWHPR1201MB0029.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR1201MB0029177B655D2B57D636CAB0DEE10@MWHPR1201MB0029.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 7ed3d06c-fd15-47af-f061-08d88cedbd4d
x-ms-traffictypediagnostic: MWHPR1101MB2093:
x-microsoft-antispam-prvs: <MWHPR1101MB209335985621F25BE056ACBBDAFF0@MWHPR1101MB2093.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bb+KV46mPcwyLl7zWp73OZ3cTKTYWCzOsYuQgRN9++ryNRyIrTIrqHOb6Zm0KKI9+72seGr02w7F48mAuItcwPxf/qGHHphClXxBtvfVjUXWNhE42J1JT/t9odSWU014/Le1u2tB+QTccFt/4myeQsDzwjOi5/izzhXVopu6MZuf+wyigMxI44IRkEtzC/bIe+YMGb5stsRfEgr2HSDpa2k0xHvPV8b8DpwVn+OYbHGp51JiYBbilo0sXvzjQavQc8ayVvKtAzPE1xm0aKTXgM2auFeXBzt8Amu2SA7vwGm9oELuQqRCsJFINFXHU7Qx+CPLLI3ZaVmvUsGIGQIr3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(66556008)(71200400001)(316002)(4326008)(64756008)(2906002)(52536014)(53546011)(86362001)(8936002)(66446008)(76116006)(26005)(33656002)(186003)(54906003)(55016002)(8676002)(5660300002)(478600001)(66476007)(66946007)(7696005)(9686003)(6506007)(6916009)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZIGQBaasjbDbvWmzCvFIj62MV+VtRL/NXySsZnD3ANNerCXaLE9t/U8QuBpmKISg9JG64CyptXf1N8UEKI2AmetGMqxpBglnmMBL3THEJQP2QJs2vtfT4FFJRLd25Ac1ZosD+n7z+ZaJVAdKTmoYX8lh20uWw38/wytw2eHpVjM+cmF88LNVzHtDvqxILO8juewlpjCp8kqpui/yEgrj27xcpOYCzziE898BNJe5oaovAmLW69xhG3B5TPq5xXGOnVHCeSlBEgcWkh9qNNgKzdwtRO92fHs6Ri9GaargFZvjJ5P4fJPoZ6ug5qzr5R8xYZOuiaF5aWL/Bb1eMdeiejKmXgrYMyJyFuEunqOWKp/EsGkkmupAVdWNHqt0/x1wuuE85mXrz55tr6dODEAzwnyG2Fc30D9xX0BE4kYeDERvpZJAilJ3ZLgVZuV5JPNr8bejvI70e6N1VBj/jt8+I8RbTdVTWhs8YupLCs3KuWKQwVY3XwJ7P5ZwXVLFpvBeQx8MMUtxsTkn18uwuhe5bb4q2hTkNqAE9egAdLvMHVm0DVKrsVPMweDfeIXj/EiBa9bBlpN+aG86a7TXPOUlyIXiIYI5D/54q+QPnPq2g6eeSFAfQifLgDP4B2/NLD69VDJFwkzzpQ0IXRhm9Gk3N+FEdgunWVtG5LFhew2rT6KXkO+k3JoZMms91eTz2Ktgr72tcYgZp4rq3nHL9kqsC/CILPAyNfYs3u4EAw4Zud1Yp7pz7yPg/wVQvqJNA9rJ7DM+vuLlBa+Wnh2xLenw07locr4jEUKpbpfVgTlm1PT1k0heJ4VaFSsPYvklWHynZ6ejlxFytCZ4rEtq+UsuHl0y12Vs4hLGI4+/EZWtsH4/Exij9wRoPG0Ch8ygqDMmEC+HJSlaOb8RIL8J8ud+8g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed3d06c-fd15-47af-f061-08d88cedbd4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 00:46:38.3108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOY9d/bWvUxbmmC6OJwxCX7RSLkGY8UVdfLDRmIbBAyv+2RHylHOyPbht0FhItC73zAC4X9Cce7Am584iiviDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2093
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Sent: 19 November 2020 7:59 AM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v4 13/15] dmaengine: dw-axi-dmac: Add Intel KeemBay A=
xiDMA
> handshake
>=20
> Hi Sia,
>=20
> > Subject: [PATCH v4 13/15] dmaengine: dw-axi-dmac: Add Intel KeemBay
> > AxiDMA handshake
> >
> > Add support for Intel KeemBay AxiDMA device handshake programming.
> > Device handshake number passed in to the AxiDMA shall be written to
> > the Intel KeemBay AxiDMA hardware handshake registers before DMA
> > operations are started.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> > ---
> >  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 52 +++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > index c2ffc5d44b6e..d44a5c9eb9c1 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > @@ -445,6 +445,48 @@ static void dma_chan_free_chan_resources(struct
> dma_chan *dchan)
> >         pm_runtime_put(chan->chip->dev);  }
> >
> > +static int dw_axi_dma_set_hw_channel(struct axi_dma_chip *chip, u32
> hs_number,
> > +                                    bool set) {
> > +       unsigned long start =3D 0;
> > +       unsigned long reg_value;
> > +       unsigned long reg_mask;
> > +       unsigned long reg_set;
> > +       unsigned long mask;
> > +       unsigned long val;
> > +
> > +       if (!chip->apb_regs)
> > +               return -ENODEV;
>=20
> In some places you check for this region existence using if (IS_ERR(chip-=
>regs)) and
> in other places you use if (!chip->apb_regs)
>=20
> I guess it isn't correct. NOTE that this comment valid for other patches =
as well.
[>>] Thanks for the invaluable comment, will make sure the consistency in t=
he code.
>=20
> > +
> > +       /*
> > +        * An unused DMA channel has a default value of 0x3F.
> > +        * Lock the DMA channel by assign a handshake number to the cha=
nnel.
> > +        * Unlock the DMA channel by assign 0x3F to the channel.
> > +        */
> > +       if (set) {
> > +               reg_set =3D UNUSED_CHANNEL;
> > +               val =3D hs_number;
> > +       } else {
> > +               reg_set =3D hs_number;
> > +               val =3D UNUSED_CHANNEL;
> > +       }
> > +
> > +       reg_value =3D lo_hi_readq(chip->apb_regs +
> > + DMAC_APB_HW_HS_SEL_0);
> > +
> > +       for_each_set_clump8(start, reg_mask, &reg_value, 64) {
> > +               if (reg_mask =3D=3D reg_set) {
> > +                       mask =3D GENMASK_ULL(start + 7, start);
> > +                       reg_value &=3D ~mask;
> > +                       reg_value |=3D rol64(val, start);
> > +                       lo_hi_writeq(reg_value,
> > +                                    chip->apb_regs + DMAC_APB_HW_HS_SE=
L_0);
> > +                       break;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  /*
> >   * If DW_axi_dmac sees CHx_CTL.ShadowReg_Or_LLI_Last bit of the fetche=
d LLI
> >   * as 1, it understands that the current block is the final block in
> > the @@ -626,6 +668,9 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan
> *dchan, dma_addr_t dma_addr,
> >                 llp =3D hw_desc->llp;
> >         } while (num_periods);
> >
> > +       if (dw_axi_dma_set_hw_channel(chan->chip, chan->hw_hs_num, true=
))
> > +               goto err_desc_get;
> > +
> >         return vchan_tx_prep(&chan->vc, &desc->vd, flags);
> >
> >  err_desc_get:
> > @@ -684,6 +729,9 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan
> *dchan, struct scatterlist *sgl,
> >                 llp =3D hw_desc->llp;
> >         } while (sg_len);
> >
> > +       if (dw_axi_dma_set_hw_channel(chan->chip, chan->hw_hs_num, true=
))
> > +               goto err_desc_get;
> > +
> >         return vchan_tx_prep(&chan->vc, &desc->vd, flags);
> >
> >  err_desc_get:
> > @@ -959,6 +1007,10 @@ static int dma_chan_terminate_all(struct dma_chan
> *dchan)
> >                 dev_warn(dchan2dev(dchan),
> >                          "%s failed to stop\n", axi_chan_name(chan));
> >
> > +       if (chan->direction !=3D DMA_MEM_TO_MEM)
> > +               dw_axi_dma_set_hw_channel(chan->chip,
> > +                                         chan->hw_hs_num, false);
> > +
> >         spin_lock_irqsave(&chan->vc.lock, flags);
> >
> >         vchan_get_all_descriptors(&chan->vc, &head);
> > --
> > 2.18.0
> >
