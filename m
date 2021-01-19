Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE202FBBDA
	for <lists+dmaengine@lfdr.de>; Tue, 19 Jan 2021 17:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbhASQCC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Jan 2021 11:02:02 -0500
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:22336
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391819AbhASQBe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 19 Jan 2021 11:01:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH3gG/yku+kXgkLn3GXT7NQuwO/4kH32pbHY6wsptiHyuzf3u8SBKZGdoVuA1OlykWRsqjjIuUmkjxPvokMIGOq77+aVlfTR8FekrwhKDUolBhRwR/SWq/eHaQ6wudgEgUcF8n/BewlEazy5fWJa4yAZN3Sf/Idxq94N6MTppUYY9nvGV8XZWdxl4z8K3+ZFBSnp6DtOgvv0CfifzvpI59wq93kcQG33lkMbV+noPgE+C7s14IFbgJ5/0JsenLfLksqxJO9nEURT8dNlq1Rntw4HfYnvAYb67EelTKfeJMMZF98gY13yQJJl7PcwL66Dy3xo9ZaRUUwFG6FRqzWfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es3fK0R8pxKKxiKYz3125eVTsWj/g118QyLwt4GYVgA=;
 b=EEsB1PPJJrmvpTVZUv1QeuA6NhNW3A/yWOmNILTQVvWPMlCyDYWi49+pHEqiuusEoZC7T2mAitpNJYelJtm6k5LuEkZT8s2srDwS4nyqFDrDWMU4zG5GT9e5GkGTTHnx0UcBxjpBpT0x+ZbILV2yN6FOoyVW+Ek8yNY3NLfLe/lfBZbQXRbOwT/Gk/NJJ2Sz/CRDSTZ+iLT1ZsaywUXjkdUcbojGYgbQhsLKSrZ/ObaPxmuBbTmaFQokFwcfTdGWajUf2FFGAsADtVuvnsYRgR9V6WOCaPUpM+xp3Z6ZTjdD7MxcjSEMjFhNdkdxeG5AiaKb1ED/qX7Vc4eSXVsQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es3fK0R8pxKKxiKYz3125eVTsWj/g118QyLwt4GYVgA=;
 b=VogtlfOCqpyDDn8m+onXqe8Uawj2q/kEB4nwAHgAdQI+5PqtC6ioH+ObaJxlg+KpVyFl1ORgD9CwQsOOM4YfiWkw2ns3YWaQXL549y4TorqfpeswuM2+R/0N5GjVaL/029YZE8gBsn5uEBzdO5we4nlp3YDgFOOHrZv2lEsN+Uk=
