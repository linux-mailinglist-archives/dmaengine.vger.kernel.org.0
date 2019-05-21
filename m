Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD48B251C6
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 16:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfEUOUO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 10:20:14 -0400
Received: from mail-eopbgr750087.outbound.protection.outlook.com ([40.107.75.87]:10627
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727534AbfEUOUN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 10:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQIaHZ+4eRtsBb7BPeSPxg8x+3jJS21jaZjIdpM10V0=;
 b=FMmBfmURMS07NiM8yy2SXzTxduU167gJl/ead+D2kjHAtvOUF93bg5KCzPEHtCD5Ko+8p3OY1TDFHaWPZ/n6RPnjD1qfhFtVaQJH4v3rE6W/pSkQLEG67gAFwFPbb4RcZiWuS+7aZEKDWRp7C+jn4uS7ryiVRjYyzQ6d7WJYQs8=
Received: from CH2PR02MB6198.namprd02.prod.outlook.com (52.132.229.224) by
 CH2PR02MB6262.namprd02.prod.outlook.com (52.132.230.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Tue, 21 May 2019 14:20:10 +0000
Received: from CH2PR02MB6198.namprd02.prod.outlook.com
 ([fe80::d44f:dac7:4445:4d0]) by CH2PR02MB6198.namprd02.prod.outlook.com
 ([fe80::d44f:dac7:4445:4d0%2]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 14:20:10 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Vinod Koul <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     Michal Simek <michals@xilinx.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>
Subject: =?utf-8?B?UkU6IFtQQVRDSF0gZG1hZW5naW5lOiB4aWxpbnhfZG1hOiBSZW1vdmUgc2V0?=
 =?utf-8?B?IGJ1dCB1bnVzZWQg4oCYdGFpbF9kZXNj4oCZ?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBkbWFlbmdpbmU6IHhpbGlueF9kbWE6IFJlbW92ZSBzZXQgYnV0?=
 =?utf-8?B?IHVudXNlZCDigJh0YWlsX2Rlc2PigJk=?=
Thread-Index: AQHVD979BpRAKLlLP0ON9uK+f+sESqZ1oD3Q
Date:   Tue, 21 May 2019 14:20:10 +0000
Message-ID: <CH2PR02MB61980091BB537AC704B1F333C7070@CH2PR02MB6198.namprd02.prod.outlook.com>
References: <20190521141034.8808-1-vkoul@kernel.org>
In-Reply-To: <20190521141034.8808-1-vkoul@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2071d3ff-0d64-439e-a953-08d6ddf76eae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:CH2PR02MB6262;
x-ms-traffictypediagnostic: CH2PR02MB6262:
x-microsoft-antispam-prvs: <CH2PR02MB62629A32195B8E16BE60F06FC7070@CH2PR02MB6262.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(376002)(136003)(189003)(199004)(13464003)(33656002)(71200400001)(229853002)(81166006)(26005)(2501003)(68736007)(14454004)(186003)(256004)(14444005)(7696005)(8936002)(4326008)(305945005)(71190400001)(86362001)(53936002)(81156014)(7736002)(52536014)(25786009)(316002)(74316002)(5660300002)(446003)(66066001)(486006)(478600001)(9686003)(6436002)(6116002)(73956011)(66476007)(66556008)(64756008)(3846002)(66446008)(66946007)(76116006)(53546011)(110136005)(107886003)(99286004)(55016002)(102836004)(54906003)(76176011)(11346002)(6246003)(6506007)(2906002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6262;H:CH2PR02MB6198.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2YXedhWpfkvB1e679MaM+1KaoiqrkO/LXVaRpC2/QgtwyBNnIZ6mTr/vFYGWvjRzXzD8HNk3hmXAOY6w0+hACkar/b6qybsSYpoBk+317gec3WDF9zZEXgzUPhbO4th6aHes5RGctzD3XAnUU/hHWzulRRVbcexKkuU/2uN3JFhGjAKYChP3UFVVaYqwj6onNnuy5ej3QSqi9edtupskV5YR4Bt5aK0AFRr505WF3mp8p7bTILnq+1OnX2Pw8gb4zghgwEbtQdKSmyewfRJeFwPdzr4HTcxwvEBRRht4d0amo1SU8H2tsRxuQFcSirhA/r1qDZURPVKyEBT9bE11n3JtqmbhBZuVObDtII9KyWwgbq6I0mG7j7UNIAYdelWqNqwO1fERX3dh12B+HCtUputH6gi4vOjxtIxobdBOrPo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2071d3ff-0d64-439e-a953-08d6ddf76eae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 14:20:10.2104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6262
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5vZCBLb3VsIDx2a291bEBr
ZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMjEsIDIwMTkgNzo0MSBQTQ0KPiBUbzog
ZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZw0KPiBDYzogVmlub2QgS291bCA8dmtvdWxAa2VybmVs
Lm9yZz47IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsNCj4gUmFkaGV5IFNoeWFt
IFBhbmRleSA8cmFkaGV5c0B4aWxpbnguY29tPjsgQW5kcmVhIE1lcmVsbG8NCj4gPGFuZHJlYS5t
ZXJlbGxvQGdtYWlsLmNvbT47IEFwcGFuYSBEdXJnYSBLZWRhcmVzd2FyYSBSYW8NCj4gPGFwcGFu
YWRAeGlsaW54LmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkbWFlbmdpbmU6IHhpbGlueF9kbWE6
IFJlbW92ZSBzZXQgYnV0IHVudXNlZCDigJh0YWlsX2Rlc2PigJkNCj4gDQo+IFdlIGdldCBhIGNv
bXBpbGVyIHdhcm4gYWJvdXQgdmFyaWFibGUg4oCYdGFpbF9kZXNj4oCZIHNldCBidXQgbm90IHVz
ZWQNCj4gDQo+IGRyaXZlcnMvZG1hL3hpbGlueC94aWxpbnhfZG1hLmM6MTEwMjo0Mjogd2Fybmlu
ZzoNCj4gCXZhcmlhYmxlIOKAmHRhaWxfZGVzY+KAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNl
ZC1idXQtc2V0LXZhcmlhYmxlXQ0KPiAgIHN0cnVjdCB4aWxpbnhfZG1hX3R4X2Rlc2NyaXB0b3Ig
KmRlc2MsICp0YWlsX2Rlc2M7DQo+IA0KPiBTbyByZW1vdmUgaXQuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPg0KDQpSZXZpZXdlZC1ieTogUmFkaGV5
IFNoeWFtIFBhbmRleSA8cmFkaGV5LnNoeWFtLnBhbmRleUB4aWxpbnguY29tPg0KVGhhbmtzIQ0K
DQo+IC0tLQ0KPiAgZHJpdmVycy9kbWEveGlsaW54L3hpbGlueF9kbWEuYyB8IDQgKy0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZG1hL3hpbGlueC94aWxpbnhfZG1hLmMgYi9kcml2ZXJzL2RtYS94
aWxpbngveGlsaW54X2RtYS5jDQo+IGluZGV4IGM0M2MxYTE1NDYwNC4uMzQ1NjQyMjRlNjc1IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2RtYS94aWxpbngveGlsaW54X2RtYS5jDQo+ICsrKyBiL2Ry
aXZlcnMvZG1hL3hpbGlueC94aWxpbnhfZG1hLmMNCj4gQEAgLTEwOTksNyArMTA5OSw3IEBAIHN0
YXRpYyB2b2lkIHhpbGlueF9kbWFfc3RhcnQoc3RydWN0IHhpbGlueF9kbWFfY2hhbg0KPiAqY2hh
bikNCj4gIHN0YXRpYyB2b2lkIHhpbGlueF92ZG1hX3N0YXJ0X3RyYW5zZmVyKHN0cnVjdCB4aWxp
bnhfZG1hX2NoYW4gKmNoYW4pDQo+ICB7DQo+ICAJc3RydWN0IHhpbGlueF92ZG1hX2NvbmZpZyAq
Y29uZmlnID0gJmNoYW4tPmNvbmZpZzsNCj4gLQlzdHJ1Y3QgeGlsaW54X2RtYV90eF9kZXNjcmlw
dG9yICpkZXNjLCAqdGFpbF9kZXNjOw0KPiArCXN0cnVjdCB4aWxpbnhfZG1hX3R4X2Rlc2NyaXB0
b3IgKmRlc2M7DQo+ICAJdTMyIHJlZywgajsNCj4gIAlzdHJ1Y3QgeGlsaW54X3ZkbWFfdHhfc2Vn
bWVudCAqc2VnbWVudCwgKmxhc3QgPSBOVUxMOw0KPiAgCWludCBpID0gMDsNCj4gQEAgLTExMTYs
OCArMTExNiw2IEBAIHN0YXRpYyB2b2lkIHhpbGlueF92ZG1hX3N0YXJ0X3RyYW5zZmVyKHN0cnVj
dA0KPiB4aWxpbnhfZG1hX2NoYW4gKmNoYW4pDQo+IA0KPiAgCWRlc2MgPSBsaXN0X2ZpcnN0X2Vu
dHJ5KCZjaGFuLT5wZW5kaW5nX2xpc3QsDQo+ICAJCQkJc3RydWN0IHhpbGlueF9kbWFfdHhfZGVz
Y3JpcHRvciwgbm9kZSk7DQo+IC0JdGFpbF9kZXNjID0gbGlzdF9sYXN0X2VudHJ5KCZjaGFuLT5w
ZW5kaW5nX2xpc3QsDQo+IC0JCQkJICAgIHN0cnVjdCB4aWxpbnhfZG1hX3R4X2Rlc2NyaXB0b3Is
IG5vZGUpOw0KPiANCj4gIAkvKiBDb25maWd1cmUgdGhlIGhhcmR3YXJlIHVzaW5nIGluZm8gaW4g
dGhlIGNvbmZpZyBzdHJ1Y3R1cmUgKi8NCj4gIAlpZiAoY2hhbi0+aGFzX3ZmbGlwKSB7DQo+IC0t
DQo+IDIuMjAuMQ0KDQo=
