Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173903A73A2
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jun 2021 04:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhFOCZZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Jun 2021 22:25:25 -0400
Received: from mail-am6eur05on2041.outbound.protection.outlook.com ([40.107.22.41]:14049
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231283AbhFOCZW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Jun 2021 22:25:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVyApvEOcdJ1bTvJHH65HiWNzUn1MZwutdkt4y3ZtoSA82bYM9BELvvjkT/RsYVmBP3D+Arued1mpE1T4qFNsif7mzb7pae7YCSFFB/HDu8HmKqyOYNaWGTK1YkDJmyDMBf1lmYagprIfEIL0qid1hKCv9gdS7fA0iCawZt4jgBJrscHxuoGln+zwqj/uyX8pWlMTi/EN59Zi+SE9efTbUUyscM6KqYdD+QgG+iHQJu8IQeBmA+0GfoF3qsFSK/xhnCTqRg+fXYaWwjypiq/vIHllYASBsLjwWSqcQ0j9p27fmfK9ForccOcUqoUafoV1M9LIfzimKNhX0mp6s6t1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxzlMe/z11qLSL3X1GucDjwlN3Je0Dol/PL/riAG12s=;
 b=cP0cBdX6eRzkJqe4U1v+xBmJmenwyuDyzblLhyq8LoHCP+rKp44cwuTZ4qS8Bb3WPODH/ySWaE5RV7rEoIo6iotrSqHniI6HU98DhXl34N1ZAmvqAqhHLlw9qnjTQ9fAVHDAc1hRcbRBXFNULb5/iSc3vledWBKqTLA1XjIfNoSAFTVOJYKt2jttYCDjscTxiu1IYRew8yR3x8iUmeegbyioC5CeUjoUFMnM8tXffRvDg+ZU970PLPyFJy5QYGiAkRylqa54sajiq2X0q5627c4NQ1CsU8GtFyWiylu5FejocawxvasdmHxVXVhDhg0xqks54oD6q/u2wJjZ6vSaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxzlMe/z11qLSL3X1GucDjwlN3Je0Dol/PL/riAG12s=;
 b=QjeP+Qf1QH1hQbIsK5OWGhoPW50dYMERF/8uD6CazJ+hameSViPSgmpw6MXCvzEPksrs/kfKjKftkTF7nDX/Z5Wes+Y9mJsfDlRZUBTdqG14c0sDJoTehxz2n9j8FMOva++qCvRODoyqssDrNR6cSa+5hLofewB2klRDE5fnwHI=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VE1PR04MB7392.eurprd04.prod.outlook.com (2603:10a6:800:1b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 01:55:29 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::ed27:a6b2:74fc:8ef2]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::ed27:a6b2:74fc:8ef2%6]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 01:55:29 +0000
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
Thread-Index: AQHXK33LUkqD6t3KUUabL8+87acFPqsPOqgAgAV+imA=
Date:   Tue, 15 Jun 2021 01:55:29 +0000
Message-ID: <VE1PR04MB6688017E125D42C5DCB3C17D89309@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
 <CAOMZO5CNjpek0vkDrMyTmfbnr2cLcquck6QQBqXLBiyTDKPXvA@mail.gmail.com>
