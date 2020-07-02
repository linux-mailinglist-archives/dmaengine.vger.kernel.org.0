Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911C62121EA
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 13:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgGBLPU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 07:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgGBLPU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Jul 2020 07:15:20 -0400
X-Greylist: delayed 695 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jul 2020 04:15:19 PDT
Received: from forward500j.mail.yandex.net (forward500j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC2C08C5C1;
        Thu,  2 Jul 2020 04:15:19 -0700 (PDT)
Received: from mxback8j.mail.yandex.net (mxback8j.mail.yandex.net [IPv6:2a02:6b8:0:1619::111])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 177EE11C1A12;
        Thu,  2 Jul 2020 14:15:17 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback8j.mail.yandex.net (mxback/Yandex) with ESMTP id zy2fKpYmZG-FFjm119q;
        Thu, 02 Jul 2020 14:15:16 +0300
Received: by iva2-13089525268d.qloud-c.yandex.net with HTTP;
        Thu, 02 Jul 2020 14:15:15 +0300
From:   Angelo Dureghello <angelo@sysam.it>
To:     Robin Gong <yibin.gong@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
References: <1593449998-32091-1-git-send-email-yibin.gong@nxp.com>
Subject: Re: [PATCH v1] dmaengine: fsl-edma-common: correct DSIZE_32BYTE
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 02 Jul 2020 13:15:15 +0200
Message-Id: <979851593688387@mail.yandex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Robin,

29.06.2020, 10:53, "Robin Gong" <yibin.gong@nxp.com>:
> Correct EDMA_TCD_ATTR_DSIZE_32BYTE define since it's broken by the below:
> '0x0005 --> BIT(3) | BIT(0))'
>
> Fixes: 4d6d3a90e4ac ("dmaengine: fsl-edma: fix macros")
> Cc: stable@vger.kernel.org
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/fsl-edma-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index 67e4225..ec11697 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -33,7 +33,7 @@
>  #define EDMA_TCD_ATTR_DSIZE_16BIT BIT(0)
>  #define EDMA_TCD_ATTR_DSIZE_32BIT BIT(1)
>  #define EDMA_TCD_ATTR_DSIZE_64BIT (BIT(0) | BIT(1))
> -#define EDMA_TCD_ATTR_DSIZE_32BYTE (BIT(3) | BIT(0))
> +#define EDMA_TCD_ATTR_DSIZE_32BYTE (BIT(2) | BIT(0))

looks like i need some glasses. Thanks a lot for the fix.
I probably missed it since not using 16bytes transfers.

Tested-by: Angelo Dureghello <angelo@sysam.it>


Regards,
angelo

>  #define EDMA_TCD_ATTR_SSIZE_8BIT 0
>  #define EDMA_TCD_ATTR_SSIZE_16BIT (EDMA_TCD_ATTR_DSIZE_16BIT << 8)
>  #define EDMA_TCD_ATTR_SSIZE_32BIT (EDMA_TCD_ATTR_DSIZE_32BIT << 8)
> --
> 2.7.4
