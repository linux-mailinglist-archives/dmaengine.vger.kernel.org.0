Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABE65A03C3
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 00:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbiHXWH6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 18:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbiHXWH5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 18:07:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA2B786DF
        for <dmaengine@vger.kernel.org>; Wed, 24 Aug 2022 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661378874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGOw6yHuwLPSrg4cYvLL/LCKRkSmjdSEjyzIqaqf654=;
        b=gLlHDa3Ck3vCFT51uO78Xt4dMdX34eEc8z9VO6Go1EARCrQOhISKo1XH0H2k/9LASfmuB3
        VNPuX0V9BpOiH/dAozSSIoufz+UdAMJgoH9DbS6ZE+yd80ZCf1QNLrQ9k0/yzuhU6TJVNF
        hQWad4HUUyOawRfqpREgOzLKTEUbNM8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-bApLj389OVWg3N5S_GQRWg-1; Wed, 24 Aug 2022 18:07:53 -0400
X-MC-Unique: bApLj389OVWg3N5S_GQRWg-1
Received: by mail-qt1-f199.google.com with SMTP id fc18-20020a05622a489200b00344b09d2578so9492899qtb.13
        for <dmaengine@vger.kernel.org>; Wed, 24 Aug 2022 15:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=IGOw6yHuwLPSrg4cYvLL/LCKRkSmjdSEjyzIqaqf654=;
        b=i9zn4Ff1VpmdU1UoXzfcU98uahIr1/GfL6Q4dH3YXbqf/mtEozyL4wa7TTtiSvEgbV
         NjtxUq2/SpVcHQbObnE9xWJ0KhMKO1n1/GInJSjvMcZu8pKqYQXGVwTaQbH/4815wlJN
         QKQjAapckKBlcCNjIog9gPr9DY/FV7vu7eptFLvd4Ly9GZZHolldYfh30pwhB1ZA/E0f
         F6d+5QMVGwl/rdU6eRqk6kshMMmxBESgqyFKcT8Boe9n1eKedzqa238ZjL4ErWxOOtdK
         GmtPQoW1SPRAp8DnNpXoT6lne3TiGLEbwu6tNUS8ZKaku4BWWk9tWoBmD8PY+CxN6UHY
         ifWw==
X-Gm-Message-State: ACgBeo2Ubporz4TCCG9tacU83BzEOyyCQerumYLiD2p2Tj5rXzH/UKSV
        adhXUE8Ko6cCiUpuS9Y/+kBIjSAsQ5fJ0nJfVxxzfYZxOUzn/MYvQmjLopt1NsGQ3xhaFnozkSY
        CXu5jpYkdgB2Xdo0G6atm
X-Received: by 2002:a05:6214:20ac:b0:497:ba:1794 with SMTP id 12-20020a05621420ac00b0049700ba1794mr1141857qvd.70.1661378873224;
        Wed, 24 Aug 2022 15:07:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4oLphmGtsx7ZGFDXs4wrjtumTOHJUPE+v4ohRZCr1d1q742enBAgLJWxYeeb/TD5WlPOSRrQ==
X-Received: by 2002:a05:6214:20ac:b0:497:ba:1794 with SMTP id 12-20020a05621420ac00b0049700ba1794mr1141841qvd.70.1661378872948;
        Wed, 24 Aug 2022 15:07:52 -0700 (PDT)
