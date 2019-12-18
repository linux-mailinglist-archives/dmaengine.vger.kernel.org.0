Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 643811247FA
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2019 14:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfLRNWi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Dec 2019 08:22:38 -0500
Received: from mail-mw2nam12on2040.outbound.protection.outlook.com ([40.107.244.40]:49159
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726743AbfLRNWi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Dec 2019 08:22:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmUdJLgzcKwbIQG6tQ8x4OGTrHcH8dK2ObhbmFbI2+vMMvhmoTLRo1KRK0c31xgZpumm1RHO9q4eljwlfXG2jtfpsSXh6Z2gp6en8CpLAq2jaOSzh9MOuuaTqFe4kDRhfYC3X8hRPwLXNrme88YMtoh2o+HhLXxeJCWD+ZBjSaTXh3WJRNM450PVsdWYMLOm3oE2O0JT3Xr5fWDFB/fO2Zzt6YXoPZxuaT/FjfY6IouHQXq2hVwRL5tlsXOl5XppHr5aH4jq5zJEysenz/O5lWGYh3xn8iv5JF/xd4WXe3rHx8H5gClpYWBYTEUKP6GMGnUvkpbDiosGErhoDRgcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd6kHD+jLfCpO+ulSC3PXB+e2+hnzjIp6M3hitCQliM=;
 b=TGEAkuHEYQnbBFOd7TMiH6fdF0nkePwtvs1ovti2atZnUUsvGF0StKMLSyOZCErYHaf/7tM4dJA0hAFjNzYFhpdW9vAUnShVLAwH5pBaOwPsgzkOwCb5aQEkmSLBmsIvkZrS7Xc3IwqSohttW1TAz/hCJApN8+mNpd+fIwd8HKzde/Uw+wvaJMqzBn6hsonbQLrdpDYbShdCuNkh7QxB9d2cA7c1kNhHNtuH7ogzY7305cuGCLxFFOxK2hX28K0WKlczlXsEnBHIOMVNrG+QE3KkBWIxISraM6GZ37kk7NYEusZ6ozTKNXU5gslH2ruBUbVdLleM/SzL3LALXXnvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd6kHD+jLfCpO+ulSC3PXB+e2+hnzjIp6M3hitCQliM=;
 b=kTmlurvW58r093H3UKjPDxqn8hloF4H+Mio4gaLkZpj1TN4occrRXsqjyjxBm2PDQx5kilavjWFjiJZdDbsdPu2Lk1salkoe3obfT2BbB5X1k90n/9tLOSd171jF5dDsIfC9TMPySnPyb/mhhAFAbDPw1DcmWiAASWH9JCegzs8=
Received: from CH2PR02MB7000.namprd02.prod.outlook.com (20.180.9.216) by
 CH2PR02MB6999.namprd02.prod.outlook.com (20.180.8.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 13:22:34 +0000
Received: from CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::969:436f:b4b8:4899]) by CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::969:436f:b4b8:4899%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 13:22:34 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "nick.graumann@gmail.com" <nick.graumann@gmail.com>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Reset DMA channel in
 dma_terminate_all
Thread-Topic: [PATCH] dmaengine: xilinx_dma: Reset DMA channel in
 dma_terminate_all
Thread-Index: AQHVo1uM5nn5YHd560C/NFUjbNUe6Key97yAgAIaTxCACnlLgIAAebcQ
Date:   Wed, 18 Dec 2019 13:22:34 +0000
Message-ID: <CH2PR02MB7000C73DA877E4A45CF5EF0DC7530@CH2PR02MB7000.namprd02.prod.outlook.com>
References: <1574664121-13451-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20191210060113.GP82508@vkoul-mobl>
 <CH2PR02MB70009D78EA8C487BFFA54964C75A0@CH2PR02MB7000.namprd02.prod.outlook.com>
 <20191218060437.GQ2536@vkoul-mobl>
