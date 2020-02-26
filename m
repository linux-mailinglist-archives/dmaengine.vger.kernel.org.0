Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6FA16FF1F
	for <lists+dmaengine@lfdr.de>; Wed, 26 Feb 2020 13:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBZMfq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Feb 2020 07:35:46 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57954 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgBZMfq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Feb 2020 07:35:46 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01QCZZqQ061451;
        Wed, 26 Feb 2020 06:35:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582720535;
        bh=6MX4V22MYbs7XtA4o68CmGS41YT4czrgfBg5crrQRB4=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=ebIdsgvFptOpOLuSFXYpL8BaxzMIwsPiSzvoYSo42I0mMdvHoEtiiohj0l3ZjLkb9
         RnTWY3UludNCkXKCZsTNjtcpbMX3NgrHjKrFh2BZ1b7C/15SO/wIoq/s6fvsCUQhIw
         a5ZclgvK0hgsL+qYieQ/tHVxH82276NgtmPwYGq0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QCZZms068874;
        Wed, 26 Feb 2020 06:35:35 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 06:35:34 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 06:35:34 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QCZXFP051342;
        Wed, 26 Feb 2020 06:35:33 -0600
Subject: Re: [PATCH v1 4/4] dmaengine: consistently return string literal from
 switch-case
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200226101842.29426-1-andriy.shevchenko@linux.intel.com>
 <20200226101842.29426-4-andriy.shevchenko@linux.intel.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <cfdb3c9b-c3cd-3951-89d3-6a34baf782c3@ti.com>
Date:   Wed, 26 Feb 2020 14:35:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200226101842.29426-4-andriy.shevchenko@linux.intel.com>
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
> There is no need to have 'break;' statement in the default case followed by
> return certain string literal when all other cases have returned the string
> literals. So, refactor it accordingly.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/dmaengine.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 1bb5477ef7ec..d3672f065a64 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1560,9 +1560,7 @@ dmaengine_get_direction_text(enum dma_transfer_direction dir)
>  	case DMA_DEV_TO_DEV:
>  		return "DEV_TO_DEV";
>  	default:
> -		break;
> +		return "invalid";
>  	}
> -
> -	return "invalid";
>  }
>  #endif /* DMAENGINE_H */
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
