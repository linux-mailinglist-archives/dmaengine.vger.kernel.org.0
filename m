Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C667A365742
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 13:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhDTLOu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 07:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhDTLOu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 07:14:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67BA26101D;
        Tue, 20 Apr 2021 11:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618917259;
        bh=6yK0mXpqTsEzzrGcuazTzZNbiVp8Kvn2BEmXwDjF7Y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PgrEWzB3uYpHkA6D5HCTxecsCNJIBrcG6VbXh42CnuMkL/j9dkbZR2BGmcoi5JQfZ
         ali5H7fkWE66gJcgJune4qKcjAlxS7J8KDFQK3m5nvAHsXoabAU57h5D9MUc+8aQoP
         IgtPuPPnXQdmopkCZAHvQm5npAftT46HgOzNqZrY31aHV1jUXCqt3uQKc0t9YjsWOq
         J/2jKdzX1Ym8Z8n9EDn3gRBlTL2rCm8BMIPczOuLXwjDnUd8peu7j5FaTaKVT2WMua
         neNFQCUFK0yySyOrmaxfyyz0NPCpwF+qsKnxqFX1Ic5rn/UHyso+LrT+5hBSqakc8J
         YU6/kHF7KS8yg==
Date:   Tue, 20 Apr 2021 16:44:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v10 00/11] idxd 'struct device' lifetime handling fixes
Message-ID: <YH63h6QQNrYlivTp@vkoul-mobl.Dlink>
References: <161852959148.2203940.7484827367948091199.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161852959148.2203940.7484827367948091199.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-04-21, 16:37, Dave Jiang wrote:
> Vinod,
> The series fixes the various 'struct device' lifetime handling in the
> idxd driver. The devm managed lifetime is incompatible with 'struct
> device' objects that resides in the idxd context. Tested with
> CONFIG_DEBUG_KOBJECT_RELEASE and address all issues from that.
> 
> Please consider for damengine/fixes for the 5.13-rc.

Applied, thanks

-- 
~Vinod
