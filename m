Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B3E16FF21
	for <lists+dmaengine@lfdr.de>; Wed, 26 Feb 2020 13:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgBZMgE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Feb 2020 07:36:04 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54318 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgBZMgE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Feb 2020 07:36:04 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01QCZweD018757;
        Wed, 26 Feb 2020 06:35:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582720558;
        bh=2kjZwRsSsMGxMrAqmicbo7vFbBnn+5YtJ39rnD+1Ocs=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=x6MBY1bkgFGXH5nTrTP3gU57LSV/Ep5E+QuWOk9v5fccF9mXtdJRQ6w08D3SNf7kx
         IX+S01e0LAep4DfI3Ga5TnJLJjyDhyWDRnSJOQuLkGHw62RE5tNcBsuYMxPS7+AYRw
         cDwvXX3fjYarbOZ9NdTuBYpGAV9wbYup9tAFlRTo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01QCZwuC108792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Feb 2020 06:35:58 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 06:35:54 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 06:35:54 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01QCZq3h067810;
        Wed, 26 Feb 2020 06:35:53 -0600
Subject: Re: [PATCH v1 1/4] dmaengine: Refactor dmaengine_check_align() to be
 bit operations only
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200226101842.29426-1-andriy.shevchenko@linux.intel.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <c853b1fc-de60-faae-d2f9-290c52e65e39@ti.com>
Date:   Wed, 26 Feb 2020 14:35:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200226101842.29426-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2/26/20 12:18 PM, Andy Shevchenko wrote:
> There is no need to have branch and temporary variable in the function.
> Simple convert it to be a set of bit and arithmetic operations.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/dmaengine.h | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 64461fc64e1b..9f3f5582816a 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1155,14 +1155,7 @@ static inline dma_cookie_t dmaengine_submit(struct dma_async_tx_descriptor *desc
>  static inline bool dmaengine_check_align(enum dmaengine_alignment align,
>  					 size_t off1, size_t off2, size_t len)
>  {
> -	size_t mask;
> -
> -	if (!align)
> -		return true;
> -	mask = (1 << align) - 1;
> -	if (mask & (off1 | off2 | len))
> -		return false;
> -	return true;
> +	return !(((1 << align) - 1) & (off1 | off2 | len));
>  }
>  
>  static inline bool is_dma_copy_aligned(struct dma_device *dev, size_t off1,
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
