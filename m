Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC0879FDAB
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2019 10:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfH1I5R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Aug 2019 04:57:17 -0400
Received: from mail-eopbgr1400121.outbound.protection.outlook.com ([40.107.140.121]:9856
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbfH1I5Q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Aug 2019 04:57:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6S7x4gmCr/C/WgF6Qs3Dn9Sc6l22aHSaqoG9ubmTBYaNp3OkU7tu6fcWfyulk4zifinfxbTgQ5v/GoxUjiHWSswkZSZIctxCpBLLDsthsgGHF0qywmLndPEbnIxRs38KyDcHf5mREBghk7zZupw7NoxFqtnEVnKHYC74AmJDtxn5sCDjU/c4QDrUjOk2zyfk0sWkS5NoNdcCB+Wxf06iyPJwr21P6eUihUrudA88q20I1prfrRUVUUl4hNa7RfNwY0bNqexSmChhcM5hRXKpdwHvQM71WufxDG1x9v5ocGBZ17KeGU2pm/DBkLh9zZJ0nNXmpm8k6nv3i8I77fP7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVRq8trD6/0wtJj0/xyehlDhSSPiaPRTWsSsUm/A/ZQ=;
 b=eWdRrhlURgXBVr9mtSkJsPUh7rGt8YobTnnQmJZNuN80UyMmqwAeI2TnJQC4dGRfYHhqB3QhdR4tKWFIB52nm3oUmzOc0gYmqE8W2XoeVO1Lrwgr9n/VyiKpX9AMhX0zvrJmyqgR4GLspUGYPt3inMlSM65OzeCevK3gMlPQfoIYzdBLKrGFGMEvODIyFoIwLTN83bnAShg3OpTFKOPmes7EcuYIeXI4Yz1FTGECnSpRu03L5rYDpwxTzkvHVhlodAWUPGHpcF/lquLkzQ7a3j45GzalFp5G/mU8UKbjJXh30rVdXLkVfub5xuiOZsnEmFyXsxAcQlzA5pryYBxmOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVRq8trD6/0wtJj0/xyehlDhSSPiaPRTWsSsUm/A/ZQ=;
 b=eAt5wdkNL9/J9nkRXkd6HpYPAz5tgkZr/mG7QT5Gh7fyupP1yTvm27cGwUibtmZByzFLeU7zPRLP3VN9Z1XkGF+nkmMlqUwS58G8K74Pl16T9gyYvWJ06+gvuVZXgfEfzz0uZhd7YW3IBC12k7AH6MQilRgk0HK3XTi4ZvXJwXQ=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB3936.jpnprd01.prod.outlook.com (20.178.139.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 08:57:13 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf%5]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 08:57:13 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: dmaengine: dma-common: Revise the
 dma-channel-mask property
Thread-Topic: [PATCH] dt-bindings: dmaengine: dma-common: Revise the
 dma-channel-mask property
Thread-Index: AQHVXWuY7BBEFyXtZE29P6wjBVSPHacQKgmAgAAX1wA=
Date:   Wed, 28 Aug 2019 08:57:12 +0000
Message-ID: <TYAPR01MB4544BB54346D937B41E16F7CD8A30@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1566974375-32482-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdVHtJTmuW0z+LRRFGL4O2bjiNv6odyGTmLi-EqxN1PP8g@mail.gmail.com>
In-Reply-To: <CAMuHMdVHtJTmuW0z+LRRFGL4O2bjiNv6odyGTmLi-EqxN1PP8g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 795346dc-7701-4991-617a-08d72b95b7de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB3936;
x-ms-traffictypediagnostic: TYAPR01MB3936:
x-microsoft-antispam-prvs: <TYAPR01MB3936375CFCD938B3D2589D82D8A30@TYAPR01MB3936.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:483;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(256004)(8936002)(6436002)(99286004)(9686003)(186003)(14454004)(8676002)(55016002)(81156014)(81166006)(7696005)(76176011)(478600001)(53936002)(26005)(316002)(54906003)(102836004)(5660300002)(6246003)(2906002)(86362001)(66556008)(7736002)(66446008)(446003)(64756008)(66946007)(66476007)(11346002)(76116006)(305945005)(476003)(3846002)(66066001)(4326008)(6116002)(486006)(229853002)(33656002)(74316002)(71200400001)(71190400001)(25786009)(6506007)(6916009)(53546011)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3936;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wIf+6b/BSvwoA0onpblALMHus7xvQQnuuDcAr77G2f4N+RKvbook6ueSaOYcMfrkBZ3+7pvPA5sHcvAFPiedM57EQ0VDurTWSu3eycswLKgEJgXJ4HSquqgHYyH/Mq4vw0cx6Dw4lRG8ujxNjuBlF7zR8vr4ZdF228xrL0El5eCm8BakxhuCRKR+vU6GqwagtO4/xauY83mLbR5+ZeAeliFai2qsn6vJ5hyzYHfWIMa8UeE/LV3tUAJAZo4V4I6CsvQkWf0R07RaYyB74bj6NPv/zV3A+TcH9PeV20XfPmhkhaKaM+rrkCmX5ZxUzyzZbuY80WnA5WG1toTmKoT0RwXJgm5zYRsrIQIub6VURuD9O3Jesjsns2APWGCcyWhdlfc0ktjByh0e+v1+JDZGBMtHK52B0h3kNoifR8dnYRY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795346dc-7701-4991-617a-08d72b95b7de
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 08:57:12.9301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFrhwVwUuujcRorfQvT3M/Ad2I22YMAs2DLbLoWbB1bNcj1j67WgaGz7aQQDrS42Ry8cL64/7jE93IkFo6UzyhpcUtllfgXuAWHXFg3HSAGIXGPUgeYlW6Oo+TbdZJfa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3936
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogV2VkbmVz
ZGF5LCBBdWd1c3QgMjgsIDIwMTkgNDozMCBQTQ0KPiANCj4gSGkgU2hpbW9kYS1zYW4sDQo+IA0K
PiBJIHdvdWxkIHMvUmV2aXNlL0ZpeC8gaW4gdGhlIHN1YmplY3QuDQoNCkkgZ290IGl0LiBJJ2xs
IHN1Ym1pdCB2MiBwYXRjaC4NCg0KPiBPbiBXZWQsIEF1ZyAyOCwgMjAxOSBhdCA4OjQxIEFNIFlv
c2hpaGlybyBTaGltb2RhDQo+IDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4gd3Jv
dGU6DQo+ID4gVGhlIGNvbW1pdCBiMzdlMzUzNGFjNDIgKCJkdC1iaW5kaW5nczogZG1hZW5naW5l
OiBBZGQgWUFNTCBzY2hlbWFzDQo+ID4gZm9yIHRoZSBnZW5lcmljIERNQSBiaW5kaW5ncyIpIGNo
YW5nZWQgdGhlIHByb3BlcnR5IGZyb20NCj4gPiBkbWEtY2hhbm5lbC1tYXNrIHRvIGRtYS1jaGFu
bmVsLW1hc2tzLiBTbywgdGhpcyBwYXRjaCByZXZpc2VzIGl0Lg0KDQpBbHNvLCBJIHRoaW5rIHRo
aXMgbGluZSBzaG91bGQgYmUgcy9yZXZpc2VzL2ZpeGVzLy4NCg0KPiA+IEZpeGVzOiBiMzdlMzUz
NGFjNDIgKCJkdC1iaW5kaW5nczogZG1hZW5naW5lOiBBZGQgWUFNTCBzY2hlbWFzIGZvciB0aGUg
Z2VuZXJpYyBETUEgYmluZGluZ3MiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hpaGlybyBTaGlt
b2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5
OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KDQpUaGFuayB5
b3UgZm9yIHlvdXIgcmV2aWV3IQ0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0K
DQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2Vl
cnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGlu
dXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFs
IGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFj
a2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJw
cm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=
