Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0A3429FA7
	for <lists+dmaengine@lfdr.de>; Tue, 12 Oct 2021 10:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhJLIWk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Oct 2021 04:22:40 -0400
Received: from mail-eopbgr1410124.outbound.protection.outlook.com ([40.107.141.124]:3412
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234605AbhJLIWk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Oct 2021 04:22:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7h7MwmfSo7frgcNfL7a2+pRKQzM0rXS0COnQkJ4pkz/4ZOn4+bnZIVDe5hGerHya/sySXNaGYgWzAswAn7DbTjjJ0Pa7O8y3qSqGSLU7hpAUHfhxohTgtq+40KVOFfNuJWGwLnxUQBorep9gtvRdklmrEECigBO/mSjgEEGGz6fv0dO7AwPs/F8vuSeUExqt4H9/z8R51EjfdhyBqd6nX7E6WWTayCoZcxLv0JmehTrmsFTaHCrPa64H781fsJKvSRRtx/lLEx1FssCXWB91hsJxdPLwlkx7s3GnUOXxmA/PDsz/2BySeFTiZgMfCofj4/8ZIuu7JIuDQHos3k2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPgbCoLt0VBvqHVP5Px6aivdErBgOsL1PhWjIRt42NY=;
 b=oNLK1RPdrc4kOrCq6TLamf9ZVuD9u+X+H3fo7r6tOwI1X4soyJMB/4YLKAFQHRii01I8pL37qVyTtd3a+QzIlhyiEREhzqyNU3s04BmjCtpga5/6u2PiZJs1CxvQFKMYgBg5ZQTrf0CI+hb205Y4Uk27SrgqZdFq3FtbpjgTV4xaw+JQ+P78t2P3Bnmu9ymMq0D0LQQYw9uQhBHKOpbjRKF5OGgnGlNjPTJ32LKEJGkGF6EItxnfpxe+Ys0VHn2pruryNuOcKc8Qbzqtonlh9YwZJtDNqCZVxmONSRdK2vtZUWt1SSCEbEr2uQEeNfWSUZacQUe0LJGgj8fHuhs8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPgbCoLt0VBvqHVP5Px6aivdErBgOsL1PhWjIRt42NY=;
 b=tHC9W7h9P/xN+lZwGtGZYZgQHuuRyk1yYtm+Om1Xaf10EPAUtYBhM+iR0aKvKrfXzM6HIiChuvP1V7FdZNUPZ3AJTaXAEiSpcxV5yZdl/mjECgPi5LBRQP059hCFJBT51Y4d/fdTXWvOt4DJDQeo1eAUzSamUMgf2srg8MYzlHI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB3571.jpnprd01.prod.outlook.com (2603:1096:604:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 08:20:33 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9ca6:1cf:5:9fc1]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9ca6:1cf:5:9fc1%3]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 08:20:32 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] dmaengine: sh: rz-dmac: Add DMA clock handling
Thread-Topic: [PATCH v2] dmaengine: sh: rz-dmac: Add DMA clock handling
Thread-Index: AQHXsGVBCXM7ODJ3WkiMFmKCqc5Bp6vPIUaAgAAAwbA=
Date:   Tue, 12 Oct 2021 08:20:32 +0000
Message-ID: <OS0PR01MB592237E34275BBBA8C4AC95A86B69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210923102451.11403-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdXF0QwFTZdi2qGuUk6ui=X+TnkgScxqu5oMrEi+4yGN=A@mail.gmail.com>
In-Reply-To: <CAMuHMdXF0QwFTZdi2qGuUk6ui=X+TnkgScxqu5oMrEi+4yGN=A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none
 header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 660bbe76-781e-4843-b329-08d98d592900
