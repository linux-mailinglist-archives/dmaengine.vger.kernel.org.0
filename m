Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDBD22A543
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jul 2020 04:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733221AbgGWCeP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jul 2020 22:34:15 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:24787 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728914AbgGWCeO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jul 2020 22:34:14 -0400
X-UUID: c259162778874c56bb613c025876b752-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=9hTIinPJ/86OaOzsDAjqdA+TQ7VtOw4pAcixEozya7A=;
        b=arU8Ru/yuG0TpypuMhw6gbzfQiwEpS2Xq1YELHCSXKxHg//a1tsTOMYL9l1knqpJgtOP+vfOvScdQ8CaypLJmo7poMls//PwavUwLbCNVRIQoI0L6Q+8BFccV9/AAdCf6NBCfVnauxXoCTReJmAGdWnPxEL3D93nZblyBPsklwE=;
X-UUID: c259162778874c56bb613c025876b752-20200723
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1258688521; Thu, 23 Jul 2020 10:34:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 10:34:10 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 10:34:07 +0800
Message-ID: <1595471650.22392.12.camel@mtkswgap22>
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
Date:   Thu, 23 Jul 2020 10:34:10 +0800
In-Reply-To: <20200715061957.GA34333@vkoul-mobl>
References: <1593673564-4425-1-git-send-email-EastL.Lee@mediatek.com>
         <1593673564-4425-3-git-send-email-EastL.Lee@mediatek.com>
         <20200715061957.GA34333@vkoul-mobl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTE1IGF0IDExOjQ5ICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBP
