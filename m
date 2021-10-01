Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B9941ECAB
	for <lists+dmaengine@lfdr.de>; Fri,  1 Oct 2021 13:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354116AbhJAMAp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Oct 2021 08:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhJAMAn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 1 Oct 2021 08:00:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9660361A82;
        Fri,  1 Oct 2021 11:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633089539;
        bh=LQC6CmmtQLl4UkLmtEOJTMSLNO/8kv2yuaHw0MLrByc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ciEKqFcWN0NnMeQsB2c5cV5YHs2gMztoMIfl96SGLX4njHHpz2ioD+0yGBjrElydi
         f+JH3VU51wmhyOgh9pzehL/S0FgQid7wUj9recpNe/L6STy5pW+6mopgL5px4+XlRa
         a1+lra/TBHJnCsGYvQm4BjiiuH3aQMrx9Fbr0d9+/6O2ptyeLzZDpqxltpBgR6UBlC
         74YxC+gh5j6yd5WvHNPYWWWcgzE7813HnuWet/bwoKKR8ZeJSmc9oS5owcOwEGHka4
         334YVsaM9VosSpiY36u1ASzaayivHpwU4U0kV8hv4/oAAiqNuywdJSaRGQZa9BdjVW
         0JVXLSidXRzlQ==
Date:   Fri, 1 Oct 2021 17:28:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: move out percpu_ref_exit() to ensure
 it's outside submission
Message-ID: <YVb3/1gesMcTB7IY@matsya>
References: <163294293832.914350.10326422026738506152.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163294293832.914350.10326422026738506152.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-09-21, 12:15, Dave Jiang wrote:
> percpu_ref_tryget_live() is safe to call as long as ref is between init and
> exit according to the function comment. Move percpu_ref_exit() so it is
> called after the dma channel is no longer valid to ensure this holds true.

Applied, thanks

-- 
~Vinod
