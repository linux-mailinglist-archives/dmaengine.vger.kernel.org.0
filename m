Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7620203AE6
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 17:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgFVPaA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 11:30:00 -0400
Received: from mail-eopbgr60112.outbound.protection.outlook.com ([40.107.6.112]:6050
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729247AbgFVP37 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jun 2020 11:29:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOB5kvz/B8dpkNxFLq0EKykT3pxOjZZKM2TE0HoIA5xzIB+HGw8wTb4OW9rJ0rrDQQjonKFkDyCN4LmtFpv48d2iJTN5Vc00hEcgrxU7us/yS00VJ1VJ/7OA0DZ8onHG31hlU7XpgplB6vn0gjvJitHWnFaflAKntWykypZzkVz4fyOHTG8koW74maONCZhv6B5O2nkrfbxncD0U9QqQRRvmYasq2slQXDYX85D6TZfVu6qIOYXGuUsJfYA1G4ZyZYoPkdwX7l03a1b/cncefPND3EJ035c/x/I3T1Hhvhejl+o/0OOBk/1g+lYIVgfD/VGvp7iWpnY5QSiuBSbh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=filx/VMaIl8ZwVtedCdWzAEnQqUjJsxxdN5HMk8Sel8=;
 b=eu2pAM2QKFC5j7AY9X/Oe2hpmRUtzWHRJ0VW2ug3vpbjtdWOit7n/yPZ/Oey5cH5FD3LMl5Abskd63pJ4DucVg20jlpaEt4+kAMsIrUL0oZnMe68JlgYI2xHJ12hx5QLHidB5MaXQBgLSx1kZW2w7vR/OF43mKeIog7/BnxlJayP2+3ELsqM5Eh+N8zjhrysojdbpJMFjjrSKF3m4TcioMUUH90HON27Bv4zFfKJKZRhjxYEe5vBbMheH4g1CnTJ4WBY+9s58sgnjv54LdNrWfgK7gWbgEyj7RXBVHuqc8xeuHNw/iw9drHcPuae10nEEqIKPDTS0Sjx8WonljEC+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=filx/VMaIl8ZwVtedCdWzAEnQqUjJsxxdN5HMk8Sel8=;
 b=esfwbXr26VsuH3PuuGOBVwyWKuDjtAxziVCc6Lh8BerxvACTFvBiEIyi573/3cGwZRgp4+972g2q6AruFKzx/Q0O0pSihogEUGqt5Xk+hInfyPP3GUoMlCMApMtjLyvFVhBziccX0fm/Jfv4L0uKpT3rKzbfdN9b+CmhCAdsOww=
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB7PR10MB2154.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 15:29:55 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc5:2acd:49a6:5048]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc5:2acd:49a6:5048%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 15:29:55 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Fabio Estevam <festevam@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: Fix: Remove 'always true' comparison
Thread-Topic: [PATCH] dmaengine: imx-sdma: Fix: Remove 'always true'
 comparison