In-Reply-To: <20191218060437.GQ2536@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86375aae-4afc-47e9-c32d-08d783bd5827
x-ms-traffictypediagnostic: CH2PR02MB6999:|CH2PR02MB6999:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB69992E9870C207142C568774C7530@CH2PR02MB6999.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(13464003)(51914003)(189003)(199004)(66946007)(478600001)(64756008)(66446008)(4326008)(66476007)(66556008)(186003)(76116006)(316002)(9686003)(2906002)(107886003)(86362001)(71200400001)(55016002)(54906003)(81166006)(81156014)(53546011)(52536014)(6916009)(8676002)(7696005)(33656002)(6506007)(5660300002)(8936002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6999;H:CH2PR02MB7000.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XVqTdk9iMMewG+SOeWDmOWK9/DsvMfiRcrv2OG15hhI6cc3W/hIGEQGmbarJEIO6MRmTT45gLsytt4cPXk2pG3vwalyV9a7wVJgyZUq0kjHCmi7X5v+2hSfQeSRFrkrNFyq80P+CBpbtLOBWX4tbfZ8ujvdts4E0c5rwyrHzlVuvM73JLVSGAS2AznUF5CaN0iz2FoqZ418hJdFTOWPerRhaQseooGUqkRek6ZMFBufgch/gYe6cjoMLmCDDUnt3dt+SN7mWH7RuHNXQXUwh/PGcb/zpkn83Kcafeh4Qg35llnY2D59irQREnnXNg1MufhcJRn9A2VR6LZAy8sXEb59EJaPyG7VRpI5tsRzxhBHd7NAoDOG8aADj/u+RbWYM2CKsSAQkjcFjYxtXWp8UfavENMUBRBIdqoSl0j9eLI2nQbRiNDddsiQNCncuRg69MZKaHVUOMjQm7z75zIw+z4HVcTq8PLzP1HPAa83vOeqPixxzfeZcmY54he+iatf/XCLeKB+owu/VmpEq2XUqxQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86375aae-4afc-47e9-c32d-08d783bd5827
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 13:22:34.6605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YxWw/WfcNHTay8QBkHvfYnbIQxpp8GuHp9cPPq3Cg9r6fP9Bg7kA9WoYIXQi7jc3ruHU7GkwBOwKskRbGoJMTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6999
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Wednesday, December 18, 2019 11:35 AM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>;
> nick.graumann@gmail.com; andrea.merello@gmail.com; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; mcgrof@kernel.org;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; git
> <git@xilinx.com>
> Subject: Re: [PATCH] dmaengine: xilinx_dma: Reset DMA channel in
> dma_terminate_all
>=20
> On 11-12-19, 14:46, Radhey Shyam Pandey wrote:
> > > -----Original Message-----
> > > From: Vinod Koul <vkoul@kernel.org>
> > > Sent: Tuesday, December 10, 2019 11:31 AM
> > > To: Radhey Shyam Pandey <radheys@xilinx.com>
> > > Cc: dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>;
> > > nick.graumann@gmail.com; andrea.merello@gmail.com; Appana Durga
> > > Kedareswara Rao <appanad@xilinx.com>; mcgrof@kernel.org;
> > > dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; git
> > > <git@xilinx.com>
> > > Subject: Re: [PATCH] dmaengine: xilinx_dma: Reset DMA channel in
> > > dma_terminate_all
> > >
> > > On 25-11-19, 12:12, Radhey Shyam Pandey wrote:
> > > > Reset DMA channel after stop to ensure that pending transfers and
> > > > FIFOs in the datapath are flushed or completed. It fixes intermitte=
nt
> > > > data verification failure reported by xilinx dma test client.
> > > >
> > > > Signed-off-by: Radhey Shyam Pandey
> <radhey.shyam.pandey@xilinx.com>
> > > > ---
> > > >  drivers/dma/xilinx/xilinx_dma.c | 17 +++++++++--------
> > > >  1 file changed, 9 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > > > b/drivers/dma/xilinx/xilinx_dma.c index a9c5d5c..6f1539c 100644
> > > > --- a/drivers/dma/xilinx/xilinx_dma.c
> > > > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > > > @@ -2404,16 +2404,17 @@ static int xilinx_dma_terminate_all(struct
> > > dma_chan *dchan)
> > > >  	u32 reg;
> > > >  	int err;
> > > >
> > > > -	if (chan->cyclic)
> > > > -		xilinx_dma_chan_reset(chan);
> > >
> > > So reset is required for non cyclic cases as well now?
> >
> > Yes. In absence of reset in non-cyclic case, when dmatest client
> > driver is stressed and loaded/unloaded multiple times we see dma
> > data comparison failures. Possibly IP is prefetching/holding the
> > previous state and reset ensures a clean state on each iteration.
> > >
> > > > -
> > > > -	err =3D chan->stop_transfer(chan);
> > > > -	if (err) {
> > > > -		dev_err(chan->dev, "Cannot stop channel %p: %x\n",
> > > > -			chan, dma_ctrl_read(chan,
> > > XILINX_DMA_REG_DMASR));
> > > > -		chan->err =3D true;
> > > > +	if (!chan->cyclic) {
> > > > +		err =3D chan->stop_transfer(chan);
> > >
> > > no stop for cyclic now..?
> > After reset stop is not needed, so for the cyclic mode we only do reset=
.
>=20
> Okay makes sense, can you please add these as comments, down the line
> these will be very useful for you & others to debug!

Thanks for the review. I agree, will include the comments in v2.
>=20
> --
> ~Vinod
