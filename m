Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E635A1D0B3F
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 10:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgEMIwq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 04:52:46 -0400
Received: from mail-am6eur05on2068.outbound.protection.outlook.com ([40.107.22.68]:42329
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730568AbgEMIwp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 May 2020 04:52:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3sqztVZ2Ge+xOqsUaRAW2+x3So+oklFK1INnz2U2tp7Azc96xcROoejMkwRiA40LZsiHsHqfhWTB3IE24MDJXu3Tcu7gH6jaRG8wgRXRyL4WKmi4mXpp4mSZVZ/OVwjfXY/laKH6nnT3YVghvZHp2zo802u8aHPqppHfToAbsQnOAxAitLyAdLnL90WtqYSuNSfTkWMB3WOMZYA0Te+vf9b8F6Ulga8bHtlTyX+3SsalaD5vgQkJ0QXU2BzCmQSD8ikuAq8DHNr5d0LosWdQvE0rBX0Gp+oi64Dk+we/f0b5fAy/V0ID2rIxS1nLd5wcFQHMBlwd1G4Y8rg0MUWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG8CYXRCFibyKzO88iDRtSCDWTyTefIW7093ybIJfHo=;
 b=JGEGXx5WycGuKR5VXEbfHqBTtkcfYJ0jcJU5ZteVKhvlCfPI2L7dcaChLn/hW5yQxPq3b2ZZ9tieTBSKSP7Oe1C2DFYn0XHpaBqEtQNmtzANadgijzokXRyA0HM+qAYfas+AQ5nGr6xQGY6cBrJSB3QwtHwnDTrBx2bY6hBNfbe6VkJiIwYYmIkxB1FgrUJDxPWICrtJiqOBk+U2pKJYEkAMhB0CrAsSvUVa6FHk7KxEyIVugUxKbI2PaFuNpeURz05yxxr/fnWMJveKYSOArJlTsMVThynoIRTclH3ZR2M+MnJaMLfKn3Pok+Y0uABXsGV/PHQ6PJk7rlKy/AEpXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG8CYXRCFibyKzO88iDRtSCDWTyTefIW7093ybIJfHo=;
 b=NfoSvsdb7ORhB/MFbFWtokwEA9D7UhdLi0ei7vPL+VoPlyWpgRbyaS1emEQL43bLPXrVRYnWnsOM1+FJeGSgzzznfWAnoew5F2IAiDFVIlSydtv1E789CfqVDyeqC4QlEu7LZcw18qzWprppwcMHRZMpP4U7RCNEQSl8+d/DlYM=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6461.eurprd04.prod.outlook.com (2603:10a6:803:120::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Wed, 13 May
 2020 08:52:39 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.3000.016; Wed, 13 May 2020
 08:52:39 +0000
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
Subject: RE: [PATCH v7 RESEND 07/13] spi: imx: fix ERR009165
Thread-Topic: [PATCH v7 RESEND 07/13] spi: imx: fix ERR009165
Thread-Index: AQHWJ3cnZ0DWmxBZKkqSbDLRijv4Zqiln1IAgAATtwCAAASDgIAAAJXw
Date:   Wed, 13 May 2020 08:52:39 +0000
Message-ID: <VE1PR04MB6638857DD94A05DC7252E69589BF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
 <1589218356-17475-8-git-send-email-yibin.gong@nxp.com>
 <20200513072132.GL5877@pengutronix.de>
 <VE1PR04MB6638F5096376BA0AF204C64189BF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200513084815.GP5877@pengutronix.de>
In-Reply-To: <20200513084815.GP5877@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9fad8ebb-8533-45ad-e593-08d7f71afdce
x-ms-traffictypediagnostic: VE1PR04MB6461:|VE1PR04MB6461:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB64610F5D530415D699E1AA1789BF0@VE1PR04MB6461.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6lQHKIbIhUi6YJkGWxf+SPT/kGz0/bGW+nw/jOUWA2MDe2GjVxvUJVra/y47ruz8yqZDuAq2MJUQoMcyaCpmfsaDX8YcqyzTwbHLJXYff2Sa7bf2vKbFj+RjCGYAbdh5q+aK83vKPcHq9G8RKPx1RbUKRR/WSSsSefp+CbYHKndUvCw+kvWXDPZZbF/GbyJ30kHqtnLlZUCNsKstLepD1oo89wYwesmSMVtqLG0b586GikN1QOWWDbNHBP6T1jTlBOEYZy8ai62DXXsFZAGHEOEwVa1r/PJ9jq/bPhk8jFD/TWIDgY/XpSG4FnRnhF61WN6bfG+shx++7/c4aFJffNt6ar7h3lSA1SLeNDEVM8v4l1SHeWZTZKWuN+7HzpuIFq30TtsIrL1n6HdOec8cJaljCQIVpKL//8+wlUlhpH+xd2CJqISwut2BKjAHo3bUlmeF1B+4/ALcIQBw3Wmnqkzlga+VU9NO2HWm4LECHXLmFYA8AMHBawFBVhtUUcUwu4yP4aypbbyLhOzh/u6XVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(33430700001)(55016002)(6916009)(8676002)(2906002)(52536014)(4744005)(186003)(478600001)(26005)(5660300002)(33656002)(33440700001)(316002)(53546011)(6506007)(66446008)(71200400001)(64756008)(8936002)(66946007)(54906003)(66556008)(4326008)(9686003)(7696005)(86362001)(7416002)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mlqUPbz0dCeT0r4R/7IcLQMr2K3t24mO6sIJroTAdDOwroHT5QUBW1cVmSc7IP1OezM9hXIyTaHbNtw7aYmiGDdpdyXykaPyKZC/wxHJxsH/mlTPBmX9fuktMa8J2I3e3jmPIGvEK4DbDTBUcc5CgJItlVNnl9I8RywGGASls3rOrPA/23evtqjlN2myhz9ujOMvbQa9HaocBpVymsKszrNcWVeWwH43F4xtGP6/o6RO3rMySx+y7reR9d4SwBey1cbmBbeE7nxJGp+lXUXkzH85LSvsyp7Ki6WplNDs8G0aINcV8Ysv1EQKY7QJzzjl96HzdnlarzellkZUgkLXknKvsYaM42GgoMjcMuI6ySW4/fwOJntu46tmA+gc5upuqL/G0FKMNVYBLu5VqgpmpXennnLaeQJy8XEpG2dr+Py+/m6p32Ct1G16xuji0MWsyb4FcZDcts8r/AH4llwSLj7/9D8T2D9ZFimcMw7R/yU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fad8ebb-8533-45ad-e593-08d7f71afdce
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 08:52:39.4610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJ7MBqCeYktU/vHaX9u3EuDcGLpcdmfEtSbskoE4wFAr3kRQCQuW7MqIlM0lTo4cze/s0kwkEL979wbmCYG97A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6461
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/05/13 16:48 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, May 13, 2020 at 08:38:26AM +0000, Robin Gong wrote:
> > On 2020/05/13 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > This patch is the one bisecting will end up with when somebody uses
> > > an older SDMA firmware or the ROM scripts. It should have a better
> > > description what happens and what should be done about it.
> > Emm..That's true. Timeout will be caught in such case, hence, maybe we =
can
> fall back it to pio always.
>=20
> With my patch applied sdma_load_context() will fail. I don't know how exa=
ctly
> this hits into the SPI driver, but it won't be a timeout.
Thanks for your quick test, assume you use ROM firmware, right?
