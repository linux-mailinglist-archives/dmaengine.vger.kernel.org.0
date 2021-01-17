Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D372F9127
	for <lists+dmaengine@lfdr.de>; Sun, 17 Jan 2021 07:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbhAQGwR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 17 Jan 2021 01:52:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbhAQGwQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 17 Jan 2021 01:52:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D801225AC;
        Sun, 17 Jan 2021 06:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610866296;
        bh=AS14Q+bmW5P/a/N+8fr0lDek5zpEq33K4NHVyYgnfLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HCX073z1lW0SuKboUNNvOnMlZubp/+vucsYoY/H2SOOb7Mn2nEnZMa+jemE6kYAYb
         2kdx/Ljvspy4TP2N93py43FjZZJuDjB4ikN9j146QVSJE6EdcRw0zKUhN2IW8bfijj
         Kk7c8awmuL6KAq3/pI1qpwLr0RIFNr1fdhOZPbwCDXkB9a8eBtDus4CY6d6fySRJl+
         +cScPMNIMhllnCuHGKvq4snYswOWNQVi+zqcHYtGxEzK+ekHq8nPGM8c6p5tV5717W
         2l+GexbI7RfHYatpl39KU9uxgl8Y5oI/RRbLi/YztjGSJ79mlSIkh2iXdQXqrltKuK
         uJkd4f4ldzcAw==
Date:   Sun, 17 Jan 2021 12:21:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Nikhil Rao <nikhil.rao@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix misc interrupt completion
Message-ID: <20210117065129.GM2771@vkoul-mobl>
References: <161074755329.2183844.13295528344116907983.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161074755329.2183844.13295528344116907983.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-01-21, 14:52, Dave Jiang wrote:
> Nikhil reported the misc interrupt handler can sometimes miss handling
> the command interrupt when an error interrupt happens near the same time.
> Have the irq handling thread continue to process the misc interrupts until
> all interrupts are processed. This is a low usage interrupt and is not
> expected to handle high volume traffic. Therefore there is no concern of
> this thread running for a long time.

Applied, thanks

-- 
~Vinod
