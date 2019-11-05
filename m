Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5149F03A3
	for <lists+dmaengine@lfdr.de>; Tue,  5 Nov 2019 18:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388098AbfKERBG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Nov 2019 12:01:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbfKERBG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 5 Nov 2019 12:01:06 -0500
Received: from localhost (unknown [106.51.111.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60DA32087E;
        Tue,  5 Nov 2019 17:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572973265;
        bh=eidZM2V4QQjO6ElDqpGD/ATrVSJUrdi/I4WF5f2EyKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qt+8WHwTJXW1jMLLWsiPCDYqwIMXQRivu9ebprQS/3h/7Xy35QHNb8uCcW5Cdl/rS
         bDGKuSbTrMptdo9j1KY+1YlwCE7d45Pl9ltgn2RvJxTeZORJoa2cIg26hTUI6TVr0Q
         XymXlVMuUqEs50IvTdIjgg7K+gzePGtRGotkZMCA=
Date:   Tue, 5 Nov 2019 22:31:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/3] dmaengine: bindings/edma: dma-channel-mask to
 array
Message-ID: <20191105170101.GE952516@vkoul-mobl>
References: <20191025073056.25450-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025073056.25450-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-10-19, 10:30, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v4:
> - Rebased on next to make it apply cleanly
> - Added Reviewed-by from Rob for the DT documentation patches
> 
> Changes since v3:
> - Update the dma-common.yaml and edma binding documentation according to Rob's
>   suggestion
> 
> Changes since v2:
> - Fix dma-common.yaml documentation patch and extend the description of the
>   dma-channel-mask array
> - The edma documentation now includes information on the dma-channel-mask array
>   size for EDMAs with 32 or 64 channels
> 
> Changes since v1:
> - Extend the common dma-channel-mask to uint32-array to be usable for
>   controllers with more than 32 channels
> - Use the dma-channel-mask instead custom property for available channels for
>   EDMA.
> 
> The original patch was part of the EDMA multicore usage series.
> 
> EDMAs can have 32 or 64 channels depending on the SoC, the dma-channel-mask
> needs to be an array to be usable for the driver.

And now I saw this and have applied these and dropped the ones I fixed
up manually!

-- 
~Vinod
