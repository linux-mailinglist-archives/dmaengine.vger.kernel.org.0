Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FDC4310C7
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 08:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhJRGqq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 02:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhJRGqq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Oct 2021 02:46:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C79F460F22;
        Mon, 18 Oct 2021 06:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634539475;
        bh=uGCY/tXBNBlB/lc0D4D3M8xPX/37yu9RIHwToaKGpZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dExZiGbes6qpibKjNxUT5VACB9yYSJ8ZDFwsE9lB5An7vKjAmay0jClGTla99WwT1
         ZnJBcfVGvmH+RyQzNhVOFauHqyrO29bkUofpRvaxhDG8KkUHEdjdYkWMXhM7DgV57s
         /hYK+F2xmcL6MvhroHYpjEG1kzHYO0zCuNEZr1VxDTCHrekStg7DVGyMHjtwOrsjwY
         8Rp7GGZLLiiJNN1+cf3SzKRlCTMpI4j8TjJUJWO4WPEwo4EAsezGv2OuGU8/6VVpXC
         DTRLUnNARqmsVzlt1SEvBAJy44Ubj1Cx0IYikiXRpQ8Y55S7AEWGhvYzo6Lp+zGsXI
         BkrRLQYB+Sgow==
Date:   Mon, 18 Oct 2021 12:14:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     pandith.n@intel.com
Cc:     eugeniy.paltsev@synopsys.com, dmaengine@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        mallikarjunappa.sangannavar@intel.com, srikanth.thokala@intel.com,
        kenchappa.demakkanavar@intel.com
Subject: Re: [PATCH V3 0/3] Add DMA support for transfers in multiple cases
Message-ID: <YW0Xz8ZsTCCxxNua@matsya>
References: <20211001140812.24977-1-pandith.n@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001140812.24977-1-pandith.n@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-10-21, 19:38, pandith.n@intel.com wrote:
> From: Pandith N <pandith.n@intel.com>
> 
> This series adds dma support in following transfers
> mem2mem: set dma coherent mask
> mem2per: memory to peripheral with hardware handshake control, when APB
> register extension is not provided.
> per2mem: peripheral to memory with hardware handshake control, when APB
> register extnesion is not provided
> 
> Support DMAX_NUM_CHANNELS > 8
> --------------------------------------------
> Depending on number of channels the register map changes in DMAC.
> DMA driver now supports both register maps based of number of
> channels used in platform.
> 
> Setting hardware handshake for peripheral transfers
> -----------------------------------------------------------------------
> mem2per and per2mem transfers are supported with hardware handshake
> control, without apb register extension.
> 
> setting dma coherent mask
> --------------------------------------------------
> Added 64-bit dma coherent mask setting

Applied, thanks

-- 
~Vinod
