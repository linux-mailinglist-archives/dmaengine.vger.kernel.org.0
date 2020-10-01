Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9547A27FEDA
	for <lists+dmaengine@lfdr.de>; Thu,  1 Oct 2020 14:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbgJAMSM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Oct 2020 08:18:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:19934 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731839AbgJAMSM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 1 Oct 2020 08:18:12 -0400
IronPort-SDR: RqY7Ggu2UsAS0fwWzLWD3KAahO4EhOxw1tC/kVcIYjLIuNXxioGTImuvG5oKCE4Vb+j8Vhjqf8
 KG+Cwfn+Sgkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="160111634"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="160111634"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 05:18:10 -0700
IronPort-SDR: UhmPryEsZv0v47Sz5+2Tmji8P36b74PgFGZqIanh2oKhivbsl8zhQ+OaFcsasu6HzOLrS4W/yx
 azUCZVY5PSSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="308611690"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 01 Oct 2020 05:18:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 1 Oct 2020 05:18:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 1 Oct 2020 05:18:08 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Thu, 1 Oct 2020 05:18:08 -0700
From:   "Jiang, Dave" <dave.jiang@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Lin, Jing" <jing.lin@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/5] Add shared workqueue support for idxd driver
Thread-Topic: [PATCH v6 0/5] Add shared workqueue support for idxd driver
Thread-Index: AQHWkpywf1ThYVfa9k6EQSVI71gKlKl4TzaAgAB6qACACQB3AIAA3JgAgAANsZc=
Date:   Thu, 1 Oct 2020 12:18:08 +0000
Message-ID: <2D7025CD-00D4-4D68-98D3-17AD4B0D65EE@intel.com>
References: <20200924180041.34056-1-dave.jiang@intel.com>
 <a2a6f147-c4ad-a225-e348-b074a8017a10@intel.com>
 <20200924215136.GS5030@zn.tnic>
 <4d857287-c751-8b37-d067-b471014c3b73@intel.com>,<20201001042908.GO2968@vkoul-mobl>
In-Reply-To: <20201001042908.GO2968@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQoNCj4gT24gU2VwIDMwLCAyMDIwLCBhdCA5OjI5IFBNLCBWaW5vZCBLb3VsIDx2a291bEBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IO+7v0hpIERhdmUsDQo+IA0KPj4gT24gMzAtMDktMjAsIDE1
OjE5LCBEYXZlIEppYW5nIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiA5LzI0LzIwMjAgMjo1MSBQ
TSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPj4+IE9uIFRodSwgU2VwIDI0LCAyMDIwIGF0IDAy
OjMyOjM1UE0gLTA3MDAsIERhdmUgSmlhbmcgd3JvdGU6DQo+Pj4+IEhpIFZpbm9kLA0KPj4+PiBM
b29rcyBsaWtlIHdlIGFyZSBjbGVhcmVkIG9uIHRoZSB4ODYgcGF0Y2hlcyBmb3IgdGhpcyBzZXJp
ZXMgd2l0aCBzaWduIG9mZnMNCj4+Pj4gZnJvbSBtYWludGFpbmVyIEJvcmlzLiBQbGVhc2UgY29u
c2lkZXIgdGhlIHNlcmllcyBmb3IgNS4xMCBpbmNsdXNpb24uIFRoYW5rDQo+Pj4+IHlvdSENCj4+
PiANCj4+PiBBcyBJIHNhaWQgaGVyZSwgSSdkIHN0cm9uZ2x5IHN1Z2dlc3Qgd2UgZG8gdGhpczoN
Cj4+PiANCj4+PiBodHRwczovL2xpc3RzLjAxLm9yZy9oeXBlcmtpdHR5L2xpc3Qva2J1aWxkLWFs
bEBsaXN0cy4wMS5vcmcvdGhyZWFkLzVGS05XTkNDUlYzQVhVQUVYVUdRRkY0RURRTkFORjNGLw0K
Pj4+IA0KPj4+IGFuZCBWaW5vZCBzaG91bGQgbWVyZ2UgdGhlIHg4Ni9wYXNpZCBicmFuY2guIE90
aGVyd2lzZSBpcyBoaXMgYnJhbmNoDQo+Pj4gYW5kIGluY29tcGxldGUgeW91IGNvdWxkIG5vdCBo
YXZlIHRlc3RlZCBpdCBwcm9wZXJseS4NCj4+PiANCj4+IA0KPj4gSGkgVmlub2QsDQo+PiBKdXN0
IGNoZWNraW5nIHRvIHNlZSBpZiB5b3UgaGF2ZSBhbnkgb2JqZWN0aW9ucyBvciBjb25jZXJucyB3
aXRoIHJlc3BlY3QgdG8NCj4+IHRoaXMgc2VyaWVzLiBXZSBhcmUgaG9waW5nIGl0IGNhbiBiZSBx
dWV1ZWQgZm9yIHRoZSA1LjEwIG1lcmdlIGlmIHRoZXJlIGFyZQ0KPj4gbm8gb2JqZWN0aW9ucy4g
VGhhbmtzIQ0KPiANCj4gSSB3YXMgb3V0IGZvciBsYXN0IGZldyBkYXlzLCBzbyBoYXZlbid0IGNo
ZWNrZWQgb24gdGhpcyB5ZXQsIGJ1dCBnaXZlbg0KPiB0aGF0IHdlIGFyZSB2ZXJ5IGNsb3NlIHRv
IG1lcmdlIHdpZG93IEkgZmVhciBpdCBpcyBiaXQgbGF0ZSB0byBtZXJnZQ0KPiB0aGlzIGxhdGUu
IEkgd2lsbCBnbyB0aHJ1IHRoZSBzZXJpZXMgdG9kYXkgdGhvdWdoLi4NCg0KVGhhbmtzIFZpbm9k
LiBWZXJ5IG11Y2ggYXBwcmVjaWF0ZSBpdCBlaXRoZXIgd2F5LiANCg0KDQo+IFRoYW5rcw0KPiAt
LSANCj4gflZpbm9kDQo=
