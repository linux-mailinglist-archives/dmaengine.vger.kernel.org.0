Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E70CAB5E
	for <lists+dmaengine@lfdr.de>; Thu,  3 Oct 2019 19:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfJCR1R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Oct 2019 13:27:17 -0400
Received: from mail-eopbgr800052.outbound.protection.outlook.com ([40.107.80.52]:45408
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728114AbfJCR1R (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Oct 2019 13:27:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0dUTtuQCcXHYybTqPmdj1BRj5NHWEo8sJWJdUst3IFwC4kEKxGeN8flowVBum4T04cSdDkXP7Mv+UZ4pO0S4YCX1gKGN+RA53zNU18SXr4YqiZJmYETFIOyo1GfiZvdeEunXzCYCmbH1ZUsqVeGqH9UDUVOygdqu3DVo0y76UYs8cLn+B89tebzHF9d8+q4nuOAOdJPTZrmJAzvpPqB3q8NVwGh+tdHGwYMp8NKPbBOhIrWzPZqKDGnsmz/3A/b9Uj+y9sR91nRI5zlBwxWR9K4CJODmrweomRCcbAmOBq1wBs0/WxWcB+IJc2/tL+vpUpZ15uAG+711XyrdDDsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2pLiHj37YkNZeAIF/BdCLZhaIRHYxqR9fFmxZyPRWw=;
 b=W2+clDxJpLumRnRQFEBYPRaRwguhUJQO8ksYiTVY6N9qBjF0Vd7z7tn5eZSthiLxaYTn744Ft67q4qpRsNQRIBvfBddP5qJg7Vq7KQBDrOAgB+XI0BPJ2ez8hB3cmWYqhIctMPZK7uUbz6XKUL3vi+xbBpDIZJeyigAp6i2uxJH/yLsxCIEmCMXHEoKCTUZfIOjIZtTT+T/3X1DfiOphPzQ3NGyGWVcZ+Wdrkx9/yDd2wgvoeLvU1rBEd940HliMbyeNHm1ivEEmItLpIFi+6QQE6Jii7whznLCN2AqoQwt4OgyvTS5Ef0wLo+Z/3vZNRHDDnT/RXkbntnrs0IaehA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2pLiHj37YkNZeAIF/BdCLZhaIRHYxqR9fFmxZyPRWw=;
 b=KsB7G1ig9TVe4EZg6t3EedVfI4LOqLYRB4i+OvSig3qaiG7wUI8JvAmFHkkCw+C/vRYrXJJ5WrxdghZ0Z/a1D31q/0Uy4W/EDhmXEsqnbWk7GpQ7IjM/qXtQs89dX4LogywpfrNc1SDeQ3ZU6vQ7o7MOto9p80iNnssN0UI/xdg=
Received: from DM6PR12MB3451.namprd12.prod.outlook.com (20.178.198.218) by
 DM6PR12MB2810.namprd12.prod.outlook.com (20.176.118.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Thu, 3 Oct 2019 17:27:15 +0000
Received: from DM6PR12MB3451.namprd12.prod.outlook.com
 ([fe80::2970:ffc7:bab:4e32]) by DM6PR12MB3451.namprd12.prod.outlook.com
 ([fe80::2970:ffc7:bab:4e32%3]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 17:27:15 +0000
From:   Sanjay R Mehta <sanmehta@amd.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "Hook, Gary" <Gary.Hook@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Kumar, Rajesh" <Rajesh1.Kumar@amd.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 0/4] *** AMD PTDMA driver ***
Thread-Topic: [PATCH 0/4] *** AMD PTDMA driver ***
Thread-Index: AQHVcqoESUxZSvjG70+062OZ6XyZgqc7B3MAgA4ysoA=
Date:   Thu, 3 Oct 2019 17:27:14 +0000
Message-ID: <8a83d483-d5e2-703c-61ed-adb88c1f9559@amd.com>
References: <1569310236-29113-1-git-send-email-Sanju.Mehta@amd.com>
 <20190924163744.GC3824@vkoul-mobl>
In-Reply-To: <20190924163744.GC3824@vkoul-mobl>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::29) To DM6PR12MB3451.namprd12.prod.outlook.com
 (2603:10b6:5:3b::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [49.206.13.118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78d5e90f-02b7-4fce-e64e-08d74826eeb8
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM6PR12MB2810:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28107CB0685891320CF798BEE59F0@DM6PR12MB2810.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(5660300002)(71200400001)(316002)(14454004)(6436002)(6116002)(7736002)(36756003)(52116002)(478600001)(3846002)(305945005)(66066001)(54906003)(7416002)(6916009)(6512007)(55236004)(102836004)(31686004)(71190400001)(11346002)(386003)(476003)(76176011)(229853002)(446003)(6506007)(53546011)(66476007)(64756008)(66446008)(66556008)(2616005)(66946007)(2906002)(25786009)(26005)(4326008)(186003)(99286004)(8936002)(8676002)(6486002)(81156014)(81166006)(6246003)(486006)(256004)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2810;H:DM6PR12MB3451.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /JnVuiwvXmrvwtQcB8+DGU4R4JQTIjTSYA2vpHpeDY9UkAhM7zm+rDrDfSfxER5+2BTG9Jd4/WiTCAG5tKGY0iyMf4zwo7hn2w6HNl9Ofk68ScH1Kfde4YVJxTQh1WAZ3Q/fmfygiEtfBv54PgmFy7Hz9mnBA7OBTY8+XB3RdE4yk3e+Gcxf7CjNYGI0Izb3RLpRWNTmNk+8K5QDGmP93roajHUNTqPYtRL4u/79968vU+OBr3nEDImtU2Qq3UCfMKEE8gM3Yt4z8K496P0JbKFU5/PVuoK0GDOhfJW5PyYjnQL0BEzNZySsFahTfO2J7AVP6JjNs1yjymWc0dmaBc2yiZAEPrA0xkpDG9+iYeNgypqQZRo/0WucniYeYLMuLtDQf8lUFZkheijAVRXRBt8eFGaBDnU07drJRKdtg8g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0249ED53C107B042A20043607AD9007C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d5e90f-02b7-4fce-e64e-08d74826eeb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 17:27:14.9555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfZDdUm3YCLqJmrQ/9sZY+n3p2KukMFD4Cb3Iqb/DXrq/oo5uzb35YmdPnd0qgeALPr88vpRfVW7Ej6vrsU4jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2810
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQpPbiA5LzI0LzIwMTkgMTA6MDcgUE0sIFZpbm9kIEtvdWwgd3JvdGU6DQo+IFtDQVVUSU9OOiBF
eHRlcm5hbCBFbWFpbF0NCj4NCj4gT24gMjQtMDktMTksIDA3OjMxLCBNZWh0YSwgU2FuanUgd3Jv
dGU6DQo+PiBGcm9tOiBTYW5qYXkgUiBNZWh0YSA8c2FuanUubWVodGFAYW1kLmNvbT4NCj4+DQo+
PiAqKiogVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBBTUQgUFRETUEgZW5naW5l
ICoqKg0KPiBXaGF0IGxvdHMgb2Ygc3RhcnMhDQo+DQo+IENhbiB5b3UgZGVzY3JpYmUgdGhlIGNv
bnRyb2xsZXIgYSBiaXQgbW9yZSB0byBoZWxwIHBlb3BsZSBzZXQgdGhlDQo+IGNvbnRleHQgZm9y
IHRoZSByZXZpZXchDQo+DQo+IEFuZCBhbHNvIGhlbHBzIHRvIG1ha2UgdGhlIGVtYWlsIHN1Ympl
Y3QgYXMgIkFkZCBBTUQgUFRETUEgZHJpdmVyIC4uLi4iDQo+IG9yIHNpbWlsYXIhDQpPa2F5IHN1
cmUgVmlub2QuIFRoaXMgd2lsbCBiZSByZXNvbHZlZCBpbiBuZXh0IHZlcnNpb24gb2YgcGF0Y2gg
c2V0Lg0KPg0KPj4gU2FuamF5IFIgTWVodGEgKDQpOg0KPj4gICBkbWE6IEFkZCBQVERNQSBFbmdp
bmUgZHJpdmVyIHN1cHBvcnQNCj4+ICAgZG1hOiBTdXBwb3J0IGZvciBtdWx0aXBsZSBQVERNQQ0K
Pj4gICBkbWFlbmdpbmU6IFJlZ2lzdGVyIGFzIGEgRE1BIHJlc291cmNlDQo+PiAgIGRtYWVuZ2lu
ZTogQWRkIGRlYnVnZnMgZW50cmllcyBmb3IgUFRETUEgaW5mb3JtYXRpb24NCj4gQ2FuIHlvdSBi
ZSBjb25zaXN0ZW50IHdpdGggbmFtaW5nLCBhbmQgeWVzIGRvIHVzZSBkbWFlbmdpbmUhDQo+DQo+
PiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKw0KPj4gIGRyaXZl
cnMvZG1hL0tjb25maWcgICAgICAgICAgICAgICAgIHwgICAyICsNCj4+ICBkcml2ZXJzL2RtYS9N
YWtlZmlsZSAgICAgICAgICAgICAgICB8ICAgMSArDQo+PiAgZHJpdmVycy9kbWEvcHRkbWEvS2Nv
bmZpZyAgICAgICAgICAgfCAgIDggKw0KPj4gIGRyaXZlcnMvZG1hL3B0ZG1hL01ha2VmaWxlICAg
ICAgICAgIHwgIDEyICsNCj4+ICBkcml2ZXJzL2RtYS9wdGRtYS9wdGRtYS1kZWJ1Z2ZzLmMgICB8
IDI0OSArKysrKysrKysrKysrDQo+PiAgZHJpdmVycy9kbWEvcHRkbWEvcHRkbWEtZGV2LmMgICAg
ICAgfCA0NDUgKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICBkcml2ZXJzL2RtYS9wdGRtYS9w
dGRtYS1kbWFlbmdpbmUuYyB8IDcwMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4+ICBkcml2ZXJzL2RtYS9wdGRtYS9wdGRtYS1vcHMuYyAgICAgICB8IDQ2NCArKysrKysr
KysrKysrKysrKysrKysrKysNCj4+ICBkcml2ZXJzL2RtYS9wdGRtYS9wdGRtYS1wY2kuYyAgICAg
ICB8IDI0NCArKysrKysrKysrKysrDQo+PiAgZHJpdmVycy9kbWEvcHRkbWEvcHRkbWEuaCAgICAg
ICAgICAgfCA1NjMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAxMSBmaWxlcyBj
aGFuZ2VkLCAyNjk0IGluc2VydGlvbnMoKykNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9kbWEvcHRkbWEvS2NvbmZpZw0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2RtYS9w
dGRtYS9NYWtlZmlsZQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2RtYS9wdGRtYS9w
dGRtYS1kZWJ1Z2ZzLmMNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9kbWEvcHRkbWEv
cHRkbWEtZGV2LmMNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9kbWEvcHRkbWEvcHRk
bWEtZG1hZW5naW5lLmMNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9kbWEvcHRkbWEv
cHRkbWEtb3BzLmMNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9kbWEvcHRkbWEvcHRk
bWEtcGNpLmMNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9kbWEvcHRkbWEvcHRkbWEu
aA0KPj4NCj4+IC0tDQo+PiAyLjcuNA0KPiAtLQ0KPiB+Vmlub2QNCg==
