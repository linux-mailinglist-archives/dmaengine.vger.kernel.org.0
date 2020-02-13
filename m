Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F0E15B9DE
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2020 08:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBMHGa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Feb 2020 02:06:30 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41978 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgBMHGa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Feb 2020 02:06:30 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01D76Gx6051841;
        Thu, 13 Feb 2020 01:06:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581577576;
        bh=JvGh8yuZ5yfeCuRWHM/H0X4BZ2PEVJYss8hEjyaIsbw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qRtxswxI+TK+ZGQIMmRS5Bg9GwxRqy2NgsudI7j3Zvp5CfA1oinDf0n5QzWZSngKC
         S/4BqrN4Zmf9TDeneMzJdjGViV7pjWKgmZpt6q5608IxCQL2mbr9qYUaENKlOV/1ZK
         Lp8dZkZCi0jWcr7FDOhDRLAdj1JEFSyFCetAERMQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01D76GAU127982
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Feb 2020 01:06:16 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 13
 Feb 2020 01:06:16 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 13 Feb 2020 01:06:16 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01D76EVm128557;
        Thu, 13 Feb 2020 01:06:14 -0600
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200213003925.GA6906@embeddedor.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <2affea92-6748-76f1-6fe4-025fa7053a4f@ti.com>
Date:   Thu, 13 Feb 2020 09:06:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200213003925.GA6906@embeddedor.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 13/02/2020 2.39, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/dma/ti/omap-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index a014ab96e673..918301e17552 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -124,7 +124,7 @@ struct omap_desc {
>  	uint32_t csdp;		/* CSDP value */
>  
>  	unsigned sglen;
> -	struct omap_sg sg[0];
> +	struct omap_sg sg[];
>  };
>  
>  enum {
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
