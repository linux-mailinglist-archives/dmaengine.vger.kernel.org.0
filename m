Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3CD2124E8
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgGBNii (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 09:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbgGBNii (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 09:38:38 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C24207CD;
        Thu,  2 Jul 2020 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593697118;
        bh=SK38Suvwk+xdsOU+uv2yWr4B8EHMAuLFFNnzGGPN86w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VFz/cuVj1OBG5szEAIcUJJayXGokGX+PhAQw/git5EVqb0jjQ6HkcAzVQgkDwKBPg
         jzAPX68taTSj3bKh9UMnMePplFSqe/sGVLFzvd5RHKdif7EnqA6YJoq4pu/6y3kuQb
         4/jGk2n2+YRQy+gxRg4znDU+RLEacAWkLkOx/sxM=
Date:   Thu, 2 Jul 2020 19:08:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: move idxd interrupt handling to mask
 instead of ignore
Message-ID: <20200702133834.GH273932@vkoul-mobl>
References: <159319517621.70410.11816465052708900506.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159319517621.70410.11816465052708900506.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-06-20, 11:12, Dave Jiang wrote:
> Switch driver to use MSIX mask and unmask instead of the ignore bit.
> When ignore bit is cleared, we must issue an MMIO read to ensure writes
> have all arrived and check and process any additional completions. The
> ignore bit does not queue up any pending MSIX interrupts. The mask bit
> however does. Use API call from interrupt subsystem to mask MSIX
> interrupt since the hardware does not have convenient mask bit register.

Applied, thanks

-- 
~Vinod
