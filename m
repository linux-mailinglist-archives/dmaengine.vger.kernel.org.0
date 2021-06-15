Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B8E3A73B1
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jun 2021 04:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhFOCZo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Jun 2021 22:25:44 -0400
Received: from mail-eopbgr130070.outbound.protection.outlook.com ([40.107.13.70]:40195
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231715AbhFOCZi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Jun 2021 22:25:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsrfGUV0I3DFgoirFjqH/scj0PxCGIX7Cf9bJ+RSECi1AyOOEt0rEzkoG9/hJgdU6Zt9RRorhwxs+2//vnFndaWPVvs+61Iigc3U/2TIHVgfLxdAkF4oNRV3IooVMeejFWjuhNCXzo0j9WLgqmRubOqfNbdRIhfrVs86yZ1i8BQHXlTXKOHnaRMzVbSEtdGZvIuVXPMAEiexDcOfbW7vfQf3Y79GCijiAq1lcGnIadQYBOCDri7AgQe/xbJo7zRMveAaLrxkruQtLbyOjFDUf1fvG5c6JwAIwR6aIwrzyTaaHeU6a6ncS0O/iTNgRdEBypvKzjGo2dzjg3kHkPwd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4YrhForA6w/ND66WhGbTtRF8Y0sfAhLgkTM+Y7lfOM=;
 b=AopZ08hcAUgqLyv+9rmDh1TXYQG689VJYnx34X7oKd9Mt8b8ZtILgzxwDQHuWXqyF6QugS0P0m04vz51V8hIteiIGgzda1XRS59aACM7gkuEqiacTkU0EyGzNTbhO1aYc78Bz++bdiFHbT7+CKbiaYNuhPViKJ4GvUK54eu97zvz1suTmjzt/3IVv6lwwHhxglyqbCYSGfzhKP7xVQcd7gJxSa5tr9NdJ8oF09ECTy5Zq+Xb+U+FDe2XtQ6Wx3lPnElauUxyuV0zgW3YG2ZHEO19cwZKQKUXNCBZPZ+Qe97UaDEEaytoj+n1qnDuR03b4B/9yEG8nY8W2PQYSKrKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4YrhForA6w/ND66WhGbTtRF8Y0sfAhLgkTM+Y7lfOM=;
 b=nArw1RXdKYmBmgFMAl+U1Hjlx2/rkTjtQVoG1/ythFOFmussIHXqYIx+FjHavT4BOIWBOkI23HsvXXnV5zlUYvK0PHdat3XYVd5mBNehRGRBqXBiRJDgIKcRjtmmiVJ5sVh4bRh5tNsyHK1FK38N9Alsp96u2DuWWzqfAd9tjyI=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4736.eurprd04.prod.outlook.com (2603:10a6:803:5d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Tue, 15 Jun
 2021 02:17:42 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::ed27:a6b2:74fc:8ef2]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::ed27:a6b2:74fc:8ef2%6]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 02:17:42 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Vinod <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Clark Wang <xiaoning.wang@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v14 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: [PATCH v14 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Index: AQHXK33LUkqD6t3KUUabL8+87acFPqsUwNUAgAAAZTA=
Date:   Tue, 15 Jun 2021 02:17:42 +0000
Message-ID: <VE1PR04MB66885BAC7032D643F308A2F989309@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
 <CAOMZO5CVyaOXNxwv9hKV3RB9Q4kzW4VchEeBj1=b9PvHkskcow@mail.gmail.com>
In-Reply-To: <CAOMZO5CVyaOXNxwv9hKV3RB9Q4kzW4VchEeBj1=b9PvHkskcow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d62242da-1f38-4689-a28e-08d92fa3c1cf
x-ms-traffictypediagnostic: VI1PR04MB4736:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB47362705A8F24023B45F96A389309@VI1PR04MB4736.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ypTfiI2qd/XzEWzdgV9dTV1vyQiJ3YyqrqKTlzrOpuSb7ckYQRa+ZJg2OwyQoWUQj6M+kmmH+2ZDdOgyzRLIoEt9CIC5jeWneyN3C7wW19/dewViT7MOq9MytlGTqDlxDmu/Fkz+wCpzKwCeiVuKPPJoEqQbPhDGL06xZS46IckK7ida18Hu3ky2Lq84wTV0ACHH44tpsRkgCJ2IVJyFQzNx87YkDa0vdOJAvzMkoKG90O29bp4YgJXTdtKg4KWhhK1wx6stWSkbaC+NRqf3aoOcF0FDXoVRZRk2Sc9B4y6SCiOSSjfliiaB58idn04c1hGEDN3B8G8r6F/Pe1j55TN4cWd8M+fH2MgjNraXYmx1SKuXXJ0keRmBZIow2F/4jLEDMhvFaSJL8UMQ+dVG5IVmH3W+rB0VMQYIqhD5Zq8LBbIsfRelkiadEdNfgt9YD3Ohx2IiugZRvZQ2XVBIuSvAZ6/FvjIwwy1jY0oMIg24rYHQx1jRmFGLvzD0djYSVFX/E8p4suEKWjoEgmLN1elN7szD+SNbU63sTzO73cU4ZRui/gNE8fLvzZJvLxq/2QChH6DL1KuCqO83L1jQYIV173dCTXmBAwP+d5cvLap6yZHmuTWQv0R+sNeq9n0zUWMMckt6sO2rDD7UkO7xbrKYq9+s5uLrGSEbrzD2d7HKpxjKb0k6bHGkEBFSf9uXFzGhuX/e0FveCEMPdEz9nA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(478600001)(54906003)(38100700002)(122000001)(966005)(8676002)(7696005)(86362001)(316002)(2906002)(71200400001)(9686003)(26005)(76116006)(66446008)(66556008)(64756008)(33656002)(6916009)(8936002)(4326008)(66946007)(7416002)(66476007)(52536014)(5660300002)(6506007)(53546011)(83380400001)(186003)(55016002)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FtFFmobDRlwgcA6JIZjM+7/MtQM2vhyNZ5g09vLRpac/QH2bxjW1Lx38Zr?=
 =?iso-8859-1?Q?zH3R8fFhfhd4jJxOga7JWP9GXfXUlUOzukHWr94zOlHgjAHbE0AOW0WY1J?=
 =?iso-8859-1?Q?bdQRbwtsANwnDs3Iyx5pwRjIgyy3vD0EIOmPkZsmoRmQwsyD8QN9WN4YB3?=
 =?iso-8859-1?Q?LFW/8MXqf08/2h63Fy9ucg40kQZw2Isg/5+euWsURMo6lX1W/Vbyjuqv9G?=
 =?iso-8859-1?Q?+DDixREMAULXv+wwJkawcFjnvFLN2KBOLTe/g58L/9HdKZK9jOdGqyz2Xi?=
 =?iso-8859-1?Q?Qf8EEE3SaEA+jL9MlieDFfl4yP1h/O2jdpusbJtyF0p2DQLAmn/Lfh4Off?=
 =?iso-8859-1?Q?qEwYiZeVECDi3+XLVh0/R+hRp2NKelHMSMytVEn6SrTWqRj61UQ09eoBz4?=
 =?iso-8859-1?Q?ufAgZWhWLFceUC99pat2vhL7RFgeWZ/g6LKSWe8f1AThKU5hpDZPsyu1OR?=
 =?iso-8859-1?Q?UojArP2OWyafmlWHK+EH4+zEY7d2d4f9RoDrEyKW5di1C2Z4Yavj3pFtua?=
 =?iso-8859-1?Q?4zPp/f7494d8smAR24HF4e/VNT74zq7F5jlCWozUPF8KzOn0LvSTN0BQHM?=
 =?iso-8859-1?Q?PqqMffquXYo1tfzmwQpvMG6wSm9iBExUTUKwNPNHoG4cbW/wgWGA6yLEdo?=
 =?iso-8859-1?Q?JI5m4uxodhIHV+gFk5VQSYgsuAsFroefNV3w+8byz/FXAXHZSNsyCf7esF?=
 =?iso-8859-1?Q?OOHIHhrv2NlZ6W/sQ12e2TzLGL022cRvi8BFrcGLw+zniCXMMsgDMCRGoe?=
 =?iso-8859-1?Q?nJAxAZkR3EpsRWKppahEjN+16grKZ2G0l//1GAHgU1nchk7LJtfhZe03/u?=
 =?iso-8859-1?Q?NbC64dDr2U6JjZ8LJB0ZoZdqOZZ3eV5Z+k29YWDfb7CrldHJB2yGfn2q/m?=
 =?iso-8859-1?Q?sEeqnSow7QEby1bfiUCq+PbWqp0SmaahhhdqlKItXnnDq9zgFtlKia9AGw?=
 =?iso-8859-1?Q?mLsDrXoGE5GwybZYp3M+tcnlKW4mQ7JueriXfoXA67lbvn+nTj5EmuGicd?=
 =?iso-8859-1?Q?mF/YNrm0e7VcDO7NEeDzWOCMarAQ8QvvObmnP9xOrur6fLZqdd2kaRTZf1?=
 =?iso-8859-1?Q?w6S9g4dPJkRu+0ahyF1KhqM/oV6K3Y0pbYYPu496L78lc8Dd5yqAUWzB8N?=
 =?iso-8859-1?Q?Nxume3iNIJNdMYdpU8rPGDuba8m7SRcraE1TO5wvsyJ0yua5wx+jkUZ7Xj?=
 =?iso-8859-1?Q?yW00jc9oJG5+svLhcj8SDz7desK2xxGVF2u5jV1nk0/EI2oFRJAVJcjOmV?=
 =?iso-8859-1?Q?B4iYIascz0W+UEQsxZ2eXeTwhNIhjmdcitmGMXi/oareUresM2c1v9B3BI?=
 =?iso-8859-1?Q?iuPb+qbvSEJSwsFNmKMTsrqAQJivH5EF/m/efjA8sq+xA/kCuZLoLTHodv?=
 =?iso-8859-1?Q?dNr+QzHMSe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62242da-1f38-4689-a28e-08d92fa3c1cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 02:17:42.5571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76gPbrV31qxOIQz3MbSHXZhh0W5Ak1cChtqcBMXq/+CP0yljut7FSwKcq72TKC35DS+1RY1tDRAKUmNdMHFIGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4736
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06/15/21 10:13 Fabio Estevam <festevam@gmail.com> wrote:
> Hi Robin,
>=20
> On Wed, Apr 7, 2021 at 4:15 AM Robin Gong <yibin.gong@nxp.com> wrote:
> >
> > There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> > transfer to be send twice in DMA mode. Please get more information from=
:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.
> >
> nxp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D04%7C01%7
> Cyibin.g
> >
> ong%40nxp.com%7C3c61a5cfd0574c1bc4eb08d92fa31257%7C686ea1d3bc2
> b4c6fa92
> >
> cd99c5c301635%7C0%7C1%7C637593199700307681%7CUnknown%7CTWF
> pbGZsb3d8eyJ
> >
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C1000
> >
> &amp;sdata=3Dg2%2FwpDG22czIhj7ELil2kiiGPG0d74Ac7D8H3g0YtJc%3D&amp;r
> eserv
> > ed=3D0. The workaround is adding new sdma ram script which works in XCH
> > mode as PIO inside sdma instead of SMC mode, meanwhile, 'TX_THRESHOLD'
> > should be 0. The issue should be
>=20
> Could you please confirm whether the sdma-imx7d.bin firmware available at
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ern
> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ffirmware%2Flinux-firmwa
> re.git%2Flog%2Fimx%2Fsdma%2Fsdma-imx7d.bin&amp;data=3D04%7C01%7Cyi
> bin.gong%40nxp.com%7C3c61a5cfd0574c1bc4eb08d92fa31257%7C686ea1d
> 3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637593199700307681%7CUnkn
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1
> haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D6UDEjl3ehC49af38OI%2FQhE
> mbeLYgQSJB91Kriihw1Jk%3D&amp;reserved=3D0
>=20
> contains the "new sdma ram script which works in XCH  mode as PIO inside
> sdma instead of SMC mode" fix?
Yes, it contains.
