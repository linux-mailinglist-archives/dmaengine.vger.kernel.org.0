Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BC32028D1
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2020 07:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgFUF1k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 Jun 2020 01:27:40 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:58734 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726015AbgFUF1k (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 21 Jun 2020 01:27:40 -0400
Received: by ajax-webmail-mail-app3 (Coremail) ; Sun, 21 Jun 2020 13:27:24
 +0800 (GMT+08:00)
X-Originating-IP: [210.32.144.65]
Date:   Sun, 21 Jun 2020 13:27:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Jon Hunter" <jonathanh@nvidia.com>
Cc:     kjlu@umn.edu, "Laxman Dewangan" <ldewangan@nvidia.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Vinod Koul" <vkoul@kernel.org>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] [v3] dmaengine: tegra210-adma: Fix runtime PM
 imbalance on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <f4034e16-e720-57c4-eb9d-733786212a4a@nvidia.com>
References: <20200618105727.14669-1-dinghao.liu@zju.edu.cn>
 <9f7684d9-7a75-497d-db1c-75cf0991a072@nvidia.com>
 <24ea1ef1.10213.172ca4d45be.Coremail.dinghao.liu@zju.edu.cn>
 <f4034e16-e720-57c4-eb9d-733786212a4a@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <711c004d.1832d.172d55876c5.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgDX3uK87+5evJH9AA--.17515W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgcQBlZdtOvMDgADsG
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbX0S07vEb7Iv0x
        C_Xr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lV2xY6cIj6I8E87Iv67AKxVWUJVW8JwCS07vEOx8S6xCaFVCjc4AY6r1j
        6r4UMIAIbVCjxxvEw4WlV2xY6xkIecxEwVAFwVW8WwCS07vEc2IjII80xcxEwVAKI48JMI
        AIbVCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1lV2xY6xCjnVCjjxCrMIAIbVCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCS07vEx2IqxVAqx4xG67AKxVWUJVWUGwCS07vEx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlV2xY6I8E67AF67kF1VAFwI0_Jw0_GFylV2xY6IIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lV2xY6IIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCS07vEIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lV2xY6IIF0xvEx4A2jsIE14v26r1j6r4UMIAIbVCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Cgo+ID4+Cj4gPj4gV2h5IG5vaWRsZT8KPiA+Pgo+ID4gCj4gPiBfbm9pZGxlIGlzIGVub3VnaCBm
b3IgZml4aW5nIHRoaXMgYnVnLiBfc3luYyBtYXkgc3VzcGVuZAo+ID4gdGhlIGRldmljZSBiZXlv
bmQgZXhwZWN0YXRpb24uCj4gCj4gSW4gdGhhdCBjYXNlLCB0aGVuIHRoZSBvdGhlciBpbnN0YW5j
ZSB5b3UgYXJlIGZpeGluZyB3aXRoIHRoaXMgcGF0Y2ggaXMKPiBub3QgY29ycmVjdC4KPiAKCkZp
bmUuIEkgd2lsbCBmaXggdGhpcyBzb29uLgoKUmVnYXJkcywKRGluZ2hhbwo=
