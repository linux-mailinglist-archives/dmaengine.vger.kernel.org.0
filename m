Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8BF2B1CC
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 12:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfE0KE5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 06:04:57 -0400
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:34286
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726560AbfE0KE4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 May 2019 06:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF/O7UKKkH8RkrEcANCsfDz00eyxt9uiF1k74Vg303U=;
 b=Cs9QvTTloeySjge2NQxo/h0zTBT2lSNlQZVSMjUYtEi2wehkA+H7Ca3L5uMVBohfixixtOI1OmO+0J2R+ADAPbr5H1w7Gs/HHIQlTd7TGtRzbVu5//dUQnACR/XwEh1+AguHds3QXn6JDozOzkUjiuKa0C9DY6tk0lHpPFgsMto=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4960.eurprd04.prod.outlook.com (20.177.49.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Mon, 27 May 2019 10:04:52 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5062:df97:a70b:93f8%7]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 10:04:52 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 6/7] dmaengine: fsl-edma: add i.mx7ulp edma2 version
 support
Thread-Topic: [PATCH v2 6/7] dmaengine: fsl-edma: add i.mx7ulp edma2 version
 support
Thread-Index: AQHVFGkz0t9zeFrYqUCYdK5UT0BVD6Z+rfOAgACXqQA=
Date:   Mon, 27 May 2019 10:04:52 +0000
Message-ID: <1558980522.19282.19.camel@nxp.com>
References: <20190527085118.40423-1-yibin.gong@nxp.com>
         <20190527085118.40423-7-yibin.gong@nxp.com>
         <20190527090553.lek7tm3lyst3bhrd@pengutronix.de>
