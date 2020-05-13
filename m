Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE381D0AB5
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 10:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbgEMIUY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 04:20:24 -0400
Received: from mail-eopbgr20053.outbound.protection.outlook.com ([40.107.2.53]:10353
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732121AbgEMIUY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 May 2020 04:20:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6Bz1p41IIUUhyaPbrgqEdl7Md9bqD/rgrR1RPB09OM6oyWugvcT/wRVWJH+RJZIq3ZicyNtMalpcYQI5V/CMB0HNGt+lGokOIP1J60A7lHbTpflS90hyy9LCPj/BkgQPoj8g07l2iyZz+8ypChEupcMiMg0CEEZFjai+lUOwG2rJCReMVfZJschQQ4gBDz+lxL5mnRCJ5CTzP4rZxijPDOnsK2dF1nxOWz6srU9WJxYGIKAWJn8m8sCAspukjSzME0wCQicItudXGJ21z0e0zxRb/Ledr2NnMj2lYClBerkWYo4SLVDCVeTwoAsYvMGST9FuQmVPTgN5WPKpw9qdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWEdXAhnXXeFk6WL4AWaBjGKdYGhKXzG8vgymH3/6l8=;
 b=W7DMBcF/kVJA3/NiCurVXxNTODLAj75lOdSPYEZBEdADIO89/UTd8iEer9rgOq8cv533EDmmxGohzI84nrtzwAkzihMIhQsgDjJFJz+hchqCgcZlKN0KpZVVnfPINzkjeqnmM3bCJ1or312h6qsSCyRvFzo6pRACZ4tJlP3GlXvFt6KiFlqQi//vpxQtFnq+a1KB6sLTRIxk0rp8rcPi8BNbwwgRHZrH028ZImSQXC4vntIuWhwW0tY4PJM325oqUfsaAIQpNRMZuy54oFdk6fLlPA7aWBSrEdHyHFql3M6oepcdYox6g5wj+9IHMZQnzshhoQ3zrj909xhCphDrMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWEdXAhnXXeFk6WL4AWaBjGKdYGhKXzG8vgymH3/6l8=;
 b=mf7qLmSG0UmxNz+RHdFT37ITOKECXkXU7sDRAz6OkCLkiKigYmBc0MJklcNO75UhbblyuFE6/Yms3Npe4oyPnOoSjNerpNRLGrvSkRgxxuUhIDywCmr0F+IOiBa04RvLVYr1L9rvYfY1xXgyngrnuQu3NLacCKtgV7D6o/iVGyc=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6495.eurprd04.prod.outlook.com (2603:10a6:803:11d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Wed, 13 May
 2020 08:20:18 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.3000.016; Wed, 13 May 2020
 08:20:18 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
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
Subject: RE: [PATCH v7 RESEND 00/13] add ecspi ERR009165 for i.mx6/7 soc
 family
Thread-Topic: [PATCH v7 RESEND 00/13] add ecspi ERR009165 for i.mx6/7 soc
 family
Thread-Index: AQHWJ3cQF4VQAfbPY0eHwEq+VJV4M6ilnvSAgAANpiA=
Date:   Wed, 13 May 2020 08:20:18 +0000
Message-ID: <VE1PR04MB663826721B0720C313C3E12A89BF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
 <20200513072012.GB15934@pengutronix.de>
In-Reply-To: <20200513072012.GB15934@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6a6175a-c429-43d8-8970-08d7f7167905
x-ms-traffictypediagnostic: VE1PR04MB6495:|VE1PR04MB6495:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6495028891FE13A5A93459B489BF0@VE1PR04MB6495.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Az6f7afz3WGTTd3KHlalP4pRyNiYet1VQlF7dMrMG8VOaXtup2no51OH5q7ezcE7S5H9U1+1xL96s+vS3/hSFXIZFbBLS8yU4cpTyEkTAeHiZZFNPJufFD5awLAtztVomOyTn/7I2iaeLRmeks+MHn10Zwigrh2so4H+Y9SDrVuVGOUpvBEbkirrruZ9yTtiH9j0I5hL+/vBPKi5lcNn0yqkI9J8vOVEjYM1eIWoQaE3mlCeyM5qFykcUXhUaGE2rEwtXIIWqm2b2l8RL6FUQ2IOxneB+ZvTu8EvDHJtu9Y0FmvpTP5yYZQOD1jCe0gSJvta1xIOS+FriAhz2KNzY9vRbuH4M7qnwl06EFTaChpU2rac47eImUdnTKxaV8wOp2RSGgC5Qvp5EMfQ5HnufIcmjbvEZ4d8ACJdpXY8dRxC3E6NrCnyTvsAtuh84Yj0tZdatyyGReJg6onKtc4HSFiP9WzYIhBr8V+rTzCALl4nuvoK3NLLSmT/mVjIcBDExOprIxBQIgN7ggKOHim/WL3JHyvQrrmUb+QZgqT20j0S/ezchVahLPR0EmJXajcFEoKZMvXxVYQqQ2r0QGRKZZfYc1hffI9etXv2tHHtEU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(33430700001)(86362001)(7416002)(71200400001)(52536014)(316002)(66476007)(66946007)(478600001)(966005)(54906003)(45080400002)(76116006)(33656002)(5660300002)(66556008)(6916009)(66446008)(7696005)(4326008)(33440700001)(9686003)(8676002)(55016002)(6506007)(2906002)(186003)(83080400001)(26005)(8936002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8YXxr7GNc171Guheu4KtR5OT0vICQafNvA5L/0OLA9vIgFXFVGzX17kYc8Xfz2vggPVDf0Ih3M4xMgIiuF7vT/VQjIeXMp3DoIQHgB77Znm/XwHorxZuDJoMAdAnb6EL3lWAitrsceE8E9ySSAzspgr8bTgj1Z8xyh4HRAiRB8REo5bV1Wy/q/oesK3XEm0d/IEyByY/mHZV65LU6U8mkyVsFQHEUe3OQfHuZIbD2KtmWdLXdE5Um/NMsCXYYLrFKd/t+rDGHHmqLg8T/g87fvUMdi0RmLa4RxYtaV3AO9QBQ0vW7o3lKkGi1/d/ojEpvb2Rcfq34jyWdBz4jI0v4vApQ3IkKc7f5cuXgYTs8gn7p/Cb/Oakm2353Q1oENi6pkTiavaeSa9COdiMscEOFDEDcXuwKYcXztu/slYQn69oAfJRK6RkdWqpGaz+F0D92022YKz3CnraCtZLybpUuGE/+ZNw6jafxTzlK5DyzO8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a6175a-c429-43d8-8970-08d7f7167905
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 08:20:18.6012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2wChgXBhAkbq7yo+BNwhok4GlUr1+Z0YXS0+dkM/o/LRsJD5JZjLoHKxy2pN5aKcbyDHAKEEz6GV/6/hChixw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6495
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/05/13 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, May 12, 2020 at 01:32:23AM +0800, Robin Gong wrote:
> > There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> > transfer to be send twice in DMA mode. Please get more information from=
:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.
> >
> nxp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D02%7C01%7C
> yibin.g
> >
> ong%40nxp.com%7C4276d42955334886056508d7f70e18af%7C686ea1d3bc2b4
> c6fa92
> >
> cd99c5c301635%7C0%7C1%7C637249512224944620&amp;sdata=3Dvh0e3BER01
> 02648t9HRe14h%2BaE9m%2BAlJ5Smd6v%2B9AhM%3D&amp;reserved=3D0. The
> workaround is adding new sdma ram script which works in XCH  mode as PIO
> inside sdma instead of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0.
> The issue should be exist on all legacy i.mx6/7 soc family before i.mx6ul=
.
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
>=20
> It's not nice to break SPI support when the new firmware is not present a=
nd I
> think we can do better. Wouldn't it be possible to fall back to PIO in th=
is case?
I'm afraid that's not easy since spi driver don't know which firmware used.=
 Could I add some comments in commit log?=20

