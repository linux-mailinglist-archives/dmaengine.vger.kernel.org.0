Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F8C121FB2
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 01:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfLQA1U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 19:27:20 -0500
Received: from muru.com ([72.249.23.125]:48830 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbfLQA1U (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 19:27:20 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C046B810D;
        Tue, 17 Dec 2019 00:27:58 +0000 (UTC)
Date:   Mon, 16 Dec 2019 16:27:16 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 12/14] dmaengine: ti: omap-dma: Use cpu notifier to block
 idle for omap2
Message-ID: <20191217002716.GT35479@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
 <20191217001925.44558-13-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217001925.44558-13-tony@atomide.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [191217 00:20]:
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> +	case CPU_CLUSTER_PM_ENTER:
> +		while (1) {
> +			lch = find_next_bit(od->lch_bitmap, od->lch_count,
> +					    lch + 1);
> +			if (lch >= od->lch_count)
> +				break;
> +			c = od->lch_map[lch];
> +			if (!c)
> +				continue;
> +			if (omap_dma_chan_read(c, CCR) & CCR_ENABLE) {
> +				pr_info("XXX %s: lch%i busy\n", __func__, lch);
> +				return NOTIFY_BAD;

Oops the pr_info line here can be dropped :)

Regards,

Tony
