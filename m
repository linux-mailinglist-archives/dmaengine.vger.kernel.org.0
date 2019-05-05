Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B35513E86
	for <lists+dmaengine@lfdr.de>; Sun,  5 May 2019 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfEEIzo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 May 2019 04:55:44 -0400
Received: from mail-eopbgr150052.outbound.protection.outlook.com ([40.107.15.52]:25422
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbfEEIzo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 5 May 2019 04:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gtw9rkS4XkmSK27kW0TiDuGbcg6kX7qePi8cV4olgic=;
 b=pxGvWvx2P4O71jBVMmyzklk2+rreT/XiDNes2zVyNh1T4OOR+7pCA34mMEoXXceDpBZu6VoJfZN3S6t3UwIhFCzaxh6R9lrTiX33NSU+5vponkMvFdZUaTMgcGNhdl51tgNbXO6b4Re2ykEMToUXKsf19pt3JDTykagAz7RPGaE=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4350.eurprd04.prod.outlook.com (52.134.122.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Sun, 5 May 2019 08:55:38 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 08:55:38 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 08/15] dt-bindings: spi: imx: add i.mx6ul to
 state errata fixed
Thread-Topic: [EXT] Re: [PATCH v2 08/15] dt-bindings: spi: imx: add i.mx6ul to
 state errata fixed
Thread-Index: AQHU/AbdFQmcRuAKXkaLI1VIJjs4JKZWut6AgAV7GBA=
Date:   Sun, 5 May 2019 08:55:38 +0000
Message-ID: <VI1PR04MB45436CE1F6856137F586C94389370@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
 <1556265512-9130-9-git-send-email-yibin.gong@nxp.com>
 <20190501200711.GA31231@bogus>
In-Reply-To: <20190501200711.GA31231@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c654712-0d58-4ea7-d6e5-08d6d13771dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4350;
x-ms-traffictypediagnostic: VI1PR04MB4350:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB435007B2BBF58D3B67C27A8189370@VI1PR04MB4350.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(136003)(396003)(199004)(189003)(71190400001)(71200400001)(25786009)(5660300002)(86362001)(6436002)(3846002)(7696005)(76176011)(99286004)(316002)(14444005)(26005)(256004)(186003)(8936002)(54906003)(6116002)(446003)(11346002)(8676002)(45080400002)(478600001)(81156014)(6506007)(102836004)(81166006)(14454004)(66066001)(476003)(486006)(68736007)(229853002)(2906002)(33656002)(6916009)(52536014)(4326008)(305945005)(9686003)(7736002)(7416002)(6246003)(74316002)(53936002)(6306002)(66556008)(64756008)(66446008)(66476007)(66946007)(73956011)(55016002)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4350;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BShK2GJlGnquBxCC/1dsZeujCYySQfrCvAoJ8l6/bRpFDA3GK9yjSG8RakpZS/pa7YWFm+n+dXL4R+iVmW5kBJv/0PnSkdlidMOAFMztlTZoWpG6372P5u5T5hj/ksFyyzTR8JG4O7d2zDF8NEgFdPD3wc3Bs6xSnwGnobwOk5V88/S//hXZSdqBa4TmWzv0Pwb5YU4Z3t5zMqGVGMVFP3H9JjhG3uqoSE0Lqqxxazka0myJV4giNT9o3ImDwmsSB9/HTGLaMELhrEZchLHibO1cy7+dUzOrEmfXysUQJNudmnRDw5AlVZwnC1ZJw21KjCWD+8Ow6cZT3GhdCFT09L/i2NjowSp0oCpKwnpA/ieaVRMiBGi5zaaH2almmgza5t49mQrNkIHZp610FZ1hTgcDxsEGT8VybruW0HFRvF8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c654712-0d58-4ea7-d6e5-08d6d13771dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 08:55:38.2283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4350
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> On Fri, Apr 26, 2019 at 08:05:51AM +0000, Robin Gong wrote:
> > ERR009165 fixed from i.mx6ul, add it to show the errata fixed.
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> > b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> > index 2d32641..32c4263d 100644
> > --- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> > +++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> > @@ -10,6 +10,8 @@ Required properties:
> >    - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.M=
X35
> >    - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.=
MX51
> >    - "fsl,imx53-ecspi" for SPI compatible with the one integrated on
> > i.MX53 and later Soc
> > +  - "fsl,imx6ul-ecspi" ERR009165 fixed on i.MX6UL and later Soc
> > +
> > + (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
w
> > +
> ww.nxp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D02%7C01
> %7Cyi
> > +
> bin.gong%40nxp.com%7C1eb9b302759b4af6fbe408d6ce709b8b%7C686ea1d
> 3bc2b
> > +
> 4c6fa92cd99c5c301635%7C0%7C1%7C636923380371230101&amp;sdata=3D%
> 2BxM9fN
> > + 6aEFkNlY5KU9qNiqqFMuDEfqGNrzADDiPO9gQ%3D&amp;reserved=3D0)
>=20
> What about other i.MX6 chips?
I only state in the cover letter of this patch set, for i.mx6q/dl/sl/sx sti=
ll need this
errata which is fixed i.mx chips after i.mx6ul including i.mx6ull,i.mx8m,i.=
mx8mm.
I'll double confirm again and describe it clearly in commit log in v3.
>=20
> Seems like this is missing some fallbacks. The binding doc should make it=
 clear
> what are all valid combinations of compatible strings.
In another Uwe's comment, I'm thinking move such errata information into sp=
i
driver level which makes binding doc clear. What do you think?
>=20
> >    - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on
> > i.MX8M
> >  - reg : Offset and length of the register set for the device
> >  - interrupts : Should contain CSPI/eCSPI interrupt
> > --
> > 2.7.4
> >
