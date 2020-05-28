Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25C51E5C84
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 11:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbgE1J5m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 05:57:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5527 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387644AbgE1J5l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 05:57:41 -0400
X-UUID: 2eb1f388023944828e72e2a8620472e5-20200528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Hhp4Gq/lAQxSghJRwoF92XaAxe8EL9n2NHwdPyaDOAY=;
        b=ZOiJQDrOsxf+NlhP5UYip6cN6QhIqSKTsMaNft0avbZI9+0PBxsthMGhLaI+6onCF/hMgN3E0IDbnkSXfNTOxIpb6dtqf39F9vDFBtfbmo7VudvufHsUaVcpjJmFNAgEaXQSPozR+CRbV1m7ZCW3muQE+rZVxtKQDCbdYmhjrNc=;
X-UUID: 2eb1f388023944828e72e2a8620472e5-20200528
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1936306507; Thu, 28 May 2020 17:57:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 May 2020 17:57:29 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 May 2020 17:57:29 +0800
From:   EastL <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, EastL <EastL.Lee@mediatek.com>
Subject: [PATCH v4 4/4] dmaengine: mediatek-cqdma: add dma mask for capability
Date:   Thu, 28 May 2020 17:57:12 +0800
Message-ID: <1590659832-31476-5-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590659832-31476-1-git-send-email-EastL.Lee@mediatek.com>
References: <1590659832-31476-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F93B03554329BDCDD88F2B63E056675CC432FAFBAF2E0F0D0441441AD2A2C1902000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgZG1hIG1hc2sgZm9yIGNhcGFiaWxpdHkuDQoNCkNoYW5nZS1JZDogSTMx
ZjQ2MjJmOTU0MWQ3Njk3MDIwMjk1MzJlNWY1ZjE4NTgxNWRkYTINClNpZ25lZC1vZmYtYnk6IEVh
c3RMIDxFYXN0TC5MZWVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9kbWEvbWVkaWF0ZWsv
bXRrLWNxZG1hLmMgfCAxMyArKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL21lZGlhdGVrL210ay1jcWRtYS5j
IGIvZHJpdmVycy9kbWEvbWVkaWF0ZWsvbXRrLWNxZG1hLmMNCmluZGV4IGJjYTcxMTguLjE4MDVh
NzYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RtYS9tZWRpYXRlay9tdGstY3FkbWEuYw0KKysrIGIv
ZHJpdmVycy9kbWEvbWVkaWF0ZWsvbXRrLWNxZG1hLmMNCkBAIC0xMTcsNiArMTE3LDcgQEAgc3Ry
dWN0IG10a19jcWRtYV92Y2hhbiB7DQogICogQGNsazogICAgICAgICAgICAgICAgICAgIFRoZSBj
bG9jayB0aGF0IGRldmljZSBpbnRlcm5hbCBpcyB1c2luZw0KICAqIEBkbWFfcmVxdWVzdHM6ICAg
ICAgICAgICBUaGUgbnVtYmVyIG9mIFZDcyB0aGUgZGV2aWNlIHN1cHBvcnRzIHRvDQogICogQGRt
YV9jaGFubmVsczogICAgICAgICAgIFRoZSBudW1iZXIgb2YgUENzIHRoZSBkZXZpY2Ugc3VwcG9y
dHMgdG8NCisgKiBAZG1hX21hc2s6ICAgICAgICAgICAgICAgQSBtYXNrIGZvciBETUEgY2FwYWJp
bGl0eQ0KICAqIEB2YzogICAgICAgICAgICAgICAgICAgICBUaGUgcG9pbnRlciB0byBhbGwgYXZh
aWxhYmxlIFZDcw0KICAqIEBwYzogICAgICAgICAgICAgICAgICAgICBUaGUgcG9pbnRlciB0byBh
bGwgdGhlIHVuZGVybHlpbmcgUENzDQogICovDQpAQCAtMTI2LDYgKzEyNyw3IEBAIHN0cnVjdCBt
dGtfY3FkbWFfZGV2aWNlIHsNCiANCiAJdTMyIGRtYV9yZXF1ZXN0czsNCiAJdTMyIGRtYV9jaGFu
bmVsczsNCisJdTMyIGRtYV9tYXNrOw0KIAlzdHJ1Y3QgbXRrX2NxZG1hX3ZjaGFuICp2YzsNCiAJ
c3RydWN0IG10a19jcWRtYV9wY2hhbiAqKnBjOw0KIH07DQpAQCAtNTQ5LDYgKzU1MSw3IEBAIHN0
YXRpYyB2b2lkIG10a19jcWRtYV9od19kZWluaXQoc3RydWN0IG10a19jcWRtYV9kZXZpY2UgKmNx
ZG1hKQ0KIH07DQogTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXRrX2NxZG1hX21hdGNoKTsNCiAN
CitzdGF0aWMgdTY0IGNxZG1hX2RtYW1hc2s7DQogc3RhdGljIGludCBtdGtfY3FkbWFfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiB7DQogCXN0cnVjdCBtdGtfY3FkbWFfZGV2
aWNlICpjcWRtYTsNCkBAIC02MDcsNiArNjEwLDE2IEBAIHN0YXRpYyBpbnQgbXRrX2NxZG1hX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQljcWRtYS0+ZG1hX2NoYW5uZWxz
ID0gTVRLX0NRRE1BX05SX1BDSEFOUzsNCiAJfQ0KIA0KKwlpZiAocGRldi0+ZGV2Lm9mX25vZGUg
JiYgb2ZfcHJvcGVydHlfcmVhZF91MzIocGRldi0+ZGV2Lm9mX25vZGUsDQorCQkJCQkJICAgICAg
ImRtYS1jaGFubmVsLW1hc2siLA0KKwkJCQkJCSAgICAgICZjcWRtYS0+ZG1hX21hc2spKSB7DQor
CQlkZXZfaW5mbygmcGRldi0+ZGV2LA0KKwkJCSAiVXNpbmcgMCBhcyBtaXNzaW5nIGRtYS1jaGFu
bmVsLW1hc2sgcHJvcGVydHlcbiIpOw0KKwl9IGVsc2Ugew0KKwkJY3FkbWFfZG1hbWFzayA9IERN
QV9CSVRfTUFTSyhjcWRtYS0+ZG1hX21hc2spOw0KKwkJcGRldi0+ZGV2LmRtYV9tYXNrID0gJmNx
ZG1hX2RtYW1hc2s7DQorCX0NCisNCiAJY3FkbWEtPnBjID0gZGV2bV9rY2FsbG9jKCZwZGV2LT5k
ZXYsIGNxZG1hLT5kbWFfY2hhbm5lbHMsDQogCQkJCSBzaXplb2YoKmNxZG1hLT5wYyksIEdGUF9L
RVJORUwpOw0KIAlpZiAoIWNxZG1hLT5wYykNCi0tIA0KMS45LjENCg==

