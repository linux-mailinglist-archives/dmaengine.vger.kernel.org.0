Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F08A4A37C0
	for <lists+dmaengine@lfdr.de>; Sun, 30 Jan 2022 17:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355595AbiA3Qns (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jan 2022 11:43:48 -0500
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com ([40.107.237.85]:62176
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1355563AbiA3Qns (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 30 Jan 2022 11:43:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faG8TIgxudTj0DKgkid1diqleLxVQMsPbbMj/PmjwMxFZAnglgpbLAJQr0tnR87LCt+fbZe+32oQVRv3Ht026xHywRLzquvSHgiv4b0WD7gCghcfEAOtgHYQ4tjB3qUZSf6Zlqd44Y7ugF3rGutwbEoabbetssC8uw6Lgan+gSMXtS9VSrFQX2eW0lGxyTDvO9bsdAvwhbLwNP0b6oiI1/Q2I5ubk3RHcRwhqasE8dIQrSRQtthQXTO/o23Sad3FZLy4oUC30ZPPE7t6dewUzobJT9MG47PDa2pEbeDl9PbEXzUQBC5+LzHitXotrR7H9ZKJo5tafZt9TTKdxmELnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoXT6p4xOlm6HKPDaMzvfEo+HXOLTE7ZSXkbJgqSqf8=;
 b=cqy8drJ5wvCeeDj69oCPLyShzrWv+1X2qyR5Ru0VxU99M/GuTqW4Gdf22gLVVcWelSy2VbBkX+tpugmf2X2kFsWsBVcsEHcDQ0ky9QWAVETi7aCzXyT/yBKm2B4d4ROgMrZzDybCIEP5OQF2eGBh36fofLJBbgxBBNkhpzhtLxhfytwGsjfcUDLEEl7D+jgRD0+cX6zHEkh1UudKe0mQPxUqjh5U4E/axW5Ow/KLpbIXvIQwJFJqtYEtOE/FFZYEc4lrbnyMHxrhMSMrYP8eOtruSgOW+1ZmTLV4ag0Ob1lh3XuUJBETPZ2jxzpFl6F4oUjWnNC2jAEnqoE/ILR1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoXT6p4xOlm6HKPDaMzvfEo+HXOLTE7ZSXkbJgqSqf8=;
 b=VNc3/1Q/9uw1xnkO0XJBoXRLd97bq+bDaHv+nx0j03bFsQthtuS8od4tACWIoBvpqH/KiN80iWZdk5nv33qYbYUa5DprzUpjiLpam6vAixiG4/VqPdg/4WGGc89+qBAkiASQjkhhMFYJ46tnUrThdAv4bWTswVdTLPpx1G7ZRLsTjN6momTAmWQqLX3+hU8jyTd7ruPI4+qOkeCrw2XK2lwkvm5b549UbzqZWXhVDfwyPphMUsA5QujoEciMGWDWkQZNxXpp4dAokiw7VKjas5NoTLAPmgggS5xxdkfcPGcxo9xwIvgV1y/QIvImTdMqbjRUZoMuCGLYBVy4mhYS2A==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sun, 30 Jan
 2022 16:43:46 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133%4]) with mapi id 15.20.4930.021; Sun, 30 Jan 2022
 16:43:46 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: RE: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHYFS8ttZm9vnsYMkmLjfwGSkse9qx7V3sAgAAF64CAAAH6gIAAZMoA
Date:   Sun, 30 Jan 2022 16:43:46 +0000
Message-ID: <DM5PR12MB1850C29D41F50FA6850C89DDC0249@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
 <1643474453-32619-3-git-send-email-akhilrajeev@nvidia.com>
 <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
 <dcd4e4db-2999-15c9-0c82-42dd8ca1e61d@gmail.com>
 <f32e119a-1d08-d1f9-a264-fe004960e8bf@gmail.com>
In-Reply-To: <f32e119a-1d08-d1f9-a264-fe004960e8bf@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 312fe727-81a0-45ba-2892-08d9e40faf3d
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_
x-microsoft-antispam-prvs: <BL1PR12MB53346194B870A489244959F1C0249@BL1PR12MB5334.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NbGjeKWBJ0hEfNSly+wJyg3WnStk+R8x8Scayzwm0AMDt2UYfpYUCmODVLZO69pd9np63Wfd0karzM96WaAPQqMfCOYmeVhY57ILPQCY2l3uFfbLWV7zwPHPJMywyj7kMtEXxbqtRd6w0SHa8G3naO3QIvT8VNgluSAWKCYXu1AxnVLpdj66jutQGAFmvhk/w2vRod+xKejXu7Y+69yiYAU05Q4YoZupMxJK/yshuUY0/cIaoQcYWoffafE4NsK49yc3nuOhtHUgsv+so3JC8ID9eOcfYxfaEBAAzoIY6YxE2/SbKEBVhMm/NmJdDwr0CCpq8FV8wQ1btlqFeyqX8VrbcU2ifn39j4KNqfVgaVKFjDwdRHJhI8LysbFr67HOt02RtaTMfkJpzy0zPETml0wckMCAcp+BNLeBBi40DsMP81t2seF4H/GLkJIf0NYELl47WW95PCDzZO4tLZ/+/v8SpU3Yh9MIN6g3CYHnTPqf1ZRn0XquujS5XtMEM6OCnfFgVpXhu25jUWkAgRN1BVuDdiGZTA+BOdyhHbBlbh63zN9fEnF3JgpcvM/pFD6OVAvBe4OwPrafQqW3yWhzuKQNvKyJzUtOrlsH7XIYNdO4vLAm4x6AuIJ1I3wioTEi6pTFNgWTfSUwkr4Azj/M487B8nkgKxTJCqhif5KeUVbimMr7hZfwrPxnDVB4mYuURvyonWjSAlZUkz+ik7c9pv7q3JsrXrzHP1i3Qi90NW4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(6506007)(9686003)(107886003)(52536014)(5660300002)(2906002)(33656002)(26005)(186003)(55016003)(508600001)(921005)(122000001)(86362001)(83380400001)(38070700005)(8936002)(8676002)(71200400001)(4326008)(316002)(64756008)(66476007)(66446008)(66946007)(66556008)(76116006)(38100700002)(110136005)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlFKYi94UFlVVXA1QzdMZVM0dFM2U3d4MUdIWVF6NDBncGgrUzNOcWJPK05T?=
 =?utf-8?B?NUNTQlIrN0t6SzJwRW1rakk3UGxVd2Z1Tm9rdVJpS3Jqd04yWW1lUGNvRW03?=
 =?utf-8?B?N3VIRm9MYjIwL2RpdVFSRUF5c0ROV1pNSXh0SkVBcGRwTVdsUVdlaTNzRFZs?=
 =?utf-8?B?aUtmTkhhWVZTVEpoYW9VajdqVll2cnk1SlFLK2U2QnRuMmxzSGZ4VFpOSHR1?=
 =?utf-8?B?dld5bXJvcUFPQVNQZFZnamdDRnhSVWdESHhKSmlnNDluOVo3SFlhMXZiMlk1?=
 =?utf-8?B?WkhQUDhoMllESHFMejhhOHhieXFQNjBJOE1IbFJSSHRkYTdySlNYelNqcHVX?=
 =?utf-8?B?VC9RcXBLNS9ZSERGQjdFNG9iTTZFSzk1azI2QTNrU1lhSS9JMncwM2JkZ2Fp?=
 =?utf-8?B?bUtZZVB0Z0E4TWl1Zk9jLzhjdXYzVlZTdGx6N2N1LzJCMXVqMlZHZ3NCcXAr?=
 =?utf-8?B?RzVEZThuSHRqSWU2azUzZFc2VGplVmZQY1RWMS9OTlRYS3ZUZ3dmK2F4N1p5?=
 =?utf-8?B?WFNDWWQwL2ZHWWpNcWRPL2JybGVZUXMvczlTTXdsTzdtUHV4YzgvVFlSemYy?=
 =?utf-8?B?VjhOMjRsalBycTRHcGp3QUY5bmNlWk51SllJNENvM2xvem1nMS9WdkFOWXNm?=
 =?utf-8?B?RWJxcjk5bTdnaXZ0cFpncERJZFU0QXIyUm9TSWo3YUZoNDkvTEhOUXNkMnpV?=
 =?utf-8?B?VmdKRlE0NEdMUUtqNUxjLzlVajFvOTNiZS9kRUVOS0NoQitNWnd1Z0hDaWpn?=
 =?utf-8?B?eEhUV2p4aFpsUVlrSGljZGZ1MGpLRHVlMXRlNWZITEV0c1lPbDZjMTF3OHNm?=
 =?utf-8?B?Wktzd1Q0Vm00Q040U0VaQ3Rjc3FmdHJsTm5DM3JuSlZsNFB6ZXZ2TkhWNnlK?=
 =?utf-8?B?ZHYzT0JGRmc4KzRhWlc0VVhFam5YeHJiZERnS2tPZW5zdlRsT0tCOFU4UTBP?=
 =?utf-8?B?L0tnL0J3MGJNSEJmYWdOVjdpVHZJTXgyalI0OHN3OHJFbnZFSTIreGZKNFk2?=
 =?utf-8?B?UGpnN0x0czVzU0M1Z2dic29iOTBaMEtUalI0eXNPR0lkMFNCRlUwOTBmNXJh?=
 =?utf-8?B?b1B0aElrcTNCczVJYjA1bVZmcTU2QU5tN2Q4TFR2UFZIUFZlQXJiV0lhcG9j?=
 =?utf-8?B?L2xHQlZhUG1DUWgzSVdkeVJ5dUhkcjgyUXVJd3hjZ0xMWG9oaEh4ejNtTldn?=
 =?utf-8?B?UHZoTk5HakRQcW9LSFAwN2RzeE1JOUEvNEhRSWFXZzdLajc2TlB2R2UxanN0?=
 =?utf-8?B?YWJIdnlVZ1NiajB5UVBXTnNLczNjc2JtQzE1T2UyVFJydHExdWkzTTlXbE5D?=
 =?utf-8?B?TDkyZ0dNTmpCbGNFWGp0VTBVSTR0RFdlZlBZemtWZ1JObGhSdXJQd3EwWExS?=
 =?utf-8?B?SWRvLzJteDJCbWhSN1dCOEpyalRnNXZFVmVoN0ZIVnRJQmVXOC96aS8xMm8x?=
 =?utf-8?B?TTY1STdLYzVteG9ycTdJeEliQzQ3SVdDNElsSFlWOCtUWHRYSkFmSVoxbkhC?=
 =?utf-8?B?T3BwSmNOcktRQjlJdVNSd1lNbTJxbWhZNXVJd1RvMytuVzJpbk5UNzBMSFhu?=
 =?utf-8?B?anFEclBBTVFLcDhpTDhjZXpwMDduTzRIN2ZnSlV2azNwN29vaEZhTVU2S1oy?=
 =?utf-8?B?OHBwZjA3ZFRNTXlBN1VIbjJuT0pUSW9HWkJsYlRaM1JEQzdaS0lXL255TWJq?=
 =?utf-8?B?Q3ZXTHp6azhhT25WRG5oMEN1WHFvL0F5RC9DTEFsWTltSjVNbDZQeU9wVUVx?=
 =?utf-8?B?RnFST1FBUHBYMExBK2RFU0Y1QWR6UndPbHI1bklrU3NaNitEQXZwQTRNRm9D?=
 =?utf-8?B?czFjUU45V1d3NmRjZ2pYNjhseTdBeFlCMFUrRWhvem1OdFBiekZUNjVtUjky?=
 =?utf-8?B?WUVuMFFPcjhzeVYyQlErNFQwZk10UnlOTzNPd0pmTzVXWEdlQy8yZzNXOGNr?=
 =?utf-8?B?Q1R0dUk0RWZUbjNvVGZtTE9RV0hzVU9nZWhYWnVyQlNPaGJJYlVTbGVndXZ0?=
 =?utf-8?B?MlV1STloNnNiaTRtR1FPYmt5cDAxMWF1cFk0UFNoRTFzcW5JbmhndjhGT1U4?=
 =?utf-8?B?R0ZoZHAzdmRic0JLWHY1emJBcmQxUUQra0xlNGVxUzcrRktUVUdxdERZQThC?=
 =?utf-8?B?NzZFa21qZjJaWnlTMTZ4NFc5UW9GVDdIQnF0NjNyS0lrTGI2Z2lsaWdMcktB?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312fe727-81a0-45ba-2892-08d9e40faf3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2022 16:43:46.4517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x53B0sXy50VN3pc7hl6kkBu00e/Buf5VVhHicLCQQ0okLYNbthfpSQBK+HPA54rd5Knij3ctT5pFQi1Ya+kKmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5334
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAzMC4wMS4yMDIyIDEzOjI2LCBEbWl0cnkgT3NpcGVua28g0L/QuNGI0LXRgjoNCj4gPiAzMC4w
MS4yMDIyIDEzOjA1LCBEbWl0cnkgT3NpcGVua28g0L/QuNGI0LXRgjoNCj4gPj4gU3RpbGwgbm90
aGluZyBwcmV2ZW50cyBpbnRlcnJ1cHQgaGFuZGxlciB0byBmaXJlIGR1cmluZyB0aGUgcGF1c2Uu
DQo+ID4+DQo+ID4+IFdoYXQgeW91IGFjdHVhbGx5IG5lZWQgdG8gZG8gaXMgdG8gZGlzYWJsZS9l
bmFibGUgaW50ZXJydXB0LiBUaGlzDQo+ID4+IHdpbGwgcHJldmVudCB0aGUgaW50ZXJydXB0IHJh
Y2luZyBhbmQgdGhlbiBwYXVzZS9yZXN1bWUgbWF5IGxvb2sgbGlrZSB0aGlzOg0KPiA+DQo+ID4g
QWx0aG91Z2gsIHNlZW1zIHRoaXMgd29uJ3Qgd29yaywgdW5mb3J0dW5hdGVseS4gSSBzZWUgbm93
IHRoYXQNCj4gPiBkZXZpY2VfcGF1c2UoKSBkb2Vzbid0IGhhdmUgbWlnaHRfc2xlZXAoKS4NCj4g
Pg0KPiANCj4gQWgsIEkgc2VlIG5vdyB0aGF0IHRoZSBwYXVzZS91bnBhdXNlIGlzIGFjdHVhbGx5
IGEgc2VwYXJhdGUgY29udHJvbCBhbmQgZG9lc24ndA0KPiBjb25mbGljdCB3aXRoICJzdGFydCBu
ZXh0IHRyYW5zZmVyIi4NCj4gDQo+IFNvIHlvdSBqdXN0IG5lZWQgdG8gc2V0L3Vuc2V0IHRoZSBw
YXVzZSB1bmRlciBsb2NrLiBBbmQgZG9uJ3QgdG91Y2gNCj4gdGRjLT5kbWFfZGVzYy4gVGhhdCdz
IGl0Lg0KPiANCj4gc3RhdGljIGludCB0ZWdyYV9kbWFfZGV2aWNlX3BhdXNlKHN0cnVjdCBkbWFf
Y2hhbiAqZGMpIHsNCj4gICAgICAgICBzdHJ1Y3QgdGVncmFfZG1hX2NoYW5uZWwgKnRkYyA9IHRv
X3RlZ3JhX2RtYV9jaGFuKGRjKTsNCj4gICAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAg
ICAgICAgIHUzMiB2YWw7DQo+IA0KPiAgICAgICAgIGlmICghdGRjLT50ZG1hLT5jaGlwX2RhdGEt
Pmh3X3N1cHBvcnRfcGF1c2UpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT1NZUzsNCj4g
DQo+ICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJnRkYy0+dmMubG9jaywgZmxhZ3MpOw0KPiAN
Cj4gICAgICAgICB2YWwgPSB0ZGNfcmVhZCh0ZGMsIFRFR1JBX0dQQ0RNQV9DSEFOX0NTUkUpOw0K
PiAgICAgICAgIHZhbCB8PSBURUdSQV9HUENETUFfQ0hBTl9DU1JFX1BBVVNFOw0KPiAgICAgICAg
IHRkY193cml0ZSh0ZGMsIFRFR1JBX0dQQ0RNQV9DSEFOX0NTUkUsIHZhbCk7DQo+IA0KPiAgICAg
ICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnRkYy0+dmMubG9jaywgZmxhZ3MpOw0KPiANCj4g
ICAgICAgICByZXR1cm4gMDsNCj4gfQ0KPiANCj4gc3RhdGljIGludCB0ZWdyYV9kbWFfZGV2aWNl
X3Jlc3VtZShzdHJ1Y3QgZG1hX2NoYW4gKmRjKSB7DQo+ICAgICAgICAgc3RydWN0IHRlZ3JhX2Rt
YV9jaGFubmVsICp0ZGMgPSB0b190ZWdyYV9kbWFfY2hhbihkYyk7DQo+ICAgICAgICAgdW5zaWdu
ZWQgbG9uZyBmbGFnczsNCj4gICAgICAgICB1MzIgdmFsOw0KPiANCj4gICAgICAgICBpZiAoIXRk
Yy0+dGRtYS0+Y2hpcF9kYXRhLT5od19zdXBwb3J0X3BhdXNlKQ0KPiAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FTk9TWVM7DQo+IA0KPiAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZ0ZGMtPnZj
LmxvY2ssIGZsYWdzKTsNCj4gDQo+ICAgICAgICAgdmFsID0gdGRjX3JlYWQodGRjLCBURUdSQV9H
UENETUFfQ0hBTl9DU1JFKTsNCj4gICAgICAgICB2YWwgJj0gflRFR1JBX0dQQ0RNQV9DSEFOX0NT
UkVfUEFVU0U7DQo+ICAgICAgICAgdGRjX3dyaXRlKHRkYywgVEVHUkFfR1BDRE1BX0NIQU5fQ1NS
RSwgdmFsKTsNCj4gDQo+ICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdGRjLT52Yy5s
b2NrLCBmbGFncyk7DQo+IA0KPiAgICAgICAgIHJldHVybiAwOw0KPiB9DQoNClRoZSByZWFzb24g
SSBzZXBhcmF0ZWQgb3V0IHJlZ2lzdGVyIHdyaXRlcyB3YXMgdG8gY29udmVuaWVudGx5IGNhbGwg
dGhvc2UNCmluIGRtYV9zdGFydCgpIGFuZCB0ZXJtaW5hdGVfYWxsKCkuIERvIHlvdSBzZWUgYW55
IGlzc3VlIHRoZXJlPw0KVGhlIHJlY29tbWVuZGVkIHdheSBvZiB0ZXJtaW5hdGluZyBhIHRyYW5z
ZmVyIGluIGJldHdlZW4gaXMgdG8gcGF1c2UNCml0IGJlZm9yZSBkaXNhYmxpbmcgdGhlIGNoYW5u
ZWwuDQoNCmRtYV9kZXNjIGNvdWxkIGJlIE5VTEwgd2hpbGUgdGhlc2UgZnVuY3Rpb25zIGFyZSBj
YWxsZWQuIHBhdXNlKCkgb3INCnJlc3VtZSgpIGlzIHVubmVlZGVkIGlmIHRoZXJlIGlzbid0IGFu
eSB0cmFuc2ZlciBnb2luZyBvbi4gTW9yZW92ZXIsDQppZiB3ZSBhcmUgdG8gY2FsY3VsYXRlIHRo
ZSB4ZmVyX3NpemUsIHRoZSBjaGVjayB3b3VsZCBiZSBtYW5kYXRvcnkuDQoNCkFncmVlIHdpdGgg
dGhlIG90aGVyIGNvbW1lbnRzLg0KDQpUaGFua3MsDQpBa2hpbCANCg==
