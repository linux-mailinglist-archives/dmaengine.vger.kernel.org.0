Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B4545F8DC
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhK0BZy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:25:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37158 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbhK0BXx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:23:53 -0500
Message-ID: <20211126224100.303046749@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=//Pymxq2YmulklNSLiTyVoYeHXlxeXwqBLpbcyzsxUc=;
        b=JkixINpLAG7IwgBGTy3CNwpiuZfzHjbD0o7N8tqoQWlATN4Ndsb8bIrIROKXtiKlXXH4GG
        MuxUB+Ktb5WxDEUxj2hmUVioMC0S6XogZC0QBqP0n+59kQsexsga3U2PHkEY4HyE1alk3f
        p8JV7bIX1mUBs68OkmizpXJOseMHtntJOwtcs0IAjZTjy4idbl2a5YBbxpARhFIhTTGekr
        EldqDDwR37StwenotF0nYTzMzKdSTWQU5SvHBGlDLfvw/DxaC3ri1p6QJ/Ff1dY+2pL77p
        2HNO/WH+51ff6rsss6Dk4dUyVwiaR3HbRC4amhWedJ7RpbR4+i6kKfF/bSo/Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=//Pymxq2YmulklNSLiTyVoYeHXlxeXwqBLpbcyzsxUc=;
        b=4aHit6zQT94D+jGrMxPhFPEQhGcg7bSgzNhpj51vxTFnMj1QhhHwGsqkp86iv7vimNWe86
        R8qcqzX4FWAmGqAg==
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
Date:   Sat, 27 Nov 2021 02:20:06 +0100 (CET)
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
YWxsIG9wZW4gY29kZWQKICAgICAgdmFyaWFudHMuCgpUaGlzIHNlY29uZCBzZXJpZXMgaXMgYmFz
ZWQgb246CgogICAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC90Z2x4L2RldmVsLmdpdCBtc2ktdjEtcGFydC0xCgphbmQgYWxzbyBhdmFpbGFibGUgZnJvbSBn
aXQ6CgogICAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90
Z2x4L2RldmVsLmdpdCBtc2ktdjEtcGFydC0yCgpGb3IgdGhlIGN1cmlvdXMgd2hvIGNhbid0IHdh
aXQgZm9yIHRoZSBuZXh0IHBhcnQgdG8gYXJyaXZlIHRoZSBmdWxsIHNlcmllcwppcyBhdmFpbGFi
bGUgdmlhOgoKICAgICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvdGdseC9kZXZlbC5naXQgbXNpLXYxLXBhcnQtNAoKVGhhbmtzLAoKCXRnbHgKLS0tCiBhcmNo
L3Bvd2VycGMvcGxhdGZvcm1zL2NlbGwvYXhvbl9tc2kuYyAgICAgICAgICAgICAgfCAgICA2IAog
YXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL21zaS5jICAgICAgICAgICAgICAgIHwgICAz
OCArLS0tCiBhcmNoL3g4Ni9rZXJuZWwvYXBpYy9tc2kuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgICA1IAogYXJjaC94ODYvcGNpL3hlbi5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAgOCAKIGRyaXZlcnMvYmFzZS9jb3JlLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgIDEgCiBkcml2ZXJzL2Jhc2UvcGxhdGZvcm0tbXNpLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgMTUyICsrKysrKysrLS0tLS0tLS0tCiBkcml2ZXJzL2J1cy9mc2wt
bWMvZHByYy1kcml2ZXIuYyAgICAgICAgICAgICAgICAgICAgfCAgICA4IAogZHJpdmVycy9idXMv
ZnNsLW1jL2ZzbC1tYy1hbGxvY2F0b3IuYyAgICAgICAgICAgICAgIHwgICAgOSAtCiBkcml2ZXJz
L2J1cy9mc2wtbWMvZnNsLW1jLW1zaS5jICAgICAgICAgICAgICAgICAgICAgfCAgIDI2ICstLQog
ZHJpdmVycy9kbWEvbXZfeG9yX3YyLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAx
NiAtCiBkcml2ZXJzL2RtYS9xY29tL2hpZG1hLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDQ0ICsrLS0tCiBkcml2ZXJzL2RtYS90aS9rMy11ZG1hLXByaXZhdGUuYyAgICAgICAgICAg
ICAgICAgICAgfCAgICA2IAogZHJpdmVycy9kbWEvdGkvazMtdWRtYS5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAxNCAtCiBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0t
c21tdS12My5jICAgICAgICAgfCAgIDIzIC0tCiBkcml2ZXJzL2lycWNoaXAvaXJxLW1iaWdlbi5j
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA0IAogZHJpdmVycy9pcnFjaGlwL2lycS1tdmVi
dS1pY3UuYyAgICAgICAgICAgICAgICAgICAgIHwgICAxMiAtCiBkcml2ZXJzL2lycWNoaXAvaXJx
LXRpLXNjaS1pbnRhLmMgICAgICAgICAgICAgICAgICAgfCAgICAyIAogZHJpdmVycy9tYWlsYm94
L2JjbS1mbGV4cm0tbWFpbGJveC5jICAgICAgICAgICAgICAgIHwgICAgOSAtCiBkcml2ZXJzL25l
dC9ldGhlcm5ldC9mcmVlc2NhbGUvZHBhYTIvZHBhYTItZXRoLmMgICAgfCAgICA0IAogZHJpdmVy
cy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2RwYWEyL2RwYWEyLXB0cC5jICAgIHwgICAgNCAKIGRy
aXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9kcGFhMi9kcGFhMi1zd2l0Y2guYyB8ICAgIDUg
CiBkcml2ZXJzL3BjaS9tc2kvaXJxZG9tYWluLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDIwICstCiBkcml2ZXJzL3BjaS9tc2kvbGVnYWN5LmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgICA2IAogZHJpdmVycy9wY2kvbXNpL21zaS5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDExOCArKysrKy0tLS0tLS0tCiBkcml2ZXJzL3BjaS94ZW4tcGNpZnJvbnQuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAyIAogZHJpdmVycy9wZXJmL2FybV9zbW11djNf
cG11LmMgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNSAKIGRyaXZlcnMvc29jL2ZzbC9kcGlv
L2RwaW8tZHJpdmVyLmMgICAgICAgICAgICAgICAgICB8ICAgIDggCiBkcml2ZXJzL3NvYy90aS9r
My1yaW5nYWNjLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA2IAogZHJpdmVycy9zb2Mv
dGkvdGlfc2NpX2ludGFfbXNpLmMgICAgICAgICAgICAgICAgICAgIHwgICAyMiAtLQogZHJpdmVy
cy92ZmlvL2ZzbC1tYy92ZmlvX2ZzbF9tY19pbnRyLmMgICAgICAgICAgICAgIHwgICAgNCAKIGlu
Y2x1ZGUvbGludXgvZGV2aWNlLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMjYg
KystCiBpbmNsdWRlL2xpbnV4L2ZzbC9tYy5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgICA0IAogaW5jbHVkZS9saW51eC9tc2kuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDExOCArKysrKysrLS0tLS0tCiBpbmNsdWRlL2xpbnV4L3BjaS5oICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgICAxIAogaW5jbHVkZS9saW51eC9zb2MvdGkvdGlfc2Np
X2ludGFfbXNpLmggICAgICAgICAgICAgIHwgICAgMSAKIGtlcm5lbC9pcnEvbXNpLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNzEgKysrKysrKysrKysrKysrLS0tLS0K
IDM2IGZpbGVzIGNoYW5nZWQsIDQ2MyBpbnNlcnRpb25zKCspLCA0NDUgZGVsZXRpb25zKC0pCg==
