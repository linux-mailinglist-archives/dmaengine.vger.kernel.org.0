Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B011F631F
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2020 10:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgFKIAU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Jun 2020 04:00:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50183 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726841AbgFKIAU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Jun 2020 04:00:20 -0400
X-UUID: 3425f3c71903411db3d9adf6ff997c7d-20200611
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ymFyA3aRkGFQ0hwS3c5JqbCS9zGTSs9AXR5E+TUVjRw=;
        b=IMcY6+ndne/pmzJYoDIvoKGGLZDsmRyLtkaBoT9f9k3kS042rQr2UNfVVjFsMNaU0TIrg1vDpeIFOhntx/+VzslwpHRyXvmBu/Aw5OmqYguvwR5+02g/yR/n8LERFqQ/VcTlDVb05mwkpoo8Ar5MVDjfgePkYsYuOZW1mxMvjLM=;
X-UUID: 3425f3c71903411db3d9adf6ff997c7d-20200611
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 462532237; Thu, 11 Jun 2020 16:00:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 11 Jun 2020 16:00:10 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Jun 2020 16:00:10 +0800
Message-ID: <1591862411.23595.5.camel@mtkswgap22>
Subject: Re: [PATCH v4 1/4] dt-bindings: dmaengine: Add MediaTek
 Command-Queue DMA controller bindings
From:   EastL <EastL.Lee@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>, <vkoul@kernel.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Thu, 11 Jun 2020 16:00:11 +0800
In-Reply-To: <20200529192443.GA2785767@bogus>
References: <1590659832-31476-1-git-send-email-EastL.Lee@mediatek.com>
         <1590659832-31476-2-git-send-email-EastL.Lee@mediatek.com>
         <20200529192443.GA2785767@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E454FB0951BC790B45883925983748159758D5FE3D941C0A086BA0DD8420AA522000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gRnJpLCAyMDIwLTA1LTI5IGF0IDEzOjI0IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVGh1LCBNYXkgMjgsIDIwMjAgYXQgMDU6NTc6MDlQTSArMDgwMCwgRWFzdEwgd3JvdGU6DQo+
