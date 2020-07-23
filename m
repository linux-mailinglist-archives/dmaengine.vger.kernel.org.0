Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991F422B10F
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jul 2020 16:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgGWOL1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jul 2020 10:11:27 -0400
Received: from mail-am6eur05on2078.outbound.protection.outlook.com ([40.107.22.78]:9697
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbgGWOLZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Jul 2020 10:11:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+wG1p/ijGdgOJW2qmFMkNYZ4X2ZBBEMZeZNv3fxvv7Ef8th4PgbBAExm6FkmWApdB/BxKd98gaQa2i6X/aBryRgtJFh16vcWX3K+LxgoR9Owa9Z/3xRTbZyo6tXPXap7v5Qm4Y5TGFV1A63YCjMXNbb1IqnmbshO36byicUIPzXsxKNsx9hOPSncM+Z4grkt9HjTJ5SF9C64CpJPsINuJYZ8PtwhFyomC1+niFxTnVQKK+Oohl62uRCCtDnRF4p6QtQTjVBAzJ5O09H+SR50IPvOR4rbMmZ+J98cE09+R+uM1EYyot+d1J8pWCJwr656dNVaVIq0vONP/xN40YqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpClA+EViGrEPTaSmvfJxJ1mrmCFpz3tfA0TYhDTxVk=;
 b=TuglgvNlAl+Kh81ai5Mun9Jlb0L6cgZLluhnfB0pieDW1OR+VHnwJYHLYloLddr5KgF7FgRjVtCx47ja0ZlVeChFXjSYgin93Av5orwZjrN70UN+nZFUU45prKKGIS0kOYb6XMaKp2bvNj8HBoBABtCOkl8PA383aRHecXL9uvDg7Zll5WuwMDoCjfguKhL+73We2iY4U89Sb+q9rNOTEMF6iKdRXEz+CMFmfUPWYGXOni0jA4uVs5px4m5vS2gT/e2QklAbbpPhOBkxpVfyLpNVFLQcZfPkkqCUIsnrxYfFq3XhB/uVJFccbWQqyLD6lk1+Ktp14x8OW/jFANAJyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpClA+EViGrEPTaSmvfJxJ1mrmCFpz3tfA0TYhDTxVk=;
 b=TVPUQGzctYiRmkRe7XztPjbMC043Vo4FIc3gvLPPLg8x+x+uXQhUu7KnIBv4P130L1dWU33qU2EObMsIEsE9pPkYVPFKxuGUwll7ieKgs9fmrmKekxN4slevt/VOOd2rVRvVWqDqxdRg843PkR3c4q9l6XyFzYSbEZQJp89ns1I=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6511.eurprd04.prod.outlook.com (2603:10a6:803:11f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 23 Jul
 2020 14:11:19 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Thu, 23 Jul 2020
 14:11:19 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v10 05/12] dmaengine: dma: imx-sdma: add fw_loaded and
 is_ram_script
Thread-Topic: [PATCH v10 05/12] dmaengine: dma: imx-sdma: add fw_loaded and
 is_ram_script
Thread-Index: AQHWTp7JbcJo/3lJ0kuBP+xQgJ1yA6kVAw+AgAAOScCAAAwKMIAAFKYAgAAgFWA=
Date:   Thu, 23 Jul 2020 14:11:19 +0000
Message-ID: <VE1PR04MB6638FFA76076ECCA9CE8F2C289760@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
 <1593523876-22387-6-git-send-email-yibin.gong@nxp.com>
 <1b04e4e6-ca26-3f45-e353-af81e03f85a7@kontron.de>
 <VE1PR04MB66385FC4FE591EAFA8CB7D8289760@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <VE1PR04MB6638BEA5C2594FEBFDE9318589760@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <22e53878-42e2-78ed-c460-3fa339c306ad@kontron.de>
In-Reply-To: <22e53878-42e2-78ed-c460-3fa339c306ad@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kontron.de; dkim=none (message not signed)
 header.d=none;kontron.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.236.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cbb2c035-07c4-4709-ef1c-08d82f124556
x-ms-traffictypediagnostic: VE1PR04MB6511:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6511D0BECC90D5027EECAA6B89760@VE1PR04MB6511.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PoZ28h6ZHrhUV39FpcC+9olHZhRbH2Ngx42zJ86BzRwa27fUVbtR8MR5kKE0zSUdFFU1f9lLtg468qUFeJwDCpEiGfSTH00jlkyFXuLuTnd63OwHawVESn6domOoewOAp73oiZTzi8ny7HHMDDksQNRi3yZJ+1HQY8M/KsKFj6XDymh7BKKT8zJl7/hYXMQUxY1N7yIi9wioCo9NATsARaRtzawVY3teKSM9H/LTL5mZuTDTsEFl+0Lv/J+olNZCsKwYS4mmRMC2U4wihfJvOnx+9PEo3GxF3OTKcj6ogJr7roPUUP2HCs3AEs+Y68wLcq5UxkVmGKqN4G0aYZVcy3uI8Wp81e9BMUPv4JzQMj/CVlIPhvAeitgJdlarmaQ7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(52536014)(8936002)(76116006)(66946007)(64756008)(110136005)(66446008)(7416002)(8676002)(5660300002)(33656002)(2906002)(54906003)(7696005)(66476007)(66556008)(478600001)(4326008)(53546011)(316002)(26005)(71200400001)(6506007)(186003)(55016002)(83380400001)(9686003)(86362001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: uG4N8KATOS5JiRifBeIMlKLNlJAqZcDEah669+VtTdQshQsouejIPJpV0JPHidLmcsLgTvrJ/ZP4R5MKboFPOsqeusDeZ3hys5YQ/yPFgP0+bRY62LV9NEjUY20KPVmad2ewSoOaESOhVZIqhodmZ537WZv7jUsCJZDOugpkAl1UlKCdLUnZ/aVhghWiVzaH35vIU1dRWjhHVo2rF9OTMgLF4/wgZRrnGMW6cWiQ9zr4hlFaJ5zzVX/9Iil/MIbOM8i4w6QA/m/jAi4Xnyk8A6zBFWs1FeZ/TLFraEwWjMyufsxZI5H7QKQGY431Ju9LTZqtkGaRYeYjafwIXlfgc82JxZHeFft5PX8hrApr6Wgd7Hf+4sw6RgbSL9TtiZf9JIJPgEnweN8wL2r+GaOWkjjh8JV26vexV5fnTss7mPrfn00RDBF/6vV9dS+ohtMB9jJY6bLbisZpu/wuTZpdgKI8Rl0GzW6tvRT0hhN0Pu6c3g3+dHysVa7W3uvMhrzC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb2c035-07c4-4709-ef1c-08d82f124556
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 14:11:19.0448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FDqm/PiPSYaqxMG9/DLr6jloqxMppLV0b+tHIJbATe/VV5g3w2bw1bEJtVbFk1FFaDYtF7aoBESDae137VIXUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6511
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAyMC8wNy8yMyAxOTo1MiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtv
bnRyb24uZGU+IHdyb3RlOg0KPiANCj4gPiBUaGUgd2FybmluZyBsb2cgY29tZXMgb3V0IGR1cmlu
ZyBzcGkNCj4gPiB0cmFuc2ZlciBzdGFydCBhbmQgc2RtYSBmaXJtd2FyZSBsb2FkaW5nIGRvbmUs
IGJ1dCBpZiBzZG1hIGRyaXZlcg0KPiA+IGJ1aWxkaW5nIGFzIG1vZHVsZSBjb3VsZCBlbnN1cmUg
ZmlybXdhcmUgbG9hZGluZyBkb25lIGluDQo+ID4gc2RtYV9kcml2ZXJfcHJvYmVfcGhhc2UtPiBz
cGlfaW14X3Byb2JlX3BoYXNlLCB3aGljaCBtZWFucyBzZG1hDQo+ID4gZmlybXdhcmUgbG9hZGlu
ZyBoYXMgYmVlbiByZWFkeSBiZWZvcmUgc3BpIHRyYW5zZmVyIHN0YXJ0LCBoZW5jZSBubyBzdWNo
DQo+IHdhcm5pbmcgbWVzc2FnZS4NCj4gPg0KPiA+IEJ1dCBJIGFtIG5vdCBzdXJlIGlmIGFsbCBj
bGllbnQgZHJpdmVycyBleGNlcHQgc3BpIGFyZSBpbiBnb29kIHNoYXBlDQo+ID4gdG8gc3VwcG9y
dCAnIENPTkZJR19JTVhfU0RNQT1tICcuDQo+IA0KPiBJJ20gcHJldHR5IHN1cmUgdGhhdCBDT05G
SUdfSU1YX1NETUE9bSBpcyBzdXBwb3J0ZWQgYW5kIGNvbW1vbi4NCj4gT3RoZXJ3aXNlIGl0IHdv
dWxkbid0IGJlIGFuIG9wdGlvbiBpbiBLY29uZmlnLg0KU29ycnksIEkgbWVhbiBvdGhlciBkcml2
ZXJzIHVzaW5nIHNkbWEgc3VjaCBhcyBhdWRpby91YXJ0Li5ldGMsIEkga25vdw0Kc2RtYSBkcml2
ZXIgc3VwcG9ydCB0byBidWlsZCBhcyBtb2R1bGUuIEJ1dCBJJ20gbm90IHN1cmUgaWYgdGhlcmUg
YXJlIHNvbWUNCnBvdGVudGlhbCBpc3N1ZXMgaGVyZSB3aXRoIGNoYW5naW5nIHRvIHNkbWEgbW9k
dWxlLiBGb3Igbm93LCBjb3VsZCB3ZQ0KanVzdCBsZWF2ZSBpdCBmb3IgYW5vdGhlciBwYXRjaCB3
aGF0ZXZlciBpdCdzIGJldHRlciBzb2x1dGlvbiBvciBub3Q/DQo+IA0KPiA+IEJlc2lkZXMsIGRv
IHlvdSB0aGluayAnZGV2X2Vycl9vbmNlICcgaW5zdGVhZCBvZiAnZGV2X2VycicgaXMgb2theSBm
b3IgeW91Pw0KPiANCj4gSSBjYW4ndCByZWFsbHkganVkZ2UgaWYgdGhpcyBpcyBhIHByb3BlciBm
aXggYXMgSSBoYXZlbid0IGxvb2tlZCBhdCB0aGUgY29kZSBpbiBkZXRhaWwsDQo+IGJ1dCBpZiB5
b3Ugd2FudCB0byB1c2UgZGV2X2Vycl9vbmNlKCksIHRoYXQgd291bGQgYmUgb2sgZm9yIG1lLCBt
YXliZSBldmVuDQo+IGJldHRlciBkZXZfd2Fybl9vbmNlKCkuDQo+IEFzIGNoYW5jZXMgYXJlIHRo
YXQgZXZlbiB3aXRob3V0IGZpcm13YXJlIHRyYW5zZmVycyB3aWxsIHdvcmsgYSB3YXJuaW5nDQo+
IGluc3RlYWQgb2YgYW4gZXJyb3IgbWFrZXMgbW9yZSBzZW5zZSB0byBtZS4NCk9rYXksIEknbGwg
Y2hhbmdlIGl0IGluIGxhdGVyIHZlcnNpb24uIEFueXdheSwgdGhhbmtzIGZvciB5b3VyIHRlc3Qu
DQo=
