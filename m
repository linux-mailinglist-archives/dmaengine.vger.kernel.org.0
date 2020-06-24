Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C76206DA1
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 09:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbgFXH3P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 03:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbgFXH3P (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 03:29:15 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48C032073E;
        Wed, 24 Jun 2020 07:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592983755;
        bh=ytPqR5xyOaqJEvsrk+oYUTZAaRvKKQWw7HgvRa/Nehg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P158rICn+S5i2qpUlvcdNvtDXTp9gZ12fG4TICxRyuSi+RlPQCmwP/j6Np+dFSarc
         yk7Jc4eASbgAB1U6MX/zIydZSxAwvXtV4cTmxt/yyqOSPp6korgVtSvAWNN6H2aHjP
         amB5yRogUO8UaztjtK6nOAj1Ga1q63e5ULMY0JNA=
Date:   Wed, 24 Jun 2020 12:59:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, swathi.kovvuri@intel.com
Subject: Re: [PATCH] dmaengine: check device and channel list for empty
Message-ID: <20200624072911.GL2324254@vkoul-mobl>
References: <158957055210.11529.14023177009907426289.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158957055210.11529.14023177009907426289.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-05-20, 12:22, Dave Jiang wrote:
> Check dma device list and channel list for empty before iterate as the
> iteration function assume the list to be not empty. With devices and
> channels now being hot pluggable this is a condition that needs to be
> checked. Otherwise it can cause the iterator to spin forever.

Can you rebase and resend, they dont apply on next

> 
> Fixes: e81274cd6b52 ("dmaengine: add support to dynamic register/unregister of channels")

Pls drop this empty line
> 
> Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
-- 
~Vinod
