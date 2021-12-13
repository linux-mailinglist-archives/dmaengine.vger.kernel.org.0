Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C3847208E
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 06:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhLMFdH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 00:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhLMFdG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 00:33:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D50C06173F;
        Sun, 12 Dec 2021 21:33:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35DF0B8076B;
        Mon, 13 Dec 2021 05:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E1DC00446;
        Mon, 13 Dec 2021 05:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639373583;
        bh=OX3w/rL67yCfKDwzGmF/nI63myPy5OTBPTIafZbFUVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XR4R8pAwKqjtf0RotDlRCBScq4k/atIB1ugecNJpg2mkL8K22jIQSbO4XcjczceZW
         AXuQxofPV9QBy9blM0CfmkMK9ZqCNmfeeXdGfmszqCdLWF2Qw8OqD4SYxMBOXOlo87
         j0HTL+QWY6Rw7qYfr4SkfuHhMLW0A4fidY4XWAz9TU1C3siAybaaYXzzt3w7vXqFLL
         wnQtxWNXOh1JH6aTX3oH30g3NlSGfYp0CEdLkTRI8uhoWld1mZMj014KPp96Kg1zh4
         8bCTfKY04h2yZ2C438UFRQVBSYi946qqtNwmIxTDlboJbLfRWFjukfhVHZd7w8Z8Tv
         Qetf8kUtZrKBg==
Date:   Mon, 13 Dec 2021 11:02:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] dma: ti: k3-udma: Fix smatch warnings
Message-ID: <YbbbCyE2db6S1Ibf@matsya>
References: <20211209180957.29036-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209180957.29036-1-vigneshr@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-12-21, 23:39, Vignesh Raghavendra wrote:
> Smatch reports below warnings [1] wrt dereferencing rm_res when it can
> potentially be ERR_PTR(). This is possible when entire range is
> allocated to Linux
> Fix this case by making sure, there is no deference of rm_res when its
> ERR_PTR().

Fixed the subsystem name and applied, thanks

-- 
~Vinod
