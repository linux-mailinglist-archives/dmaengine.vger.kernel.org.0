Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B410C3A464D
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 18:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhFKQSy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 12:18:54 -0400
Received: from mail-dm6nam10on2062.outbound.protection.outlook.com ([40.107.93.62]:6848
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230470AbhFKQSw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Jun 2021 12:18:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxKxKsUVVfnXIy+XL3zePPbGgRURw/LJSv3BdyMEFwyGIYCnjp2/dpXqLpYRlskmizclZ5xiYmEFaGsZ/47r7hHG4MJ149iv/XoO6YW5S7Yg3CNvp1lxRN8pXqddUk24dFyDPJF8VCxhlEZRD2Q2I5zDPCLRHj/vRCEwh3oPJ0qvR1Fel+NOogX/HPdWGHc4DgxJUTh/6fd5lzaSKq9f4b38p4m3ZughLtaYJm4qgp+cpsoTZKTlu6G3dVrceyyyqBHVsO7Akz1+bF1TeCxRokLEeNRDCa/6pRcrE8A6+v4Bcp5iCpm/7j5B8Tj9LOKOEp7T6QCEgXBaT33HqpHo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xEywpTe2Algadqxh4gTsN0jkw8FF1o94yaxSP/iEJk=;
 b=NxeIaOesmpgonkN1+Ys2sK1oC2rm2ieKDosF8UNLHQKha1Vg0UZIDGoUJ+L7MlbnT2AenLZVwpSuvpzQjJP13H6s0ByVS8hQbrnPnMsGu0t9u7ZjDWYPzC0HDPO1D+GtG0WAgQhPQ41io5FxXZuj9NZ6qpfT20G+s6GKqrKni4qbzQbwqmKAKs4U7wRXkpR6TQLZXiUB9Jok6jmnekHZFD07gO7Gh6GDszmbD9B5e23Nl1E8mEUMhwUnx9KPZAwrJ5X9bCyK7PfdctR91TbS1OB8e478cgyzLxmbYBuFENjKlYUJKbeOecZTHsqQ1UThN4NrqyUC/oE6p0gmf3/kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xEywpTe2Algadqxh4gTsN0jkw8FF1o94yaxSP/iEJk=;
 b=deVKXIA6FQWawIULEuk9XdSPOYkiyKOwVgFXv9A70APII1KSNDyIrDyslrTytQ+wb0KF4FsDK04OieJvCBNE917iYGck5zm/L5uZXXzj59nnVOMdwL7mt950PlYfVtk5q5i1cRhmX74Oiqj1iuQvDRsF5cKmG7nJu88YNbT1N38=
Received: from BY5PR02MB6520.namprd02.prod.outlook.com (2603:10b6:a03:1d3::8)
 by BYAPR02MB4167.namprd02.prod.outlook.com (2603:10b6:a02:fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 16:16:51 +0000
Received: from BY5PR02MB6520.namprd02.prod.outlook.com
 ([fe80::d880:7694:92d6:7798]) by BY5PR02MB6520.namprd02.prod.outlook.com
 ([fe80::d880:7694:92d6:7798%5]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 16:16:51 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [RFC v2 PATCH 5/7] dmaengine: xilinx_dma: Freeup active list
 based on descriptor completion bit
Thread-Topic: [RFC v2 PATCH 5/7] dmaengine: xilinx_dma: Freeup active list
 based on descriptor completion bit
Thread-Index: AQHXLWnQwGXrB49GLkeWOkZPWQaKgqq1MZWAgFotG8A=
Date:   Fri, 11 Jun 2021 16:16:51 +0000
Message-ID: <BY5PR02MB6520ED330900468D691A034DC7349@BY5PR02MB6520.namprd02.prod.outlook.com>
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1617990965-35337-6-git-send-email-radhey.shyam.pandey@xilinx.com>
 <ec177886-fc14-b52e-4c98-da523fa711d9@metafoo.de>
In-Reply-To: <ec177886-fc14-b52e-4c98-da523fa711d9@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3c14e05-6525-4629-d01a-08d92cf45237
x-ms-traffictypediagnostic: BYAPR02MB4167:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB416731373BD62F5D2B91A442C7349@BYAPR02MB4167.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AJkWHicv67MfqkS6BQIneNj86CReXeNi+h6Gzkoax4SQHmlLhLt1cELSvFaq7a1jV4LrBffsNolojwBbvyNlr78dwBo8GQoMwT06zDC1kpIBBquKdJVI1dSTfzEueG5DORHxjwYOgp5VS/m6vkC7JOLU/dHhjVojzMT6bnVlTclk6kp038AVxV0p483+XWprkk99i66bLZnfQ1HugsHxpCl6QHnEBc7xiroh1QklEGJiKIRw0/3ikdYyN/BOFXvZ5CTe46SOTziEeCXBsP9USbOxOszu6NCvSxQLEeS/PnncKDSCzMuUiNl5fhqreB2dIFok3l5hYUctuCTAGugDxIMW0q62Ww4+ZPjWXdili2TpLUr429G7p0RF4g3tzVnMzmwUbnK8UrZEGUnHt7gSEp1mWSZphTBVxUQv9AVsIiQxMxJq1BFOfCUaDU4LaGYXih5z2PUJ7jrOEVwoonX33GhE4mY0PGfS5LBlIw3R1+ELLq16/hMYa1ltfVAF4YsK5Ez8LbSCBDPzZ8Zj429+q9X27xvNTsMRVRpGHPxoRYN0m9t0k8lSdx1t8ELq6siBQF5kVO0Z/oQNzLd54qamy2DGLKSXn+0Qal8zrhgh5XQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6520.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(38100700002)(55016002)(83380400001)(33656002)(52536014)(26005)(71200400001)(122000001)(2906002)(107886003)(110136005)(4326008)(8936002)(86362001)(54906003)(478600001)(8676002)(53546011)(6636002)(66446008)(316002)(66946007)(76116006)(66556008)(186003)(64756008)(66476007)(6506007)(5660300002)(7696005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm84bVBnTWtWcVliNjRQSmF4TGd0YzliNjR6eng2MG5oR2MwNlU0QkJjdjEv?=
 =?utf-8?B?MC9OYVorWVBZK3JKZ3lqOC9OWGJ3MkY5OFpGTkoyeWtiaFpVaEdDajRYR25C?=
 =?utf-8?B?dURUNE1UcjJiVi9sOHU3aEVtSGxHVmR4TGhJWm9qeVBPRm9PL1lIUDNnL3M5?=
 =?utf-8?B?dEZDd2dvZTNTN29QUlk4d1JEZ21DaC9LbHA0NXBOY1BtQWFqWmt4WEpJSGwx?=
 =?utf-8?B?ZnhjVDNOd0tJM0hvOUh5bjdMeU9XZDZLR043UWU4R3dHSWdTTmNkM0M0Vnov?=
 =?utf-8?B?V3Vudm5DcndnOXkvZ0RnK3FwMHpoK1pRQVAzZitBNHRVR3BONzkwNmJobmp0?=
 =?utf-8?B?WmZDNHBsMkVra21sdms0Q2tMd0dmdXFNd2V5YmFOUmlSTWNCRGE1Mk85Yzd5?=
 =?utf-8?B?cEZteXcwM093a3FnK0JhclpGRW9zV0RIR0t5dzdXOVcyWnFmbjBRTWJNNHlU?=
 =?utf-8?B?U0JtQXVvd2V6NDF1V3RQUGtOTWJXMU16dGIxbWFjck80RkJGanFndjlFTUxQ?=
 =?utf-8?B?VXNXMER5ckEwRDFmVE1YOC94SWc4U3k0ZG8zWmF5S3RVK0YzK0VlRmx6ZFdx?=
 =?utf-8?B?Qm1ZaWtWRmljUjJTaWdEdDlHVHFPalRydjltNC9NYnRINVZFZFNjc2RpWEh4?=
 =?utf-8?B?Y3Mrb2xWajRNMTJOSVlGNWdqd29vbWlTOHZtL1k2Sk9xUEtDdnBTc2JoLzFU?=
 =?utf-8?B?YzNkSmIybUU5cGxnQ3dEVXVYUWx0OHZTaXplMHJCMm5HNU5mZGI0c1NJZEtC?=
 =?utf-8?B?V2cvamo1d3EyR3R6MkZEQmZMeXpSTXFWSHpLY2RHejBjZ1RBZkZEbFVsdzhm?=
 =?utf-8?B?U1JXQXRsVEdMMU1ISXFaaFhSVUl2NmxQanZMRHpCUU9ORVNMTmlKdGt1UFlF?=
 =?utf-8?B?TVNCQXdLbWN0SXl0UmkrY0lFbXVNQmVjRFd1STBFZ2F2QlpYU202UlQzR1px?=
 =?utf-8?B?QXhsTHNzaE9uUUdRa2YyNTFUV0dYOXlocHE4QlpnQ0NKWEVQVFFaeTNiZ3d4?=
 =?utf-8?B?TFlCRHpIU29ZdFRodjJCdzY3Y0ErN1dlM3V5d3hGRzlLUWFVSnI1dE9veG5Q?=
 =?utf-8?B?OTF6NkorWlpkbVcvOEhBUDBuZndVTjZxZ0prTW1RNU9PYUtIVHg4YWRyUGJO?=
 =?utf-8?B?UVF3dnJ1L2U4WVZPU2VDWjFPL0ltTjJrbUFKRGowRlR4eFdHeG9JYU1CSGMy?=
 =?utf-8?B?MjE2aGV6UHh0WHl1OWNWb3RKQlk0dk8xREMvajZnMUVwd2hKLytYeDFjdmdR?=
 =?utf-8?B?ZCt3ekVpNC9yUFRqZTFSQXh3Mm5Sak1tTTM4R3U4S1NmVmY2NzNuSUY5WHF3?=
 =?utf-8?B?TXpoY3dsU3VYdEdid0c2ZlJvV1lNdE52Nyt0eit4RzFTUTV3M1owQUt5cFY4?=
 =?utf-8?B?c2RUaFE1QkZaMjlkby9GaGhva0RubkF2VlM3WVpEK3g3TEkxS3VzUGRibTVZ?=
 =?utf-8?B?d2UzVGs4bkdxTTc5Ylo3NEt3U3dqMHVqc2EyQk5SL1gxazRMaHgyaUozZFp4?=
 =?utf-8?B?R2dKTHd6b2FTSWpzK1Q4VUFSc0xlN2V6NUZoYWF1OUhuRUVuSUk3RG54WXRi?=
 =?utf-8?B?bk53ckd4NEJrNy9tR1dzSVN0VlVkTExvWjB2dGdtT21yNnl4TGl0eFkzWFNy?=
 =?utf-8?B?dlVFSlBvVXdqQ2FjdDBDc2RjbzlaT1pOb2srVW4yRDVhaE5OWG5pRmlUSUlh?=
 =?utf-8?B?UGJpQU5uUFh2V0lMeXFlZnhLQ0xkQVRYZkc1TmRsU09ra090M1J0S0V6KzRM?=
 =?utf-8?Q?m5faOG0t4ZidAovjigs/SCctbTNmloAVEhD2JHm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6520.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c14e05-6525-4629-d01a-08d92cf45237
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 16:16:51.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4lefJfLCIaKOQbpxlJT65wLazWDNhEwmsojhJDJ9naEL4GDZUhh8Q5M5Tvwkrflz8t/w57ztQmHZqUwS2grNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4167
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXJzLVBldGVyIENsYXVzZW4g
PGxhcnNAbWV0YWZvby5kZT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDE1LCAyMDIxIDEyOjM5
IFBNDQo+IFRvOiBSYWRoZXkgU2h5YW0gUGFuZGV5IDxyYWRoZXlzQHhpbGlueC5jb20+OyB2a291
bEBrZXJuZWwub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IE1pY2hhbCBTaW1layA8bWljaGFs
c0B4aWxpbnguY29tPg0KPiBDYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGdpdA0KPiA8Z2l0QHhpbGlueC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUkZDIHYyIFBBVENIIDUvN10gZG1hZW5naW5lOiB4aWxpbnhfZG1h
OiBGcmVldXAgYWN0aXZlIGxpc3QNCj4gYmFzZWQgb24gZGVzY3JpcHRvciBjb21wbGV0aW9uIGJp
dA0KPiANCj4gT24gNC85LzIxIDc6NTYgUE0sIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+
ID4gQVhJRE1BIElQIGluIFNHIG1vZGUgc2V0cyBjb21wbGV0aW9uIGJpdCB0byAxIHdoZW4gdGhl
IHRyYW5zZmVyIGlzDQo+ID4gY29tcGxldGVkLiBSZWFkIHRoaXMgYml0IHRvIG1vdmUgZGVzY3Jp
cHRvciBmcm9tIGFjdGl2ZSBsaXN0IHRvIHRoZQ0KPiA+IGRvbmUgbGlzdC4gVGhpcyBmZWF0dXJl
IGlzIG5lZWRlZCB3aGVuIGludGVycnVwdCBkZWxheSB0aW1lb3V0IGFuZA0KPiA+IElSUVRocmVz
aG9sZCBpcyBlbmFibGVkIGkuZSBEbHlfSXJxRW4gaXMgdHJpZ2dlcmVkIHcvbyBjb21wbGV0aW5n
DQo+ID4gaW50ZXJydXB0IHRocmVzaG9sZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJhZGhl
eSBTaHlhbSBQYW5kZXkgPHJhZGhleS5zaHlhbS5wYW5kZXlAeGlsaW54LmNvbT4NCj4gPiAtLS0N
Cj4gPiAtIENoZWNrIEJEIGNvbXBsZXRpb24gYml0IG9ubHkgZm9yIFNHIG1vZGUuDQo+ID4gLSBN
b2RpZnkgdGhlIGxvZ2ljIHRvIGhhdmUgZWFybHkgcmV0dXJuIHBhdGguDQo+ID4gLS0tDQo+ID4g
ICBkcml2ZXJzL2RtYS94aWxpbngveGlsaW54X2RtYS5jIHwgNyArKysrKysrDQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9kbWEveGlsaW54L3hpbGlueF9kbWEuYw0KPiA+IGIvZHJpdmVycy9kbWEveGlsaW54L3hpbGlu
eF9kbWEuYyBpbmRleCA4OTBiZjQ2YjM2ZTUuLmYyMzA1YTczY2I5MQ0KPiA+IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvZG1hL3hpbGlueC94aWxpbnhfZG1hLmMNCj4gPiArKysgYi9kcml2ZXJz
L2RtYS94aWxpbngveGlsaW54X2RtYS5jDQo+ID4gQEAgLTE3Nyw2ICsxNzcsNyBAQA0KPiA+ICAg
I2RlZmluZSBYSUxJTlhfRE1BX0NSX0NPQUxFU0NFX1NISUZUCTE2DQo+ID4gICAjZGVmaW5lIFhJ
TElOWF9ETUFfQkRfU09QCQlCSVQoMjcpDQo+ID4gICAjZGVmaW5lIFhJTElOWF9ETUFfQkRfRU9Q
CQlCSVQoMjYpDQo+ID4gKyNkZWZpbmUgWElMSU5YX0RNQV9CRF9DT01QX01BU0sJCUJJVCgzMSkN
Cj4gPiAgICNkZWZpbmUgWElMSU5YX0RNQV9DT0FMRVNDRV9NQVgJCTI1NQ0KPiA+ICAgI2RlZmlu
ZSBYSUxJTlhfRE1BX05VTV9ERVNDUwkJNTEyDQo+ID4gICAjZGVmaW5lIFhJTElOWF9ETUFfTlVN
X0FQUF9XT1JEUwk1DQo+ID4gQEAgLTE2ODMsMTIgKzE2ODQsMTggQEAgc3RhdGljIHZvaWQgeGls
aW54X2RtYV9pc3N1ZV9wZW5kaW5nKHN0cnVjdA0KPiBkbWFfY2hhbiAqZGNoYW4pDQo+ID4gICBz
dGF0aWMgdm9pZCB4aWxpbnhfZG1hX2NvbXBsZXRlX2Rlc2NyaXB0b3Ioc3RydWN0IHhpbGlueF9k
bWFfY2hhbg0KPiAqY2hhbikNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgeGlsaW54X2RtYV90eF9k
ZXNjcmlwdG9yICpkZXNjLCAqbmV4dDsNCj4gPiArCXN0cnVjdCB4aWxpbnhfYXhpZG1hX3R4X3Nl
Z21lbnQgKnNlZzsNCj4gPg0KPiA+ICAgCS8qIFRoaXMgZnVuY3Rpb24gd2FzIGludm9rZWQgd2l0
aCBsb2NrIGhlbGQgKi8NCj4gPiAgIAlpZiAobGlzdF9lbXB0eSgmY2hhbi0+YWN0aXZlX2xpc3Qp
KQ0KPiA+ICAgCQlyZXR1cm47DQo+ID4NCj4gPiAgIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUo
ZGVzYywgbmV4dCwgJmNoYW4tPmFjdGl2ZV9saXN0LCBub2RlKSB7DQo+ID4gKwkJLyogVE9ETzog
cmVtb3ZlIGhhcmRjb2RpbmcgZm9yIGF4aWRtYV90eF9zZWdtZW50ICovDQo+ID4gKwkJc2VnID0g
bGlzdF9sYXN0X2VudHJ5KCZkZXNjLT5zZWdtZW50cywNCj4gPiArCQkJCSAgICAgIHN0cnVjdCB4
aWxpbnhfYXhpZG1hX3R4X3NlZ21lbnQsIG5vZGUpOw0KPiBUaGlzIG5lZWRzIHRvIGJlIGZpeGVk
IGJlZm9yZSB0aGlzIGNhbiBiZSBtZXJnZWQgYXMgaXQgcmlnaHQgbm93IHdpbGwgYnJlYWsNCj4g
dGhlIG5vbiBBWElETUEgdmFyaWFudHMuDQoNCkkgYWdyZWUsIG1lbnRpb25lZCBpdCBpbiBUT0RP
IHRvIHJlbW92ZSBheGlkbWEgc3BlY2lmaWMgaGFyZGNvZGluZy4NCldpbGwgZml4IGl0IG5leHQg
dmVyc2lvbi4NCg0KVGhhbmtzLA0KUmFkaGV5DQo+ID4gKwkJaWYgKCEoc2VnLT5ody5zdGF0dXMg
JiBYSUxJTlhfRE1BX0JEX0NPTVBfTUFTSykgJiYNCj4gY2hhbi0+aGFzX3NnKQ0KPiA+ICsJCQli
cmVhazsNCj4gPiAgIAkJaWYgKGNoYW4tPmhhc19zZyAmJiBjaGFuLT54ZGV2LT5kbWFfY29uZmln
LT5kbWF0eXBlICE9DQo+ID4gICAJCSAgICBYRE1BX1RZUEVfVkRNQSkNCj4gPiAgIAkJCWRlc2Mt
PnJlc2lkdWUgPSB4aWxpbnhfZG1hX2dldF9yZXNpZHVlKGNoYW4sIGRlc2MpOw0KPiANCg0K
