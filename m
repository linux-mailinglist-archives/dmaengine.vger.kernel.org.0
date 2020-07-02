Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DC92124C0
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 15:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgGBNdE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 09:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbgGBNdE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 09:33:04 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43F522088E;
        Thu,  2 Jul 2020 13:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593696784;
        bh=vj7wd7OF+NrWJiycl03hhQbSuzSILLZMCrXgUPrR8no=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iyvPtTVdxOHd23seQVvfE8Zbq3Ob9RZEDZby1FGolvQRWjb9jo4y2Cu7/H1yqk9Cs
         nkwrN/eZmOcLOPYwRR391D0mLDeUZbKM3PWhsscSknKy84/dnGAvsJwbGM6Fc4jLHF
         JaqGIbTYiQSB9JM1zvh/CHR1TsefLl7YdwcDe74g=
Date:   Thu, 2 Jul 2020 19:03:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: fix misc interrupt handler thread
 unmasking
Message-ID: <20200702133300.GD273932@vkoul-mobl>
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
