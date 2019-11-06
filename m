Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E92ACF1C22
	for <lists+dmaengine@lfdr.de>; Wed,  6 Nov 2019 18:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfKFRIT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Nov 2019 12:08:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbfKFRIT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 6 Nov 2019 12:08:19 -0500
Received: from localhost (unknown [106.51.111.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C557521848;
        Wed,  6 Nov 2019 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573060098;
        bh=wmLHBRowqgj8WO8cDFITDoAKnZVvMcJ9OldphjgPD9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yOzB3YCAvxO7BCN5xbbDWRCHUSwUsYcyvGPJQzkp2KUBOjXgUx1XVPaEPnMI4BL9Q
         LG96b93FUgz3iNrvsaeY6SwQeqeZX55kBGReH5/PA/gn48iB16gp8fFSVkUYEqOE6N
         nu+p48MBCtkSW6R0ii1gH+LeOjLZ2e9U07Hs8duM=
Date:   Wed, 6 Nov 2019 22:38:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dan.j.williams@intel.com,
        michal.simek@xilinx.com, anirudha.sarangi@xilinx.com,
        nick.graumann@gmail.com, andrea.merello@gmail.com,
        appana.durga.rao@xilinx.com, mcgrof@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH -next 0/6] dmaengine: xilinx_dma: Add Xilinx AXI MCDMA
 Engine driver support
Message-ID: <20191106170813.GJ952516@vkoul-mobl>
References: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-10-19, 22:30, Radhey Shyam Pandey wrote:
> This patchset adds Xilinx AXI MCDMA IP support. The AXI MCDMA provides
> high-bandwidth direct memory access between memory and AXI4-Stream target
> peripherals. It supports up to 16 independent read/write channels.
> 
> MCDMA IP supports per channel interrupt output but driver support one
> interrupt per channel for simplification. IP specification/programming
> sequence and register description is mentioned in PG [1].
> 
> The driver is tested with xilinx internal dmatest client. In end usecase
> MCDMA will be used by xilinx axiethernet driver using dma API's.

Applied, thanks

-- 
~Vinod
