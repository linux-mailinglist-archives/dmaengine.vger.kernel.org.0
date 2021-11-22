Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A7B458985
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 08:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhKVHDO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 02:03:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231545AbhKVHDN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 02:03:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9E1060F25;
        Mon, 22 Nov 2021 07:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637564407;
        bh=0mpLUNkFkKEVCU9tYkDRjAIEfeJMPNq5SbN742vXAFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lw1gJKeVZjI++cizDdeaCGrUYyfWyinPkPxwK3nLYRvV1sRh5/4/VYQn6ru+dHPK8
         F/Schv8lOo8abbwHzR8kHR7Y6jlCELYTBcDkfw7FoCnbifd4TAvK8kjZFz/F3J3SkN
         wUyan7oT4Eu8IGiu9rowKjmdokFgmwAvYvLpC+x0fqXx0zaF9QXTXhLmLmhK2sJYxB
         s2VzloHdr3J7SgUX5yJqOz5DoTZ3ZL/g6YWs1AttfmD3Nzq6R3PeiZYbbVZGBdGl8B
         CvlTh8d7h6TUPFW8iU6BenGWDi2QNZKylxiJxNJF1eW1AdxJU3EhA3rVG7lwaiM7pR
         8NtztQXcUvQqQ==
Date:   Mon, 22 Nov 2021 12:30:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: idxd: fix calling wq quiesce inside
 spinlock
Message-ID: <YZs/8ywXtuKv0T6s@matsya>
References: <163716858508.1721911.15051495873516709923.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163716858508.1721911.15051495873516709923.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-11-21, 10:03, Dave Jiang wrote:
> Dan reports that smatch has found idxd_wq_quiesce() is being called inside
> the idxd->dev_lock. idxd_wq_quiesce() calls wait_for_completion() and
> therefore it can sleep. Move the call outside of the spinlock as it does
> not need device lock.

Applied, thanks

-- 
~Vinod
