Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BA4200330
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2020 10:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgFSIFU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Jun 2020 04:05:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61126 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731014AbgFSIFR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 Jun 2020 04:05:17 -0400
X-UUID: b26bcc8d838d418f9f82ad9c66d0b376-20200619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ySEtHTH57bxejrMtxUW7baRYR2KhL0kU2xryPA6GWeY=;
        b=ClaWGkPI9RpLVoRnBZifvdim+xIqrjdZPjEAOWfc3U9cAl8zghRfsiYu7/cOHk0NzeSE5JglQJOYwOjQY9ssN4NVngve7nT4mBTFGv7NMBvrXlzmqEtF8E3laAwL3eL1CRQ6mScKDdleuysXyDNqn25QnTHepArv5ZSIYpKdYpk=;
X-UUID: b26bcc8d838d418f9f82ad9c66d0b376-20200619
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 344117436; Fri, 19 Jun 2020 16:05:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Jun 2020 16:05:06 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Jun 2020 16:05:08 +0800
From:   EastL <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, EastL <EastL.Lee@mediatek.com>
Subject: [PATCH v5 3/4] dmaengine: mediatek-cqdma: add dma mask for capability
Date:   Fri, 19 Jun 2020 16:05:01 +0800
Message-ID: <1592553902-30592-4-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1592553902-30592-1-git-send-email-EastL.Lee@mediatek.com>
References: <1592553902-30592-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5F99345FA7F246BBF9849BD1CEB69989773CB4DE139E4BBB3040F4B2C603A3392000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgZG1hIG1hc2sgZm9yIGNhcGFiaWxpdHkuDQoNClNpZ25lZC1vZmYtYnk6
IEVhc3RMIDxFYXN0TC5MZWVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9kbWEvbWVkaWF0
ZWsvbXRrLWNxZG1hLmMgfCAxNyArKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAx
NyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9tZWRpYXRlay9tdGst
Y3FkbWEuYyBiL2RyaXZlcnMvZG1hL21lZGlhdGVrL210ay1jcWRtYS5jDQppbmRleCA5MDViYmNi
Li5lZDMzYzY0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9kbWEvbWVkaWF0ZWsvbXRrLWNxZG1hLmMN
CisrKyBiL2RyaXZlcnMvZG1hL21lZGlhdGVrL210ay1jcWRtYS5jDQpAQCAtMTE3LDYgKzExNyw3
IEBAIHN0cnVjdCBtdGtfY3FkbWFfdmNoYW4gew0KICAqIEBjbGs6ICAgICAgICAgICAgICAgICAg
ICBUaGUgY2xvY2sgdGhhdCBkZXZpY2UgaW50ZXJuYWwgaXMgdXNpbmcNCiAgKiBAZG1hX3JlcXVl
c3RzOiAgICAgICAgICAgVGhlIG51bWJlciBvZiBWQ3MgdGhlIGRldmljZSBzdXBwb3J0cyB0bw0K
ICAqIEBkbWFfY2hhbm5lbHM6ICAgICAgICAgICBUaGUgbnVtYmVyIG9mIFBDcyB0aGUgZGV2aWNl
IHN1cHBvcnRzIHRvDQorICogQGRtYV9tYXNrOiAgICAgICAgICAgICAgIEEgbWFzayBmb3IgRE1B
IGNhcGFiaWxpdHkNCiAgKiBAdmM6ICAgICAgICAgICAgICAgICAgICAgVGhlIHBvaW50ZXIgdG8g
YWxsIGF2YWlsYWJsZSBWQ3MNCiAgKiBAcGM6ICAgICAgICAgICAgICAgICAgICAgVGhlIHBvaW50
ZXIgdG8gYWxsIHRoZSB1bmRlcmx5aW5nIFBDcw0KICAqLw0KQEAgLTEyNiw2ICsxMjcsNyBAQCBz
dHJ1Y3QgbXRrX2NxZG1hX2RldmljZSB7DQogDQogCXUzMiBkbWFfcmVxdWVzdHM7DQogCXUzMiBk
bWFfY2hhbm5lbHM7DQorCXUzMiBkbWFfbWFzazsNCiAJc3RydWN0IG10a19jcWRtYV92Y2hhbiAq
dmM7DQogCXN0cnVjdCBtdGtfY3FkbWFfcGNoYW4gKipwYzsNCiB9Ow0KQEAgLTYwNyw2ICs2MDks
MjEgQEAgc3RhdGljIGludCBtdGtfY3FkbWFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCiAJCWNxZG1hLT5kbWFfY2hhbm5lbHMgPSBNVEtfQ1FETUFfTlJfUENIQU5TOw0KIAl9
DQogDQorCWlmIChwZGV2LT5kZXYub2Zfbm9kZSkNCisJCWVyciA9IG9mX3Byb3BlcnR5X3JlYWRf
dTMyKHBkZXYtPmRldi5vZl9ub2RlLA0KKwkJCQkJICAgImRtYS1jaGFubmVsLW1hc2siLA0KKwkJ
CQkJICAgJmNxZG1hLT5kbWFfbWFzayk7DQorCWlmIChlcnIpIHsNCisJCWRldl93YXJuKCZwZGV2
LT5kZXYsDQorCQkJICJVc2luZyAwIGFzIG1pc3NpbmcgZG1hLWNoYW5uZWwtbWFzayBwcm9wZXJ0
eVxuIik7DQorCQljcWRtYS0+ZG1hX21hc2sgPSAwOw0KKwl9DQorDQorCWlmIChkbWFfc2V0X21h
c2soJnBkZXYtPmRldiwgRE1BX0JJVF9NQVNLKGNxZG1hLT5kbWFfbWFzaykpKSB7DQorCQlkZXZf
d2FybigmcGRldi0+ZGV2LCAiRE1BIHNldCBtYXNrIGZhaWxcbiIpOw0KKwkJcmV0dXJuIC1FSU5W
QUw7DQorCX0NCisNCiAJY3FkbWEtPnBjID0gZGV2bV9rY2FsbG9jKCZwZGV2LT5kZXYsIGNxZG1h
LT5kbWFfY2hhbm5lbHMsDQogCQkJCSBzaXplb2YoKmNxZG1hLT5wYyksIEdGUF9LRVJORUwpOw0K
IAlpZiAoIWNxZG1hLT5wYykNCi0tIA0KMS45LjENCg==

