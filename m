Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3FA34F65E
	for <lists+dmaengine@lfdr.de>; Wed, 31 Mar 2021 03:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhCaBqk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 21:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhCaBqf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Mar 2021 21:46:35 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A9A8C061574;
        Tue, 30 Mar 2021 18:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=r6IX+H3mWFlutMMZlalWXqUjbNmwlaGMJsek
        1+SAYqk=; b=pPLK+nzbVV0Ot8FSwxV9saIDWH5CEQY/ZLGwssOOi1YRVwrEqXb1
        aZxj18N0O5ni0IrZvcTpKS2BfNLNH1/GPdU67QOukVrl3WUnQL/3jzhsThQvyPJ/
        I1lyXbIFcplWmHSHb1Z6Z0TQNrLp1yUQQYaHCwpWwY2t45wRl8wcgLA=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Wed, 31 Mar
 2021 09:46:32 +0800 (GMT+08:00)
X-Originating-IP: [202.38.69.14]
Date:   Wed, 31 Mar 2021 09:46:32 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Dave Jiang" <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] dma: Fix a double free in dma_async_device_register
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <f4ce9e2a-6bb9-d3ae-3583-2d29e09aa3a3@intel.com>
References: <20210330090149.13476-1-lyl2019@mail.ustc.edu.cn>
 <f4ce9e2a-6bb9-d3ae-3583-2d29e09aa3a3@intel.com>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1f7a14cc.20e14.17885f5f67f.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygDX3KR41GNgo6J0AA--.2W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQoRBlQhn5kbZwACsR
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIkRhdmUgSmlhbmci
IDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIxLTAzLTMxIDAwOjA1
OjE1ICjmmJ/mnJ/kuIkpDQo+IOaUtuS7tuS6ujogIkx2IFl1bmxvbmciIDxseWwyMDE5QG1haWwu
dXN0Yy5lZHUuY24+LCB2a291bEBrZXJuZWwub3JnDQo+IOaKhOmAgTogZG1hZW5naW5lQHZnZXIu
a2VybmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiDkuLvpopg6IFJlOiBb
UEFUQ0hdIGRtYTogRml4IGEgZG91YmxlIGZyZWUgaW4gZG1hX2FzeW5jX2RldmljZV9yZWdpc3Rl
cg0KPiANCj4gDQo+IE9uIDMvMzAvMjAyMSAyOjAxIEFNLCBMdiBZdW5sb25nIHdyb3RlOg0KPiA+
IEluIHRoZSBmaXJzdCBsaXN0X2Zvcl9lYWNoX2VudHJ5KCkgbWFjcm8gb2YgZG1hX2FzeW5jX2Rl
dmljZV9yZWdpc3RlciwNCj4gPiBpdCBnZXRzIHRoZSBjaGFuIGZyb20gbGlzdCBhbmQgY2FsbHMg
X19kbWFfYXN5bmNfZGV2aWNlX2NoYW5uZWxfcmVnaXN0ZXINCj4gPiAoLi4sY2hhbikuIFdlIGNh
biBzZWUgdGhhdCBjaGFuLT5sb2NhbCBpcyBhbGxvY2F0ZWQgYnkgYWxsb2NfcGVyY3B1KCkgYW5k
DQo+ID4gaXQgaXMgZnJlZWQgY2hhbi0+bG9jYWwgYnkgZnJlZV9wZXJjcHUoY2hhbi0+bG9jYWwp
IHdoZW4NCj4gPiBfX2RtYV9hc3luY19kZXZpY2VfY2hhbm5lbF9yZWdpc3RlcigpIGZhaWxlZC4N
Cj4gPg0KPiA+IEJ1dCBhZnRlciBfX2RtYV9hc3luY19kZXZpY2VfY2hhbm5lbF9yZWdpc3Rlcigp
IGZhaWxlZCwgdGhlIGNhbGxlciB3aWxsDQo+ID4gZ290byBlcnJfb3V0IGFuZCBmcmVlZCB0aGUg
Y2hhbi0+bG9jYWwgaW4gdGhlIHNlY29uZCB0aW1lIGJ5IGZyZWVfcGVyY3B1KCkuDQo+ID4NCj4g
PiBUaGUgY2F1c2Ugb2YgdGhpcyBwcm9ibGVtIGlzIGZvcmdldCB0byBzZXQgY2hhbi0+bG9jYWwg
dG8gTlVMTCB3aGVuDQo+ID4gY2hhbi0+bG9jYWwgd2FzIGZyZWVkIGluIF9fZG1hX2FzeW5jX2Rl
dmljZV9jaGFubmVsX3JlZ2lzdGVyKCkuIE15DQo+ID4gcGF0Y2ggc2V0cyBjaGFuLT5sb2NhbCB0
byBOVUxMIHdoZW4gdGhlIGNhbGxlZSBmYWlsZWQgdG8gYXZvaWQgZG91YmxlIGZyZWUuDQo+IA0K
PiBUaGFua3MgZm9yIHRoZSBmaXguIEkgdGhpbmsgaXQgd291bGQgbWFrZSBzZW5zZSB0byBzZXQg
aXQgdG8gTlVMTCBpbiANCj4gX19kbWFfYXN5bmNfZGV2aWNlX2NoYW5uZWxfcmVnaXN0ZXIoKSBj
bGVhbnVwIHBhdGggYWZ0ZXIgaXQgY2FsbHMgDQo+IGZyZWVfcGVyY3B1KGNoYW4tPmxvY2FsKSBy
aWdodD8gVGhhdCB3b3VsZCBhZGRyZXNzIGFueSBvdGhlciBpbnN0YW5jZXMgDQo+IG9mIHRoaXMg
aXNzdWUgaGFwcGVuaW5nIGVsc2Ugd2hlcmUuDQo+IA0KPiANCj4gPg0KPiA+IEZpeGVzOiBkMmZi
MGEwNDM4Mzg0ICgiZG1hZW5naW5lOiBicmVhayBvdXQgY2hhbm5lbCByZWdpc3RyYXRpb24iKQ0K
PiA+IFNpZ25lZC1vZmYtYnk6IEx2IFl1bmxvbmcgPGx5bDIwMTlAbWFpbC51c3RjLmVkdS5jbj4N
Cj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZG1hL2RtYWVuZ2luZS5jIHwgNCArKystDQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvZG1hZW5naW5lLmMgYi9kcml2ZXJzL2RtYS9kbWFlbmdp
bmUuYw0KPiA+IGluZGV4IGZlNmE0NjBjNDM3My4uZmVmNjRiMTk4Yzk1IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZG1hL2RtYWVuZ2luZS5jDQo+ID4gKysrIGIvZHJpdmVycy9kbWEvZG1hZW5n
aW5lLmMNCj4gPiBAQCAtMTI0OSw4ICsxMjQ5LDEwIEBAIGludCBkbWFfYXN5bmNfZGV2aWNlX3Jl
Z2lzdGVyKHN0cnVjdCBkbWFfZGV2aWNlICpkZXZpY2UpDQo+ID4gICAJLyogcmVwcmVzZW50IGNo
YW5uZWxzIGluIHN5c2ZzLiBQcm9iYWJseSB3YW50IGRldnMgdG9vICovDQo+ID4gICAJbGlzdF9m
b3JfZWFjaF9lbnRyeShjaGFuLCAmZGV2aWNlLT5jaGFubmVscywgZGV2aWNlX25vZGUpIHsNCj4g
PiAgIAkJcmMgPSBfX2RtYV9hc3luY19kZXZpY2VfY2hhbm5lbF9yZWdpc3RlcihkZXZpY2UsIGNo
YW4pOw0KPiA+IC0JCWlmIChyYyA8IDApDQo+ID4gKwkJaWYgKHJjIDwgMCkgew0KPiA+ICsJCQlj
aGFuLT5sb2NhbCA9IE5VTEw7DQo+ID4gICAJCQlnb3RvIGVycl9vdXQ7DQo+ID4gKwkJfQ0KPiA+
ICAgCX0NCj4gPiAgIA0KPiA+ICAgCW11dGV4X2xvY2soJmRtYV9saXN0X211dGV4KTsNCg0KT2ss
IHRoYXQgaXMgYSBnb29kIGlkZWEuIEkgaGF2ZSBzdWJtaXR0ZWQgdGhlIFBBVENIIHYyLg0KDQpU
aGFua3MuDQo=
