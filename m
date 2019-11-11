Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07012F6E24
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 06:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfKKFdK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 00:33:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfKKFdK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Nov 2019 00:33:10 -0500
Received: from localhost (unknown [106.201.42.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BEA32084F;
        Mon, 11 Nov 2019 05:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573450389;
        bh=DwdNdotJjKRBotkgqG0AIy+E8ZCiOTVy/UNvW4JpNsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABZSn1q21qj5r9squHwS0oGuOYuynXB490X8qzW1Pxzbm1pafmfecgT+HR33T4pA6
         jOmzmzgPP5MDBO/ttPB0N4R17asILBNmijo1DxkuuMbnHDaJ7PJEmqJFjwkGCUabxX
         Fp4C98Qcdj/94tnt+JN/0mgZux3id9o8wQryUzmI=
Date:   Mon, 11 Nov 2019 11:03:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v4 10/15] dmaengine: ti: New driver for K3 UDMA -
 split#2: probe/remove, xlate and filter_fn
Message-ID: <20191111053301.GO952516@vkoul-mobl>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-11-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101084135.14811-11-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-11-19, 10:41, Peter Ujfalusi wrote:

> +static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
> +{
> +	struct psil_endpoint_config *ep_config;
> +	struct udma_chan *uc;
> +	struct udma_dev *ud;
> +	u32 *args;
> +
> +	if (chan->device->dev->driver != &udma_driver.driver)
> +		return false;
> +
> +	uc = to_udma_chan(chan);
> +	ud = uc->ud;
> +	args = param;
> +	uc->remote_thread_id = args[0];
> +
> +	if (uc->remote_thread_id & K3_PSIL_DST_THREAD_ID_OFFSET)
> +		uc->dir = DMA_MEM_TO_DEV;
> +	else
> +		uc->dir = DMA_DEV_TO_MEM;

Can you explain this a bit?

> +static int udma_remove(struct platform_device *pdev)
> +{
> +	struct udma_dev *ud = platform_get_drvdata(pdev);
> +
> +	of_dma_controller_free(pdev->dev.of_node);
> +	dma_async_device_unregister(&ud->ddev);
> +
> +	/* Make sure that we did proper cleanup */
> +	cancel_work_sync(&ud->purge_work);
> +	udma_purge_desc_work(&ud->purge_work);

kill the vchan tasklets at it too please
-- 
~Vinod
