Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A113C7F48
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 09:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbhGNHZv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 03:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238104AbhGNHZu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 03:25:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE18F61361;
        Wed, 14 Jul 2021 07:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626247379;
        bh=xgAC1G/YgjuQOSiu/OW8fEl3QNiFeBT0UK7CPP+fvmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ht8vKQizLl+CH2na/eUgH5/Y0Xq3mqrjqgxCXPLOH6p5OFRB3RDIJXZsIBGqmrkRf
         /G02nNee9312KgUx2a3lTcAaEQYAmiywmo8nmGaf0MW9cirP0jtkY8W789n/BanfJu
         HeCh1cddaDuXDXPgR7Dn68sFieWikfh8bzQ0/EHRyzyB2l+vi4KmSq51cPr/AZyJXS
         jz+XHeDGrwfgdH9NU3GGpK2/rNyiRRK30XOPtLchmVQJv0FhYsehxM6k+2hBYqrP+V
         gWA572IL2guQUCTvv8FqLzutotaxtSRekicdSDNzgw7zmeBd4fqwOOHeLWGbbwF8on
         i5+qBkM6EMNGg==
Date:   Wed, 14 Jul 2021 12:52:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Konstantin Ananyev <konstantin.ananyev@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: idxd: fix submission race window
Message-ID: <YO6Qz/ErsM/g0npk@matsya>
References: <162498301955.2302125.5031103655704428294.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162498301955.2302125.5031103655704428294.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-06-21, 09:11, Dave Jiang wrote:
> Konstantin observed that when descriptors are submitted, the descriptor is
> added to the pending list after the submission. This creates a race window
> with the slight possibility that the descriptor can complete before it
> gets added to the pending list and this window would cause the completion
> handler to miss processing the descriptor.
> 
> To address the issue, the addition of the descriptor to the pending list
> must be done before it gets submitted to the hardware. However, submitting
> to swq with ENQCMDS instruction can cause a failure with the condition of
> either wq is full or wq is not "active".
> 
> With the descriptor allocation being the gate to the wq capacity, it is not
> possible to hit a retry with ENQCMDS submission to the swq. The only
> possible failure can happen is when wq is no longer "active" due to hw
> error and therefore we are moving towards taking down the portal. Given
> this is a rare condition and there's no longer concern over I/O
> performance, the driver can walk the completion lists in order to retrieve
> and abort the descriptor.
> 
> The error path will set the descriptor to aborted status. It will take the
> work list lock to prevent further processing of worklist. It will do a
> delete_all on the pending llist to retrieve all descriptors on the pending
> llist. The delete_all action does not require a lock. It will walk through
> the acquired llist to find the aborted descriptor while add all remaining
> descriptors to the work list since it holds the lock. If it does not find
> the aborted descriptor on the llist, it will walk through the work
> list. And if it still does not find the descriptor, then it means the
> interrupt handler has removed the desc from the llist but is pending on
> the work list lock and will process it once the error path releases the
> lock.

This fails to apply on fixes branch, pls rebase

-- 
~Vinod
