Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7923A7724
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jun 2021 08:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhFOGic (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Jun 2021 02:38:32 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:8423
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229463AbhFOGib (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Jun 2021 02:38:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UolVsf7Xl+NCZMRi0IPfY6Zz3LEW+bTMs0PvPBrshCasTXuDuUeyGTKCaZqMiV6US/xgvcx8chg293ejBW8BBrHlJGuIDpUZpTQo9i8fP8xQ7/dyxIYSTZxrDU5pFfaqF1+8wN2cORRUjXcuDgo1c+CdBWU8UpSjUmDC4iyJlm/6XbpHnfsAgrPGcAZ7m6JeicA3OGbfpwBj/zQfehmDcvCpt1T9WEsQrF/Lg400rDOGXMfOiNzDC0bMMaZH77QwuOJbsDDpGHAMKjkSMMqnWdF6c1LU4v18pHIFX2/nk/3e7bJ7SCiv7QpVv0SYBA1d1PwH/NdoKt7Egz5H7/YwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JM7+sgeCV3PNK1US8rPO8Dfufib2IZaKxHTC+IQ250=;
 b=W3VXYrDTHYCvmeDD8lR15WxjwtGmJ5CAg+qvZFtaMBCD6yKla1tqRSDLfnCgQR+RG4ZrDc0WOSFJ2VDS8/SdHhBXe829n1UzMpitIDpH0IinhksNM3WvZViz43ecKXJiDsDHg8Dr3YYycu6dAQCHNJEVdcxZ4t0cPHGMyjp7g8AF8X1QXnobxL7/J0FPJmYILJtWWNdyMSg0xERfTdk2mDDjqdTmZ4+AhLAl0N+DKmhwdV2SR0Bv4p/XqzfaO9L+7mbpdD1MobQbvDIYEGL6+cvPQgwn7gjZmXMwS+wLu4yMAjoUayoKL+zYbrRXosaEoF4XE594vupz1gxnjnmfyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JM7+sgeCV3PNK1US8rPO8Dfufib2IZaKxHTC+IQ250=;
 b=W2lppunz+H6ghSLcrBu1bTRubQlzSssKPuNZrpl5+g1jxVpSfbM4ymdbDJ0sfBevh6i/6t6RYF9gxWL690nVJdODH1wBhyLQErEmmROZFuXFZH/KO/d+wY7j1R+GFNSFPnGBmtpEA+xLu3Uq8sxgOZjt7Zcu2E7mpO6rs4g5YeY=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 06:36:24 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::ed27:a6b2:74fc:8ef2]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::ed27:a6b2:74fc:8ef2%6]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 06:36:24 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Thread-Index: AQHXK33LUkqD6t3KUUabL8+87acFPqsPOqgAgAV+imCAAElmAIAABENQ
Date:   Tue, 15 Jun 2021 06:36:24 +0000
Message-ID: <VE1PR04MB6688E8EECC03C5290DE10BC089309@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
 <CAOMZO5CNjpek0vkDrMyTmfbnr2cLcquck6QQBqXLBiyTDKPXvA@mail.gmail.com>
 <VE1PR04MB6688017E125D42C5DCB3C17D89309@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <YMhDvlPrFvSZP//I@vkoul-mobl>