Received: from CH2PR02MB6523.namprd02.prod.outlook.com (2603:10b6:610:34::13)
 by CH2PR02MB6216.namprd02.prod.outlook.com (2603:10b6:610:f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Tue, 19 Jan
 2021 16:00:39 +0000
Received: from CH2PR02MB6523.namprd02.prod.outlook.com
 ([fe80::d955:8acd:bbb8:4e44]) by CH2PR02MB6523.namprd02.prod.outlook.com
 ([fe80::d955:8acd:bbb8:4e44%6]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 16:00:39 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Dave Jiang <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "pthomas8589@gmail.com" <pthomas8589@gmail.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [PATCH] dmaengine: move channel device_node deletion to driver
Thread-Topic: [PATCH] dmaengine: move channel device_node deletion to driver
Thread-Index: AQHW7b9hAhTQA5mGqEe9BCo20CR3waovHE9Q
Date:   Tue, 19 Jan 2021 16:00:39 +0000
Message-ID: <CH2PR02MB6523BC739FE35038A57F0ACAC7A30@CH2PR02MB6523.namprd02.prod.outlook.com>
References: <161099092469.2495902.5064826526660062342.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161099092469.2495902.5064826526660062342.stgit@djiang5-desk3.ch.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5d11738-b430-4091-53fe-08d8bc935e05
x-ms-traffictypediagnostic: CH2PR02MB6216:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB621692F6321B9B8F87888A2AC7A30@CH2PR02MB6216.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QIBGd73LAeaDea3eTfBV4mtR3Je036uD6TMTJz9hMF7KLEBJL9yMy6E9vc0cZGofG6zIXhfo34qYSs+yPEBQYXmR0V//OKtNPKgM2WEvn7rUlVbmWpeLcRPCoVR0hD4qYHjT8hjhhbor5V7KBDjzdWq8K4MQuYLHj/nBp/0WyLdao/x1wBqC+gLqsBRsVXtsFwoCbzUp1ZhQmAUYpW7H45QjwLQAtTa7EBn40KxBsGAsj6Fw4iRLeqRUfUb7BkO7+dT78vPGQYqXDBHOKIq7epquWbJoRlW5/eL5Fh5SGz4cw1YKvBhAcvlHnwx2D6MRbG+1DvLyVO5hSoznqH2TNrboj6j/4RtqJC27SdyXg9pRq/Ql5YYtWf38StIXPDdk7Kgo4SPhGgEfufkBx/jdTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR02MB6523.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(76116006)(33656002)(186003)(66476007)(45080400002)(316002)(6506007)(478600001)(66946007)(53546011)(54906003)(7696005)(5660300002)(55016002)(86362001)(107886003)(52536014)(71200400001)(2906002)(8936002)(8676002)(66556008)(26005)(64756008)(110136005)(9686003)(83380400001)(66446008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QkFxeVhpdFVpdWwvU1JKTXpiQ25SM3BNb094cW1RY1lYbDJtbGhOTmRQWGpI?=
 =?utf-8?B?VjR4M2tma3BQRk1jSEkzVzJVOERhcjBRYXpIMS9WY0Ezb0U1eG1IZkk0NjV6?=
 =?utf-8?B?UndDbXgxd0EzVWJmQ3Z1UlRkTGFGU3JGak1QeFMyai9NaHplUHp0TkxYU0o0?=
 =?utf-8?B?Rm5oalFNUWpyc0JsNHNaRG9nK1k4dVVmamZvZkozNW9mdFBWY0RRK25reFp2?=
 =?utf-8?B?MWQxZlBMZVVvQmVlS0JsazBYbHVaUXlOb3FPT1ZTNjIvajZqclo3bjRFQ1V2?=
 =?utf-8?B?eHA1SWFmK0xqclVFRnBYc2kzZFBpS1BOOWxDWklzT2JhYVdEQ3ZiODU0dnZQ?=
 =?utf-8?B?Mk9EZ1JzU2lwbk4rdm9pODFsbzdhOEJqY3RmTSs5MFQ2UWRwS0x2dDNtaGxI?=
 =?utf-8?B?ZUc2QTBwQTljL3F3VUpwMWxmTEdLUVBnbWVFVEYzZVgwOTE2bnF4Q0FRWWpt?=
 =?utf-8?B?TzhXd29Id3dpTHZoOTRxVVp2NFRkZXZTbmlSRlBNZmhlMzhGYjdhNWpGYmVE?=
 =?utf-8?B?Yk04ME5iUVdXOSttRXBnT28zK1VDUkFWdTlMUmlYV3VXRXpKRXhmaGh6NXVo?=
 =?utf-8?B?UjVxVkpCRnBEdFZsWXJZeWVMK2VHalhmb0JjZmJMMGwzUVpnckI5THhhQXI5?=
 =?utf-8?B?Tjk3NWVTVVNtaklvMC96cG9sb3lsMkdreDliRGZOdWpwSHpubDRkTlY0b1BV?=
 =?utf-8?B?MnBxRzZFbmppdHArU1AzYmZURjlGbmZsc3ZpU24zUCs0S2xvVnFKaW1ZVStB?=
 =?utf-8?B?SmhXa2kxZUo1dTZWTDFLaGZEc2lPOXhoSEo1enBncS9aUXVXYnlMSkdrNWFh?=
 =?utf-8?B?QjFOT0tjczVleWRYWFRiMGNKWGIzQUQ4aXJvcHk2YXllSnlySWpSZFhTaEVN?=
 =?utf-8?B?UVF0YU1MWUdNVVJIOVk5cU1HaWtNS1JqRnF6eEtMdSs5WWRBRDZEQ0Q0QklV?=
 =?utf-8?B?L2REUlJuSWdrVkFQbzY0RjhRMERnZ2k3ZHI1YUlGMjRJaExXNnlEZ0tqMGhP?=
 =?utf-8?B?VEdvQ2p6ek1IZENaQ1BESUc2eUZWMFBkMGxIMWlzbmZhRVVhZmJJNVNPQjBS?=
 =?utf-8?B?dStYU2p3cFRSbUErcVpOdG8yS1JpYXcyMFNnQ0RNS3h6N2tYbnJCWERlblhP?=
 =?utf-8?B?NStWeXF3Q1pXdUJQL1VvbHlqQUs0MWUrOHZtbWt0SXZsZWZ0VVlwdkREb3pN?=
 =?utf-8?B?Yzc2Y1MzL0RXb2tuWjVrMmFkQ2xSWE52aHBkNnBSTkcwN3JlSVB3YW4zUHVQ?=
 =?utf-8?B?RzNMdEFoOEJ3Q2tZbytvZk1HSXZqZmc2UWhBQ3VWZHNiMTJsZ3VSNzRYTDRK?=
 =?utf-8?Q?o8S66shIwQ224=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6523.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d11738-b430-4091-53fe-08d8bc935e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 16:00:39.5392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyNUxVP9mXq1Uf59+91vSEiQENUxvU1Ocnhmd8UDqdZZ2i58c3GCUigy11sL72aC5UsVVIlLn9a5Fq0OgSC9dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6216
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZlIEppYW5nIDxkYXZlLmpp
YW5nQGludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDE4LCAyMDIxIDEwOjU5IFBN
DQo+IFRvOiB2a291bEBrZXJuZWwub3JnDQo+IENjOiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3Jn
OyBSYWRoZXkgU2h5YW0gUGFuZGV5DQo+IDxyYWRoZXlzQHhpbGlueC5jb20+OyBwdGhvbWFzODU4
OUBnbWFpbC5jb20NCj4gU3ViamVjdDogW1BBVENIXSBkbWFlbmdpbmU6IG1vdmUgY2hhbm5lbCBk
ZXZpY2Vfbm9kZSBkZWxldGlvbiB0byBkcml2ZXINCj4gDQo+IENoYW5uZWwgZGV2aWNlX25vZGUg
ZGVsZXRpb24gaXMgbWFuYWdlZCBieSB0aGUgZGV2aWNlIGRyaXZlciByYXRoZXIgdGhhbg0KPiB0
aGUgZG1hZW5naW5lIGNvcmUuIFRoZSBkZWxldGlvbiB3YXMgYWNjaWRlbnRhbGx5IGludHJvZHVj
ZWQgd2hlbiBtYWtpbmcNCj4gY2hhbm5lbCB1bnJlZ2lzdGVyIGR5bmFtaWMuIEl0IGNhdXNlcyB4
aWxpbnhfZG1hIG1vZHVsZSB0byBjcmFzaCBvbiB1bmxvYWQNCj4gYXMgcmVwb3J0ZWQgYnkgUmFk
aGV5LiBSZW1vdmUgY2hhbi0+ZGV2aWNlX25vZGUgZGVsZXRlIGluIGRtYWVuZ2luZQ0KPiBhbmQN
Cj4gYWxzbyBmaXggdXAgaWR4ZCBkcml2ZXIuDQo+IA0KPiBbICAgNDIuMTQyNzA1XSBJbnRlcm5h
bCBlcnJvcjogT29wczogOTYwMDAwNDQgWyMxXSBTTVANCj4gWyAgIDQyLjE0NzU2Nl0gTW9kdWxl
cyBsaW5rZWQgaW46IHhpbGlueF9kbWEoLSkgY2xrX3hsbnhfY2xvY2tfd2l6YXJkDQo+IHVpb19w
ZHJ2X2dlbmlycQ0KPiBbICAgNDIuMTU1MTM5XSBDUFU6IDEgUElEOiAyMDc1IENvbW06IHJtbW9k
IE5vdCB0YWludGVkIDUuMTAuMS0wMDAyNi0NCj4gZzNhMmU2ZGQ3YTA1LWRpcnR5ICMxOTINCj4g
WyAgIDQyLjE2MzMwMl0gSGFyZHdhcmUgbmFtZTogRW5jbHVzdHJhIFhVNSBTT00gKERUKQ0KPiBb
ICAgNDIuMTY3OTkyXSBwc3RhdGU6IDQwMDAwMDA1IChuWmN2IGRhaWYgLVBBTiAtVUFPIC1UQ08g
QlRZUEU9LS0pDQo+IFsgICA0Mi4xNzM5OTZdIHBjIDogeGlsaW54X2RtYV9jaGFuX3JlbW92ZSsw
eDc0LzB4YTAgW3hpbGlueF9kbWFdDQo+IFsgICA0Mi4xNzk4MTVdIGxyIDogeGlsaW54X2RtYV9j
aGFuX3JlbW92ZSsweDcwLzB4YTAgW3hpbGlueF9kbWFdDQo+IFsgICA0Mi4xODU2MzZdIHNwIDog
ZmZmZmZmYzAxMTEyYmNhMA0KPiBbICAgNDIuMTg4OTM1XSB4Mjk6IGZmZmZmZmMwMTExMmJjYTAg
eDI4OiBmZmZmZmY4MDQwMmVhNjQwDQo+IA0KPiB4aWxpbnhfZG1hX2NoYW5fcmVtb3ZlKzB4NzQv
MHhhMDoNCj4gX19saXN0X2RlbCBhdCAuL2luY2x1ZGUvbGludXgvbGlzdC5oOjExMiAoaW5saW5l
ZCBieSkNCj4gX19saXN0X2RlbF9lbnRyeSBhdC4vaW5jbHVkZS9saW51eC9saXN0Lmg6MTM1IChp
bmxpbmVkIGJ5KQ0KPiBsaXN0X2RlbCBhdCAuL2luY2x1ZGUvbGludXgvbGlzdC5oOjE0NiAoaW5s
aW5lZCBieSkNCj4geGlsaW54X2RtYV9jaGFuX3JlbW92ZSBhdCBkcml2ZXJzL2RtYS94aWxpbngv
eGlsaW54X2RtYS5jOjI1NDYNCj4gDQo+IFJlcG9ydGVkLWJ5OiBSYWRoZXkgU2h5YW0gUGFuZGV5
IDxyYWRoZXlzQHhpbGlueC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERhdmUgSmlhbmcgPGRhdmUu
amlhbmdAaW50ZWwuY29tPg0KPiBGaXhlczogZTgxMjc0Y2Q2YjUyICgiZG1hZW5naW5lOiBhZGQg
c3VwcG9ydCB0byBkeW5hbWljDQo+IHJlZ2lzdGVyL3VucmVnaXN0ZXIgb2YgY2hhbm5lbHMiKQ0K
DQpGb3IgeGlsaW54X2RtYSBkcml2ZXI6DQpUZXN0ZWQtYnk6IFJhZGhleSBTaHlhbSBQYW5kZXkg
PHJhZGhleS5zaHlhbS5wYW5kZXlAeGlsaW54LmNvbT4NClRoYW5rcyBmb3IgdGhlIGZpeCENCg0K
PiAtLS0NCj4gIGRyaXZlcnMvZG1hL2RtYWVuZ2luZS5jIHwgICAgMSAtDQo+ICBkcml2ZXJzL2Rt
YS9pZHhkL2RtYS5jICB8ICAgIDUgKysrKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2Rt
YWVuZ2luZS5jIGIvZHJpdmVycy9kbWEvZG1hZW5naW5lLmMNCj4gaW5kZXggOTYyY2JiNWU1Zjdm
Li5mZTZhNDYwYzQzNzMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZG1hL2RtYWVuZ2luZS5jDQo+
ICsrKyBiL2RyaXZlcnMvZG1hL2RtYWVuZ2luZS5jDQo+IEBAIC0xMTEwLDcgKzExMTAsNiBAQCBz
dGF0aWMgdm9pZA0KPiBfX2RtYV9hc3luY19kZXZpY2VfY2hhbm5lbF91bnJlZ2lzdGVyKHN0cnVj
dCBkbWFfZGV2aWNlICpkZXZpY2UsDQo+ICAJCSAgIiVzIGNhbGxlZCB3aGlsZSAlZCBjbGllbnRz
IGhvbGQgYSByZWZlcmVuY2VcbiIsDQo+ICAJCSAgX19mdW5jX18sIGNoYW4tPmNsaWVudF9jb3Vu
dCk7DQo+ICAJbXV0ZXhfbG9jaygmZG1hX2xpc3RfbXV0ZXgpOw0KPiAtCWxpc3RfZGVsKCZjaGFu
LT5kZXZpY2Vfbm9kZSk7DQo+ICAJZGV2aWNlLT5jaGFuY250LS07DQo+ICAJY2hhbi0+ZGV2LT5j
aGFuID0gTlVMTDsNCj4gIAltdXRleF91bmxvY2soJmRtYV9saXN0X211dGV4KTsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZG1hL2lkeGQvZG1hLmMgYi9kcml2ZXJzL2RtYS9pZHhkL2RtYS5jDQo+
IGluZGV4IDkwZDE5ZDA2NzgzYS4uYTE1ZTUwMTI2NDM0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2RtYS9pZHhkL2RtYS5jDQo+ICsrKyBiL2RyaXZlcnMvZG1hL2lkeGQvZG1hLmMNCj4gQEAgLTIw
Niw1ICsyMDYsOCBAQCBpbnQgaWR4ZF9yZWdpc3Rlcl9kbWFfY2hhbm5lbChzdHJ1Y3QgaWR4ZF93
cSAqd3EpDQo+IA0KPiAgdm9pZCBpZHhkX3VucmVnaXN0ZXJfZG1hX2NoYW5uZWwoc3RydWN0IGlk
eGRfd3EgKndxKQ0KPiAgew0KPiAtCWRtYV9hc3luY19kZXZpY2VfY2hhbm5lbF91bnJlZ2lzdGVy
KCZ3cS0+aWR4ZC0+ZG1hX2RldiwgJndxLQ0KPiA+ZG1hX2NoYW4pOw0KPiArCXN0cnVjdCBkbWFf
Y2hhbiAqY2hhbiA9ICZ3cS0+ZG1hX2NoYW47DQo+ICsNCj4gKwlkbWFfYXN5bmNfZGV2aWNlX2No
YW5uZWxfdW5yZWdpc3Rlcigmd3EtPmlkeGQtPmRtYV9kZXYsDQo+IGNoYW4pOw0KPiArCWxpc3Rf
ZGVsKCZjaGFuLT5kZXZpY2Vfbm9kZSk7DQo+ICB9DQo+IA0KDQo=
