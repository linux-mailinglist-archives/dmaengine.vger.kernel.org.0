Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 494854545C
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 07:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfFNFzW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 01:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfFNFzW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 14 Jun 2019 01:55:22 -0400
Received: from localhost (unknown [106.201.34.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F9A520850;
        Fri, 14 Jun 2019 05:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560491721;
        bh=Ib1hiWdsziZXSOSgRTyl65Mjn+55wz9zSfPlHLyLA9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gjq44Fw4V1cmzLB1McVOPytTCJaMuRuoqv+jsE2a2SLPkajczJj2MwwyFf64xiDAa
         3wQNtWP8VP7LUftA+ROblLdAeZNRbLpFCTF91litBgSwPhmZLMY96MJjTqyYG+3kqj
         BI3JsIOzietSZLDsE1GQvRQVHeGCZ5soCZt3mpE0=
Date:   Fri, 14 Jun 2019 11:22:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH 4/4] dmaengine: axi-dmac: add regmap support
Message-ID: <20190614055212.GC2962@vkoul-mobl>
References: <20190606104550.32336-1-alexandru.ardelean@analog.com>
 <20190606104550.32336-4-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606104550.32336-4-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-06-19, 13:45, Alexandru Ardelean wrote:
 
> +static bool axi_dmac_regmap_rdwr(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case AXI_DMAC_REG_IRQ_MASK:
> +	case AXI_DMAC_REG_IRQ_SOURCE:
> +	case AXI_DMAC_REG_IRQ_PENDING:
> +	case AXI_DMAC_REG_CTRL:
> +	case AXI_DMAC_REG_TRANSFER_ID:
> +	case AXI_DMAC_REG_START_TRANSFER:
> +	case AXI_DMAC_REG_FLAGS:
> +	case AXI_DMAC_REG_DEST_ADDRESS:
> +	case AXI_DMAC_REG_SRC_ADDRESS:
> +	case AXI_DMAC_REG_X_LENGTH:
> +	case AXI_DMAC_REG_Y_LENGTH:
> +	case AXI_DMAC_REG_DEST_STRIDE:
> +	case AXI_DMAC_REG_SRC_STRIDE:
> +	case AXI_DMAC_REG_TRANSFER_DONE:
> +	case AXI_DMAC_REG_ACTIVE_TRANSFER_ID :

Space before : ...?

-- 
~Vinod
