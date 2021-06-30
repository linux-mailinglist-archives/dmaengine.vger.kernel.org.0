Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF3F3B87C3
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jun 2021 19:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhF3Rfx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Jun 2021 13:35:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:39260 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhF3Rfw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 30 Jun 2021 13:35:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="294032890"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="294032890"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 10:33:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="641786892"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2021 10:33:22 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 30 Jun 2021 10:33:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 30 Jun 2021 10:33:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 30 Jun 2021 10:33:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiptv+8Ny1p+vICbC3m2oWUj4Jfcm7FVF18bNy+iyzGRSPBRLM7RebjZpz5Iy7N8/ydYvUrWtsbiLNID19R/QS3agFpJXWs9XT5ejCB+o+HNhELgDL4maOdom/nCsMfr0dlP9kRPc6terIvEFGYQ4xPYjjnZ5WfH8ymGBXzU7lf21s/NVFx8cSeaxVhBrwFmpJssEp4+NoPDD/zELW5g9NY4TzkZKRu7HG8nXvCiCVBkmeJfwjEMX5TIliACNQH91gdR9+3qJriio14o/TuwVyG0XqIUvnQoa2vTl1p5ttZ9kTi0wxdTxVOSB17Q4fGzTp3c/L+HS2HKY9L9ge5jng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygxLlkBCMhmH7MexQkIghywJb2an5W9zGQg0i96rH8E=;
 b=NDaT1zAEHOYrrqXPB0Gip3vpk65M+mTPFfOviN/f3LD3rdtP5zN+ZdT4EEGvofGiRTUH5IxEhVJa6aax4WTs2s0bo6Q9fJPif4xqvG+d4l2U2XK8Blr6TIL3P/c3dxsf3SDsPxw6ZphkdGA1nhD78e6ZJN+RRFsLGwLEMqHiJi6qM87+Wn1l5RuGWeUXqRORF4ZMfWP40dFEGmWFE54oM15Ucvv0heBGx6PCefvJtwpbiUgktvTs5Y6Z3UydXCST4++ppetm+aRiRFJXP6h8HHpAazuJ6Qhm+/Etwv83bEuygca8gVoRPwq5J33Ulw7VY2UrXmXZPgn3NxPdUs2LNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygxLlkBCMhmH7MexQkIghywJb2an5W9zGQg0i96rH8E=;
 b=AS6qEhs6lsKc5Hl2NfpMIY6Sru3CvOnG74tsHKYJOpGgFV810aB9C3khjD9SYe2xpsDjug/SWo2nffrKKInDCKcXzUZJPUoMeYxo1khmC3QG6WYR7K8crViyyXT7Do15LR/ZfiuF1HiZaILInAHXHp5pPnuyGHje69arbvIvB94=
