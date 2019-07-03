Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC0965DF3F
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jul 2019 10:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfGCIB5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jul 2019 04:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfGCIB5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Jul 2019 04:01:57 -0400
Received: from localhost (unknown [122.167.76.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C812D21897;
        Wed,  3 Jul 2019 08:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562140916;
        bh=ThdOqIlE3tUWkIZCcSvGSfnftygpU4mdRMsrGkRB824=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYWQ75vkqGkJRXZ6dih6ItEgb92wHdF8ZCCOyuF3axygjOhqHqmTIb2jAg4FJQyMO
         MrWvaEwr1wH1x6qy3E1kg8mRdmo6Z75vwTE4+AMN4bcaxafhH/uYvWc70hiwxTZnlX
         O8X88LouQrPToBR47ovMX8nPVzJBtNteMfpzquKY=
Date:   Wed, 3 Jul 2019 13:28:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     yibin.gong@nxp.com
Cc:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, dan.j.williams@intel.com,
        angelo@sysam.it, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v5 0/6] add edma2 for i.mx7ulp
Message-ID: <20190703075848.GR2911@vkoul-mobl>
References: <20190625094324.19196-1-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625094324.19196-1-yibin.gong@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-06-19, 17:43, yibin.gong@nxp.com wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> This patch set add new version of edma for i.mx7ulp, the main changes
> are as belows:
>  1. only one dmamux.
>  2. another clock dma_clk except dmamux clk.
>  3. 16 independent interrupts instead of only one interrupt for
>     all channels
> For the first change, need modify fsl-edma-common.c and mcf-edma,
> so create the first two patches to prepare without any function impact.
> 
> For the third change, need request single irq for every channel with
> the legacy handler. But actually 2 dma channels share one interrupt(16
> channel interrupts, but 32 channels.),ch0/ch16,ch1/ch17... For now, just
> simply request irq without IRQF_SHARED flag, since 16 channels are enough
> on i.mx7ulp whose M4 domain own some peripherals.

Applied patches 1-5, thanks
-- 
~Vinod
