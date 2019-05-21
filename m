Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7207024B0C
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 11:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfEUJBE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 05:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfEUJBE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 05:01:04 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66C6221019;
        Tue, 21 May 2019 09:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558429264;
        bh=3WQ0Qjttg5VAmos9LBjKq/caqxMX7CCBc0pIQwDIa3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j6XjRkDA8HwcQjDysaXvldnG0t3LshJl9qYt0zhHq4I8e6hCpvn7DaVL5XJj+0MDH
         vA+6a7uUK+Q6LCD+o7ovLmjaJRo/4p1xFwfCzVd0m0RCdhGoWAF9BOkxv81LKUAf6r
         kzo1sCcCKUueRy92LSPjzlO2NFyVA9IvGsIg8f34=
Date:   Tue, 21 May 2019 14:30:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] dmaengine: axi-dmac: Discover length alignment
 requirement
Message-ID: <20190521090042.GC15118@vkoul-mobl>
References: <20190521112331.32424-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521112331.32424-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-05-19, 14:23, Alexandru Ardelean wrote:
> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Starting with version 4.1.a the AXI-DMAC is capable of reporting the
> required length alignment.
> 
> The LSBs that are required to be set for alignment will always read back as
> set from the transfer length register. It is not possible to clear them by
> writing a 0. This means the driver can discover the length alignment
> requirement by writing 0 to that register and reading back the value.
> 
> Since the DMA will support length alignment requirements that are different
> from the address alignment requirement track both of them independently.
> 
> For older versions of the peripheral assume that the length alignment
> requirement is equal to the address alignment requirement.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

You need to sign off the patch before sending. Please reread Documentation/process/submitting-patches.rst

>  	axi_dmac_write(dmac, AXI_DMAC_REG_FLAGS, AXI_DMAC_FLAG_CYCLIC);
>  	if (axi_dmac_read(dmac, AXI_DMAC_REG_FLAGS) == AXI_DMAC_FLAG_CYCLIC)
> @@ -670,6 +676,13 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac)
>  		return -ENODEV;
>  	}
>  
> +	if ((version & 0xff00) >= 0x0100) {

magic numbers yaay

-- 
~Vinod