In-Reply-To: <CAOMZO5CNjpek0vkDrMyTmfbnr2cLcquck6QQBqXLBiyTDKPXvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a18d0e51-5508-401b-e2da-08d92fa0a720
x-ms-traffictypediagnostic: VE1PR04MB7392:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB7392354B754FF1E8857FB46C89309@VE1PR04MB7392.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cAi4K12uTIoze9sLfMKMNMcJpjWc8EH+qPECiizWVgVcKdWlTVEbXnVQrC8CoXlycoPbVwIcA3T+7l7Fsn2MVfwj8J6ZOHOrl+Pxl9Iw0KyE4+OuRh54OCqXcs9L4WD8lonIrvFRYfgcpcezE3Mk4dQ88N3IlszEgjDuyWa8MnjdPtszAvu/qZb8SrsqambOdvx4C+wFwmNEc3Ld7JLFaQlnCtjASplEkjj8LRcJElWSa/n6VKu1GAoUrvXGV3ho1Wi1OborcIVBhsecojGcj0zZYLC1kvVK6vDt846iJottlbwITtAaxeKf3Dc4QxYdgLKI2Cxw2b+8kDQinljPCjGqyfdMwKAeXvCtqlCGc0DTN0jCAse6rCZ7am8p5LTEcvAeO6cpAkrAb/yWQPW4tJlZ9px+T+lv55x6pcM+M0zV4fUOP8mtpKpY/c0aWYjSsJKlLUuH2ZRWrNHeN7Vibm85OkrVDuyZhL5x/sAdE1NymxlB5AIint6k5ftjVhqyOqhkzus7DIgN4PRa8dkck26xeRVeLfPaQt9gbN3bXIFntBQkZ2Ff9e29GGUIsfBhua5zuYwx22FbvAvrQQcu0YCNthbUuqh2LGZ4jkrOaxB4YA/N75jqKGg9D0/WdsGfVfh9ePHtLNIB7t7JpMuQWQIDig4Jy6h/sQ4es/m+zEBb0RTeAzUWDBpMSfTf9tb5+HRSpglJrJpSl2Z3mDC4lcOAOAB3Zwa2mPwRue7k9XjS2cc8D/TfC788duCLu0K9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(122000001)(2906002)(4326008)(38100700002)(86362001)(64756008)(66556008)(6916009)(186003)(66446008)(76116006)(26005)(8676002)(66476007)(8936002)(71200400001)(52536014)(966005)(55016002)(83380400001)(7416002)(478600001)(7696005)(33656002)(66946007)(6506007)(45080400002)(54906003)(53546011)(316002)(9686003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8WWkhgBAK5O7QxiWgrMn4UIxSrUsBxlD2PvrdMWEKbUOMOCPf1m/YbYXcA?=
 =?iso-8859-1?Q?DV186jNrsqn23B/fvS1s6Sh+LDIA4UOZvDjoSCyUDzk/enLjcRmktroBW2?=
 =?iso-8859-1?Q?F3S5OHRWyrenMDbadjYp6uLPBeV4Em8ZROffi3G5MbtYdtUlC4Up0r664F?=
 =?iso-8859-1?Q?q6CnaOwxdE844ot46DKG5MDxNOxO427uF9eB/+CGblZR6YepXDNj8NugS9?=
 =?iso-8859-1?Q?uBpaWF6PqRyow8r/mioiC9XZ7FfLqgb8uj6lX+zAzgzLyoV3dXTqx9Z6bF?=
 =?iso-8859-1?Q?jGGFCl6UojkjKVaVIw1QeFWu+lDPSNBTx3NTgl1YJhyVjiRArU7Ib9RpR/?=
 =?iso-8859-1?Q?hn5JRXkqNZ8PFnw+H+STTgTGXcHCHkFhxzHGWQQ6gcRYNOxD4+2ppi829A?=
 =?iso-8859-1?Q?T6my9i7N6QXt9TUtSnWebXhyrbMm83apBf5R2kI99oYVwW9+njBssW6nVh?=
 =?iso-8859-1?Q?Z3UXvqTCsQZK8OrkvHuZ+OTpfjm4X1tHPB+F3xIXHBEixopF7WcZ0fuCxx?=
 =?iso-8859-1?Q?4lVsIofldwvR69bSLCG7UOUoNvLBTSmUGN8bD6tLAtpD25pyw6UTfEKN1n?=
 =?iso-8859-1?Q?fpKC98YkBVlAWz796pj7txDyPeuhP5dQbNdWPsbZbKo7ymyCw7ROBseNfd?=
 =?iso-8859-1?Q?CldJKXxnbo2o8YpXirJtZbrD3Yt45r8jWIAHr05t6P3Z6yVDWBmHDhOEA2?=
 =?iso-8859-1?Q?4Wt6eM9FSmwbzUhOPu5F6ZpIjVEcfW7BqwwZKf0ElK2StOOd5qoGFbeahB?=
 =?iso-8859-1?Q?u91p/Mt8p+8owRxkD/gs0TT4qtAUSTXLfTjpUOpt2ifmANdRUy945DPUVh?=
 =?iso-8859-1?Q?tLgAz9wkgUtU6W9BT7Y8ml1ftJZwwm842dI7mQ7zatOHTw7kKuQL4yr/Tl?=
 =?iso-8859-1?Q?pMlS1DeUU7AUKBEq9iGDVRB+eatYjvHjnR7vIOrik43k3J2FAZnCFb+yuQ?=
 =?iso-8859-1?Q?wdvFT3BwT/zTz3lNsJasfm04lSE8DAVWQZVIZkBM9x58kEEdBoORLGrC/A?=
 =?iso-8859-1?Q?dRujH7KDaCSvqKpvnybXznGZfL0gB+pyU1SFXqJiG8cSzwpJBsN4gpaDj+?=
 =?iso-8859-1?Q?FBbJm8ZU/6j0sGRyKjMiBOeMllg+FgFG/lL2rlOQlX4ArUEv3190h3t/Ta?=
 =?iso-8859-1?Q?idKWaPXWWUantvW88ENcwMIw9EvfnVoN2UaNIXxErW0ae9/ykIBHlhBG+W?=
 =?iso-8859-1?Q?BCwaEzsBZdBBxyNAjGdHZdHWdeqYN8QCZch50Tbd8vXnttWCLkQvvWbBtc?=
 =?iso-8859-1?Q?K1w9zAJHBqt1k5u91SJ5ShbtBslcU6DCDJQrmHlk26Px9HRe/LIs+apsw7?=
 =?iso-8859-1?Q?uuHuRMAZZXd5FIiazc9JjDO5RNxOMwfqvBIUiKBmmK3p/0U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18d0e51-5508-401b-e2da-08d92fa0a720
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 01:55:29.2710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQY9AWa6C7ZElcMF4NdeIu2rqXAPI5G5u1vqH8FjUiiY7v8RzmwCZVVVFPsTN0ds+DO4fj9VBWGXrJAaa5j5NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7392
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06/11/21 21:51 Fabio Estevam <festevam@gmail.com> wrote:=20
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
> ong%40nxp.com%7Cab59d4a2e95a4351e48708d92cdffc09%7C686ea1d3bc2
> b4c6fa92
> >
> cd99c5c301635%7C0%7C1%7C637590162781662129%7CUnknown%7CTWF
> pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> I6Mn0%3D%7C1000&amp;sdata=3DDIbrrAYvpoJ4lKrkDJYvyoixR9DcMCgVDwuW
> gI5fuVw%3D&amp;reserved=3D0. The workaround is adding new sdma ram
> script which works in XCH  mode as PIO inside sdma instead of SMC mode,
> meanwhile, 'TX_THRESHOLD' should be 0. The issue should be exist on all
> legacy i.mx6/7 soc family before i.mx6ul.
> > NXP fix this design issue from i.mx6ul, so newer chips including
> > i.mx6ul/ 6ull/6sll do not need this workaroud anymore. All other
> > i.mx6/7/8 chips still need this workaroud. This patch set add new
> 'fsl,imx6ul-ecspi'
> > for ecspi driver and 'ecspi_fixed' in sdma driver to choose if need
> > errata or not.
> > The first two reverted patches should be the same issue, though, it
> > seems 'fixed' by changing to other shp script. Hope Sean or Sascha
> > could have the chance to test this patch set if could fix their issues.
> > Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not work
> > on i.mx8mm because the event id is zero.
> >
> > PS:
> >    Please get sdma firmware from below linux-firmware and copy it to
> > your local rootfs /lib/firmware/imx/sdma.
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
.
> >
> kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ffirmware%2Flinux-fir
> mw
> >
> are.git%2Ftree%2Fimx%2Fsdma&amp;data=3D04%7C01%7Cyibin.gong%40nxp.c
> om%7C
> >
> ab59d4a2e95a4351e48708d92cdffc09%7C686ea1d3bc2b4c6fa92cd99c5c301
> 635%7C
> >
> 0%7C1%7C637590162781662129%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDA
> >
> iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DuL
> %2F
> >
> 6w%2F7JF76dqTfKYk4BT%2F5flWr0d3U2O86ABSq2UhI%3D&amp;reserved=3D0
>=20
> Without this series, SPI DMA does not work on i.MX8MM:
>=20
>  [   41.315984] spi_master spi1: I/O Error in DMA RX
>=20
> I applied your series and SPI DMA works now:
>=20
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
Thanks Fabio.
Hello Vinod, Mark,=20
Is my patch set good enough to merge? I remember someone else are
requesting it from last year like Fabio.=20

