Return-Path: <dmaengine+bounces-647-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0122381D074
	for <lists+dmaengine@lfdr.de>; Sat, 23 Dec 2023 00:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA15D284FCE
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 23:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5553E33CF3;
	Fri, 22 Dec 2023 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qa+VmtYq"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ABF33CE8;
	Fri, 22 Dec 2023 23:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=jeAP6X2umucewZGQcbSnRUGvrVAC3CUeMMR9f5t1VmA=; b=qa+VmtYqW88mxyclWdLRDcbIhG
	8+d3pSFKjjwzsoaEa1pk7FniLC5ZTnppQmBusT/Hy+pZCBm7Nj5S6n8OlTn6dT2EfXEEBLkZ8fJ69
	cVglYodDW4UCHvTc8ZN0P+KWZIXTChCAIP0QbyVuybzy9Vx907eVzL+R0EI9xhGouvkGPOZTAMGdd
	uWzTlmFbco9E4R8SP9qpToiu/wHVCETcU+b8bWZTqgtxsHJApdJvuJWBQErTWxKhYZlCwfeOgxuAj
	d4DV4PXrdwAfK2AFcIZ+uSQ+u4WSFkuEmOSxRinrpugoPjzz1G74wLhtT4xPJ1WS3Pf2zHE3zkGIE
	E4Ukp8Tg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGowZ-0070qb-1B;
	Fri, 22 Dec 2023 23:28:39 +0000
Message-ID: <d821f459-25bf-4712-bc07-4240a02602f4@infradead.org>
Date: Fri, 22 Dec 2023 15:28:38 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: xilinx: xdma: Fix kernel-doc warnings
Content-Language: en-US
To: Jan Kuliga <jankul@alatek.krakow.pl>, lizhi.hou@amd.com,
 brian.xu@amd.com, raj.kumar.rampelli@amd.com, vkoul@kernel.org,
 michal.simek@amd.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
References: <20231222231728.7156-1-jankul@alatek.krakow.pl>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231222231728.7156-1-jankul@alatek.krakow.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/22/23 15:17, Jan Kuliga wrote:
> Replace hyphens with colons where necessary.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312230634.3AIMQ3OP-lkp@intel.com/
> Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/dma/xilinx/xdma.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 4ebc90b41bdb..927c68ed6bbc 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -548,11 +548,11 @@ static void xdma_synchronize(struct dma_chan *chan)
>  
>  /**
>   * xdma_fill_descs - Fill hardware descriptors with contiguous memory block addresses
> - * @sw_desc - tx descriptor state container
> - * @src_addr - Value for a ->src_addr field of a first descriptor
> - * @dst_addr - Value for a ->dst_addr field of a first descriptor
> - * @size - Total size of a contiguous memory block
> - * @filled_descs_num - Number of filled hardware descriptors for corresponding sw_desc
> + * @sw_desc: tx descriptor state container
> + * @src_addr: Value for a ->src_addr field of a first descriptor
> + * @dst_addr: Value for a ->dst_addr field of a first descriptor
> + * @size: Total size of a contiguous memory block
> + * @filled_descs_num: Number of filled hardware descriptors for corresponding sw_desc
>   */
>  static inline u32 xdma_fill_descs(struct xdma_desc *sw_desc, u64 src_addr,
>  				  u64 dst_addr, u32 size, u32 filled_descs_num)

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

