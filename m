Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64883C9E97
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 14:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhGOMaw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jul 2021 08:30:52 -0400
Received: from mail-eopbgr1400104.outbound.protection.outlook.com ([40.107.140.104]:42976
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229862AbhGOMaw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Jul 2021 08:30:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCVP4YOeuz5V7WFYsEDFBHqp5ffIKue9ExUVK6g5bE/4WHldflO/IXtGsDOoRvTgHSnCsuSjzehHynY055CjP9Yq6InUX2PFXtj1ys8R3D9Laxo4suqTuh444y7/4zGiBiMdDR32GHWHGkI2LkuJnJ8zFcSPwSp9QQtwlf9RIPJbSCKhIkSL5ymdNO9pEkWZjQtCW0GkfsAvSF/+UvKScaR/voh218LM7AFseR2kgLxmeDn4ot7tzMItQae8zjDPWX4HN/cCBexhCoC+Y2liGMdK5Q0rn9LPQPIdOw5MuKrHrtyWmj7oLuhtaUPaCQPywwdb/Tp2Nr2Saaffrl8JgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYm6h5BekaHqjARbrtw6Ywdb/BtrVWJRUo3KFLJp69s=;
 b=UFK58aifYC5NUSgr0d3V8GpR/wPQ0WuuEEMzaZey5ji/fFk3kZJJGeMiX30nNp4WUghXG3XwaSEcJMirU6j0iJW3ZGisHb60OjzzQJE3ZE1vggZQ2Hx2933PVTvz6LoAGG1MOD30ZdZBnAonSqh6MTwtA+kymBOB4/ZH7ISiaL0wyaN3h3uvBwK4nMYc/k6LJg79pAIAUji3V6DMX68WhKUHPraLnZCVBnU8+8CMWR32FWf+iwPwsxCyBvT8hV5ZmUzi7PihztvhVQYHKyyjARBJO4vsD1jFM13pEB9cD4Bnco0wJabyNmlzcJkp8gP02cAhHVSyk6VAQaEm2dQC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYm6h5BekaHqjARbrtw6Ywdb/BtrVWJRUo3KFLJp69s=;
 b=JeAOkwNMEM2iOXTa7390cp7itl/QOio+bcUnjtRfPOpX/bLSrXcZeJ7Kl8B6aBQADaur1agWhPx3al0tu2PEEurDcSXVmg4AT+xi3EsewwWskMZMFZjvBdOjeDDkRq/+WR2Zk49gXJ58gMDz9Vjj6ybAb1o4l4LTeXOLQcDiGug=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5925.jpnprd01.prod.outlook.com (2603:1096:604:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Thu, 15 Jul
 2021 12:27:56 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe%9]) with mapi id 15.20.4331.021; Thu, 15 Jul 2021
 12:27:56 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine <dmaengine@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Topic: [PATCH v3 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Index: AQHXbynVYmsBZxQS4EiRHSpVqA5Gl6tCMM4AgAHZ0/A=
Date:   Thu, 15 Jul 2021 12:27:56 +0000
Message-ID: <OS0PR01MB5922E3781D974DE51FC5F0ED86129@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210702100527.28251-1-biju.das.jz@bp.renesas.com>
 <20210702100527.28251-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdV8VFoUC_Od9F=4On6=tZwr-qN4s4g+=_QcHQTrxrvQJg@mail.gmail.com>
In-Reply-To: <CAMuHMdV8VFoUC_Od9F=4On6=tZwr-qN4s4g+=_QcHQTrxrvQJg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none
 header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61662556-77b3-4465-2297-08d9478bf9f7
x-ms-traffictypediagnostic: OS3PR01MB5925:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB5925DDED97041A9FD18F1DA086129@OS3PR01MB5925.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dIyeqUqBBp1Mj+iTOiSfm5lksBAZ376qDTu7aiXRTDtiP+OgI41i7w3MexsZ46CvI62X25OhFOpK2Xdqehz9//+YDaUIgK0nXStTes4PP5o1Bg5aw7+9S1dkJT6NKD87l9/nMOWyTEBl8rHgWJhWeocqCmvR9g/m1EvXNgC5WQBLM7n+pjydHF6moBVjPhrGWp0FrZvByBrKn/U6dCEsdrCVylOXBkOxKSgALEqw6hxXeidCzo19SKuMeyCCUSlIySNhiFee9vd69Yz8dYyC4KrrDTzTbwM3f3pS4UQNo2g/VEfqsmHI1N8LosMYHDgVFt6VGAHYKOFqVdxXRp3yaztHy/eCGHKEFC3IR6EKLERIZKnF8rzSoeFLBY66e2F4WNSQFxVwI1NsIVB2zzoUGo+v+sj5Dttu3eaBlhkL2Yj749oA7+z45neYU7uLIMy+RonNHGD83XPc8HfHRapMZ/fKn2bV4IrkpgpmvAnwYhH7XLSOBjOouIRyBQzgvcELy2OGj8C7d1wxiVlQLZ10GCo2WKfEws8N7CuEfMFubbC3Qm8T/GfGOFjCnFDufjaZnZna5rn8CSxNYHg0FSrsWYuQP8oHLW5pCbwgZqcUeKMstpTgjpaIslC5i4dnyoQDXVDkIrj0YxkWVdl307F3JTUnmfrRYJSV2ZaRLFLgju40Dn1Pe8EIDl/8MOQDUHpVpiZX4S6e96q6g6sAAesv1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(8936002)(5660300002)(6506007)(26005)(83380400001)(2906002)(8676002)(478600001)(33656002)(53546011)(52536014)(38100700002)(4326008)(71200400001)(7696005)(186003)(316002)(54906003)(66446008)(64756008)(66556008)(76116006)(86362001)(9686003)(6916009)(66946007)(122000001)(66476007)(55016002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXlWYzNTemp6STBmdDNOYmMrSThudlNtUG9WV3RJNXk1T1NnVHBwS2Vnanl6?=
 =?utf-8?B?RG80VUhSM1c3dnB1MEJmeXhWYVdjaGp4WHhoSVZxZDJ2L0ZpRmc4TFhuaE5B?=
 =?utf-8?B?ekI1R1dGZ2wydUlPVUQ4cGJjOGd6UEYwQUNBVG5WenRYS3ZNMktKYng4TlZD?=
 =?utf-8?B?VW9BNUJMa3NEbUMvMC9NZFNya1dhL2NlVDNaNDNscjAwTVpKdU9aQTlOWjFD?=
 =?utf-8?B?bTZzaW1XZFJraTF6eEhzZ0dhMjhXUjNQVi9maUhLd2I0VmdRV1FvUzV1VThC?=
 =?utf-8?B?Nkg4aURuenZqMEZydkV1dXE1cnptZFZlaTNNdkhNSGJic3BEejRXQnZQTTJi?=
 =?utf-8?B?Y01hM2t0OUIrYlNnS3AvU1FEM3RFdTRkblhDYmxEbENWOEJwUk41Vk1HSkJV?=
 =?utf-8?B?dkJUUHk2d3dReWtmRFlqa1FpWVpYdDRPdXRsblJTQ2FUTUxUNm9jZFp6NTk1?=
 =?utf-8?B?TlZ2amY4UlZ2bVUydThrVzFHblRETFNzNjJXU0IxWk14TkQvdjBlbE52b0ht?=
 =?utf-8?B?eUpJU3kxYVZQRFVaYk41VFZGb0V0dTlQQ1U1RWJ5N1dXRzNYTWkxOFdUVGJq?=
 =?utf-8?B?eE1pOWIzSmlEeHhKMDIrQlJHSEhyR3R1c1JiT0diV00weng1bUR1MldLWGt3?=
 =?utf-8?B?VU42ZnNGNTRtS2RwUWh3dXJKN0VtUnVPbTdpQ3RFUkNnd2xUZk1VaittYUxV?=
 =?utf-8?B?VU9aSUs1UDl3ZEEza3BkTS92OEZQU2dkQWh6RGtFbXJNa3EveVM3U2szb0t1?=
 =?utf-8?B?RGZIb1FUNUd5OFBKM1d5amdwWlAyQVJpSU9BQVlZSGNMZENhNDhtaFJLTS9G?=
 =?utf-8?B?OGM1OEcrNWY3cWhrRncvbDNqbkZUK2RoYlB2T0xzdi9WYy9vZjB2RUhMKzA3?=
 =?utf-8?B?SnFQdEV4Q3VpL3dHbW1tZ3NhRFd0M1g5YTMwWTJnK2J2RmhOZ01ISFA0QXZq?=
 =?utf-8?B?M3VvblpNMTdqRklJS3dBRG8xZkZKem1mTHdtV2RSK0JtbktMRUd2UzZSd3dN?=
 =?utf-8?B?a0dJaWtnb3MraGRYMFJ0dkxLTEUxbEczOEdhbkZCMUw2S3F3NUZwTzBSZVEw?=
 =?utf-8?B?TlRPMkN3M0NEbjgxMWc0cjNUMW9CU25JSVJlNlJtY0lHbGlwRDFLcm1BSVNq?=
 =?utf-8?B?WXpLeTFDWTBZeHk5TzhQbHdKZkFRTFZzcU15QTJPcDBxQVp1UDQ0UGRiaGNR?=
 =?utf-8?B?c2QwZGJNYWl5YlRON3AycGkrRG1SVnZFeG5ad0hlb3NnR2NidG1qOUZPd3ZD?=
 =?utf-8?B?RTRCNXUxZ2dYZWFTaDBJQ0Y4VkhXempCVTZJTFlVdUJPeCtWNTUrazV2SzZ6?=
 =?utf-8?B?Q293OGFpR2NLMHhlQlRIQ2NML1N2eXBGenR4Y1NWK3lrS3BHd0YvT2NOSHdF?=
 =?utf-8?B?QWM5VU5jbyt2blVaMWdMUWRiTWdWVmk0bEVlYkNzUGpZN1daNGZNNmExU3ZM?=
 =?utf-8?B?cmNnODdWU2JERzladnVyRjgzL1FCUVpkMFRZV29UTmFGdFhuVDJlMWI1RmYw?=
 =?utf-8?B?cjRQNFlRc1dDYmpJZE9FaTBkdnkvcklQeTVuU00wRHEwbURHZmwvZ0t6dG9u?=
 =?utf-8?B?QmhBRTI3NDB5ZWFLbFcyaW9hUGd2VHZPTG8zN2U1Uk1UUUducTdoblA5a2Jh?=
 =?utf-8?B?dVpWWExFSGlxd0QxNDBLQlFJSmhSWHlaOXFhRTc4blNYYjZYS2gzcjFFZy81?=
 =?utf-8?B?Q2xCWm5kS2hyMTMvTWlHMEFHVzNFekhGS3hVMnNHUzV2azA0TmJXQlBFSlpk?=
 =?utf-8?Q?eLxm6bN/Y9IEHJhNfriX3ZfwPJ0laLyKbBhIEnD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61662556-77b3-4465-2297-08d9478bf9f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 12:27:56.7861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TilBdAR8iFFtVArzLVj4pIJl5czoXAnxKaOXcifpwkhwR+fH4uDSOFN3IJJdVdQGbnBuSA0HYFKgsYinq0r03CPeErl/0b1tMSJf3roR8qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5925
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQpIaSBHZWVydCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MyAyLzRdIGRyaXZlcnM6IGRtYTogc2g6IEFkZCBETUFDIGRyaXZlciBmb3IgUlov
RzJMDQo+IFNvQw0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIEZyaSwgSnVsIDIsIDIwMjEgYXQg
MTI6MDUgUE0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToN
Cj4gPiBBZGQgRE1BIENvbnRyb2xsZXIgZHJpdmVyIGZvciBSWi9HMkwgU29DLg0KPiA+DQo+ID4g
QmFzZWQgb24gdGhlIHdvcmsgZG9uZSBieSBDaHJpcyBCcmFuZHQgZm9yIFJaL0EgRE1BIGRyaXZl
ci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5l
c2FzLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1haGFk
ZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0K
PiANCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9kbWEvc2gvcnotZG1hYy5j
DQo+IA0KPiA+ICtzdGF0aWMgdm9pZCByel9kbWFjX3NldF9kbWFyc19yZWdpc3RlcihzdHJ1Y3Qg
cnpfZG1hYyAqZG1hYywgaW50IG5yLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHUzMiBkbWFycykgew0KPiA+ICsgICAgICAgdTMyIGRtYXJzX29mZnNldCA9IChu
ciAvIDIpICogNDsNCj4gPiArICAgICAgIHUzMiBkbWFyczMyOw0KPiA+ICsNCj4gPiArICAgICAg
IGRtYXJzMzIgPSByel9kbWFjX2V4dF9yZWFkbChkbWFjLCBkbWFyc19vZmZzZXQpOw0KPiA+ICsg
ICAgICAgaWYgKG5yICUgMikgew0KPiA+ICsgICAgICAgICAgICAgICBkbWFyczMyICY9IDB4MDAw
MGZmZmY7DQo+ID4gKyAgICAgICAgICAgICAgIGRtYXJzMzIgfD0gZG1hcnMgPDwgMTY7DQo+ID4g
KyAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICAgICBkbWFyczMyICY9IDB4ZmZmZjAw
MDA7DQo+ID4gKyAgICAgICAgICAgICAgIGRtYXJzMzIgfD0gZG1hcnM7DQo+ID4gKyAgICAgICB9
DQo+IA0KPiBBbiBhbHRlcm5hdGl2ZSB0byBWaW5vZCdzIHN1Z2dlc3Rpb246DQo+IA0KPiAgICAg
c2hpZnQgPSAobnIgJTIpICogMTY7DQo+ICAgICBkbWFyczMyICY9IH4oMHhmZmZmIDw8IHNoaWZ0
KTsNCj4gICAgIGRtYXJzMzIgfD0gZG1hcnMgPDwgc2hpZnQ7DQo+IA0KDQpPSy4NCg0KPiA+ICsN
Cj4gPiArICAgICAgIHJ6X2RtYWNfZXh0X3dyaXRlbChkbWFjLCBkbWFyczMyLCBkbWFyc19vZmZz
ZXQpOyB9DQo+IA0KPiA+ICtzdGF0aWMgaW50IHJ6X2RtYWNfY2hhbl9wcm9iZShzdHJ1Y3Qgcnpf
ZG1hYyAqZG1hYywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgcnpf
ZG1hY19jaGFuICpjaGFubmVsLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVu
c2lnbmVkIGludCBpbmRleCkgew0KPiA+ICsgICAgICAgc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkbWFjLT5kZXYpOw0KPiA+ICsgICAgICAgc3RydWN0
IHJ6X2xtZGVzYyAqbG1kZXNjOw0KPiA+ICsgICAgICAgY2hhciBwZGV2X2lycW5hbWVbNV07DQo+
ID4gKyAgICAgICBjaGFyICppcnFuYW1lOw0KPiA+ICsgICAgICAgaW50IHJldDsNCj4gPiArDQo+
ID4gKyAgICAgICBjaGFubmVsLT5pbmRleCA9IGluZGV4Ow0KPiA+ICsgICAgICAgY2hhbm5lbC0+
bWlkX3JpZCA9IC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsgICAgICAgLyogUmVxdWVzdCB0aGUgY2hh
bm5lbCBpbnRlcnJ1cHQuICovDQo+ID4gKyAgICAgICBzcHJpbnRmKHBkZXZfaXJxbmFtZSwgImNo
JXUiLCBpbmRleCk7DQo+ID4gKyAgICAgICBjaGFubmVsLT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJx
X2J5bmFtZShwZGV2LCBwZGV2X2lycW5hbWUpOw0KPiA+ICsgICAgICAgaWYgKGNoYW5uZWwtPmly
cSA8IDApDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPiANCj4gUGxlYXNl
IHByb3BhZ2F0ZSB0aGUgZXJyb3IgaW4gY2hhbm5lbC0+aXJxLCB3aGljaCBtaWdodCBiZSAtRVBS
T0JFX0RFRkVSLg0KT0suDQoNCj4gDQo+ID4gK3N0YXRpYyBpbnQgcnpfZG1hY19wYXJzZV9vZihz
dHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCByel9kbWFjICpkbWFjKQ0KPiA+ICt7DQo+ID4gKyAg
ICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0KPiA+ICsgICAgICAg
aW50IHJldDsNCj4gPiArDQo+ID4gKyAgICAgICByZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihu
cCwgImRtYS1jaGFubmVscyIsICZkbWFjLQ0KPiA+bl9jaGFubmVscyk7DQo+ID4gKyAgICAgICBp
ZiAocmV0IDwgMCkgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgInVuYWJsZSB0
byByZWFkIGRtYS1jaGFubmVscyBwcm9wZXJ0eVxuIik7DQo+ID4gKyAgICAgICAgICAgICAgIHJl
dHVybiByZXQ7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKCFkbWFjLT5u
X2NoYW5uZWxzIHx8IGRtYWMtPm5fY2hhbm5lbHMgPg0KPiBSWl9ETUFDX01BWF9DSEFOTkVMUykg
ew0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgImludmFsaWQgbnVtYmVyIG9mIGNo
YW5uZWxzICV1XG4iLCBkbWFjLQ0KPiA+bl9jaGFubmVscyk7DQo+ID4gKyAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJldHVy
biAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHJ6X2RtYWNfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ICsgICAgICAgY29uc3QgY2hhciAqaXJxbmFt
ZSA9ICJlcnJvciI7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZG1hX2RldmljZSAqZW5naW5lOw0KPiA+
ICsgICAgICAgc3RydWN0IHJ6X2RtYWMgKmRtYWM7DQo+ID4gKyAgICAgICBpbnQgY2hhbm5lbF9u
dW07DQo+ID4gKyAgICAgICBpbnQgcmV0LCBpOw0KPiANCj4gdW5zaWduZWQgaW50IGk7DQoNCk9L
Lg0KDQo+IA0KPiA+ICsgICAgICAgaW50IGlycTsNCj4gPiArDQo+ID4gKyAgICAgICBkbWFjID0g
ZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZigqZG1hYyksIEdGUF9LRVJORUwpOw0KPiA+
ICsgICAgICAgaWYgKCFkbWFjKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsN
Cj4gPiArDQo+ID4gKyAgICAgICBkbWFjLT5kZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsgICAgICAg
cGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZG1hYyk7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0
ID0gcnpfZG1hY19wYXJzZV9vZigmcGRldi0+ZGV2LCBkbWFjKTsNCj4gPiArICAgICAgIGlmIChy
ZXQgPCAwKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArICAg
ICAgIGRtYWMtPmNoYW5uZWxzID0gZGV2bV9rY2FsbG9jKCZwZGV2LT5kZXYsIGRtYWMtPm5fY2hh
bm5lbHMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yo
KmRtYWMtPmNoYW5uZWxzKSwNCj4gR0ZQX0tFUk5FTCk7DQo+ID4gKyAgICAgICBpZiAoIWRtYWMt
PmNoYW5uZWxzKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+
ID4gKyAgICAgICAvKiBSZXF1ZXN0IHJlc291cmNlcyAqLw0KPiA+ICsgICAgICAgZG1hYy0+YmFz
ZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gPiArICAgICAg
IGlmIChJU19FUlIoZG1hYy0+YmFzZSkpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFJf
RVJSKGRtYWMtPmJhc2UpOw0KPiA+ICsNCj4gPiArICAgICAgIGRtYWMtPmV4dF9iYXNlID0gZGV2
bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDEpOw0KPiA+ICsgICAgICAgaWYgKElT
X0VSUihkbWFjLT5leHRfYmFzZSkpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJS
KGRtYWMtPmV4dF9iYXNlKTsNCj4gPiArDQo+ID4gKyAgICAgICAvKiBSZWdpc3RlciBpbnRlcnJ1
cHQgaGFuZGxlciBmb3IgZXJyb3IgKi8NCj4gPiArICAgICAgIGlycSA9IHBsYXRmb3JtX2dldF9p
cnFfYnluYW1lKHBkZXYsIGlycW5hbWUpOw0KPiA+ICsgICAgICAgaWYgKGlycSA8IDApIHsNCj4g
PiArICAgICAgICAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCAibm8gZXJyb3IgSVJRIHNwZWNp
ZmllZFxuIik7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPiANCj4gSSdk
IHNheSAicmV0dXJuIGRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwgaXJxLCAuLik7IiwgYnV0DQo+
IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lKCkgYWxyZWFkeSBwcmludHMgYW4gZXJyb3IgbWVzc2Fn
ZSwgc28gcGxlYXNlIGp1c3QNCj4gdXNlICJyZXR1cm4gaXJxOyIgdG8gcHJvcGFnYXRlIHRoZSBl
cnJvciwgd2hpY2ggY291bGQgYmUgLUVQUk9CRV9ERUZFUi4NCg0KT0suIFdpbGwganVzdCByZXR1
cm4gaXJxOw0KDQo+IA0KPiA+ICsgICAgICAgfQ0KPiANCj4gPiArc3RhdGljIGludCByel9kbWFj
X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+ID4gKyAgICAgICBzdHJ1
Y3QgcnpfZG1hYyAqZG1hYyA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+ICsgICAg
ICAgaW50IGk7DQo+IA0KPiB1bnNpZ25lZCBpbnQgaTsNCg0KT0suDQoNClJlZ2FyZHMsDQpCaWp1
DQoNCg==
