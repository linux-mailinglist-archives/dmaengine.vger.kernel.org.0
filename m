Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4535C1F7519
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2020 10:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgFLIOA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Jun 2020 04:14:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48266 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726264AbgFLIOA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Jun 2020 04:14:00 -0400
X-UUID: d5d6f6122080406ebe9cdfcfe03565a6-20200612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=0GUyHvRF9VSyT75UO1lemvQzocW+/xKvL/7X1JD+e3c=;
        b=kyvH0EUBv92HPX2ACqV0iGmIsriy/5p9EwSAR3r4T1xcSU5vwKwEtzt9COkq0ShUR8M9thPr/QQ9I5d26rbTQtS7gHAh7GNGONyzcGjpBUtQ/Hluusz7r4KZYYDlIFvp1q+oJolP3loCoYOKwriwq0zoG8DWbE7y64Jmbkg3FZg=;
X-UUID: d5d6f6122080406ebe9cdfcfe03565a6-20200612
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1851533519; Fri, 12 Jun 2020 16:13:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 12 Jun 2020 16:13:54 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Jun 2020 16:13:53 +0800
Message-ID: <1591949635.23595.9.camel@mtkswgap22>
Subject: Re: [PATCH v4 4/4] dmaengine: mediatek-cqdma: add dma mask for
 capability
From:   EastL <EastL.Lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Sean Wang <sean.wang@mediatek.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Fri, 12 Jun 2020 16:13:55 +0800
In-Reply-To: <ea26fb2c-aec0-c031-ac30-9e5099943d9c@gmail.com>
References: <1590659832-31476-1-git-send-email-EastL.Lee@mediatek.com>
         <1590659832-31476-5-git-send-email-EastL.Lee@mediatek.com>
         <ea26fb2c-aec0-c031-ac30-9e5099943d9c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gVGh1LCAyMDIwLTA1LTI4IGF0IDE2OjEwICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjgvMDUvMjAyMCAxMTo1NywgRWFzdEwgd3JvdGU6DQo+ID4gVGhpcyBwYXRj
