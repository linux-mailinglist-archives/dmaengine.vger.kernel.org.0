Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FED2EBB9F
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jan 2021 10:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbhAFJ0a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jan 2021 04:26:30 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:53879 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725868AbhAFJ03 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jan 2021 04:26:29 -0500
X-UUID: 1b1acfb439384d78a32acd87f25d5b70-20210106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zOuLnq2988VcCoJP2KaUOG1UC0p7HGPhxsgATLl5fuU=;
        b=q1aDPvqbJEz8uedknKGYXsOPVx3xFNpHppP5FHHAOdz7kfe8Qd3WkTCG/zaIeFlr0HH30f8CgWVBQjb5Rv1LAiTXDbo3IsLQM2pe5E07rgfQ+GGcbojW5S9I2kewCYW56Z5W45Aj9nRfE2TRgCRe9b5v10zlrC9ZCTACIxmBkIA=;
X-UUID: 1b1acfb439384d78a32acd87f25d5b70-20210106
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 603406478; Wed, 06 Jan 2021 17:25:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 Jan 2021 17:25:40 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Jan 2021 17:25:40 +0800
Message-ID: <1609925140.5373.5.camel@mtkswgap22>
Subject: Re: [PATCH v8 1/4] dt-bindings: dmaengine: Add MediaTek
 Command-Queue DMA controller bindings
From:   EastL <EastL.Lee@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>, <vkoul@kernel.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>
Date:   Wed, 6 Jan 2021 17:25:40 +0800
In-Reply-To: <20210103165842.GA4024251@robh.at.kernel.org>
References: <1608715847-28956-1-git-send-email-EastL.Lee@mediatek.com>
         <1608715847-28956-2-git-send-email-EastL.Lee@mediatek.com>
         <20210103165842.GA4024251@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gU3VuLCAyMDIxLTAxLTAzIGF0IDA5OjU4IC0wNzAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gV2VkLCBEZWMgMjMsIDIwMjAgYXQgMDU6MzA6NDRQTSArMDgwMCwgRWFzdEwgTGVlIHdyb3Rl