Received: from [192.168.1.52] (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id n1-20020ac86741000000b0031eebfcb369sm12935896qtp.97.2022.08.24.15.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:07:52 -0700 (PDT)
Message-ID: <f59ea139533f37991e786cd8cf4a0d591133d92c.camel@redhat.com>
Subject: Re: [PATCH] dmaengine: idxd: Set workqueue state to disabled before
 trying to re-enable
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Date:   Wed, 24 Aug 2022 15:07:51 -0700
In-Reply-To: <d0dbdd27-a890-1eea-63b5-ab6aaa27583e@intel.com>
References: <20220824192913.2425634-1-jsnitsel@redhat.com>
         <1417f4ce-2573-5c88-6c92-fda5c57ebceb@intel.com>
         <20220824211625.mfcyefi5yvasdt4r@cantor>
         <d0dbdd27-a890-1eea-63b5-ab6aaa27583e@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTI0IGF0IDE0OjU5IC0wNzAwLCBEYXZlIEppYW5nIHdyb3RlOgo+IAo+
IE9uIDgvMjQvMjAyMiAyOjE2IFBNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+ID4gT24gV2Vk
LCBBdWcgMjQsIDIwMjIgYXQgMDE6Mjk6MDNQTSAtMDcwMCwgRGF2ZSBKaWFuZyB3cm90ZToKPiA+
ID4gT24gOC8yNC8yMDIyIDEyOjI5IFBNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+ID4gPiA+
IEZvciBhIHNvZnR3YXJlIHJlc2V0IGlkeGRfZGV2aWNlX3JlaW5pdCgpIGlzIGNhbGxlZCwgd2hp
Y2ggd2lsbAo+ID4gPiA+IHdhbGsKPiA+ID4gPiB0aGUgZGV2aWNlIHdvcmtxdWV1ZXMgdG8gc2Vl
IHdoaWNoIG9uZXMgd2VyZSBlbmFibGVkLCBhbmQgdHJ5Cj4gPiA+ID4gdG8KPiA+ID4gPiByZS1l
bmFibGUgdGhlbS4gSXQga2V5cyBvZmYgd3EtPnN0YXRlIGJlaW5nIGlEWERfV1FfRU5BQkxFRCwK
PiA+ID4gPiBidXQgdGhlCj4gPiA+ID4gZmlyc3QgdGhpbmcgaWR4ZF9lbmFibGVfd3EoKSB3aWxs
IGRvIGlzIHNlZSB0aGF0IHRoZSBzdGF0ZSBvZgo+ID4gPiA+IHRoZQo+ID4gPiA+IHdvcmtxdWV1
ZSBpcyBlbmFibGVkLCBhbmQgcmV0dXJuIDAgaW5zdGVhZCBvZiBhdHRlbXB0aW5nIHRvCj4gPiA+
ID4gaXNzdWUKPiA+ID4gPiBhIGNvbW1hbmQgdG8gZW5hYmxlIHRoZSB3b3JrcXVldWUuCj4gPiA+
ID4gCj4gPiA+ID4gU28gb25jZSBhIHdvcmtxdWV1ZSBpcyBmb3VuZCB0aGF0IG5lZWRzIHRvIGJl
IHJlLWVuYWJsZWQsCj4gPiA+ID4gc2V0IHRoZSBzdGF0ZSB0byBkaXNhYmxlZCBwcmlvciB0byBj
YWxsaW5nIGlkeGRfZW5hYmxlX3dxKCkuCj4gPiA+ID4gVGhpcyB3b3VsZCBhY2N1cmF0ZWx5IHJl
ZmxlY3QgdGhlIHN0YXRlIGlmIHRoZSBlbmFibGUgZmFpbHMKPiA+ID4gPiBhcyB3ZWxsLgo+ID4g
PiA+IAo+ID4gPiA+IENjOiBGZW5naHVhIFl1IDxmZW5naHVhLnl1QGludGVsLmNvbT4KPiA+ID4g
PiBDYzogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+Cj4gPiA+ID4gQ2M6IFZpbm9k
IEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+Cj4gPiA+ID4gQ2M6IGRtYWVuZ2luZUB2Z2VyLmtlcm5l
bC5vcmcKPiA+ID4gPiBGaXhlczogYmZlMWQ1NjA5MWMxICgiZG1hZW5naW5lOiBpZHhkOiBJbml0
IGFuZCBwcm9iZSBmb3IgSW50ZWwKPiA+ID4gPiBkYXRhIGFjY2VsZXJhdG9ycyIpCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogSmVycnkgU25pdHNlbGFhciA8anNuaXRzZWxAcmVkaGF0LmNvbT4KPiA+
ID4gPiAtLS0KPiA+ID4gPiDCoMKgIGRyaXZlcnMvZG1hL2lkeGQvaXJxLmMgfCAxICsKPiA+ID4g
PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+ID4gPiA+IAo+ID4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pZHhkL2lycS5jIGIvZHJpdmVycy9kbWEvaWR4ZC9pcnEu
Ywo+ID4gPiA+IGluZGV4IDc0M2VhZDVlYmM1Ny4uNzIzZWViNTMyOGQ2IDEwMDY0NAo+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvZG1hL2lkeGQvaXJxLmMKPiA+ID4gPiArKysgYi9kcml2ZXJzL2RtYS9p
ZHhkL2lycS5jCj4gPiA+ID4gQEAgLTUyLDYgKzUyLDcgQEAgc3RhdGljIHZvaWQgaWR4ZF9kZXZp
Y2VfcmVpbml0KHN0cnVjdAo+ID4gPiA+IHdvcmtfc3RydWN0ICp3b3JrKQo+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGlkeGRfd3EgKndxID0gaWR4ZC0+d3Fz
W2ldOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHdxLT5zdGF0
ZSA9PSBJRFhEX1dRX0VOQUJMRUQpIHsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHdxLT5zdGF0ZSA9IElEWERfV1FfRElTQUJMRUQ7Cj4gPiA+
IE1pZ2h0IGJlIGJldHRlciBvZmYgdG8gaW5zZXJ0IHRoaXMgbGluZSBpbgo+ID4gPiBpZHhkX3dx
X2Rpc2FibGVfY2xlYW51cCgpLiBJCj4gPiA+IHRoaW5rIHRoYXQgc2hvdWxkIHB1dCBpdCBpbiBz
YW5lIHN0YXRlLgo+ID4gSSBkb24ndCB0aGluayB0aGF0IGlzIGNhbGxlZCBpbiB0aGUgY29kZSBw
YXRoIHRoYXQgSSB3YXMgbG9va25nIGF0Lgo+ID4gSSd2ZSBiZWVuCj4gPiBsb29raW5nIGF0IHRo
aXMgYml0IG9mIHByb2Nlc3NfbWlzY19pbnRlcnJ1cHRzKCk6Cj4gPiAKPiA+IGhhbHQ6Cj4gPiDC
oMKgwqDCoMKgwqDCoMKgZ2Vuc3RzLmJpdHMgPSBpb3JlYWQzMihpZHhkLT5yZWdfYmFzZSArCj4g
PiBJRFhEX0dFTlNUQVRTX09GRlNFVCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGdlbnN0cy5z
dGF0ZSA9PSBJRFhEX0RFVklDRV9TVEFURV9IQUxUKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlkeGQtPnN0YXRlID0gSURYRF9ERVZfSEFMVEVEOwo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZ2Vuc3RzLnJlc2V0X3R5cGUgPT0KPiA+IElEWERf
REVWSUNFX1JFU0VUX1NPRlRXQVJFKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogSWYgd2UgbmVlZCBhIHNvZnR3YXJlIHJlc2V0LCB3ZSB3aWxs
Cj4gPiB0aHJvdyB0aGUgd29yawo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICogb24gYSBzeXN0ZW0gd29ya3F1ZXVlIGluIG9yZGVyIHRvIGFsbG93
Cj4gPiBpbnRlcnJ1cHRzCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKiBmb3IgdGhlIGRldmljZSBjb21tYW5kIGNvbXBsZXRpb25zLgo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBJTklUX1dPUksoJmlk
eGQtPndvcmssIGlkeGRfZGV2aWNlX3JlaW5pdCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBxdWV1ZV93b3JrKGlkeGQtPndxLCAmaWR4ZC0+d29y
ayk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSB7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZHhkLT5zdGF0ZSA9
IElEWERfREVWX0hBTFRFRDsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlkeGRfd3FzX3F1aWVzY2UoaWR4ZCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZHhkX3dxc191bm1hcF9wb3J0YWwoaWR4
ZCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBz
cGluX2xvY2soJmlkeGQtPmRldl9sb2NrKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlkeGRfZGV2aWNlX2NsZWFyX3N0YXRlKGlkeGQpOwo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2Vycigm
aWR4ZC0+cGRldi0+ZGV2LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJpZHhkIGhhbHRlZCwgbmVlZCAlcy5cbiIsCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZ2Vuc3RzLnJlc2V0X3R5cGUgPT0KPiA+IElEWERfREVWSUNFX1JFU0VUX0ZMUiA/
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIkZMUiIgOiAic3lzdGVtIHJlc2V0Iik7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzcGluX3VubG9jaygmaWR4ZC0+ZGV2X2xv
Y2spOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIC1FTlhJTzsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4g
wqDCoMKgwqDCoMKgwqDCoH0KPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ID4g
fQo+ID4gCj4gPiBTbyBpdCBzZWVzIHRoYXQgdGhlIGRldmljZSBpcyBoYWx0ZWQsIGFuZCBzdGlj
a3MKPiA+IGlkeGRfZGV2aWNlX3JlaW5pbnQoKSBvbiB0aGF0Cj4gPiB3b3JrcXVldWUuIFRoZSBp
ZHhkX2RldmljZV9yZWluaXQoKSBoYXMgdGhpcyBsb29wIHRvIHJlLWVuYWJsZSB0aGUKPiA+IGlk
eGQgd3FzOgo+IAo+IGlkeGRfZGV2aWNlX3JlaW5pdCgpIHNob3VsZCBjYWxsZWQgaWR4ZF9kZXZp
Y2VfcmVzZXQoKSBmaXJzdC4gQW5kCj4gdGhhdCAKPiBzaG91bGQgYXQgc29tZSBwb2ludCBjYWxs
IGlkeGRfd3FfZGlzYWJsZV9jbGVhbnVwKCkgYW5kIGNsZWFuIHVwIHRoZQo+IHN0YXRlcy4KPiAK
PiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4wLXJjMi9zb3VyY2UvZHJpdmVy
cy9kbWEvaWR4ZC9pcnEuYyNMNDIKPiAKPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51
eC92Ni4wLXJjMi9zb3VyY2UvZHJpdmVycy9kbWEvaWR4ZC9kZXZpY2UuYyNMNzI1Cj4gCj4gaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMC1yYzIvc291cmNlL2RyaXZlcnMvZG1h
L2lkeGQvZGV2aWNlLmMjTDcxMQo+IAo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L3Y2LjAtcmMyL3NvdXJjZS9kcml2ZXJzL2RtYS9pZHhkL2RldmljZS5jI0wzNzYKPiAKPiBTbyBp
ZiB3ZSBzdGljayB0aGUgd3Egc3RhdGUgcmVzZXQgaW4gdGhlcmUsIGl0IHNob3VsZCBzaG93IHVw
IGFzIAo+ICJkaXNhYmxlZCIgYnkgdGhlIHRpbWUgd2UgdHJ5IHRvIGVuYWJsZSB0aGUgV1FzIGFn
YWluLiBEb2VzIHRoYXQgbG9vawo+IHJlYXNvbmFibGU/Cj4gCgpBaCwgeWVhaCBJIHNlZSB0aGF0
IG5vdy4gU28sIGlmIGl0IGRvZXMgc2V0IHRoZSBzdGF0ZSB0byBkaXNhYmxlZCBpbgppZHhkX3dx
X2Rpc2FibGVfY2xlYW51cCgpLCBkb2VzIGl0IGhhdmUgYW5vdGhlciBtZWFucyB0byB0cmFjayB3
aGljaAp3cXMgbmVlZCB0byBiZSByZS1lbmFibGVkIGZvciB0aGF0IGxvb3AgdGhhdCBoYXBwZW5z
IGFmdGVyIHRoZQppZHhkX2RldmljZV9yZXNldCgpIGNhbGw/Cgo+IAo+ID4gCj4gPiDCoMKgwqDC
oMKgwqDCoMKgZm9yIChpID0gMDsgaSA8IGlkeGQtPm1heF93cXM7IGkrKykgewo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaWR4ZF93cSAqd3EgPSBpZHhkLT53cXNb
aV07Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHdxLT5zdGF0
ZSA9PSBJRFhEX1dRX0VOQUJMRUQpIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHdxLT5zdGF0ZSA9IElEWERfV1FfRElTQUJMRUQ7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYyA9IGlkeGRfd3Ff
ZW5hYmxlKHdxKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGlmIChyYyA8IDApIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfd2FybihkZXYsICJVbmFibGUgdG8g
cmUtZW5hYmxlCj4gPiB3cSAlc1xuIiwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9u
YW1lKHdxX2NvbmZkZXYod3EpKSk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0K
PiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiAKPiA+IE9uY2UgeW91IGdvIGludG8gaWR4ZF93cV9l
bmFibGUoKSB0aG91Z2ggeW91IGdldCB0aGlzIGNoZWNrIGF0IHRoZQo+ID4gYmVnaW5uaW5nOgo+
ID4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHdxLT5zdGF0ZSA9PSBJRFhEX1dRX0VOQUJMRUQp
IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2RiZyhkZXYsICJXUSAl
ZCBhbHJlYWR5IGVuYWJsZWRcbiIsIHdxLT5pZCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiAwOwo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+IAo+ID4gU28gSUlV
QyBpdCBzZWVzIHRoZSBkZXZpY2UgaXMgaGFsdGVkLCBnb2VzIHRvIHJlc2V0IGl0LCBmaWd1cmVz
IG91dAo+ID4gYSB3cQo+ID4gc2hvdWxkIGJlIHJlLWVuYWJsZWQsIGNhbGxzIGlkeGRfd3FfZW5h
YmxlKCkgd2hpY2ggaGl0cyB0aGUgY2hlY2ssCj4gPiByZXR1cm5zCj4gPiAwIGFuZCB0aGUgd3Eg
aXMgbmV2ZXIgcmVhbGx5IHJlLWVuYWJsZWQsIHRob3VnaCBpdCB3aWxsIHN0aWxsIGhhdmUKPiA+
IHdxIHN0YXRlCj4gPiBzZXQgdG8gSURYRF9XUV9FTkFCTEVELgo+ID4gCj4gPiBPciBhbSBJIG1p
c3Npbmcgc29tZXRoaW5nPwo+ID4gCj4gPiBSZWdhcmRzLAo+ID4gSmVycnkKPiA+IAo+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJjID0gaWR4
ZF93cV9lbmFibGUod3EpOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIChyYyA8IDApIHsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X3dhcm4oZGV2
LCAiVW5hYmxlIHRvIHJlLQo+ID4gPiA+IGVuYWJsZSB3cSAlc1xuIiwKPiAKCg==

