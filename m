Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E391629D7A4
	for <lists+dmaengine@lfdr.de>; Wed, 28 Oct 2020 23:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbgJ1WZX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Oct 2020 18:25:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:16879 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732859AbgJ1WZW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Oct 2020 18:25:22 -0400
IronPort-SDR: WuUmfoN5+PRMMHgQsdkJvxWaOY4nhZ38/egN86Gk7UpCT5kDkE9nbfobO5PtDUcPOjRbOxtE6z
 Jen4F1tmHr1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="156073982"
X-IronPort-AV: E=Sophos;i="5.77,427,1596524400"; 
   d="scan'208";a="156073982"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 10:22:02 -0700
IronPort-SDR: MMcnkjAmhwGu3eUty5KUgK3k5De+0tsY3YFnpMIo1n6deOgbKvtbspbJAReUTNw+z1Io+JEc2i
 5eboqv5E0VEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,427,1596524400"; 
   d="scan'208";a="323409665"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 28 Oct 2020 10:22:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 28 Oct 2020 10:22:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 28 Oct 2020 10:22:01 -0700
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.1713.004;
 Wed, 28 Oct 2020 10:22:01 -0700
From:   "Dutt, Sudeep" <sudeep.dutt@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sherry.sun@nxp.com" <sherry.sun@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Dutt, Sudeep" <sudeep.dutt@intel.com>,
        "Rao, Nikhil" <nikhil.rao@intel.com>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH char-misc-next 1/1] misc: mic: remove the MIC drivers
Thread-Topic: [PATCH char-misc-next 1/1] misc: mic: remove the MIC drivers
Thread-Index: AQHWrNlSTcDKHXrr00Ok1/haUeN9aKms+T+AgAC+UYA=
Date:   Wed, 28 Oct 2020 17:22:01 +0000
Message-ID: <f64a1f67781441c8ed48b991afbf8dd2f9030289.camel@intel.com>
References: <8c1443136563de34699d2c084df478181c205db4.1603854416.git.sudeep.dutt@intel.com>
         <20201028055429.GA244117@kroah.com>
In-Reply-To: <20201028055429.GA244117@kroah.com>
Reply-To: "Dutt, Sudeep" <sudeep.dutt@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFAD421A00FC374C8C548A4A07C1EE45@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gV2VkLCAyMDIwLTEwLTI4IGF0IDA2OjU0ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFR1ZSwgT2N0IDI3LCAyMDIwIGF0IDA4OjE0OjE1UE0gLTA3MDAsIFN1ZGVlcCBE
dXR0IHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggcmVtb3ZlcyB0aGUgTUlDIGRyaXZlcnMgZnJvbSB0
aGUga2VybmVsIHRyZWUNCj4gPiBzaW5jZSB0aGUgY29ycmVzcG9uZGluZyBkZXZpY2VzIGhhdmUg
YmVlbiBkaXNjb250aW51ZWQuDQo+IA0KPiBEb2VzICJkaXNjb250aW51ZWQiIG1lYW4gIm5ldmVy
IHNoaXBwZWQgYSBkZXZpY2Ugc28gbm8gb25lIGhhcyBhY2Nlc3MNCj4gdG8NCj4gdGhpcyBoYXJk
d2FyZSBhbnltb3JlIiwgb3IgZG9lcyBpdCBtZWFuICJ3ZSBzdG9wcGVkIHNoaXBwaW5nIGRldmlj
ZXMNCj4gYW5kDQo+IHRoZXJlIGFyZSBjdXN0b21lcnMgd2l0aCB0aGlzPyINCg0KSGkgR3JlZywN
Cg0KV2UgYXJlIG5vdCBhd2FyZSBvZiBhbnkgY3VzdG9tZXJzIG9mIHRoZSB1cHN0cmVhbWVkIE1J
QyBkcml2ZXJzLiBUaGUgDQpkcml2ZXJzIHdlcmUgdXBzdHJlYW1lZCBwcmltYXJpbHkgdG8gbGF5
IGEgZm91bmRhdGlvbiBmb3IgZW5hYmxpbmcgdGhlDQpuZXh0IGdlbmVyYXRpb24gTUlDIGRldmlj
ZXMgd2hpY2ggZGlkIG5vdCBzaGlwLg0KDQo+ID4gUmVtb3ZpbmcgdGhlIGRtYSBhbmQgY2hhci1t
aXNjIGNoYW5nZXMgaW4gb25lIHBhdGNoIGFuZA0KPiA+IG1lcmdpbmcgdmlhIHRoZSBjaGFyLW1p
c2MgdHJlZSBpcyBiZXN0IHRvIGF2b2lkIGFueQ0KPiA+IHBvdGVudGlhbCBidWlsZCBicmVha2Fn
ZS4NCj4gPiANCj4gPiBDYzogTmlraGlsIFJhbyA8bmlraGlsLnJhb0BpbnRlbC5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IEFzaHV0b3NoIERpeGl0IDxhc2h1dG9zaC5kaXhpdEBpbnRlbC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogU3VkZWVwIER1dHQgPHN1ZGVlcC5kdXR0QGludGVsLmNvbT4NCj4g
DQo+IEkgbGlrZSBkZWxldGluZyBjb2RlLCBjYW4gdGhpcyBnbyBpbnRvIDUuMTAtZmluYWw/DQoN
Clllcywgd2Ugd291bGQgcHJlZmVyIHRoaXMgZ29lcyBpbnRvIHY1LjEwLiBJIGFtIGhvcGluZyB5
b3UgY2FuIGNhcnJ5DQp0aGUgQWNrIGZyb20gVmlub2QgYW5kIHRoZSBSZXZpZXdlZC1ieSBmcm9t
IFNoZXJyeSBidXQgSSBjYW4gcmVzZW5kIHRoZQ0KcGF0Y2ggd2l0aCB0aG9zZSB1cGRhdGVzIGlu
IHRoZSBjb21taXQgbWVzc2FnZSBpZiByZXF1aXJlZC4gSSBkaWQNCnZlcmlmeSB0aGF0IHRoaXMg
cGF0Y2ggcGFzc2VzIGFsbG1vZGNvbmZpZyBhbmQgYWxseWVzY29uZmlnIGJ1aWxkcyB3aXRoDQp5
b3VyIGxhdGVzdCBjaGFyLW1pc2MtbmV4dCB0cmVlLg0KDQpNYW55IHRoYW5rcyBmb3IgeW91ciBo
ZWxwIHdpdGggdGhpcyBzdWJzeXN0ZW0gR3JlZy4NCg0KQmVzdCBSZWdhcmRzLA0KU3VkZWVwIER1
dHQNCg==
