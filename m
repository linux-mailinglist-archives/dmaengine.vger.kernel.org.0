Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5121311AE22
	for <lists+dmaengine@lfdr.de>; Wed, 11 Dec 2019 15:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfLKOqw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Dec 2019 09:46:52 -0500
Received: from mail-dm6nam11on2073.outbound.protection.outlook.com ([40.107.223.73]:6248
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729278AbfLKOqv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Dec 2019 09:46:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+rcO7bTCQIKPxX8gERUX6cz/7MAtwWtVRZAKLxGKmhjpR38ttm3K4ZWs84Y7zP97RzkuEDNmclPhu67Rn0Rc3nep4fXNdHcigItpTl5w9DjMx2KW5E7lPlB6kxZrKZkX55juC25jkLLgIvr3Mou3wDZwwjlq9NDwoIUdBaep7r3WR6HrpLwIQ1B8TQ7w+Ls++SV5c6sIB7TjKivrAVW98Wq6AL8Z6xjlyJPgH3ZPAbuWacdu1+kd2KhYBI58z+oyHcGye5X47g8N58TPtHP+yRPmWE0p3eDDCghHOL9j3yfQ1fcVg40iTa/QX33X9uraF+GxNNF4oW5bSh3egxp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdv3xy29Ew/4mwo89L0xX6a2q6ZWQwmDFj9NDkwLk3c=;
 b=loLVyd+Qlz046zjbDxbbFP5vKYP4IP1yQZL+o7BwlnfyGdiuD9Gncn2CX/SVgFDcLneB1W5DRGM9J2mu80qZN2r2NHGIxtMmsZuo5x5C0FERLxCcAKfSeCEBlOtPTgvY3CMsUw05+JgpmGsNdd/Pav2c67QHZK9/h2wKn6vdBm2pcmK3ktTeRMZnvcP7SFaQlvnSNeKpc60uPhoAr82wcUZ63AxX7NMY1fTeXiY3zAl5bx2rdbwzA27cH9iJGi2MkD2K018sSNKHiljI6N7PdMV5FvEuMxqup6In2J2l0viAgLSFZmmVC61cXjfckZeSkJzwaUUKNVp1b63gAA5Rig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdv3xy29Ew/4mwo89L0xX6a2q6ZWQwmDFj9NDkwLk3c=;
 b=Wn15tCuqROGkjSZ09yo2fGdby/PJ6tS9LDCeI5h6Oj+qHRoGjYG+FAQbJLafPSrcrEqpzkT7J6JI6535RU4jMaJuC05ewLUfsNsj3coqVFzeY/FuBCfKEseWatIv+zbqrr/4lVEbXeGO0/KhcqMp3tFk+fY/elbtyTF3tchFWSc=
Received: from CH2PR02MB7000.namprd02.prod.outlook.com (20.180.9.216) by
 CH2PR02MB6039.namprd02.prod.outlook.com (10.255.156.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Wed, 11 Dec 2019 14:46:07 +0000
Received: from CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::5d66:1c32:4c41:b087]) by CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::5d66:1c32:4c41:b087%3]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 14:46:07 +0000
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
Thread-Index: AQHVo1uM5nn5YHd560C/NFUjbNUe6Key97yAgAIaTxA=
Date:   Wed, 11 Dec 2019 14:46:06 +0000
Message-ID: <CH2PR02MB70009D78EA8C487BFFA54964C75A0@CH2PR02MB7000.namprd02.prod.outlook.com>
References: <1574664121-13451-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20191210060113.GP82508@vkoul-mobl>
In-Reply-To: <20191210060113.GP82508@vkoul-mobl>
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
x-ms-office365-filtering-correlation-id: ef0dec40-0481-4d15-5cd0-08d77e48daea
x-ms-traffictypediagnostic: CH2PR02MB6039:|CH2PR02MB6039:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB60398A17E15599DA0D2CCBA1C75A0@CH2PR02MB6039.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(13464003)(199004)(189003)(53546011)(6506007)(26005)(33656002)(7696005)(52536014)(186003)(71200400001)(5660300002)(54906003)(66476007)(4326008)(64756008)(66946007)(76116006)(6916009)(8676002)(9686003)(478600001)(86362001)(316002)(107886003)(81166006)(66556008)(8936002)(2906002)(81156014)(55016002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6039;H:CH2PR02MB7000.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PUn7PqYLM3gQYoFo5910B6QAXDsjEa8Y11OSjEEgiiVEua5rbGsUxlrR7/KiV3+WDYfs0qtWPb8bOvzBROAqU1yzazf3JkBplxuhiN4+bjg8iYQnr7f7GlCcat88R/ZEhH5fpjpNlMMpTHrpWvgNbM8gZARUYiwPDCnvKyiyqHp61Ywp2cXgIjoukTsRV2GoqRdBmCXS+67pXH3v9S/d1vy7h7tR6/tQ2WB0i+lSb97IRxE3hcCuwnqmnuMdvyk4xnHPeOu5teKLI656qnp+e6H0kcS+FLKH0JuCc0AfwWTwNZKkGLGz1eYP7MZgULvH1rSBXN3POy9WAFhtbWhA0q0EUx4ts9xsK5gdB2R4Jv18N7LwFlT4IPXcwRZTkb66DphpsG5AtuYp5HfPGnPQriznE/25AVAfrAv3zrUEmFcqGvmeD+z97tM8Nvylhlh1Jl/57h8V551Xerc2ymx9OqThjNLokSObCz2q2kQs2XF7ic/U0uU5a+45emoHvjq4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0dec40-0481-4d15-5cd0-08d77e48daea
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 14:46:06.9820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/y7fQpR/hiFMEAHvZue0wZq0viLsZsFdSRQSo6+6vqeIwqOvEafgGsAnvQDbV8hVNJTAcWegITq5NwGaSOk1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6039
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Tuesday, December 10, 2019 11:31 AM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>;
> nick.graumann@gmail.com; andrea.merello@gmail.com; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; mcgrof@kernel.org;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; git
> <git@xilinx.com>
> Subject: Re: [PATCH] dmaengine: xilinx_dma: Reset DMA channel in
> dma_terminate_all
>=20
> On 25-11-19, 12:12, Radhey Shyam Pandey wrote:
> > Reset DMA channel after stop to ensure that pending transfers and
> > FIFOs in the datapath are flushed or completed. It fixes intermittent
> > data verification failure reported by xilinx dma test client.
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > b/drivers/dma/xilinx/xilinx_dma.c index a9c5d5c..6f1539c 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -2404,16 +2404,17 @@ static int xilinx_dma_terminate_all(struct
> dma_chan *dchan)
> >  	u32 reg;
> >  	int err;
> >
> > -	if (chan->cyclic)
> > -		xilinx_dma_chan_reset(chan);
>=20
> So reset is required for non cyclic cases as well now?

Yes. In absence of reset in non-cyclic case, when dmatest client
driver is stressed and loaded/unloaded multiple times we see dma=20
data comparison failures. Possibly IP is prefetching/holding the
previous state and reset ensures a clean state on each iteration.
>=20
> > -
> > -	err =3D chan->stop_transfer(chan);
> > -	if (err) {
> > -		dev_err(chan->dev, "Cannot stop channel %p: %x\n",
> > -			chan, dma_ctrl_read(chan,
> XILINX_DMA_REG_DMASR));
> > -		chan->err =3D true;
> > +	if (!chan->cyclic) {
> > +		err =3D chan->stop_transfer(chan);
>=20
> no stop for cyclic now..?
After reset stop is not needed, so for the cyclic mode we only do reset.

>=20
> > +		if (err) {
> > +			dev_err(chan->dev, "Cannot stop channel %p: %x\n",
> > +				chan, dma_ctrl_read(chan,
> > +				XILINX_DMA_REG_DMASR));
> > +			chan->err =3D true;
> > +		}
> >  	}
> >
> > +	xilinx_dma_chan_reset(chan);
> >  	/* Remove and free all of the descriptors in the lists */
> >  	xilinx_dma_free_descriptors(chan);
> >  	chan->idle =3D true;
> > --
> > 2.7.4
>=20
> --
> ~Vinod
