Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1868918EF9D
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2020 07:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgCWGCZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Mar 2020 02:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgCWGCZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Mar 2020 02:02:25 -0400
Received: from localhost (unknown [171.76.96.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1786C20409;
        Mon, 23 Mar 2020 06:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584943344;
        bh=ee0DvBFR0IGEeMCB7WFreXz0Sqm1oKY39XWtZzXkiXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CuEEd5I6kltM4V4NI3FO8NDfqMx6Kf2qZEt2KEGWANZLYix88JDsILxAs1tXSIMUA
         +nRBDjmcjoP2XDtvCtcMcBb18oMJGCaYetviByFAIuWjDeaNOfFhCEbXlvf/Jx7dli
         tNwzqNPnPjtsT1LLMxmh1n7PPp14/FpctfCcvOQE=
Date:   Mon, 23 Mar 2020 11:32:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: fix off by one on cdev dwq refcount
Message-ID: <20200323060218.GB72691@vkoul-mobl>
References: <158403020187.10208.14117394394540710774.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158403020187.10208.14117394394540710774.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-03-20, 09:23, Dave Jiang wrote:
> The refcount check for dedicated workqueue (dwq) is off by one and allows
> more than 1 user to open the char device. Fix check so only a single user
> can open the device.

Applied, thanks

-- 
~Vinod
