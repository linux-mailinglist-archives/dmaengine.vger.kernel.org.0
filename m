Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEAD346F7
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2019 14:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfFDMgk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jun 2019 08:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfFDMgk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 4 Jun 2019 08:36:40 -0400
Received: from localhost (unknown [117.99.94.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D25C52231F;
        Tue,  4 Jun 2019 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559651799;
        bh=6OleqzP9quO2zeSwzsj8bZMeC8Hf2G1MKsJM7hbM2y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sL71fl8ksf2Ja1HmqStkjNNeRgC7UL/xPDVK/wp7YJZkONHwjxdusA5XmNr9iQnHA
         CPnGDlVR4TZRrq9zl16yEt13Z0/3Kl035kY7Ipn6UGuSrr5bTvLzkbrE9x2QIXqbiL
         YxbXRHqG6DcMl7mNpHZRpPIhA1VPbU0b0bh/0aTI=
Date:   Tue, 4 Jun 2019 18:03:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     yibin.gong@nxp.com
Cc:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, dan.j.williams@intel.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 5/8] dmaengine: fsl-edma: add drvdata for vf610
Message-ID: <20190604123331.GE15118@vkoul-mobl>
References: <20190529090848.34350-1-yibin.gong@nxp.com>
 <20190529090848.34350-6-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529090848.34350-6-yibin.gong@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-05-19, 17:08, yibin.gong@nxp.com wrote:

> @@ -205,8 +228,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	if (!fsl_edma)
>  		return -ENOMEM;
>  
> -	fsl_edma->version = v1;
> -	fsl_edma->dmamux_nr = DMAMUX_NR;
> +	fsl_edma->drvdata = drvdata;
> +	fsl_edma->version = drvdata->version;
> +	fsl_edma->dmamux_nr = drvdata->dmamuxs;

And can we avoid the duplication here, you have version and dmamuxs
represented in two places. But right now it looks logical so the removal
should be done after this series

-- 
~Vinod
