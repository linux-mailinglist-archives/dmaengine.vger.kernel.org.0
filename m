Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2392438FA5
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhJYGoq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhJYGoq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 02:44:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D629260551;
        Mon, 25 Oct 2021 06:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635144144;
        bh=z9bJcfbJUc0zsG6SDCKjaFwU8ogmWivAIveF/3NAfyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U1lJu74z1oZV8hsL6Jk/YRoqhnqVBJcNp+7ShBOD44EPjkKdTkLhkmTrIFMU5maGq
         c7WwD3c/gagUnIpApE+NJ/EgwwVnkyuepsPCkV4dWklLPDpZ+FbGgg8MSK7YVgm77r
         WfWJWW/b6hdgjeUZ11AXNUxC8p7br5ZRAn/VdyaMmANIQ3AoVgRfh5++XYCByZQtFV
         qwWac1ct5aHaX/5If4sqYjPnvdUob77G+8SEPLSySY//9GXvnibTsO+z7ATb/JvZ2v
         SIufN7RqhIaFc9P7sdoMjBUrTgbJim1abHCQY/6VhNH/sNY9Np+rNU79T+qJoS/1z4
         qXLfohx2vjopw==
Date:   Mon, 25 Oct 2021 12:12:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: milbeaut-hdmac: Prefer kcalloc over open
 coded arithmetic
Message-ID: <YXZRzCZxSN1jYOoI@matsya>
References: <20210904145813.5161-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904145813.5161-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-09-21, 16:58, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.

Applied, thanks

-- 
~Vinod
