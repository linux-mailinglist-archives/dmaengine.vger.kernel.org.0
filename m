Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7665F036F
	for <lists+dmaengine@lfdr.de>; Tue,  5 Nov 2019 17:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390334AbfKEQvz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Nov 2019 11:51:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390275AbfKEQvz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 5 Nov 2019 11:51:55 -0500
Received: from localhost (unknown [106.51.111.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D74D8214B2;
        Tue,  5 Nov 2019 16:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572972714;
        bh=lG1xPmjx0M85Hu15xRRf0c2UDYPZiP2tf8OaC4I1OSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jc0PolQjd2QLbTRJwYlwV7qizu9bVSyJSqZwRHyFnC8c7/osMDc+W9gmAKfJ5kDMN
         sDJvx6DtQulk8s8/AlAW6vNqyRTke+wyJXlqvsmK+vIeETAUo+luv7bEFJA56YR7Fg
         a3NRxb/tHNHIunYBuV1mTiSVr+07ZVP3zZszybA4=
Date:   Tue, 5 Nov 2019 22:21:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/3] dmaengine: bindings/edma: dma-channel-mask to
 array
Message-ID: <20191105165145.GB952516@vkoul-mobl>
References: <20190930114055.29315-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930114055.29315-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-09-19, 14:40, Peter Ujfalusi wrote:
> Hi,
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
> Rob: I'm not sure if I got the dma-common.yaml update correctly...
> 
> EDMAs can have 32 or 64 channels depending on the SoC, the dma-channel-mask
> needs to be an array to be usable for the driver.

Applied, thanks

There was a conflict on patch3, I have reolved it, please check.

-- 
~Vinod
