Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23FFC2472D
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 06:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfEUE6n (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 00:58:43 -0400
Received: from mail-eopbgr140051.outbound.protection.outlook.com ([40.107.14.51]:54501
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfEUE6n (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 00:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4cL0FzG/60/IKhHxZPY2aYXwp5+/PfEExE2yKeMdMM=;
 b=kFxW+TcLDDejjL6fTKpSInGDMN1h9KI+OI4p66bhRyGbjYKLX2/HZsyODjksMIMS1uv7GQKJxpMNqRML3yFznUlV9VR/h2hDPsF4VCICya96Iq4VGCkTgsDSIr7adJeTC0E4o5tQmrtQVUY38QgzIk8jnu2O1W18JofuLugbAGU=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4734.eurprd04.prod.outlook.com (20.177.48.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 04:58:39 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 04:58:39 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
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
Subject: RE:  Re: [PATCH v3 11/14] dmaengine: imx-sdma: fix ecspi1 rx dma not
 work on i.mx8mm
Thread-Topic: Re: [PATCH v3 11/14] dmaengine: imx-sdma: fix ecspi1 rx dma not
 work on i.mx8mm
Thread-Index: AdUPkTBymYi7NitxTk6DECeOgW52Qw==
Date:   Tue, 21 May 2019 04:58:38 +0000
Message-ID: <VI1PR04MB45436C98D70C16635CF3CFDE89070@VI1PR04MB4543.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f917408d-0173-4855-9dc6-08d6dda8fd37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4734;
x-ms-traffictypediagnostic: VI1PR04MB4734:
x-microsoft-antispam-prvs: <VI1PR04MB473447A559C6100CAB6BB1C989070@VI1PR04MB4734.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(39860400002)(136003)(189003)(199004)(13464003)(76116006)(66446008)(64756008)(66556008)(66476007)(73956011)(4326008)(71190400001)(71200400001)(486006)(66946007)(6916009)(7416002)(316002)(256004)(14454004)(6436002)(54906003)(478600001)(53936002)(99286004)(476003)(8676002)(33656002)(55016002)(8936002)(7696005)(68736007)(2906002)(26005)(102836004)(81166006)(5660300002)(4744005)(25786009)(3846002)(6506007)(6116002)(9686003)(305945005)(6246003)(86362001)(81156014)(52536014)(7736002)(74316002)(229853002)(53546011)(66066001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4734;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aZukrJIMUx8SlEtNTS9op5VuKh3GcDX2ozqfeOsdLnWt1/wCNDaYtcjgT5J3kEiHMqp/eSXTNTQm9vfbn0hlgYlMbGv8A5oer7A29ysmtJ7hSr3qq0lOb8aCg8CjQzCOTd74ccpYrrBsBoHXPvZATgekZJcCZOlOWr6wzu7XrminGWbqUmZYKcT7Gawm+EldsMIUTol20Wa3cYhDr73WOMef0GYmdWlQKe3i9mFJ9HQAD8y1n8VCT87rxEXKVNXOOSQwVJYq/A40YgFoqFyn4rQoV5Cs5DXNoRo6uf5GpoIQu16kZ9CF+Yv4nP3WeEN/QaDv1v1jyyjEWOTfWj8+biXrmTEAkGJYdolS+IFLfAM2m0UX1nADL3HCSd18LnjGjQP5bQs61mCqnNRa6eNtsP6cipzKv80svxm/AEQH51o=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f917408d-0173-4855-9dc6-08d6dda8fd37
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 04:58:39.0519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4734
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5vZCBLb3VsIDx2a291bEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDE5xOo11MIyMcjVIDEyOjE4DQo+IA0KPiBPbiAwNy0wNS0x
OSwgMDk6MTYsIFJvYmluIEdvbmcgd3JvdGU6DQo+ID4gQmVjYXVzZSB0aGUgbnVtYmVyIG9mIGVj
c3BpMSByeCBldmVudCBvbiBpLm14OG1tIGlzIDAsIHRoZSBjb25kaXRpb24NCj4gPiBjaGVjayBp
Z25vcmUgc3VjaCBzcGVjaWFsIGNhc2Ugd2l0aG91dCBkbWEgY2hhbm5lbCBlbmFibGVkLCB3aGlj
aA0KPiA+IGNhdXNlZA0KPiA+IGVjc3BpMSByeCB3b3JrcyBmYWlsZWQuIEFjdHVhbGx5LCBubyBu
ZWVkIHRvIGNoZWNrIGV2ZW50X2lkMCwgY2hlY2tpbmcNCj4gPiBldmVudF9pZDEgaXMgZW5vdWdo
IGZvciBERVZfMl9ERVYgY2FzZSBiZWNhdXNlIGl0J3Mgc28gbHVja3kgdGhhdA0KPiA+IGV2ZW50
X2lkMSBuZXZlciBiZSAwLg0KPiANCj4gV2VsbCBpcyB0aGF0IGJ5IGNoYW5jZSBvciBkZXNpZ24g
dGhhdCBldmVudF9pZDEgd2lsbCBiZSBuZXZlciAwPw0KPiANClRoYXQncyBieSBjaGFuY2UuIERF
Vl8yX0RFViBpcyBqdXN0IGZvciBBdWRpbyBjYXNlIGFuZCBub24temVybyBmb3IgZXZlbnRfaWQx
IG9uIGN1cnJlbnQgaS5NWCBmYW1pbHkuDQo=
