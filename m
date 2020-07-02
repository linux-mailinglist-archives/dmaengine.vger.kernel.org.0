Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6802124E2
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgGBNhM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 09:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729200AbgGBNhM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 09:37:12 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05168207CD;
        Thu,  2 Jul 2020 13:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593697031;
        bh=4CfeVrbrFbhlVQu+lywSl1jUsKDblS2d6jzie2tuMQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgPShu2iX9+OE+mJaeaaX9m5sSFB5KBRydU9WcBA3yq3/9VNg2crQPEuLDz1gkSby
         zf00/3p/4kTMlmp2ngIcpUq1fAak7wfUSKrrm9OiNSPnQ/M22TvIENM7o4mI7Q+53u
         H4KcnTDuNL1m42VZQRV7pSeyb4n7Qh1fz5R3eHqg=
Date:   Thu, 2 Jul 2020 19:07:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: add work queue drain support
Message-ID: <20200702133708.GG273932@vkoul-mobl>
References: <159319502515.69593.13451647706946040301.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159319502515.69593.13451647706946040301.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-06-20, 11:11, Dave Jiang wrote:
> Add wq drain support. When a wq is being released, it needs to wait for
> all in-flight operation to complete.  A device control function
> idxd_wq_drain() has been added to facilitate this. A wq drain call
> is added to the char dev on release to make sure all user operations are
> complete. A wq drain is also added before the wq is being disabled.
> 
> A drain command can take an unpredictable period of time. Interrupt support
> for device commands is added to allow waiting on the command to
> finish. If a previous command is in progress, the new submitter can block
> until the current command is finished before proceeding. The interrupt
> based submission will submit the command and then wait until a command
> completion interrupt happens to complete. All commands are moved to the
> interrupt based command submission except for the device reset during
> probe, which will be polled.

Applied, thanks

-- 
~Vinod
