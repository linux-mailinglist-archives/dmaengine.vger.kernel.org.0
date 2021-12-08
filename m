Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B327046D130
	for <lists+dmaengine@lfdr.de>; Wed,  8 Dec 2021 11:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhLHKos (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Dec 2021 05:44:48 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:13814 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhLHKos (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Dec 2021 05:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638960077; x=1670496077;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=6efhgTwOQ+BksN3W7gKk5cPv0gbAT3aa2LCJO+xICYQ=;
  b=Aq/fKIBSbz4nMVi204osP9jjuvLK2LvHSnTa5UDtRsVeX2J+dKPoyagp
   o8q+mAOfLUUP+W54DaZI0wPBki+saLZvWwwuSHvKftZ5T4Jg9rgxTikbK
   e4XPyBQBYOJYjUElF6dUnu7ZtXIVXv9P/rgsp4T8uJ3xdjHrmw9YByhHu
   f5kgSRqnG6z0EyudTC1aXe0O/1m7g5HZNC1vhVJ1mXw4gJ4DegQ6M68ma
   t7wJpWBRR8mk43VfWiUUTETc/wipuXsXCAo+j55DPo12Js6PBvnQDJDCD
   jbgDSl9JccDLPCRPtdyJeY3wTF8R+m9Hf88cukwwt7vldQGbrDLHV0c+G
   A==;
IronPort-SDR: 7xfYPdqh5WDhRFwQy2okqjSInim4M7SOkW/D5djAO8OJCGLySXu5FfT+JZ6qWa/UETRCdcFiuq
 xaEIWSJv9e1BTSTNXZw35iTSlVslr9fwA6TmRvaxbL9WRiQgfcgoSqwBf+peR67tsLOfZ/n423
 coYIfMoGVHj9O6W1Ij0tNPh1v4Enk66Q1qiGELpenwx/nAI8SME0ZuWZnIi9EkPs4b1o1YW2Tl
 q4zepRxPAXfepy1HQtERDlH6Idqf54XsMGanoAwgWJ2GT2Xt2WDLId5gQ/3OLYiWmwS+owjzy1
 gPQd8Uj0ON4nqOV+R62PhiMw
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="141705605"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2021 03:41:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Dec 2021 03:41:15 -0700
Received: from [10.12.73.2] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 8 Dec 2021 03:41:13 -0700
Subject: Re: [PATCH] dmaengine: at_xdmac: fix compilation warning
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20211025074002.722504-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <abb29fac-b25d-e5cd-859a-020e08625b27@microchip.com>
Date:   Wed, 8 Dec 2021 11:41:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211025074002.722504-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25/10/2021 at 09:40, Claudiu Beznea wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Fixed "unused variable 'atmel_xdmac_dev_pm_ops'" compilation warning
> when CONFIG_PM is not defined.
> 
> Fixes: 8e0c7e486014 ("dmaengine: at_xdmac: use pm_ptr()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

If needed:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas

> ---
>   drivers/dma/at_xdmac.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 7fb19bd18ac3..f5d053df66a5 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -2207,7 +2207,7 @@ static int at_xdmac_remove(struct platform_device *pdev)
>          return 0;
>   }
> 
> -static const struct dev_pm_ops atmel_xdmac_dev_pm_ops = {
> +static const struct dev_pm_ops __maybe_unused atmel_xdmac_dev_pm_ops = {
>          .prepare        = atmel_xdmac_prepare,
>          SET_LATE_SYSTEM_SLEEP_PM_OPS(atmel_xdmac_suspend, atmel_xdmac_resume)
>   };
> --
> 2.33.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Nicolas Ferre
