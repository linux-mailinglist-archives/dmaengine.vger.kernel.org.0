Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93D6419C575
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2020 17:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbgDBPGX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Apr 2020 11:06:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:46064 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389046AbgDBPGW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Apr 2020 11:06:22 -0400
IronPort-SDR: 4D8RU2cY6TDk9aDUSLGUhPGw896w78bSp+k1g3Ld/MFaJwjjZu7DmSqWpn4O2xVprYS7AlpOVl
 a4IJzJXaE16w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 08:06:21 -0700
IronPort-SDR: k0nZ9Qd2HT/5yhMfVt502GBN9EOzOQDTwehNxMiHA5YqPY8haqm9eO0q2ZPMWE2LbzRRSsLm3Z
 4Dgl2RNI/F9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="284807116"
Received: from ccui-mobl1.amr.corp.intel.com (HELO [10.134.85.228]) ([10.134.85.228])
  by fmsmga002.fm.intel.com with ESMTP; 02 Apr 2020 08:06:20 -0700
Subject: Re: [PATCH 2/2] dmaengine: ioat: Decreasing allocation chunk size 2M
 -> 512K
To:     leonid.ravich@dell.com, dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
References: <20200402092725.15121-1-leonid.ravich@dell.com>
 <20200402092725.15121-2-leonid.ravich@dell.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <793bc07b-fec9-27ee-7eff-203326e3608a@intel.com>
Date:   Thu, 2 Apr 2020 08:06:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402092725.15121-2-leonid.ravich@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/2/2020 2:27 AM, leonid.ravich@dell.com wrote:
> From: Leonid Ravich <Leonid.Ravich@emc.com>
> 
> current IOAT driver using big (2MB) allocations chunk for its descriptors
> therefore each ioat dma engine need 2 such chunks
> (64k entres in ring  each entry 64B = 4MB)
> requiring 2 * 2M * dmaengine contiguies memory chunk
> might fail due to memory fragmention.
> 
> so we decresging chunk size and using more chunks.

decreasing

> 
> Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>

Acked-by: Dave Jiang <dave.jiang@intel.com> if the two patches have been 
tested on hw.

> ---
>   drivers/dma/ioat/dma.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index 535aba9..e9757bc 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -83,7 +83,7 @@ struct ioatdma_device {
>   
>   #define IOAT_MAX_ORDER 16
>   #define IOAT_MAX_DESCS (1 << IOAT_MAX_ORDER)
> -#define IOAT_CHUNK_SIZE (SZ_2M)
> +#define IOAT_CHUNK_SIZE (SZ_512K)
>   #define IOAT_DESCS_PER_CHUNK (IOAT_CHUNK_SIZE/IOAT_DESC_SZ)
>   
>   struct ioat_descs {
> 
