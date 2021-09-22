Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78690414C56
	for <lists+dmaengine@lfdr.de>; Wed, 22 Sep 2021 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhIVOsW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Sep 2021 10:48:22 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:53600
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236199AbhIVOsW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 Sep 2021 10:48:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzdSxQm1Wkl8+GG+mELxV3rLcgZDfiblTnXL9y812Qo7XJ8xE+jKk4DEaxvwRAD6RQJ5BeYwhh3tfe8JOlJDxYjLy4VQp+3Ex5D1kMt/ORUK3vjblf+c+XMD8NaaMr0N78Rj7Xm9n5aJfOUAaadVP75HZzmaKAKqZFajyFGg3aFkmzt8a5BXn/tql4C1wD6R/qiSuXL2qA/TNTvIvQw+RSPUr2TmHiTPSgGBioOtLX+4drhn5wKmi5qeEfV/RMKGi9hg7SX9KFbPeNr5OQd0NfcxnlpaNSdW4UzzJAqbpEbcQg6q8Fs5f0dFQCP/Ot0D7A7m32YLjKxjF8FpWjRZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Fv0F4RdQLwOyLPpl0c0t1gdNR9HgcOmZj73BzhnR8sc=;
 b=LJtWAuktDo5kP9fOyUY8Sx0hSauLbKWlg47gsWZ8Gjgs8lHcQLQfY0xwUiItMv/wCsPedSdVzF3C2wnNBBtlAWBkSMLaVaYmQ4PDrKy/IPVYcUpzXPc0lWhxZmiy6Ep0wb+6aIMahkVnS/pfiPbbImcupFCXyICE54i5jv/8rdbbw1jbbTL4YYPg3otNZiwn0dXQSD0He+vg77whNwiES2lRzP/tf9sxOr+our027oqQolJoK6emX6aQK/ulUU0C5DJmz6r1b/ilQhrVb8hV3W2f5mieOe4TxIxjCtiW3tcUChy84c3WgAy58PneOSP0cTXawWn3Pwy0dJmqTcMCeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv0F4RdQLwOyLPpl0c0t1gdNR9HgcOmZj73BzhnR8sc=;
 b=qPEzO9bvw7S1E9fwdXbWIu8ELtdgl6elvJrSfKFnMZ9zNyses3bX/8YK4aIXRWyKA2osYdUtb0xWmWv6U22yDcHk4TEOpzG/rjOLQBrKSn9LjkL03Cv98W6775NxVRIDabQl/u4TAzXqHFRR3oW7Hy3bVfQRlpVffHuiw0zZxRJ+RH82CmYET8JCjSrfVrb4lGckOhuGoC3FbflzlC3FqysqRIL6hZgS6bdyztNJ9TO/CuOD12RxtQQdtVuHo1TMb6NkY5gm5oHKNHioqF0g/cFQMWAKVQI3rMfyGRcKdWnrAocoCTqW/RxpsyWD00OnZ2uB6RoLmdZVOagWkNg3Tw==