aCBhZGQgZG1hIG1hc2sgZm9yIGNhcGFiaWxpdHkuDQo+ID4gDQo+ID4gQ2hhbmdlLUlkOiBJMzFm
NDYyMmY5NTQxZDc2OTcwMjAyOTUzMmU1ZjVmMTg1ODE1ZGRhMg0KPiANCj4gTm8gQ2hhbmdlLUlk
IGluIHRoZSBjb21taXQgbWVzc2FnZSBwbGVhc2UuDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEVh
c3RMIDxFYXN0TC5MZWVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2RtYS9t
ZWRpYXRlay9tdGstY3FkbWEuYyB8IDEzICsrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDEzIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEv
bWVkaWF0ZWsvbXRrLWNxZG1hLmMgYi9kcml2ZXJzL2RtYS9tZWRpYXRlay9tdGstY3FkbWEuYw0K
PiA+IGluZGV4IGJjYTcxMTguLjE4MDVhNzYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9kbWEv
bWVkaWF0ZWsvbXRrLWNxZG1hLmMNCj4gPiArKysgYi9kcml2ZXJzL2RtYS9tZWRpYXRlay9tdGst
Y3FkbWEuYw0KPiA+IEBAIC0xMTcsNiArMTE3LDcgQEAgc3RydWN0IG10a19jcWRtYV92Y2hhbiB7
DQo+ID4gICAqIEBjbGs6ICAgICAgICAgICAgICAgICAgICBUaGUgY2xvY2sgdGhhdCBkZXZpY2Ug
aW50ZXJuYWwgaXMgdXNpbmcNCj4gPiAgICogQGRtYV9yZXF1ZXN0czogICAgICAgICAgIFRoZSBu
dW1iZXIgb2YgVkNzIHRoZSBkZXZpY2Ugc3VwcG9ydHMgdG8NCj4gPiAgICogQGRtYV9jaGFubmVs
czogICAgICAgICAgIFRoZSBudW1iZXIgb2YgUENzIHRoZSBkZXZpY2Ugc3VwcG9ydHMgdG8NCj4g
PiArICogQGRtYV9tYXNrOiAgICAgICAgICAgICAgIEEgbWFzayBmb3IgRE1BIGNhcGFiaWxpdHkN
Cj4gPiAgICogQHZjOiAgICAgICAgICAgICAgICAgICAgIFRoZSBwb2ludGVyIHRvIGFsbCBhdmFp
bGFibGUgVkNzDQo+ID4gICAqIEBwYzogICAgICAgICAgICAgICAgICAgICBUaGUgcG9pbnRlciB0
byBhbGwgdGhlIHVuZGVybHlpbmcgUENzDQo+ID4gICAqLw0KPiA+IEBAIC0xMjYsNiArMTI3LDcg
QEAgc3RydWN0IG10a19jcWRtYV9kZXZpY2Ugew0KPiA+ICANCj4gPiAgCXUzMiBkbWFfcmVxdWVz
dHM7DQo+ID4gIAl1MzIgZG1hX2NoYW5uZWxzOw0KPiA+ICsJdTMyIGRtYV9tYXNrOw0KPiA+ICAJ
c3RydWN0IG10a19jcWRtYV92Y2hhbiAqdmM7DQo+ID4gIAlzdHJ1Y3QgbXRrX2NxZG1hX3BjaGFu
ICoqcGM7DQo+ID4gIH07DQo+ID4gQEAgLTU0OSw2ICs1NTEsNyBAQCBzdGF0aWMgdm9pZCBtdGtf
Y3FkbWFfaHdfZGVpbml0KHN0cnVjdCBtdGtfY3FkbWFfZGV2aWNlICpjcWRtYSkNCj4gPiAgfTsN
Cj4gPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXRrX2NxZG1hX21hdGNoKTsNCj4gPiAgDQo+
ID4gK3N0YXRpYyB1NjQgY3FkbWFfZG1hbWFzazsNCj4gPiAgc3RhdGljIGludCBtdGtfY3FkbWFf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgew0KPiA+ICAJc3RydWN0
IG10a19jcWRtYV9kZXZpY2UgKmNxZG1hOw0KPiA+IEBAIC02MDcsNiArNjEwLDE2IEBAIHN0YXRp
YyBpbnQgbXRrX2NxZG1hX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4g
IAkJY3FkbWEtPmRtYV9jaGFubmVscyA9IE1US19DUURNQV9OUl9QQ0hBTlM7DQo+ID4gIAl9DQo+
ID4gIA0KPiA+ICsJaWYgKHBkZXYtPmRldi5vZl9ub2RlICYmIG9mX3Byb3BlcnR5X3JlYWRfdTMy
KHBkZXYtPmRldi5vZl9ub2RlLA0KPiA+ICsJCQkJCQkgICAgICAiZG1hLWNoYW5uZWwtbWFzayIs
DQo+ID4gKwkJCQkJCSAgICAgICZjcWRtYS0+ZG1hX21hc2spKSB7DQo+IA0KPiBJJ2QgcHJlZmVy
Og0KPiANCj4gaWYgKHBkZXYtPmRldi5vZl9ub2RlKQ0KPiAgICAgcmV0ID0gb2ZfcHJvcGVydHlf
cmVhZF91MzIocGRldi0+ZGV2Lm9mX25vZGUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiZG1hLWNoYW5uZWwtbWFzayIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmY3FkbWEtPmRtYV9tYXNrKSkNCj4gaWYgKHJldCkgew0KPiAgICAgZGV2X3dhcm4oJnBkZXYt
PmRldiwNCj4gICAgICAgICAgICAgICJVc2luZyAwIGFzIG1pc3NpbmcgZG1hLWNoYW5uZWwtbWFz
aw0KPiAgICAgICAgICAgICAgIHByb3BlcnR5XG4iKTsNCj4gICAgIGNxZG1hLT5kbWFfbWFzayA9
IDA7DQo+IH0NCj4gDQo+ID4gKwkJZGV2X2luZm8oJnBkZXYtPmRldiwNCj4gPiArCQkJICJVc2lu
ZyAwIGFzIG1pc3NpbmcgZG1hLWNoYW5uZWwtbWFzayBwcm9wZXJ0eVxuIik7DQo+IA0KPiBkZXZf
d2FybiBzaG91bGQgYmUgT0suDQo+IA0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQljcWRtYV9kbWFt
YXNrID0gRE1BX0JJVF9NQVNLKGNxZG1hLT5kbWFfbWFzayk7DQo+ID4gKwkJcGRldi0+ZGV2LmRt
YV9tYXNrID0gJmNxZG1hX2RtYW1hc2s7DQo+IA0KPiBpZiAoZG1hX3NldF9tYXNrKCZwZGV2LT5k
ZXYsDQo+ICAgICBETUFfQklUX01BU0soY3FkbWEtPmRtYV9tYXNrKSkgew0KPiAgICAgICAgICAv
KiBlcnJvciBvdXQgKi8NCj4gfQ0KPiANCk9LLCBJJ2xsIGZpeCBpdCBvbiBuZXh0IHZlcnNpb24u
DQoNCj4gPiArCX0NCj4gPiArDQo+ID4gIAljcWRtYS0+cGMgPSBkZXZtX2tjYWxsb2MoJnBkZXYt
PmRldiwgY3FkbWEtPmRtYV9jaGFubmVscywNCj4gPiAgCQkJCSBzaXplb2YoKmNxZG1hLT5wYyks
IEdGUF9LRVJORUwpOw0KPiA+ICAJaWYgKCFjcWRtYS0+cGMpDQo+ID4gDQoNCg==