x-ms-traffictypediagnostic: OSAPR01MB3571:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB3571D028338253C406EB828A86B69@OSAPR01MB3571.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vL4AAmIkgBlHTSVjtM0stowsoP2/XGptp8MnKCBe+ij8e1oRDNabKRemAq20h/F+zquhg/KNBxucMy0q+u4t9gjofWas8TOdrSe6JiiUZ3zGrUhRVIFZ36FmOiLxvBNe5KbsZzANuuK5r91000gttCT/t3MBmFmN44M7nWrGg+6/MyDCxLxcU3k2N2iVdH/ZQorG+ycZTjSDo8vVIrYMZZA9UasGwbrBHpO2ngLHCcYy8YpyhDZ+SHqCPIbx120Isl2I/Z8RggzD7I5jbw4W2JPgHsmfh0sotcQQTyu7g0m0lwUkVvqNZx7s/zsG6SF10Gq4fUGoHgR9pveqs5eE2RHw5gyy0u6rcK0Up2l2kPoH4w7eZnGpO83LKuoyLwrneW/Xn6EFXOhna1vzJ9Udy6y66+uUhHlVmtRHs3K0+WLRSt2d+csioVmKZ1gKo3Ar01QCOY12xW04ouJDhgoz4QvInkAffXtf24EdOMvTyMR1anfg36Gz/8f/hjHBTm7h9qJVcwUtlwV0wcRbc9loLPzlgM8maInzcI9CfvcMFrVrsFKNKoxJLADbowggohlaYSytsGNWgorLIrIZ0Q/zz026aSXzsrywAw5a1xxsEsCsTVq8pixJm5ufxVtV28/OWYu1RNEgHh25KcRt7vWAT1tvjq6Dofm9mDyKIxp0hZzcO/4/K5nGb3AskKfiNHm/C/TzrGWPsE4hLjbM9vwDFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(6506007)(2906002)(7696005)(54906003)(71200400001)(9686003)(316002)(64756008)(508600001)(66446008)(55016002)(66946007)(66476007)(38070700005)(186003)(76116006)(110136005)(53546011)(86362001)(26005)(66556008)(5660300002)(52536014)(122000001)(8676002)(8936002)(4326008)(83380400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjNiYnFXVmVMRVM2cnZEbHJma1JWVGx3YUZDWklTT3FIcjRqbEI4ZG03VnMz?=
 =?utf-8?B?d2dMMU5FRXFtUzRERUJ6bEV6NGtuN2x6RzRQb09zNGtYYWdiOFFHRDBzeDRI?=
 =?utf-8?B?K1Bya3F6bG5PNG5Cb3hwbW0yRlZwZGZncW1uZ3BlMWhTWmtab1BCOUR5emha?=
 =?utf-8?B?SjJnZ1RIMk5FZVRIak1YNzY3Q0pDc2pxdUNseUFWMTZFZ2drREZNS2dFVE5x?=
 =?utf-8?B?M3RQNyswNlQveTFNb0JNSjdvV1hISTE4bUFsejdudFJ5UnFlSmRHMzV1dGpS?=
 =?utf-8?B?aithTlNCK2hRd0VSaTIvMHFwZ3lhZGtVeUpWay9meU5ZdmdNNjBOOEgwVW9y?=
 =?utf-8?B?RmtFWEZBeE5GUS9wNDQxWUJ2eCtHNjgwQ1g1TSs2TkJxU1BBbUNyZEsxQ3BY?=
 =?utf-8?B?WVpjc09JWmR3M2xZM0NFWUgrZTc3Vkx0ZzVOVUVYTFkxeExpUFY3cEtTTi81?=
 =?utf-8?B?Zk4wem8vU0ZEWk52L3BUelNzekVOenZwa1RKTXB1blJ5VXNmSGZja0dlaXRI?=
 =?utf-8?B?NUJBK2xZUmNtWFZOc2lCWVZpaExFVU0veVlWSlpmSERXQUpWU1pRUndtYkdU?=
 =?utf-8?B?azF6YXE5bXVGMTN2MU55dmJFa215bmxRL1RGaExZb1pQdzY3WXNIazBXbmJP?=
 =?utf-8?B?bXZmVXAxMlZSWXZGUHQ2NHBsZlVpTys0aXBtZ3NVam9SQjlGSE9keWxRU1ND?=
 =?utf-8?B?cW5UYzBULzd6ZWxXKzE4RHd0b2V6VHdHYVk1MXB0alF5Sndjak53cE1oaHdE?=
 =?utf-8?B?cTJHYlBtem5lUlREbUdlMFlKaC9QcTRTNjd6Q21meXBtelpWVVVZYUk4aGZG?=
 =?utf-8?B?UE1zTTRoRmgxclhWN0UyaDl1VUJBdlc3djkwZTlwYzdVLzR1L3paelBTWkFO?=
 =?utf-8?B?emVvdXh2OHJaaHVTUmpWL2hmaVE1dmhiS1QxY1hMY1FXVzgxZ2RsZ21zTWZK?=
 =?utf-8?B?WU1yN3ozalJWK3N0MDRIT2dDdjdTUTczMEVCbjJ5Vi93MjQ0bEhIUEhIVkFV?=
 =?utf-8?B?NTU2eHMvZllmdTYwZkloaU5YdUxlMkNLSTFFZzZMWFViOWFTVjFzZlc4SWs2?=
 =?utf-8?B?ZHJsWktycFpVY0lpT2lTbFN1L055aE1nRDV6TnloaHFRZjZUaEx2MmdMZ3Ir?=
 =?utf-8?B?V09FdkZlSlVCclBXMm83T1V3UVdwOWFMbmpSUDh4bVRtR2U1UmhLRXNBRFlM?=
 =?utf-8?B?U3dBSi8zUmdGV2traWpkbTFzN1ZGczc5RHhZL0h5WGNhc2h2S2hKR25LSGRQ?=
 =?utf-8?B?dnhBdzBWUUJDSjZXRnNGWVZpQlFjcnAzUTlhVE9JS2M4VS80ZFJhSDh2NGxq?=
 =?utf-8?B?Vm1UZXR4OWVwdTd0Wng4NExSRTA3aERDZzZSeTUxTjMwMDlrLzJaU2lBcytH?=
 =?utf-8?B?RjlBL1BGSER3RktCd0RPNnFSTkQrN2xNa0tQZ3lPbmNENTYwamNvTkxXUlN0?=
 =?utf-8?B?Mm9oZU5mZlQ0MWFtRWNIL3ZBTFAwSHlmOG5kN2VLZzlDL3U0QTN0RlF2d2xz?=
 =?utf-8?B?L3IvZjZEeTFac3ZZMWxYMnJES2pNSXlpbkIzMG1FdldxOGZGMU0wOHRHc2ZV?=
 =?utf-8?B?TEJ4Uk0wbTEvWGFVMmFGckY1dHhSZ0VIV0RRQ2FNR3RwN0Q2RExqamc4cFll?=
 =?utf-8?B?SytSV3Q3VjZkVktqNjdmY3lMRlJmVldnV3UycWNrOHhmdDNLQWJ5RjhrL1ZI?=
 =?utf-8?B?Y3pYbU5LVHc4MTRDd1lyUjVNQlNueGRyS2ExS0pwd3AvK24xRWZTSUowS2Nw?=
 =?utf-8?Q?w2hWCjHr4KC9B8b5hY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660bbe76-781e-4843-b329-08d98d592900
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 08:20:32.6933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52P6erlnTbvsGcc01FQB+odkAapH2ct85aMJk5uIR5cIJzPHKt6KlZNt0Izd4deFLmg9pXalylvIhoiwrfRvSGhygkk+4hsDG20ji9TatuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3571
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjJdIGRtYWVuZ2luZTogc2g6IHJ6LWRtYWM6IEFkZCBETUEgY2xvY2sgaGFuZGxpbmcN
Cj4gDQo+IEhpIEJpanUsIFZpbm9kLA0KPiANCj4gT24gVGh1LCBTZXAgMjMsIDIwMjEgYXQgMTI6
MjUgUE0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4g
PiBDdXJyZW50bHksIERNQSBjbG9ja3MgYXJlIHR1cm5lZCBvbiBieSB0aGUgYm9vdGxvYWRlci4N
Cj4gPiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgRE1BIGNsb2NrIGhhbmRsaW5nIHNvIHRo
YXQgdGhlIGRyaXZlcg0KPiA+IG1hbmFnZXMgdGhlIERNQSBjbG9ja3MuDQo+ID4NCj4gPiBGaXhl
czogNTAwMGQzNzA0MmE2ICgiZG1hZW5naW5lOiBzaDogQWRkIERNQUMgZHJpdmVyIGZvciBSWi9H
MkwgU29DIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVu
ZXNhcy5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVu
ZXNhc0BnbGlkZXIuYmU+DQo+IA0KPiBJZiBJJ20gbm90IG1pc3Rha2VuLCB0aGlzIGlzIGEgZml4
IHdlIHdhbnQgaW4gdjUuMTUsIHRvIGF2b2lkIHJlZ3Jlc3Npb25zDQo+IHdoZW4gdGhlIGNsb2Nr
IGRyaXZlciB3aWxsIGJlIGZpeGVkIChpbiBjbGstZml4ZXMgZm9yIHY1LjE1KSwgYW5kIERNQSB3
aWxsDQo+IGJlIGVuYWJsZWQgaW4gRFQgKGluIHY1LjE2KT8NCg0KWWVzIHRoYXQgaXMgY29ycmVj
dCwgb3RoZXJ3aXNlIGl0IHdpbGwgY2F1c2UgcmVncmVzc2lvbi4NClZpbm9kLCBjYW4geW91IHBs
ZWFzZSBhcHBseSB0aGlzIGFzIGZpeGVzIGluIDUuMTUuDQoNClJlZ2FyZHMsDQpCaWp1DQoNCj4g
DQo+IFRoYW5rcyENCj4gDQo+ID4gLS0tDQo+ID4gdjEtPnYyOg0KPiA+ICAqIEhhbmRsZWQgdGhl
IGZhaWx1cmUgY2FzZSBmb3IgcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldA0KPiA+ICAqIEFkZGVk
IEdlZXJ0J3MgUmIgdGFnLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2RtYS9zaC9yei1kbWFjLmMg
fCAxNCArKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL3NoL3J6LWRtYWMuYyBiL2RyaXZl
cnMvZG1hL3NoL3J6LWRtYWMuYyBpbmRleA0KPiA+IGY5ZjMwY2JlY2NiZS4uZDlmMmNmZWY4Nzhl
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZG1hL3NoL3J6LWRtYWMuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZG1hL3NoL3J6LWRtYWMuYw0KPiA+IEBAIC0xOCw2ICsxOCw3IEBADQo+ID4gICNpbmNs
dWRlIDxsaW51eC9vZl9kbWEuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+
DQo+ID4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUg
PGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPiAg
I2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+DQo+ID4NCj4gPiBAQCAtODcyLDYgKzg3MywxMyBA
QCBzdGF0aWMgaW50IHJ6X2RtYWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRl
dikNCj4gPiAgICAgICAgIC8qIEluaXRpYWxpemUgdGhlIGNoYW5uZWxzLiAqLw0KPiA+ICAgICAg
ICAgSU5JVF9MSVNUX0hFQUQoJmRtYWMtPmVuZ2luZS5jaGFubmVscyk7DQo+ID4NCj4gPiArICAg
ICAgIHBtX3J1bnRpbWVfZW5hYmxlKCZwZGV2LT5kZXYpOw0KPiA+ICsgICAgICAgcmV0ID0gcG1f
cnVudGltZV9yZXN1bWVfYW5kX2dldCgmcGRldi0+ZGV2KTsNCj4gPiArICAgICAgIGlmIChyZXQg
PCAwKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgInBtX3J1bnRp
bWVfcmVzdW1lX2FuZF9nZXQNCj4gZmFpbGVkXG4iKTsNCj4gPiArICAgICAgICAgICAgICAgZ290
byBlcnJfcG1fZGlzYWJsZTsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgZG1hYy0+bl9jaGFubmVsczsgaSsrKSB7DQo+ID4gICAgICAgICAgICAgICAg
IHJldCA9IHJ6X2RtYWNfY2hhbl9wcm9iZShkbWFjLCAmZG1hYy0+Y2hhbm5lbHNbaV0sIGkpOw0K
PiA+ICAgICAgICAgICAgICAgICBpZiAocmV0IDwgMCkNCj4gPiBAQCAtOTI1LDYgKzkzMywxMCBA
QCBzdGF0aWMgaW50IHJ6X2RtYWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRl
dikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hhbm5lbC0+bG1kZXNj
LmJhc2VfZG1hKTsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICsgICAgICAgcG1fcnVudGltZV9w
dXQoJnBkZXYtPmRldik7DQo+ID4gK2Vycl9wbV9kaXNhYmxlOg0KPiA+ICsgICAgICAgcG1fcnVu
dGltZV9kaXNhYmxlKCZwZGV2LT5kZXYpOw0KPiA+ICsNCj4gPiAgICAgICAgIHJldHVybiByZXQ7
DQo+ID4gIH0NCj4gPg0KPiA+IEBAIC05NDMsNiArOTU1LDggQEAgc3RhdGljIGludCByel9kbWFj
X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAgICAgICAgfQ0K
PiA+ICAgICAgICAgb2ZfZG1hX2NvbnRyb2xsZXJfZnJlZShwZGV2LT5kZXYub2Zfbm9kZSk7DQo+
ID4gICAgICAgICBkbWFfYXN5bmNfZGV2aWNlX3VucmVnaXN0ZXIoJmRtYWMtPmVuZ2luZSk7DQo+
ID4gKyAgICAgICBwbV9ydW50aW1lX3B1dCgmcGRldi0+ZGV2KTsNCj4gPiArICAgICAgIHBtX3J1
bnRpbWVfZGlzYWJsZSgmcGRldi0+ZGV2KTsNCj4gPg0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+
ID4gIH0NCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxv
dHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtDQo+IG02OGsub3JnDQo+IA0K
PiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxs
IG15c2VsZiBhIGhhY2tlci4NCj4gQnV0IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMg
SSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nDQo+IGxpa2UgdGhhdC4NCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
