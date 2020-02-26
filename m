Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC2716FF25
	for <lists+dmaengine@lfdr.de>; Wed, 26 Feb 2020 13:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgBZMhi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Feb 2020 07:37:38 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56044 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgBZMhi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Feb 2020 07:37:38 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01QCbU4t127767;
        Wed, 26 Feb 2020 06:37:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582720650;
        bh=OIU6x2hhNwb5rltUvjHJ1Zp/tsz033LMjrc4I7yZWQw=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=r6Jo3mLGFYKD2E6PUh/MDKQvNVaLtr9VBp1HpKTOxBYQr+Vux2+4wTKZnfcN34kt5
         Xu+W8n+YD7q+FW9MYkHOJlUeNpRcOANHR3sDZ01R65UMtVmAmQppHrfo+eRZEFOupm
         6FZw0bd5ZTCdz7P2Esc92gCQWOaNMDSm541dyqZk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QCbUK1071396;
        Wed, 26 Feb 2020 06:37:30 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 06:37:29 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 06:37:30 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QCbRpM046630;
        Wed, 26 Feb 2020 06:37:29 -0600
Subject: Re: [PATCH v1 3/4] dmaengine: Drop redundant 'else' keyword
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200226101842.29426-1-andriy.shevchenko@linux.intel.com>
 <20200226101842.29426-3-andriy.shevchenko@linux.intel.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <55eafd8a-d36b-5de3-ad55-ab73d9d56146@ti.com>
Date:   Wed, 26 Feb 2020 14:37:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200226101842.29426-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy,

On 2/26/20 12:18 PM, Andy Shevchenko wrote:
> It's obvious that 'else' keyword is redundant in the code like
> 
> 	if (foo)
> 		return bar;
> 	else if (baz)
> 		...
> 
> Drop it for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/dmaengine.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index ae56a91c2a05..1bb5477ef7ec 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1230,9 +1230,9 @@ static inline int dma_maxpq(struct dma_device *dma, enum dma_ctrl_flags flags)
>  {
>  	if (dma_dev_has_pq_continue(dma) || !dmaf_continue(flags))
>  		return dma_dev_to_maxpq(dma);
> -	else if (dmaf_p_disabled_continue(flags))
> +	if (dmaf_p_disabled_continue(flags))

I would add blank line in between the - new - if cases for better
readability.

>  		return dma_dev_to_maxpq(dma) - 1;
> -	else if (dmaf_continue(flags))
> +	if (dmaf_continue(flags))
>  		return dma_dev_to_maxpq(dma) - 3;
>  	BUG();
>  }
> @@ -1243,7 +1243,7 @@ static inline size_t dmaengine_get_icg(bool inc, bool sgl, size_t icg,
>  	if (inc) {
>  		if (dir_icg)
>  			return dir_icg;
> -		else if (sgl)
> +		if (sgl)
>  			return icg;
>  	}
>  
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
