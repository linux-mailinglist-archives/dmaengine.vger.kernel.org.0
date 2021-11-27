Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA5B45F9ED
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349612AbhK0B25 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:28:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36172 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346673AbhK0B04 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:26:56 -0500
Message-ID: <20211126224100.303046749@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=D0yh694HAZ3x2h0rG71M6T2fw5sthPkuogohG8lSbJI=;
        b=w6pK52XDa9bfNu68RSrKvm6GKEVwOgeG0R2mjGy+Ljv0EL5wC2cqlsVuONXECwcosy4NYg
        Zvllz2i/TQbjvQA7mutF9MuQtpBIbohCrmIsj8xUhNU23Gn61CG8jN4LTu11EFtUGrnaHv
        ouPUxlCHTRZBerHMOivkSFS4WLqtpSDJ8BHr5SAmyF0lGNYOFQpjYvDiNVqoEN30Cs3zyO
        vrAXyUm7IZiq23GkM8spyQ258mPOLMbAYABQP0y98XyOspgxj/wAx/lYiDf83Myy4zjBCs
        n86aPNJth/ecj9aTFrQLoem0s1rbnZ0PJu86OteSxzvsR8niKLzKFnhgQIy4oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=D0yh694HAZ3x2h0rG71M6T2fw5sthPkuogohG8lSbJI=;
        b=LeNdtrqF7l8D9NVX/BTtPjeTBvYqfWdFGvwOiZNk2hcW7E3tx+o6AguxMtI1XDLhMnWr7r
        0DIN7t0ZMAVTaECw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: [patch 00/37] genirq/msi, PCI/MSI: Spring cleaning - Part 2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Sat, 27 Nov 2021 02:21:17 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhpcyBpcyB0aGUgc2Vjb25kIHBhcnQgb2YgW1BDSV1NU0kgcmVmYWN0b3Jpbmcgd2hpY2ggYWlt
