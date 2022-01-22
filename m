Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CC1496B1A
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jan 2022 09:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiAVIs4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jan 2022 03:48:56 -0500
Received: from tkylinode-sdnproxy-1.icoremail.net ([139.162.70.28]:44470 "HELO
        tkylinode-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229935AbiAVIs4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Jan 2022 03:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=cUi7kGdbvfGPc8ZcvTG0IA+aJjRDTmLl//7L
        dxOF41o=; b=PEXmcAwE4YPosOKbdNHBbUVjC8U86J8ldK8+f9ulU3Wk9ib5cfBm
        cd0DhuORZgQKMZajeWMSdZqE1kieI3sPE7QbdukykdXjNZExNUeOsiJ3IAnqPzVr
        ofIelwFwGj4m5funp4K85OMVgMYmRBCzaX7pn/lGmL0z/DmcigqQVFs=
Received: by ajax-webmail-front01 (Coremail) ; Sat, 22 Jan 2022 16:47:39
 +0800 (GMT+08:00)
X-Originating-IP: [10.129.37.75]
Date:   Sat, 22 Jan 2022 16:47:39 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5YiY5rC45b+X?= <lyz_cs@pku.edu.cn>
To:     =?UTF-8?Q?p=C3=A9ter_ujfalusi?= <peter.ujfalusi@gmail.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: Fix runtime PM imbalance on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-1ea67e80-64e4-49d5-bd9f-3beeae24b9f2-pku.edu.cn
In-Reply-To: <6169df3d-3d04-644c-fc70-a184ecfa97c8@gmail.com>
References: <1642332702-126304-1-git-send-email-lyz_cs@pku.edu.cn>
 <6169df3d-3d04-644c-fc70-a184ecfa97c8@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <37b99b59.2d9e6.17e80f83cbc.Coremail.lyz_cs@pku.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: 5oFpogBXOrirxOthpA2bAA--.24001W
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEOBlPy7uCwlwABsD
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiUMOpdGVyIFVqZmFsdXNpIiA8
cGV0ZXIudWpmYWx1c2lAZ21haWwuY29tPgo+IOWPkemAgeaXtumXtDogMjAyMi0wMS0yMiAxNjow
OTo1MyAo5pif5pyf5YWtKQo+IOaUtuS7tuS6ujogIllvbmd6aGkgTGl1IiA8bHl6X2NzQHBrdS5l
ZHUuY24+LCB2a291bEBrZXJuZWwub3JnCj4g5oqE6YCBOiBkbWFlbmdpbmVAdmdlci5rZXJuZWwu
b3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4g5Li76aKYOiBSZTogW1BBVENIXSBk
bWFlbmdpbmU6IHRpOiBGaXggcnVudGltZSBQTSBpbWJhbGFuY2Ugb24gZXJyb3IKPiAKPiAKPiAK
PiBPbiAxLzE2LzIyIDEzOjMxLCBZb25nemhpIExpdSB3cm90ZToKPiA+IHBtX3J1bnRpbWVfZ2V0
X3N5bmMoKSBpbmNyZW1lbnRzIHRoZSBydW50aW1lIFBNIHVzYWdlIGNvdW50ZXIgZXZlbgo+ID4g
d2hlbiBpdCByZXR1cm5zIGFuIGVycm9yIGNvZGUsIHRodXMgYSBtYXRjaGluZyBkZWNyZW1lbnQg
aXMgbmVlZGVkIG9uCj4gPiB0aGUgZXJyb3IgaGFuZGxpbmcgcGF0aCB0byBrZWVwIHRoZSBjb3Vu
dGVyIGJhbGFuY2VkLgo+IAo+IFRoZSBwYXRjaCBpcyBjb3JyZWN0LCBob3dldmVyIHRoZSBjb21t
aXQgbWVzc2FnZSBpcyBhIGJpdCBpbmNvcnJlY3QuCj4gCj4gV2UgYXJlIG5vdCBhZGRpbmcgYW55
IHZpc2libGUgbWF0Y2hpbmcgZGVjcmVtZW50LCB3ZSBhcmUgc3dpdGNoaW5nIHRvCj4gcG1fcnVu
dGltZV9yZXN1bWVfYW5kX2dldCgpIHdoaWNoIG9ubHkgaW5jcmVtZW50cyB0aGUgdXNhZ2UgY291
bnRlciBpZgo+IHBtX3J1bnRpbWVfcmVzdW1lKCkgaXMgc3VjY2Vzc2Z1bC4KPiBHcmFudGVkIGlu
dGVybmFsbHkgaXQgZG9lcyBhIHBtX3J1bnRpbWVfcHV0X25vaWRsZSgpIGlmIHJlc3VtZSBjYWxs
IGZhaWxzLgo+IAo+IFN3aXRjaCB0byBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KCkgdG8ga2Vl
cCB0aGUgZGV2aWNlJ3MgdXNlIGNhdW50Cj4gYmFsYW5jZWQ/Cj4gCgpUaGFua3MgZm9yIHlvdXIg
cmVwbHkuIEkgYWdyZWUgd2l0aCB5b3VyIGNoYW5nZSBhbmQgcmV3cml0ZSB0aGUgY29tbWl0IG1l
c3NhZ2UgYXMgZm9sbG93cy4KClt3aHldCnBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBpbmNyZW1lbnRz
IHRoZSBydW50aW1lIFBNIHVzYWdlIGNvdW50ZXIgZXZlbgp3aGVuIGl0IHJldHVybnMgYW4gZXJy
b3IgY29kZSwgaG93ZXZlciBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KCkgCm9ubHkgaW5jcmVt
ZW50cyB0aGUgdXNhZ2UgY291bnRlciBpZiBwbV9ydW50aW1lX3Jlc3VtZSgpIGlzIHN1Y2Nlc3Nm
dWwsCndoaWNoIGdyYW50ZWQgaW50ZXJuYWxseSBkb2VzIGEgcG1fcnVudGltZV9wdXRfbm9pZGxl
KCkgaWYgcmVzdW1lIGNhbGwgZmFpbHMuCgpbaG93XQpGaXggdGhpcyBieSBzd2l0Y2hpbmcgdG8g
cG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgpIHRvIGtlZXAgdGhlIGRldmljZSdzIHVzZSBjb3Vu
dApiYWxhbmNlZC4KCgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb25nemhpIExpdSA8bHl6X2Nz
QHBrdS5lZHUuY24+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2RtYS90aS9lZG1hLmMgfCA0ICsrLS0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4g
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvdGkvZWRtYS5jIGIvZHJpdmVycy9kbWEvdGkv
ZWRtYS5jCj4gPiBpbmRleCAwOGU0N2Y0Li5hNzNmNzc5IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVy
cy9kbWEvdGkvZWRtYS5jCj4gPiArKysgYi9kcml2ZXJzL2RtYS90aS9lZG1hLmMKPiA+IEBAIC0y
Mzk4LDkgKzIzOTgsOSBAQCBzdGF0aWMgaW50IGVkbWFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikKPiA+ICAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZWNjKTsKPiA+ICAK
PiA+ICAJcG1fcnVudGltZV9lbmFibGUoZGV2KTsKPiA+IC0JcmV0ID0gcG1fcnVudGltZV9nZXRf
c3luYyhkZXYpOwo+ID4gKwlyZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGRldik7Cj4g
PiAgCWlmIChyZXQgPCAwKSB7Cj4gPiAtCQlkZXZfZXJyKGRldiwgInBtX3J1bnRpbWVfZ2V0X3N5
bmMoKSBmYWlsZWRcbiIpOwo+ID4gKwkJZGV2X2VycihkZXYsICJwbV9ydW50aW1lX3Jlc3VtZV9h
bmRfZ2V0KCkgZmFpbGVkXG4iKTsKPiA+ICAJCXBtX3J1bnRpbWVfZGlzYWJsZShkZXYpOwo+ID4g
IAkJcmV0dXJuIHJldDsKPiA+ICAJfQo+IAo+IC0tIAo+IFDDqXRlcgo=