In-Reply-To: <YMhDvlPrFvSZP//I@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71d7bb9f-c803-4909-ab6a-08d92fc7e56e
x-ms-traffictypediagnostic: VE1PR04MB7469:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB7469489940FE52D788C7390289309@VE1PR04MB7469.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ailfJ6aS7zzOlR6fhAi2RUdT1uTSGHYHstnVTTf5o1+JSJhWJIAL1GLan0/qx9nIXJ0orWpfn9aKlIGPqtqTR9AYKxEmuiubWblsO1aD5UL//fOXQeEZs4BXg8ZHtzTH7EgxwfPpCypAkAaabd6d4rprKnQI+fbOgfDlvKDhqag5QbrtgGp21wWmsVDPKZ5edphhnHdGXkczzXYISr/4F8b7VcVlQFM754PFdc1MlSQiN4lzt4IsVaq9ywHC4EC8ouF2/w1lbV5QGFN85K+WMvvGj/kD8Tp50e81kB8eJCxLpLhtartsG+l6uYoaTv7V086UmudLotHxLtdAnNFD/SOCN6Msl/ffdH9ASDHZTMGPB/ertrGtoxhFtErIHE+cuSHtAbq99OXlr3zj/RM1e9aVfFuJP6z0JFJ8D37mszeQStfyBTLoiEg9Ze+PUiX8h/XKvt/OTPrku1Pq/pKk8IAN8/74TpMKpEaizwJ/6pLuwLwQhoGZXzXxj3LRgF/JoCly0Cv1lzoVay3OIGEIZ1eHnOO+GUixGPIEIYRS0uQYbLAAtMYo6GqQctXlFP/xxHXx+LbFc++2K0OnH31AID7Vy8nTPn+Ikgh8tWSX4MM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(33656002)(8936002)(2906002)(54906003)(6916009)(316002)(7696005)(478600001)(86362001)(4744005)(7416002)(9686003)(5660300002)(64756008)(71200400001)(66446008)(4326008)(6506007)(76116006)(66946007)(52536014)(66476007)(55016002)(8676002)(66556008)(53546011)(83380400001)(186003)(122000001)(38100700002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tSx1klPIORTV4tbDkj+TbiihO5cXxOTYjG+OpGRAUtLjVp68rbLq0vJvDD?=
 =?iso-8859-1?Q?66uUWq06Zu66CiHG8Z0xwqNyCUGYEUrU8/vHjTkyjYrWaCyZtrAVr4R3Li?=
 =?iso-8859-1?Q?D3o3MXfWd4TsGgrLQFa7EhaZAYqWPGhrXcRLshJPAWe+pu4TGGsvsJr0In?=
 =?iso-8859-1?Q?S7cbdrDuwBOK73Fy5B26n71MyV56XpKGBkzg8Gbuxigx/d7wz4rUDw98OP?=
 =?iso-8859-1?Q?xldo8JT/SFDvl4oUyqyNdnjayM/zCZqlB79XJ34A1jFsTIh5yhAlmhkHfv?=
 =?iso-8859-1?Q?8bicQ6HsFrzjBVGfzcbbhg9EnJ71zlY43hG9jjlwvv2mEWbDl3efPfPgru?=
 =?iso-8859-1?Q?c5NaK5OsDOgPC3fhABzyUoBdWY0MpYhGRYdnBGEBR+TiXhlz93V96b0UPn?=
 =?iso-8859-1?Q?4KIPS/znxlZwpajdMm/29uGDJMn7D+jrBO9iQMdIBawd/LuA8AhsuMuPAJ?=
 =?iso-8859-1?Q?dVhp4mpwgjXRRqyDkMiRwqUSgJT/u/B45DYAxnc3hTzV3I+/EBhPPTgDSk?=
 =?iso-8859-1?Q?BqMBY0W6mk6+B4z8YBd/Y1uJnurPSQgZh2zik6ZD+esZiSWPnz+cwwd+cH?=
 =?iso-8859-1?Q?+/ANK1UG/MNXSYFmitln0KLRNAfXqiceHvMrTgL5WNgDHs3KPOfpP++A3z?=
 =?iso-8859-1?Q?C1wESgx6T3kPOLTiyfulkWHHOontj9JQUjTiOG+JNBy82Ef9obiLEAPkRp?=
 =?iso-8859-1?Q?uBK2DSuJi26uOYpPopgZkBa6uVSNTY9MWVr5awEa1ExG2IxPEJ3KzWZfZl?=
 =?iso-8859-1?Q?iLKL9tdvqMLjYyXWFnZXaVSeKG//VcGck+tqPbtm5gK56a/zeOuqSt/n3G?=
 =?iso-8859-1?Q?QHs1mU0S6qfp8p04HOGtAXmkmW7mGGK/s1zEOKszKm/hVoLkozeXrK0GC8?=
 =?iso-8859-1?Q?797a7yxWXtdtfnRWRZNNv9fJ//jIcMRVyZ1FlJAjhd/KcKitNLCHqldot/?=
 =?iso-8859-1?Q?poelf4Xu/oBs80Cz+6ayENYlHet0zOMHMa2xAH7frS7BxsqOPtj12BnzqB?=
 =?iso-8859-1?Q?A2zR5RzEusyGpNSJXDVrfXPwVJGPQCHzo5JOWWmaYT3K+0l3gnqc8pJAbv?=
 =?iso-8859-1?Q?BUa47rpSe+QD1aFnQdROjRKMDHMWorWTp8MXH3H3ZyqoG63u4wRhJ2xG+o?=
 =?iso-8859-1?Q?nkYUOfZpEDYtAlcunZLggd6+StejQKNDlnW0nDzeYky3Tl/RWdupF3Z5qz?=
 =?iso-8859-1?Q?EEMYUM6xzvrH+3+/NndF5DIGQvb2tvjG5JCBcZ1l+Nc8pRDNhKDFRnbAti?=
 =?iso-8859-1?Q?SciWcfAv/0ypUDntnQ5fwQV8bpIVm7WsIZBxY3S50dfiz3sYN+u2zyHGKa?=
 =?iso-8859-1?Q?uWML5uNDLbzLBjJOlRLDJgOxIX4+pqgG9neZ1Et+0VWoQ8NsWRzjjeeMdP?=
 =?iso-8859-1?Q?xvoHwk/7ZW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d7bb9f-c803-4909-ab6a-08d92fc7e56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 06:36:24.2649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79+/KejoIlNV62LvCog5TtkJJkTo7c5BOz6psiFCPZCXaNI+er+LxaoyvoSYUWsmbgl2RkvWIlpdpw5M3J6/SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15/06/21 14:08 Vinod Koul <vkoul@kernel.org> wrote:
> On 15-06-21, 01:55, Robin Gong wrote:
> > On 06/11/21 21:51 Fabio Estevam <festevam@gmail.com> wrote:
>=20
> > > Without this series, SPI DMA does not work on i.MX8MM:
> > >
> > >  [   41.315984] spi_master spi1: I/O Error in DMA RX
> > >
> > > I applied your series and SPI DMA works now:
> > >
> > > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> > Thanks Fabio.
> > Hello Vinod, Mark,
> > Is my patch set good enough to merge? I remember someone else are
> > requesting it from last year like Fabio.
>=20
> I have acked the last dmaengine patch, is there any else required from me=
?
> Which tree will be this merged thru?
Thanks Vinod, mainline is enough I think.=20