biAwMi0wNy0yMCwgMTU6MDYsIEVhc3RMIExlZSB3cm90ZToNCj4gDQo+ID4gIHN0YXRpYyBlbnVt
IGRtYV9zdGF0dXMgbXRrX2NxZG1hX3R4X3N0YXR1cyhzdHJ1Y3QgZG1hX2NoYW4gKmMsDQo+ID4g
IAkJCQkJICAgZG1hX2Nvb2tpZV90IGNvb2tpZSwNCj4gPiAgCQkJCQkgICBzdHJ1Y3QgZG1hX3R4
X3N0YXRlICp0eHN0YXRlKQ0KPiA+ICB7DQo+ID4gLQlzdHJ1Y3QgbXRrX2NxZG1hX3ZjaGFuICpj
dmMgPSB0b19jcWRtYV92Y2hhbihjKTsNCj4gPiAtCXN0cnVjdCBtdGtfY3FkbWFfdmRlc2MgKmN2
ZDsNCj4gPiAtCXN0cnVjdCB2aXJ0X2RtYV9kZXNjICp2ZDsNCj4gPiAtCWVudW0gZG1hX3N0YXR1
cyByZXQ7DQo+ID4gLQl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+IC0Jc2l6ZV90IGJ5dGVzID0g
MDsNCj4gPiAtDQo+ID4gLQlyZXQgPSBkbWFfY29va2llX3N0YXR1cyhjLCBjb29raWUsIHR4c3Rh
dGUpOw0KPiA+IC0JaWYgKHJldCA9PSBETUFfQ09NUExFVEUgfHwgIXR4c3RhdGUpDQo+ID4gLQkJ
cmV0dXJuIHJldDsNCj4gPiAtDQo+ID4gLQlzcGluX2xvY2tfaXJxc2F2ZSgmY3ZjLT52Yy5sb2Nr
LCBmbGFncyk7DQo+ID4gLQl2ZCA9IG10a19jcWRtYV9maW5kX2FjdGl2ZV9kZXNjKGMsIGNvb2tp
ZSk7DQo+ID4gLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZjdmMtPnZjLmxvY2ssIGZsYWdzKTsN
Cj4gPiAtDQo+ID4gLQlpZiAodmQpIHsNCj4gPiAtCQljdmQgPSB0b19jcWRtYV92ZGVzYyh2ZCk7
DQo+ID4gLQkJYnl0ZXMgPSBjdmQtPnJlc2lkdWU7DQo+ID4gLQl9DQo+ID4gLQ0KPiA+IC0JZG1h
X3NldF9yZXNpZHVlKHR4c3RhdGUsIGJ5dGVzKTsNCj4gDQo+IGFueSByZWFzb24gd2h5IHlvdSB3
YW50IHRvIHJlbW92ZSBzZXR0aW5nIHJlc2lkdWU/DQpCZWNhdXNlIE1lZGlhdGVrIENRRE1BIEhX
IGNhbid0IHN1cHBvcnQgcmVzaWR1ZS4NCj4gDQo+ID4gLXN0YXRpYyB2b2lkIG10a19jcWRtYV9m
cmVlX2FjdGl2ZV9kZXNjKHN0cnVjdCBkbWFfY2hhbiAqYykNCj4gPiArc3RhdGljIGludCBtdGtf
Y3FkbWFfdGVybWluYXRlX2FsbChzdHJ1Y3QgZG1hX2NoYW4gKmMpDQo+ID4gIHsNCj4gPiAgCXN0
cnVjdCBtdGtfY3FkbWFfdmNoYW4gKmN2YyA9IHRvX2NxZG1hX3ZjaGFuKGMpOw0KPiA+IC0JYm9v
bCBzeW5jX25lZWRlZCA9IGZhbHNlOw0KPiA+ICsJc3RydWN0IHZpcnRfZG1hX2NoYW4gKnZjID0g
dG9fdmlydF9jaGFuKGMpOw0KPiA+ICAJdW5zaWduZWQgbG9uZyBwY19mbGFnczsNCj4gPiAgCXVu
c2lnbmVkIGxvbmcgdmNfZmxhZ3M7DQo+ID4gKwlMSVNUX0hFQUQoaGVhZCk7DQo+ID4gKw0KPiA+
ICsJLyogd2FpdCBmb3IgdGhlIFZDIHRvIGJlIGluYWN0aXZlICAqLw0KPiA+ICsJaWYgKCF3YWl0
X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJmN2Yy0+Y21wLCBtc2Vjc190b19qaWZmaWVzKDMwMDAp
KSkNCj4gPiArCQlyZXR1cm4gLUVBR0FJTjsNCj4gPiAgDQo+ID4gIAkvKiBhY3F1aXJlIFBDJ3Mg
bG9jayBmaXJzdCBkdWUgdG8gbG9jayBkZXBlbmRlbmN5IGluIGRtYSBJU1IgKi8NCj4gPiAgCXNw
aW5fbG9ja19pcnFzYXZlKCZjdmMtPnBjLT5sb2NrLCBwY19mbGFncyk7DQo+ID4gIAlzcGluX2xv
Y2tfaXJxc2F2ZSgmY3ZjLT52Yy5sb2NrLCB2Y19mbGFncyk7DQo+ID4gIA0KPiA+IC0JLyogc3lu
Y2hyb25pemF0aW9uIGlzIHJlcXVpcmVkIGlmIHRoaXMgVkMgaXMgYWN0aXZlICovDQo+ID4gLQlp
ZiAobXRrX2NxZG1hX2lzX3ZjaGFuX2FjdGl2ZShjdmMpKSB7DQo+ID4gLQkJY3ZjLT5pc3N1ZV9z
eW5jaHJvbml6ZSA9IHRydWU7DQo+ID4gLQkJc3luY19uZWVkZWQgPSB0cnVlOw0KPiA+IC0JfQ0K
PiA+ICsJLyogZ2V0IFZEcyBmcm9tIGxpc3RzICovDQo+ID4gKwl2Y2hhbl9nZXRfYWxsX2Rlc2Ny
aXB0b3JzKHZjLCAmaGVhZCk7DQo+ID4gKw0KPiA+ICsJLyogZnJlZSBhbGwgdGhlIFZEcyAqLw0K
PiA+ICsJdmNoYW5fZG1hX2Rlc2NfZnJlZV9saXN0KHZjLCAmaGVhZCk7DQo+ID4gIA0KPiA+ICAJ
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmY3ZjLT52Yy5sb2NrLCB2Y19mbGFncyk7DQo+ID4gIAlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZjdmMtPnBjLT5sb2NrLCBwY19mbGFncyk7DQo+IA0KPiBH
b29kIGNsZWFudXAsIGRvIHlvdSBuZWVkIGJvdGggdGhlc2UgbG9ja3M/DQpZZXMsIGJlY2F1c2Ug
d2Ugd2lsbCBoYXZlIG11bHRpcGxlIHZjIHRvIHBjLCBpdCB3aWxsIG5lZWQgYm90aCBsb2NrLg0K
DQo=

