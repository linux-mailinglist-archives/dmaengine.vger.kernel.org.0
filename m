Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D359F6A784
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2019 13:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbfGPLfI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jul 2019 07:35:08 -0400
Received: from foss.arm.com ([217.140.110.172]:33286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733067AbfGPLfI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Jul 2019 07:35:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC6AC2B;
        Tue, 16 Jul 2019 04:35:07 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD30B3F71A;
        Tue, 16 Jul 2019 04:35:06 -0700 (PDT)
Subject: Re: [PATCH v3 04/24] dmaengine: qcom_hidma: Remove call to memset
 after dmam_alloc_coherent
To:     Sinan Kaya <Okaya@kernel.org>,
        Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20190715031723.6375-1-huangfq.daxian@gmail.com>
 <72c45b14-f0c0-9d1c-0953-eea70ce513a0@kernel.org>
 <CABXRUiQXweOLRTpdyhx9xT_B1VBmoSoNm=_+Qr4prmz7u1QRFA@mail.gmail.com>
 <245ffd79-316c-e985-d1da-2ccea6d29636@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9ea5f97f-5963-5836-6ab2-dc30628c6820@arm.com>
Date:   Tue, 16 Jul 2019 12:35:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <245ffd79-316c-e985-d1da-2ccea6d29636@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15/07/2019 16:17, Sinan Kaya wrote:
> On 7/15/2019 1:43 AM, Fuqian Huang wrote:
>> Should I rewrite the commit log? Just mention that dma_alloc_coherent
>> has already
>> zeroed the memory and not to reference the commit?
> 
> I'd like to hear from Robin Murphy that arm smmu driver follows this as
> well.

I'd be lying if I said it did.

...but only because that's never been part of the SMMU driver's 
responsibility either way. The iommu-dma layer however, and thus the 
respective arm64 iommu_dma_ops, has always zeroed allocations right from 
its inception.

518a2f1925c3 was just cleaning up the last of the stragglers which 
*weren't* already clearing buffers anyway, such that we could formalise 
that behaviour into the API.

Robin.
