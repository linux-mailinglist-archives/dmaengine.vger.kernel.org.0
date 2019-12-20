Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EABA127C0E
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 14:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfLTN4q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 08:56:46 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:31778 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727351AbfLTN4q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Dec 2019 08:56:46 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBKDtIem026834;
        Fri, 20 Dec 2019 08:56:36 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2059.outbound.protection.outlook.com [104.47.37.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wxf1n3tpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Dec 2019 08:56:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqRxpOiEyNo0YSo08r/IOVD1E9I+mWR6FbZRW9Vw+caQCiEaMjjrsq7qOl0sPglhJb5HPm7I/QRKE1yRyDrRs/gDZAjZpY2/H8xvSFaFxmHPAj3OZZbQTkAAIzozwkhIKAtocgdzDFNufKl98s+G4KiaVo2Petoa9oVX2AcZYXRaW63ryQKB/aH7/bv+WMtvRZNLe+mZOKhsazBVUIyXptm0n3pHmRBg5sV8q2pauqZopmalN54wLaSc2QMq9cTN9WE0zJ7MCmOmLtbtznuIdd1fMYZJkDOS10fTa4aFx+IKG8HPM5Y7oYOozIbA9DDAUII8KeOvuNguz0DWqbOLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfu/D4NYCZrnOUHJrFoLi7m6qMD+4/YZ7lbEgprIvUc=;
 b=LvkISIVtCupDk+uFe/IkU2edAQeInKfyDrG5A11dPNlZFQVwSl4HkuxmiKe28+av+v+EXHJLq3fexEZM9sTBjSv6OIY2WDzalDYf0zLEDZTY2adc4kv+CuvXBnSI1jB+6VymWatahe+1upkcWD9nz9S3kzmgPqgavWNcUScDK5ji2mCY0nJIyPCfjUJ0y5OTQ5tBr5ZSjiB1mEFPp5n6A+wvnzGgN07Bvj+vL7RkOu56taefl6LNuTV+SKgZ5mVPf5NeFz85YaH6t9yB6xJWuhrg+YrqexlBOHbINSp0h1O1pdBT/+xNW2K+UI7d+kSvczdndCaDiGC2KwjObtmTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfu/D4NYCZrnOUHJrFoLi7m6qMD+4/YZ7lbEgprIvUc=;
 b=HQ3M5FRtULNK5nVw+niWcVaVsyVXynb9P6KYf7u7KmHZyTjxJXcNRlGkKg3rLshdqjXHvjvzHsTVlkCxEIAHxLOS31HxaDLPwXVs+QBaThKUo8ibKPWQ96K7FtmaRpfg1T95qZ2nGcBxqpwD86izsnihxilz6g0XuBJe42mMlQ4=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5288.namprd03.prod.outlook.com (20.180.15.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Fri, 20 Dec 2019 13:56:35 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2538.022; Fri, 20 Dec 2019
 13:56:35 +0000
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
Thread-Index: AQHVtzbsaWn2CaQHREast6QazHrzz6fDDCYA
Date:   Fri, 20 Dec 2019 13:56:35 +0000
Message-ID: <8d16035ddfff974e5d28043d91ce2a4077f89e81.camel@analog.com>
References: <20191220131100.21804-1-peter.ujfalusi@ti.com>
In-Reply-To: <20191220131100.21804-1-peter.ujfalusi@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8a3071e-d69f-4346-90d2-08d785546d3c
x-ms-traffictypediagnostic: CH2PR03MB5288:
x-microsoft-antispam-prvs: <CH2PR03MB5288130FEC32A2B808A4D3CBF92D0@CH2PR03MB5288.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(2616005)(26005)(8936002)(71200400001)(2906002)(86362001)(54906003)(81166006)(81156014)(66946007)(66446008)(4001150100001)(186003)(64756008)(8676002)(76116006)(5660300002)(36756003)(4326008)(6486002)(110136005)(66556008)(4744005)(316002)(6512007)(66476007)(6506007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5288;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PA62y54+CkwCURZ74k18THBoqwGfuo65bQcWr/7GBVJBaDVRpu1eK5FvX013ei4zixXcT6q0CBA7uRSa/eF+G2Tfpu3BsoLLrzQW23sSV3kdS6uBP2ze+oxHCn2d/RD1w/3IvpYDvtLN6i9ajIvPc3DABd5yNjDjrjPJmrgIjm1Yg8weH/9oMMY01ZrnWtShocCrfmNl5amI3iaarBg0NeX1CaB/g85fuNrLWaAEn6d3aFOTgf1Xb4rQeTOl4JyPMRGJmeLoO7TfOQxj1vBa2qe4ADfiK5QuqJAsNV2K+T/ToGB+D+GTHDN7AFWkYa0K/FIHNPEr6QDLZP7J4rbfXKYaPiPo6H285zvcWXleY8WLQhyhR1HTZVqiRacYvP3pG8WQXu4YmBMTpu9UTyYb4++lZfl4WcZKDJ8HgmqmfDIqQ9L5OZBKFOKcXWEzkE/m
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C60BA5ECB522CB459C61133DDC0259F0@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a3071e-d69f-4346-90d2-08d785546d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 13:56:35.1671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dkxB0Vo3VTAzcsQO4oxtRHKPKT2JfnPraCOFE6my1DZgdNcMKy2FfyH2xQKYB7uTZk56wVqB/Mbeve9V+HJrrSPchYaECf4PzNXRftd13jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5288
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_02:2019-12-17,2019-12-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912200110
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gRnJpLCAyMDE5LTEyLTIwIGF0IDE1OjExICswMjAwLCBQZXRlciBVamZhbHVzaSB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gdmNoYW5fdmRlc2NfZmluaSgpIGlzIGZyZWVpbmcgdXAgJ3Zk
JyBzbyB0aGUgYWNjZXNzIHRvIHZkLT50eF9yZXN1bHQgaXMNCj4gdmlhIGFscmVhZHkgZnJlZWQg
dXAgbWVtb3J5Lg0KPiANCj4gTW92ZSB0aGUgdmNoYW5fdmRlc2NfZmluaSgpIGFmdGVyIGludm9r
aW5nIHRoZSBjYWxsYmFjayB0byBhdm9pZCB0aGlzLg0KPiANCg0KUmV2aWV3ZWQtYnk6IEFsZXhh
bmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoNCj4gRml4ZXM6
IDA5ZDViNzAyYjBmOTcgKCJkbWFlbmdpbmU6IHZpcnQtZG1hOiBzdG9yZSByZXN1bHQgb24gZG1h
DQo+IGRlc2NyaXB0b3IiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBVamZhbHVzaSA8cGV0ZXIu
dWpmYWx1c2lAdGkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZG1hL3ZpcnQtZG1hLmMgfCAzICst
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL3ZpcnQtZG1hLmMgYi9kcml2ZXJzL2RtYS92aXJ0
LWRtYS5jDQo+IGluZGV4IGVjNGFkZjQyNjBhMC4uMjU2ZmM2NjJjNTAwIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2RtYS92aXJ0LWRtYS5jDQo+ICsrKyBiL2RyaXZlcnMvZG1hL3ZpcnQtZG1hLmMN
Cj4gQEAgLTEwNCw5ICsxMDQsOCBAQCBzdGF0aWMgdm9pZCB2Y2hhbl9jb21wbGV0ZSh1bnNpZ25l
ZCBsb25nIGFyZykNCj4gIAkJZG1hZW5naW5lX2Rlc2NfZ2V0X2NhbGxiYWNrKCZ2ZC0+dHgsICZj
Yik7DQo+ICANCj4gIAkJbGlzdF9kZWwoJnZkLT5ub2RlKTsNCj4gLQkJdmNoYW5fdmRlc2NfZmlu
aSh2ZCk7DQo+IC0NCj4gIAkJZG1hZW5naW5lX2Rlc2NfY2FsbGJhY2tfaW52b2tlKCZjYiwgJnZk
LT50eF9yZXN1bHQpOw0KPiArCQl2Y2hhbl92ZGVzY19maW5pKHZkKTsNCj4gIAl9DQo+ICB9DQo+
ICANCg==
