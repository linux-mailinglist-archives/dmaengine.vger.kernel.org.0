Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DEA534023
	for <lists+dmaengine@lfdr.de>; Wed, 25 May 2022 17:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbiEYPPG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 May 2022 11:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245153AbiEYPPE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 May 2022 11:15:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F5B2AFAE1
        for <dmaengine@vger.kernel.org>; Wed, 25 May 2022 08:15:00 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-139-Xco2DS7JNnqZ9dGANxt50w-1; Wed, 25 May 2022 16:14:57 +0100
X-MC-Unique: Xco2DS7JNnqZ9dGANxt50w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 25 May 2022 16:14:55 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 25 May 2022 16:14:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Allen Pais <apais@linux.microsoft.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "olivier.dautricourt@orolia.com" <olivier.dautricourt@orolia.com>,
        Stefan Roese <sr@denx.de>, Vinod Koul <vkoul@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Ray Jui" <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "Nicolas Saenz Julienne" <nsaenz@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "Gustavo Pimentel" <gustavo.pimentel@synopsys.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "zw@zh-kernel.org" <zw@zh-kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sean Wang <sean.wang@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "green.wan@sifive.com" <green.wan@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?utf-8?B?SmVybmVqIMWga3JhYmVj?= <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
Thread-Topic: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
Thread-Index: AQHYcCfd7aGmAIzi9kCYuZw9gbAMOK0vsf4g
Date:   Wed, 25 May 2022 15:14:55 +0000
Message-ID: <9947cfa64667406996de191f07b9e8b9@AcuMS.aculab.com>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com>
 <CACRpkdZ2DFZRPHS1x0=M3_8zYvU-jpCG5Tm3863dXv51EhY+BA@mail.gmail.com>
 <CAK8P3a0j_rziihsgHnG5bHMxmPbOkAhT6_+CCE4iFZy7HzQrLw@mail.gmail.com>
In-Reply-To: <CAK8P3a0j_rziihsgHnG5bHMxmPbOkAhT6_+CCE4iFZy7HzQrLw@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAyNSBNYXkgMjAyMiAxMjowNA0KPiANCj4gT24g
V2VkLCBNYXkgMjUsIDIwMjIgYXQgMTE6MjQgQU0gTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVp
akBsaW5hcm8ub3JnPiB3cm90ZToNCj4gPiBPbiBUdWUsIEFwciAxOSwgMjAyMiBhdCAxMToxNyBQ
TSBBbGxlbiBQYWlzIDxhcGFpc0BsaW51eC5taWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPg0KPiA+
ID4gVGhlIHRhc2tsZXQgaXMgYW4gb2xkIEFQSSB3aGljaCB3aWxsIGJlIGRlcHJlY2F0ZWQsIHdv
cmtxdWV1ZSBBUEkNCj4gPiA+IGNhYiBiZSB1c2VkIGluc3RlYWQgb2YgdGhlbS4NCj4gPiA+DQo+
ID4gPiBUaGlzIHBhdGNoIHJlcGxhY2VzIHRoZSB0YXNrbGV0IHVzYWdlIGluIGRyaXZlcnMvZG1h
Lyogd2l0aCBhDQo+ID4gPiBzaW1wbGUgd29yay4NCj4gPiA+DQo+ID4gPiBHaXRodWI6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9LU1BQL2xpbnV4L2lzc3Vlcy85NA0KPiA+ID4NCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEFsbGVuIFBhaXMgPGFwYWlzQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+ID4NCj4gPiBQ
YWdpbmcgVmluY2VudCBHdWl0dG90IGFuZCBBcm5kIEJlcmdtYW5uIG9uIHRoZSBmb2xsb3dpbmcg
cXVlc3Rpb24NCj4gPiBvbiB0aGlzIHBhdGNoIHNldDoNCj4gPg0KPiA+IC0gV2lsbCByZXBsYWNp
bmcgdGFza2xldHMgd2l0aCB3b3JrcXVlIGxpa2UgdGhpcyBuZWdhdGl2ZWx5IGltcGFjdCB0aGUN
Cj4gPiAgIHBlcmZvcm1hbmNlIG9uIERNQSBlbmdpbmUgYm90dG9tIGhhbHZlcz8NCj4gDQo+IEkg
dGhpbmsgaXQgd2lsbCBpbiBzb21lIGNhc2VzIGJ1dCBub3Qgb3RoZXJzLiBUaGUgcHJvYmxlbSBJ
IHNlZSBpcyB0aGF0DQo+IHRoZSBzaG9ydCBwYXRjaCBkZXNjcmlwdGlvbiBtYWtlcyBpdCBzb3Vu
ZCBsaWtlIGEgdHJpdmlhbCBjb252ZXJzaW9uIG9mIGENCj4gc2luZ2xlIHN1YnN5c3RlbSwgYnV0
IGluIHJlYWxpdHkgdGhpcyBpbnRlcmFjdHMgd2l0aCBhbGwgdGhlIGRyaXZlcnMgdXNpbmcNCj4g
RE1BIGVuZ2luZXMsIGluY2x1ZGluZyB0dHkvc2VyaWFsLCBzb3VuZCwgbW1jIGFuZCBzcGkuDQo+
IA0KPiBJbiBtYW55IGNhc2VzLCB0aGUgY2hhbmdlIGlzIGFuIGltcHJvdmVtZW50LCBidXQgSSBj
YW4gc2VlIGEgbnVtYmVyDQo+IG9mIHdheXMgdGhpcyBtaWdodCBnbyB3cm9uZzoNCg0KSWYgdGhl
ICd0YXNrbGV0JyBBUEkgaXMgYmFzZWQgb24gdGhlIHNvZnRpbnQgKG9yIHNpbWlsYXIpDQp0aGVu
IGNoYW5naW5nIHRvIHdvcmtxdWV1ZSB3aWxsIGNhdXNlIHNlcmlvdXMgZ3JpZWYgaW4gbWFueSBj
YXNlcw0KdW5sZXNzIHRoZSB3b3JrcXVldWUgcHJvY2VzcyBydW5zIGF0IGEgaGlnaCBwcmlvcml0
eS4NCg0KQ3VycmVudGx5IHNvZnRpbnQgY2FsbGJhY2tzIGFyZSB1c3VhbGx5IGhpZ2hlciBwcmlv
cml0eSB0aGFuDQphbnkgdGFzay9wcm9jZXNzLg0KU28gb24gYSBidXN5IHN5c3RlbSB0aGV5IGFs
bW9zdCBhbHdheXMgcnVuLg0KKFRoZXkgY2FuIGdldCBjYXVnaHQgb3V0IGJ5IGEgbmVlZF9yZXNj
aGVkKCkgY2FsbCBhbmQgc3VkZGVubHkNCmJlIGZpZ2h0aW5nIHdpdGggbm9ybWFsIHVzZXIgcHJv
Y2Vzc2VzIGZvciBjcHUgdGltZS4pDQoNCkFzIGFybmQgc2FpZCwgSSBzdXNwZWN0IHRoaXMgd2ls
bCBicmVhayBhbnl0aGluZyB1c2luZyB0YXNrbGV0cw0KdG8gY2hhaW4gdG9nZXRoZXIgYXVkaW8g
b3IgdmlkZW8gYnVmZmVycy4NCkFueSBwcm9jZXNzIGNvZGUgZG9pbmcgdGhhdCB3b3VsZCBuZWVk
IHByb2JiYWx5IHRvIHJ1biBhdCBhDQonbWlkZGxpbmcnIFJUIHByaW9yaXR5Lg0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K

