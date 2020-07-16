Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C234221902
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jul 2020 02:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgGPAmo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 20:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgGPAmn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jul 2020 20:42:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE254C061755
        for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2020 17:42:43 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 088E7564;
        Thu, 16 Jul 2020 02:42:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594860161;
        bh=G5OAk/6UIzciy4bfJKVt8BVmuLqhEIsSbBAjRE0D8Lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qERzaurJTCZKkjMOFPUmg1EOaqMR1yuqE0KY1oRAIKUDSSUL7+ueCdjJX1El0OgZH
         z6Zsr7Oxn2DlL6gy5m03yvdyfuDAFJW2USvv3fN8US0xF+ruBZUXjpn3AFWBVVmZF6
         JoXbvu72h65m+TbTF4k9a6LgiVm9Bv5lePJgCkec=
Date:   Thu, 16 Jul 2020 03:42:33 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v6 5/6] dmaengine: xilinx: dpdma: Add debugfs support
Message-ID: <20200716004233.GO6144@pendragon.ideasonboard.com>
References: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
 <20200708201906.4546-6-laurent.pinchart@ideasonboard.com>
 <20200715110130.GJ34333@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200715110130.GJ34333@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Wed, Jul 15, 2020 at 04:31:30PM +0530, Vinod Koul wrote:
> On 08-07-20, 23:19, Laurent Pinchart wrote:
> > +static int xilinx_dpdma_debugfs_init(struct device *dev)
> > +{
> > +	int err;
> > +	struct dentry *xilinx_dpdma_debugfs_dir, *xilinx_dpdma_debugfs_file;
> > +
> > +	dpdma_debugfs.testcase = DPDMA_TC_NONE;
> > +
> > +	xilinx_dpdma_debugfs_dir = debugfs_create_dir("dpdma", NULL);
> 
> can you please use the dma_dev->dbg_dev_root, we are already creating
> /sys/kernel/debug/dmaengine/<device>/

Good point, I'll fix that.

-- 
Regards,

Laurent Pinchart
