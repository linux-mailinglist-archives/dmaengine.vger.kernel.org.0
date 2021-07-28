Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F173D87F9
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 08:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhG1Ge3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 02:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233989AbhG1Ge2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 02:34:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48D86601FE;
        Wed, 28 Jul 2021 06:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627454067;
        bh=C0FNTOnyxUD0u4VKjgMCo4MT78njp9/ePeqMC0wr4aY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0jaCs56hHgGNUyu1WhaGCiBvXaMWBZ3YaFFg5YXmsBg8UrD9jx0YHJOL8BJVOuGG
         oA2gNrVKGYIkHeE3XhNoUQBkTRGqi6vabH6YgZz2FO1Nmkvenz04RGMd9ccdA4w2BN
         2B8j33He8zRqDcjLBfctF0ChcJWD52ZviPqOxz1cpduLS0qAyCR6bBT39pc9aKHUOj
         yc3ofBVPEDJKq3vyfu9Qyx0XoptQeWXSwrKfQ4ERqhVl5WpfaYqnQFdeu16pcpBy0n
         KwpVXin36c2PjYt4oq5u/KJPQA6he/loqZszJ2uscwIFMA3NK8G97KFcM8gfyV9d7x
         3kRlBCBZqwi3Q==
Date:   Wed, 28 Jul 2021 12:04:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        pierre-yves.mordret@st.com, amelie.delaunay@st.com,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next 0/3] Fix PM usage counter imblance and clear code
Message-ID: <YQD6bADgB6KTfQ/R@matsya>
References: <20210607064640.121394-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607064640.121394-1-zhangqilong3@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-06-21, 14:46, Zhang Qilong wrote:
> The first two patches fix PM disable depth imbalance and
> the last clear pm_runtime_get_sync calls.

Applied, thanks

-- 
~Vinod
