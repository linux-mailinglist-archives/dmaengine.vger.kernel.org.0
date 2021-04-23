Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A3836988E
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 19:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243123AbhDWRjw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Apr 2021 13:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231522AbhDWRjw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 23 Apr 2021 13:39:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 839846141C;
        Fri, 23 Apr 2021 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619199555;
        bh=3C2XnYGCG1vMywhQIOZpPYpWaaMESOwLZtDgXSYMwe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ooac47mlWgV1+oOS3TLSCdJRO2sbq/7Penj9tjqv4cL++rsCUXlreLkFYEMYIaYax
         eKc6h0WRLhegvaW0JmvBFf0aSdB+KlDgwoBseDlhoDik+N/THZc3txPZgg9k8FZDmI
         MwBtxouUsaU0hKJGyObZwo1cBI/IvoxaD14tPJu0ZRkOL5g7zh6SropwSm+F61bo6g
         LgsgvNLNv/rYXV4vPkqjAOBfFrcgUjx/GL4br7IrssSv8zGb23VWfa95MRsZUPeIZI
         SgVvGSSAGu7h+1by1bLP+H5SKMkNLSWxBc+QfhwDIFuJhqTzeVf6XP0HRalOvWr5Yn
         oDsPEKtQcwCLA==
Date:   Fri, 23 Apr 2021 23:09:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: remove MSIX masking for interrupt
 handlers
Message-ID: <YIMGP+/2hrUUWRsI@vkoul-mobl.Dlink>
References: <161894523436.3210025.1834640110556139277.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161894523436.3210025.1834640110556139277.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-04-21, 12:00, Dave Jiang wrote:
> Remove interrupt masking and just let the hard irq handler keep
> firing for new events. This is less of a performance impact vs
> the MMIO readback inside the pci_msi_{mask,unmas}_irq(). Especially
> with a loaded system those flushes can be stuck behind large amounts
> of MMIO writes to flush. When guest kernel is running on top of VFIO
> mdev, mask/unmask causes a vmexit each time and is not desirable.

Applied, thanks

-- 
~Vinod
