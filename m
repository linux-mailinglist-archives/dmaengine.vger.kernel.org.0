Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BE81DE56D
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2020 13:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgEVLcd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 May 2020 07:32:33 -0400
Received: from aliyun-cloud.icoremail.net ([47.90.88.95]:54570 "HELO
        aliyun-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S1728281AbgEVLcc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 May 2020 07:32:32 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Fri, 22 May 2020 19:32:10
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.77.158]
Date:   Fri, 22 May 2020 19:32:10 +0800 (GMT+08:00)
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
In-Reply-To: <e2274ef7-2c33-cd3a-319f-45c5c27cff3e@nvidia.com>
References: <20200522075846.30706-1-dinghao.liu@zju.edu.cn>
 <967c17d2-6b57-27f0-7762-cd0835caaec9@nvidia.com>
 <45d18e3c.bfdab.1723c07b7d3.Coremail.dinghao.liu@zju.edu.cn>
 <e2274ef7-2c33-cd3a-319f-45c5c27cff3e@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1b580492.bff38.1723c27a5e8.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgCXPxw6uMdeTRQCAg--.32364W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoIBlZdtOQpEQAFsg
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbW0S07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lV2xY6cIj6I8E87Iv67AKxVWxJVW8Jr1lV2xY6cvjeVCFs4IE7xkEbVWU
        JVW8JwCS07vE7I0Y64k_MIAIbVCY02Avz4vE14v_Gw4lV2xY6xkI7II2jI8vz4vEwIxGrw
        CS07vE42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMIAIbVCF72vE77IF4wCS07vE4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lV2xY6I8I3I0E5I8CrVAFwI0_Jr0_Jr4lV2xY6I8I3I0E7480Y4
        vE14v26r106r1rMIAIbVC2zVAF1VAY17CE14v26r1q6r43MIAIbVCI42IY6xIIjxv20xvE
        14v26r1j6r1xMIAIbVCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lV2xY6IIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCS07vEIxAIcVC2z280aVAFwI0_Gr0_Cr1lV2xY6IIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73U
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAKPiBPbiAyMi8wNS8yMDIwIDExOjU3LCBkaW5naGFvLmxpdUB6anUuZWR1LmNuIHdyb3RlOgo+
ID4+Cj4gPj4gT24gMjIvMDUvMjAyMCAwODo1OCwgRGluZ2hhbyBMaXUgd3JvdGU6Cj4gPj4+IHBt
X3J1bnRpbWVfZ2V0X3N5bmMoKSBpbmNyZW1lbnRzIHRoZSBydW50aW1lIFBNIHVzYWdlIGNvdW50
ZXIgZXZlbgo+ID4+PiB3aGVuIGl0IHJldHVybnMgYW4gZXJyb3IgY29kZS4gVGh1cyBhIHBhaXJp
bmcgZGVjcmVtZW50IGlzIG5lZWRlZCBvbgo+ID4+PiB0aGUgZXJyb3IgaGFuZGxpbmcgcGF0aCB0
byBrZWVwIHRoZSBjb3VudGVyIGJhbGFuY2VkLgo+ID4+Pgo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBE
aW5naGFvIExpdSA8ZGluZ2hhby5saXVAemp1LmVkdS5jbj4KPiA+Pj4gLS0tCj4gPj4+ICBkcml2
ZXJzL2RtYS90ZWdyYTIxMC1hZG1hLmMgfCAxICsKPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQo+ID4+Pgo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvdGVncmEyMTAt
YWRtYS5jIGIvZHJpdmVycy9kbWEvdGVncmEyMTAtYWRtYS5jCj4gPj4+IGluZGV4IGM0Y2U1ZGZi
MTQ5Yi4uODAzZTFmNGQ1ZGFjIDEwMDY0NAo+ID4+PiAtLS0gYS9kcml2ZXJzL2RtYS90ZWdyYTIx
MC1hZG1hLmMKPiA+Pj4gKysrIGIvZHJpdmVycy9kbWEvdGVncmEyMTAtYWRtYS5jCj4gPj4+IEBA
IC02NTgsNiArNjU4LDcgQEAgc3RhdGljIGludCB0ZWdyYV9hZG1hX2FsbG9jX2NoYW5fcmVzb3Vy
Y2VzKHN0cnVjdCBkbWFfY2hhbiAqZGMpCj4gPj4+ICAKPiA+Pj4gIAlyZXQgPSBwbV9ydW50aW1l
X2dldF9zeW5jKHRkYzJkZXYodGRjKSk7Cj4gPj4+ICAJaWYgKHJldCA8IDApIHsKPiA+Pj4gKwkJ
cG1fcnVudGltZV9wdXRfc3luYyh0ZGMyZGV2KHRkYykpOwo+ID4+PiAgCQlmcmVlX2lycSh0ZGMt
PmlycSwgdGRjKTsKPiA+Pj4gIAkJcmV0dXJuIHJldDsKPiA+Pj4gIAl9Cj4gPj4+Cj4gPj4KPiA+
Pgo+ID4+IFRoZXJlIGlzIGFub3RoZXIgcGxhY2UgaW4gcHJvYmUgdGhhdCBuZWVkcyB0byBiZSBm
aXhlZCBhcyB3ZWxsLiBDYW4geW91Cj4gPj4gY29ycmVjdCB0aGlzIHdoaWxlIHlvdSBhcmUgYXQg
aXQ/Cj4gPj4KPiA+PiBUaGFua3MKPiA+PiBKb24KPiA+Pgo+ID4+IC0tIAo+ID4+IG52cHVibGlj
Cj4gPiAKPiA+IFN1cmUuIEkgaGF2ZSBzZW50IGEgcGF0Y2ggdG8gZml4IFBNIGltYmFsYW5jZSBp
biB0ZWdyYV9hZG1hX3Byb2JlKCkuCj4gCj4gCj4gWW91IHNob3VsZCBvbmx5IHNlbmQgb25lIHBh
dGNoIHRvIGZpeCBib3RoIGluc3RhbmNlcyBhcyBpdCBpcyB0aGUgc2FtZQo+IGRyaXZlci4gSXQg
aXMgaW1wb3NzaWJsZSB0byBmaWd1cmUgb3V0IHRoYXQgdHdvIHBhdGNoZXMgd2l0aCB0aGUgc2Ft
ZQo+ICRzdWJqZWN0IGFyZSBkaWZmZXJlbnQuCj4gCj4gSm9uCj4gCj4gLS0gCj4gbnZwdWJsaWMK
Ck9LLiBJIHdpbGwgZml4IHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbiBvZiBwYXRjaC4KClJlZ2Fy
ZHMsCkRpbmdoYW8K
