Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F7D3597C5
	for <lists+dmaengine@lfdr.de>; Fri,  9 Apr 2021 10:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhDIIZM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Apr 2021 04:25:12 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:5652 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231370AbhDIIZL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 9 Apr 2021 04:25:11 -0400
Received: by ajax-webmail-mail-app3 (Coremail) ; Fri, 9 Apr 2021 16:24:52
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.72.8]
Date:   Fri, 9 Apr 2021 16:24:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Jon Hunter" <jonathanh@nvidia.com>
Cc:     kjlu@umn.edu, "Laxman Dewangan" <ldewangan@nvidia.com>,
        "Vinod Koul" <vkoul@kernel.org>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] dmaengine: tegra20: Fix runtime PM imbalance in
 tegra_dma_issue_pending
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <5699d0e9-968c-c8b0-3b0b-0416b5b48aa0@nvidia.com>
References: <20210408071158.12565-1-dinghao.liu@zju.edu.cn>
 <5699d0e9-968c-c8b0-3b0b-0416b5b48aa0@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7c55cf68.45570.178b5bbe111.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgC3nyJUD3BgqX_xAA--.30209W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgkKBlZdtTUlDwAEsi
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBPbiAwOC8wNC8yMDIxIDA4OjExLCBEaW5naGFvIExpdSB3cm90ZToKPiA+IHBtX3J1bnRpbWVf
Z2V0X3N5bmMoKSB3aWxsIGluY3JlYXNlIHRoZSBydW10aW1lIFBNIGNvdW50ZXIKPiA+IGV2ZW4g
aXQgcmV0dXJucyBhbiBlcnJvci4gVGh1cyBhIHBhaXJpbmcgZGVjcmVtZW50IGlzIG5lZWRlZAo+
ID4gdG8gcHJldmVudCByZWZjb3VudCBsZWFrLiBGaXggdGhpcyBieSByZXBsYWNpbmcgdGhpcyBB
UEkgd2l0aAo+ID4gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgpLCB3aGljaCB3aWxsIG5vdCBj
aGFuZ2UgdGhlIHJ1bnRpbWUKPiA+IFBNIGNvdW50ZXIgb24gZXJyb3IuCj4gPiAKPiA+IFNpZ25l
ZC1vZmYtYnk6IERpbmdoYW8gTGl1IDxkaW5naGFvLmxpdUB6anUuZWR1LmNuPgo+ID4gLS0tCj4g
PiAgZHJpdmVycy9kbWEvdGVncmEyMC1hcGItZG1hLmMgfCAyICstCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2RtYS90ZWdyYTIwLWFwYi1kbWEuYyBiL2RyaXZlcnMvZG1hL3RlZ3JhMjAtYXBiLWRt
YS5jCj4gPiBpbmRleCA3MTgyN2Q5YjBhYTEuLjczMTc4YWZhZjRjMiAxMDA2NDQKPiA+IC0tLSBh
L2RyaXZlcnMvZG1hL3RlZ3JhMjAtYXBiLWRtYS5jCj4gPiArKysgYi9kcml2ZXJzL2RtYS90ZWdy
YTIwLWFwYi1kbWEuYwo+ID4gQEAgLTcyMyw3ICs3MjMsNyBAQCBzdGF0aWMgdm9pZCB0ZWdyYV9k
bWFfaXNzdWVfcGVuZGluZyhzdHJ1Y3QgZG1hX2NoYW4gKmRjKQo+ID4gIAkJZ290byBlbmQ7Cj4g
PiAgCX0KPiA+ICAJaWYgKCF0ZGMtPmJ1c3kpIHsKPiA+IC0JCWVyciA9IHBtX3J1bnRpbWVfZ2V0
X3N5bmModGRjLT50ZG1hLT5kZXYpOwo+ID4gKwkJZXJyID0gcG1fcnVudGltZV9yZXN1bWVfYW5k
X2dldCh0ZGMtPnRkbWEtPmRldik7Cj4gPiAgCQlpZiAoZXJyIDwgMCkgewo+ID4gIAkJCWRldl9l
cnIodGRjMmRldih0ZGMpLCAiRmFpbGVkIHRvIGVuYWJsZSBETUFcbiIpOwo+ID4gIAkJCWdvdG8g
ZW5kOwo+ID4gCj4gCj4gCj4gVGhhbmtzISBMb29rcyBsaWtlIHRoZXJlIGFyZSB0d28gaW5zdGFu
Y2VzIG9mIHRoaXMgdGhhdCBuZWVkIGZpeGluZy4KPiAKClRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0
IHRoaXMhIEkgd2lsbCBmaXggdGhpcyBhbmQgc2VuZCBhIG5ldyBwYXRjaCBzb29uLgoKUmVnYXJk
cywKRGluZ2hhbw==
