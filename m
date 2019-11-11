Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34276F6E70
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 07:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfKKGMG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 01:12:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfKKGMF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Nov 2019 01:12:05 -0500
Received: from localhost (unknown [106.201.42.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EE6A2067B;
        Mon, 11 Nov 2019 06:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573452725;
        bh=LXWYG1ROjwSH1hn5KYvqLWtCtUw0B3W+w0MZMaAcIaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsnMSCFw5ZbH23zLhgAFCwVg2FwK5kCYILOEY/l88c2/tQn3gFEdKtlk33mBg9g2s
         z76+MU+MyTYq5lhTxgbkUjLpv8zwtT63VYdiVEXHjuhKuYNo+CsAcCs1ao2cduNY/W
         T21t7yjRDnOuRFezqAU7K6ee7PAD95SVrXme2VgU=
Date:   Mon, 11 Nov 2019 11:41:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v4 14/15] dmaengine: ti: New driver for K3 UDMA -
 split#6: Kconfig and Makefile
Message-ID: <20191111061159.GR952516@vkoul-mobl>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-15-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101084135.14811-15-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> +config TI_K3_UDMA
> +	tristate "Texas Instruments UDMA support"
> +	depends on ARCH_K3 || COMPILE_TEST
> +	depends on TI_SCI_PROTOCOL
> +	depends on TI_SCI_INTA_IRQCHIP
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	select TI_K3_RINGACC
> +	select TI_K3_PSIL
> +	default y

Again no default y!

-- 
~Vinod
