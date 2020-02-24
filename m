Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD6616AD1B
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2020 18:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgBXRWJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Feb 2020 12:22:09 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:43130 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbgBXRWI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Feb 2020 12:22:08 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 4DC0E67A7D5;
        Mon, 24 Feb 2020 18:22:05 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 24 Feb
 2020 18:22:04 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.005; Mon, 24 Feb 2020 18:22:04 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Linus Walleij <linus.ml.walleij@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "Vinod Koul" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma: imx-sdma: Fix the event id check to include RX event
 for UART6
Thread-Topic: [PATCH] dma: imx-sdma: Fix the event id check to include RX
 event for UART6
Thread-Index: AQHV6zYWVmd7WYLi20CvYMo8u04O/6gqhq0A
Date:   Mon, 24 Feb 2020 17:22:04 +0000
Message-ID: <c4f8b6e7-32d3-0523-43f7-33aef2ebb66b@kontron.de>
References: <20200224171531.22204-1-frieder.schrempf@kontron.de>
In-Reply-To: <20200224171531.22204-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <26B40BE5F01BA54ABC9C4ADADFF6A1D6@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 4DC0E67A7D5.AFBD6
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        festevam@gmail.com, kernel@pengutronix.de,
        linus.ml.walleij@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, vkoul@kernel.org
X-Spam-Status: No
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjQuMDIuMjAgMTg6MTYsIFNjaHJlbXBmIEZyaWVkZXIgd3JvdGU6DQo+IEZyb206IEZyaWVk
ZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4gDQo+IE9uIGkuTVg2
IHRoZSBETUEgZXZlbnQgZm9yIHRoZSBSWCBjaGFubmVsIG9mIFVBUlQ2IGlzICcwJy4gVG8gZml4
DQo+IHRoZSBicm9rZW4gRE1BIHN1cHBvcnQgZm9yIFVBUlQ2LCB3ZSBjaGFuZ2UgdGhlIGNoZWNr
IGZvciBldmVudF9pZDANCj4gdG8gaW5jbHVkZSAnMCcgYXMgYSB2YWxpZCBpZC4NCj4gDQo+IEZp
eGVzOiAxZWMxZTgyZjI1MTAgKCJkbWFlbmdpbmU6IEFkZCBGcmVlc2NhbGUgaS5NWCBTRE1BIHN1
cHBvcnQiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsDQoNClNvcnJ5LCBJIG1lc3NlZCB1cCB0
aGUgc3RhYmxlIHRhZy4gV2lsbCBzZW5kIGFnYWluLg0KDQo+IFNpZ25lZC1vZmYtYnk6IEZyaWVk
ZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4gLS0tDQo+ICAgZHJp
dmVycy9kbWEvaW14LXNkbWEuYyB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEv
aW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCj4gaW5kZXggMDY2YjIxYTMyMjMy
Li4zZDRhYWM5N2IxZmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCj4g
KysrIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KPiBAQCAtMTMzMSw3ICsxMzMxLDcgQEAgc3Rh
dGljIHZvaWQgc2RtYV9mcmVlX2NoYW5fcmVzb3VyY2VzKHN0cnVjdCBkbWFfY2hhbiAqY2hhbikN
Cj4gICANCj4gICAJc2RtYV9jaGFubmVsX3N5bmNocm9uaXplKGNoYW4pOw0KPiAgIA0KPiAtCWlm
IChzZG1hYy0+ZXZlbnRfaWQwKQ0KPiArCWlmIChzZG1hYy0+ZXZlbnRfaWQwID49IDApDQo+ICAg
CQlzZG1hX2V2ZW50X2Rpc2FibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDApOw0KPiAgIAlpZiAo
c2RtYWMtPmV2ZW50X2lkMSkNCj4gICAJCXNkbWFfZXZlbnRfZGlzYWJsZShzZG1hYywgc2RtYWMt
PmV2ZW50X2lkMSk7DQo+IEBAIC0xNjMxLDcgKzE2MzEsNyBAQCBzdGF0aWMgaW50IHNkbWFfY29u
ZmlnKHN0cnVjdCBkbWFfY2hhbiAqY2hhbiwNCj4gICAJbWVtY3B5KCZzZG1hYy0+c2xhdmVfY29u
ZmlnLCBkbWFlbmdpbmVfY2ZnLCBzaXplb2YoKmRtYWVuZ2luZV9jZmcpKTsNCj4gICANCj4gICAJ
LyogU2V0IEVOQkxuIGVhcmxpZXIgdG8gbWFrZSBzdXJlIGRtYSByZXF1ZXN0IHRyaWdnZXJlZCBh
ZnRlciB0aGF0ICovDQo+IC0JaWYgKHNkbWFjLT5ldmVudF9pZDApIHsNCj4gKwlpZiAoc2RtYWMt
PmV2ZW50X2lkMCA+PSAwKSB7DQo+ICAgCQlpZiAoc2RtYWMtPmV2ZW50X2lkMCA+PSBzZG1hYy0+
c2RtYS0+ZHJ2ZGF0YS0+bnVtX2V2ZW50cykNCj4gICAJCQlyZXR1cm4gLUVJTlZBTDsNCj4gICAJ
CXNkbWFfZXZlbnRfZW5hYmxlKHNkbWFjLCBzZG1hYy0+ZXZlbnRfaWQwKTsNCj4g
