Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E54E3AE876
	for <lists+dmaengine@lfdr.de>; Mon, 21 Jun 2021 13:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhFUL6U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Jun 2021 07:58:20 -0400
Received: from mail-eopbgr1400094.outbound.protection.outlook.com ([40.107.140.94]:15680
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229937AbhFUL6T (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Jun 2021 07:58:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLd21X/511E/A0hLgHKjOvhKXxgdzXiyXo2DSh4ogJlLLgLu7KhATIL7yEQ7kYj+3qmNLnWM0YyZ5jQpkDPGmzIQaxXr7Um2iWPCVfB98jERvWu+z3sDreuidxY47Jxh+mzoPlsysNIkjpz0szccZTs2hmXNu3pW8lXcpOKmUpNIxrNeCJ1fhxw6nZKb+fmAL0yh6y/AZWcjTVhfP9hizKEPbVcpH3sFcL2VWYMeBF1gVeLLBlYsL9a/t/12pNoxXWsCnaNUYYqCeq9zEFX4n6g/86QFov9ZbU5D9QoZ2s8YxFSGCC52OfWefkFfP4ekEQdScdgCvyFS1XYsZZzpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gor1b5Jb5myFgTyTLfGBF6fLLTlspZvVn3AXsVICkb8=;
 b=DOlD6xV1u9VceZCyS0ZN++rMgF88QGxKkVvQWWW4ETlthkdE2PXd6En79S/zyscXSxmcJdk5i2Hm6eT17AZyXBJ9XxQNVNxF9WrZIjkUTZdVEcBrqTV8IcJKZ5jmqjR9ycm80VkoD9UVrmwty6BDMk3fS9YQZD7myS5HBI9cvl6soGIBlaAUVe/c54iyygZV/Yol1tB8DStWC/L8lhq5UrJGqBzRMp6gfcCNUixNDnP7gugXsOLgbfA4vVapz8hRnuWyGqTGcY5ptaeEePa6Yh8EdTQu67O3WvvCgE0/AT2xzp+KjetuF36Es/NfHNXwsSdtM28dGKcEF44FOg7NzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gor1b5Jb5myFgTyTLfGBF6fLLTlspZvVn3AXsVICkb8=;
 b=hKpfqu53PsUGwPnOPBbz05gBrR6LKNv8hCjKy7k5hBDO1nGp+8+rrFrP0edhaY8x+hlWNVMIoQ9/yNI1M8SC4DpOilhQV7R/t43BKs6g77Dg/Q65pqOYy5EVZCi2qy55gYfWrfPZmvJpsw1OW3pJjSSbsQFxqahMIz9h/90jL1E=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5859.jpnprd01.prod.outlook.com (2603:1096:604:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 11:56:02 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0%3]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 11:56:02 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] dt-bindings: dma: Document RZ/G2L bindings
Thread-Topic: [PATCH v2] dt-bindings: dma: Document RZ/G2L bindings
Thread-Index: AQHXYqDJZAh2Sn0rLE2r28/uwfy5v6sWftyAgAfkcoA=
Date:   Mon, 21 Jun 2021 11:56:02 +0000
Message-ID: <OS0PR01MB59228C11F3BDE91D7A2B506C860A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210616105557.9321-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdUHiO1VP0jC5RJ6Mc1uk28bURy0tgbM4Myzp+jS87E-TQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUHiO1VP0jC5RJ6Mc1uk28bURy0tgbM4Myzp+jS87E-TQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none
 header.from=bp.renesas.com;
x-originating-ip: [193.141.219.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b4f17d5-2e48-48c7-e469-08d934ab8ad9
x-ms-traffictypediagnostic: OS0PR01MB5859:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS0PR01MB58598D2AEC258D328CC13162860A9@OS0PR01MB5859.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: da2v4TqC2NZWJRJp3KgfybkDPCKfi2ODnG4nM6ivdkBmd+C/w7ewSEV8R2yTPAoHB1idlDt8ylFG8OlKT5yQWr+Jk7N5KBV6L7rdEKqYzs0vkdMA1wROMXLXEerYP4MRsuUd7BldTMeQ5sCDTOE8Ek+dKBmsfHxcRAMF0Ug3ikexN/OREu++Eyobs23R7NEIQ3fBPOToXBBsds27rx6XBVZCHWInZl9UBV3jBXFG8MgRgMM1jbYI+wApYfMtUgdBXvQoZhGxlkB7xoxzyP2+eMNop0nwiLe8ilpZFSTQuwQcw2T8pN0fwGDXouH04u5yDgHVjSvGt/iLD6uxS9buAw5Kt9xmFWr1k4Dh12IMV5KxsIfXI/5XNnVpBWIjnZbA5zc8m0iEHhqOawUCXXZaiPSc3HHFc9tkMW/F8aAPoCz8rUxrJztu7bMTNUAC53w4OnfS8OCZoPGXvDCtMG282TD1Iua64MRiCf9+yUZSb5M8ijx7phvdqttWMkjVY9alXdThQPGT+S/0k9uJGIqAtpD47lrZUPmHGLh7w4o/EuK+p/zYz1HIIg85xV5JNBkOsTn7fd5uZS4vXcBdGbpSkLndRimttdzD/s0tCpWqoCM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39850400004)(6506007)(53546011)(5660300002)(26005)(7696005)(2906002)(186003)(4326008)(478600001)(71200400001)(6916009)(122000001)(38100700002)(66476007)(33656002)(66946007)(76116006)(66556008)(66446008)(316002)(83380400001)(64756008)(86362001)(52536014)(8936002)(54906003)(9686003)(55016002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmhYMm5FOXl5QlY3ZFZkdWw3WGwvNWVpMlc4S0lCc1FybnNWQUlGcVNXTEZi?=
 =?utf-8?B?OCthS0Ivdk5PcHArSXVnQWhZYW1kOHQvMytnTXJ4eU95aVpEQk96Q0dRSEJj?=
 =?utf-8?B?UG0xL3pXZlJDTm54eXBJZUVNeFlmYS9NS2t5SDNMQUx3aGtkVnpZbkdUalAz?=
 =?utf-8?B?VDRRTW5xcEVZRFlFQ205WnVRK1YzS0d0MzFSWUY3eWowd21zUTIwZjdiQXhX?=
 =?utf-8?B?MDAxdVRSNjdtVUtCZGtOQmdMMGNVSVI2bmljcHBsNUVjdGFuS3U1MWtDdUIz?=
 =?utf-8?B?Z0luTkt1cnpoTEhWUHFkK3VNV3pBaUhCUGFzbHltSXRuenExQ0duaENzWTlO?=
 =?utf-8?B?UDM3WjIyTndSTFIxVU9NWDFZWnNyVXp2WCtMVHlTR1hSSS9sZDQvNGF2bndi?=
 =?utf-8?B?eW1qUVlCcnNWb2s3ZGt2Y0pSUGFyWE1ZdkpKT3NSN1ZTdDZIOFBHdHRHbmk5?=
 =?utf-8?B?ZUVab2pXRnZ2NUpPeThwdGVtdk1ZRVptcW9NOVdBMXhEV3NOV3Bab0xvL05M?=
 =?utf-8?B?bkVkSkQxZzNISzFxa3hXNEtmVGFSdHAwQW94ekRZelpWUmVhNzRQQ0lRWFMy?=
 =?utf-8?B?S2E3YU00R2RieElpNkdIYldNeDRIWmhlZ1Fyb2QwUDVDdXdXVEx1WFVxamp5?=
 =?utf-8?B?SjRKUWxQNkplZGFFT0hKRW04NzFVVTAvUnY4QXlna1BxWkNWMWkyWCtpNXFR?=
 =?utf-8?B?ei9ZU1k2ZzhEV0RrUVdoTXlQNVhvNHgwUjVYaHpDalNPeVVQSTh5Q0EvUGxD?=
 =?utf-8?B?STZ5R0dnUy91UFNqenpEOFVZcldEVUlFelB1Tk1UVkRMRTZlV2Vyd0FBbkNG?=
 =?utf-8?B?OWVEWSsrL3pIazZJY21VcXNkaUxIVWZJT3lhNVcwa21BWXNUdXdBRHQ4UmVt?=
 =?utf-8?B?Z3JGWFB5RFJNVXZhUVV3Wm9ZeG8wV0pmU3FyWlZQNWVndFFJZWt1YTB3R1Ju?=
 =?utf-8?B?ME15Znpxd0tKQ21GRnJ6bFFHblg5QnM0RGMyNG45N0t6V1FsRGtIZ0JFTU53?=
 =?utf-8?B?UXFXb2U5aFAweFB2cVZCWlZhWlh1a3Q4OWVlWDN3MkJCNy9YaXM5Y3NnMDhZ?=
 =?utf-8?B?VUtiWUE4WUtmSitEQ0lIcHpiTm9iK01qdUJ0T0hGcDkycEFYc0hFcnRKbjlF?=
 =?utf-8?B?bU1GRG4wNmZlek1qYjY2SEVhMi84VEZUQzNvYytRZGRLUmppV2RYamhhWTRw?=
 =?utf-8?B?elFSK3IybUk5RXpJRG5TWTdYd1ZWcGtJbVdMdUpGQ1d5YkN0RkxJRVBvcGFK?=
 =?utf-8?B?UHpiZlRrTExNUksxNDc0TVcwMWR3cmFhVk81eERHWUNUVE9FSHdJc2pNc1RX?=
 =?utf-8?B?NFZoOHJ3TmluVXNlNDk0M3ZjT1F5Wkc4RkdJREd4Z2svVE56MEMrODlCSFpZ?=
 =?utf-8?B?bXJXTHE5Ym9EYThyUnNSb0J0bGJRbHZOQ0licW9wRGpCMnlkNnhYbGFmUG9D?=
 =?utf-8?B?LzFUOG54TlJxUlNzTTJHT3hBUHBPNlBOWTNnbUEwMEhkWmVrY2UyTzRjSE5U?=
 =?utf-8?B?ZkpLUC8rOUZNMENxQ3FESzM1ajEvSlRLYTZQRnJzUDliNHdEVW5pR2tYaklU?=
 =?utf-8?B?dzhFSGNTNCtFTjUrQS9DS00vWTY4b1diWm4wbUp4cXRvVUF3RnQ3WVlOUGlR?=
 =?utf-8?B?TithZ0VINUlJTlZBSGFHZzBnTlJkL2plY3NjNWt0eTk3c1VOcUQ3bHRwdEZQ?=
 =?utf-8?B?WnZBc3dyZHRmZXV3bGFrUEZLNXlyMHdxdXhvZUJoalh6c3BPOFNJWVZoajBt?=
 =?utf-8?Q?XjevoCkMLvwebJ8hhSScsqZDSIuQykx+fM7hrQy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4f17d5-2e48-48c7-e469-08d934ab8ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 11:56:02.2357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63M8K37mGOC+KqHDIraXzJy90i4r4XYbWxT/lrT0NZ/5yL0MtpQyecEmWeP+5aUnTUaYrEr4ocZAqQ/Zv/x+k+RTpo1TYhYjOuIx5pyIf/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5859
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjJdIGR0LWJpbmRpbmdzOiBkbWE6IERvY3VtZW50IFJaL0cyTCBiaW5kaW5ncw0KPiAN
Cj4gSGkgQmlqdSwNCj4gDQo+IE9uIFdlZCwgSnVuIDE2LCAyMDIxIGF0IDE6MTQgUE0gQmlqdSBE
YXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPiBEb2N1bWVudCBS
Wi9HMkwgRE1BQyBiaW5kaW5ncy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxi
aWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTGFkIFByYWJoYWth
ciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+
IE5vdGU6LSAgVGhpcyBwYXRjaCBoYXMgZGVwZW5kZW5jeSBvbiAjaW5jbHVkZQ0KPiA+IDxkdC1i
aW5kaW5ncy9jbG9jay9yOWEwN2cwNDQtY3BnLmg+IGZpbGUgd2hpY2ggd2lsbCBiZSBpbiBuZXh0
IDUuMTQtcmMxDQo+IHJlbGVhc2UuDQo+ID4NCj4gPiB2MS0+djI6DQo+ID4gICAqIE1hZGUgaW50
ZXJydXB0IG5hbWVzIGluIGRlZmluZWQgb3JkZXINCj4gPiAgICogUmVtb3ZlZCBzcmMgYWRkcmVz
cyBhbmQgY2hhbm5lbCBjb25maWd1cmF0aW9uIGZyb20gZG1hLWNlbGxzLg0KPiA+ICAgKiBDaGFu
Z2VkIHRoZSBjb21wYXRpYmVsZSBzdHJpbmcgdG8gInJlbmVzYXMscjlhMDdnMDQ0LWRtYWMiLg0K
PiANCj4gVGhhbmtzIGZvciB0aGUgdXBkYXRlIQ0KPiANCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9yZW5lc2FzLHJ6LWRt
YWMueWFtbA0KPiANCj4gPiArICBpbnRlcnJ1cHQtbmFtZXM6DQo+ID4gKyAgICBpdGVtczoNCj4g
PiArICAgICAgLSBjb25zdDogY2gwDQo+ID4gKyAgICAgIC0gY29uc3Q6IGNoMQ0KPiA+ICsgICAg
ICAtIGNvbnN0OiBjaDINCj4gPiArICAgICAgLSBjb25zdDogY2gzDQo+ID4gKyAgICAgIC0gY29u
c3Q6IGNoNA0KPiA+ICsgICAgICAtIGNvbnN0OiBjaDUNCj4gPiArICAgICAgLSBjb25zdDogY2g2
DQo+ID4gKyAgICAgIC0gY29uc3Q6IGNoNw0KPiA+ICsgICAgICAtIGNvbnN0OiBjaDgNCj4gPiAr
ICAgICAgLSBjb25zdDogY2g5DQo+ID4gKyAgICAgIC0gY29uc3Q6IGNoMTANCj4gPiArICAgICAg
LSBjb25zdDogY2gxMQ0KPiA+ICsgICAgICAtIGNvbnN0OiBjaDEyDQo+ID4gKyAgICAgIC0gY29u
c3Q6IGNoMTMNCj4gPiArICAgICAgLSBjb25zdDogY2gxNA0KPiA+ICsgICAgICAtIGNvbnN0OiBj
aDE1DQo+ID4gKyAgICAgIC0gY29uc3Q6IGVycm9yDQo+IA0KPiBZb3UgbWF5IHdhbnQgdG8gcHV0
IHRoZSAiZXJyb3IiIGludGVycnVwdCBmaXJzdCwgbGlrZSByZW5lc2FzLHJjYXItDQo+IGRtYWMu
eWFtbCBkb2VzLCB0byBtYWtlIGxpZmUgZWFzaWVyIHdoZW4gdGhlIG5leHQgU29DIHJldXNlcyB0
aGlzIGJsb2NrLA0KPiBidXQgd2l0aCBhIGRpZmZlcmVudCBudW1iZXIgb2YgY2hhbm5lbHMuDQoN
ClN1cmUuIHdpbGwgZml4IHRoaXMgaW4gVjMuDQoNCj4gDQo+IFdpdGggdGhhdCBmaXhlZDoNCj4g
UmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+
DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9m
IExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4g
cGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNl
bGYgYSBoYWNrZXIuDQo+IEJ1dCB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVz
dCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZw0KPiBsaWtlIHRoYXQuDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