cyB0byBwcm92aWRlIHRoZQphYmlsaXR5IG9mIGV4cGFuZGluZyBNU0ktWCB2ZWN0b3JzIGFmdGVy
IGVuYWJsaW5nIE1TSS1YLgoKVGhlIGZpcnN0IHBhcnQgb2YgdGhpcyB3b3JrIGNhbiBiZSBmb3Vu
ZCBoZXJlOgoKICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMTExMjYyMjI3MDAuODYy
NDA3OTc3QGxpbnV0cm9uaXguZGUKClRoaXMgc2Vjb25kIHBhcnQgaGFzIHRoZSBmb2xsb3dpbmcg
aW1wb3J0YW50IGNoYW5nZXM6CgogICAxKSBDbGVhbnVwIG9mIHRoZSBNU0kgcmVsYXRlZCBkYXRh
IGluIHN0cnVjdCBkZXZpY2UKCiAgICAgIHN0cnVjdCBkZXZpY2UgY29udGFpbnMgYXQgdGhlIG1v
bWVudCB2YXJpb3VzIE1TSSByZWxhdGVkIHBhcnRzLiBTb21lCiAgICAgIG9mIHRoZW0gKHRoZSBp
cnEgZG9tYWluIHBvaW50ZXIpIGNhbm5vdCBiZSBtb3ZlZCBvdXQsIGJ1dCB0aGUgcmVzdAogICAg
ICBjYW4gYmUgYWxsb2NhdGVkIG9uIGZpcnN0IHVzZS4gVGhpcyBpcyBpbiBwcmVwYXJhdGlvbiBv
ZiBhZGRpbmcgbW9yZQogICAgICBwZXIgZGV2aWNlIE1TSSBkYXRhIGxhdGVyIG9uLgoKICAgMikg
Q29uc29saWRhdGlvbiBvZiBzeXNmcyBoYW5kbGluZwoKICAgICAgQXMgYSBmaXJzdCBzdGVwIHRo
aXMgbW92ZXMgdGhlIHN5c2ZzIHBvaW50ZXIgZnJvbSBzdHJ1Y3QgbXNpX2Rlc2MKICAgICAgaW50
byB0aGUgbmV3IHBlciBkZXZpY2UgTVNJIGRhdGEgc3RydWN0dXJlIHdoZXJlIGl0IGJlbG9uZ3Mu
CgogICAgICBMYXRlciBjaGFuZ2VzIHdpbGwgY2xlYW51cCB0aGlzIGNvZGUgZnVydGhlciwgYnV0
IHRoYXQncyBub3QgcG9zc2libGUKICAgICAgYXQgdGhpcyBwb2ludC4KCiAgIDMpIFN0b3JlIHBl
ciBkZXZpY2UgcHJvcGVydGllcyBpbiB0aGUgcGVyIGRldmljZSBNU0kgZGF0YSB0byBhdm9pZAog
ICAgICBsb29raW5nIHVwIE1TSSBkZXNjcmlwdG9ycyBhbmQgYW5hbHlzaW5nIHRoZWlyIGRhdGEu
IENsZWFudXAgYWxsCiAgICAgIHJlbGF0ZWQgdXNlIGNhc2VzLgoKICAgNCkgUHJvdmlkZSBhIGZ1
bmN0aW9uIHRvIHJldHJpZXZlIHRoZSBMaW51eCBpbnRlcnJ1cHQgbnVtYmVyIGZvciBhIGdpdmVu
CiAgICAgIE1TSSBpbmRleCBzaW1pbGFyIHRvIHBjaV9pcnFfdmVjdG9yKCkgYW5kIGNsZWFudXAg
YWxsIG9wZW4gY29kZWQKICAgICAgdmFyaWFudHMuCgpUaGUgc2VyaWVzIGlzIGJhc2VkIG9uOgoK
ICAgICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9k
ZXZlbC5naXQgbXNpLXYxLXBhcnQtMQoKYW5kIGFsc28gYXZhaWxhYmxlIGZyb20gZ2l0OgoKICAg
ICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9kZXZl
bC5naXQgbXNpLXYxLXBhcnQtMgoKRm9yIHRoZSBjdXJpb3VzIHdobyBjYW4ndCB3YWl0IGZvciB0
aGUgbmV4dCBwYXJ0IHRvIGFycml2ZSB0aGUgZnVsbCBzZXJpZXMKaXMgYXZhaWxhYmxlIHZpYToK
CiAgICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RnbHgv
ZGV2ZWwuZ2l0IG1zaS12MS1wYXJ0LTQKClRoYW5rcywKCgl0Z2x4Ci0tLQogYXJjaC9wb3dlcnBj
L3BsYXRmb3Jtcy9jZWxsL2F4b25fbXNpLmMgICAgICAgICAgICAgIHwgICAgNiAKIGFyY2gvcG93
ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9tc2kuYyAgICAgICAgICAgICAgICB8ICAgMzggKy0tLQog
YXJjaC94ODYva2VybmVsL2FwaWMvbXNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
NSAKIGFyY2gveDg2L3BjaS94ZW4uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgIDggCiBkcml2ZXJzL2Jhc2UvY29yZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgICAxIAogZHJpdmVycy9iYXNlL3BsYXRmb3JtLW1zaS5jICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDE1MiArKysrKysrKy0tLS0tLS0tLQogZHJpdmVycy9idXMvZnNsLW1jL2RwcmMt
ZHJpdmVyLmMgICAgICAgICAgICAgICAgICAgIHwgICAgOCAKIGRyaXZlcnMvYnVzL2ZzbC1tYy9m
c2wtbWMtYWxsb2NhdG9yLmMgICAgICAgICAgICAgICB8ICAgIDkgLQogZHJpdmVycy9idXMvZnNs
LW1jL2ZzbC1tYy1tc2kuYyAgICAgICAgICAgICAgICAgICAgIHwgICAyNiArLS0KIGRyaXZlcnMv
ZG1hL212X3hvcl92Mi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMTYgLQogZHJp
dmVycy9kbWEvcWNvbS9oaWRtYS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0NCAr
Ky0tLQogZHJpdmVycy9kbWEvdGkvazMtdWRtYS1wcml2YXRlLmMgICAgICAgICAgICAgICAgICAg
IHwgICAgNiAKIGRyaXZlcnMvZG1hL3RpL2szLXVkbWEuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgMTQgLQogZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMu
YyAgICAgICAgIHwgICAyMyAtLQogZHJpdmVycy9pcnFjaGlwL2lycS1tYmlnZW4uYyAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgNCAKIGRyaXZlcnMvaXJxY2hpcC9pcnEtbXZlYnUtaWN1LmMg
ICAgICAgICAgICAgICAgICAgICB8ICAgMTIgLQogZHJpdmVycy9pcnFjaGlwL2lycS10aS1zY2kt
aW50YS5jICAgICAgICAgICAgICAgICAgIHwgICAgMiAKIGRyaXZlcnMvbWFpbGJveC9iY20tZmxl
eHJtLW1haWxib3guYyAgICAgICAgICAgICAgICB8ICAgIDkgLQogZHJpdmVycy9uZXQvZXRoZXJu
ZXQvZnJlZXNjYWxlL2RwYWEyL2RwYWEyLWV0aC5jICAgIHwgICAgNCAKIGRyaXZlcnMvbmV0L2V0
aGVybmV0L2ZyZWVzY2FsZS9kcGFhMi9kcGFhMi1wdHAuYyAgICB8ICAgIDQgCiBkcml2ZXJzL25l
dC9ldGhlcm5ldC9mcmVlc2NhbGUvZHBhYTIvZHBhYTItc3dpdGNoLmMgfCAgICA1IAogZHJpdmVy
cy9wY2kvbXNpL2lycWRvbWFpbi5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyMCArLQog
ZHJpdmVycy9wY2kvbXNpL2xlZ2FjeS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
NiAKIGRyaXZlcnMvcGNpL21zaS9tc2kuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAxMTggKysrKystLS0tLS0tLQogZHJpdmVycy9wY2kveGVuLXBjaWZyb250LmMgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgMiAKIGRyaXZlcnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgIDUgCiBkcml2ZXJzL3NvYy9mc2wvZHBpby9kcGlvLWRy
aXZlci5jICAgICAgICAgICAgICAgICAgfCAgICA4IAogZHJpdmVycy9zb2MvdGkvazMtcmluZ2Fj
Yy5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNiAKIGRyaXZlcnMvc29jL3RpL3RpX3Nj
aV9pbnRhX21zaS5jICAgICAgICAgICAgICAgICAgICB8ICAgMjIgLS0KIGRyaXZlcnMvdmZpby9m
c2wtbWMvdmZpb19mc2xfbWNfaW50ci5jICAgICAgICAgICAgICB8ICAgIDQgCiBpbmNsdWRlL2xp
bnV4L2RldmljZS5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDI2ICsrLQogaW5j
bHVkZS9saW51eC9mc2wvbWMuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNCAK
IGluY2x1ZGUvbGludXgvbXNpLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAx
MTggKysrKysrKy0tLS0tLQogaW5jbHVkZS9saW51eC9wY2kuaCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgMSAKIGluY2x1ZGUvbGludXgvc29jL3RpL3RpX3NjaV9pbnRhX21z
aS5oICAgICAgICAgICAgICB8ICAgIDEgCiBrZXJuZWwvaXJxL21zaS5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMTcxICsrKysrKysrKysrKysrKy0tLS0tCiAzNiBmaWxl
cyBjaGFuZ2VkLCA0NjMgaW5zZXJ0aW9ucygrKSwgNDQ1IGRlbGV0aW9ucygtKQo=
