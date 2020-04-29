Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7205C1BD342
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2020 05:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgD2DxI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Apr 2020 23:53:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:27427 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726548AbgD2DxI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Apr 2020 23:53:08 -0400
X-UUID: b3b0f4c0bfa34ad5b826e995e7092c8a-20200429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=OiZgzIWXliTigMWS4ngHmC2XsFCzxE9JvxbFZlR5Y5A=;
        b=pum+Q+O5Zp2uxHclGYj9cXsT8SoFWIVRHAE44jy8rMaHtkwvzjTDHCVLKwZDxTSDb9/VXfQbXXqfMb/sFnS8IwTzQxOfFEMzLMCCbzxrLdhCmoEpAwYW4XAhWRMBQea5tVJnzld4V7EYuEZkaxp8o5jG722jRxyzcdvLg8/vvIA=;
X-UUID: b3b0f4c0bfa34ad5b826e995e7092c8a-20200429
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 915013963; Wed, 29 Apr 2020 11:53:05 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Apr 2020 11:53:03 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Apr 2020 11:53:02 +0800
Message-ID: <1588132383.16498.2.camel@mtkswgap22>
Subject: Re: [PATCH v3 1/2] dt-bindings: dmaengine: Add MediaTek
 Command-Queue DMA controller bindings
From:   EastL <EastL.Lee@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Wed, 29 Apr 2020 11:53:03 +0800
In-Reply-To: <1588125274311004.11906.seg@mailgw02.mediatek.com>
References: <1587955977-17207-1-git-send-email-EastL.Lee@mediatek.com>
         <1587955977-17207-2-git-send-email-EastL.Lee@mediatek.com>
         <1588125274311004.11906.seg@mailgw02.mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: EA5880C4AA2B61D894C249225ED43DB19CC852CE1078F1987B00AF67E97FC2DB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTI3IGF0IDE2OjMyIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCAyNyBBcHIgMjAyMCAxMDo1Mjo1NiArMDgwMCwgRWFzdEwgd3JvdGU6DQo+ID4gRG9j
dW1lbnQgdGhlIGRldmljZXRyZWUgYmluZGluZ3MgZm9yIE1lZGlhVGVrIENvbW1hbmQtUXVldWUg
RE1BIGNvbnRyb2xsZXINCj4gPiB3aGljaCBjb3VsZCBiZSBmb3VuZCBvbiBNVDY3NzkgU29DIG9y
IG90aGVyIHNpbWlsYXIgTWVkaWF0ZWsgU29Dcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBF
YXN0TCA8RWFzdEwuTGVlQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRy
ZWUvYmluZGluZ3MvZG1hL210ay1jcWRtYS55YW1sICAgICAgICAgfCA5OCArKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCspDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210
ay1jcWRtYS55YW1sDQo+ID4gDQo+IA0KPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5pbmcgJ21h
a2UgZHRfYmluZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCj4gDQo+IC9idWlsZHMvcm9iaGVy
cmluZy9saW51eC1kdC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rt
YS9tdGstY3FkbWEuZXhhbXBsZS5kdC55YW1sOiBkbWEtY29udHJvbGxlckAxMDIxMjAwMDogaW50
ZXJydXB0czogW1swLCAxMzksIDhdLCBbMCwgMTQwLCA4XSwgWzAsIDE0MSwgOF1dIGlzIHRvbyBz
aG9ydA0KPiAvYnVpbGRzL3JvYmhlcnJpbmcvbGludXgtZHQtcmV2aWV3L0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvbXRrLWNxZG1hLmV4YW1wbGUuZHQueWFtbDogZG1hLWNv
bnRyb2xsZXJAMTAyMTIwMDA6IHJlZzogW1swLCAyNzA2MDYzMzYsIDAsIDEyOF0sIFswLCAyNzA2
MDY0NjQsIDAsIDEyOF0sIFswLCAyNzA2MDY1OTIsIDAsIDEyOF1dIGlzIHRvbyBzaG9ydA0KPiAN
Cj4gU2VlIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvMTI3NzI5Mg0KPiANCj4g
SWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIGFuZCBkaWRuJ3Qgc2Vl
IHRoZSBhYm92ZQ0KPiBlcnJvcihzKSwgdGhlbiBtYWtlIHN1cmUgZHQtc2NoZW1hIGlzIHVwIHRv
IGRhdGU6DQo+IA0KPiBwaXAzIGluc3RhbGwgZ2l0K2h0dHBzOi8vZ2l0aHViLmNvbS9kZXZpY2V0
cmVlLW9yZy9kdC1zY2hlbWEuZ2l0QG1hc3RlciAtLXVwZ3JhZGUNCj4gDQo+IFBsZWFzZSBjaGVj
ayBhbmQgcmUtc3VibWl0Lg0KDQpPSywgSSdsbCBmaXggaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQo=