Received: from DM6PR11MB4491.namprd11.prod.outlook.com (2603:10b6:5:204::19)
 by DM6PR11MB3466.namprd11.prod.outlook.com (2603:10b6:5:e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.23; Wed, 30 Jun 2021 17:33:16 +0000
Received: from DM6PR11MB4491.namprd11.prod.outlook.com
 ([fe80::7dc4:66b0:f76b:6d48]) by DM6PR11MB4491.namprd11.prod.outlook.com
 ([fe80::7dc4:66b0:f76b:6d48%7]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 17:33:16 +0000
From:   "Ananyev, Konstantin" <konstantin.ananyev@intel.com>
To:     "Jiang, Dave" <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH v3] dmaengine: idxd: fix submission race window
Thread-Topic: [PATCH v3] dmaengine: idxd: fix submission race window
Thread-Index: AQHXbQF67WpENznkKEWNutr6QUm2b6ss0agw
Date:   Wed, 30 Jun 2021 17:33:16 +0000
Message-ID: <DM6PR11MB4491853F02415B78D62A7DC99A019@DM6PR11MB4491.namprd11.prod.outlook.com>
References: <162498301955.2302125.5031103655704428294.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162498301955.2302125.5031103655704428294.stgit@djiang5-desk3.ch.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [109.255.184.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2ea4735-51c7-4de3-8e69-08d93bed2516
x-ms-traffictypediagnostic: DM6PR11MB3466:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB346651C0269372DF9E62B9C49A019@DM6PR11MB3466.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLQHAnlikm7KmQX0QRDQNeex1sHpLJ61h1nzNDhn/Xz9sRfIPi+kIFdXHY4mzCEfp1M1GJUdSZgkYNUXdhYimYE+2LAnhMIm+PVmS339fnLGA4LKtsqoD2WZF+ak7IuFPLPb2+/lsStsQJ34D0idYcaxzZUSU7ET07HTIBs0Jesru90yH7wLCDZcNMkv1TqLIpJfQxUFvX5wG0C0DdYYuj/ERXKKkWC4p342nCDuwe7Wr/7VnIaHRYThiIFI7P7RiZ7uXmyNvxcZAnbTgNBQY7F9wKOEoHE0IY6d3NjmDPFU2dNrzVTMfYBiHuIff2vG0ZswhuAL8UVE2yQwXlP6AECo7MrKxhBXI0vaKxF4OazGAAoS5yKK92yY3qfd3vNCoX43JYoVxBcf6BGG4i/SDyywT+AUHS/k211HhlpjQNxq+CMREgEoOhpASEUEcn4rvq9rrttUeNE4q5dhYRksq8hVtiuWHa9SNchcf4nZJhmRXj3/40Pnwp6dO6vPCi78+839lnZ6RN8MS/KgoQ0mCimnT7lhGGUylLEDsbfY6lD4QMuK2xGELj2jR/GPf/HuK+EwE7bAxgFOGPGPyKpobv9YN27NAbdxIUzaBpiJutU9DPO9xmsIiOGdXoRQqnhE2mXr/OQew8hXF2E8+TWd+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4491.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(376002)(136003)(366004)(4326008)(478600001)(122000001)(38100700002)(86362001)(66556008)(55236004)(6506007)(5660300002)(52536014)(26005)(76116006)(83380400001)(64756008)(66446008)(7696005)(66946007)(186003)(66476007)(110136005)(8936002)(33656002)(71200400001)(316002)(8676002)(2906002)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGhYUG1mYnZaUTZ4UkV3MHFZd1RRYjIvSExxM3h6SVVBMmx4SE5tckEzeXVi?=
 =?utf-8?B?amo2TmRLbHpyd1AveWVVSkNjQTdIdHEyVXFNTjBRYjdabDRJelpaRTc0WG9o?=
 =?utf-8?B?S0MybSthYWVtVmdndDFwUlF2dmlVQlorcnQwUktjR09PVEVjbjdrNHRjWUVF?=
 =?utf-8?B?NDJPREUyWHQ0UzJOQ215a1NQOTNjVkozVEFDblNOSjlEYkRNS0RHVHFRdlFZ?=
 =?utf-8?B?MXJsemdwWGZHZlNpeDBBS0VJN1FwaTVOMW5FdGVqL1N3RUlTaVBQMnQzL1hR?=
 =?utf-8?B?eGJ6UmQ2NXQ4eHZkRTBTeXN1VldUMWh0cFVYVmx0c2JNV0hKeTRJT2pzVWZ5?=
 =?utf-8?B?R0J1SFh2cHJyMGVNWlRCWUcwZU0wZ3cwNUJocndXYS9IdmQydWFwZzNJU1NS?=
 =?utf-8?B?Q3RhSUtTVUduWHBsRlgzNHdtNXdsYW1jUnZ3cVZpVEtpaHZHY1hOQldHbFlB?=
 =?utf-8?B?a2FTL0Jpd3g4bkR3MXd5ZjFDSFZBVi8wdXJYU2o0NFBJM0NPV2FMN0UyU3U1?=
 =?utf-8?B?QjRyWi80TXdObXQ0Ly9ueGswUUovSGxYaW1sQ1MzSDd5T1IxMlFSelhxcGtE?=
 =?utf-8?B?UkJCaVRGaXRHQkdnYmhnTVJISXA0ajI5QUZzY0xhWTVxTDFTTVMxYWFFcGJ5?=
 =?utf-8?B?UWFEWkx4N0UvSEVFTFB1eWlzSVArQk1FUm14d0IxNGEvZSswK2VURjRMT0Vl?=
 =?utf-8?B?UC9VU240NDllQjY3QkxVQjlIc3FIZW9sSGk3Rm5OcVQxVTJDTFF5dUlwVkZj?=
 =?utf-8?B?QWtDY1B5cVhIVmkzZm9yc1lCajVDL21lcVpOSUQ5YU5zUjJDZW1SbkFmMldx?=
 =?utf-8?B?MkhsTEtIZ3pIdFBHcCtwVDRPTVhzY3U1OFIwMUpnVFBPdnkwSjV3Z1RSSXdv?=
 =?utf-8?B?UmM4L0t2UERHSk8yQWhqc0xDYnJ4SjByejh1Z2tYN0JZNFliWTkzSmJrR0dk?=
 =?utf-8?B?dEptdS9DNjJ4ejIxa3FIdHlYZ0JBZGlDUEZJdEUrMTFLc3FnM1ViUXgwMlht?=
 =?utf-8?B?a1BKY09pb0xyTFUvL1RlZUw3UjNsK253bkxXbklvaFF6VzBGb0x5NlJzV2xj?=
 =?utf-8?B?bHY1MmxZcm5nVkorMFB0MTcwUkpnRWpORnhibXRITEZ1dE5iY05WVllBcXl6?=
 =?utf-8?B?dUFBZzJnTC9YNkNBd3p5d0d6K2ZYNm90cTAzZGxNdHJsN0p6WlFuV013TjZH?=
 =?utf-8?B?bVdFTW5vVEF1MmVUZmtuTU13MjBzd0hZaGxwNjk2VkF5WW5WcGl6V3FCZkd3?=
 =?utf-8?B?YklNNFAyNUVPcWZFdE5tVTQ5dDlkZDg5UzZ1aXNIUnRwRkVKUHFWMkVack56?=
 =?utf-8?B?czRudmlxZkU5UUROYzhXdmVNQk1JRjk4Mks0Q1FKN3dDNzQ5SzB2clpVQjVI?=
 =?utf-8?B?KzRmVDZHZTVFck1oRFBHZ3c3VHBJM244YjVsZU5XK0IwVmpVOVYzbFJDbE9t?=
 =?utf-8?B?aHlLY2Vjd1BseDVaTnJ2aXZlV1lSMVE5QWEydHkwVlN5aHBaaTZjUGNlUnZv?=
 =?utf-8?B?Z2NES1ZybVhnUStOVHV4SHQybFREQUdWbjBwa0ZmOVA4eXJRek5sRklGS054?=
 =?utf-8?B?S2VjNW1PUXZWQU1PNGVUV3FUN2hkRjIwN05hR20xL1c2Tm4rMXYzTlRXdWtw?=
 =?utf-8?B?MjB5Z0tCWVR6VUZDYkI0MlZTVmxQVW5heWdmYytoZnVWcytCcnlwYlUwUEJL?=
 =?utf-8?B?Q29sd0xMeFE3VGpLcWpvMENuaThXR2F4WU9xVmpacXNlTmsyLzREZzQ5cjJY?=
 =?utf-8?Q?D2Wc5gPMlfyJTDX0qH9BIU7XAPpbGqWH7d2SuSs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ea4735-51c7-4de3-8e69-08d93bed2516
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 17:33:16.4159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygxtS2STuPv2Lje8wrY0OVWzfJrLzJ5RCm2DNIVg1OCh1rsAo2hshN8jccmc3XXaxZrCT35w3rwLM7F4kqUc72HUQFHwGbDSZ0LuZPjQsUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3466
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQo+IEtvbnN0YW50aW4gb2JzZXJ2ZWQgdGhhdCB3aGVuIGRlc2NyaXB0b3JzIGFyZSBzdWJtaXR0
ZWQsIHRoZSBkZXNjcmlwdG9yIGlzDQo+IGFkZGVkIHRvIHRoZSBwZW5kaW5nIGxpc3QgYWZ0ZXIg
dGhlIHN1Ym1pc3Npb24uIFRoaXMgY3JlYXRlcyBhIHJhY2Ugd2luZG93DQo+IHdpdGggdGhlIHNs
aWdodCBwb3NzaWJpbGl0eSB0aGF0IHRoZSBkZXNjcmlwdG9yIGNhbiBjb21wbGV0ZSBiZWZvcmUg
aXQNCj4gZ2V0cyBhZGRlZCB0byB0aGUgcGVuZGluZyBsaXN0IGFuZCB0aGlzIHdpbmRvdyB3b3Vs
ZCBjYXVzZSB0aGUgY29tcGxldGlvbg0KPiBoYW5kbGVyIHRvIG1pc3MgcHJvY2Vzc2luZyB0aGUg
ZGVzY3JpcHRvci4NCj4gDQo+IFRvIGFkZHJlc3MgdGhlIGlzc3VlLCB0aGUgYWRkaXRpb24gb2Yg
dGhlIGRlc2NyaXB0b3IgdG8gdGhlIHBlbmRpbmcgbGlzdA0KPiBtdXN0IGJlIGRvbmUgYmVmb3Jl
IGl0IGdldHMgc3VibWl0dGVkIHRvIHRoZSBoYXJkd2FyZS4gSG93ZXZlciwgc3VibWl0dGluZw0K
PiB0byBzd3Egd2l0aCBFTlFDTURTIGluc3RydWN0aW9uIGNhbiBjYXVzZSBhIGZhaWx1cmUgd2l0
aCB0aGUgY29uZGl0aW9uIG9mDQo+IGVpdGhlciB3cSBpcyBmdWxsIG9yIHdxIGlzIG5vdCAiYWN0
aXZlIi4NCj4gDQo+IFdpdGggdGhlIGRlc2NyaXB0b3IgYWxsb2NhdGlvbiBiZWluZyB0aGUgZ2F0
ZSB0byB0aGUgd3EgY2FwYWNpdHksIGl0IGlzIG5vdA0KPiBwb3NzaWJsZSB0byBoaXQgYSByZXRy
eSB3aXRoIEVOUUNNRFMgc3VibWlzc2lvbiB0byB0aGUgc3dxLiBUaGUgb25seQ0KPiBwb3NzaWJs
ZSBmYWlsdXJlIGNhbiBoYXBwZW4gaXMgd2hlbiB3cSBpcyBubyBsb25nZXIgImFjdGl2ZSIgZHVl
IHRvIGh3DQo+IGVycm9yIGFuZCB0aGVyZWZvcmUgd2UgYXJlIG1vdmluZyB0b3dhcmRzIHRha2lu
ZyBkb3duIHRoZSBwb3J0YWwuIEdpdmVuDQo+IHRoaXMgaXMgYSByYXJlIGNvbmRpdGlvbiBhbmQg
dGhlcmUncyBubyBsb25nZXIgY29uY2VybiBvdmVyIEkvTw0KPiBwZXJmb3JtYW5jZSwgdGhlIGRy
aXZlciBjYW4gd2FsayB0aGUgY29tcGxldGlvbiBsaXN0cyBpbiBvcmRlciB0byByZXRyaWV2ZQ0K
PiBhbmQgYWJvcnQgdGhlIGRlc2NyaXB0b3IuDQo+IA0KPiBUaGUgZXJyb3IgcGF0aCB3aWxsIHNl
dCB0aGUgZGVzY3JpcHRvciB0byBhYm9ydGVkIHN0YXR1cy4gSXQgd2lsbCB0YWtlIHRoZQ0KPiB3
b3JrIGxpc3QgbG9jayB0byBwcmV2ZW50IGZ1cnRoZXIgcHJvY2Vzc2luZyBvZiB3b3JrbGlzdC4g
SXQgd2lsbCBkbyBhDQo+IGRlbGV0ZV9hbGwgb24gdGhlIHBlbmRpbmcgbGxpc3QgdG8gcmV0cmll
dmUgYWxsIGRlc2NyaXB0b3JzIG9uIHRoZSBwZW5kaW5nDQo+IGxsaXN0LiBUaGUgZGVsZXRlX2Fs
bCBhY3Rpb24gZG9lcyBub3QgcmVxdWlyZSBhIGxvY2suIEl0IHdpbGwgd2FsayB0aHJvdWdoDQo+
IHRoZSBhY3F1aXJlZCBsbGlzdCB0byBmaW5kIHRoZSBhYm9ydGVkIGRlc2NyaXB0b3Igd2hpbGUg
YWRkIGFsbCByZW1haW5pbmcNCj4gZGVzY3JpcHRvcnMgdG8gdGhlIHdvcmsgbGlzdCBzaW5jZSBp
dCBob2xkcyB0aGUgbG9jay4gSWYgaXQgZG9lcyBub3QgZmluZA0KPiB0aGUgYWJvcnRlZCBkZXNj
cmlwdG9yIG9uIHRoZSBsbGlzdCwgaXQgd2lsbCB3YWxrIHRocm91Z2ggdGhlIHdvcmsNCj4gbGlz
dC4gQW5kIGlmIGl0IHN0aWxsIGRvZXMgbm90IGZpbmQgdGhlIGRlc2NyaXB0b3IsIHRoZW4gaXQg
bWVhbnMgdGhlDQo+IGludGVycnVwdCBoYW5kbGVyIGhhcyByZW1vdmVkIHRoZSBkZXNjIGZyb20g
dGhlIGxsaXN0IGJ1dCBpcyBwZW5kaW5nIG9uDQo+IHRoZSB3b3JrIGxpc3QgbG9jayBhbmQgd2ls
bCBwcm9jZXNzIGl0IG9uY2UgdGhlIGVycm9yIHBhdGggcmVsZWFzZXMgdGhlDQo+IGxvY2suDQo+
IA0KPiBGaXhlczogZWIxNWU3MTU0ZmJmICgiZG1hZW5naW5lOiBpZHhkOiBhZGQgaW50ZXJydXB0
IGhhbmRsZSByZXF1ZXN0IGFuZCByZWxlYXNlIHN1cHBvcnQiKQ0KPiBSZXBvcnRlZC1ieTogS29u
c3RhbnRpbiBBbmFueWV2IDxrb25zdGFudGluLmFuYW55ZXZAaW50ZWwuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4gLS0tDQo+IA0KPiB2
MzoNCj4gLSBhZGQgbWlzc2luZyBpbml0IGZvciB2YXIgKEtvbnN0YW50aW4pDQo+IA0KPiB2MjoN
Cj4gLSBkbyBhYm9ydCBjYWxsYmFjayBvdXRzaWRlIG9mIGxvY2sgKEtvbnN0YW50aW4pDQo+IC0g
Zml4IGFib3J0IHJlYXNvbiBmbGFnIChLb25zdGFudGluKQ0KPiAtIHJlbW92ZSBjaGFuZ2VzIHRv
IHNwaW5sb2NrDQo+IA0KPiAgZHJpdmVycy9kbWEvaWR4ZC9pZHhkLmggICB8ICAgMTQgKysrKysr
KysNCj4gIGRyaXZlcnMvZG1hL2lkeGQvaXJxLmMgICAgfCAgIDI3ICsrKysrKysrKysrLS0tLS0N
Cj4gIGRyaXZlcnMvZG1hL2lkeGQvc3VibWl0LmMgfCAgIDc1ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA5OSBpbnNlcnRp
b25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gDQoNCkFja2VkLWJ5OiBLb25zdGFudGluIEFuYW55
ZXYgPGtvbnN0YW50aW4uYW5hbnlldkBpbnRlbC5jb20+DQoNCg==
