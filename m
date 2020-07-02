Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F7211C66
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 09:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgGBHGX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 03:06:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13941 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727046AbgGBHGW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Jul 2020 03:06:22 -0400
X-UUID: 890ff4b72342461bb52ca7766ec68252-20200702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rVJ/HR/KXQAiejqufqXGDKDnW4GEgj2c2Tw9QevZ/Sk=;
        b=lwK4IVInQgeEFgsNLdTz42L61dgiWpsW+TA2LitjH5Lr9eiI2J9ItZN3tcuBXnZbSixq23BJQap+byi70nev7LT1Kjoo3LNCmDY5R2g2nffY7JERVAhevPMzz2u5TCGJUztQr9DLorlaAQ3ycUn0gF57w1rxcCCzscldtorwKE8=;
X-UUID: 890ff4b72342461bb52ca7766ec68252-20200702
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1715574752; Thu, 02 Jul 2020 15:06:17 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Jul 2020 15:06:14 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Jul 2020 15:06:09 +0800
From:   EastL Lee <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>,
        EastL Lee <EastL.Lee@mediatek.com>
Subject: [PATCH v6 3/4] dmaengine: mediatek-cqdma: add dma mask for capability
Date:   Thu, 2 Jul 2020 15:06:03 +0800
Message-ID: <1593673564-4425-4-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1593673564-4425-1-git-send-email-EastL.Lee@mediatek.com>
References: <1593673564-4425-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgZG1hIG1hc2sgZm9yIGNhcGFiaWxpdHkuDQoNClNpZ25lZC1vZmYtYnk6
IEVhc3RMIExlZSA8RWFzdEwuTGVlQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZG1hL21l
ZGlhdGVrL210ay1jcWRtYS5jIHwgMTcgKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdl
ZCwgMTcgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvbWVkaWF0ZWsv
bXRrLWNxZG1hLmMgYi9kcml2ZXJzL2RtYS9tZWRpYXRlay9tdGstY3FkbWEuYw0KaW5kZXggOTA1
YmJjYi4uMTYxMDYzMiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZG1hL21lZGlhdGVrL210ay1jcWRt
YS5jDQorKysgYi9kcml2ZXJzL2RtYS9tZWRpYXRlay9tdGstY3FkbWEuYw0KQEAgLTExNyw2ICsx
MTcsNyBAQCBzdHJ1Y3QgbXRrX2NxZG1hX3ZjaGFuIHsNCiAgKiBAY2xrOiAgICAgICAgICAgICAg
ICAgICAgVGhlIGNsb2NrIHRoYXQgZGV2aWNlIGludGVybmFsIGlzIHVzaW5nDQogICogQGRtYV9y
ZXF1ZXN0czogICAgICAgICAgIFRoZSBudW1iZXIgb2YgVkNzIHRoZSBkZXZpY2Ugc3VwcG9ydHMg
dG8NCiAgKiBAZG1hX2NoYW5uZWxzOiAgICAgICAgICAgVGhlIG51bWJlciBvZiBQQ3MgdGhlIGRl
dmljZSBzdXBwb3J0cyB0bw0KKyAqIEBkbWFfbWFzazogICAgICAgICAgICAgICBBIG1hc2sgZm9y
IERNQSBjYXBhYmlsaXR5DQogICogQHZjOiAgICAgICAgICAgICAgICAgICAgIFRoZSBwb2ludGVy
IHRvIGFsbCBhdmFpbGFibGUgVkNzDQogICogQHBjOiAgICAgICAgICAgICAgICAgICAgIFRoZSBw
b2ludGVyIHRvIGFsbCB0aGUgdW5kZXJseWluZyBQQ3MNCiAgKi8NCkBAIC0xMjYsNiArMTI3LDcg
QEAgc3RydWN0IG10a19jcWRtYV9kZXZpY2Ugew0KIA0KIAl1MzIgZG1hX3JlcXVlc3RzOw0KIAl1
MzIgZG1hX2NoYW5uZWxzOw0KKwl1MzIgZG1hX21hc2s7DQogCXN0cnVjdCBtdGtfY3FkbWFfdmNo
YW4gKnZjOw0KIAlzdHJ1Y3QgbXRrX2NxZG1hX3BjaGFuICoqcGM7DQogfTsNCkBAIC02MDcsNiAr
NjA5LDIxIEBAIHN0YXRpYyBpbnQgbXRrX2NxZG1hX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQogCQljcWRtYS0+ZG1hX2NoYW5uZWxzID0gTVRLX0NRRE1BX05SX1BDSEFOUzsN
CiAJfQ0KIA0KKwlpZiAocGRldi0+ZGV2Lm9mX25vZGUpDQorCQllcnIgPSBvZl9wcm9wZXJ0eV9y
ZWFkX3UzMihwZGV2LT5kZXYub2Zfbm9kZSwNCisJCQkJCSAgICJkbWEtY2hhbm5lbC1tYXNrIiwN
CisJCQkJCSAgICZjcWRtYS0+ZG1hX21hc2spOw0KKwlpZiAoZXJyKSB7DQorCQlkZXZfd2Fybigm
cGRldi0+ZGV2LA0KKwkJCSAiVXNpbmcgMCBhcyBtaXNzaW5nIGRtYS1jaGFubmVsLW1hc2sgcHJv
cGVydHlcbiIpOw0KKwkJY3FkbWEtPmRtYV9tYXNrID0gMDsNCisJfQ0KKw0KKwlpZiAoZG1hX3Nl
dF9tYXNrKCZwZGV2LT5kZXYsIERNQV9CSVRfTUFTSyhjcWRtYS0+ZG1hX21hc2spKSkgew0KKwkJ
ZGV2X3dhcm4oJnBkZXYtPmRldiwgIkRNQSBzZXQgbWFzayBmYWlsZWRcbiIpOw0KKwkJcmV0dXJu
IC1FSU5WQUw7DQorCX0NCisNCiAJY3FkbWEtPnBjID0gZGV2bV9rY2FsbG9jKCZwZGV2LT5kZXYs
IGNxZG1hLT5kbWFfY2hhbm5lbHMsDQogCQkJCSBzaXplb2YoKmNxZG1hLT5wYyksIEdGUF9LRVJO
RUwpOw0KIAlpZiAoIWNxZG1hLT5wYykNCi0tIA0KMS45LjENCg==

