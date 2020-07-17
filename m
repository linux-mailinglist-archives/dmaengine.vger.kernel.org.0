Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599B4223355
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 08:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgGQGFU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 02:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgGQGFU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Jul 2020 02:05:20 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2ADF2065E;
        Fri, 17 Jul 2020 06:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594965919;
        bh=ULhdOx89nRtmQeqBLFII5MBKJQMkkFOuD6QfOLh0eoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhNsc8XX5SSMnOfFe9u+Wqdi/3fGCeiTjmoVw/h18HKRZIUEssmzq1prUigE7jeg4
         N6a3VIyAfCUK972jx+XH2uc5vBfAtlrb4S7r3qLCcMahFo0YF/7Zc8VFy1RIBysZWB
         BfjUxyxKMqKbE3rqoLEo3izFm0nNs1Tj5UVyp2xc=
Date:   Fri, 17 Jul 2020 11:35:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v7 4/5] dmaengine: xilinx: dpdma: Add debugfs support
Message-ID: <20200717060515.GD82923@vkoul-mobl>
References: <20200717013337.24122-1-laurent.pinchart@ideasonboard.com>
 <20200717013337.24122-5-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717013337.24122-5-laurent.pinchart@ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-07-20, 04:33, Laurent Pinchart wrote:

> +static void xilinx_dpdma_debugfs_cleanup(struct xilinx_dpdma_device *xdev)
> +{
> +	debugfs_remove_recursive(xdev->debugfs_dir);

you can skip this step as core will do so when you call
dma_async_device_unregister()

> +	xdev->debugfs_dir = NULL;
> +}
> +
> +static int xilinx_dpdma_debugfs_init(struct xilinx_dpdma_device *xdev)
> +{
> +	struct dentry *dent;
> +
> +	dpdma_debugfs.testcase = DPDMA_TC_NONE;
> +
> +	dent = debugfs_create_dir("dpdma", xdev->common.dbg_dev_root);
> +	if (IS_ERR(dent)) {
> +		dev_err(xdev->dev, "Failed to create debugfs directory\n");
> +		return -ENODEV;
> +	}

Do you really need another dir in your device root. You should already
have .../dmaengine/<dpdma-dev-name>/ adding dpdma dir seems overkill

-- 
~Vinod
