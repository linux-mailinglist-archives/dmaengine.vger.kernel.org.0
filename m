Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BAE1DE4F0
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2020 12:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgEVK5b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 May 2020 06:57:31 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:62450 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728371AbgEVK5a (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 22 May 2020 06:57:30 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Fri, 22 May 2020 18:57:18
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.77.158]
Date:   Fri, 22 May 2020 18:57:18 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Jon Hunter" <jonathanh@nvidia.com>
Cc:     kjlu@umn.edu, "Laxman Dewangan" <ldewangan@nvidia.com>,
        "Vinod Koul" <vkoul@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] dmaengine: tegra210-adma: Fix runtime PM imbalance
 on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <967c17d2-6b57-27f0-7762-cd0835caaec9@nvidia.com>
References: <20200522075846.30706-1-dinghao.liu@zju.edu.cn>
 <967c17d2-6b57-27f0-7762-cd0835caaec9@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <45d18e3c.bfdab.1723c07b7d3.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgDn7z8OsMdeRoYBAg--.44085W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgUIBlZdtOQgrAASsM
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbW0S07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_JrI_JrylV2xY6cIj6I8E87Iv67AKxVWxJVW8Jr1lV2xY6cvjeVCFs4IE7xkEbVWU
        JVW8JwCS07vE7I0Y64k_MIAIbVCY02Avz4vE14v_Gw1lV2xY6xkI7II2jI8vz4vEwIxGrw
        CS07vE42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMIAIbVCF72vE77IF4wCS07vE4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lV2xY6I8I3I0E5I8CrVAFwI0_Jr0_Jr4lV2xY6I8I3I0E7480Y4
        vE14v26r106r1rMIAIbVC2zVAF1VAY17CE14v26r1q6r43MIAIbVCI42IY6xIIjxv20xvE
        14v26r1j6r1xMIAIbVCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lV2xY6IIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCS07vEIxAIcVC2z280aVAFwI0_Gr0_Cr1lV2xY6IIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73U
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAKPiBPbiAyMi8wNS8yMDIwIDA4OjU4LCBEaW5naGFvIExpdSB3cm90ZToKPiA+IHBtX3J1bnRp
bWVfZ2V0X3N5bmMoKSBpbmNyZW1lbnRzIHRoZSBydW50aW1lIFBNIHVzYWdlIGNvdW50ZXIgZXZl
bgo+ID4gd2hlbiBpdCByZXR1cm5zIGFuIGVycm9yIGNvZGUuIFRodXMgYSBwYWlyaW5nIGRlY3Jl
bWVudCBpcyBuZWVkZWQgb24KPiA+IHRoZSBlcnJvciBoYW5kbGluZyBwYXRoIHRvIGtlZXAgdGhl
IGNvdW50ZXIgYmFsYW5jZWQuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IERpbmdoYW8gTGl1IDxk
aW5naGFvLmxpdUB6anUuZWR1LmNuPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9kbWEvdGVncmEyMTAt
YWRtYS5jIHwgMSArCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4gPiAKPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS90ZWdyYTIxMC1hZG1hLmMgYi9kcml2ZXJzL2RtYS90
ZWdyYTIxMC1hZG1hLmMKPiA+IGluZGV4IGM0Y2U1ZGZiMTQ5Yi4uODAzZTFmNGQ1ZGFjIDEwMDY0
NAo+ID4gLS0tIGEvZHJpdmVycy9kbWEvdGVncmEyMTAtYWRtYS5jCj4gPiArKysgYi9kcml2ZXJz
L2RtYS90ZWdyYTIxMC1hZG1hLmMKPiA+IEBAIC02NTgsNiArNjU4LDcgQEAgc3RhdGljIGludCB0
ZWdyYV9hZG1hX2FsbG9jX2NoYW5fcmVzb3VyY2VzKHN0cnVjdCBkbWFfY2hhbiAqZGMpCj4gPiAg
Cj4gPiAgCXJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmModGRjMmRldih0ZGMpKTsKPiA+ICAJaWYg
KHJldCA8IDApIHsKPiA+ICsJCXBtX3J1bnRpbWVfcHV0X3N5bmModGRjMmRldih0ZGMpKTsKPiA+
ICAJCWZyZWVfaXJxKHRkYy0+aXJxLCB0ZGMpOwo+ID4gIAkJcmV0dXJuIHJldDsKPiA+ICAJfQo+
ID4gCj4gCj4gCj4gVGhlcmUgaXMgYW5vdGhlciBwbGFjZSBpbiBwcm9iZSB0aGF0IG5lZWRzIHRv
IGJlIGZpeGVkIGFzIHdlbGwuIENhbiB5b3UKPiBjb3JyZWN0IHRoaXMgd2hpbGUgeW91IGFyZSBh
dCBpdD8KPiAKPiBUaGFua3MKPiBKb24KPiAKPiAtLSAKPiBudnB1YmxpYwoKU3VyZS4gSSBoYXZl
IHNlbnQgYSBwYXRjaCB0byBmaXggUE0gaW1iYWxhbmNlIGluIHRlZ3JhX2FkbWFfcHJvYmUoKS4K
ClJlZ2FyZHMsCkRpbmdoYW8=
