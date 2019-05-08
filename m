Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49AE91756A
	for <lists+dmaengine@lfdr.de>; Wed,  8 May 2019 11:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfEHJro (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 May 2019 05:47:44 -0400
Received: from mail-eopbgr150050.outbound.protection.outlook.com ([40.107.15.50]:42753
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726634AbfEHJro (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 May 2019 05:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYKSw8E3S3YAcBWxSFu4j7WStB3i2e/0mj4lpwSvJ58=;
 b=RDKS6WCpPv13kq+kVmnYdXH3VrZ5+IQMYhXC2A59w5WrA5dzlXMTOa0rI1DouXMNz3zwxpTGjTUijLRTMgDk20hN/TYSb8lbuAZS2viyxsUzXspKd+HRtzCfzjXU9FjmR7CY/LKORWtkZRaa/fq1cawVbaKYr/AsQav0sQtV5Iw=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4462.eurprd04.prod.outlook.com (20.177.53.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Wed, 8 May 2019 09:47:38 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 09:47:38 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v3 10/14] dt-bindings: dma: imx-sdma: add
 i.mx6ul/6sx  compatible name
Thread-Topic: [EXT] Re: [PATCH v3 10/14] dt-bindings: dma: imx-sdma: add
 i.mx6ul/6sx  compatible name
Thread-Index: AQHVBPXDrkhn+7eeekK+EpnqoHxjf6Zg+QNg
Date:   Wed, 8 May 2019 09:47:38 +0000
Message-ID: <VI1PR04MB45434F10FA0AC88AFE2DB09489320@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
 <1557249513-4903-11-git-send-email-yibin.gong@nxp.com>
 <20190507165601.GA17194@bogus>
In-Reply-To: <20190507165601.GA17194@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc0548f4-333e-4519-fe07-08d6d39a34f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4462;
x-ms-traffictypediagnostic: VI1PR04MB4462:
x-microsoft-antispam-prvs: <VI1PR04MB446223DD4B9BE9D881B73A7089320@VI1PR04MB4462.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(366004)(189003)(199004)(8676002)(81156014)(81166006)(53936002)(71190400001)(4326008)(76176011)(102836004)(66066001)(8936002)(7696005)(6506007)(5660300002)(446003)(256004)(11346002)(478600001)(476003)(25786009)(6916009)(14454004)(486006)(6116002)(4744005)(3846002)(305945005)(66946007)(73956011)(76116006)(66476007)(7416002)(9686003)(71200400001)(54906003)(68736007)(86362001)(33656002)(2906002)(26005)(186003)(99286004)(229853002)(66556008)(6436002)(52536014)(64756008)(74316002)(66446008)(7736002)(6246003)(316002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4462;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +Yl8u/xWF8nmY5CuTOD0yrKFVHCLe7vxfUCGAyUOGsf7dq9JERyXEW3j1sNgFd47DfPRADxiG3i+vCaha6weSAI+wsXp4Ok4XNR/WjZlrPUj87wQr3s8sH+0xLg6nRENpb2bCh0SwVo6DXImMpIMYJHYjXAkpgGHOEKUnv1lc5caD1vhNGnol3GzQteqbxv48IfgxzjBebinFO8De5yrcsgFp58KzAW2vLdBCuQwA1CgGgY06zJrEXw//E94ZcL17iyxfK2MlaQbFQZYbj1y0K+m6frfZ3fk1u7FUXiYxpfwz85C9BYj8oRn3NlLRxVVqS6Bb7lWiFJAVqmqzIKFg/vjJu/3OoiiN5HE7gYPzBE5MqPHn+tVA+E2Mq32ZAHHxOQ1LR9hKPI5cCJqqHfh9vqYD9Fy17XDrOPPWLSuZ3M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0548f4-333e-4519-fe07-08d6d39a34f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 09:47:38.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4462
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> On Wed, 8 May 2019 09:16:38 +0000, Rob Herring wrote:
> On Tue, 7 May 2019 09:16:38 +0000, Robin Gong wrote:
> > Add i.mx6ul and i.mx6sx compatible name.
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
>=20
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
Sorry, no tags and no comments get from V2 for this patch. Just resend the =
whole
patch set for v3 since other comments addressed from other patch.=20
>=20
> If a tag was not added on purpose, please state why and what changed.
