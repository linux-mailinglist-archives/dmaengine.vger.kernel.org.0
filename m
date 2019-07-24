Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7697240C
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jul 2019 03:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfGXBxF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Jul 2019 21:53:05 -0400
Received: from mail-eopbgr140083.outbound.protection.outlook.com ([40.107.14.83]:20858
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfGXBxF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 23 Jul 2019 21:53:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQTOEWBkE04IY+YAyrzfpgwlv93BC/UfmnlY4I5Rnnu69m5crFIR3nMuozpmwShzXM0ZsO1TXuRI0kR4p2NnbGb/xSff8gpIlfCzRJ3sIRESxaSX8M9cm2e5ACvSYq0QKFf7CgIjTVs7IYsxDs80WRjL8+mnFVCogfVOgywjLniGkFndmxZesC8nd1CE/5WIkpUasqSCz0fX8IVPQ8ZaqWU9xXPviX82tNXbgLGfE9jh6cMaQ9yljidhpmBAtxqnb7J3p7WnGbfryBK0/VNMF++ppbC2zQTAKDzpo0Gl5BNQCe9mD28SRJzcyKql5QwTWnVV1/dHMWUe2Vd65naxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVRTQOJR8hUnc7CckOKhDvoVieXPJrdfQhUMUFZtr60=;
 b=mLO0BAXB5arqC6QvgNlnmklpthF2TszeSehQTJAPXTbf44gy0I4pNoEDGmimL2FkGP1H4XLKfssl8IDuZrMx8peRxw0uTDI6GSiBXrx39VBCbqQ8JsRrdwNN9O8lSSsUJ2sF0H+QMvoLVxqHukuUXesNfXZBANNjKFO3perFZdeWUdPX2LbuJfg9EGR8QY3bEB/1ttHFCLjrUY1iYd2D5Suymwjm3d8itf+M40os8k6xO+8yUF6OYTu1hbnXbG4V50ShUN2cJS3f8F5MhacFj63IuJDZ/ukoWPk3oB0ioj1giOIdONMCDIKgP5w336lCCFCiutvT2aPuUZURQ/6isA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVRTQOJR8hUnc7CckOKhDvoVieXPJrdfQhUMUFZtr60=;
 b=rgxIEaoJ9pJjqTGIRqLjPk5AgUK6+HScSwjGq6hxjrRC1a69OpSMGZZkT9E2QYDsmuBDzlTTdy1S7WIIpurQiNVixdHwgmjh/lRs/zH/sEtimmv3XHwCr28oPKhPbtqyVX2U6Wr8SokWXAEgAnlmpH2/bbs3u/s1gMA1PDiQjfI=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) by
 VE1SPR01MB0007.eurprd04.prod.outlook.com (20.179.193.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Wed, 24 Jul 2019 01:53:01 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::905c:a110:72fc:3a49]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::905c:a110:72fc:3a49%7]) with mapi id 15.20.2094.017; Wed, 24 Jul 2019
 01:53:01 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 12/15] ARM: dts: imx6ul: add dma support on ecspi
Thread-Topic: [PATCH v5 12/15] ARM: dts: imx6ul: add dma support on ecspi
Thread-Index: AQHVH2TVoxrocaPAG0GbhXUgE95pRabOlrSAgAmbW7CAAQJGgIAAEIzw
Date:   Wed, 24 Jul 2019 01:53:00 +0000
Message-ID: <VE1PR04MB6638F60965CD3D5CE47F26C489C60@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
 <20190610081753.11422-13-yibin.gong@nxp.com> <20190717064204.GA3738@dragon>
 <VE1PR04MB663894FA5BC88B130C70AC0789C70@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20190724004848.GV15632@dragon>
In-Reply-To: <20190724004848.GV15632@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 153fc810-43c0-4ffa-be34-08d70fd9a8e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1SPR01MB0007;
x-ms-traffictypediagnostic: VE1SPR01MB0007:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VE1SPR01MB0007C7C8F79C9966AFE4CB7589C60@VE1SPR01MB0007.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(6436002)(33656002)(55016002)(966005)(66066001)(4001150100001)(6306002)(486006)(9686003)(53936002)(2906002)(102836004)(8936002)(6116002)(68736007)(25786009)(6506007)(53546011)(76176011)(7696005)(478600001)(186003)(11346002)(66556008)(66476007)(81166006)(4326008)(8676002)(99286004)(64756008)(14454004)(26005)(305945005)(316002)(7736002)(256004)(4744005)(476003)(76116006)(5660300002)(229853002)(66946007)(54906003)(52536014)(3846002)(446003)(71200400001)(74316002)(66446008)(6916009)(7416002)(81156014)(86362001)(71190400001)(6246003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1SPR01MB0007;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GHJD73MEUaC/tMFOsrJaSUhVSGrdVXLWUG8i8gVF083Z8djAh+aZH4AtLNofEPr0hzxubHDvFE9hsUYLtaOphE2LSOSpTmvH/hyoOT+XB0/KgcvV2wM+sdv1iBhL8Oamhv4eLMqMy+2gELHLrwfReLZbwU4OJ03bPguINsp85dYeUjQxPG7y9A9w+OgbKx67F1fkZ3WlLEahuwtTAkc6rEw3Dr1mVqa1oQ9+BP8eUJwNRSt7Tp8wSCl/eq+XbpmlBEhKy8OtxIA861rYfjEObHNznoESU20iz7eWqpsCoeyn27Y60JQ3/SaAX/UaQ3TYavsDlIBNovRFIeadrZFm7nt2gB8CRV+krHmZZMrx4OSC1QgQBVkurTCtBFpOEDz0Pw/T4c3t1+T4eAi8FZGmUnjbENxAGbTv7yK4eiwC3UQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153fc810-43c0-4ffa-be34-08d70fd9a8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 01:53:01.0358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1SPR01MB0007
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2019-7-24 at 08:49 Shawn Guo <shawnguo@kernel.org> wrote:
> On Tue, Jul 23, 2019 at 09:39:38AM +0000, Robin Gong wrote:
> > On 2019-7-17 at 14:42 Shawn Guo <shawnguo@kernel.org> wrote:
> > > On Mon, Jun 10, 2019 at 04:17:50PM +0800, yibin.gong@nxp.com wrote:
> > > > From: Robin Gong <yibin.gong@nxp.com>
> > > >
> > > > Add dma support on ecspi.
> > > >
> > > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > >
> > > Applied, thanks.
> > Thanks Shawn, but how about other dts patches such as 01/15,02/15?
>=20
> I need the authors of the commits being reverted agree on the reverting.
>=20
>   Sean Nyekjaer <sean.nyekjaer@prevas.dk>
>   Sascha Hauer <s.hauer@pengutronix.de>
Seems Sean's mail can't be reached.
Hello Sacha, Could you please help test if my patch set could fix your issu=
e even
I revert your patch?
https://patchwork.kernel.org/cover/10984301/
>=20
> Shawn
