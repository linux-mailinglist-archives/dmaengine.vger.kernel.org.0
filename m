Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB18B43E742
	for <lists+dmaengine@lfdr.de>; Thu, 28 Oct 2021 19:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhJ1R1Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Oct 2021 13:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230192AbhJ1R1Y (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 Oct 2021 13:27:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDD3660F38;
        Thu, 28 Oct 2021 17:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635441896;
        bh=jN3PT7OSQI9rk4nveuzC6GDiPUy1op7zepWCdvxGec4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzUEChK1waTKsu/NEbL00QNwDglLEuetCu7EY/B4AMN9kSNiqcP5d7oL3Lyy9+D9i
         EvUcS8fj6UlrPGfvdkm0eoZ1wjB8WWxJPKz+tBESZHYDU0z3L3c0aNotWYeC/Ibvui
         s/scMfjSrTmSJBDSG8E6xSzRFNmw+KiKGII5hvo3SgazRecJ72lz+nYEM5oe4bbz5n
         vrwnju/V4BmDlS5z9VYXDSESe+iF03En8Sdruvi5z/FEOwFH2OUhUk+6P5PojRVY19
         aqb2yWZQqVwFFR8eMpVPdCYlypsTLbiWJ/BUSWvZAO0BpS4S+sfTS3hlyuSfmxDVS8
         eC6H/kKvr3guw==
Date:   Thu, 28 Oct 2021 22:54:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: cleanup completion record allocation
Message-ID: <YXrc5K6DDBAqPN9P@matsya>
References: <163517396063.3484297.7494385225280705372.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163517396063.3484297.7494385225280705372.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-10-21, 07:59, Dave Jiang wrote:
> According to core-api/dma-api-howto.rst, the address from
> dma_alloc_coherent is gauranteed to align to the smallest PAGE_SIZE order.
> That supercedes the 64B/32B alignment requirement of the completion record.
> Remove alignment adjustment code.

Applied, thanks

-- 
~Vinod