Og0KPiA+IERvY3VtZW50IHRoZSBkZXZpY2V0cmVlIGJpbmRpbmdzIGZvciBNZWRpYVRlayBDb21t
YW5kLVF1ZXVlIERNQSBjb250cm9sbGVyDQo+ID4gd2hpY2ggY291bGQgYmUgZm91bmQgb24gTVQ2
Nzc5IFNvQyBvciBvdGhlciBzaW1pbGFyIE1lZGlhdGVrIFNvQ3MuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogRWFzdEwgTGVlIDxFYXN0TC5MZWVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvbXRrLWNxZG1hLnlhbWwgICAgICAgICB8IDEw
NCArKysrKysrKysrKysrKysrKysrKysNCj4gDQo+IFVzZSBjb21wYXRpYmxlIHN0cmluZyBmb3Ig
ZmlsZW5hbWU6DQpPSw0KPiANCj4gbWVkaWF0ZWssY3FkbWEueWFtbA0KPiANCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEwNCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210ay1jcWRtYS55YW1sDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvbXRr
LWNxZG1hLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210ay1j
cWRtYS55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi5h
NzZhMjYzDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kbWEvbXRrLWNxZG1hLnlhbWwNCj4gPiBAQCAtMCwwICsxLDEwNCBAQA0K
PiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNs
YXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9zY2hlbWFzL2RtYS9tdGstY3FkbWEueWFtbCMNCj4gDQo+IERvbid0IGZvcmdldCB0
byB1cGRhdGUgdGhpcy4NCk9LDQo+IA0KPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5v
cmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiArDQo+ID4gK3RpdGxlOiBNZWRpYVRlayBD
b21tYW5kLVF1ZXVlIERNQSBjb250cm9sbGVyIERldmljZSBUcmVlIEJpbmRpbmcNCj4gPiArDQo+
ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gRWFzdEwgTGVlIDxFYXN0TC5MZWVAbWVkaWF0ZWsu
Y29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246DQo+ID4gKyAgTWVkaWFUZWsgQ29tbWFuZC1R
dWV1ZSBETUEgY29udHJvbGxlciAoQ1FETUEpIG9uIE1lZGlhdGVrIFNvQw0KPiA+ICsgIGlzIGRl
ZGljYXRlZCB0byBtZW1vcnktdG8tbWVtb3J5IHRyYW5zZmVyIHRocm91Z2ggcXVldWUgYmFzZWQN
Cj4gPiArICBkZXNjcmlwdG9yIG1hbmFnZW1lbnQuDQo+ID4gKw0KPiA+ICthbGxPZjoNCj4gPiAr
ICAtICRyZWY6ICJkbWEtY29udHJvbGxlci55YW1sIyINCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6
DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGVudW06
DQo+ID4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10Njc2NS1jcWRtYQ0KPiA+ICsgICAgICAgICAg
LSBtZWRpYXRlayxtdDY3NzktY3FkbWENCj4gPiArICAgICAgLSBjb25zdDogbWVkaWF0ZWssY3Fk
bWENCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiArICAgIG1h
eEl0ZW1zOiA1DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgICBBIGJhc2UgYWRk
cmVzcyBvZiBNZWRpYVRlayBDb21tYW5kLVF1ZXVlIERNQSBjb250cm9sbGVyLA0KPiA+ICsgICAg
ICAgIGEgY2hhbm5lbCB3aWxsIGhhdmUgYSBzZXQgb2YgYmFzZSBhZGRyZXNzLg0KPiA+ICsNCj4g
PiArICBpbnRlcnJ1cHRzOg0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiArICAgIG1heEl0ZW1z
OiA1DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgICBBIGludGVycnVwdCBudW1i
ZXIgb2YgTWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxlciwNCj4gPiArICAgICAg
ICBvbmUgaW50ZXJydXB0IG51bWJlciBwZXIgZG1hLWNoYW5uZWxzLg0KPiA+ICsNCj4gPiArICBj
bG9ja3M6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBjbG9jay1uYW1lczoN
Cj4gPiArICAgIGNvbnN0OiBjcWRtYQ0KPiA+ICsNCj4gPiArICBkbWEtY2hhbm5lbC1tYXNrOg0K
PiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgICBGb3IgRE1BIGNhcGFiaWxpdHksIFdl
IHdpbGwga25vdyB0aGUgYWRkcmVzc2luZyBjYXBhYmlsaXR5IG9mDQo+ID4gKyAgICAgICBNZWRp
YVRlayBDb21tYW5kLVF1ZXVlIERNQSBjb250cm9sbGVyIHRocm91Z2ggZG1hLWNoYW5uZWwtbWFz
ay4NCj4gPiArICAgICAgbWluaW11bTogMQ0KPiA+ICsgICAgICBtYXhpbXVtOiA2Mw0KPiANCj4g
SW5kZW50YXRpb24gaXMgd3JvbmcgaGVyZSBzbyB0aGlzIGhhcyBubyBlZmZlY3QuDQpJJ2xsIGZp
eCBpdA0KPiANCj4gQSBtYXNrIG9mIDYzIGlzIDYgY2hhbm5lbHMuLi4NCkluIG15IG9waW5pb24s
IGtlcm5lbCBkbWEgbWFzayBpZiBmb3IgMzIvNjQgYml0IGNhcGFiaWxpdHkuLi4NCklmIEkgZG9u
J3Qgc2V0IGRtYSBtYXNrIEkgd2lsbCBnZXQgZmFpbCBvbiBETUFURVNULg0KPiANCj4gPiArDQo+
ID4gKyAgZG1hLWNoYW5uZWxzOg0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIE51
bWJlciBvZiBETUEgY2hhbm5lbHMgc3VwcG9ydGVkIGJ5IE1lZGlhVGVrIENvbW1hbmQtUXVldWUg
RE1BDQo+ID4gKyAgICAgIGNvbnRyb2xsZXIsIHN1cHBvcnQgdXAgdG8gZml2ZS4NCj4gPiArICAg
ICAgbWluaW11bTogMQ0KPiA+ICsgICAgICBtYXhpbXVtOiA1DQo+IA0KPiBTYW1lIGhlcmUuDQpP
Sw0KPiANCj4gRG8geW91IHJlYWxseSBuZWVkIGJvdGggZG1hLWNoYW5uZWxzIGFuZCBkbWEtY2hh
bm5lbC1tYXNrPyBZb3Ugc2hvdWxkIGJlIA0KPiBhYmxlIHRvIGdldCBvbmUgZnJvbSB0aGUgb3Ro
ZXIuDQo+IA0KPiA+ICsNCj4gPiArICBkbWEtcmVxdWVzdHM6DQo+ID4gKyAgICBkZXNjcmlwdGlv
bjoNCj4gPiArICAgICAgTnVtYmVyIG9mIERNQSByZXF1ZXN0ICh2aXJ0dWFsIGNoYW5uZWwpIHN1
cHBvcnRlZCBieSBNZWRpYVRlaw0KPiA+ICsgICAgICBDb21tYW5kLVF1ZXVlIERNQSBjb250cm9s
bGVyLCBzdXBwb3J0IHVwIHRvIDMyLg0KPiA+ICsgICAgICBtaW5pbXVtOiAxDQo+ID4gKyAgICAg
IG1heGltdW06IDMyDQo+IA0KPiBBbmQgaGVyZS4NCj4gDQo+IFlvdSBhcmUgbWlzc2luZyAnI2Rt
YS1jZWxscycgYWxzby4NCk9LIEknbGwgZml4IGl0Lg0KPiANCj4gPiArDQo+ID4gK3JlcXVpcmVk
Og0KPiA+ICsgIC0gIiNkbWEtY2VsbHMiDQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSBy
ZWcNCj4gPiArICAtIGludGVycnVwdHMNCj4gPiArICAtIGNsb2Nrcw0KPiA+ICsgIC0gY2xvY2st
bmFtZXMNCj4gPiArICAtIGRtYS1jaGFubmVsLW1hc2sNCj4gPiArICAtIGRtYS1jaGFubmVscw0K
PiA+ICsgIC0gZG1hLXJlcXVlc3RzDQo+ID4gKw0KPiA+ICthZGRpdGlvbmFsUHJvcGVydGllczog
ZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgI2luY2x1
ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KPiA+ICsgICAgI2lu
Y2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4NCj4gPiAr
ICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDY3NzktY2xrLmg+DQo+ID4gKyAgICBj
cWRtYTogZG1hLWNvbnRyb2xsZXJAMTAyMTIwMDAgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ2Nzc5LWNxZG1hIjsNCj4gDQo+IFRoaXMgc2hvdWxkIGZhaWwgdmFsaWRh
dGlvbiBiZWNhdXNlIGl0IGRvZXNuJ3QgbWF0Y2ggdGhlIHNjaGVtYS4gWW91IHJhbiANCj4gJ21h
a2UgZHRfYmluZGluZ19jaGVjaycsIHJpZ2h0Pw0KWWVzLCBidXQgSSBnb3Qgb3RoZXIgZmFpbCBv
biBrZXJuZWwtNS4xMC4uLg0KPiANCj4gPiArICAgICAgICByZWcgPSA8MHgxMDIxMjAwMCAweDgw
PiwNCj4gPiArICAgICAgICAgICAgPDB4MTAyMTIwODAgMHg4MD4sDQo+ID4gKyAgICAgICAgICAg
IDwweDEwMjEyMTAwIDB4ODA+Ow0KPiA+ICsgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSAx
MzkgSVJRX1RZUEVfTEVWRUxfTE9XPiwNCj4gPiArICAgICAgICAgICAgPEdJQ19TUEkgMTQwIElS
UV9UWVBFX0xFVkVMX0xPVz4sDQo+ID4gKyAgICAgICAgICAgIDxHSUNfU1BJIDE0MSBJUlFfVFlQ
RV9MRVZFTF9MT1c+Ow0KPiA+ICsgICAgICAgIGNsb2NrcyA9IDwmaW5mcmFjZmdfYW8gQ0xLX0lO
RlJBX0NRX0RNQT47DQo+ID4gKyAgICAgICAgY2xvY2stbmFtZXMgPSAiY3FkbWEiOw0KPiA+ICsg
ICAgICAgIGRtYS1jaGFubmVsLW1hc2sgPSA8NjM+Ow0KPiANCj4gNiBjaGFubmVscyBvci4uLg0K
PiANCj4gPiArICAgICAgICBkbWEtY2hhbm5lbHMgPSA8Mz47DQo+IA0KPiAzPw0KMyBjaGFubmVs
LCB0aGUgbWFzayBpcyBmb3IgRE1BVEVTVCBQQVNTLg0KPiANCj4gPiArICAgICAgICBkbWEtcmVx
dWVzdHMgPSA8MzI+Ow0KPiA+ICsgICAgICAgICNkbWEtY2VsbHMgPSA8MT47DQo+ID4gKyAgICB9
Ow0KPiA+ICsNCj4gPiArLi4uDQo+ID4gLS0gDQo+ID4gMS45LjENCj4gPiANCg0K

