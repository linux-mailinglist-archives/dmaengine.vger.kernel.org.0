Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B4FC097
	for <lists+dmaengine@lfdr.de>; Thu, 14 Nov 2019 08:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfKNHP5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Nov 2019 02:15:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfKNHP5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 14 Nov 2019 02:15:57 -0500
Received: from localhost (unknown [223.226.110.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539B9206C0;
        Thu, 14 Nov 2019 07:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573715756;
        bh=CdaQJfZeE12NS1/9Gejd29MDaXIfXJWzS072VrL8Xes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PhsOCoDGSgOK8ezKmJxaKvTdSHilYh12J6nNN8tFokL7n2P2BHdFFLr3jKRR4wcSB
         kHkUc5uIaH/d1CCakQKBk9IVDJHVa0Hzz7WHtWGluW3kwSI9Kb0arWaeqG8M6/M0vt
         /5dpCcS3I4+Zhf/lF6Xke7riMzVuVnG37CmLzPhs=
Date:   Thu, 14 Nov 2019 12:45:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Green Wan <green.wan@sifive.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] dmaengine: sf-pdma: Add platform dma driver
Message-ID: <20191114071551.GQ952516@vkoul-mobl>
References: <20191107084955.7580-1-green.wan@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107084955.7580-1-green.wan@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-11-19, 16:49, Green Wan wrote:
> Add PDMA driver support for SiFive HiFive Unleashed RevA00 board. Mainly follows
> DMAengine controller doc[1] to implement and take other DMA drivers as reference.
> Such as
> 
>   - drivers/dma/fsl-edma.c
>   - drivers/dma/dw-edma/
>   - drivers/dma/pxa-dma.c
> 
> Using DMA test client[2] to test. Detailed datasheet is doc[3]. Driver supports:
> 
>  - 4 physical DMA channels, share same DONE and error interrupt handler. 
>  - Support MEM_TO_MEM
>  - Tested by DMA test client
>  - patches include DT Bindgins document and dts for fu450-c000 SoC. Separate dts
>    patch for easier review and apply to different branch or SoC platform.
>  - retry 1 time if DMA error occurs.

I have applied this expect dt change. I see some warns due to missing
kernel-doc style comments with W=1, please fix that and send update on
top of these

Thanks
-- 
~Vinod
