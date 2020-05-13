Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566961D0A80
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 10:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgEMIGh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 04:06:37 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:6060
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbgEMIGh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 May 2020 04:06:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wg7bF+gx0FCpW9wU1rX4Bb6jMS7uUu/K8h2vnzrQquFs/qtyZ0yzC8PGVckvMiLGLJK2NRu+D70N27RTRR+c4tAzgc/l9L0/KSPgJ2DtBPmz2PdqWNbxCvf8Mq/qlEnnz/82T8sLSrJW6xVS8niU1V3iAdcoDBaUqO22OmtVdTZIIWoVbhwKM35y/Y5dtyouup/5JeUXSby+/poNA6Y/IK+X5dxYCtiEvvzwjHWP6qRzVH8deO9qNFPYafaz9Fve/7iX0b/rtpYFi38qx+VH9k3eoZLHSPPF1rZIyD9A4K7ma1InWglv0qrg4yng00RQw/lnrlgiYHvhHAbo3aXvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG/5eRAkPL0M8IFsNRjZ70jvC1+Kn6ZtS/f8mUCOUEY=;
 b=I9pA0REMaYu8/KuNvIDIV0JdHv13bkbBNO/aKOrr700sGeH+2xb7/4d6BM5lL6jWLQKSilbVlFmQ1I+AqFF+q9X3oAu1XG1n2kiFPkISNwi+95WxWl/d69JJX2ZXZ6BSsN3jl8vopaQGZZlM9RavMkGCnSzn5LVcEettkQeRzLczdFJUW3MWNPABOr+EQZSKhSqSISORDbIVHVQN4jdiGTXqvnwo662VkUls7StpNRBWDGm4Zt8uuGAQblsQ8Y8uaqhOEehf8PcKd+TXUNuvUO6RjqjLLOJzuWs67s6uaTs0QW3w1ZDH6N7epRFKfxk8rrkenr1a97oShtsl4TSmVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG/5eRAkPL0M8IFsNRjZ70jvC1+Kn6ZtS/f8mUCOUEY=;
 b=XeUplpuTi2REF84g8dYfzk8tQLmEu/pIeATeVeHmDyboDnDQ6kD3ANVCbOoFBly5oAmyWu3lOyDwBg87vaehkOyJiz9vndkUD/KutsvltNfwWaao2Ww8qzblY59nWsjN3ODoIG8P3B6sQzcA4oFp8eXCqPpvpn7gWNY+HcR75Cg=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6592.eurprd04.prod.outlook.com (2603:10a6:803:124::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 13 May
 2020 08:06:31 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.3000.016; Wed, 13 May 2020
 08:06:31 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "Fuzzey, Martin" <martin.fuzzey@flowbird.group>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v7 RESEND 03/13] Revert "dmaengine: imx-sdma: fix context
 cache"
Thread-Topic: [PATCH v7 RESEND 03/13] Revert "dmaengine: imx-sdma: fix context
 cache"
Thread-Index: AQHWJ3caK60pir53Nk+ogIMcp5w3wKilig6AgAASqoCAAA6qQA==
Date:   Wed, 13 May 2020 08:06:31 +0000
Message-ID: <VE1PR04MB66381C7FAC6EA04658C3176389BF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
 <1589218356-17475-4-git-send-email-yibin.gong@nxp.com>
 <20200513060525.GJ5877@pengutronix.de>
 <CANh8QzxJg05nXasHfN2kC-G7TOKZ8trJkOP_v0KXvcy6S4df4Q@mail.gmail.com>
In-Reply-To: <CANh8QzxJg05nXasHfN2kC-G7TOKZ8trJkOP_v0KXvcy6S4df4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: flowbird.group; dkim=none (message not signed)
 header.d=none;flowbird.group; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09161746-f2ea-48e0-b444-08d7f7148bc9