ID4gRG9jdW1lbnQgdGhlIGRldmljZXRyZWUgYmluZGluZ3MgZm9yIE1lZGlhVGVrIENvbW1hbmQt
UXVldWUgRE1BIGNvbnRyb2xsZXINCj4gPiB3aGljaCBjb3VsZCBiZSBmb3VuZCBvbiBNVDY3Nzkg
U29DIG9yIG90aGVyIHNpbWlsYXIgTWVkaWF0ZWsgU29Dcy4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBFYXN0TCA8RWFzdEwuTGVlQG1lZGlhdGVrLmNvbT4NCj4gDQo+IE5lZWQgYSBmdWxsIG5h
bWUNCg0KT0sNCj4gLg0KPiANCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZG1hL210ay1jcWRtYS55YW1sICAgICAgICAgfCAxMDAgKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9tdGstY3FkbWEueWFt
bA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZG1hL210ay1jcWRtYS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2RtYS9tdGstY3FkbWEueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXgg
MDAwMDAwMC4uMDQ1YWEwYw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210ay1jcWRtYS55YW1sDQo+ID4gQEAgLTAsMCAr
MSwxMDAgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiANCj4g
RHVhbCBsaWNlbnNlIG5ldyBiaW5kaW5nczoNCj4gDQo+IChHUEwtMi4wLW9ubHkgT1IgQlNELTIt
Q2xhdXNlKQ0KDQpPSw0KPiANCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2RtYS9tdGstY3FkbWEueWFtbCMNCj4gPiArJHNj
aGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4g
Kw0KPiA+ICt0aXRsZTogTWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxlciBEZXZp
Y2UgVHJlZSBCaW5kaW5nDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIEVhc3RM
IDxFYXN0TC5MZWVAbWVkaWF0ZWsuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246DQo+ID4g
KyAgTWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxlciAoQ1FETUEpIG9uIE1lZGlh
dGVrIFNvQw0KPiA+ICsgIGlzIGRlZGljYXRlZCB0byBtZW1vcnktdG8tbWVtb3J5IHRyYW5zZmVy
IHRocm91Z2ggcXVldWUgYmFzZWQNCj4gPiArICBkZXNjcmlwdG9yIG1hbmFnZW1lbnQuDQo+ID4g
Kw0KPiANCj4gTmVlZCBhICRyZWYgdG8gZG1hLWNvbnRyb2xsZXIueWFtbA0KDQpPSw0KPiANCj4g
PiArcHJvcGVydGllczoNCj4gPiArICAiI2RtYS1jZWxscyI6DQo+ID4gKyAgICBtaW5pbXVtOiAx
DQo+ID4gKyAgICAjIFNob3VsZCBiZSBlbm91Z2gNCj4gPiArICAgIG1heGltdW06IDI1NQ0KPiA+
ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIFVzZWQgdG8gcHJvdmlkZSBETUEgY29udHJv
bGxlciBzcGVjaWZpYyBpbmZvcm1hdGlvbi4NCj4gPiArDQo+ID4gKyAgY29tcGF0aWJsZToNCj4g
PiArICAgIGNvbnN0OiBtZWRpYXRlayxjcWRtYQ0KPiANCj4gTmVlZHMgU29DIHNwZWNpZmljIGNv
bXBhdGlibGUgc3RyaW5nKHMpLg0KT0sNCj4gDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAg
IG1pbkl0ZW1zOiAxDQo+ID4gKyAgICBtYXhJdGVtczogMjU1DQo+IA0KPiBZb3UgY2FuIGhhdmUg
MjU1IHJlZ2lzdGVyIHJlZ2lvbnM/DQpObywgSSdsbCBmaXggbWF4SXRlbXMgdG8gNQ0KPiANCj4g
WW91IG5lZWQgdG8gZGVmaW5lIHdoYXQgZWFjaCByZWdpb24gaXMgaWYgbW9yZSB0aGFuIDEuDQo+
IA0KPiA+ICsNCj4gPiArICBpbnRlcnJ1cHRzOg0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiAr
ICAgIG1heEl0ZW1zOiAyNTUNCj4gDQo+IDI1NSBpbnRlcnJ1cHRzPw0KDQp0aGUgc2FtZSwgNSBp
bnRlcnJpcHRzLg0KPiANCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgbWF4SXRlbXM6
IDENCj4gPiArDQo+ID4gKyAgY2xvY2stbmFtZXM6DQo+ID4gKyAgICBjb25zdDogY3FkbWENCj4g
PiArDQo+ID4gKyAgZG1hLWNoYW5uZWwtbWFzazoNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+
ICsgICAgICBCaXRtYXNrIG9mIGF2YWlsYWJsZSBETUEgY2hhbm5lbHMgaW4gYXNjZW5kaW5nIG9y
ZGVyIHRoYXQgYXJlDQo+ID4gKyAgICAgIG5vdCByZXNlcnZlZCBieSBmaXJtd2FyZSBhbmQgYXJl
IGF2YWlsYWJsZSB0byB0aGUNCj4gPiArICAgICAga2VybmVsLiBpLmUuIGZpcnN0IGNoYW5uZWwg
Y29ycmVzcG9uZHMgdG8gTFNCLg0KPiA+ICsgICAgICBUaGUgZmlyc3QgaXRlbSBpbiB0aGUgYXJy
YXkgaXMgZm9yIGNoYW5uZWxzIDAtMzEsIHRoZSBzZWNvbmQgaXMgZm9yDQo+ID4gKyAgICAgIGNo
YW5uZWxzIDMyLTYzLCBldGMuDQo+ID4gKyAgICBhbGxPZjoNCj4gPiArICAgICAgLSAkcmVmOiAv
c2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzItYXJyYXkNCj4gPiArICAgIGl0
ZW1zOg0KPiA+ICsgICAgICBtaW5JdGVtczogMQ0KPiA+ICsgICAgICAjIFNob3VsZCBiZSBlbm91
Z2gNCj4gPiArICAgICAgbWF4SXRlbXM6IDI1NQ0KPiANCj4gVGhpcyBhbHJlYWR5IGhhcyBhIGRl
ZmluaXRpb24gaW4gZG1hLWNvbW1vbi55YW1sLiBEb24ndCBjb3B5LW4tcGFzdGUgDQo+IGl0LiBK
dXN0IGFkZCBhbnkgY29uc3RyYWludHMgeW91IGhhdmUuIExpa2Ugd2hhdCBpcyB0aGUgbWF4IG51
bWJlciBvZiANCj4gY2hhbm5lbHM/DQoNCk9LLCB0aGUgbWF4IGNoYW5uZWwgbnVtYmVyIGlzIDUs
IEknbGwgZml4IGl0IG9uIG5leHQgdmVyc2lvbi4NCj4gDQo+ID4gKw0KPiA+ICsgIGRtYS1jaGFu
bmVsczoNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjZGVmaW5pdGlvbnMvdWlu
dDMyDQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgTnVtYmVyIG9mIERNQSBjaGFu
bmVscyBzdXBwb3J0ZWQgYnkgdGhlIGNvbnRyb2xsZXIuDQo+ID4gKw0KPiA+ICsgIGRtYS1yZXF1
ZXN0czoNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjZGVmaW5pdGlvbnMvdWlu
dDMyDQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgTnVtYmVyIG9mIERNQSByZXF1
ZXN0IHNpZ25hbHMgc3VwcG9ydGVkIGJ5IHRoZSBjb250cm9sbGVyLg0KPiANCj4gU2FtZSBjb21t
ZW50IG9uIHRoZXNlIDIuDQoNCk9LDQo+IA0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAg
LSAiI2RtYS1jZWxscyINCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsg
IC0gaW50ZXJydXB0cw0KPiA+ICsgIC0gY2xvY2tzDQo+ID4gKyAgLSBjbG9jay1uYW1lcw0KPiA+
ICsgIC0gZG1hLWNoYW5uZWwtbWFzaw0KPiA+ICsgIC0gZG1hLWNoYW5uZWxzDQo+ID4gKyAgLSBk
bWEtcmVxdWVzdHMNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+
ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+ICsgICAgI2luY2x1
ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL210Njc3OS1jbGsuaD4NCj4gPiArICAgIGNxZG1hOiBkbWEt
Y29udHJvbGxlckAxMDIxMjAwMCB7DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxjcWRtYSI7DQo+ID4gKyAgICAgICAgcmVnID0gPDAgMHgxMDIxMjAwMCAwIDB4ODA+LA0KPiA+
ICsgICAgICAgICAgICA8MCAweDEwMjEyMDgwIDAgMHg4MD4sDQo+ID4gKyAgICAgICAgICAgIDww
IDB4MTAyMTIxMDAgMCAweDgwPjsNCj4gDQo+IEV4YW1wbGVzIGRlZmF1bHQgdG8gMSBjZWxsIGVh
Y2ggZm9yIGFkZHJlc3MgYW5kIHNpemUuDQpPSw0KPiANCj4gPiArICAgICAgICBpbnRlcnJ1cHRz
ID0gPEdJQ19TUEkgMTM5IElSUV9UWVBFX0xFVkVMX0xPVz4sDQo+ID4gKyAgICAgICAgICAgIDxH
SUNfU1BJIDE0MCBJUlFfVFlQRV9MRVZFTF9MT1c+LA0KPiA+ICsgICAgICAgICAgICA8R0lDX1NQ
SSAxNDEgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCj4gPiArICAgICAgICBjbG9ja3MgPSA8JmluZnJh
Y2ZnX2FvIENMS19JTkZSQV9DUV9ETUE+Ow0KPiA+ICsgICAgICAgIGNsb2NrLW5hbWVzID0gImNx
ZG1hIjsNCj4gPiArICAgICAgICBkbWEtY2hhbm5lbC1tYXNrID0gPDYzPjsNCj4gPiArICAgICAg
ICBkbWEtY2hhbm5lbHMgPSA8Mz47DQo+ID4gKyAgICAgICAgZG1hLXJlcXVlc3RzID0gPDMyPjsN
Cj4gPiArICAgICAgICAjZG1hLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgfTsNCj4gPiArDQo+ID4g
Ky4uLg0KPiA+IC0tIA0KPiA+IDEuOS4xDQoNCg==

