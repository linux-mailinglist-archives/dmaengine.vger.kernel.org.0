Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3448423D6CA
	for <lists+dmaengine@lfdr.de>; Thu,  6 Aug 2020 08:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgHFG10 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Aug 2020 02:27:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:65192 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726051AbgHFG10 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Aug 2020 02:27:26 -0400
X-UUID: 2fc2f2a842ec4c078ca32d6b7ed97daf-20200806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=0AEHGNsfy4Kowym5Y/9MX+FAdIMhxa+q99bMpmtdLlk=;
        b=SmiOYQX5nyus4h0miAuTv0wdQMYEQaHIIwRMlc3P5i506JhUbx5z30hsDOB89C96iB3eHHb5Qc770W0lXJTvqw4ggj9gtm6OdEaIFxOd1+8gHq0siEBivLLJ6SvSaNQ0ZoZ8Msp7vo3D7iBGOgHaitPGIcCOmK8Y1UWdERXj+/w=;
X-UUID: 2fc2f2a842ec4c078ca32d6b7ed97daf-20200806
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1876968445; Thu, 06 Aug 2020 14:27:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 Aug 2020 14:27:18 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Aug 2020 14:27:18 +0800
Message-ID: <1596695238.26800.4.camel@mtkswgap22>
Subject: Re: [PATCH v6 2/4] dmaengine: mediatek-cqdma: remove redundant
 queue structure
From:   EastL <EastL.Lee@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>
Date:   Thu, 6 Aug 2020 14:27:18 +0800
In-Reply-To: <20200727094458.GU12965@vkoul-mobl>
References: <1593673564-4425-1-git-send-email-EastL.Lee@mediatek.com>
         <1593673564-4425-3-git-send-email-EastL.Lee@mediatek.com>
         <20200715061957.GA34333@vkoul-mobl> <1595471650.22392.12.camel@mtkswgap22>
         <20200727094458.GU12965@vkoul-mobl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F4B7DC2C1D8B20EE4F229651815F3A8E35BCF4AAA4E64D95EAC95B78FBFF707C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTI3IGF0IDE1OjE0ICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBP
biAyMy0wNy0yMCwgMTA6MzQsIEVhc3RMIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyMC0wNy0xNSBh
dCAxMTo0OSArMDUzMCwgVmlub2QgS291bCB3cm90ZToNCj4gPiA+IE9uIDAyLTA3LTIwLCAxNTow
NiwgRWFzdEwgTGVlIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+ICBzdGF0aWMgZW51bSBkbWFfc3Rh
dHVzIG10a19jcWRtYV90eF9zdGF0dXMoc3RydWN0IGRtYV9jaGFuICpjLA0KPiA+ID4gPiAgCQkJ
CQkgICBkbWFfY29va2llX3QgY29va2llLA0KPiA+ID4gPiAgCQkJCQkgICBzdHJ1Y3QgZG1hX3R4
X3N0YXRlICp0eHN0YXRlKQ0KPiA+ID4gPiAgew0KPiA+ID4gPiAtCXN0cnVjdCBtdGtfY3FkbWFf
dmNoYW4gKmN2YyA9IHRvX2NxZG1hX3ZjaGFuKGMpOw0KPiA+ID4gPiAtCXN0cnVjdCBtdGtfY3Fk
bWFfdmRlc2MgKmN2ZDsNCj4gPiA+ID4gLQlzdHJ1Y3QgdmlydF9kbWFfZGVzYyAqdmQ7DQo+ID4g
PiA+IC0JZW51bSBkbWFfc3RhdHVzIHJldDsNCj4gPiA+ID4gLQl1bnNpZ25lZCBsb25nIGZsYWdz
Ow0KPiA+ID4gPiAtCXNpemVfdCBieXRlcyA9IDA7DQo+ID4gPiA+IC0NCj4gPiA+ID4gLQlyZXQg
PSBkbWFfY29va2llX3N0YXR1cyhjLCBjb29raWUsIHR4c3RhdGUpOw0KPiA+ID4gPiAtCWlmIChy
ZXQgPT0gRE1BX0NPTVBMRVRFIHx8ICF0eHN0YXRlKQ0KPiA+ID4gPiAtCQlyZXR1cm4gcmV0Ow0K
PiA+ID4gPiAtDQo+ID4gPiA+IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJmN2Yy0+dmMubG9jaywgZmxh
Z3MpOw0KPiA+ID4gPiAtCXZkID0gbXRrX2NxZG1hX2ZpbmRfYWN0aXZlX2Rlc2MoYywgY29va2ll
KTsNCj4gPiA+ID4gLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZjdmMtPnZjLmxvY2ssIGZsYWdz
KTsNCj4gPiA+ID4gLQ0KPiA+ID4gPiAtCWlmICh2ZCkgew0KPiA+ID4gPiAtCQljdmQgPSB0b19j
cWRtYV92ZGVzYyh2ZCk7DQo+ID4gPiA+IC0JCWJ5dGVzID0gY3ZkLT5yZXNpZHVlOw0KPiA+ID4g
PiAtCX0NCj4gPiA+ID4gLQ0KPiA+ID4gPiAtCWRtYV9zZXRfcmVzaWR1ZSh0eHN0YXRlLCBieXRl
cyk7DQo+ID4gPiANCj4gPiA+IGFueSByZWFzb24gd2h5IHlvdSB3YW50IHRvIHJlbW92ZSBzZXR0
aW5nIHJlc2lkdWU/DQo+ID4gQmVjYXVzZSBNZWRpYXRlayBDUURNQSBIVyBjYW4ndCBzdXBwb3J0
IHJlc2lkdWUuDQo+IA0KPiBBbmQgcHJldmlvdXNseSBpdCBkaWQ/DQpObywgSXQgd2FzIGNhbGN1
bGF0ZWQgYnkgc3cgYmVmb3JlLg0KV2UgZm91bmQgdGhhdCB0aGUgcmVzaWR1ZSB3YXMgbm90IG5l
Y2Vzc2FyeSwgc28gd2UgcmVtb3ZlZCBpdC4NCg0K

