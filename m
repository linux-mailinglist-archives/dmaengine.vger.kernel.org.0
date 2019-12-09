Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A9C11694C
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2019 10:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfLIJ2z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Dec 2019 04:28:55 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:53910 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727044AbfLIJ2z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Dec 2019 04:28:55 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB99QZJ2016727;
        Mon, 9 Dec 2019 04:28:40 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2053.outbound.protection.outlook.com [104.47.46.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wraq3dq7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Dec 2019 04:28:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aK0PQSRfwc1+gBjhpVn5lxzIwz1ELTaWRv+InqNheEUesiEcNTP0+8C5Y8s3J7sxiBjkUVL2QLhJBdT3ZnblvUlKKWR580PxMclSnrHCC/0r0IoWJ7YtjBeQKGVy8NgCdznMb+xNvYMhnK8ZS2zkFakePyitBjjluph6SZcWujmrl+CXCkykvIHxZlQzUP5n/J8cjQ+b+DSE2cp5XmdU++spoaW24Us8oZZls5VuN6P+V8k1ePJEVfHR5UAaEOSEdFNTajTbKoA5qnRi4mdGQI9RDLSosb+Li2QguqZVS/APwfZtsymRnjuqeu0p3ZPz8DoeFtQ3lAFAd9szFV+TKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPfe8uiSJkHB0cz3cnWoauntF7PbirniIBxeuaxGMtc=;
 b=iYm3moC+KhNgx6naVYQyj4urrqKlV2UwJF0A2+/uuEV2Cn6pcUeBIPGeB/l0ovy6u0wXE6hpX6L1KZkeyqcFoFywblMRmoJ0kYDBSKHX4GeFU+dVNjNyrr2Gy3h3V3qQWwYoorghuXUTHw0yyC/8iP7y05GkZ11cNEbQjRgvkec3vL+eEWeCrYuC6K4Fckoqpnd8UXzu2IpQnwppRepAjNE7BQ1sBY0Zeelwl2weAfH2WNmBuuB+hUsChu2ivHyVp0QCFIIrKeaxgN6DJYep8Zx9LMNfNZr8IpXwQtZ0Ef9ByGerdLLBPHAYVJ2iv/lj7nGqyidB4uX9Sz6T1jA3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPfe8uiSJkHB0cz3cnWoauntF7PbirniIBxeuaxGMtc=;
 b=9GZZrx/v9XzJeMnaK+EBu6CcuYIH5pH0+Ttw+JKQa+MzqgsgMWhVYgYoCcGkqhuCYRFQlDOgqusL+p1jhGD/q+2/cBgnWz4qUPedUrRIsowPNpxVa2v2y5TsEb6icLP5BL3FEbzfWnHQd7nil3Sta3pj5Lyi+z0P8cPtkJYtpdQ=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5174.namprd03.prod.outlook.com (20.180.4.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Mon, 9 Dec 2019 09:28:37 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 09:28:37 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "hslester96@gmail.com" <hslester96@gmail.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: axi-dmac: add a check for
 devm_regmap_init_mmio
Thread-Topic: [PATCH] dmaengine: axi-dmac: add a check for
 devm_regmap_init_mmio
Thread-Index: AQHVrm6zhfB4YXZwDU+2mjrHrKjDGKexiZaA
Date:   Mon, 9 Dec 2019 09:28:37 +0000
Message-ID: <232e1bafc05611355fdd26e2ffa16d0050ad37fc.camel@analog.com>
References: <20191209085711.16001-1-hslester96@gmail.com>
In-Reply-To: <20191209085711.16001-1-hslester96@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0ae8cc0-01c2-4f7b-f76e-08d77c8a2b75
x-ms-traffictypediagnostic: CH2PR03MB5174:
x-microsoft-antispam-prvs: <CH2PR03MB5174AEA2D43BF58B8EBD00FAF9580@CH2PR03MB5174.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(136003)(376002)(199004)(189003)(478600001)(186003)(2906002)(4326008)(86362001)(66946007)(316002)(76176011)(99286004)(2616005)(229853002)(26005)(54906003)(8936002)(305945005)(6916009)(6512007)(102836004)(6486002)(5660300002)(118296001)(81156014)(71200400001)(71190400001)(5640700003)(6506007)(81166006)(8676002)(66446008)(66476007)(66556008)(64756008)(76116006)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5174;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 79jiqzfQxxLhN8KVQzuQcWUsBsWo/O60NN7BWf7hCiJTAeILIW9FrMBm7zj86nwH8nUD3rqiyIRgcA0DYreDVFbR1P9v71lDpseE5OIBD+rjhntsJq8PwkU+7YIp3mwgWPsiwUv0b60xRKjlYfTyIitzMpXE5bAvGW4OdbjdbewIVa8FaYOOTssvzROYEj4G7BT6Ibxg6DVT3rqNzVhlxJKIHU0S/cm4KS2XOVAOBD+bwlySjjUrXUOYdd2rBMT06ImKQjhA1sjx6/8RM3gjWzvVGgkfISFFDmP2PNBKAdhF7DD04ChWNhWKTue43xcPEfs1nDfUhHoN8isdBNG0wQQycGqOWl/x/s5RwWVK5uESHtfmITjrMlOefXiQfUY6PDj+2VYaigxvaPyOU9GESrxOjToQJKLoloDVFalsEx3NbL3L1AukaOOfa8bcN/ks
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8155289B51E944EAC1D2C16AE73ED20@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ae8cc0-01c2-4f7b-f76e-08d77c8a2b75
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 09:28:37.1432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmDRS4l6O/MzOzwAHdE3xLS7yumb1VC/Y3STBn7oCCw9GKRjPsTnNBwWNj+IjLbtNd5++hnDhtzOlqoH8iJ/qctFVfcuJrE9jz3yWHGigEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5174
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_01:2019-12-09,2019-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912090081
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gTW9uLCAyMDE5LTEyLTA5IGF0IDE2OjU3ICswODAwLCBDaHVob25nIFl1YW4gd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IFRoZSBkcml2ZXIgbWlzc2VzIGNoZWNraW5nIHRoZSByZXN1bHQg
b2YgZGV2bV9yZWdtYXBfaW5pdF9tbWlvKCkuDQo+IEFkZCBhIGNoZWNrIHRvIGZpeCBpdC4NCg0K
VGhhbmtzIDopDQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5h
cmRlbGVhbkBhbmFsb2cuY29tPg0KDQo+IA0KPiBGaXhlczogZmMxNWJlMzlhODI3ICgiZG1hZW5n
aW5lOiBheGktZG1hYzogYWRkIHJlZ21hcCBzdXBwb3J0IikNCj4gU2lnbmVkLW9mZi1ieTogQ2h1
aG9uZyBZdWFuIDxoc2xlc3Rlcjk2QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2RtYS9k
bWEtYXhpLWRtYWMuYyB8IDEwICsrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9k
bWEtYXhpLWRtYWMuYyBiL2RyaXZlcnMvZG1hL2RtYS1heGktZG1hYy5jDQo+IGluZGV4IGEwZWU0
MDRiNzM2ZS4uY2Y0Zjg5MjU2MmNjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2RtYS9kbWEtYXhp
LWRtYWMuYw0KPiArKysgYi9kcml2ZXJzL2RtYS9kbWEtYXhpLWRtYWMuYw0KPiBAQCAtODMwLDYg
KzgzMCw3IEBAIHN0YXRpYyBpbnQgYXhpX2RtYWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZQ0KPiAqcGRldikNCj4gIAlzdHJ1Y3QgZG1hX2RldmljZSAqZG1hX2RldjsNCj4gIAlzdHJ1Y3Qg
YXhpX2RtYWMgKmRtYWM7DQo+ICAJc3RydWN0IHJlc291cmNlICpyZXM7DQo+ICsJc3RydWN0IHJl
Z21hcCAqcmVnbWFwOw0KPiAgCWludCByZXQ7DQo+ICANCj4gIAlkbWFjID0gZGV2bV9remFsbG9j
KCZwZGV2LT5kZXYsIHNpemVvZigqZG1hYyksIEdGUF9LRVJORUwpOw0KPiBAQCAtOTIxLDEwICs5
MjIsMTcgQEAgc3RhdGljIGludCBheGlfZG1hY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
DQo+ICpwZGV2KQ0KPiAgDQo+ICAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZG1hYyk7DQo+
ICANCj4gLQlkZXZtX3JlZ21hcF9pbml0X21taW8oJnBkZXYtPmRldiwgZG1hYy0+YmFzZSwNCj4g
JmF4aV9kbWFjX3JlZ21hcF9jb25maWcpOw0KPiArCXJlZ21hcCA9IGRldm1fcmVnbWFwX2luaXRf
bW1pbygmcGRldi0+ZGV2LCBkbWFjLT5iYXNlLA0KPiArCQkgJmF4aV9kbWFjX3JlZ21hcF9jb25m
aWcpOw0KPiArCWlmIChJU19FUlIocmVnbWFwKSkgew0KPiArCQlyZXQgPSBQVFJfRVJSKHJlZ21h
cCk7DQo+ICsJCWdvdG8gZXJyX2ZyZWVfaXJxOw0KPiArCX0NCj4gIA0KPiAgCXJldHVybiAwOw0K
PiAgDQo+ICtlcnJfZnJlZV9pcnE6DQo+ICsJZnJlZV9pcnEoZG1hYy0+aXJxLCBkbWFjKTsNCj4g
IGVycl91bnJlZ2lzdGVyX29mOg0KPiAgCW9mX2RtYV9jb250cm9sbGVyX2ZyZWUocGRldi0+ZGV2
Lm9mX25vZGUpOw0KPiAgZXJyX3VucmVnaXN0ZXJfZGV2aWNlOg0K
