Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120E03655F5
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 12:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhDTKQh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 06:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhDTKQh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 06:16:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3D3F6103E;
        Tue, 20 Apr 2021 10:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618913765;
        bh=ywKEyiHWYClQI1Dmf/rkB4oZayawQuFh8fCIiiwQMC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGv/OALmF8O3hYRASifOtbcgAI3TjOxs2wBcV3W/tLLmQVvZmEE198xmCjRfhgcEB
         Z7WVddlioF8mTidJtG4eEFaMh9swtExXvNUeox2aCT1J/3nWJRpVefsDa/9MuLQ8p0
         G0svygTczL0kXJb9RvH3rHZMisQALgoDP/Tt7QMlKXXp1pI3C6rQmnuVhh9nFuO5mz
         JasB47atzmXus6U/wHsAk07BnMY53PpJ4YL6/DNSI2hP1ypS8takaNUIkexY7aN4+A
         +vbzsUU3eEwZHa7Vy8nrfY5BZxqTxjXTVx7cXrXoN5lWo4PqQjMB184F7N8T3d5mTN
         9nFZnGZhTFnDA==
Date:   Tue, 20 Apr 2021 15:46:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix potential null dereference on
 pointer status
Message-ID: <YH6p4e/BtoYp8jH7@vkoul-mobl.Dlink>
References: <20210415110654.1941580-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415110654.1941580-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-04-21, 12:06, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are calls to idxd_cmd_exec that pass a null status pointer however
> a recent commit has added an assignment to *status that can end up
> with a null pointer dereference.  The function expects a null status
> pointer sometimes as there is a later assignment to *status where
> status is first null checked.  Fix the issue by null checking status
> before making the assignment.

Applied, thanks

-- 
~Vinod
