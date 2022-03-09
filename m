Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256874D26C3
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 05:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiCIEGF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Mar 2022 23:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiCIEGD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Mar 2022 23:06:03 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBC315F0A2;
        Tue,  8 Mar 2022 20:05:04 -0800 (PST)
Received: from kwepemi100021.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KCz4G1SpJz1GC28;
        Wed,  9 Mar 2022 12:00:14 +0800 (CST)
Received: from kwepemm000008.china.huawei.com (7.193.23.125) by
 kwepemi100021.china.huawei.com (7.221.188.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 9 Mar 2022 12:05:02 +0800
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 kwepemm000008.china.huawei.com (7.193.23.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 12:05:02 +0800
Received: from kwepemm600007.china.huawei.com ([7.193.23.208]) by
 kwepemm600007.china.huawei.com ([7.193.23.208]) with mapi id 15.01.2308.021;
 Wed, 9 Mar 2022 12:05:02 +0800
From:   haijie <haijie1@huawei.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: hisi_dma: fix MSI allocate fail when reload
 hisi_dma
Thread-Topic: [PATCH] dmaengine: hisi_dma: fix MSI allocate fail when reload
 hisi_dma
Thread-Index: AQHYKGWuhu5tqpyyZk6BPYLezmY++ay2hByw
Date:   Wed, 9 Mar 2022 04:05:02 +0000
Message-ID: <d847faf0ac3042b094f56cff76b055dd@huawei.com>
References: <20220216072101.34473-1-haijie1@huawei.com>
 <5882d4c4-8ab9-0d33-91eb-ac4cfcd189b6@hisilicon.com>
In-Reply-To: <5882d4c4-8ab9-0d33-91eb-ac4cfcd189b6@hisilicon.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.102.167]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

aGVsbG8sIGtpbmRseSBwaW5nIGZvciByZXZpZXcgc3RhdHVzLiA6KQ0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogV2FuZ3pob3UgKEIpIA0KU2VudDogV2VkbmVzZGF5LCBGZWJy
dWFyeSAyMywgMjAyMiAxMTozMCBBTQ0KVG86IGhhaWppZSA8aGFpamllMUBodWF3ZWkuY29tPjsg
dmtvdWxAa2VybmVsLm9yZw0KQ2M6IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRtYWVuZ2luZTogaGlz
aV9kbWE6IGZpeCBNU0kgYWxsb2NhdGUgZmFpbCB3aGVuIHJlbG9hZCBoaXNpX2RtYQ0KDQo+IFJl
bW92ZSB0aGUgbG9hZGVkIGhpc2lfZG1hIGRyaXZlciBhbmQgcmVsb2FkIGl0LCB0aGUgZHJpdmVy
IGZhaWxzIHRvIA0KPiB3b3JrIHByb3Blcmx5LiBUaGUgZm9sbG93aW5nIGVycm9yIGlzIHJlcG9y
dGVkIGluIHRoZSBrZXJuZWwgbG9nOg0KPiANCj4gWyAxNDc1LjU5NzYwOV0gaGlzaV9kbWEgMDAw
MDo3YjowMC4wOiBGYWlsZWQgdG8gYWxsb2NhdGUgTVNJIHZlY3RvcnMhDQo+IFsgMTQ3NS42MDQ5
MTVdIGhpc2lfZG1hOiBwcm9iZSBvZiAwMDAwOjdiOjAwLjAgZmFpbGVkIHdpdGggZXJyb3IgLTI4
DQo+IA0KPiBBcyBub3RlZCBpbiAiVGhlIE1TSSBEcml2ZXIgR3VpZGUgSE9XVE8iWzFdLCB0aGUg
bnVtYmVyIG9mIE1TSSANCj4gaW50ZXJydXB0IG11c3QgYmUgYSBwb3dlciBvZiB0d28uIFRoZSBL
dW5wZW5nIERNQSBkcml2ZXIgYWxsb2NhdGVzIDMwIA0KPiBNU0kgaW50ZXJydXB0cy4gQXMgYSBy
ZXN1bHQsIG5vIHNwYWNlIGxlZnQgb24gZGV2aWNlIGlzIHJlcG9ydGVkIHdoZW4gDQo+IHRoZSBk
cml2ZXIgaXMgcmVsb2FkZWQgYW5kIGFsbG9jYXRlcyBpbnRlcnJ1cHQgdmVjdG9ycyBmcm9tIHRo
ZSANCj4gaW50ZXJydXB0IGRvbWFpbi4NCj4gDQo+IFRoaXMgcGF0Y2ggY2hhbmdlcyB0aGUgbnVt
YmVyIG9mIGludGVycnVwdCB2ZWN0b3JzIGFsbG9jYXRlZCBieSANCj4gaGlzaV9kbWEgZHJpdmVy
IHRvIDMyIHRvIGF2b2lkIHRoaXMgcHJvYmxlbS4NCj4gDQo+IFsxXSBodHRwczovL3d3dy5rZXJu
ZWwub3JnL2RvYy9odG1sL2xhdGVzdC9QQ0kvbXNpLWhvd3RvLmh0bWwNCj4gDQo+IEZpeGVzOiBl
OWYwOGI2NTI1MGQgKCJkbWFlbmdpbmU6IGhpc2lsaWNvbjogQWRkIEt1bnBlbmcgRE1BIGVuZ2lu
ZSANCj4gc3VwcG9ydCIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaWUgSGFpIDxoYWlqaWUxQGh1
YXdlaS5jb20+DQoNClRoYW5rcyBmb3IgZml4aW5nIGl0Lg0KDQpBY2tlZC1ieTogWmhvdSBXYW5n
IDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT4NCg0KQmVzdCwNClpob3UNCg0KPiAtLS0NCj4gIGRy
aXZlcnMvZG1hL2hpc2lfZG1hLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9oaXNp
X2RtYS5jIGIvZHJpdmVycy9kbWEvaGlzaV9kbWEuYyBpbmRleCANCj4gOTdjODdhN2NiYTg3Li40
MzgxN2NlZDNhM2UgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZG1hL2hpc2lfZG1hLmMNCj4gKysr
IGIvZHJpdmVycy9kbWEvaGlzaV9kbWEuYw0KPiBAQCAtMzAsNyArMzAsNyBAQA0KPiAgI2RlZmlu
ZSBISVNJX0RNQV9NT0RFCQkJMHgyMTdjDQo+ICAjZGVmaW5lIEhJU0lfRE1BX09GRlNFVAkJCTB4
MTAwDQo+ICANCj4gLSNkZWZpbmUgSElTSV9ETUFfTVNJX05VTQkJMzANCj4gKyNkZWZpbmUgSElT
SV9ETUFfTVNJX05VTQkJMzINCj4gICNkZWZpbmUgSElTSV9ETUFfQ0hBTl9OVU0JCTMwDQo+ICAj
ZGVmaW5lIEhJU0lfRE1BX1FfREVQVEhfVkFMCQkxMDI0DQo+ICANCj4gDQo=