Thread-Index: AQHWR+S6S5hM+0E+IkWKZf5sT0RI4ajkxCsA
Date:   Mon, 22 Jun 2020 15:29:55 +0000
Message-ID: <5f38f9c0-711f-9cbb-09a4-49f51f879fcb@kontron.de>
References: <20200621155730.28766-1-festevam@gmail.com>
In-Reply-To: <20200621155730.28766-1-festevam@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=kontron.de;
x-originating-ip: [46.142.145.88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee715d5e-0701-49ca-02ff-08d816c11da6
x-ms-traffictypediagnostic: DB7PR10MB2154:
x-microsoft-antispam-prvs: <DB7PR10MB2154556D13650A269512922BE9970@DB7PR10MB2154.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qaBhiMa2DihpJZk6VjTawNDxB4AVApqVQl+Gat6kecsyUo/0EYZbYxo5sPzhl05iEZHecOqnehdX3Y5tiFbJ7XFl4nAhwN0ptYU6pouZ103fZY3iIOGRdpkUCStxq828lRcEpUHFs8LA/lXB7QokI+S+p0RnUDYGPKoMlqZmWFk3QIUI78COlZHmCUu/iYiF8hMECpDv06wOTz+z4iTJai0Swt00ZQFlqg6wufBt8SZJYiUjtXUBo8jemRr7g62PPCYZap1wIVKkZhgiSA8tNo8LMvED3Dt1iWBw2UuVbEcF4CCVqQrcD2E3J7kWZ0UhqWZDDuWgl5jqAy9va0X4yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(86362001)(31686004)(76116006)(91956017)(478600001)(186003)(316002)(6506007)(53546011)(71200400001)(31696002)(66446008)(26005)(54906003)(2616005)(110136005)(8936002)(5660300002)(6486002)(6512007)(83380400001)(66476007)(66946007)(64756008)(66556008)(8676002)(2906002)(36756003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tQ7UAqYQGabcBTObm8YJ7rNY2QDfPC4RLul7dWwFk61Csac2h0IhQxl67hRrkK2PBVsYL9y9o3ziCQcQK22pTCGizjUaAqRJZl2X/YqZg9W7ieJSWDtqdAPGa9FMlsUNLq2fI1HVU+rgXKY7alE7aPKpXzV2OVLXVBUPODawoVSQM2utBMxXu3klrXlNJgCadrJ4JcOP/UB6KC1lrB0JrBE0iJO4ITJsSUsp9PI4YxY5W+XvbguVx6jLI32EakPeFeOKpjZaU1egUPX8a9RWUxjuySOIo5cfxzXwYNbKj0MB50V/WJI8t6uJs6P9uBD1v4hKqVHlxTTvomA2oob7t5XSPB4ELpZLy9lwpgy0bv74QBOmk0n0HQmcYoYdRN3GTGsImsthP2HVjfU0valF6XBFpdJNBCewL+X9YyBDylwCJxGsuLb3BEpLEQchtQsNfscUPYuOrdbvFZB0+/UhKz7whgC24373NGTSJoZFY3M=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <782040A222FC6648A569C39B568F9AF1@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ee715d5e-0701-49ca-02ff-08d816c11da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 15:29:55.2954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SiRitUmWDNciTR6Jwgd6EGGXfzYaVqm6AS2m6lYOosUzka3BqhZzWReIODoIxX15jkYPFNDwa3XKE9KcvKOyBK+ImVLK/nTB5568o4x0b9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2154
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjEuMDYuMjAgMTc6NTcsIEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+IGV2ZW50X2lkMCBpcyBk
ZWZpbmVkIGFzICd1bnNpZ25lZCBpbnQnLCBzbyBpdCBpcyBhbHdheXMgZ3JlYXRlciBvcg0KPiBl
cXVhbCB0byB6ZXJvLg0KPiANCj4gUmVtb3ZlIHRoZSB1bm5lZWRlZCBjb21wYXJpc29ucyB0byBm
aXggdGhlIGZvbGxvd2luZyBXPTEgYnVpbGQNCj4gd2FybmluZzoNCj4gDQo+IGRyaXZlcnMvZG1h
L2lteC1zZG1hLmM6IEluIGZ1bmN0aW9uICdzZG1hX2ZyZWVfY2hhbl9yZXNvdXJjZXMnOg0KPiBk
cml2ZXJzL2RtYS9pbXgtc2RtYS5jOjEzMzQ6MjM6IHdhcm5pbmc6IGNvbXBhcmlzb24gb2YgdW5z
aWduZWQgZXhwcmVzc2lvbiA+PSAwIGlzIGFsd2F5cyB0cnVlIFstV3R5cGUtbGltaXRzXQ0KPiAx
MzM0IHwgIGlmIChzZG1hYy0+ZXZlbnRfaWQwID49IDApDQo+IHwgICAgICAgICAgICAgICAgICAg
ICAgIF5+DQo+IGRyaXZlcnMvZG1hL2lteC1zZG1hLmM6IEluIGZ1bmN0aW9uICdzZG1hX2NvbmZp
Zyc6DQo+IGRyaXZlcnMvZG1hL2lteC1zZG1hLmM6MTYzNToyMzogd2FybmluZzogY29tcGFyaXNv
biBvZiB1bnNpZ25lZCBleHByZXNzaW9uID49IDAgaXMgYWx3YXlzIHRydWUgWy1XdHlwZS1saW1p
dHNdDQo+IDE2MzUgfCAgaWYgKHNkbWFjLT5ldmVudF9pZDAgPj0gMCkgew0KPiB8DQo+IA0KPiBG
aXhlczogMjU5NjJlMWE3ZjFkICgiZG1hZW5naW5lOiBpbXgtc2RtYTogRml4IHRoZSBldmVudCBp
ZCBjaGVjayB0byBpbmNsdWRlIFJYIGV2ZW50IGZvciBVQVJUNiIpDQo+IFJlcG9ydGVkLWJ5OiBr
ZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRmFiaW8g
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KDQpUaGFua3MhDQoNClJldmlld2VkLWJ5OiBG
cmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQoNCj4gLS0tDQo+
ICAgZHJpdmVycy9kbWEvaW14LXNkbWEuYyB8IDExICsrKystLS0tLS0tDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KPiBpbmRl
eCA5MTc3NDAzOWFlNWQuLjI3MDk5MmM0ZmU0NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9kbWEv
aW14LXNkbWEuYw0KPiArKysgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQo+IEBAIC0xMzMxLDgg
KzEzMzEsNyBAQCBzdGF0aWMgdm9pZCBzZG1hX2ZyZWVfY2hhbl9yZXNvdXJjZXMoc3RydWN0IGRt
YV9jaGFuICpjaGFuKQ0KPiAgIA0KPiAgIAlzZG1hX2NoYW5uZWxfc3luY2hyb25pemUoY2hhbik7
DQo+ICAgDQo+IC0JaWYgKHNkbWFjLT5ldmVudF9pZDAgPj0gMCkNCj4gLQkJc2RtYV9ldmVudF9k
aXNhYmxlKHNkbWFjLCBzZG1hYy0+ZXZlbnRfaWQwKTsNCj4gKwlzZG1hX2V2ZW50X2Rpc2FibGUo
c2RtYWMsIHNkbWFjLT5ldmVudF9pZDApOw0KPiAgIAlpZiAoc2RtYWMtPmV2ZW50X2lkMSkNCj4g
ICAJCXNkbWFfZXZlbnRfZGlzYWJsZShzZG1hYywgc2RtYWMtPmV2ZW50X2lkMSk7DQo+ICAgDQo+
IEBAIC0xNjMyLDExICsxNjMxLDkgQEAgc3RhdGljIGludCBzZG1hX2NvbmZpZyhzdHJ1Y3QgZG1h
X2NoYW4gKmNoYW4sDQo+ICAgCW1lbWNweSgmc2RtYWMtPnNsYXZlX2NvbmZpZywgZG1hZW5naW5l
X2NmZywgc2l6ZW9mKCpkbWFlbmdpbmVfY2ZnKSk7DQo+ICAgDQo+ICAgCS8qIFNldCBFTkJMbiBl
YXJsaWVyIHRvIG1ha2Ugc3VyZSBkbWEgcmVxdWVzdCB0cmlnZ2VyZWQgYWZ0ZXIgdGhhdCAqLw0K
PiAtCWlmIChzZG1hYy0+ZXZlbnRfaWQwID49IDApIHsNCj4gLQkJaWYgKHNkbWFjLT5ldmVudF9p
ZDAgPj0gc2RtYWMtPnNkbWEtPmRydmRhdGEtPm51bV9ldmVudHMpDQo+IC0JCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gLQkJc2RtYV9ldmVudF9lbmFibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDApOw0K
PiAtCX0NCj4gKwlpZiAoc2RtYWMtPmV2ZW50X2lkMCA+PSBzZG1hYy0+c2RtYS0+ZHJ2ZGF0YS0+
bnVtX2V2ZW50cykNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJc2RtYV9ldmVudF9lbmFibGUo
c2RtYWMsIHNkbWFjLT5ldmVudF9pZDApOw0KPiAgIA0KPiAgIAlpZiAoc2RtYWMtPmV2ZW50X2lk
MSkgew0KPiAgIAkJaWYgKHNkbWFjLT5ldmVudF9pZDEgPj0gc2RtYWMtPnNkbWEtPmRydmRhdGEt
Pm51bV9ldmVudHMpDQo+IA==
