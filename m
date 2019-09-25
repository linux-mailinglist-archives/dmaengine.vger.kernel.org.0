Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6905CBE09C
	for <lists+dmaengine@lfdr.de>; Wed, 25 Sep 2019 16:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438273AbfIYOxh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Sep 2019 10:53:37 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:41546 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732535AbfIYOxg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Sep 2019 10:53:36 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 09BAE67A659;
        Wed, 25 Sep 2019 16:53:30 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 25 Sep
 2019 16:53:29 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Wed, 25 Sep 2019 16:53:29 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Robin Gong <yibin.gong@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v5 11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Thread-Topic: [PATCH v5 11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Thread-Index: AQHVctvU4cuMSjzwIEqWCaN8EgDgaac8IOgAgAA51YA=
Date:   Wed, 25 Sep 2019 14:53:29 +0000
Message-ID: <1307d229-4c49-80e3-04ba-377c0caeae9c@kontron.de>
References: <20190610081753.11422-12-yibin.gong@nxp.com>
 <29cf9f29-bdb4-94db-00b0-56ec36386f7a@kontron.de>
 <VE1PR04MB6638639EF4F580E04689538E89870@VE1PR04MB6638.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB6638639EF4F580E04689538E89870@VE1PR04MB6638.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <8326CD696BB9F14CBFF37C6E31B2574A@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 09BAE67A659.A3106
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, vkoul@kernel.org,
        yibin.gong@nxp.com
X-Spam-Status: No
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjUuMDkuMTkgMTM6MjYsIFJvYmluIEdvbmcgd3JvdGU6DQo+IE9uIDIwMTktOS0yNCAyMToy
OCBTY2hyZW1wZiBGcmllZGVyIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+IHdyb3RlOg0K
Pj4NCj4+IEhpIFJvYmluLA0KPj4NCj4+PiBGcm9tOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nIGF0
IG54cC5jb20+DQo+Pj4NCj4+PiBCZWNhdXNlIHRoZSBudW1iZXIgb2YgZWNzcGkxIHJ4IGV2ZW50
IG9uIGkubXg4bW0gaXMgMCwgdGhlIGNvbmRpdGlvbg0KPj4+IGNoZWNrIGlnbm9yZSBzdWNoIHNw
ZWNpYWwgY2FzZSB3aXRob3V0IGRtYSBjaGFubmVsIGVuYWJsZWQsIHdoaWNoDQo+Pj4gY2F1c2Vk
DQo+Pj4gZWNzcGkxIHJ4IHdvcmtzIGZhaWxlZC4gQWN0dWFsbHksIG5vIG5lZWQgdG8gY2hlY2sg
ZXZlbnRfaWQwL2V2ZW50X2lkMQ0KPj4+IGFuZCByZXBsYWNlIGNoZWNraW5nICdldmVudF9pZDEn
IHdpdGggJ0RNQV9ERVZfVE9fREVWJywgc28gdGhhdA0KPj4+IGNvbmZpZ3VyZQ0KPj4+IGV2ZW50
X2lkMSBvbmx5IGluIGNhc2UgREVWX1RPX0RFVi4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFJv
YmluIEdvbmcgPHlpYmluLmdvbmcgYXQgbnhwLmNvbT4NCj4+PiBBY2tlZC1ieTogVmlub2QgS291
bCA8dmtvdWwgYXQga2VybmVsLm9yZz4NCj4+DQo+PiBJIGhhdmUgYSBjdXN0b20gYm9hcmQgd2l0
aCBpLk1YOE1NIGFuZCBTUEkgZmxhc2ggb24gZWNzcGkxLiBJJ20gY3VycmVudGx5DQo+PiB0ZXN0
aW5nIHdpdGggdjUuMyBhbmQgYXMgU1BJIGRpZG4ndCB3b3JrLCBJIHRyaWVkIHR3byBkaWZmZXJl
bnQgdGhpbmdzOg0KPj4NCj4+IDEuIFJlbW92aW5nICdkbWFzJyBhbmQgJ2RtYS1uYW1lcycgZnJv
bSB0aGUgZWNzcGkxIG5vZGUgaW4gaW14OG1tLmR0c2ksDQo+PiAgICAgIHRvIHVzZSBQSU8gaW5z
dGVhZCBvZiBETUEuIFRoaXMgd29ya3MgYXMgZXhwZWN0ZWQgYW5kIHRoZSBkcml2ZXINCj4+ICAg
ICAgYm9vdHMgd2l0aCB0aGUgZm9sbG93aW5nIG1lc3NhZ2VzOg0KPj4NCj4+ICAgICAgICAgIHNw
aV9pbXggMzA4MjAwMDAuc3BpOiBkbWEgc2V0dXAgZXJyb3IgLTE5LCB1c2UgcGlvDQo+PiAgICAg
ICAgICBtMjVwODAgc3BpMC4wOiBteDI1djgwMzVmICgxMDI0IEtieXRlcykNCj4+ICAgICAgICAg
IHNwaV9pbXggMzA4MjAwMDAuc3BpOiBwcm9iZWQNCj4+DQo+PiAyLiBBcHBseWluZyB5b3VyIHBh
dGNoc2V0IGFuZCB1c2UgRE1BLiBJbiB0aGlzIGNhc2UsIHRoZSBmbGFzaCBhbHNvDQo+PiAgICAg
IHdvcmtzIGZpbmUsIGJ1dCB0aGVyZSBhcmUgc29tZSBlcnJvciBtZXNzYWdlcyBwcmludGVkIHdo
aWxlIGJvb3Rpbmc6DQo+Pg0KPj4gICAgICAgICAgc3BpX21hc3RlciBzcGkwOiBJL08gRXJyb3Ig
aW4gRE1BIFJYDQo+PiAgICAgICAgICBtMjVwODAgc3BpMC4wOiBTUEkgdHJhbnNmZXIgZmFpbGVk
OiAtMTEwDQo+PiAgICAgICAgICBzcGlfbWFzdGVyIHNwaTA6IGZhaWxlZCB0byB0cmFuc2ZlciBv
bmUgbWVzc2FnZSBmcm9tIHF1ZXVlDQo+PiAgICAgICAgICBtMjVwODAgc3BpMC4wOiBteDI1djgw
MzVmICgxMDI0IEtieXRlcykNCj4+ICAgICAgICAgIHNwaV9pbXggMzA4MjAwMDAuc3BpOiBwcm9i
ZWQNCj4+DQo+PiBJdCB3b3VsZCBiZSBncmVhdCB0byBnZXQgeW91ciBwYXRjaGVzIG1lcmdlZCBh
bmQgZml4IFNQSSArIERNQSwgYnV0IGZvcg0KPj4gaS5NWDhNTSwgd2UgbmVlZCB0byBnZXQgcmlk
IG9mIHRoZSBlcnJvciBtZXNzYWdlcy4gRG8geW91IGhhdmUgYW4gaWRlYSwNCj4+IHdoYXQncyB3
cm9uZz8NCg0KPiBDb3VsZCB5b3UgY2hlY2sgaWYgdGhlIGxlbmd0aCBvZiBzcGkgbWVzc2FnZSBp
cyBiaWdnZXIgdGhhbiBmaWZvX3NpemUgZHVyaW5nDQo+IHNwaV9ub3IgcHJvYmU/IElmIHllcywg
YXQgdGhhdCB0aW1lIG1heWJlIHNkbWEgZmlybXdhcmUgbm90IGxvYWRlZC4NCj4gaWYgKHRyYW5z
ZmVyLT5sZW4gPCBzcGlfaW14LT5kZXZ0eXBlX2RhdGEtPmZpZm9fc2l6ZSkNCg0KSW5kZWVkLCBt
b3N0IG9mIHRoZSB0cmFuc2ZlcnMgdHJpZ2dlcmVkIGJ5IHRoZSBTUEkgTk9SIGRpcnZlciBhcmUg
YmVsb3cgDQpmaWZvX3NpemUgYW5kIHdvcmsgZmluZSwgYnV0IHNvbWUgYXJlIGJpZ2dlci4gVGhl
IHRyYW5zZmVycyB0aGVyZWZvcmUgDQp0cnkgdG8gdXNlIERNQSwgYnV0IHRoZSBmaXJtd2FyZSBp
cyBub3QgbG9hZGVkIHlldC4NCg0KSG93IGlzIHRoaXMgc3VwcG9zZWQgdG8gd29yaz8gU2hvdWxk
bid0IGFsbCB0cmFuc2ZlcnMgdXNlIFBJTyBhcyBsb25nIGFzIA0KdGhlIFNETUEgZmlybXdhcmUg
aXMgbm90IGxvYWRlZCB5ZXQ/DQoNCigrIENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnKQ==
