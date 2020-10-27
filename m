Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F0C29A51E
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 08:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbgJ0HCC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 03:02:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43578 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730446AbgJ0HCB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Oct 2020 03:02:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09R71kda057937;
        Tue, 27 Oct 2020 02:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603782106;
        bh=Gvm0rHZv6ZytyaW+fToZnnx5xhB6hxH+duasZbvDz+4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AjuetEnr/G8X3j36GCztIXk9lbZ0zhDKZGea/WjIbs0vkAhREwUD2CH9V8zgVjUjm
         4wzRkDwtumeqOt/wR+KKk+x19+unVpZYk+5GNYbaCrtmpGvNvVEQ9kw3iyUTrHEgqo
         S/3tUqe8LgcxnYGkJKyZJVcb59a+0P2SxrKHcZIU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09R71kx5041212
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 02:01:46 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 27
 Oct 2020 02:01:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 27 Oct 2020 02:01:46 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09R71iUR028399;
        Tue, 27 Oct 2020 02:01:45 -0500
Subject: Re: [PATCH] dmaengine: ti: k3-udma: fix -Wenum-conversion warning
To:     Arnd Bergmann <arnd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Yu Kuai <yukuai3@huawei.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201026160123.3704531-1-arnd@kernel.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <2bf8a179-9dad-97b9-2295-31d27eefdbb7@ti.com>
Date:   Tue, 27 Oct 2020 09:02:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026160123.3704531-1-arnd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 26/10/2020 18.01, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns about a mismatch argument type when passing
> 'false' into a function that expects an enum:

Strange enough, but my gcc does not warn me (Gentoo 10.2.0-r2 p3).

> drivers/dma/ti/k3-udma-private.c: In function 'xudma_tchan_get':
> drivers/dma/ti/k3-udma-private.c:86:34: warning: implicit conversion from 'enum <anonymous>' to 'enum udma_tp_level' [-Wenum-conversion]
>   86 |  return __udma_reserve_##res(ud, false, id);   \
>      |                                  ^~~~~
> drivers/dma/ti/k3-udma-private.c:95:1: note: in expansion of macro 'XUDMA_GET_PUT_RESOURCE'
>    95 | XUDMA_GET_PUT_RESOURCE(tchan);
>       | ^~~~~~~~~~~~~~~~~~~~~~

But this is valid. The Throughput Levels got expanded with j721e from 2
to three and I failed to update this.

> In this case, false has the same numerical value as
> UDMA_TP_NORMAL, so passing that is most likely the correct
> way to avoid the warning without changing the behavior.

Yes, that's correct, thanks for fixing it!

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Fixes: d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine users")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/ti/k3-udma-private.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
> index aa24e554f7b4..8563a392f30b 100644
> --- a/drivers/dma/ti/k3-udma-private.c
> +++ b/drivers/dma/ti/k3-udma-private.c
> @@ -83,7 +83,7 @@ EXPORT_SYMBOL(xudma_rflow_is_gp);
>  #define XUDMA_GET_PUT_RESOURCE(res)					\
>  struct udma_##res *xudma_##res##_get(struct udma_dev *ud, int id)	\
>  {									\
> -	return __udma_reserve_##res(ud, false, id);			\
> +	return __udma_reserve_##res(ud, UDMA_TP_NORMAL, id);		\
>  }									\
>  EXPORT_SYMBOL(xudma_##res##_get);					\
>  									\
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
