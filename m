Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FF4399F84
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 13:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFCLJm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 07:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhFCLJm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Jun 2021 07:09:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DC09613D7;
        Thu,  3 Jun 2021 11:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622718477;
        bh=f4K5JWhbtxnt2GNMNdWE8aEyOnpUw3O1MWjxYMBbEFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8TVXqawAQgHdbdZw+m67cZ6I5igyM+svwdaRgkzGO9Afs7/5Nkk1XHtm/0bFlMKY
         MqIZtIskyIpXA1wf8UAh/qBEjBKMYwJrF6Nsr9gIxsLtWP9B2AZLrcYKH81LBnDaRv
         /i+i0B3qIecGs46LUrju5XEFKv3Rjzjwf0PXQFeEc95WLWF8mO3mYY9rzVZrv3Ruhf
         AC/MuAJpOekC9FwDMn4CypOLosf8cmwmrNYzAKAWZe4Xjucdgn5aWCx0fZNWq+QYId
         5X43Ew/txa80+VhzsSUb7M/oWzjRN8VQBzaEl/SoM/ygfRQrOd9Eow/O0rgYQHrQOj
         9KdjkH3Jh07Tg==
Date:   Thu, 3 Jun 2021 16:37:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        wsa+renesas@sang-engineering.com,
        laurent.pinchart@ideasonboard.com, robin.murphy@arm.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: rcar-dmac: Fix PM reference leak in
 rcar_dmac_probe()
Message-ID: <YLi4CUhjpnAGrZ+A@vkoul-mobl>
References: <1622442963-54095-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622442963-54095-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-05-21, 14:36, Zou Wei wrote:
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.

Applied, thanks

-- 
~Vinod
