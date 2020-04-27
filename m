Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193271B9532
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2020 04:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgD0CxL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 26 Apr 2020 22:53:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:62276 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726437AbgD0CxL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 26 Apr 2020 22:53:11 -0400
X-UUID: 00425d357db44eae879d56b619aca172-20200427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=51pLSQ6vu0bktqe9XfAF5B+ix//CVuEoq0YX27Es87U=;
        b=FxRC6jPhH+DvWJ4mBvUACkr6D8pTBUuji/QKWmCG8WDFCHTe7r6+GrU3tSWaRqbdAQ6Yy+y5Mh7VjA7wU6kVKJxPFAlurNzCHmoU8UFpkaaeKu8e+VmHIS0iih0AjQVObdvnKsWoTSFIyxRAu8uwDojRZeWLoGvqlwc7RkvIqlA=;
X-UUID: 00425d357db44eae879d56b619aca172-20200427
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 17700560; Mon, 27 Apr 2020 10:53:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Apr 2020 10:53:02 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Apr 2020 10:53:01 +0800
From:   EastL <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH v3] dmaengine: mediatek-cqdma: add dt-bindings and remove redundant queue
Date:   Mon, 27 Apr 2020 10:52:55 +0800
Message-ID: <1587955977-17207-1-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A4FE1395A7320814F6C9DF9C065ECF57BFD0FAA2D5B51FB9BD4F56FBF4D209432000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhpcyBwYXRjaCBzZXQgYWRkcyBkb2N1bWVudCB0aGUgZGV2aWNldHJlZSBiaW5kaW5ncyBmb3Ig
TWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxlciwNCmFuZCByZW1vdmUgcmVkdW5k
YW50IHF1ZXVlIHN0cnVjdHVyZS4NCg0KQ2hhbmdlcyBzaW5jZSB2MjoNCi0gYWRkIGRldmljZXRy
ZWUgYmluZGluZ3MgZm9yIE1lZGlhVGVrIENvbW1hbmQtUXVldWUgRE1BIGNvbnRyb2xsZXINCg0K
Q2hhbmdlcyBzaW5jZSB2MToNCi0gcmVtb3ZlIHJlZHVuZGFudCBxdWV1ZSBzdHJ1Y3R1cmUNCi0g
Zml4IHdyb25nIGRlc2NyaXB0aW9uIGFuZCB0YWdzIGluIHRoZSBlYXJsaWVyIHBhdGNoDQotIGFk
ZCBkbWEtY2hhbm5lbC1tYXNrIGZvciBETUEgY2FwYWJpbGl0eQ0KDQoNCkVhc3RMICgyKToNCiAg
ZHQtYmluZGluZ3M6IGRtYWVuZ2luZTogQWRkIE1lZGlhVGVrIENvbW1hbmQtUXVldWUgRE1BIGNv
bnRyb2xsZXINCiAgICBiaW5kaW5ncw0KICBkbWFlbmdpbmU6IG1lZGlhdGVrLWNxZG1hOiByZW1v
dmUgcmVkdW5kYW50IHF1ZXVlIHN0cnVjdHVyZQ0KDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZG1hL210ay1jcWRtYS55YW1sICAgIHwgIDk4ICsrKysNCiBkcml2ZXJzL2RtYS9tZWRpYXRlay9t
dGstY3FkbWEuYyAgICAgICAgICAgICAgfCA0MjIgKysrKystLS0tLS0tLS0tLS0tDQogMiBmaWxl
cyBjaGFuZ2VkLCAyMTggaW5zZXJ0aW9ucygrKSwgMzAyIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210ay1jcWRt
YS55YW1sDQoNCi0tDQoyLjE4LjA=