x-ms-traffictypediagnostic: VE1PR04MB6592:|VE1PR04MB6592:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6592EA6BA1F97D96928FD1A589BF0@VE1PR04MB6592.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ApPW9OKxUwxbX9Tz5vIfQitGI7jRCQRMX9jM3OmFwOZaxH5PSdZvcGwF4I42FHGrv5svdtXiokSeGnOcTdLUPUt57wjugVd2Q/GXuqec/EaWz/Yv3i6XXd/obxGNtd5Xld9ENbCtTdIc1mwWKU9jUBVlibnHbtIPI2kd3JMYyd7L/QNPEnIsS+cHnQuAq36u81iV/lh010obXJ1AMyHzrZQzSH/lRfvfxgdkLVby3M4iwuhL8uDVaX3nOY3Fpm8U3Qz2P3Vwt2zxyquP50X14JF8nyoZqyUXtXtsIImUckjiGNbbPAZiknsNGrXWTDpi+h7OTcEaHae8CL2UJ45XCKEo5FFNtZClNcU63RHlgbqWX/M0XzFUiDJyu7SobrSZ8VJvWkVIdjAnWPl1SsRY2aQVe7o/XUbrficqSGvvf8NKL0xmlsL47OqyxGsvfMvlYod4bp1Z4ahLPnHslg+jjtwQQFzJK1MK40IF4y1So6j+HK1DT2rdLJjluxcmsV5p0KKjDMdBNRpRvdzYukFTow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(33430700001)(64756008)(66556008)(66446008)(86362001)(54906003)(4326008)(7696005)(7416002)(5660300002)(33656002)(478600001)(8936002)(110136005)(4744005)(26005)(76116006)(71200400001)(33440700001)(8676002)(52536014)(66946007)(55016002)(66476007)(9686003)(2906002)(316002)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rVnGgRtCpZXQwHyquhdA6CCfT40SD1YjDH/Ms+3xT43ucDkcB7UFefbxmxwE2QzIiavvKaMnUANRNB8JDGPeFwzet0QdaDgS1y/f4Fo0JNinSPWuT4XGMR6v3GBf2SnUZgWJ1f4ltChB9xWMvXjeamoIidHktoB5RZem4Es3NU7naPgMLCehchnSKYTYjrH5v0+Yf4Ax7YO9+uZFR0vPKkqpq+iCELuVChpwlw/0zYnXipWWfelVDfMYV666gmj1clpSs6NDBp5LRgu2aOnSVfHpvqx+O6vgeFx42/N6NuOFw16GhI2WpRNY2xsHVYop+hw5Bt3wa0gH+BuMT2FvIHkVDZwrKn8e6kE82Dhsz1T2fq85nmRbJomikqnFk1hA5C7XZa6N1ElXXEZ8Cl9PsLKGSFchL+DHFDEQ1WgfGIOdMr0J2Q+kDQkKAw4L/XnqMHfXT3OOyakDbpq16cq8jvSuHCceDRWurqifDhQlRy8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09161746-f2ea-48e0-b444-08d7f7148bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 08:06:31.0954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kMAp/rrSxe+NNwq4gPmEXt2YCS7O5cC0bMyrqCPT8zJJbXxpleIeTSESm8quSXUJwtQCfbkd4+l1eyAIFT0epQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6592
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAyMC8wNS8xMyBGdXp6ZXksIE1hcnRpbiA8bWFydGluLmZ1enpleUBmbG93YmlyZC5ncm91
cD4gd3JvdGU6DQo+IE9uIFdlZCwgMTMgTWF5IDIwMjAgYXQgMDg6MDcsIFNhc2NoYSBIYXVlciA8
cy5oYXVlckBwZW5ndXRyb25peC5kZT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUdWUsIE1heSAx
MiwgMjAyMCBhdCAwMTozMjoyNkFNICswODAwLCBSb2JpbiBHb25nIHdyb3RlOg0KPiA+ID4gVGhp
cyByZXZlcnRzIGNvbW1pdCBkMjg4YmRkZDgzNzRlMGEwNDNhYzlkZGU2NGExYWU2YTA5NDExZDc0
LCBzaW5jZQ0KPiA+ID4gJ2NvbnRleHRfbG9hZGVkJyBmaW5hbGx5IHJlbW92ZWQuDQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KPiA+
ID4gLS0tDQo+ID4NCj4gPiBJIHRoaW5rIHRoaXMgY2FuIHNhZmVseSBiZSBmb2xkZWQgaW50byB0
aGUgbmV4dCBwYXRjaCB3aGljaCBtYWtlcyBpdA0KPiA+IG1vcmUgY2xlYXIgd2hhdCBpcyBoYXBw
ZW5pbmcuDQo+ID4NCj4gDQo+IEFncmVlZCwNCj4gbm90IG9ubHkgdGhhdCBidXQgaGF2aW5nIDIg
c2VwYXJhdGUgcGF0Y2hlcyBhbHNvIG1lYW5zIHRoYXQgdGhlIGJ1ZyB0aGF0IHdhcw0KPiBmaXhl
ZCBieSB0aGUgY29tbWl0IGJlaW5nIHJldmVydGVkIGNvdWxkIHJlYXBwZWFyIGR1cmluZyBiaXNl
Y3Rpb24uDQo+IA0KPiBNb3JlIGdlbmVyYWxseSBJIHRoaW5rIHJldmVydHMgc2hvdWxkIGJlIHJl
c2VydmVkIGZvciBjb21taXRzIHRoYXQgbGF0ZXIgdHVybg0KPiBvdXQgdG8gYmUgd3Jvbmcgb3Ig
dW5uZWVkZWQgKGllIHNob3VsZCBuZXZlciByZWFsbHkgaGF2ZSBiZWVuIGFwcGxpZWQpLg0KPiBJ
ZiB0aGV5IHdlcmUgT0sgYXQgdGhlIHRpbWUgYnV0IGxhdGVyIGJlY29tZSB1bm5lY2Vzc2FyeSBk
dWUgdG8gb3RoZXIgY29kZQ0KPiBjaGFuZ2VzIEkgdGhpbmsgYWxsIHRoZSByZWxhdGVkIG1vZGlm
aWNhdGlvbnMgc2hvdWxkIGJlIGRvbmUgaW4gYSBzaW5nbGUgbm9ybWFsDQo+IG5vbiByZXZlcnQg
cGF0Y2guDQpPa2F5LCB3aWxsIHJlbW92ZSBpdCBpbiB2OC4NCg==
