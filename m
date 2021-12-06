Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D3F46AC49
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 23:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357751AbhLFWm2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 17:42:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46462 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357744AbhLFWm1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 17:42:27 -0500
Message-ID: <20211206210307.625116253@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638830336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tVxkONw1+URUxuo5QL2ocxThr7/mkfa4+qL7IuxO3Uk=;
        b=IBPmwzRmWD5mL6+e7MwJlzRwVEFnyloQOG5U1+MtcbGwWlmr/iX9fTfUI/80/wO154AnhB
        8DYtOoCiUZGZIX7xxJRto86p8RkbCzd/unh1t58dBbsJrwuPqPvrRLRXrT0esBwzHbNsNa
        qwXZqvTJre7RZQfDg4/dTnBaJ4Vn9A0GgekS+1e4Qf5kRU0iK9FpbDyilXUeeC7+VrAfb5
        IxJNcokipuIGvUWHF5lH8dowLW34B6L9V/hmTpeZhSPpHFMlpyl8w1QpGVxHjEjKadyW2W
        7U4rDr3YJC9E75LoEvXhJG05GptEAkSgVKVq9N1KE7tsTr7r8yq+qfSK1FbT+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638830336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tVxkONw1+URUxuo5QL2ocxThr7/mkfa4+qL7IuxO3Uk=;
        b=kGhsuXkAAqnqxB8SQ+Z7lY2BC9yD4sp1NOG0tpAY5Yhj/oSfoQ4S3EJ7Pv7mdUHrVMdkTQ
        yUjnayt7pKthTuCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [patch V2 00/36] genirq/msi, PCI/MSI: Spring cleaning - Part 2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Mon,  6 Dec 2021 23:38:56 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ClRoaXMgaXMgdGhlIHNlY29uZCBwYXJ0IG9mIFtQQ0ldTVNJIHJlZmFjdG9yaW5nIHdoaWNoIGFp