In-Reply-To: <20190527090553.lek7tm3lyst3bhrd@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2587d9a-605c-4e00-1955-08d6e28ac336
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4960;
x-ms-traffictypediagnostic: VI1PR04MB4960:
x-microsoft-antispam-prvs: <VI1PR04MB49604F55D102F58D9CCD8918891D0@VI1PR04MB4960.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(136003)(189003)(199004)(478600001)(6486002)(229853002)(6246003)(2351001)(73956011)(256004)(7416002)(71200400001)(71190400001)(91956017)(76116006)(66556008)(64756008)(66446008)(14454004)(4326008)(66476007)(66946007)(66066001)(25786009)(103116003)(8936002)(6116002)(3846002)(8676002)(36756003)(5640700003)(5660300002)(81156014)(186003)(6506007)(53546011)(11346002)(81166006)(26005)(102836004)(68736007)(476003)(2616005)(446003)(486006)(2906002)(54906003)(76176011)(316002)(99286004)(305945005)(86362001)(7736002)(2501003)(50226002)(6512007)(53936002)(6436002)(6916009)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4960;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ccE1UjTR8vtON0cdMdxuizdJYXSahrGA5W7O8mJtdgHkUpBszNVF/lzgMJ8g8GBCI6MegDd/L4mvnBjdMjbfFukeKZiV4aYH7FLgVSKYoNsJ4n0kY8kXXNdWEAB7suafnx9za6Joh0Du96ipl82rFkNTLclu+F5GCJj4MS+kPNPwg2+NoJ1gFQGDEqd+VVKsWr9b+B8wAWvbmJsUFgW27kA5v2jq2s4f44IaeZpaTRw0gXhauerV1ThJIww6AvaTYB/MujA4AMhDy3yPjWBsfg06r/ZKzGFnUJgDZ3+Ce0d0yD12eCss9iZxp6jzQMgGhVPhd6+/mB3glS2Qq9IK6DEPw0gqFXao1I5wKH6zdBx4V5VFPckuDprxe+Sa7Yyeddm5JDfQzjrT2JIQd+M1SUnCR6ylaSK9DyabEsu8EbY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E36FDC36F6C504D97207C792FF31B4D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2587d9a-605c-4e00-1955-08d6e28ac336
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 10:04:52.7171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4960
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAxOS0wNS0yNyBhdCAxMTowNSArMDIwMCwgU2FzY2hhIEhhdWVyIHdyb3RlOg0KPiBPbiBN
b24sIE1heSAyNywgMjAxOSBhdCAwNDo1MToxN1BNICswODAwLCB5aWJpbi5nb25nQG54cC5jb20g
d3JvdGU6DQo+ID4gDQo+ID4gRnJvbTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0K
PiA+IA0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBmc2xfZWRtYV9kdF9p
ZHNbXSA9IHsNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLHZmNjEwLWVkbWEiLCAuZGF0YSA9
ICh2b2lkICopdjEgfSwNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDd1bHAtZWRtYSIs
IC5kYXRhID0gKHZvaWQgKil2MyB9LA0KPiA+ICsJeyAvKiBzZW50aW5lbCAqLyB9DQo+IFBsZWFz
ZSBwdXQgYSBzdHJ1Y3QgdHlwZSBiZWhpbmQgdGhlIC5kYXRhIHBvaW50ZXIgc28gdGhhdCB5b3Ug
Y2FuDQo+IGNvbmZpZ3VyZS4uLg0KQnV0IGN1cnJlbnQgb25seSB2ZXJzaW9uIG5lZWRlZCwgc28g
SSBnaXZlIHVwIHN0cnVjdCBkZWZpbmUuLi4uDQo+IA0KPiA+IA0KPiA+ICt9Ow0KPiA+ICtNT0RV
TEVfREVWSUNFX1RBQkxFKG9mLCBmc2xfZWRtYV9kdF9pZHMpOw0KPiA+ICsNCj4gPiBAQCAtMjE4
LDYgKzI3MiwyMiBAQCBzdGF0aWMgaW50IGZzbF9lZG1hX3Byb2JlKHN0cnVjdA0KPiA+IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gPiDCoAlmc2xfZWRtYV9zZXR1cF9yZWdzKGZzbF9lZG1hKTsN
Cj4gPiDCoAlyZWdzID0gJmZzbF9lZG1hLT5yZWdzOw0KPiA+IMKgDQo+ID4gKwlpZiAoZnNsX2Vk
bWEtPnZlcnNpb24gPT0gdjMpIHsNCj4gPiArCQlmc2xfZWRtYS0+ZG1hbXV4X25yID0gMTsNCj4g
Li4udGhpbmdzIGxpa2UgdGhpcy4uLg0KWWVzLCBkbWFtdXhfbnIgY291bGQgYmUgbW92ZWQgdG8g
c3RydWN0IGF0IGxlYXN0Lg0KPiANCj4gPiANCj4gPiBAQCAtMjY0LDcgKzMzNCwxMSBAQCBzdGF0
aWMgaW50IGZzbF9lZG1hX3Byb2JlKHN0cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gPiDCoAl9DQo+ID4gwqANCj4gPiDCoAllZG1hX3dyaXRlbChmc2xfZWRtYSwgfjAsIHJlZ3Mt
PmludGwpOw0KPiA+IC0JcmV0ID0gZnNsX2VkbWFfaXJxX2luaXQocGRldiwgZnNsX2VkbWEpOw0K
PiA+ICsNCj4gPiArCWlmIChmc2xfZWRtYS0+dmVyc2lvbiA9PSB2MykNCj4gPiArCQlyZXQgPSBm
c2xfZWRtYTJfaXJxX2luaXQocGRldiwgZnNsX2VkbWEpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJl
dCA9IGZzbF9lZG1hX2lycV9pbml0KHBkZXYsIGZzbF9lZG1hKTsNCj4gLi4uYW5kIHRoaXMgb25l
IGluIHRoYXQgc3RydWN0IHJhdGhlciB0aGFuIGxpdHRlcmluZyB0aGUgY29kZSBtb3JlDQo+IGFu
ZA0KPiBtb3JlIHdpdGggc3VjaCB2ZXJzaW9uIHRlc3RzLg0KWWVzLCBzdWNoIGlycSBzZXR1cCBm
dW5jdGlvbiBjb3VsZCBiZSBtb3ZlZCB0byBzdHJ1Y3QsIHRodXMsIG5vIHZlcnNpb24NCnRlc3Qg
aW4gdGhpcyBmaWxlLiBXaWxsIHJlZmluZSBpdCBpbiB2My4NCj4gDQo+IFNhc2NoYQ0KPiA=
