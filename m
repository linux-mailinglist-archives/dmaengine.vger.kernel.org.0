Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114392204AE
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 07:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgGOF5Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 01:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbgGOF5P (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 01:57:15 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 062C220663;
        Wed, 15 Jul 2020 05:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594792635;
        bh=sh/y6Tv58ZbvejAQoIQ7VjPDPdiVI5suGLxy8ixlw/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ccBKPEH3rQXWo6yxYXS2I2Zlg2bQpnTixf+T723Cut6K23obwSGs8LC/tGlIcQMhh
         tRvVtjy4pdNc9vNYYLz3mV77xwIpzia10DvfB0RHR5uP/CP2ZPcyWHVDuB2iSvoR1u
         OJ0W3dyzkgKGrnKDO4/kalcaLUs9xZJFNlP/+B/A=
Date:   Wed, 15 Jul 2020 11:27:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, shawnguo@kernel.org,
        festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v10 05/12] dmaengine: dma: imx-sdma: add fw_loaded and
 is_ram_script
Message-ID: <20200715055711.GW34333@vkoul-mobl>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
 <1593523876-22387-6-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593523876-22387-6-git-send-email-yibin.gong@nxp.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-06-20, 21:31, Robin Gong wrote:
> Add 'fw_loaded' and 'is_ram_script' to check if the script used by channel
> is ram script and it's loaded or not, so that could prevent meaningless
> following malloc dma descriptor and bd allocate in sdma_transfer_init(),
> otherwise memory may be consumed out potentially without free in case
> that spi fallback into pio while dma transfer failed by sdma firmware not
> ready(next ERR009165 patch depends on sdma RAM scripts/firmware).

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
