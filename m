Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA77277B81
	for <lists+dmaengine@lfdr.de>; Fri, 25 Sep 2020 00:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIXWJ0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 18:09:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:27973 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgIXWJ0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Sep 2020 18:09:26 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-33-rUFRHqo6MiC-lQEt20YkRg-1; Thu, 24 Sep 2020 23:09:20 +0100
X-MC-Unique: rUFRHqo6MiC-lQEt20YkRg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 24 Sep 2020 23:09:19 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 24 Sep 2020 23:09:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Jiang' <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "jing.lin@intel.com" <jing.lin@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 2/5] x86/asm: Add enqcmds() to support ENQCMDS
 instruction
Thread-Topic: [PATCH v6 2/5] x86/asm: Add enqcmds() to support ENQCMDS
 instruction
Thread-Index: AQHWkpyytHRIYDTNN0W1+DWKJw+VJ6l4WLfg
Date:   Thu, 24 Sep 2020 22:09:19 +0000
Message-ID: <c55cedaddf3c4b04936b9879e5d57a45@AcuMS.aculab.com>
References: <20200924180041.34056-1-dave.jiang@intel.com>
 <20200924180041.34056-3-dave.jiang@intel.com>
In-Reply-To: <20200924180041.34056-3-dave.jiang@intel.com>
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
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

