Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B61276FD9
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 13:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIXLZm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 07:25:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:25943 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727195AbgIXLZi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Sep 2020 07:25:38 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-119-KlslSWq2M2yj5-tk0Dfdtw-1; Thu, 24 Sep 2020 12:25:34 +0100
X-MC-Unique: KlslSWq2M2yj5-tk0Dfdtw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 24 Sep 2020 12:25:27 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 24 Sep 2020 12:25:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>
CC:     Michael Matz <matz@suse.de>, 'Dave Jiang' <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "jing.lin@intel.com" <jing.lin@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/5] x86/asm: Carve out a generic movdir64b() helper
 for general usage
Thread-Topic: [PATCH v5 1/5] x86/asm: Carve out a generic movdir64b() helper
 for general usage
Thread-Index: AQHWkf7GVv/Eui5H70ijlKVH2OrKB6l3b2twgAAS+QCAABEoMP//+/uAgAAW53A=
Date:   Thu, 24 Sep 2020 11:25:27 +0000
Message-ID: <ba7e555d0dea42eb97d8b08df69b3191@AcuMS.aculab.com>
References: <160090233730.44288.4446779116422752486.stgit@djiang5-desk3.ch.intel.com>
 <160090264332.44288.7575027054245105525.stgit@djiang5-desk3.ch.intel.com>
 <a8c81da06df2471296b663d40b186c92@AcuMS.aculab.com>
 <20200924101506.GD5030@zn.tnic>
 <40f740d814764019ac2306800a6b68e4@AcuMS.aculab.com>
 <20200924110207.GE5030@zn.tnic>
In-Reply-To: <20200924110207.GE5030@zn.tnic>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiA+IE5vLCB0aGF0IGp1c3Qgc2F5cyB0aGUgYXNtIHVzZXMgdGhlIHZhbHVlIG9mIHRoZSBwb2lu
dGVyLg0KPiA+IE5vdCB3aGF0IGl0IHBvaW50cyB0by4NCj4gDQo+IEVyciwgbm8sIGl0IGlzICpl
eGFjdGx5KiB3aGF0IGl0IHBvaW50cyB0byB0aGF0IGlzIGltcG9ydGFudCBoZXJlIGFuZA0KPiB5
b3UncmUgdGVsbGluZyB0aGUgY29tcGlsZXIgdGhhdCB0aGUgaW5zdHJ1Y3Rpb24gd2lsbCByZWFk
IHRoYXQgbXVjaA0KPiBtZW1vcnkgdGhyb3VnaCB0aGUgcG9pbnRlci4NCg0KWW91IG5lZWQgdG8g
dXNlIGFuICJtIiBjb25zdHJhaW50IGZvciB0aGF0Lg0KQSAncmVnaXN0ZXInIGNvbnN0cmFpbnQg
anVzdCByZXF1aXJlcyB0aGUgdmFsdWUgb2YgdGhlIGFkZHJlc3MNCnRvIGJlIHZhbGlkLg0KDQpM
b29rIGF0IHRoZSBhc20gb3V0cHV0IGZyb20gdGhlIGV4YW1wbGUgY29kZSBJIHBvc3RlZC4NCg0K
CURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAx
Mzk3Mzg2IChXYWxlcykNCg==

