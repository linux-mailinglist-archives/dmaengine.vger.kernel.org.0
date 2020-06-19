Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8A31FFFF8
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2020 03:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgFSB7g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Jun 2020 21:59:36 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:11670 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727981AbgFSB7f (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 18 Jun 2020 21:59:35 -0400
Received: by ajax-webmail-mail-app2 (Coremail) ; Fri, 19 Jun 2020 09:59:21
 +0800 (GMT+08:00)
X-Originating-IP: [210.32.144.65]
Date:   Fri, 19 Jun 2020 09:59:21 +0800 (GMT+08:00)
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
In-Reply-To: <9f7684d9-7a75-497d-db1c-75cf0991a072@nvidia.com>
References: <20200618105727.14669-1-dinghao.liu@zju.edu.cn>
 <9f7684d9-7a75-497d-db1c-75cf0991a072@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <24ea1ef1.10213.172ca4d45be.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgBXITT5G+xeNNEtAA--.6813W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgsQBlZdtOuLuQABs4
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbGvS07vEb7Iv0x
        C_Xr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlV2xY628EF7xvwVC2z280aVAFwI0_Gc
        CE3s1lV2xY628EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wCS07vEe2I262IYc4CY6c8I
        j28IcVAaY2xG8wCS07vE5I8CrVACY4xI64kE6c02F40Ex7xfMIAIbVAv7VC0I7IYx2IY67
        AKxVWUJVWUGwCS07vEYx0Ex4A2jsIE14v26r1j6r4UMIAIbVAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lV2xY6x02cVAKzwCS07vEc2xSY4AK67AK6w4lV2xY6xkI7II2jI8vz4vEwIxGrwCS07
        vE42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMIAIbVCF72vE77IF4wCS07vE4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1lV2xY6I8I3I0E5I8CrVAFwI0_Jr0_Jr4lV2xY6I8I3I0E7480Y4vE14
        v26r106r1rMIAIbVC2zVAF1VAY17CE14v26r1q6r43MIAIbVCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIAIbVCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lV2xY6IIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIAIbVCI42IY6I8E87Iv67AKxVWUJVW8JwCS07vEIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73U
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAKPiBXaHkgbm9pZGxlPwo+IAoKX25vaWRsZSBpcyBlbm91Z2ggZm9yIGZpeGluZyB0aGlzIGJ1
Zy4gX3N5bmMgbWF5IHN1c3BlbmQKdGhlIGRldmljZSBiZXlvbmQgZXhwZWN0YXRpb24uCgpSZWdh
cmRzLApEaW5naGFv