RnJvbTogRGF2ZSBKaWFuZw0KPiBTZW50OiAyNCBTZXB0ZW1iZXIgMjAyMCAxOTowMQ0KPiANCj4g
Q3VycmVudGx5LCB0aGUgTU9WRElSNjRCIGluc3RydWN0aW9uIGlzIHVzZWQgdG8gYXRvbWljYWxs
eQ0KPiBzdWJtaXQgNjQtYnl0ZSB3b3JrIGRlc2NyaXB0b3JzIHRvIGRldmljZXMuIEFsdGhvdWdo
IGl0IGNhbg0KPiBlbmNvdW50ZXIgZXJyb3JzIGxpa2UgZGV2aWNlIHF1ZXVlIGZ1bGwsIGNvbW1h
bmQgbm90IGFjY2VwdGVkLA0KPiBkZXZpY2Ugbm90IHJlYWR5LCBldGMgd2hlbiB3cml0aW5nIHRv
IGEgZGV2aWNlIE1NSU8sIE1PVkRJUjY0Qg0KPiBjYW4gbm90IHJlcG9ydCBiYWNrIG9uIGVycm9y
cyBmcm9tIHRoZSBkZXZpY2UgaXRzZWxmLiBUaGlzDQo+IG1lYW5zIHRoYXQgTU9WRElSNjRCIHVz
ZXJzIG5lZWQgdG8gc2VwYXJhdGVseSBpbnRlcmFjdCB3aXRoIGENCj4gZGV2aWNlIHRvIHNlZSBp
ZiBhIGRlc2NyaXB0b3Igd2FzIHN1Y2Nlc3NmdWxseSBxdWV1ZWQsIHdoaWNoDQo+IHNsb3dzIGRv
d24gZGV2aWNlIGludGVyYWN0aW9ucy4NCj4gDQo+IEVOUUNNRCBhbmQgRU5RQ01EUyBhbHNvIGF0
b21pY2FsbHkgc3VibWl0IDY0LWJ5dGUgd29yaw0KPiBkZXNjcmlwdG9ycyB0byBkZXZpY2VzLiBC
dXQsIHRoZXkgKmNhbiogcmVwb3J0IGJhY2sgZXJyb3JzDQo+IGRpcmVjdGx5IGZyb20gdGhlIGRl
dmljZSwgc3VjaCBhcyBpZiB0aGUgZGV2aWNlIHdhcyBidXN5LA0KPiBvciBkZXZpY2Ugbm90IGVu
YWJsZWQgb3IgZG9lcyBub3Qgc3VwcG9ydCB0aGUgY29tbWFuZC4gVGhpcw0KPiBpbW1lZGlhdGUg
ZmVlZGJhY2sgZnJvbSB0aGUgc3VibWlzc2lvbiBpbnN0cnVjdGlvbiBpdHNlbGYNCj4gcmVkdWNl
cyB0aGUgbnVtYmVyIG9mIGludGVyYWN0aW9ucyB3aXRoIHRoZSBkZXZpY2UgYW5kIGNhbg0KPiBn
cmVhdGx5IGluY3JlYXNlIGVmZmljaWVuY3kuDQo+IA0KPiBFTlFDTUQgY2FuIGJlIHVzZWQgYXQg
YW55IHByaXZpbGVnZSBsZXZlbCwgYnV0IGNhbiBlZmZlY3RpdmVseQ0KPiBvbmx5IHN1Ym1pdCB3
b3JrIG9uIGJlaGFsZiBvZiB0aGUgY3VycmVudCBwcm9jZXNzLiBFTlFDTURTIGlzIGENCj4gcmlu
ZzAtb25seSBpbnN0cnVjdGlvbiBhbmQgY2FuIGV4cGxpY2l0bHkgc3BlY2lmeSBhIHByb2Nlc3MN
Cj4gY29udGV4dCBpbnN0ZWFkIG9mIGJlaW5nIHRpZWQgdG8gdGhlIGN1cnJlbnQgcHJvY2VzcyBv
ciBuZWVkaW5nDQo+IHRvIHJlcHJvZ3JhbSB0aGUgSUEzMl9QQVNJRCBNU1IuDQo+IA0KPiBVc2Ug
RU5RQ01EUyBmb3Igd29yayBzdWJtaXNzaW9uIHdpdGhpbiB0aGUga2VybmVsIGJlY2F1c2UgYQ0K
PiBQcm9jZXNzIEFkZHJlc3MgSUQgKFBBU0lEKSBpcyBzZXR1cCB0byB0cmFuc2xhdGUgdGhlIGtl
cm5lbA0KPiB2aXJ0dWFsIGFkZHJlc3Mgc3BhY2UuIFRoaXMgUEFTSUQgaXMgcHJvdmlkZWQgdG8g
RU5RQ01EUyBmcm9tDQo+IHRoZSBkZXNjcmlwdG9yIHN0cnVjdHVyZSBzdWJtaXR0ZWQgdG8gdGhl
IGRldmljZSBhbmQgbm90IHJldHJpZXZlZA0KPiBmcm9tIElBMzJfUEFTSUQgTVNSLCB3aGljaCBp
cyBzZXR1cCBmb3IgdGhlIGN1cnJlbnQgdXNlciBhZGRyZXNzIHNwYWNlLg0KPiANCj4gU2VlIElu
dGVsIFNvZnR3YXJlIERldmVsb3BlcuKAmXMgTWFudWFsIGZvciBtb3JlIGluZm9ybWF0aW9uIG9u
IHRoZQ0KPiBpbnN0cnVjdGlvbnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZlIEppYW5nIDxk
YXZlLmppYW5nQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFRvbnkgTHVjayA8dG9ueS5sdWNr
QGludGVsLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zcGVjaWFsX2luc25z
LmggfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MzQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNt
L3NwZWNpYWxfaW5zbnMuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaA0K
PiBpbmRleCAyMjU4YzdkNmUyODEuLmI0ZDJjZTMwMGM5NCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94
ODYvaW5jbHVkZS9hc20vc3BlY2lhbF9pbnNucy5oDQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3NwZWNpYWxfaW5zbnMuaA0KPiBAQCAtMjU2LDYgKzI1Niw0MCBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgbW92ZGlyNjRiKHZvaWQgKmRzdCwgY29uc3Qgdm9pZCAqc3JjKQ0KPiAgCQkgICAgIDog
ICJtIiAoKl9fc3JjKSwgImEiIChfX2RzdCksICJkIiAoX19zcmMpKTsNCj4gIH0NCj4gDQo+ICsv
KioNCj4gKyAqIGVucWNtZHMgLSBjb3B5IGEgNTEyIGJpdHMgZGF0YSB1bml0IHRvIHNpbmdsZSBN
TUlPIGxvY2F0aW9uDQo+ICsgKiBAZHN0OiBkZXN0aW5hdGlvbiwgaW4gTU1JTyBzcGFjZSAobXVz
dCBiZSA1MTItYml0IGFsaWduZWQpDQo+ICsgKiBAc3JjOiBzb3VyY2UNCj4gKyAqDQo+ICsgKiBU
aGUgRU5RQ01EUyBpbnN0cnVjdGlvbiBhbGxvd3Mgc29mdHdhcmUgdG8gd3JpdGUgYSA1MTIgYml0
cyBjb21tYW5kIHRvDQo+ICsgKiBhIDUxMiBiaXRzIGFsaWduZWQgc3BlY2lhbCBNTUlPIHJlZ2lv
biB0aGF0IHN1cHBvcnRzIHRoZSBpbnN0cnVjdGlvbi4NCj4gKyAqIEEgcmV0dXJuIHN0YXR1cyBp
cyBsb2FkZWQgaW50byB0aGUgWkYgZmxhZyBpbiB0aGUgUkZMQUdTIHJlZ2lzdGVyLg0KPiArICog
WkYgPSAwIGVxdWF0ZXMgdG8gc3VjY2VzcywgYW5kIFpGID0gMSBpbmRpY2F0ZXMgcmV0cnkgb3Ig
ZXJyb3IuDQo+ICsgKg0KPiArICogVGhlIGVucWNtZHMoKSBmdW5jdGlvbiB1c2VzIHRoZSBFTlFD
TURTIGluc3RydWN0aW9uIHRvIHN1Ym1pdCBkYXRhIGZyb20NCj4gKyAqIGtlcm5lbCBzcGFjZSB0
byBNTUlPIHNwYWNlLCBpbiBhIHVuaXQgb2YgNTEyIGJpdHMuIE9yZGVyIG9mIGRhdGEgYWNjZXNz
DQo+ICsgKiBpcyBub3QgZ3VhcmFudGVlZCwgbm9yIGlzIGEgbWVtb3J5IGJhcnJpZXIgcGVyZm9y
bWVkIGFmdGVyd2FyZHMuIFRoZQ0KPiArICogZnVuY3Rpb24gcmV0dXJucyAwIG9uIHN1Y2Nlc3Mg
YW5kIC1FQUdBSU4gb24gZmFpbHVyZS4NCj4gKyAqDQo+ICsgKiBXYXJuaW5nOiBEbyBub3QgdXNl
IHRoaXMgaGVscGVyIHVubGVzcyB5b3VyIGRyaXZlciBoYXMgY2hlY2tlZCB0aGF0IHRoZSBDUFUN
Cj4gKyAqIGluc3RydWN0aW9uIGlzIHN1cHBvcnRlZCBvbiB0aGUgcGxhdGZvcm0gYW5kIHRoZSBk
ZXZpY2UgYWNjZXB0cyBFTlFDTURTLg0KPiArICovDQo+ICtzdGF0aWMgaW5saW5lIGludCBlbnFj
bWRzKHZvaWQgX19pb21lbSAqZHN0LCBjb25zdCB2b2lkICpzcmMpDQo+ICt7DQo+ICsJaW50IHpm
Ow0KPiArDQo+ICsJLyogRU5RQ01EUyBbcmR4XSwgcmF4ICovDQo+ICsJYXNtIHZvbGF0aWxlKCIu
Ynl0ZSAweGYzLCAweDBmLCAweDM4LCAweGY4LCAweDAyLCAweDY2LCAweDkwIg0KPiArCQkgICAg
IENDX1NFVCh6KQ0KPiArCQkgICAgIDogQ0NfT1VUKHopICh6ZikNCj4gKwkJICAgICA6ICJhIiAo
ZHN0KSwgImQiIChzcmMpKTsNCj4gKwkvKiBTdWJtaXNzaW9uIGZhaWx1cmUgaXMgaW5kaWNhdGVk
IHZpYSBFRkxBR1MuWkY9MSAqLw0KPiArCWlmICh6ZikNCj4gKwkJcmV0dXJuIC1FQUdBSU47DQo+
ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KDQoNCkRvZXNuJ3QgdGhpcyBuZWVkIGFuICJt
IiBpbnB1dCBjb25zdHJhaW50IGZvciB0aGUgc291cmNlIGJ1ZmZlci4NCk90aGVyd2lzZSBpZiBp
dCBpcyBhIGxvY2FsIG9uLXN0YWNrIGJ1ZmZlciB0aGUgY29tcGlsZXINCndpbGwgb3B0aW1pc2Ug
YXdheSB0aGUgaW5zdHJ1Y3Rpb25zIHRoYXQgd3JpdGUgdG8gaXQuDQoNClRoZSBtaXNzaW5nIG91
dHB1dCBtZW1vcnkgY29uc3RyYWludCBpcyBsZXNzIG9mIGEgcHJvYmxlbS4NClRoZSBkcml2ZXIg
bmVlZHMgdG8gYmUgdXNpbmcgYmFycmllcnMgb2YgaXRzIG93bi4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

