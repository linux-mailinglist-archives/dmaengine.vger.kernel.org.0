Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4D0E14122B
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2020 21:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgAQUPs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jan 2020 15:15:48 -0500
Received: from first.geanix.com ([116.203.34.67]:55076 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbgAQUPs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Jan 2020 15:15:48 -0500
Received: from localhost (87-49-44-45-mobile.dk.customer.tdc.net [87.49.44.45])
        by first.geanix.com (Postfix) with ESMTPSA id 8A681AB7CF;
        Fri, 17 Jan 2020 20:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1579292096; bh=NyD2V5SZSfQVTYmJ6N+L70KBjajwnojRIy5BahhEoVQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To;
        b=b/n+rnpA3v2O8rwAeqUqPDB/3pEwDc8aT2Fzok20ORw+bUJDTkgOWQJHZ3Eb86Nia
         h98IRvImFLnZ3NQRetCb6D/15fc32Ni9LV793Q5O3DKiP92rHDevyMv5bwJLFN0Ta6
         ctOCLIZmzJBbNrwj5Z2qa7uSVgnhjj37BGjVLtTy5oUdnotiRsWizk+MAELt9JT9KH
         GFdOjdO64TpbS+k62YS0jqpEbH46IEswdqmK+kaLNugVhwRmefu4zDFGZCI48g0Lsf
         W4gUgVPD8KoWVI0J28kJEVZhPwjJMfaGqologNqBxhwXb0FMrHeMhgdOTg9/hJ2g9S
         as4l4hd/ssMvQ==
From:   Esben Haabendal <esben@geanix.com>
To:     Han Xu <han.xu@nxp.com>
Cc:     vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, festevam@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] mtd: rawnand: gpmi: set the pinctrl state for suspend/reusme
References: <1579038243-28550-1-git-send-email-han.xu@nxp.com>
        <1579038243-28550-7-git-send-email-han.xu@nxp.com>
Date:   Fri, 17 Jan 2020 21:15:44 +0100
In-Reply-To: <1579038243-28550-7-git-send-email-han.xu@nxp.com> (Han Xu's
        message of "Wed, 15 Jan 2020 05:44:03 +0800")
Message-ID: <87wo9pvnyn.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=4.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=disabled
        version=3.4.3
X-Spam-Checker-Version: SpamAssassin 3.4.3 (2019-12-06) on ea2d15de10a4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Han Xu <han.xu@nxp.com> writes:

> set the correct pinctrl state in system pm suspend/resume ops
>
> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> index 73644c96fa9b..de1e3dbb2eb1 100644
> --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/dma/mxs-dma.h>
>  #include "gpmi-nand.h"
>  #include "gpmi-regs.h"
> @@ -2692,6 +2693,7 @@ static int gpmi_pm_suspend(struct device *dev)
>  {
>  	int ret;
>  
> +	pinctrl_pm_select_sleep_state(dev);
>  	ret = pm_runtime_force_suspend(dev);
>  
>  	return ret;
> @@ -2708,6 +2710,8 @@ static int gpmi_pm_resume(struct device *dev)
>  		return ret;
>  	}
>  
> +	pinctrl_pm_select_default_state(dev);
> +
>  	/* re-init the GPMI registers */
>  	ret = gpmi_init(this);
>  	if (ret) {

Acked-by: Esben Haabendal <esben@geanix.com>
