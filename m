Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235A21AB5BF
	for <lists+dmaengine@lfdr.de>; Thu, 16 Apr 2020 04:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgDPCFD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 22:05:03 -0400
Received: from mail-eopbgr1400095.outbound.protection.outlook.com ([40.107.140.95]:54694
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728397AbgDPCE6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Apr 2020 22:04:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F03LrnjyqUFuj7w8YMu8gLjJNeI4olFboE9eOg/bozVbjS8Zm2ZTQonTADXqheq+kLunJsBqdFGLpFSbVNtWILgREGuN5TC43e//T+khJh75a+ENmAZSbAOP/od/T/dFMJKiPGX0ft7Il638uhTawKZCqxUHWomQ1zVs0a9wkcuul57Fx2E5NyibRgMY7U5kGs0Im57fEZ7ItE7W3hrCCF60zBp5aoxSKH+zBER3/nxmtUsbzLhHSdzgklrTqfFZKYjxHOxCRLMJLdZcx8z6SWhemyWhLuMkVvratsqTncSh8pZ9kXh8HKBmYJouXH9NINpQt2ah/AGBD1iFzAdtqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsXjyU3rXc6Gm5BE74SOnXHcc2MBsD59rjtt/lrbcGU=;
 b=ArVBmxz1VFSllelmrBReu2LL8ziRy3hQAkqyAImiBkfxOdIbAmOlzW4S3/OKNd84PaKfWYDznA/+78AivbN4Inlvj/rUamYuIZzBE55i+KNy0eRe6+5K+KYPuERDCt51mBTNcdqY6Y0Dip9o3x6dT1vp8ewLw6sV9hOYSmUjp57o3/c4hu/3s7pXggVdfxeFDVHacfmbKveDYRsaPRR2qzrVhsIrcw9hfuvtqeLACoUk7S47LhNQyv/GqW1D4iuJY/N4YxmDzVXRfZM7KJzibAIjkOvJgDeFBlYiwldEeROeqsz1uD0ZXkfsORs5tRwx8A5MKFIPi8EkZEEGPE013Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsXjyU3rXc6Gm5BE74SOnXHcc2MBsD59rjtt/lrbcGU=;
 b=hS6ZVNV+7eei+AxNXym2haGltGYoPXReyajR/0Cp13xaIa8PD+fY8LAbWIcz7O6lQ1TvLUeUbbBTk4vflIQi3Y/dFD6mUJkPDzv8sQF7h6L2RVI6OYCvxAtb0RC271QXOg27H1/DY39ix0EH8rRDErFzjQ0t2FII4Q/u0HeVQMQ=
Received: from OSAPR01MB4529.jpnprd01.prod.outlook.com (20.179.176.20) by
 OSAPR01MB3361.jpnprd01.prod.outlook.com (20.178.103.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15; Thu, 16 Apr 2020 02:04:51 +0000
Received: from OSAPR01MB4529.jpnprd01.prod.outlook.com
 ([fe80::3056:e118:8a8e:b3ad]) by OSAPR01MB4529.jpnprd01.prod.outlook.com
 ([fe80::3056:e118:8a8e:b3ad%7]) with mapi id 15.20.2878.023; Thu, 16 Apr 2020
 02:04:51 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/2] dt-bindings: dma: renesas,usb-dmac: convert bindings
 to json-schema
Thread-Topic: [PATCH 2/2] dt-bindings: dma: renesas,usb-dmac: convert bindings
 to json-schema
Thread-Index: AQHWDx8gtNeFxgyfAE26KaVsY8FTY6h6POmAgADJxGA=
Date:   Thu, 16 Apr 2020 02:04:50 +0000
Message-ID: <OSAPR01MB452933886B2C83A6E054AE50D8D80@OSAPR01MB4529.jpnprd01.prod.outlook.com>
References: <1586512923-21739-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1586512923-21739-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdWziQYKFeZZt7ZOCYMEWxD8e3mjqf+x0xsAcA7XDzZHWQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWziQYKFeZZt7ZOCYMEWxD8e3mjqf+x0xsAcA7XDzZHWQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd89c524-5792-40b2-98ca-08d7e1aa8c4c
x-ms-traffictypediagnostic: OSAPR01MB3361:
x-microsoft-antispam-prvs: <OSAPR01MB3361F48EF823E209B3CCE190D8D80@OSAPR01MB3361.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4529.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(8936002)(81156014)(76116006)(55236004)(8676002)(52536014)(5660300002)(26005)(186003)(7696005)(6506007)(86362001)(6916009)(54906003)(2906002)(966005)(4326008)(66446008)(71200400001)(33656002)(66556008)(64756008)(55016002)(66946007)(66476007)(478600001)(316002)(9686003)(142933001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RaLQvvCTl1l9/TAkX2QEEOcyU/QGMBHtOl4ltq+6z4wON0sbQIhEE+ZhGphXV5vVoxdTnMSgwn2u/4QNvMOD1NwnUyvMrwJbZOOX06DLViqTTdZL3plNG7cM7EkKfO/l37uP2vJoRVVBJMGEyI4yuEi2MG2pVAt9UO9OHgf0CyGBQfWdPUVWOYf6P+9nElAZTyuQGWUoc8M9wgeKb2EOtnFEvWHnK+iz5/u6vQb3aUm+EQTppSnqs6pg6JdDQR20KyKF/iegn3PjBFldB1CpX4kRI4Qd0qNZVwV69VMvffLELsrVroeXXzKsxGbCidG8OtCEdRzLk6d4q7vEUVFMtAtb3Ch9U/YkZFtDyPq6B50FasqOjmquNSgORrYuG6eiaMp09hYSRl1WQz5Sc7ij1LFJ7jyNUAZdOSfGw3z6l79lFOiB9QdpZlkYHh3cxckxfS4jjeTgakj5e32Ur9d8JAw/gCKQcFg7shYmh7vxHW41SXI/lMbS8jQSTyAPoblCZMjAJqwsBwbrP12wqD2ZswfHPCJBd8EqRP2Q8HrF/N2eAmktYYd4Dk8nbzCv65po
x-ms-exchange-antispam-messagedata: psBQ5o63KvBasq6V+iFm/No293pdosRfYZytaYhBaGh5POGyhVdoKCfWRGFD9OlP4p6a1hotv+EC/UxfTlYTJIsxfP33VGkmC1iRgN4xljrPYS6ufvTIQm5Jb4R6pcFhW2b4gbl6xVa41iqdifoPUQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd89c524-5792-40b2-98ca-08d7e1aa8c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 02:04:50.9215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +voOFvZiZVcNIOx8RLXJv0Lxx3kC9k/bQmUgmK2/WLLynIhcrGI01lz5BS9S4VWTfI8j9z/rI13bKfjIZljbsh5V2jFHR3rGQi9ofiyNQQexyn01yjmdaZuXPuzD1oD4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3361
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3IQ0KDQo+IEZyb206IEdl
ZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogV2VkbmVzZGF5LCBBcHJpbCAxNSwgMjAyMCAxMDo1NiBQ
TQ0KPHNuaXA+DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9kbWEvcmVuZXNhcyx1c2ItZG1hYy55YW1sDQo+ID4gQEAgLTAsMCAr
MSw5OSBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9S
IEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2RtYS9yZW5lc2FzLHVzYi1kbWFjLnlhbWwjDQo+ID4g
KyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0K
PiA+ICsNCj4gPiArdGl0bGU6IFJlbmVzYXMgVVNCIERNQSBDb250cm9sbGVyDQo+ID4gKw0KPiA+
ICttYWludGFpbmVyczoNCj4gPiArICAtIFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hp
bW9kYS51aEByZW5lc2FzLmNvbT4NCj4gPiArDQo+ID4gK2FsbE9mOg0KPiA+ICsgIC0gJHJlZjog
ImRtYS1jb250cm9sbGVyLnlhbWwjIg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBj
b21wYXRpYmxlOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gZW51bToNCj4gPiArICAg
ICAgICAgIC0gcmVuZXNhcyxyOGE3NzQzLXVzYi1kbWFjICAjIFJaL0cxTQ0KPiA+ICsgICAgICAg
ICAgLSByZW5lc2FzLHI4YTc3NDQtdXNiLWRtYWMgICMgUlovRzFODQo+ID4gKyAgICAgICAgICAt
IHJlbmVzYXMscjhhNzc0NS11c2ItZG1hYyAgIyBSWi9HMUUNCj4gPiArICAgICAgICAgIC0gcmVu
ZXNhcyxyOGE3NzQ3MC11c2ItZG1hYyAjIFJaL0cxQw0KPiA+ICsgICAgICAgICAgLSByZW5lc2Fz
LHI4YTc3NGExLXVzYi1kbWFjICMgUlovRzJNDQo+ID4gKyAgICAgICAgICAtIHJlbmVzYXMscjhh
Nzc0YjEtdXNiLWRtYWMgIyBSWi9HMk4NCj4gPiArICAgICAgICAgIC0gcmVuZXNhcyxyOGE3NzRj
MC11c2ItZG1hYyAjIFJaL0cyRQ0KPiA+ICsgICAgICAgICAgLSByZW5lc2FzLHI4YTc3OTAtdXNi
LWRtYWMgICMgUi1DYXIgSDINCj4gPiArICAgICAgICAgIC0gcmVuZXNhcyxyOGE3NzkxLXVzYi1k
bWFjICAjIFItQ2FyIE0yLVcNCj4gPiArICAgICAgICAgIC0gcmVuZXNhcyxyOGE3NzkzLXVzYi1k
bWFjICAjIFItQ2FyIE0yLU4NCj4gPiArICAgICAgICAgIC0gcmVuZXNhcyxyOGE3Nzk0LXVzYi1k
bWFjICAjIFItQ2FyIEUyDQo+ID4gKyAgICAgICAgICAtIHJlbmVzYXMscjhhNzc5NS11c2ItZG1h
YyAgIyBSLUNhciBIMw0KPiA+ICsgICAgICAgICAgLSByZW5lc2FzLHI4YTc3OTYtdXNiLWRtYWMg
ICMgUi1DYXIgTTMtVw0KPiA+ICsgICAgICAgICAgLSByZW5lc2FzLHI4YTc3OTYxLXVzYi1kbWFj
ICMgUi1DYXIgTTMtVysNCj4gPiArICAgICAgICAgIC0gcmVuZXNhcyxyOGE3Nzk2NS11c2ItZG1h
YyAjIFItQ2FyIE0zLU4NCj4gPiArICAgICAgICAgIC0gcmVuZXNhcyxyOGE3Nzk5MC11c2ItZG1h
YyAjIFItQ2FyIEUzDQo+ID4gKyAgICAgICAgICAtIHJlbmVzYXMscjhhNzc5OTUtdXNiLWRtYWMg
IyBSLUNhciBEMw0KPiA+ICsgICAgICAtIGNvbnN0OiByZW5lc2FzLHVzYi1kbWFjDQo+ID4gKw0K
PiA+ICsgIHJlZzoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGludGVycnVw
dHM6DQo+ID4gKyAgICBtYXhJdGVtczogMg0KPiANCj4gSXMgdGhlcmUgYSB1c2UgY2FzZSBmb3Ig
c3BlY2lmeWluZyBhIHNpbmdsZSBpbnRlcnJ1cHQ/DQoNCk5vLiBBbGwgVVNCLURNQUMgb2YgUi1D
YXIgR2VuMi8zIGFuZCBSWi9HbiBoYXMgMiBjaGFubmVscy4NCkluIGNhc2Ugb2YgUi1DYXIgR2Vu
MywgcGxlYXNlIHJlZmVyIHRvIHRoZSBGaWd1cmUgNzUuMSBVU0ItRE1BQyBCbG9jayBEaWFncmFt
Lg0KVGhlc2UgVVNCLURNQUNuIGhhdmUgQ0gwIGFuZCBDSDENCg0KPiA+ICsNCj4gPiArICBpbnRl
cnJ1cHQtbmFtZXM6DQo+ID4gKyAgICBtYXhJdGVtczogMg0KPiA+ICsgICAgaXRlbXM6DQo+ID4g
KyAgICAgIC0gcGF0dGVybjogIl5jaFswLTFdJCINCj4gPiArICAgICAgLSBwYXR0ZXJuOiAiXmNo
WzAtMV0kIg0KPiANCj4gV291bGQgaXQgbWFrZSBzZW5zZSB0byBsaXN0IHRoZSAodHdvKSBhY3R1
YWwgY2hhbm5lbCBuYW1lcyBpbnN0ZWFkPw0KDQpJIGFncmVlLiBKdXN0IHVzaW5nIGNoMCBhbmQg
Y2gxIGlzIHNpbXBsZXIuDQoNCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgbWF4SXRl
bXM6IDENCj4gPiArDQo+ID4gKyAgJyNkbWEtY2VsbHMnOg0KPiA+ICsgICAgY29uc3Q6IDENCj4g
PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBUaGUgY2VsbCBzcGVjaWZpZXMgdGhlIGNo
YW5uZWwgbnVtYmVyIG9mIHRoZSBETUFDIHBvcnQgY29ubmVjdGVkIHRvDQo+ID4gKyAgICAgIHRo
ZSBETUEgY2xpZW50Lg0KPiA+ICsNCj4gPiArICBkbWEtY2hhbm5lbHM6DQo+ID4gKyAgICBtYXhp
bXVtOiAyDQo+IA0KPiBJcyB0aGVyZSBhIHVzZSBjYXNlIGZvciBzcGVjaWZ5aW5nIGEgc2luZ2xl
IGNoYW5uZWw/DQo+IA0KPiA+ICsNCj4gPiArICBpb21tdXM6DQo+ID4gKyAgICBtYXhJdGVtczog
Mg0KPiANCj4gTGlrZXdpc2U/DQoNCkFzIEkgbWVudGlvbmVkIGFib3ZlLCB0aGVyZSBpcyBub3Qg
YSB1c2UgY2FzZSBmb3Igc3BlY2lmeWluZyBhIHNpbmdsZSBjaGFubmVsLg0KDQo+ID4gKw0KPiA+
ICsgIHBvd2VyLWRvbWFpbnM6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBy
ZXNldHM6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4g
KyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiArICAtIGludGVycnVwdHMNCj4gPiAr
ICAtIGludGVycnVwdC1uYW1lcw0KPiA+ICsgIC0gY2xvY2tzDQo+ID4gKyAgLSAnI2RtYS1jZWxs
cycNCj4gPiArICAtIGRtYS1jaGFubmVscw0KPiANCj4gU2hvdWxkbid0ICJwb3dlci1kb21haW5z
IiBhbmQgInJlc2V0cyIgYmUgbWFuZGF0b3J5LCB0b28/DQo+IEFsbCBjb3ZlcmVkIFNvQ1MgaGF2
ZSB0aGVtLg0KDQpPb3BzLiBJJ2xsIGFkZCB0aGVzZSBwcm9wZXJ0aWVzIGFzIHJlcXVpcmVkLg0K
DQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+IEdye29ldGplLGVldGluZ31z
LA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0
IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2Vl
cnRAbGludXgtbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0
ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20g
dGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhp
bmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVz
IFRvcnZhbGRzDQo=
