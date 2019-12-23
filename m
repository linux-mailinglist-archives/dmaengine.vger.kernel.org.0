Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 120A9129568
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 12:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLWLgj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 06:36:39 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55768 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfLWLgj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Dec 2019 06:36:39 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBNBaQd4076186;
        Mon, 23 Dec 2019 05:36:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577100986;
        bh=7PM2ExdFmOb9fTnrkCAvPvStWpyhC4HlYdlnuYMgkPA=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=aThz1c95Y01tgz3j5uHahRmYXBp091MoH635BZu0AoiA+dT7LaZgv/+Q3tLXAwTVQ
         eE2l2Gdi15/vc3ZGHVFzWR5hRYEJRYFv8vrfOi6AJuqwfFzvzYqQw0emR+58sRb2uC
         lUZ91GQPf/+I1DrqFJjCnu0X9OBdGn9A0FIW5wFQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBNBaQ8p064888
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Dec 2019 05:36:26 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 05:36:26 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 05:36:26 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBNBaM2E039852;
        Mon, 23 Dec 2019 05:36:23 -0600
Subject: Re: [PATCH v8 14/18] of: irq: Export of_msi_get_domain
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>, <frowand.list@gmail.com>
References: <20191223110458.30766-1-peter.ujfalusi@ti.com>
 <20191223110458.30766-15-peter.ujfalusi@ti.com>
Message-ID: <f49e6c3f-804b-27d8-5712-b381be49c3f4@ti.com>
Date:   Mon, 23 Dec 2019 13:36:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191223110458.30766-15-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Matthias,

On 23/12/2019 13.04, Peter Ujfalusi wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Export of_mis_get_domain to enable it for users from outside.

FYI, I have picked this old patch from you. I can not find the history
why it is not in the kernel...

> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/of/irq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index a296eaf52a5b..73017506ef00 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -673,6 +673,7 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
>  
>  	return NULL;
>  }
> +EXPORT_SYMBOL_GPL(of_msi_get_domain);
>  
>  /**
>   * of_msi_configure - Set the msi_domain field of a device
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
