Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF6329243E
	for <lists+dmaengine@lfdr.de>; Mon, 19 Oct 2020 11:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgJSJEF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Oct 2020 05:04:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42434 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgJSJEE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Oct 2020 05:04:04 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09J9427b073771;
        Mon, 19 Oct 2020 04:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603098242;
        bh=Aboc8rUWRMqbGatDJ20aOWCfhiTeVHhep4T+4qZVV4M=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Nc1KHttWSjd/CKOM6TX6ZxZH/+MAo9uuCrJgNDUc1Fg6f+9uxCqHtrzffzM0Uibit
         U3jwBwHGjD9aTxaXKRTgZqPiszkLzjc+B06plOPjFJR8a2GLP1d5BnmmQHWh0phEGa
         8J6VlRN4uxa9jOcHWdCxyPnt76hmmDvtzaLjskeM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09J942mX103398
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Oct 2020 04:04:02 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 19
 Oct 2020 04:04:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 19 Oct 2020 04:04:01 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09J9402k084703;
        Mon, 19 Oct 2020 04:04:00 -0500
Subject: Re: [PATCH 2/4] dmaengine: move struct in interface to use peripheral
 term
To:     Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
References: <20201015073132.3571684-1-vkoul@kernel.org>
 <20201015073132.3571684-3-vkoul@kernel.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <61417567-e42a-789a-6848-acc84008cd45@ti.com>
Date:   Mon, 19 Oct 2020 12:04:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201015073132.3571684-3-vkoul@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

one minor comment...

On 15/10/2020 10.31, Vinod Koul wrote:
> dmaengine history has a non inclusive terminology of dmaengine slave, I
> feel it is time to replace that.
> 
> This moves structures in dmaengine interface with replacement of slave
> to peripheral which is an appropriate term for dmaengine peripheral
> devices
> 
> Since the change of name can break users, the new names have been added
> with old structs kept as macro define for new names. Once the users have
> been migrated, these macros will be dropped.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

...

> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index f7f420876d21..04b993a5373c 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h

...

>  /**
> - * struct dma_slave_map - associates slave device and it's slave channel with
> + * struct dma_peripheral_map - associates peripheral device and it's peripheral channel with
>   * parameter to be used by a filter function
>   * @devname: name of the device
> - * @slave: slave channel name
> + * @peripheral: peripheral channel name

I know that this is slave -> peripheral change, but would not be better
to call this as 'channame'?

>   * @param: opaque parameter to pass to struct dma_filter.fn
>   */
> -struct dma_slave_map {
> +struct dma_peripheral_map {
>  	const char *devname;
> -	const char *slave;
> +	const char *peripheral;
>  	void *param;
>  };
>  
> +#define dma_slave_map dma_peripheral_map
> +

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
