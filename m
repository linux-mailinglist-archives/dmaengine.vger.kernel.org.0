Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C4A4830F0
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jan 2022 13:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiACMTw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Jan 2022 07:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiACMTw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Jan 2022 07:19:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDEBC061761;
        Mon,  3 Jan 2022 04:19:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7A44B80952;
        Mon,  3 Jan 2022 12:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DBFC36AE9;
        Mon,  3 Jan 2022 12:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641212389;
        bh=k/Gud+CIQfxPylqjPvD3pX1+oaPh7LRPvorDB5+5ZEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0LTsVh+EeiyF5GRfWd0thDRR2QIdJNGWUAJHPN1jeWjyhyWUHQIa3SediDdkg67C
         EhzIxKMtyr9Wb8t6jKtY65nGvZ/uKAaD8QIELw+JgrLv+2He1nMjYWPRyGu9RJFTmw
         Mxs2h/k0uD7mu4llRFL7syDEUEGPg3UXOR8j2UFls9eT5Ni7XL8WfuxgTO/kLLrKDD
         aEZ9b5QpN5BJdoWWnkxPOU4vn5/hi4wcJqAec/noNQykOf/OlhqAvH+qiDv9gZhvsI
         HwtXjMoRIqpeO0CiI5HzgJ3rBwhT03nsrpz5vi64xT1YN9Yjy5Hu4nIhxXKw6bLd1O
         b/1EYWoY/SknA==
Date:   Mon, 3 Jan 2022 17:49:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: uniphier-xdmac: Fix type of address variables
Message-ID: <YdLp4Qz+j9BRPzah@matsya>
References: <1639456963-10232-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639456963-10232-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-12-21, 13:42, Kunihiko Hayashi wrote:
> The variables src_addr and dst_addr handle DMA addresses, so these should
> be declared as dma_addr_t.

Applied, thanks

-- 
~Vinod
