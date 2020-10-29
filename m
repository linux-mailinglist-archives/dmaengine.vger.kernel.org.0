Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AEA29F681
	for <lists+dmaengine@lfdr.de>; Thu, 29 Oct 2020 21:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgJ2U6c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Oct 2020 16:58:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2049 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ2U6c (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Oct 2020 16:58:32 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CMd854mFZzVhLG;
        Fri, 30 Oct 2020 04:58:29 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 30 Oct 2020 04:58:29 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 30 Oct 2020 04:58:29 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Fri, 30 Oct 2020 04:58:29 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>
Subject: RE: [PATCH 09/10] dmaengine: ste_dma40: remove redundant irqsave and
 irqrestore in hardIRQ
Thread-Topic: [PATCH 09/10] dmaengine: ste_dma40: remove redundant irqsave and
 irqrestore in hardIRQ
Thread-Index: AQHWrfwFd4bsoLTQpkWaKvTb/BCJ/qmvDjPw
Date:   Thu, 29 Oct 2020 20:58:29 +0000
Message-ID: <e5c2894d4fce4f9d9adf508b9dee776c@hisilicon.com>
References: <20201015235921.21224-1-song.bao.hua@hisilicon.com>
 <20201015235921.21224-10-song.bao.hua@hisilicon.com>
 <CACRpkdYObFW77kCv5sRb+Dx_Gxfvw+YkPB5joYXTw_i-ag34kQ@mail.gmail.com>
In-Reply-To: <CACRpkdYObFW77kCv5sRb+Dx_Gxfvw+YkPB5joYXTw_i-ag34kQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.117]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXMgV2FsbGVpaiBb
bWFpbHRvOmxpbnVzLndhbGxlaWpAbGluYXJvLm9yZ10NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVy
IDMwLCAyMDIwIDM6MDEgQU0NCj4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNvbmcu
YmFvLmh1YUBoaXNpbGljb24uY29tPg0KPiBDYzogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9y
Zz47IGRtYWVuZ2luZSA8ZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAwOS8xMF0gZG1hZW5naW5lOiBzdGVfZG1hNDA6IHJlbW92ZSByZWR1bmRhbnQgaXJx
c2F2ZQ0KPiBhbmQgaXJxcmVzdG9yZSBpbiBoYXJkSVJRDQo+IA0KPiBPbiBGcmksIE9jdCAxNiwg
MjAyMCBhdCAyOjAzIEFNIEJhcnJ5IFNvbmcgPHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tPg0K
PiB3cm90ZToNCj4gDQo+ID4gUnVubmluZyBpbiBoYXJkSVJRLCBkaXNhYmxpbmcgSVJRIGlzIHJl
ZHVuZGFudC4NCj4gPg0KPiA+IENjOiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFy
by5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmFycnkgU29uZyA8c29uZy5iYW8uaHVhQGhpc2ls
aWNvbi5jb20+DQo+IA0KPiBUaGF0J3MgcmlnaHQhDQo+IFJldmlld2VkLWJ5OiBMaW51cyBXYWxs
ZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQoNClRoYW5rcywgTGludXMuDQpJIGd1ZXNz
IHlvdSBtaXNzZWQgdjIgaW4gd2hpY2ggeW91IGFjdHVhbGx5IHNob3VsZCBoYXZlIGFja2VkIDot
KQ0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9kbWFlbmdpbmUvMjAyMDEwMjcyMTUyNTIuMjU4
MjAtMTAtc29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20vDQoNClRoYW5rcw0KQmFycnkNCg0KPiAN
Cj4gWW91cnMsDQo+IExpbnVzIFdhbGxlaWoNCg==
