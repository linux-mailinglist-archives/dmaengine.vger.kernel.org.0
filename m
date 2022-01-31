Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E624A3F0E
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jan 2022 10:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiAaJJZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jan 2022 04:09:25 -0500
Received: from mail-dm6nam11on2056.outbound.protection.outlook.com ([40.107.223.56]:23840
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234358AbiAaJJX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Jan 2022 04:09:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/zrtG+aRMWRykM/mLzv91/VjP5Dos9+SDU+yL6qI4zw4kQtc+5Mm8SMuqAnpFyo4Al4jpJfodo8IxlX6K7SAAFqrDW9jruIw32Z3BnZjDsK0+/abwqKEWIGKBtoXDhSk3z2aP1FEIOvl8Eq7yZeLBzYh76QlpEKHgP2YwHlWY8ZFE0LuiRxdGxHEvlot6/61XxWVUrab7z6O5Cj9foobE+FnfYLyorQ+Lu+kJa0lktkw48ek41wgEBqTpk5/e+sIE7Vr8Euk0pIhDao/GY4rJcpEeuWsKBpiuE8ap2IPZwPrZUFLATkDnhkG+Bu7QhtTD1hmKRA6x7FF7Gdw4EL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyBSqI1ypmD/MJtu1nwNDJuAveK+bqgqyVihm8Fa/9I=;
 b=h2CxOvuYUXc9KdWUiEkrsHYRQ9cjYsou6r7UEbOK4Dmu/74+9euIromLhP8Y34OuKoJewqZiOO0AJozYoPkT9ajiVuFw2vph3yA5KSeF9BzWDyhOvHjcCkB7S4G9mpUCHXUlM4RmZyPFIlCleD2Xv1diAhtVsBaEeGhhEtSLVyXwvo0NKZYkNtXy46EM1WeYyMFFzFj5esyVFOukJAt4GLzqJDFAjcz2cxYArl+6WzXvjT9Hh9SPfz9TrHDJQrsMCNQ0FS4eyT9Mx6HxGIMtk0ED1kONQSPDSxx5ikEocMuTkuvNOGFttNstJZFZOikSrIFtU6pUIjAsZuQv981BFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyBSqI1ypmD/MJtu1nwNDJuAveK+bqgqyVihm8Fa/9I=;
 b=dzMf3PMBCm+xMVEIin78p3jYdBGf4mf+3w3crXXgewBbV5oRtUwl4lmRyXRlUHygkmqabokgh0//47uXbM45ON+lQLinNW691iLBY2Up2cbIvj3GYkWzAjH6UJ73H794SmOLSMJomiJI5ZzQp1ymGDJVeNQ9k292NHsImBQcsTcJUl+Z5csLZHIcloSHx/42Oz6DdtSaGQqpQiAyD5cCQIZir0KVr4N0nHULyGyQCpnLWs+FpKvn+YaEPtl26XrtHno7c15o8II0ERWKzpEqf5vLFtG2cDsKrVwKM5Irsomj8ImA8fQsQlaXez6ywNEACHRrCbzrkzMWlS6klKqXqQ==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by BN8PR12MB2883.namprd12.prod.outlook.com (2603:10b6:408:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 09:09:21 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133%4]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 09:09:21 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: RE: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHYFS8ttZm9vnsYMkmLjfwGSkse9qx7V3sAgABn8UCAAHOwgIAAU3IwgAAqZYCAACYYkA==
Date:   Mon, 31 Jan 2022 09:09:21 +0000
Message-ID: <DM5PR12MB1850D677140466EC74C621A4C0259@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
        <1643474453-32619-3-git-send-email-akhilrajeev@nvidia.com>
        <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
        <DM5PR12MB1850D836ACDF95008EF74CC7C0249@DM5PR12MB1850.namprd12.prod.outlook.com>
        <08f6571e-af75-b6b3-443e-e86e3bdb365b@gmail.com>
        <DM5PR12MB1850FD5F3EF5CBFEA97B3611C0259@DM5PR12MB1850.namprd12.prod.outlook.com>
 <20220131094205.73f5f8c3@dimatab>
In-Reply-To: <20220131094205.73f5f8c3@dimatab>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ba9a74a-c804-4921-0015-08d9e4995e76
x-ms-traffictypediagnostic: BN8PR12MB2883:EE_
x-microsoft-antispam-prvs: <BN8PR12MB28831EA83A8E9ED84F601549C0259@BN8PR12MB2883.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k6YDUlAOzBDIJiWTWWCGJ0p1yM56Xpqx1Rt76B+staCqHcZRnGkfvCwx/ot2xTpp8zJhjNYpDImuEdj54MipqV1tjoSbcvM5FkCZRbP+aI3UhiUmqfTpvRGJ4HyYm6ZS3arP1dFYXxiREne6/T2/u7+aVC6BlI4RWXz4ZnMH3BeJPIY6I8xO7glu6QQaafkAlKzGt5SPmiI+wisv/N5IfqeeR+qjVcxxct9Gy1NTFPdbKRYttOA2aEEBA9J2SNEKb4ZJUFhJFxRPd5EpColURLXCqEIGjIPlG3gJApMOHEVFIAUDVT3BuPCbqHUa4kQhwhcWk+5iqBc3IjWvB2CvkO9WT/QDNIxt0vFpfFh8g6PFvjQ02muuUxjucBLJRvsLLOZO1viHxj/qN1I0tdLR9T6VM3QpRiM0auGQ0G7iBiowQv0aFUL/A+G2Ymuz7QBPVyu2JsLlL9f84C9fgVjapnvcA9FBpsHmyQCjXkKBWrEZe7oTFPMTixn9EpZZPIpj5sX1tDPwEXMAxORdV6M/i7fiOY2M8gzKcs0jK9v1M31BXYGVFbiGhzqHr8iYylBsx0fOtrB5yKOgzx2f5j6ZpVuNfqvnx9GITXlHdSEtWQMullv5tELhV1e/4XYlH2NBLsEctgA0jFbUpI0tH/BqqTev1W9SSsPKwgBr3oms8bpeaZecARIt/hHAcaToI+XTXnZMw7fRQXjmcKCYfZWNOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(4326008)(8676002)(86362001)(107886003)(83380400001)(55016003)(66556008)(8936002)(66946007)(38100700002)(66476007)(122000001)(66446008)(38070700005)(64756008)(6916009)(76116006)(54906003)(6506007)(7696005)(52536014)(9686003)(55236004)(33656002)(316002)(508600001)(26005)(5660300002)(71200400001)(186003)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm1TN256QzhqYUpwaGdvVGZHZGhWaDJqalN5ZkNwRkpIbWR0aGRsSE1pdjc3?=
 =?utf-8?B?NTJUVVRGUnJzUURWV0h3VVRqN29RczNubHgrbXRaenQ0NFg5WGlWWWREb29o?=
 =?utf-8?B?MGp5UjFGVU9ZeU8zOXpPTU84V2VaVmt2NVJQcSswcEJHb0FtVkxHdUFNRG5J?=
 =?utf-8?B?U2cwUWQxckJCampSRVRJZkxpRjZwNUQ4dTBVbmlkaWw4bmx5Y1FrQ2paSC9R?=
 =?utf-8?B?NVAvdlFhRUFHMHdvdlhHQS9HZjBubGZQR3pwdkh3YVhsN0kyOGJaN2VkclBw?=
 =?utf-8?B?YmU0VjdXZlIxdjBmTlFVdnV1NlN0OGFJb2VtVGxlS2RLbjhWd3g0bEFYeHhG?=
 =?utf-8?B?L0g3bkJPS1lNaWdRdnBBQ3lDRDl0WXM4aHJvalZKRkRjNmx2NjZIYzhXRjlM?=
 =?utf-8?B?cUhkWWRHRFpVQmJOZVdWUkNBZi9PUWVrYjg1amVPci9MVy9rMHlieWxGNm1l?=
 =?utf-8?B?cnZ1S1Uvdk5KNFA4NUY4VXBvbVNXc09xSFh4cWZmbWloOWtlS1VnSWsvZS9y?=
 =?utf-8?B?RStwaEZrSmloOVpIby9zUVZZS3QzMGhPK0pzdDdWcGtoMWtxaGVlS1RxclY5?=
 =?utf-8?B?RUw0cDc5TWpreWZLdzhkNmZWNVF2SDJrd3VvdVBTeG1IYXM1eUFNRkZXQVY1?=
 =?utf-8?B?V2IrenZHNXNMekVFanZzYnIyK0xtRDF6Q0xwaXM5THhsVktYaDVkQU5manU2?=
 =?utf-8?B?aVBacXBBUEhadXRFOXM0STJlNWdjeWV6dzE0VkszeFVzZUg2am5wRzA1Nnlh?=
 =?utf-8?B?SUFpRzFFVFd1bWUwY1ovbHdJZkRZSVFHaU9ETmwveDRreUdqRlM5N0dSa3pH?=
 =?utf-8?B?Nnk3U1RwSzJIYTJNcFAxNG9tWWpIUXFSeHhlcldWd08yWW5ZblJVRWowWXJk?=
 =?utf-8?B?N295MHFpcjhkOW8rK2NDc3dRMURMZWNmdnZWVllZSnl2Z3FsRlVzb0YzTW4z?=
 =?utf-8?B?dGt6TC94SUREb0s3UlNvY1BGeTdDNGhZYjlFd29qU0F5ZTRibXlzaU1pakFt?=
 =?utf-8?B?aXREL0tKT1lOY2ZQWEJ0cFg1aEtOYkcyQjhPK3NBTGJZYVFTaHorTE96Wk5s?=
 =?utf-8?B?TWZWMmplOEVRVE9IakN0OXY2NXhkNzhLbWZXMmZUK2tkL0E3NXJkT3dyQkFJ?=
 =?utf-8?B?a0l2ckV2cWkyRllTN0g3eVVHN21RMmpoQXVrQ2ozMDFuTjBZUHFhVlBHVHk3?=
 =?utf-8?B?akpiTVVLUVRuVG9xV3pQYTZEUUhhdUlBNnA3MDlIL0ZpUkN0R09CN2FKVFdI?=
 =?utf-8?B?UFJzUk5BQnV0d3ZRbmxjM2RwdTU5cUNXeTZEaXlXYnpxUC9kdDNUa1dUZ2xP?=
 =?utf-8?B?ZmN4eFZQSGFvUDBtb2pUQVZPb2ZTWm1lNzg4NXl1cURsaG8rRnR1amtqaXBw?=
 =?utf-8?B?ekpSNWJtVEs0UDVJWlEyR0R1M3AxUW50NWdkSDlKWUpaNGc1M0o3TmJjdHVE?=
 =?utf-8?B?SWJQVWFpWER2UHpjVUxWcit3N3ltWnQwWUEvdWgvYUNtakh4b2x5QTI5RjY0?=
 =?utf-8?B?TkpLVUVEMWpUZFovZ3I4VVZ3enFxdTJBMjk4ajNRTzc1NUc3SmZvUVdrN3FK?=
 =?utf-8?B?Y3BNZ1MwREJwb3pOM3BETDBLZTl3azZxMzBneVdlMHlXaHBrNkJwVGJ5a3NR?=
 =?utf-8?B?QTJubFJGZ2tuR3JsbTloYWg3eUZBQVhUSWpLNGlwM1Y1NkFQYzFVZHlVOXRI?=
 =?utf-8?B?L2hCNUpwYUZTTlZiODBta1YxTmwvbDJ5OWwyS0NjRHJoTXJqUEdKa1p2bTJx?=
 =?utf-8?B?RjFwK0w4cU1KOGc0b01JSFppalN0a0FIRTMzRHJGRFllbXNQTFdVQnFlbnBL?=
 =?utf-8?B?bHBDZE9VNlV6UWcyNEtnZFF6UjBqUWxDMnQwUzVJbGpkMnQ3SFNvLytTM1E2?=
 =?utf-8?B?R295Ulo3S1F0a2c0VFp6VjJJOGIzdTUxN0h6YlBiK1ovNTlCd3labTdoT25C?=
 =?utf-8?B?bjFLbnN0L0czclJFc2ZEM1puc2NiTGw0RDZuZFRoQzA0WThoTlczZUh5MzFH?=
 =?utf-8?B?aDV3SGtkak1nWUxYaWxXRG9EUGplSjhmMzhYRXZMQUZkandzMXhtWll6NDIr?=
 =?utf-8?B?UVp6UVg2NjUyZVNvM3hJZjdKMk1BdS8vTWg5dGxrVU5xdE5PaTNWL0VheUpY?=
 =?utf-8?B?NHlXdXBvT281Mkdibi9VNDlRSE51dmZOVmFuM2hsbThTaG5tbGFNQkNjWnla?=
 =?utf-8?Q?DVcv3R6XmJAdiKDjDa1PzXw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba9a74a-c804-4921-0015-08d9e4995e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 09:09:21.3681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lMUahcD6l2zlH9T7OVjl+ll8JuzzXBaitNPeGxrmgR+VJl9mND3g2W68P1f/kdK+lXHkM1WvBImbdfRVM6ouw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2883
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiDQkiBNb24sIDMxIEphbiAyMDIyIDA0OjI1OjE0ICswMDAwDQo+IEFraGlsIFIgPGFraGlscmFq
ZWV2QG52aWRpYS5jb20+INC/0LjRiNC10YI6DQo+IA0KPiA+ID4gMzAuMDEuMjAyMiAxOTozNCwg
QWtoaWwgUiDQv9C40YjQtdGCOg0KPiA+ID4gPj4gMjkuMDEuMjAyMiAxOTo0MCwgQWtoaWwgUiDQ
v9C40YjQtdGCOg0KPiA+ID4gPj4+ICtzdGF0aWMgaW50IHRlZ3JhX2RtYV9kZXZpY2VfcGF1c2Uo
c3RydWN0IGRtYV9jaGFuICpkYykgew0KPiA+ID4gPj4+ICsgICAgIHN0cnVjdCB0ZWdyYV9kbWFf
Y2hhbm5lbCAqdGRjID0gdG9fdGVncmFfZG1hX2NoYW4oZGMpOw0KPiA+ID4gPj4+ICsgICAgIHVu
c2lnbmVkIGxvbmcgd2NvdW50LCBmbGFnczsNCj4gPiA+ID4+PiArICAgICBpbnQgcmV0ID0gMDsN
Cj4gPiA+ID4+PiArDQo+ID4gPiA+Pj4gKyAgICAgaWYgKCF0ZGMtPnRkbWEtPmNoaXBfZGF0YS0+
aHdfc3VwcG9ydF9wYXVzZSkNCj4gPiA+ID4+PiArICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+
ID4gPj4NCj4gPiA+ID4+IEl0J3Mgd3JvbmcgdG8gcmV0dXJuIHplcm8gaWYgcGF1c2UgdW5zdXBw
b3J0ZWQsIHBsZWFzZSBzZWUgd2hhdA0KPiA+ID4gPj4gZG1hZW5naW5lX3BhdXNlKCkgcmV0dXJu
cy4NCj4gPiA+ID4+DQo+ID4gPiA+Pj4gKw0KPiA+ID4gPj4+ICsgICAgIHNwaW5fbG9ja19pcnFz
YXZlKCZ0ZGMtPnZjLmxvY2ssIGZsYWdzKTsNCj4gPiA+ID4+PiArICAgICBpZiAoIXRkYy0+ZG1h
X2Rlc2MpDQo+ID4gPiA+Pj4gKyAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiA+ID4+PiArDQo+
ID4gPiA+Pj4gKyAgICAgcmV0ID0gdGVncmFfZG1hX3BhdXNlKHRkYyk7DQo+ID4gPiA+Pj4gKyAg
ICAgaWYgKHJldCkgew0KPiA+ID4gPj4+ICsgICAgICAgICAgICAgZGV2X2Vycih0ZGMyZGV2KHRk
YyksICJETUEgcGF1c2UgdGltZWQgb3V0XG4iKTsNCj4gPiA+ID4+PiArICAgICAgICAgICAgIGdv
dG8gb3V0Ow0KPiA+ID4gPj4+ICsgICAgIH0NCj4gPiA+ID4+PiArDQo+ID4gPiA+Pj4gKyAgICAg
d2NvdW50ID0gdGRjX3JlYWQodGRjLCBURUdSQV9HUENETUFfQ0hBTl9YRkVSX0NPVU5UKTsNCj4g
PiA+ID4+PiArICAgICB0ZGMtPmRtYV9kZXNjLT5ieXRlc194ZmVyICs9DQo+ID4gPiA+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgIHRkYy0+ZG1hX2Rlc2MtPmJ5dGVzX3JlcSAtICh3Y291bnQgKiA0
KTsNCj4gPiA+ID4+DQo+ID4gPiA+PiBXaHkgdHJhbnNmZXIgaXMgYWNjdW11bGF0ZWQ/DQo+ID4g
PiA+Pg0KPiA+ID4gPj4gV2h5IGRvIHlvdSBuZWVkIHRvIHVwZGF0ZSB4ZmVyIHNpemUgYXQgYWxs
IG9uIHBhdXNlPw0KPiA+ID4gPg0KPiA+ID4gPiBJIHdpbGwgdmVyaWZ5IHRoZSBjYWxjdWxhdGlv
bi4gVGhpcyBsb29rcyBjb3JyZWN0IG9ubHkgZm9yIHNpbmdsZQ0KPiA+ID4gPiBzZyB0cmFuc2Fj
dGlvbi4NCj4gPiA+ID4NCj4gPiA+ID4gVXBkYXRpbmcgeGZlcl9zaXplIGlzIGFkZGVkIHRvIHN1
cHBvcnQgZHJpdmVycyB3aGljaCBwYXVzZSB0aGUNCj4gPiA+ID4gdHJhbnNhY3Rpb24gYW5kIHJl
YWQgdGhlIHN0YXR1cyBiZWZvcmUgdGVybWluYXRpbmcuDQo+ID4gPiA+IEVnLg0KPiA+ID4NCj4g
PiA+IFdoeSB5b3UgY291bGRuJ3QgdXBkYXRlIHRoZSBzdGF0dXMgaW4gdGVncmFfZG1hX3Rlcm1p
bmF0ZV9hbGwoKT8NCj4gPiBJcyBpdCB1c2VmdWwgdG8gdXBkYXRlIHRoZSBzdGF0dXMgaW4gdGVy
bWluYXRlX2FsbCgpPyBJIGFzc3VtZSB0aGUNCj4gPiBkZXNjcmlwdG9yIElzIGZyZWVkIGluIHZj
aGFuX2RtYV9kZXNjX2ZyZWVfbGlzdCgpIG9yIGFtIEkgZ2V0dGluZyBpdA0KPiA+IHdyb25nPw0K
PiANCj4gWWVzLCBpdCdzIG5vdCB1c2VmdWwuIFRoZW4geW91IG9ubHkgbmVlZCB0byBmaXggdGhl
IHR4X3N0YXR1cygpIGFuZA0KPiBkb24ndCB0b3VjaCBkbWFfZGVzYyBvbiBwYXVzZS4NCklmIHRo
ZSBieXRlc194ZmVyIGlzIHVwZGF0ZWQgaW4gdHhfc3RhdHVzKCksIEkgc3VwcG9zZSANCkRNQV9S
RVNJRFVFX0dSQU5VTEFSSVRZX0JVUlNUIGNhbiBiZSBrZXB0IGFzIGlzLCBjb3JyZWN0Pw0KDQpU
aGFua3MsDQpBa2hpbCANCg==