Received: from BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22)
 by BN9PR12MB5065.namprd12.prod.outlook.com (2603:10b6:408:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 14:46:50 +0000
Received: from BN9PR12MB5273.namprd12.prod.outlook.com
 ([fe80::b54f:5a6c:caf8:7445]) by BN9PR12MB5273.namprd12.prod.outlook.com
 ([fe80::b54f:5a6c:caf8:7445%3]) with mapi id 15.20.4544.014; Wed, 22 Sep 2021
 14:46:50 +0000
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
Thread-Index: AQHXq84I1y/KN/E0g0SFzWdA4cvLWquoW/uAgAep6BA=
Date:   Wed, 22 Sep 2021 14:46:50 +0000
Message-ID: <BN9PR12MB5273F667288F7DEE99BA275DC0A29@BN9PR12MB5273.namprd12.prod.outlook.com>
References: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
 <1631887887-18967-3-git-send-email-akhilrajeev@nvidia.com>
 <fe8b4d60-0051-a11a-50e5-c188a9e9b346@nvidia.com>
In-Reply-To: <fe8b4d60-0051-a11a-50e5-c188a9e9b346@nvidia.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5428adf-8036-4be9-2613-08d97dd7cfd7
x-ms-traffictypediagnostic: BN9PR12MB5065:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB50656B04EBEFBADA1845A638C0A29@BN9PR12MB5065.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s7AdOPbbkMM7zuo2WJ3jeUa1dvQHY7w2RBMhB0CiHJkHJ7GYFWWeM3vAlofk9wxmqhgGCMUrJafx4EnLz9Lc7+X1efOck3/t3Nm6E94GX7CgbVl2uV57YFa9JYkxKlF1hwQx6q60J+07TGDAcQWOIl+aRzXCBavIVvEbXmE9AXknQh21qn6zwjDWpEOYFDoPVpT68lnB54I1L6+YnvIUYEzmIwZuF1w+U/EsS8BcLrePFfXOBkEK3ZYyqgpwaRfmIXdMyiJF1x6IMMdl9I/ZYBSCt/a1PhnK3lLQBUzVavVC52ED15dqJeXcWZ14VEdlYb6GGBhz4H9Zpn1Py0qZOfyPX/DV9UdczbCO/Xt/P7tFMb8EgVBIYEoN8jsoSpUalEO8lCIzmCyngnHZ9N9QB0APEfvzj3gaz6gvLqug6pS7TULgmtIH9OEPEZ5VF9bbLbee9W3o90fwc42IWQPRWClz0x7xSE4t5q8uL7oPrP7tghuGYNMQ78BiVv7u80UWxLL7cnrFc3s6vVjG+Lh9ZQ/5OWgoRCgQVODTKvTmQUN0HPhSBEp91MorPd6k+cfItIaIIP2qVrqf3RM5zlPTO2VKkq+0Lnby2xb4Yc1r1MPee/sIX3NtP+lPjtSncw3PvkQhex3WdQ9ThGN0N/Hn/8afg8YLEjRo30dBm2NVi6NGXcjG5zPh/bEZqucC9aJIXefAGUFJffskxsBDWv0VsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(33656002)(6636002)(52536014)(2906002)(55016002)(122000001)(26005)(9686003)(38100700002)(186003)(76116006)(7696005)(508600001)(66946007)(6862004)(66446008)(66556008)(316002)(66476007)(64756008)(54906003)(38070700005)(8676002)(6506007)(107886003)(83380400001)(71200400001)(8936002)(53546011)(4326008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlZicm00OGo3dHZUdHJuZUhCWjRIMzVtL2UyMTloa0RGT2F2TFpwbmdObWph?=
 =?utf-8?B?RWxGL0g4S1djZTgvd20ySjB1VWxMWUNNZXJ5d0RsdU44ZllwaGVLSHl2Tk4v?=
 =?utf-8?B?Z3pzY3k0aEdybjJXT0hyNzJHcVZqVE9YWVpuN2R5bWFGdGJpbGUvV3FQM3dG?=
 =?utf-8?B?YlVObXl4clNtTnJkWWpBVFFXY25qOHBrbzR2YkR0aDkvSFlMby9sbExlWjcw?=
 =?utf-8?B?Z2lubDF1THpnR201d29CeWtzR2NxQUZkRWM2c1JaYm52RnBBM1NkNnBFQkZI?=
 =?utf-8?B?SWl6eHZ4blpOWTgrT1U0bTBFMmpRd0JnYUtaQVpjckNZaHZiSFlETm1tNTA5?=
 =?utf-8?B?WEtiOTBqR0RXemh1YnAzdFVkZGZWMW1wQ2JmaGMvQXZWSC9CN0NTUlpWMk5v?=
 =?utf-8?B?d0EvRVp0VGhTdmtCYmFCS2RidzJ4ZWMvSk5uS3F3NEtNTE1Pb3h1d1lVVlY2?=
 =?utf-8?B?WnlJM0ZiTDVWdEJMcDQ5TUl3V1JEdm5yUUxGUCtBZk51bURmSUxhQSs0MHlY?=
 =?utf-8?B?WnhpU0lJdTdhS3NnaGdZY1hKRldEenhwY1I1ekVOSGtnVEtYV3JpalZVN3hj?=
 =?utf-8?B?RExOaWgzWUw2c1VrWkVIWmZPYWk2aVJ2NS9sbUVmc05zRlJZR01CbExYTnBU?=
 =?utf-8?B?K05HbWZsVXlJQlJ5ZzFpMWQ1NHdXTm5vemVqOGs3WFZRb1VPN1FHLzFPVDFF?=
 =?utf-8?B?TFFzR091QXR1Zko0a0toY241SWlGRW11K0JQSHd1djNGb2lZelNWMTIxRUhN?=
 =?utf-8?B?WkZNenZGdEFYaVhKcUpGRzlGSkZPc3dWV0VRUGdkcThuaGtrREtNWG5lZWhK?=
 =?utf-8?B?S0Y3emtsQWsvcm5qdkt3c3daNkY1UlF1djlyZXk3QzZHN3hlbG9aTzkxSDdt?=
 =?utf-8?B?aitXSDZxek4vbTI5R2lnK2RJYmN5bHFwREFEVEptbmhmdWxWdTlETDd0VXNU?=
 =?utf-8?B?MWY2QytsajJjMUNzVlg0a3hvNFF5WEpFSlRXWW9MQkpZV0V5ZmRKMnlhcW5X?=
 =?utf-8?B?ZFcwNU5RSVpBN3RLSENqME9FNDFzU1ZJWmNzc1dGaEFiR2EvTGNQeUI0a25F?=
 =?utf-8?B?cU1ISUVycVRCVzAybkJmd1NvY3psVjEraVlWWExkeElScmtyMWpIb0pHMzBo?=
 =?utf-8?B?QkRnOEtXbm5zVHlvNnJqbUQvUFVVbDF4ZGhuMHppNzZHOWJvWG1VTmhHTCtM?=
 =?utf-8?B?S1FJbGw0cUdnbGNJN3lvRDJHUWNUK2JGUWFxQnA3VUZyYTFPUHlNQURSQVFi?=
 =?utf-8?B?YVlUNVduMjZKME9Tb2w3a1VKbEhLQlpwaUJJdVgrSkVaTGF6UzNNdWZHdXll?=
 =?utf-8?B?dlV3SDgvcFBCZHJ2RWl5MzV6VGI4a0k5VWFkc1lTTFZaSmhyaUhHQnRWR3Ju?=
 =?utf-8?B?T2FxcncrYWorOTRWRFVPbmdldjZ5VU5YQm5ncSs1L3RpSmRoZ0NTb21YYjZK?=
 =?utf-8?B?VlJneGZTUmdOdFdod0p2Q2t2Vm9pSEJBQTdoM2s1bGcyTFllSUw0WkVYV09P?=
 =?utf-8?B?ODY0YkJJVDlqbk50WFJZMWpzTzJHT1B1Ny93ZVJ4WE0yekhkTlBqNVVPcUo1?=
 =?utf-8?B?N1FyZE0zL3JFUUMydlh1RTFrUS9WclcxT2MxWWJ6WFV1TjNEQTdnYWNWdVVp?=
 =?utf-8?B?ZUxqV2RPdnZMUFRiSklxWEcrN2VoQ3N6Qlo5VEw2bjhRNDhyNjhURi9Nay9p?=
 =?utf-8?B?MW1CMHlwN3N5Ly9TMytmNUJrb2RMb3ljTG1qU0VzdDFjUG5mRmZCbGxUOXBG?=
 =?utf-8?Q?U13gpbJHolCYqtWZGU/wXpmYMXnRqgaPy1/1WLk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5273.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5428adf-8036-4be9-2613-08d97dd7cfd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 14:46:50.6755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0k/DyydDgTTJaE5zC1oxOys9Xgtlp88Mw7rmsV4ciaBM0BK/mWOYdju8Vc62SDNtGPHtxMxmvunQknyyK5mzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5065
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQo+IE9uIDE3LzA5LzIwMjEgMTU6MTEsIEFraGlsIFIgd3JvdGU6DQo+ID4gK3N0YXRpYyBpbnQg
dGVncmFfZG1hX3NsYXZlX2NvbmZpZyhzdHJ1Y3QgZG1hX2NoYW4gKmRjLA0KPiA+ICsJCQkJICBz
dHJ1Y3QgZG1hX3NsYXZlX2NvbmZpZyAqc2NvbmZpZykgew0KPiA+ICsJc3RydWN0IHRlZ3JhX2Rt
YV9jaGFubmVsICp0ZGMgPSB0b190ZWdyYV9kbWFfY2hhbihkYyk7DQo+ID4gKw0KPiA+ICsJaWYg
KHRkYy0+ZG1hX2Rlc2MpIHsNCj4gPiArCQlkZXZfZXJyKHRkYzJkZXYodGRjKSwgIkNvbmZpZ3Vy
YXRpb24gbm90IGFsbG93ZWRcbiIpOw0KPiA+ICsJCXJldHVybiAtRUJVU1k7DQo+ID4gKwl9DQo+
ID4gKw0KPiA+ICsJbWVtY3B5KCZ0ZGMtPmRtYV9zY29uZmlnLCBzY29uZmlnLCBzaXplb2YoKnNj
b25maWcpKTsNCj4gPiArCWlmICh0ZGMtPnNsYXZlX2lkID09IC0xKQ0KPiA+ICsJCXRkYy0+c2xh
dmVfaWQgPSBzY29uZmlnLT5zbGF2ZV9pZDsNCj4gPiArDQo+ID4gKwl0ZGMtPmNvbmZpZ19pbml0
ID0gdHJ1ZTsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+IA0KPiBTbyB5b3UgaGF2ZSBhIGZ1
bmN0aW9uIHRvIHJlc2VydmUgYSBzbGF2ZSBJRCwgYnV0IHlvdSBkb24ndCBjaGVjayBoZXJlIGlm
IGl0IGlzDQo+IGFscmVhZHkgcmVzZXJ2ZWQuDQpzbGF2ZS1pZCBpcyByZXNlcnZlZCBjb25zaWRl
cmluZyB0aGUgZGlyZWN0aW9uIGFzIHdlbGwuDQonZGlyZWN0aW9uJyBpcyBhdmFpbGFibGUgb25s
eSBkdXJpbmcgcHJlcF9zbGF2ZV9zZyBmdW5jdGlvbiwgSSBndWVzcy4NCj4NCj4gLi4uDQo+DQo+
ID4gKw0KPiA+ICsJaW9tbXVfc3BlYyA9IGRldl9pb21tdV9md3NwZWNfZ2V0KCZwZGV2LT5kZXYp
Ow0KPiA+ICsJaWYgKCFpb21tdV9zcGVjKSB7DQo+ID4gKwkJZGV2X2VycigmcGRldi0+ZGV2LCAi
TWlzc2luZyBpb21tdSBzdHJlYW0taWRcbiIpOw0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+
ICsJfQ0KPiA+ICsJc3RyZWFtX2lkID0gaW9tbXVfc3BlYy0+aWRzWzBdICYgMHhmZmZmOw0KPiAN
Cj4gSXMgaXQgYW4gZXJyb3IgaWYgdGhlIElEIGlzIGdyZWF0ZXIgdGhhbiAweGZmZmY/DQpUaGUg
dmFsdWUgc2hvdWxkIGNvcnJlc3BvbmQgdG8gb25lIG9mIHRoZSBHUEMgRE1BIENsaWVudHMgbGlz
dGVkIGluDQppbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS90ZWdyYTE4Ni1tYy5oLg0KSSBzYXcg
c2ltaWxhciBtYXNraW5nIGluIG90aGVyIHRlZ3JhIGRyaXZlcnMgYWxzbyBmb3Igc3RyZWFtLWlk
Lg0KDQpXb3VsZCBhZGQgZml4ZXMgZm9yIG90aGVyIGNvbW1lbnRzIGluIHRoZSBuZXh0IHZlcnNp
b24uDQoNClRoYW5rcywNCkFraGlsDQoNCi0tDQogbnZwdWJsaWMNCg==
