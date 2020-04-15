Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026AE1AA93F
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 16:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636368AbgDON5a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 09:57:30 -0400
Received: from mail-db8eur05on2079.outbound.protection.outlook.com ([40.107.20.79]:53569
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2636336AbgDON5Z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Apr 2020 09:57:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ju8E65IMg9sHvQ2J3fNfvnLu9Y/URhwBJx95H1O0vOZJBIEPJteiLkG6rr3q80ZWFafg3gfbGZNYanb9TulApHRByMwBLikJcWG7o3aBU4K2McPmNiGC5uQiHlLLVXKbSiX09ZYthzwK0LHiSiIj+y8S26eDxKKPrFD/U0QMkqUMyxY5zuVsjALLu5FCE6N+jZL5Iq6zXJ/XuxpvcbJ1AX35fldAQHU1pHK+Y2c+c/kbu+w0HmjTf/F6/tbg95Pfa1h3oqg07n2J5DeabO6dsrN/4Wq7PglrPqqzkp+tzz/0NJ0BM16FO5a1tWhUGs1Sr56Nd9XexXvSVP9LlNk5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmm4XmG0HRJCozo83YuBx7rDVrhGVHvuaePiudKcuxA=;
 b=TK+RKKOkl26v+1nhuni2p2iekxJFlWf6Y7anX2ah1JvWBlHEArjXBEC/XwBMU7rcU/nap7tssOe1eoLvJTgsZ4khEx2vwFbJApQcTkPfOHTPmHu5sJjcx2XPG8Ng/dCTzTstD4DrF9JUdxgsNRLbagf5fIy10CP+qR5qXh8szbI5F3PGxwAJLzpAYNVI6icAt49KJr8K9+UVOqM+WaT2exykmyNvtrIb50SwV0iYqMj4vRDFhPRCV5j7fRZ5puNukFgE+n2ia3Qbyw+DUJE2VOSGkdqnd+NIjD+j9z47uKP90YiODzgHqX3eIAfGrYB74nvYGAY9bv3ZArk5DkbNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmm4XmG0HRJCozo83YuBx7rDVrhGVHvuaePiudKcuxA=;
 b=erhi/KoY+58LColgiP0YGdTeUCqeeW9vXAezu8OLgJoRkaWUcLw/92CuWl8nxpzJ0fXZ7sHescZMuG6eSZJLoxkZd8LtAyyQ04dQuTmm7G5+NQ972ttcuAeDPTsWhRBwkpn9L0Pmtjjyvzb8g/ghppFXSXol7z7DcMZw9SmR+5k=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6735.eurprd04.prod.outlook.com (2603:10a6:803:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 15 Apr
 2020 13:57:20 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 13:57:20 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v7 00/13] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: [PATCH v7 00/13] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Index: AQHV93/7B768gsXihk2i42KIYKNYiqh6E8wAgAALJICAAEzJsA==
Date:   Wed, 15 Apr 2020 13:57:20 +0000
Message-ID: <VE1PR04MB6638C99F592E5FEEB08A3A8589DB0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
 <VE1PR04MB6638AE84CD338AE1CF26FDFD89DB0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200415091931.GA5265@sirena.org.uk>
In-Reply-To: <20200415091931.GA5265@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [183.192.239.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8fba9e2a-b011-4945-8612-08d7e144eabc
x-ms-traffictypediagnostic: VE1PR04MB6735:|VE1PR04MB6735:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB673572BF2D2B3B6FD9980A3689DB0@VE1PR04MB6735.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(26005)(53546011)(186003)(54906003)(2906002)(71200400001)(6506007)(7696005)(6916009)(86362001)(9686003)(64756008)(8936002)(4326008)(8676002)(76116006)(66476007)(81156014)(66946007)(66446008)(55016002)(7416002)(66556008)(33656002)(5660300002)(52536014)(316002)(478600001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zJA73oMKLigpMaayhHSExAfEAQwOg9TgfTOQz/tga42tVFl4fy0qa555n8SSX64iwzx9gTKBSARQ1ZIRuhIOL6iLHmI7LTwcTdoPHJyisLXOOFVB7mTDFNkKg/cpKPTKot/txtcVYplBY0JeZypmeMnqW4lsCFmbWn02iL6d+TmdMTpqQDQj7ZW/XLd4pfyT/Zwos700h2llmKeMsYfe/L/afdFYR7AwDGG0fSVGvuALISKZ89JDpyE8DAXpAsz2K3Bgbbx1lX9Th6S4R0SpxiB+h/ENZ28nS4Yf72Yfe5J9wMfS1ISGeyg8//jHUrEpppQ1/KFvQE12ILlfVUdJThBex4oshzAQEU4FpPxk9/FUdE4BBxkbk7uo2w8WwtAFqJftiEeRof3+kOQCZE2KM1e8Ms/ab/T56GGxELjRiYKult1k0W6cVFbaMdO6kFO6
x-ms-exchange-antispam-messagedata: FVGiIcarUBwt0h07Y8XNtPByXba9vfTwPTt8dzeE7JNe0LxjdhaUB1OBC2wMOF/8dmP2tqkT8/mweGafZty80lDsKXpj44rtDL+2vUXICR+XSLgivWyd7dI/i/3Gt4QJh/B1WjWjilQstAH5TeiFKA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fba9e2a-b011-4945-8612-08d7e144eabc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 13:57:20.7274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUypouwSZkh7VO5Ei0wHV3T1f5BOIo/oP8eEOGRSttMsj3bBfxEVyT0n3a/KIfRA56XZ//v6dvgE+wpg7bX3kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6735
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/04/15 17:20 Mark Brown <broonie@kernel.org> wrote:
> On Wed, Apr 15, 2020 at 08:41:17AM +0000, Robin Gong wrote:
> > Ping....
> > On 2020/03/11 16:35 Robin Gong <yibin.gong@nxp.com> wrote:
> > > There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> > > transfer to
>=20
> Please don't send content free pings and please allow a reasonable time f=
or
> review.  People get busy, go on holiday, attend conferences and so on so
> unless there is some reason for urgency (like critical bug fixes) please =
allow at
> least a couple of weeks for review.  If there have been review comments t=
hen
> people may be waiting for those to be addressed.
>=20
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed directly=
 if
> something has gone wrong you'll have to resend the patches anyway, so
> sending again is generally a better approach though there are some other
> maintainers who like them - if in doubt look at how patches for the subsy=
stem
> are normally handled.
Thanks Mark for the kind reminding. Will resend patches instead.
