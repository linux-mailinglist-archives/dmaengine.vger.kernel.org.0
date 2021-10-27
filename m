Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86B943C27C
	for <lists+dmaengine@lfdr.de>; Wed, 27 Oct 2021 08:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbhJ0GDP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Oct 2021 02:03:15 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53002 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJ0GDP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Oct 2021 02:03:15 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2021 02:03:15 EDT
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19R5suWQ115299;
        Wed, 27 Oct 2021 00:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635314096;
        bh=gwwKZSkClD6ZbncJNtCYx9HarUAhL5A9fzaLxzfmhZE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ix5DU9CU3JIpQvYHXbR0+jo2mPJjUKvDWC+zGIKXBvUBRuFWVBxnvQDerrFkYR1tM
         8akkabRWpJbYvtTHtcXHNeqCgiqy+0bhSfFRZ2rim9vLZByj8htuKdYkNDgw9OTMrU
         E9a/MUzqQjK5/omgLe6BGgftiYgYclfpUCDraibs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19R5suPA001249
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Oct 2021 00:54:56 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Oct 2021 00:54:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Oct 2021 00:54:55 -0500
Received: from [10.250.234.118] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19R5sqJ1107019;
        Wed, 27 Oct 2021 00:54:53 -0500
Subject: Re: [PATCH 1/2] dmaengine: ti: k3-udma: Fix NULL pointer dereference
 error for BCDMA
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20211027055254.10912-1-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c4faa3d6-4622-0f82-603e-308c8fd43156@ti.com>
Date:   Wed, 27 Oct 2021 11:24:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211027055254.10912-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi All,

On 27/10/21 11:22 am, Kishon Vijay Abraham I wrote:
> bcdma_get_*() checks if bchan is already allocated by checking if it
> has a NON NULL value. For the error cases, bchan will have error value
> and bcdma_get_*() considers this as already allocated (PASS) since the
> error values are NON NULL. This results in NULL pointer dereference
> error while de-referencing bchan.
> 
> Reset the value of bchan to NULL if the allocation actually fails.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Please ignore this series. There was some stray patches left which I failed to
notice before sending. I'll resend a clean one.


Thanks,
Kishon
> ---
>  drivers/dma/ti/k3-udma.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index a35858610780..14ae28830871 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -1348,6 +1348,7 @@ static int bcdma_get_bchan(struct udma_chan *uc)
>  {
>  	struct udma_dev *ud = uc->ud;
>  	enum udma_tp_level tpl;
> +	int ret;
>  
>  	if (uc->bchan) {
>  		dev_dbg(ud->dev, "chan%d: already have bchan%d allocated\n",
> @@ -1365,8 +1366,11 @@ static int bcdma_get_bchan(struct udma_chan *uc)
>  		tpl = ud->bchan_tpl.levels - 1;
>  
>  	uc->bchan = __udma_reserve_bchan(ud, tpl, -1);
> -	if (IS_ERR(uc->bchan))
> -		return PTR_ERR(uc->bchan);
> +	if (IS_ERR(uc->bchan)) {
> +		ret = PTR_ERR(uc->bchan);
> +		uc->bchan = NULL;
> +		return ret;
> +	}
>  
>  	uc->tchan = uc->bchan;
>  
> 
