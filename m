Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5718784FE
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2019 08:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfG2Gg3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jul 2019 02:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfG2Gg2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Jul 2019 02:36:28 -0400
Received: from localhost (unknown [122.178.221.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF1E2070B;
        Mon, 29 Jul 2019 06:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564382188;
        bh=jbM48Eg7Yx5V9z4igLzOpQybV0ra5WLa7K3ccfFGuMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pH0ozCVJa4iWQkH3dXM5D+1GzWT3ECrY+N3AZwQtUZOKB71Oie7Tb3N3q1Gn9TZxX
         Bhbi4DmxJCaNEpEhvC3z+qqFjyBah+/NUeQIAeLpr9Hoa/xOZmCuMY5j+IhPaxUn9J
         ZvgY0OvpfKIfxSD2EsCEivoIQD5X0D6/tRSNln2c=
Date:   Mon, 29 Jul 2019 12:05:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 0/2] dmaengine: ti: omap-dma: Improved polling support
Message-ID: <20190729063515.GE12733@vkoul-mobl.Dlink>
References: <20190716082459.1222-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716082459.1222-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-07-19, 11:24, Peter Ujfalusi wrote:
> Hi,
> 
> changes since v1:
> - New preparation cleanup patch
> - Simplified code for the main patch to be easier to read
> 
> This series fine-tunes the omap-dma polled memcpy support to be inline with how
> the EDMA driver is handling it.
> 
> The polled completion can be tested by applying:
> https://patchwork.kernel.org/patch/10966499/
> 
> and run the dmatest with polled = 1 on boards where sDMA is used.
> 
> Or boot up any dra7 family device with display enabled. The workaround for DMM
> errata i878 uses polled DMA memcpy.

Applied, thanks

-- 
~Vinod
