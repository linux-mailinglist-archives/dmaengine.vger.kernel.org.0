Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2030541ECA4
	for <lists+dmaengine@lfdr.de>; Fri,  1 Oct 2021 13:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhJAL6j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Oct 2021 07:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230522AbhJAL6j (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 1 Oct 2021 07:58:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17EAD6135E;
        Fri,  1 Oct 2021 11:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633089415;
        bh=VceA1nbn1q6t4P/0QR99Pc1TuhtvAKnzyYVgMoL+cjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JmkDlByp2NlYJS2tNQ7xSG4Xg9FmKqQk8ZA6z5f0RXh6PaxERPAhGM2k3diDVnYI6
         mQzpINO2EAs9KUgQmADwXEtMDIVOF6TTSTRB1k/NdNzTo+PlOwd3pO3pb5tLPJuK+C
         RsQ5FJB3HlJ1y8Y9UFBaU6m7PonB1qPNFsEkB4iW4FclLmrgxJ5+6gOe6F0874LLMA
         0WThjtEvKRn2dvGtzttdhk6YZ6As6dqjFbu62BFnUEHrPv/iwgDv4Ggpfl3bfxHaUv
         f6lZOl7RTwYaiJPKYG/1rulJg8nhFHzmLbY8IesUJIdQ9KQNe7Ljjkzyki1BSOQUaD
         tjHcBcCJURgBA==
Date:   Fri, 1 Oct 2021 17:26:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        appana.durga.rao@xilinx.com, michal.simek@xilinx.com,
        kernel@pengutronix.de
Subject: Re: [PATCH 0/7] dmaengine: zynqmp_dma: fix lockdep warning and
 cleanup
Message-ID: <YVb3gtSOamU91E5I@matsya>
References: <20210826094742.1302009-1-m.tretter@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826094742.1302009-1-m.tretter@pengutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-08-21, 11:47, Michael Tretter wrote:
> Hi,
> 
> I reported a lockdep warning in the ZynqMP DMA driver a few weeks ago [0].
> This series fixes the reported warning and performs some cleanup that I found
> while looking at the driver more closely.
> 
> Patches 1-4 are the cleanups. They affect the log output of the driver, allow
> to compile the driver on other platforms when COMPILE_TEST is enabled, and
> remove unused included header files from the driver.
> 
> Patches 5-7 aim to fix the lockdep warning. Patch 5 and 6 restructure the
> locking in the driver to make it more fine-grained instead of holding the lock
> for the entire tasklet. Patch 7 finally fixes the warning.

Applied, thanks

-- 
~Vinod
