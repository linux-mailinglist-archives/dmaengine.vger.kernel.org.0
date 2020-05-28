Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6EF1E5C7C
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 11:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbgE1J52 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 05:57:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:24695 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387432AbgE1J52 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 05:57:28 -0400
X-UUID: 829f924e41534aa484e467417301eae4-20200528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=r2yyS/GzdhkWnjygzbbMG8mX4hLDdpXfT3ti9OAQv6Y=;
        b=FjdVOj5nQMZrE/2dPDdOslYWp14mlFOrWpw9YZmqdPG+vIQ6WWQT5U/zCnXfXkJKTeaQV+UhmZ8NUXsmvxWoJVQSnpDfQB95VGd6Bc2yijhxOjDItpPOablIdRq+/OT0AdeWNfK093W8QPkASwvisv3UeJHikkwejFUgMbupBuY=;
X-UUID: 829f924e41534aa484e467417301eae4-20200528
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2051785732; Thu, 28 May 2020 17:57:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 May 2020 17:57:17 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 May 2020 17:57:17 +0800
From:   EastL <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH v4] dmaengine: mediatek-cqdma: add dt-bindings and remove redundant queue
Date:   Thu, 28 May 2020 17:57:08 +0800
Message-ID: <1590659832-31476-1-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhpcyBwYXRjaCBzZXQgYWRkcyBkb2N1bWVudCB0aGUgZGV2aWNldHJlZSBiaW5kaW5ncyBmb3Ig
TWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxlciwNCmFuZCByZW1vdmUgcmVkdW5k
YW50IHF1ZXVlIHN0cnVjdHVyZSwgYWRkIGRtYS1jaGFubmVsLW1hc2sgZm9yIERNQSBjYXBhYmls
aXR5IGFuZCBmaXggY29tcGF0aWJsZS4NCg0KQ2hhbmdlcyBzaW5jZSB2MzoNCi0gZml4IGR0X2Jp
bmRpbmdfY2hlY2sgZXJyb3JzDQoNCkNoYW5nZXMgc2luY2UgdjI6DQotIGFkZCBkZXZpY2V0cmVl
IGJpbmRpbmdzIGZvciBNZWRpYVRlayBDb21tYW5kLVF1ZXVlIERNQSBjb250cm9sbGVyDQoNCkNo
YW5nZXMgc2luY2UgdjE6DQotIHJlbW92ZSByZWR1bmRhbnQgcXVldWUgc3RydWN0dXJlDQotIGZp
eCB3cm9uZyBkZXNjcmlwdGlvbiBhbmQgdGFncyBpbiB0aGUgZWFybGllciBwYXRjaA0KLSBhZGQg
ZG1hLWNoYW5uZWwtbWFzayBmb3IgRE1BIGNhcGFiaWxpdHkNCi0gZml4IGNvbXBhdGlibGUgZm9y
IGNvbW1vbg0K

