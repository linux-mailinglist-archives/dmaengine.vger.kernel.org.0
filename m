Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5D3129E0E
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2019 07:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfLXGZy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Dec 2019 01:25:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfLXGZy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Dec 2019 01:25:54 -0500
Received: from localhost (unknown [122.167.68.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D89F4206CB;
        Tue, 24 Dec 2019 06:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577168753;
        bh=InoE8ryzjR+FID2QK7KPw32193qUgMsnYRn9+U++QDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SK2AZDRtPCzRvSUy+gpty5CrqB1jckZ6y+Itx/Um154hA9qntpCsm/3UdO0zc1xGW
         uFMkO5LygHb3YW5QTabCdz3ZQnE6Lutf0k2K89ZBFtVWo9JsrwUr677S84Y/OtSd8Z
         OEHOoxhmV4YoQlnUJTpR5CGKQl2hTyKnPVBRPSIw=
Date:   Tue, 24 Dec 2019 11:55:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     dmaengine@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Green Wan <green.wan@sifive.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Sean Wang <sean.wang@mediatek.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 0/9] dmaengine: virt-dma related fixes
Message-ID: <20191224062547.GJ2536@vkoul-mobl>
References: <20191216105328.15198-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216105328.15198-1-s.hauer@pengutronix.de>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-12-19, 11:53, Sascha Hauer wrote:
> Several drivers call vchan_dma_desc_free_list() or vchan_vdesc_fini() under
> &vc->lock. This is not allowed and the first two patches fix this up. If you
> are a DMA driver maintainer, the first two patches are the reason you are on
> Cc.
> 
> The remaining patches are the original purpose of this series:
> The i.MX SDMA driver leaks memory when a currently running descriptor is
> aborted. Calling vchan_terminate_vdesc() on it to fix this revealed that
> the virt-dma support calls the desc_free with the spin_lock held. This
> doesn't work for the SDMA driver because it calls dma_free_coherent in
> its desc_free hook. This series aims to fix that up.

Applied all, thanks

-- 
~Vinod
