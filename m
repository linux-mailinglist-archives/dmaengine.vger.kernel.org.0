Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6203F7776
	for <lists+dmaengine@lfdr.de>; Wed, 25 Aug 2021 16:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241761AbhHYOew (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Aug 2021 10:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241760AbhHYOev (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Aug 2021 10:34:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBBD461073;
        Wed, 25 Aug 2021 14:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629902045;
        bh=NtRP31ODX9MN/AzgZio7vVzdgP+wd2nNrjVYjeD9d5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7b3xV3XUx9g+WeVEQU5lFzuzyR20JMvxLjR+q8vcNfpU95EyYtcgQR8fxT/i+JIz
         g9S9djJVRgCSxDlkBEJZIG8yAFVUq0tbjVidjd24lJSYZ6KyuGBX0dLbAwhNep7/bz
         TzxN/dGCHZIIjAiquVDaDkfTo4kA8G/kVOgprGngYIGFbHF4YgZH6xsu63+Tzg7Dq3
         7X0IVgPDEWQdGIKaicxjqrLCaFGN49t/RRxSy+82RRHPnBjIpBs2KJjF3bd4mK6uXq
         Ba+gKgKySdsc22GO1Vxa824n39rgJbzdVOp02wduodmquaSX56UascJnvlyirpfYws
         GYNibhHiw3mZg==
Date:   Wed, 25 Aug 2021 20:04:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     appana.durga.rao@xilinx.com, michal.simek@xilinx.com,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: xilinx_dma: Set DMA mask for coherent APIs
Message-ID: <YSZU2QKisH62lHug@matsya>
References: <1629363528-30347-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629363528-30347-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-08-21, 14:28, Radhey Shyam Pandey wrote:
> The xilinx dma driver uses the consistent allocations, so for correct
> operation also set the DMA mask for coherent APIs. It fixes the below
> kernel crash with dmatest client when DMA IP is configured with 64-bit
> address width and linux is booted from high (>4GB) memory.

Applied, thanks

-- 
~Vinod
