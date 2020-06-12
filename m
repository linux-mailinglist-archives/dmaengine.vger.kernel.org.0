Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329D11F7512
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2020 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgFLINE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Jun 2020 04:13:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:2677 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726264AbgFLIND (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Jun 2020 04:13:03 -0400
X-UUID: 3ba8a42a263140749386b68f9b58ac85-20200612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=UMgcVfDJy2DNtueEsKv2oMpjTkk90WFRphgVGkekQiE=;
        b=fL52jjGyd7Q36ByJ4RxJqGCLiDVVn81WhjD37xSdQanH9IBsmmG8C8+ZaFwkMo5a7AcQNr+fsJijJH2decJIMcXqYHKTuhvNoCt5mMEa6P4CzMsF8Es+qIdRHxEDpqIdOP/oeEkG47GBDqriRl644Su+XLUT6w00FyFqvTVPOQc=;
X-UUID: 3ba8a42a263140749386b68f9b58ac85-20200612
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2056287983; Fri, 12 Jun 2020 16:13:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 12 Jun 2020 16:12:57 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Jun 2020 16:12:56 +0800
Message-ID: <1591949578.23595.8.camel@mtkswgap22>
Subject: Re: [PATCH v4 3/4] dmaengine: mediatek-cqdma: fix compatible
From:   EastL <EastL.Lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Sean Wang <sean.wang@mediatek.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Fri, 12 Jun 2020 16:12:58 +0800
In-Reply-To: <b96e9b4d-880d-885e-fc2e-56e5618eb014@gmail.com>
References: <1590659832-31476-1-git-send-email-EastL.Lee@mediatek.com>
         <1590659832-31476-4-git-send-email-EastL.Lee@mediatek.com>
         <b96e9b4d-880d-885e-fc2e-56e5618eb014@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gVGh1LCAyMDIwLTA1LTI4IGF0IDE1OjM5ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjgvMDUvMjAyMCAxMTo1NywgRWFzdEwgd3JvdGU6DQo+ID4gVGhpcyBwYXRj
aCBmaXhlcyBtZWRpYXRlay1jcWRtYSBjb21wYXRpYmxlIHRvIGNvbW1vbi4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBFYXN0TCA8RWFzdEwuTGVlQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9kbWEvbWVkaWF0ZWsvbXRrLWNxZG1hLmMgfCAyICstDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2RtYS9tZWRpYXRlay9tdGstY3FkbWEuYyBiL2RyaXZlcnMvZG1hL21lZGlh
dGVrL210ay1jcWRtYS5jDQo+ID4gaW5kZXggOTA1YmJjYi4uYmNhNzExOCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2RtYS9tZWRpYXRlay9tdGstY3FkbWEuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
ZG1hL21lZGlhdGVrL210ay1jcWRtYS5jDQo+ID4gQEAgLTU0NCw3ICs1NDQsNyBAQCBzdGF0aWMg
dm9pZCBtdGtfY3FkbWFfaHdfZGVpbml0KHN0cnVjdCBtdGtfY3FkbWFfZGV2aWNlICpjcWRtYSkN
Cj4gPiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRr
X2NxZG1hX21hdGNoW10gPSB7DQo+ID4gLQl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc2
NS1jcWRtYSIgfSwNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssY3FkbWEiIH0sDQo+
IA0KPiBXZSBjYW4ndCBqdXN0IGRlbGV0ZSBhbmQgb2xkIGNvbXBhdGlibGUuIElmIG90aGVyIGNx
ZG1hIElQIGJsb2NrcyBhcmUgdGhlIHNhbWUNCj4gYXMgbXQ2Nzk1LCB3ZSBzaG91bGQgaW5zdGVh
ZCBhZGQgZW50cmllcyBpbiB0aGUgYmluZGluZyBkZXNjcmlwdGlvbiB3aXRoDQo+IGZhbGxiYWNr
IGNvbXBhdGlibGUuIEZvciBleGFtcGxlIGZvciBtdDY3NzkgdGhlIERUUyB3b3VsZCBsb29rIGxp
a2UgdGhpczoNCj4gY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3NzktY3FkbWEiLCAibWVkaWF0
ZWssbXQ2NzY1LWNxZG1hIjsNCj4gDQo+IFRoaXMgd2F5IHdlIHRoZSBrZXJuZWwgd2lsbCB0YWtl
IGNhcmUgdG8gYmluZCB0aGUgZGV2aWNlIGFnYWluc3QgdGhlIGRyaXZlciB3aXRoDQo+IG10NzY2
NS1jcWRtYSwgYnV0IGxlYXZlcyB1cyB0aGUgcG9zaWJpbGxpdHkgdG8gYWRkIGFueSBjaGFuZ2Vz
IHRvIHRoZSBkcml2ZXIgaW4NCj4gdGhlIGZ1dHVyZSBpZiB3ZSBmaW5kIHNvbWUgYnVncy9mZWF0
dXJlcyBmb3IgbXQ2Nzc5IHRoYXQgYXJlIG5vdCBwcmVzZW50IGluIG10Njc2NS4NCj4gDQo+IFJl
Z2FyZHMsDQo+IE1hdHRoaWFzDQo+IA0KPiA+ICAJeyAvKiBzZW50aW5lbCAqLyB9DQo+ID4gIH07
DQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG10a19jcWRtYV9tYXRjaCk7DQo+ID4gDQoN
Ck9LLCBDYW4gSSBhZGQgYSBjb21tb24gY29tcGF0aWJsZT8gTGlrZSB0aGlzDQoNCnN0YXRpYyBj
b25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19jcWRtYV9tYXRjaFtdID0gew0KeyAuY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDY3NjUtY3FkbWEiIH0sDQp7IC5jb21wYXRpYmxlID0gIm1lZGlh
dGVrLGNvbW1vbi1jcWRtYSIgfSwNCg0KDQpSZWdhcmRzLA0KRWFzdEwNCg==

