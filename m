Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB1D206C2A
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 08:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbgFXGHk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 02:07:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388164AbgFXGHk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 02:07:40 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D93332073E;
        Wed, 24 Jun 2020 06:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592978859;
        bh=3YDSYYsFMeJJ8+yfGXhyil0Sju0aIwCctzEpnT5CjsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mdLRm3mUb3wIZjDN23bMXOTmMu8A6ZUtpLbhg4Ke5GairEBbRukYzkEn3yRv0DcsO
         ttq3GjT3NLht4YEtS3lYb2aLTu9g3c0fXLDupnXZIr25sjrGF0pC9kr9lr6ubTQVLV
         IakGzQNSUEbY/NyPIv9WmHV7ypwLdyt0jcWGjJCk=
Date:   Wed, 24 Jun 2020 11:37:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix misc interrupt handler thread
 unmasking
Message-ID: <20200624060735.GE2324254@vkoul-mobl>
References: <159251803563.35972.386134975421311008.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159251803563.35972.386134975421311008.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-06-20, 15:07, Dave Jiang wrote:
> Fix unmasking of misc interrupt handler when completing normal. It exits
> early and skips the unmasking with the current implementation. Fix to
> unmask interrupt when exiting normally.
> 
> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> 

ugh!

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Anyway this fails to apply, please rebase on fixes and resend

Thanks
-- 
~Vinod
