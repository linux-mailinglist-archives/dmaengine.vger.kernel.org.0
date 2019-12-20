Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B55127C26
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 15:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLTOBt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 09:01:49 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:33252 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727347AbfLTOBt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Dec 2019 09:01:49 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBKE0crc023653;
        Fri, 20 Dec 2019 09:01:40 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wvtfdr4mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Dec 2019 09:01:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dcl5VKUxpegYbs7/Dv2u0XLzYgoxRSa+j9c3N9kk5KJHxvnfalp+oxV4xP42KP/nkAJ2yemfwlE6cQ51ePbmD2l8UioZlf/zER3pXwXydTZSCkEO3KuXyVFelFZXWjnld9g+qUS/JC26gbOKw1yustv8iJt2VpeBsUdmqOSvtSQGnFyrYm5aZkACNNeHkRogPkeDJ8CueTZs2FEkfnOjbIO7fbgsVKpgmfpi3QIYnRxzyfha9OdK+eqAzz5bgiCASdCjVRiW9vD2eoebZG5UqLfDesD0tN67yHvsfHNrji1gvk0gAkNyEVIbUwCxpaBQ1bVI5/o7Fu2FXM2wKBqg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtoIAVSgI0rE+59jgasrl9wNjCCG6t1IPAehQKR19js=;
 b=i9TYtND4BkqgRgz0peIiGAVSXvNRWmoJZ5DeHFjfG0SD8BtHffRJ+KLWdkUtxSh/QBLS8sAohWAAjHi3wGsanGvZGmp0YOxO4eL1uiXLMfsmvLxDcUd4RfpIwXtB11YLjDWsA/oTVyO0/P6Opg+ZC/IqUUsbCwDW4Dgw2QXrmCemGCKKVUNIPd+yB4b7Dc7qVdRQOV3goOYHWRTIl+GotfMt47C4EinMz9xq6i88Dw/39qEOc5WVoFuszjQ9nGSYfzYRLsnGwh9AkO6h/R4MN7mv7M3QSi9Hfe6ZWOyQEiOpEoGNZ+5QyGaMXHcYc+OSos96loHO8FiDAp/jIyaxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtoIAVSgI0rE+59jgasrl9wNjCCG6t1IPAehQKR19js=;
 b=dT2VaLs/XnUK9DjJf3VRCF7mQQKXc22JGQH1JqBMmX8TWFTDGU7cM/XpRiqjow8ia8Es2hCGa6MD7cLmZfP5QYEf55Qc9FqQxBlMdAg9D8r54ZWpPhyrPE0QIBtH9VDG6gUTPloGVfkfxLcoO1DdvP0uct+RNQ7sLrwH4tw/koE=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5159.namprd03.prod.outlook.com (20.180.4.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Fri, 20 Dec 2019 14:01:36 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2538.022; Fri, 20 Dec 2019
 14:01:36 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: virt-dma: Fix access after free in
 vcna_complete()
Thread-Topic: [PATCH] dmaengine: virt-dma: Fix access after free in
 vcna_complete()
Thread-Index: AQHVtzbsaWn2CaQHREast6QazHrzz6fDDY4A
Date:   Fri, 20 Dec 2019 14:01:36 +0000
Message-ID: <0303ceda023121d9048d2508e28c0306b1871561.camel@analog.com>
References: <20191220131100.21804-1-peter.ujfalusi@ti.com>
In-Reply-To: <20191220131100.21804-1-peter.ujfalusi@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2bb2399-1eec-4d1c-1a28-08d7855520e2
x-ms-traffictypediagnostic: CH2PR03MB5159:
x-microsoft-antispam-prvs: <CH2PR03MB51590033193D05A66316042EF92D0@CH2PR03MB5159.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(2616005)(5660300002)(36756003)(186003)(6512007)(4001150100001)(86362001)(71200400001)(110136005)(316002)(6506007)(26005)(4744005)(478600001)(8676002)(81156014)(81166006)(4326008)(54906003)(2906002)(66946007)(66476007)(76116006)(64756008)(6486002)(66446008)(66556008)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5159;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vXR+yN2tg/BEtQrc5Zx6+XN98JcbzsDIxo7RokXL1Q9CBZobnLGnaULUbDf/VOxpEnDP0Mbw4sMA6rd141+12UUCZUrXfwQnVmqlFB6DH6ChA6MrXCx0VblZ7M7CwXCkXNP+lRUi1wJEqAWuwS57mtCBmVLW2jLne0A1frX3Q4g0S6xx2CQ00Pn7LVtcuDIGbD59jrUilIBO9VLcVp3sJDOcu24htRHP9tG+yq10q0kJe0C2ZWbh2LCY+uuJOLdgkH3ZGLRhDSGcTGqntOcI3QWcvThH+9xNEpmYRg4yYsjxihetBlx5xxjD+Wgdu4+DHusAjEpz2b6A6Kfrj4zRmKutxcdXPnzD8cSGRYxVPnql/V3U74IJPbdkoBerU/AU4DToalxdVCwEOU5SpKGVXO/9bFZbXkAu1Ycrv9PXrRdF3k9S/ezKXwRmyz7g3H4B
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B057917A2E2F3408E7A07AC8311649F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bb2399-1eec-4d1c-1a28-08d7855520e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 14:01:36.5552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5z1/K0+26DvrpXcJpHDxuKas6i/Q+snA3zDhie8KfDX+NJnoR9THegwmbd95Z0ghDMgE9363U5fDZgVQrpKUNgHQ+oWAC+vJFiU2NBggVwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5159
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_03:2019-12-17,2019-12-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912200111
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gRnJpLCAyMDE5LTEyLTIwIGF0IDE1OjExICswMjAwLCBQZXRlciBVamZhbHVzaSB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gdmNoYW5fdmRlc2NfZmluaSgpIGlzIGZyZWVpbmcgdXAgJ3Zk
JyBzbyB0aGUgYWNjZXNzIHRvIHZkLT50eF9yZXN1bHQgaXMNCj4gdmlhIGFscmVhZHkgZnJlZWQg
dXAgbWVtb3J5Lg0KPiANCj4gTW92ZSB0aGUgdmNoYW5fdmRlc2NfZmluaSgpIGFmdGVyIGludm9r
aW5nIHRoZSBjYWxsYmFjayB0byBhdm9pZCB0aGlzLg0KPiANCg0KQXBvbG9naWVzIGZvciBzZWVp
bmcgdGhpcyB0b28gbGF0ZTogdHlwbyBpbiB0aXRsZSB2Y25hX2NvbXBsZXRlKCkgLT4NCnZjaGFu
X2NvbXBsZXRlKCkNCg0KDQo+IEZpeGVzOiAwOWQ1YjcwMmIwZjk3ICgiZG1hZW5naW5lOiB2aXJ0
LWRtYTogc3RvcmUgcmVzdWx0IG9uIGRtYQ0KPiBkZXNjcmlwdG9yIikNCj4gU2lnbmVkLW9mZi1i
eTogUGV0ZXIgVWpmYWx1c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2RtYS92aXJ0LWRtYS5jIHwgMyArLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS92aXJ0
LWRtYS5jIGIvZHJpdmVycy9kbWEvdmlydC1kbWEuYw0KPiBpbmRleCBlYzRhZGY0MjYwYTAuLjI1
NmZjNjYyYzUwMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9kbWEvdmlydC1kbWEuYw0KPiArKysg
Yi9kcml2ZXJzL2RtYS92aXJ0LWRtYS5jDQo+IEBAIC0xMDQsOSArMTA0LDggQEAgc3RhdGljIHZv
aWQgdmNoYW5fY29tcGxldGUodW5zaWduZWQgbG9uZyBhcmcpDQo+ICAJCWRtYWVuZ2luZV9kZXNj
X2dldF9jYWxsYmFjaygmdmQtPnR4LCAmY2IpOw0KPiAgDQo+ICAJCWxpc3RfZGVsKCZ2ZC0+bm9k
ZSk7DQo+IC0JCXZjaGFuX3ZkZXNjX2ZpbmkodmQpOw0KPiAtDQo+ICAJCWRtYWVuZ2luZV9kZXNj
X2NhbGxiYWNrX2ludm9rZSgmY2IsICZ2ZC0+dHhfcmVzdWx0KTsNCj4gKwkJdmNoYW5fdmRlc2Nf
ZmluaSh2ZCk7DQo+ICAJfQ0KPiAgfQ0KPiAgDQo=
