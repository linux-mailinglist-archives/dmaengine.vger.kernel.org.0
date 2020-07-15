Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB17220A9D
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgGOLBg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 07:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgGOLBf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 07:01:35 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF819206E9;
        Wed, 15 Jul 2020 11:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594810894;
        bh=YjjoHD3Wp6sBSi4hh4xOaYUzXKIyMBu6ceqlWbva7vE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJmULLuF/9VG5+B+gNKPikV8sWzTpoWYJATi1dirD+xNf324fPe4U3uz3nRj9v+co
         p528K8/SsKAW9ZtYlF95dCoLyD3mgm0KGzFthjGBziKxMB3hYq4DKscefRMQ9snJwu
         94vjjwq136WFis2YEo93wyg1W/vKz4xXT1XC1grU=
Date:   Wed, 15 Jul 2020 16:31:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v6 5/6] dmaengine: xilinx: dpdma: Add debugfs support
Message-ID: <20200715110130.GJ34333@vkoul-mobl>
References: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
 <20200708201906.4546-6-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708201906.4546-6-laurent.pinchart@ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-07-20, 23:19, Laurent Pinchart wrote:

> +static int xilinx_dpdma_debugfs_init(struct device *dev)
> +{
> +	int err;
> +	struct dentry *xilinx_dpdma_debugfs_dir, *xilinx_dpdma_debugfs_file;
> +
> +	dpdma_debugfs.testcase = DPDMA_TC_NONE;
> +
> +	xilinx_dpdma_debugfs_dir = debugfs_create_dir("dpdma", NULL);

can you please use the dma_dev->dbg_dev_root, we are already creating
/sys/kernel/debug/dmaengine/<device>/
-- 
~Vinod
