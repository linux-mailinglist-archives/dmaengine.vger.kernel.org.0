Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B938A247C6A
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 05:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHRDEW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 23:04:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53059 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726583AbgHRDEL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Aug 2020 23:04:11 -0400
X-UUID: ccb16292f9334147aa0fb1d2597a1b34-20200818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xBoe6gt6wxqIzbSLaemhxTBncfJ0ORMMg2skOSe8MSA=;
        b=rhgOsNBe53VNvhORlgJDR5uzkww/bGNSfyNXs/8HODj8FnuafiWu54n5fxbQupJqZJ+1eG0N4yN4Yk1ONz1JRqQX+4/AnKNsJ0Ce7GZyfeRlqjk9ogwwF5pizXGWRKWOYEltcIG5Lzj8TVUjtPuX163h5t8OFXtyqmxXfo3oTig=;
X-UUID: ccb16292f9334147aa0fb1d2597a1b34-20200818
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1383409060; Tue, 18 Aug 2020 11:04:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 18 Aug 2020 11:03:59 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 18 Aug 2020 11:03:59 +0800
From:   EastL Lee <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>
Subject: [PATCH v7] dmaengine: mediatek-cqdma: add dt-bindings and remove redundant queue 
Date:   Tue, 18 Aug 2020 11:03:50 +0800
Message-ID: <1597719834-6675-1-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AAEC054072CFE97947F8CDF899EAE91679FC3A35881BA561C49E25310D7FF1332000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhpcyBwYXRjaCBzZXQgYWRkcyBkb2N1bWVudCB0aGUgZGV2aWNldHJlZSBiaW5kaW5ncyBmb3Ig
TWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxlciwNCmFuZCByZW1vdmUgcmVkdW5k
YW50IHF1ZXVlIHN0cnVjdHVyZS4NCg0KaGFuZ2VzIHNpbmNlIHY2Og0KLSBmaXggZHQgYmluZGlu
ZyBmb3JtYXQNCg0KaGFuZ2VzIHNpbmNlIHY1Og0KLSBmaXggZnVsbCBuYW1lDQoNCmhhbmdlcyBz
aW5jZSB2NDoNCi0gZml4IHlhbWwgJiBkbWEtbWFzayBjb2RlIGZsb3cNCg0KaGFuZ2VzIHNpbmNl
IHYzOg0KLSBmaXggZHRfYmluZGluZ19jaGVjayBlcnJvcnMNCg0KQ2hhbmdlcyBzaW5jZSB2MjoN
Ci0gYWRkIGRldmljZXRyZWUgYmluZGluZ3MgZm9yIE1lZGlhVGVrIENvbW1hbmQtUXVldWUgRE1B
IGNvbnRyb2xsZXINCg0KQ2hhbmdlcyBzaW5jZSB2MToNCi0gcmVtb3ZlIHJlZHVuZGFudCBxdWV1
ZSBzdHJ1Y3R1cmUNCi0gZml4IHdyb25nIGRlc2NyaXB0aW9uIGFuZCB0YWdzIGluIHRoZSBlYXJs
aWVyIHBhdGNoDQotIGFkZCBkbWEtY2hhbm5lbC1tYXNrIGZvciBETUEgY2FwYWJpbGl0eQ0KLSBm
aXggY29tcGF0aWJsZSBmb3IgY29tbW9uDQoNCg==

