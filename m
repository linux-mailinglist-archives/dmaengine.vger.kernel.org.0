Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1FE2B4C52
	for <lists+dmaengine@lfdr.de>; Mon, 16 Nov 2020 18:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbgKPRMp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Nov 2020 12:12:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731047AbgKPRMo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Nov 2020 12:12:44 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 687A120797;
        Mon, 16 Nov 2020 17:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605546764;
        bh=C+QJikeAlLIV6+DknTEUchTCebYLLhgex24/4Sa1/mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xd92LMg4sb5lNB9U2s8QyLQwfDwvDYKwoj02d6R5nJJG6smh/WbEUZKf5U4gEjh8w
         u1HCFAw4F7GBBwQegG9gvlLj1kSPVFoqwY2Vp6k3OlxP4gYfUPU3aY57VdVYzTxEzR
         XVmUKpGbDxbrVGlUJBIx4D/Y4TRvGq0cGO9RQgeU=
Date:   Mon, 16 Nov 2020 22:42:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Maciej Sosnowski <maciej.sosnowski@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ioatdma: remove unused function missed during
 dma_v2 removal
Message-ID: <20201116171239.GX7499@vkoul-mobl>
References: <20201113081248.26416-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113081248.26416-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-11-20, 09:12, Lukas Bulwahn wrote:
> Commit 7f832645d0e5 ("dmaengine: ioatdma: remove ioatdma v2 registration")
> missed to remove dca2_tag_map_valid() during its removal. Hence, since
> then, dca2_tag_map_valid() is unused and make CC=clang W=1 warns:
> 
>   drivers/dma/ioat/dca.c:44:19:
>     warning: unused function 'dca2_tag_map_valid' [-Wunused-function]
> 
> So, remove this unused function and get rid of a -Wused-function warning.

Applied, thanks

-- 
~Vinod
