Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1ED3CFB83
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jul 2021 16:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbhGTNVy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jul 2021 09:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239210AbhGTNRl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Jul 2021 09:17:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41C3D6113A;
        Tue, 20 Jul 2021 13:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626789500;
        bh=m4r6SGJy8VkYPoQh952xQ62vlJp1Exmn/BK57supkL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hbd8s22omned4LdKTFXoh0EPXkZJ39QIVUAalKsR6jZMgxUc2wb1fOpvJiMCUORK7
         QzsjgNsK/jYRk2BH5hMhkXPGQ/iXBJV/+9QNDKdjd936CLzRHyIfObVhE7HT+7MKj9
         Far0DxGo+ozLnnMchFumgS9v55wSwRe91rUMgZKUqyQzeGL0450LOpYh1SNGOoVYi3
         PU9HLVm7SNyhu5paS7I+orRr9P8X74geMx2LoDFpwsvvBaCAilYR5vLWwGcCQwuTrC
         A1SPrn/xEiuI6s2ZfThHfMNEBIt9ekoFlZmDhiUNxC9VoJ/mA4zukT16MhIUUcXMnG
         8qp3hber8IglQ==
Date:   Tue, 20 Jul 2021 19:28:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Konstantin Ananyev <konstantin.ananyev@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v4] dmaengine: idxd: fix submission race window
Message-ID: <YPbWeAyZa/IsZyEG@matsya>
References: <162628855747.360485.10101925573082466530.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162628855747.360485.10101925573082466530.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-07-21, 11:50, Dave Jiang wrote:
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

Applied, thanks

-- 
~Vinod
