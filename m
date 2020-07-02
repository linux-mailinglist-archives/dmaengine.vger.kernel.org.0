Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597832124BD
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 15:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgGBNcc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 09:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbgGBNcc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 09:32:32 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F3820780;
        Thu,  2 Jul 2020 13:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593696752;
        bh=vj7wd7OF+NrWJiycl03hhQbSuzSILLZMCrXgUPrR8no=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZiNMZ0/VRBDmP4fUk4V4mdIVM3ogCYNF59adLOrmZn7MPnxvLw/nm6zyLaPqh74Jx
         YitRBbMMzsQHqUPNWwP6g5ZxwCf+4RrxKqPRIX3wEJfZaNb0nQW9PXRRSRxmSH2AeB
         /QjX09nDRuRiHESHkkoKQLM1v7fDJ4KNV77m1uoI=
Date:   Thu, 2 Jul 2020 19:02:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: fix misc interrupt handler thread
 unmasking
Message-ID: <20200702133228.GC273932@vkoul-mobl>
References: <159311256528.855.11527922406329728512.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159311256528.855.11527922406329728512.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-06-20, 12:16, Dave Jiang wrote:
> Fix unmasking of misc interrupt handler when completing normal. It exits
> early and skips the unmasking with the current implementation. Fix to
> unmask interrupt when exiting normally.

Applied, thanks

-- 
~Vinod
