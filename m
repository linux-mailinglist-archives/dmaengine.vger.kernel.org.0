Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314AB415AE0
	for <lists+dmaengine@lfdr.de>; Thu, 23 Sep 2021 11:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbhIWJ0x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Sep 2021 05:26:53 -0400
Received: from mail-eopbgr1410113.outbound.protection.outlook.com ([40.107.141.113]:60048
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239965AbhIWJ0x (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Sep 2021 05:26:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gl8VDQWg7Fwm1Gmyap6BQcPjBNCnMKqKmIPGe35esmnlkIlLcOo7HPYeBhAijWoKZt/ZCLltWhvnRCNkNbwifGyPA0DK75BZLEUy1kU4R0WCB25TgQ4KqB3hzFGHukudP/7vEKdlcZPbMkbnk1Vg2WZV4mQqb3XeLgqxjp1tdjgjK+h8XgBkYG1a/CC4yDkNvLIBzdHxLbd+nv0q92vGrr2D9cn5lLPgpr586HhrQ5ghM0SJaV7MV0IYfwOq6VN+VZoJXCEoSBoVYWL3UzzNkp1nCuxAqMOvo96mJSXzMbHc1Z86+Bm1zsoLj3rqS80Zpr8PH5iSngOCwSjyK1WEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yZl585cs71NGbvjlXIJW8EJxRWOWZirM37XWabFz9iE=;
 b=LrVxViiulv8pM/w3bLr7kXWqSwtsHZPt4zUp8IIjY/GsgMHWKoUXgx4smUu5yZdnjfEMlMX7zhs+vfFc9if6j9nxxOILIOjnxI2Oa1lEZY69gTNsZN/0PyzEEqHhHpsmbO7Yd4A43kNceo0DoM5c9iqiYcgRqvSmP6+EDUr8oLtfle7vcn+1crL2CraQ8mPuLkUvsuzygM46iUyxtNbSLsS5tYj/tOHgbQImKo4Mh8DbxtvseKFlVGv+X2z85CiaREr5RcS9eAyttaXNoIXkvpXqCSas5KLUTnftMHBtrqH1w0EkkMj32BNudO5P5ZxEMdi7lUGdATRYOioIyFiU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZl585cs71NGbvjlXIJW8EJxRWOWZirM37XWabFz9iE=;
 b=KUaJBrdPhpREQaVPtvliDqURE7i+I86MIY6LzbaxVeHEr6tyu5Rb1gKEqARuru4WZDe4SfjmatZwD3Xk8+j7EyLbm9Tu6druuzG3KDN6s39lIotqI//Chnxpdo1tGcqufXGM4csGTvcP0OLW8SjPQlvQs0YJ6Q5AlKQ6y3hZLF0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB7068.jpnprd01.prod.outlook.com (2603:1096:604:11a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Thu, 23 Sep
 2021 09:25:18 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::6532:19dd:dfa1:4097]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::6532:19dd:dfa1:4097%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 09:25:18 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: sh: rz-dmac: Add DMA clock handling
Thread-Topic: [PATCH] dmaengine: sh: rz-dmac: Add DMA clock handling
Thread-Index: AQHXr6NiroPN13z2kUuXU6jqnMnwY6uxWaoAgAAAcUA=
Date:   Thu, 23 Sep 2021 09:25:18 +0000
Message-ID: <OS0PR01MB5922C9BFA7743E389068AC1686A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210922110453.25122-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdUadbZf++tTBgGUh5ZKsbu7-sr=z5wd=yHh9vgjpTU67w@mail.gmail.com>
In-Reply-To: <CAMuHMdUadbZf++tTBgGUh5ZKsbu7-sr=z5wd=yHh9vgjpTU67w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none
 header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0175a789-70de-4801-de5f-08d97e740f4d
x-ms-traffictypediagnostic: OSZPR01MB7068:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSZPR01MB70685E1E51493D0F3F16750786A39@OSZPR01MB7068.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IYbvl+zrScrdVlnho8/97zt1w8h35FO32xnNGPExk+NRaAY7r4pksfUv4cgwuhl94iPjuwBDIFaSjEl3JErwLSMgxhETT3JOJpb1IIz6rNz7R+YG0Tr4ayFqMGWFM26aRpPYPxz7hpLoQBx2/BMaiQsqCovUC7YPACo3vkqljeiT7f42cAV7ieMYaGfCwWYZiTtY6TMiNDorZnP3yfydo40ytYLXJSjNbdK8FSbgzIoXqzSwtqnt1yq+2c6g47tcsE4rFjj3RwAXybyX0sjHM3RbWesu6nIp0E3W2EMNqOkEhgPO2HbwYMyeQt9yyqhJcscuQL0vRB2bK9swC69KWhgHNxncksep8zTfWvYNT07fFRBDdsagfFx+99FlobqJVTHBTzBt+XfoBQF+4fMY9wqLY6h1BPc5QOnWV1nA+bqEQSxRet1ySavVFjOWb3U1J9lfGcedy3RxBQ3YYqNE4WKeoBkD4gyGqb78QEngEttSgeFKxlEIogO32MfkOs6rXhhvCg3JQfid3r2HSNFdz7C4kcuBWzYPB5dRF/jR0Sg0FI6BOEFNkhO7QKCVI0s0eGOCdwaW0JP8H5j7qdNiMprdf61SAh4gl7l2knj5Iax+2GR78FfPgQxfiq/Lfh2No36HhRDYgc71dFfJTCvzN4Igxr9mBZ6yzVn/foNSxUbVXjlnzu3U/clxIlELKBSVytvcDX9TbwNWrS9o3ihLGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(122000001)(66446008)(8676002)(6506007)(5660300002)(64756008)(71200400001)(316002)(33656002)(8936002)(53546011)(66556008)(76116006)(9686003)(66476007)(38070700005)(66946007)(4326008)(7696005)(54906003)(83380400001)(6916009)(52536014)(55016002)(2906002)(86362001)(186003)(26005)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTZJRmxCTWppNkdNWVdEVTN0RTJuOTNuRW9leXNQREw3d09McUxnVTlLV3BH?=
 =?utf-8?B?ZDVLbEJTY3FOMjNCb3V3NHZBRSt1L0FLU1hSRnVndjczNWlka055YjBmV2pI?=
 =?utf-8?B?eHlGQmZpQkdWekpma3B2YjZtVFN5V1NYQlhHZ2RJcElISHNJKzJRdXBJYnp5?=
 =?utf-8?B?c2RHcWNXbEplZG9uNDNOU0dscEFZbjNqNzhrSmJuODdMeGhLYVFyY3o4dnpu?=
 =?utf-8?B?Zkh0VUo1TTBQSy9ObitYcTBVU0dUQ3FjSUZFcHpEVnNXS3JMcFJHR245cGE3?=
 =?utf-8?B?d1VSTjFoWkJPZUszeUZhVlV2OHYyZVZ6SE9GMGM2WXYrRkl0dXh4d2ROdW9G?=
 =?utf-8?B?V2pZbWRpd2NjSHNoNUdlM2hUc3g3OGFKQ0pDWmhWaVpjOVJCRXIydkFEZVRD?=
 =?utf-8?B?cWZ1citJMG9TTHlJUFNmUm5OVVJabFpYYlJQSzIrMnAzZnpEdkJkUW9yYVpt?=
 =?utf-8?B?bE9WcnY0dVg0ZFRuV3IzUlROdWhxTzcwNnZMditnVEU3ekJ0R1RYN1F5Wmht?=
 =?utf-8?B?MVkxazNwVTQyNURJR1V1R1cwZktYY05qWWlzNEpXOHpCdVkwc3A4Mlk0dlky?=
 =?utf-8?B?ZGwzZGhoQWh1Uy92aGFrZ29PeS9VK1NRbUtuck81Tm5YMmx6NUdsTytBNXJ5?=
 =?utf-8?B?RE0rOWE4T0ZWK3UzL3Bvck5Tak1xK1FSYkFkVW5HTUpxOHJMVTB0NnNKaGpt?=
 =?utf-8?B?a2JaY0wxNHdVN1hzdExZZHVWaGs4VDlGaFJWMmZuMXJJVEs3T1Q4blBTTEFP?=
 =?utf-8?B?M24xcVJLY3MzOXlQYUtiNTY0MXZaaEJvRWU0TWdBTTFHeWRXUTJONkJ2RUVx?=
 =?utf-8?B?RUY0L0tFNFBzV1hPZEM5NkptRU9PdGU1SXNsU0NUc2RtUmYxTStBaUtTMjJX?=
 =?utf-8?B?aUN5RWgzNnp4L1o0T1FMZENNL0ZaeGxQVFNHMkhNdTNFV25HamhXZXFaK2Ir?=
 =?utf-8?B?b1kxRFpSc3REbTRjN3VQcFgvK1NuUjVhS1JOcnU1VzdYc3NTM0xKajkxZnBT?=
 =?utf-8?B?cG9mc0NTN0JYOHpITzRXVGRab2VRR0xHblNQY09iZi9CMEFWM3lKQXdMejY0?=
 =?utf-8?B?eHpOUlp0N3ZTZFJ3NWZaRHpwV3VTNmsxeHFQVTNqRExSK1A1UzJzMUw5cFRH?=
 =?utf-8?B?ZE9OU2VEaGYxYldad29vYlNiRHp6MXVCV0E4Q1pMZzhDbDR5SzFxb3FPYWU5?=
 =?utf-8?B?enFJRTI3NXJmVEJMY0ZJcklwb1p5elZRNlhYdHlubUREUGN6MHBxbFJHMUtp?=
 =?utf-8?B?eUdUVVNmdCtzam1iNzZMdXh5cU9JSSsxTDR0L1ZKcTNVOUhTMTBVNVhnSm9I?=
 =?utf-8?B?d2NwRDNxWHlzRURYSUUveTBWelc1Z1drRERoL05sSWpJNDNTOGRPYXBvaFo1?=
 =?utf-8?B?eVJ5dThGZTNxMHNMOXB2R0pPRjNUb24wUVMyTU9XLzdpcEhtam9tNWEwK0xj?=
 =?utf-8?B?QlZlUDY1OHpLVGFST0pqVVIzK3I1QTB5OS9kL25Hb2Y0SENZSkNzdk4rQUJy?=
 =?utf-8?B?MUt0S1hSQVlZN2ZOU0lpemhnUnBIQkJwZFRDdWF6dGNvOE5iWE0wRGt1NXlq?=
 =?utf-8?B?WWRhU05hdldtYlZKb3VZS2pQbUtMRlR6dEpWYU9mWDNCQmxwd1ZrS2Z6S21T?=
 =?utf-8?B?aFVaS0l4c0RzWEVxNTVJVTNJQnFVN1BIUkhaWFdoSnJuaGU5a1lFRU1acHVq?=
 =?utf-8?B?Y2tFd0tTWnRBUFZoRVh5NUNiT01JOGNhOTB0RDk2WWJBQmh2SllDVURaQmli?=
 =?utf-8?Q?9KUtd2/3+mzRGRlBeSOaHfz0WzzexQnY+A4sQ11?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0175a789-70de-4801-de5f-08d97e740f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 09:25:18.3790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OsJFDakNYuzWQ4KYlFntf1TXopoti1mQAepyKbntRbByeaktj4F6vrgYVtuOxYtkmoSTYRugkoIXlEZozb7ex6AUS7VBdwcFHoJmqqNpVXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7068
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRtYWVuZ2luZTogc2g6IHJ6LWRtYWM6IEFkZCBETUEgY2xvY2sgaGFuZGxpbmcNCj4g
DQo+IEhpIEJpanUsDQo+IA0KPiBPbiBXZWQsIFNlcCAyMiwgMjAyMSBhdCAxOjE3IFBNIEJpanUg
RGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6DQo+ID4gQ3VycmVudGx5
LCBETUEgY2xvY2tzIGFyZSB0dXJuZWQgb24gYnkgdGhlIGJvb3Rsb2FkZXIuDQo+ID4gVGhpcyBw
YXRjaCBhZGRzIHN1cHBvcnQgZm9yIERNQSBjbG9jayBoYW5kbGluZyBzbyB0aGF0IHRoZSBkcml2
ZXINCj4gPiBtYW5hZ2VzIHRoZSBETUEgY2xvY2tzLg0KPiA+DQo+ID4gRml4ZXM6IDUwMDBkMzcw
NDJhNiAoImRtYWVuZ2luZTogc2g6IEFkZCBETUFDIGRyaXZlciBmb3IgUlovRzJMIFNvQyIpDQo+
ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0K
PiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gPiAtLS0gYS9kcml2ZXJzL2RtYS9z
aC9yei1kbWFjLmMNCj4gPiArKysgYi9kcml2ZXJzL2RtYS9zaC9yei1kbWFjLmMNCj4gPiBAQCAt
MTgsNiArMTgsNyBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2ZfZG1hLmg+DQo+ID4gICNpbmNs
dWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1f
ZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+ID4gICNpbmNs
dWRlIDxsaW51eC9zbGFiLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPg0KPiA+
DQo+ID4gQEAgLTg3Miw2ICs4NzMsOSBAQCBzdGF0aWMgaW50IHJ6X2RtYWNfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPiAgICAgICAgIC8qIEluaXRpYWxpemUgdGhl
IGNoYW5uZWxzLiAqLw0KPiA+ICAgICAgICAgSU5JVF9MSVNUX0hFQUQoJmRtYWMtPmVuZ2luZS5j
aGFubmVscyk7DQo+ID4NCj4gPiArICAgICAgIHBtX3J1bnRpbWVfZW5hYmxlKCZwZGV2LT5kZXYp
Ow0KPiA+ICsgICAgICAgcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgmcGRldi0+ZGV2KTsNCj4g
DQo+IEkga25vdyB0aGlzIGNhbm5vdCBmYWlsIGluIHRoZSByZWFsIHdvcmxkLCBidXQgSSB0aGlu
ayB5b3Ugc2hvdWxkIGhhbmRsZQ0KPiBmYWlsdXJlIGhlcmUsIGVsc2UgdGhlIGp1bmlvciBqYW5p
dG9yIGNyb3dkIHdpbGwgc2VuZCBhIGZvbGxvdy11cCBwYXRjaA0KPiBhZGRpbmcgc3VjaCBoYW5k
bGluZy4uLg0KDQpPSy4gV2lsbCBoYW5kbGUgdGhlIGZhaWx1cmUgaW4gbmV4dCB2ZXJzaW9uLg0K
DQpSZWdhcmRzLA0KQmlqdQ0KDQo+IA0KPiA+ICsNCj4gPiAgICAgICAgIGZvciAoaSA9IDA7IGkg
PCBkbWFjLT5uX2NoYW5uZWxzOyBpKyspIHsNCj4gPiAgICAgICAgICAgICAgICAgcmV0ID0gcnpf
ZG1hY19jaGFuX3Byb2JlKGRtYWMsICZkbWFjLT5jaGFubmVsc1tpXSwgaSk7DQo+ID4gICAgICAg
ICAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiA+IEBAIC05MjUsNiArOTI5LDkgQEAgc3RhdGljIGlu
dCByel9kbWFjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNoYW5uZWwtPmxtZGVzYy5iYXNlX2RtYSk7
DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiArICAgICAgIHBtX3J1bnRpbWVfcHV0KCZwZGV2LT5k
ZXYpOw0KPiA+ICsgICAgICAgcG1fcnVudGltZV9kaXNhYmxlKCZwZGV2LT5kZXYpOw0KPiA+ICsN
Cj4gPiAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gIH0NCj4gPg0KPiA+IEBAIC05NDMsNiArOTUw
LDggQEAgc3RhdGljIGludCByel9kbWFjX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+
ICpwZGV2KQ0KPiA+ICAgICAgICAgfQ0KPiA+ICAgICAgICAgb2ZfZG1hX2NvbnRyb2xsZXJfZnJl
ZShwZGV2LT5kZXYub2Zfbm9kZSk7DQo+ID4gICAgICAgICBkbWFfYXN5bmNfZGV2aWNlX3VucmVn
aXN0ZXIoJmRtYWMtPmVuZ2luZSk7DQo+ID4gKyAgICAgICBwbV9ydW50aW1lX3B1dCgmcGRldi0+
ZGV2KTsNCj4gPiArICAgICAgIHBtX3J1bnRpbWVfZGlzYWJsZSgmcGRldi0+ZGV2KTsNCj4gPg0K
PiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gDQo+IFJlZ2FyZGxlc3M6DQo+IFJldmll
d2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiAN
Cj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVy
dA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51
eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC0NCj4gbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNv
bmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEg
aGFja2VyLg0KPiBCdXQgd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5
ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcNCj4gbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=
