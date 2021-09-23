Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC108415ED5
	for <lists+dmaengine@lfdr.de>; Thu, 23 Sep 2021 14:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbhIWMxI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Sep 2021 08:53:08 -0400
Received: from mail-bn8nam11on2076.outbound.protection.outlook.com ([40.107.236.76]:41964
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240787AbhIWMxH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Sep 2021 08:53:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0P/lZfKZW778dbWL6vGAyy8lnVElfCzl5JdbhXuicwvL0KvftbehI20qCSyCb3M7xx1WB2DVQEPs/rVf31K1ZZiUgwS5MeFp5ihx2fbIUVRZBvel3Lo04Mz6UQr9xMtfOAs8bwf5Qgdyv5oV4FZowHs8HUMpGr5KMdRSAQGPDDoFdQg33vvHBDiKypc9fdHzQXIMtYziq/htgpg1FXWcTThIAh3tuEaEa0girmgv7hb45tGfIyNCMmGl+byxU6HFPgVUc+K+ZxFfieB4ZTnRwQrQe5U43xpG+kXfRky2mW7BV/EtnWfArud4gErNwAdWGeJJa6K+Jb8c2X+W1WiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=N4XzooxLohDHpxeJ0caeSKjZi/md52hXyqtqeaMqFIE=;
 b=WE6oqaVtPX3e1324GtWX8ONoX2J2s09Clc0801Vae2AOA2LU2BZWsYyrJXkCqpKdaZXIRH5R39TzTVuTw02SXTYtEmnX2vbvyroKdtjsec4kMa1bc1TUzFE/sasT9elO8iSbfnqq5LYnIQvY4aGjIFCCqqMPJ6taUHzvuQvGPjt6EwhZRCl2WICUUCKrN1WGeSiEpC1LPKUVJ7DdduJ2yWt2Kp0V//vNRRiYp5G8NjVJDUWmxZHuuNh06Z6tJFGd9yjqmfDIU3Y3I11P5UN3DujrhS5b7XwoB24KR6/OHLyDigovQqSMu7Q8DsvChf68iXJVonBwP9FfhktY7n86NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4XzooxLohDHpxeJ0caeSKjZi/md52hXyqtqeaMqFIE=;
 b=e62GstR6MVoSIrH91EImkqqAXiPr/Cn7K65Crxrgu4s75ilkxGlE8QGp8KdVMWJnx7AWtv2EiUYPw1BpZPU1D/IC4mGCYIdr6myvATIlhoSR9R1uzxu0ALNt0PdT55tqE59/acZRlNgObQk/elHOFRmfO8TTC52wnZmNVeWWKEFctjzThtwY+u2qCDkiWZnIOrCPQYaDHcNP+8gtv48kydcZ7TjZB336aj1ZGx0S0et2B8czXW7RIG+oCI+te31rRtW0uDpXQKt3HRo9KG8EdFtDrFuC1mW5hGkIOTPQHKyU9LEaFW6obMOH9NUQ5/UXQL2i7HW2TTgfRHpZ4r2Jew==
Received: from BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 12:51:35 +0000
Received: from BN9PR12MB5273.namprd12.prod.outlook.com
 ([fe80::b54f:5a6c:caf8:7445]) by BN9PR12MB5273.namprd12.prod.outlook.com
 ([fe80::b54f:5a6c:caf8:7445%3]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 12:51:35 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: RE: [PATCH v6 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v6 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHXq84I1y/KN/E0g0SFzWdA4cvLWquoW/uAgAep6BCAAY3LAIAAAzfg
Date:   Thu, 23 Sep 2021 12:51:34 +0000
Message-ID: <BN9PR12MB52731FB8F424A7E92EB8694AC0A39@BN9PR12MB5273.namprd12.prod.outlook.com>
References: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
 <1631887887-18967-3-git-send-email-akhilrajeev@nvidia.com>
 <fe8b4d60-0051-a11a-50e5-c188a9e9b346@nvidia.com>
 <BN9PR12MB5273F667288F7DEE99BA275DC0A29@BN9PR12MB5273.namprd12.prod.outlook.com>
 <5a3de015-a0d1-4440-12d0-06297ac7f9d0@nvidia.com>
In-Reply-To: <5a3de015-a0d1-4440-12d0-06297ac7f9d0@nvidia.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a9fd13d-709c-418d-40d3-08d97e90e01e
x-ms-traffictypediagnostic: BN9PR12MB5131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5131B5AC824952628CB1ED08C0A39@BN9PR12MB5131.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gFmtMSGt/kVnzQyeSvvbjb2Nf7P4ey72N1jVV2WBaml6h3C7GmE2kORCh/9Cf0I8+rS0n50/oMDKPYDLviTD+yJyEl4UUneWTKCSGNLDgVVkPtH76tDybXkd2Ff7N9gYENiMQAE9thtvFfSZURny+xp3cod3Ze8dNc/o7b+z03C19CP39yUSGtZUL9cHUrQXCUvl0oEKgRMBCNoxqmAuf5qAefJAeIHKc8qzZX6VX+r9Z43xRkJ2BDl4IDQ92D4lNfZHY0AmeLANdXRePf9moGhxxQhHwkddLHxBIKOsiMjiLNXuBU8c9xH69ux4oUFqBl4h3WN1qAYnVdNXGQ9r+QLvyYtzAYo+lj8KUZW8qHz7fI2Y5KPC66uo+mH+QEdATWRBshLMhhPsPbpJQJluu8seHD+/9pqcL8DaWVusjm4uX59a68k17xreYGkEQL/IW77tqxtsf/qoJagPZWxQBZtuKfVxmDInHxlxyt/WWgf6IjkY+Uyt53szz6HQY73jAzFodUvIC5EQ3RkkcxLfV3vJKx1spFDIsQ7DSs3JjF7YJQUBtodi4Gy1lkb8wG/iH/3XUadIEVOLiF/ytdH3DHjQzs1q198ewGXr3juSLq9as4X8ok4bDD7shjLcGx2wWPGTEq8X4sJUXp8A2aTMricyQEy4LwomORS5e5v8dhnFl4oj66bmJM7A2js9BVkNLItJA1sFk85TOCYoQQiAPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(86362001)(52536014)(508600001)(316002)(76116006)(38100700002)(26005)(64756008)(9686003)(8936002)(38070700005)(71200400001)(55016002)(7696005)(8676002)(122000001)(186003)(107886003)(6636002)(6862004)(66556008)(66946007)(66476007)(2906002)(33656002)(54906003)(5660300002)(6506007)(53546011)(4326008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0locGpCNEkrZFN6Vm9mTFQxM3NnVVpmaUMvM1dpWG12b0RFY2M2aXArMHJ5?=
 =?utf-8?B?Y1VTZXVuL1B0ajh0K1FBODFHSUFyMlJkcUx6dkZCU01INnh2M3lrZUFPZWpq?=
 =?utf-8?B?cXVqME5FQW85WFNWaUx0b1h4N1pDanA1MG56TUc2UTdPMUNuTEpRME1NN0RX?=
 =?utf-8?B?OUpTMXBpRytBekVOaFRQdDVkK24za29FbUNQSXFHZlkrNDhGbyt0Y3gzMldD?=
 =?utf-8?B?b0RIOEdSN0Npek1RV2tCVmxBZFphZk01bW9VQnZuTlhkN3gzSCthWkJXWUNm?=
 =?utf-8?B?dFE0N1dzVnorb2hEcmlOSFNUVWJOVVZ2VGZGMFdSa2ZxRnUxNUVnR2ZnN1Bi?=
 =?utf-8?B?Y2RaMzVuK3NzT09wQmZWS0xyaEYwdkJJTmVMYWpGaWtRVE8rUkNuSXdDdjJS?=
 =?utf-8?B?YkFBR3d2WXJFUG9hK1ZaZnBETjB1bDNjNFZuN1pENWJFajRRWFhBV1pUS1VR?=
 =?utf-8?B?Tm50enNWaE9ySEROdXVFYnR1eHRyV2pkVVdpNXRVUFdnTE5IQXZxRm9PRnhh?=
 =?utf-8?B?TFJYamZvUTBJeEUzOWg0b2MyRDJ2YjYvU0ViV0JidS9iV1cvQVc1ZTlYeE5L?=
 =?utf-8?B?dk9iMVg3TktZVXhubnVYTnV2bm9Fc2tXWk5FeVN1dHlHeTZYUnRzR0NSb002?=
 =?utf-8?B?M2Q0REMwakRoejJkNHhVR1hYSlZQelZGY2ZyY2NzT2Q0eFdoR2NCVzlGbnY5?=
 =?utf-8?B?MEhCYjE5MmQxTFVuQ3Y5R2V4WXFlV3ZZV0s5eTYxNWw3OU5SU2syOVdJbU5C?=
 =?utf-8?B?UWFyc0pyeEVZYnZPMXpKczNHSzRpYXJicmVYcCszaTFJalI1VmEyN1JyYVFZ?=
 =?utf-8?B?bHRvWk85NXlvd0lPNUFGTWVkYWN6dE5tT3AxUGJkYktWTkNQQ0d4YmZiZWZS?=
 =?utf-8?B?SVUwYVpBNDByVFFuMHlST3NXZGxsVGFEZUZrV0E5OWFlRWp6K2E1UWkwWHp5?=
 =?utf-8?B?bWVTVllsb243QWltTXp5aEdScEtPVU5IdWtXVGFVSWlZWUZGK1RuYzZ2aSt4?=
 =?utf-8?B?RExjQXdaZytsMDZnaVprclU3NE1PZGRsZTYrUnN3ZExUOUF1VGFLcW0zdnp3?=
 =?utf-8?B?S3RHcjlxazZQOElHdnNxeHp4SmJ2NDVzNHBxS3BNU1ZuNzc1MEFZRURheXc3?=
 =?utf-8?B?ZTI5MUx3Z2pMMjE5QThtcFdMZ0tQL0UvcUNpUGNKWU92dlNpM1VSNHZYdHEz?=
 =?utf-8?B?UTRLd3hJbGdXYmdFU1pOZGY3S2xPSjViNUVZMklNWXM5WDNUbmZTSjdaWDU4?=
 =?utf-8?B?cElDQ1JSYTJXNlV6R0lCZ3BpNEQ4MjMvWHdOVDQvZ0hmQkxHeVlmZzlSOXZF?=
 =?utf-8?B?ZndSYWsrUzhGaDhSOHJzK2pyb3orWjJoSzJlZXFGMXlYc2Y3Y0JUd1g5NHM5?=
 =?utf-8?B?NmdVMS93UHIvSUFsaEN3ZllHcTNhQlpSNVpsaDNtdHJvcUl3M1pqNmZpVVRu?=
 =?utf-8?B?TUJXRzRjWEg1Mnc1UEx5OXVzekYvTmtjRjZ2bGxvbGdyc3puL2JYZlphaUU2?=
 =?utf-8?B?ZlRhZjZpSEtid3ZuL2lLdnlNTHVJVkplK2RSQ2FyQmVnNEt6Z0M5NFlCdDVr?=
 =?utf-8?B?M3FMTkZZRkQxQmFScCtxeEVCbFhab3d4WTdBWnlwSlBQWERPOXd3YjFTOTlG?=
 =?utf-8?B?U0NEcmpRZmFPQ3VPdXZ5ZmxlSW1IT29SVGNJelRHM081YmxkNmk3YUE1M0oz?=
 =?utf-8?B?SXplbUxuOW1hK1IwY2F5WHdKL2VOdGJHT0psbGRCWGdpaWcvSHY2NzRpM3FP?=
 =?utf-8?Q?i7wHa9jPbekeMkHGDHJJaAIs0FoUBjuvp+ZFNRL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5273.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9fd13d-709c-418d-40d3-08d97e90e01e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 12:51:34.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T30pL92NUo8SAz2zMZjSwF9NBTP6/N4mK2IOzXtuDnf9F+sb5XC9CteZFjAkYnlt/bI1xVBUFGsIojZs4xT1zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBPbiAyMi8wOS8yMDIxIDE1OjQ2LCBBa2hpbCBSIHdyb3RlOg0KPiA+DQo+ID4+IE9uIDE3LzA5
LzIwMjEgMTU6MTEsIEFraGlsIFIgd3JvdGU6DQo+ID4+PiArc3RhdGljIGludCB0ZWdyYV9kbWFf
c2xhdmVfY29uZmlnKHN0cnVjdCBkbWFfY2hhbiAqZGMsDQo+ID4+PiArCQkJCSAgc3RydWN0IGRt
YV9zbGF2ZV9jb25maWcgKnNjb25maWcpIHsNCj4gPj4+ICsJc3RydWN0IHRlZ3JhX2RtYV9jaGFu
bmVsICp0ZGMgPSB0b190ZWdyYV9kbWFfY2hhbihkYyk7DQo+ID4+PiArDQo+ID4+PiArCWlmICh0
ZGMtPmRtYV9kZXNjKSB7DQo+ID4+PiArCQlkZXZfZXJyKHRkYzJkZXYodGRjKSwgIkNvbmZpZ3Vy
YXRpb24gbm90IGFsbG93ZWRcbiIpOw0KPiA+Pj4gKwkJcmV0dXJuIC1FQlVTWTsNCj4gPj4+ICsJ
fQ0KPiA+Pj4gKw0KPiA+Pj4gKwltZW1jcHkoJnRkYy0+ZG1hX3Njb25maWcsIHNjb25maWcsIHNp
emVvZigqc2NvbmZpZykpOw0KPiA+Pj4gKwlpZiAodGRjLT5zbGF2ZV9pZCA9PSAtMSkNCj4gPj4+
ICsJCXRkYy0+c2xhdmVfaWQgPSBzY29uZmlnLT5zbGF2ZV9pZDsNCj4gPj4+ICsNCj4gPj4+ICsJ
dGRjLT5jb25maWdfaW5pdCA9IHRydWU7DQo+ID4+PiArCXJldHVybiAwOw0KPiA+Pj4gK30NCj4g
Pj4NCj4gPj4gU28geW91IGhhdmUgYSBmdW5jdGlvbiB0byByZXNlcnZlIGEgc2xhdmUgSUQsIGJ1
dCB5b3UgZG9uJ3QgY2hlY2sNCj4gPj4gaGVyZSBpZiBpdCBpcyBhbHJlYWR5IHJlc2VydmVkLg0K
PiA+IHNsYXZlLWlkIGlzIHJlc2VydmVkIGNvbnNpZGVyaW5nIHRoZSBkaXJlY3Rpb24gYXMgd2Vs
bC4NCj4gPiAnZGlyZWN0aW9uJyBpcyBhdmFpbGFibGUgb25seSBkdXJpbmcgcHJlcF9zbGF2ZV9z
ZyBmdW5jdGlvbiwgSSBndWVzcy4NCj4gDQo+IFNvcnJ5IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0
IHlvdSBtZWFuIGJ5IHRoYXQuDQpJIG1lYW4sIGl0IHdvdWxkIG5vdCBiZSBwb3NzaWJsZSB0byBj
aGVjayBpZiB0aGUgc2lkIGlzIGluIHVzZSB3aXRob3V0IGtub3dpbmcNCmlmIHRoZSBkaXJlY3Rp
b24gaXMgTUVNX1RPX0RFViBvciBERVZfVE9fTUVNLiBUaGUgYml0bWFzayB0byBjaGVjayB0aGUN
CnNpZCByZXNlcnZhdGlvbiBpcyBzZXBhcmF0ZSBmb3IgTUVNX1RPX0RFViBhbmQgREVWX1RPX01F
TS4gDQpUbyBnZXQgdGhlIGRpcmVjdGlvbiBwYXJhbWV0ZXIsIHdlIHdvdWxkIG5lZWQgdG8gd2Fp
dCB0aWxsIGRtYV9wcmVwX3NsYXZlX3NnDQppcyBjYWxsZWQsIEkgZ3Vlc3MuIEkgc2F3IGluIHRo
ZSBkb2N1bWVudGF0aW9uIHRoYXQgdGhlICdkaXJlY3Rpb24nIGVsZW1lbnQgaW4gDQpkbWFfc2xh
dmVfY29uZmlnIHN0cnVjdCBpcyBkZXByZWNhdGVkIGFuZCBzaG91bGQgdXNlIHRoZSB2YWx1ZSBw
YXNzZWQgdG8NCmRtYV9wcmVwX3NsYXZlX3NnKCkuDQoNClJlZ2FyZHMsDQpBa2hpbA0KDQotLQ0K
bnZwdWJsaWMNCg==
