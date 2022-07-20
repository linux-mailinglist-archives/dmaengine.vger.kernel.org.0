Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE7B57B143
	for <lists+dmaengine@lfdr.de>; Wed, 20 Jul 2022 08:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiGTGyc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Jul 2022 02:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiGTGyb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Jul 2022 02:54:31 -0400
Received: from m1564.mail.126.com (m1564.mail.126.com [220.181.15.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73B8037F99
        for <dmaengine@vger.kernel.org>; Tue, 19 Jul 2022 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=gGvko
        cabzaNDaKVlGdFJUg8taHjcbceLNaQY3hV/J/w=; b=posDjMHUaDx/h7xkr6MlQ
        7WKBUZ+W3Q3Thv+cMDdtzhUvjobXOJJSedZRC3krqR4on2dDjQOzV8lGk12TDEBQ
        un41gc9e9bmB0FbCGvaFQqPj+seV//9oP+d8PLiqu9jBlK+lgN4R/e4BgGjyWAlx
        GOqefgsdZBO1+ef4LaF/Oc=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr64
 (Coremail) ; Wed, 20 Jul 2022 14:54:16 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Wed, 20 Jul 2022 14:54:16 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     =?GBK?Q?P=A8=A6ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org
Subject: Re:Re: [PATCH] dmaengine: ti: k3-udma-private: Fix refcount leak
 bug in of_xudma_dev_get()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <fec32664-3f7a-aaa7-489b-10916544ce33@gmail.com>
References: <20220716084642.701268-1-windhl@126.com>
 <fec32664-3f7a-aaa7-489b-10916544ce33@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5e82772d.4026.1821a62c57b.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: QMqowAAXH3OaptdicAJPAA--.28838W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGhFEF1-HZh5p6QADs7
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

CgoKQXQgMjAyMi0wNy0yMCAxNDozOTo1NiwgIlCopnRlciBVamZhbHVzaSIgPHBldGVyLnVqZmFs
dXNpQGdtYWlsLmNvbT4gd3JvdGU6Cj5IaSwKPgo+T24gMTYvMDcvMjAyMiAxMTo0NiwgTGlhbmcg
SGUgd3JvdGU6Cj4+IFdlIHNob3VsZCBjYWxsIG9mX25vZGVfcHV0KCkgZm9yIHRoZSByZWZlcmVu
Y2UgcmV0dXJuZWQgYnkKPj4gb2ZfcGFyc2VfcGhhbmRsZSgpIGluIGZhaWwgcGF0aCBvciB3aGVu
IGl0IGlzIG5vdCB1c2VkIGFueW1vcmUuCj4+IEhlcmUgd2Ugb25seSBuZWVkIHRvIG1vdmUgdGhl
IG9mX25vZGVfcHV0KCkgYmVmb3JlIHRoZSBjaGVjay4KPgo+VGhhbmsgeW91IGZvciB0aGUgYW5h
bHlzaXMsIHllcywgdGhpcyBpcyBhIGJ1Zy4KPgo+SWYgeW91IGFkZCB0aGUgbWlzc2luZyBibGFu
ayBsaW5lLCB5b3UgY2FuIGF0dGFjaCBteToKPkFja2VkLWJ5OiBQZXRlciBVamZhbHVzaSA8cGV0
ZXIudWpmYWx1c2lAZ21haWwuY29tPgo+CgpUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIGVmZm9y
dCB0byByZXZpZXcgbXkgcGF0Y2guCgpJIHdpbGwgZG8gdGhhdCBpbiBuZXcgdmVyc2lvbiBzb29u
LgoKPj4gRml4ZXM6IGQ3MDI0MTkxMzQxMyAoImRtYWVuZ2luZTogdGk6IGszLXVkbWE6IEFkZCBn
bHVlIGxheWVyIGZvciBub24gRE1BZW5naW5lIHVzZXJzIikKPj4gU2lnbmVkLW9mZi1ieTogTGlh
bmcgSGUgPHdpbmRobEAxMjYuY29tPgo+PiAtLS0KPj4gCj4+IEkgY2Fubm90IGZpbmQgdGhlICdr
My11ZG1hLXByaXZhdGUuYycgY29taXBsZSBpdGVtIGluIGRyaXZlcnMvZG1hL3RpL01ha2VmaWxl
LCAKPj4gSSB3b25kZXIgaWYgdGhlIGF1dGhvciBoYXMgZm9yZ290dGVuIHRoZSBjb21waWxlIGl0
ZW0gYW5kIHRoZQo+PiBrMy11ZG1hLXByaXZhdGUuYyBoYXMgbm90IGJlZW4gY29tcGlsZWQgYmVm
b3JlLgo+PiAKPj4gSSBoYXZlIHRyaWVkIHRvIGFkZCBrMy11ZG1hLXByaXZhdGUubyBpbiB0aGUg
TWFrZWZpbGUsIGJ1dCB0aGVyZSBhcmUgbG90cyBvZgo+PiBjb21waWxlIGVycm9ycy4gIAo+PiBQ
bGVhc2UgY2hlY2sgaXQgY2FyZWZ1bGx5IGFuZCBpZiBwb3NzYmlsZSBwbGVhc2UgdGVhY2ggbWUg
aG93IHRvIGNvbXBpbGUgaXQsIHRoYW5rcy4KPgo+dGhlIGszLXVkbWEtcHJpdmF0ZS5jIGlzIGlu
Y2x1ZGVkIGluIHRvIGszLXVkbWEuYyAoc2VlIGVuZCBvZiBmaWxlKS4KPldoZW4gdGhlIFVETUEg
c3RhY2sgd2FzIGludHJvZHVjZWQgd2UgbmVlZGVkIHRvIGhhdmUgYSBnbHVlIGxheWVyIHRvCj5z
ZXJ2aWNlIHRoZSBuZXR3b3JraW5nIHVzZXJzIGR1ZSB0byB0aGUgbGFjayBvZiBpbmZyYXN0cnVj
dHVyZSB2aWEKPkRNQWVuZ2luZS4KPlRoZSBnbHVlIGxheWVyIG5lZWRzIHRvIHRhcCBpbiB0byB0
aGUgRE1BZW5naW5lIGRyaXZlciwgYnV0IEkgZGlkIG5vdAo+d2FudGVkIHRvIGV4cG9zZSBsb3cg
bGV2ZWwgaW50ZXJmYWNlcywgc3RydWN0cywgb3BzIGluIG9yZGVyIHRvIGJlIGFibGUKPnRvIGdl
dCByaWQgb2YgdGhlIGdsdWUgbGF5ZXIgd2hlbiB3ZSBoYXZlIGFsbCB0aGUgbmVlZGVkIGZlYXR1
cmVzIGluCj5ETUFlbmdpbmUuCj4KPlRoZSBrMy11ZG1hLXByaXZhdGUuYyBpcyBwYXJ0IG9mIHRo
ZSBrMy11ZG1hLmMgYnV0IGtlcHQgYXMgc2VwYXJhdGUgZmlsZQo+dG8gbWFrZSBpdCBleHBsaWNp
dCB0aGF0IGl0IGlzIHN1cHBvc2UgdG8gZ28gYXdheSBhbmQgdG8gbm90IG1peCBpdCB3aXRoCj50
aGUgRE1BZW5naW5lIGRyaXZlci4KPgoKVGhhbmtzIGZvciB5b3UgZXhwbGFpbmF0aW9uLCB0aGlz
IGlzIGEgZ3JlYXQgbGVzc29uIQoKPj4gIGRyaXZlcnMvZG1hL3RpL2szLXVkbWEtcHJpdmF0ZS5j
IHwgNSArKy0tLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS90aS9rMy11ZG1hLXByaXZhdGUu
YyBiL2RyaXZlcnMvZG1hL3RpL2szLXVkbWEtcHJpdmF0ZS5jCj4+IGluZGV4IGQ0ZjFlNGU5NjAz
YS4uZWMyNzRlZjdkNWVhIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2RtYS90aS9rMy11ZG1hLXBy
aXZhdGUuYwo+PiArKysgYi9kcml2ZXJzL2RtYS90aS9rMy11ZG1hLXByaXZhdGUuYwo+PiBAQCAt
MzEsMTQgKzMxLDEzIEBAIHN0cnVjdCB1ZG1hX2RldiAqb2ZfeHVkbWFfZGV2X2dldChzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5wLCBjb25zdCBjaGFyICpwcm9wZXJ0eSkKPj4gIAl9Cj4+ICAKPj4gIAlw
ZGV2ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZSh1ZG1hX25vZGUpOwo+PiArCWlmIChucCAhPSB1
ZG1hX25vZGUpCj4+ICsJCW9mX25vZGVfcHV0KHVkbWFfbm9kZSk7Cj4KPkNhbiB5b3UgYWRkIGEg
YmxhbmsgbGluZSBoZXJlIGZvciByZWFkYWJpbGl0eT8KPgoKVGhhbmtzLCBJIHdpbGwgZG8gaXQu
Cgo+PiAgCWlmICghcGRldikgewo+PiAgCQlwcl9kZWJ1ZygiVURNQSBkZXZpY2Ugbm90IGZvdW5k
XG4iKTsKPj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVQUk9CRV9ERUZFUik7Cj4+ICAJfQo+PiAgCj4+
IC0JaWYgKG5wICE9IHVkbWFfbm9kZSkKPj4gLQkJb2Zfbm9kZV9wdXQodWRtYV9ub2RlKTsKPj4g
LQo+PiAgCXVkID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7Cj4+ICAJaWYgKCF1ZCkgewo+
PiAgCQlwcl9kZWJ1ZygiVURNQSBoYXMgbm90IGJlZW4gcHJvYmVkXG4iKTsKPgo+LS0gCj5QqKZ0
ZXIK