bXMgdG8gcHJvdmlkZSB0aGUKYWJpbGl0eSBvZiBleHBhbmRpbmcgTVNJLVggdmVjdG9ycyBhZnRl
ciBlbmFibGluZyBNU0ktWC4KClRoZSBmaXJzdCBwYXJ0IG9mIHRoaXMgd29yayBjYW4gYmUgZm91
bmQgaGVyZToKCiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjExMjA2MjEwMTQ3Ljg3
Mjg2NTgyM0BsaW51dHJvbml4LmRlCgpUaGlzIHNlY29uZCBwYXJ0IGhhcyB0aGUgZm9sbG93aW5n
IGltcG9ydGFudCBjaGFuZ2VzOgoKICAgMSkgQ2xlYW51cCBvZiB0aGUgTVNJIHJlbGF0ZWQgZGF0
YSBpbiBzdHJ1Y3QgZGV2aWNlCgogICAgICBzdHJ1Y3QgZGV2aWNlIGNvbnRhaW5zIGF0IHRoZSBt
b21lbnQgdmFyaW91cyBNU0kgcmVsYXRlZCBwYXJ0cy4gU29tZQogICAgICBvZiB0aGVtICh0aGUg
aXJxIGRvbWFpbiBwb2ludGVyKSBjYW5ub3QgYmUgbW92ZWQgb3V0LCBidXQgdGhlIHJlc3QKICAg
ICAgY2FuIGJlIGFsbG9jYXRlZCBvbiBmaXJzdCB1c2UuIFRoaXMgaXMgaW4gcHJlcGFyYXRpb24g
b2YgYWRkaW5nIG1vcmUKICAgICAgcGVyIGRldmljZSBNU0kgZGF0YSBsYXRlciBvbi4KCiAgIDIp
IENvbnNvbGlkYXRpb24gb2Ygc3lzZnMgaGFuZGxpbmcKCiAgICAgIEFzIGEgZmlyc3Qgc3RlcCB0
aGlzIG1vdmVzIHRoZSBzeXNmcyBwb2ludGVyIGZyb20gc3RydWN0IG1zaV9kZXNjCiAgICAgIGlu
dG8gdGhlIG5ldyBwZXIgZGV2aWNlIE1TSSBkYXRhIHN0cnVjdHVyZSB3aGVyZSBpdCBiZWxvbmdz
LgoKICAgICAgTGF0ZXIgY2hhbmdlcyB3aWxsIGNsZWFudXAgdGhpcyBjb2RlIGZ1cnRoZXIsIGJ1
dCB0aGF0J3Mgbm90IHBvc3NpYmxlCiAgICAgIGF0IHRoaXMgcG9pbnQuCgogICAzKSBTdG9yZSBw
ZXIgZGV2aWNlIHByb3BlcnRpZXMgaW4gdGhlIHBlciBkZXZpY2UgTVNJIGRhdGEgdG8gYXZvaWQK
ICAgICAgbG9va2luZyB1cCBNU0kgZGVzY3JpcHRvcnMgYW5kIGFuYWx5c2luZyB0aGVpciBkYXRh
LiBDbGVhbnVwIGFsbAogICAgICByZWxhdGVkIHVzZSBjYXNlcy4KCiAgIDQpIFByb3ZpZGUgYSBm
dW5jdGlvbiB0byByZXRyaWV2ZSB0aGUgTGludXggaW50ZXJydXB0IG51bWJlciBmb3IgYSBnaXZl
bgogICAgICBNU0kgaW5kZXggc2ltaWxhciB0byBwY2lfaXJxX3ZlY3RvcigpIGFuZCBjbGVhbnVw
IGFsbCBvcGVuIGNvZGVkCiAgICAgIHZhcmlhbnRzLgoKVGhpcyBzZWNvbmQgc2VyaWVzIGlzIGJh
c2VkIG9uOgoKICAgICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvdGdseC9kZXZlbC5naXQgbXNpLXYyLXBhcnQtMQoKYW5kIGFsc28gYXZhaWxhYmxlIGZyb20g
Z2l0OgoKICAgICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dGdseC9kZXZlbC5naXQgbXNpLXYyLXBhcnQtMgoKRm9yIHRoZSBjdXJpb3VzIHdobyBjYW4ndCB3
YWl0IGZvciB0aGUgbmV4dCBwYXJ0IHRvIGFycml2ZSB0aGUgZnVsbCBzZXJpZXMKaXMgYXZhaWxh
YmxlIHZpYToKCiAgICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RnbHgvZGV2ZWwuZ2l0IG1zaS12Mi1wYXJ0LTMKClYxIG9mIHRoaXMgc2VyaWVzIGNhbiBi
ZSBmb3VuZCBoZXJlOgoKICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMTExMjYyMjQx
MDAuMzAzMDQ2NzQ5QGxpbnV0cm9uaXguZGUKCkNoYW5nZXMgdmVyc3VzIFYxOgoKICAtIEZpeCB0
aGUgcGNpX2lycV92ZWN0b3IoKSB0aGlua28gLSBNYXJjCgogIC0gRml4IHRoZSBwb3dlcnBjIGZh
bGxvdXQgLSBDZWRyaWMsIEFuZHkKCiAgLSBBZGRyZXNzZWQgY29kaW5nc3R5bGUvY29tbWVudHMg
ZmVlZGJhY2sgLSBKb25hdGhhbgoKICAtIEFkZGVkIGEgTVNJIHByb3BlcnRpZXMgc2V0dGVyIHRv
IHByZXBhcmUgZm9yIGxhdGVyIGNoYW5nZXMKCiAgLSBDb25maW5lZCB0aGUgZ2xvYmFsIG1zaSpz
eXNmcyBmdW5jdGlvbnMgdG8gbGVnYWN5IGNvZGUKCiAgLSBEcm9wcGVkIHRoZSBNU0kgbG9jayBw
YXRjaCBhcyB0aGUgbG9jayBoYXMgbW92ZWQgdG8gc3RydWN0IHBjaV9kZXYKICAgIGluIFYyIHBh
cnQtMSBub3cKCiAgLSBQaWNrZWQgdXAgUmV2aWV3ZWQvVGVzdGVkL0Fja2VkLWJ5IHRhZ3MgYXMg
YXBwcm9wcmlhdGUKClRoYW5rcywKCgl0Z2x4Ci0tLQogYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9j
ZWxsL2F4b25fbXNpLmMgICAgICAgICAgICAgIHwgICAgNiAKIGFyY2gvcG93ZXJwYy9wbGF0Zm9y
bXMvcHNlcmllcy9tc2kuYyAgICAgICAgICAgICAgICB8ICAgMzkgKy0tLQogYXJjaC94ODYva2Vy
bmVsL2FwaWMvbXNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNSAKIGFyY2gveDg2
L3BjaS94ZW4uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDggCiBkcml2
ZXJzL2Jhc2UvcGxhdGZvcm0tbXNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTUyICsr
KysrKystLS0tLS0tLS0KIGRyaXZlcnMvYnVzL2ZzbC1tYy9kcHJjLWRyaXZlci5jICAgICAgICAg
ICAgICAgICAgICB8ICAgIDggCiBkcml2ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLWFsbG9jYXRvci5j
ICAgICAgICAgICAgICAgfCAgICA5IAogZHJpdmVycy9idXMvZnNsLW1jL2ZzbC1tYy1tc2kuYyAg
ICAgICAgICAgICAgICAgICAgIHwgICAyNiArLQogZHJpdmVycy9kbWEvbXZfeG9yX3YyLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxNiAtCiBkcml2ZXJzL2RtYS9xY29tL2hpZG1h
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQ0ICsrLS0KIGRyaXZlcnMvZG1hL3Rp
L2szLXVkbWEtcHJpdmF0ZS5jICAgICAgICAgICAgICAgICAgICB8ICAgIDYgCiBkcml2ZXJzL2Rt
YS90aS9rMy11ZG1hLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDE0IC0KIGRyaXZl
cnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgICAgICAgICB8ICAgMjMgLS0K
IGRyaXZlcnMvaXJxY2hpcC9pcnEtbWJpZ2VuLmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
IDQgCiBkcml2ZXJzL2lycWNoaXAvaXJxLW12ZWJ1LWljdS5jICAgICAgICAgICAgICAgICAgICAg
fCAgIDEyIC0KIGRyaXZlcnMvaXJxY2hpcC9pcnEtdGktc2NpLWludGEuYyAgICAgICAgICAgICAg
ICAgICB8ICAgIDIgCiBkcml2ZXJzL21haWxib3gvYmNtLWZsZXhybS1tYWlsYm94LmMgICAgICAg
ICAgICAgICAgfCAgICA5IAogZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2RwYWEyL2Rw
YWEyLWV0aC5jICAgIHwgICAgNCAKIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9kcGFh
Mi9kcGFhMi1wdHAuYyAgICB8ICAgIDQgCiBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZHBhYTIvZHBhYTItc3dpdGNoLmMgfCAgICA1IAogZHJpdmVycy9wY2kvbXNpL2lycWRvbWFpbi5j
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyMCArLQogZHJpdmVycy9wY2kvbXNpL2xlZ2Fj
eS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNiAKIGRyaXZlcnMvcGNpL21zaS9t
c2kuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMTggKysrKy0tLS0tLS0tCiBk
cml2ZXJzL3BjaS94ZW4tcGNpZnJvbnQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAy
IAogZHJpdmVycy9wZXJmL2FybV9zbW11djNfcG11LmMgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAgNSAKIGRyaXZlcnMvc29jL2ZzbC9kcGlvL2RwaW8tZHJpdmVyLmMgICAgICAgICAgICAgICAg
ICB8ICAgIDggCiBkcml2ZXJzL3NvYy90aS9rMy1yaW5nYWNjLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICA2IAogZHJpdmVycy9zb2MvdGkvdGlfc2NpX2ludGFfbXNpLmMgICAgICAgICAg
ICAgICAgICAgIHwgICAyMiAtLQogZHJpdmVycy92ZmlvL2ZzbC1tYy92ZmlvX2ZzbF9tY19pbnRy
LmMgICAgICAgICAgICAgIHwgICAgNCAKIGluY2x1ZGUvbGludXgvZGV2aWNlLmggICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMjUgKysKIGluY2x1ZGUvbGludXgvZnNsL21jLmggICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDQgCiBpbmNsdWRlL2xpbnV4L21zaS5oICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTEyICsrKysrKy0tLS0tLQogaW5jbHVk
ZS9saW51eC9wY2kuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSAKIGlu
Y2x1ZGUvbGludXgvc29jL3RpL3RpX3NjaV9pbnRhX21zaS5oICAgICAgICAgICAgICB8ICAgIDEg
CiBrZXJuZWwvaXJxL21zaS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MTgyICsrKysrKysrKysrKysrKy0tLS0tCiAzNSBmaWxlcyBjaGFuZ2VkLCA0NjQgaW5zZXJ0aW9u
cygrKSwgNDQ4IGRlbGV0aW9ucygtKQo=
