Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5002AB779
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 12:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgKILsA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 06:48:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgKILsA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Nov 2020 06:48:00 -0500
Received: from localhost (unknown [122.171.147.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23D65206ED;
        Mon,  9 Nov 2020 11:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604922480;
        bh=+1jUO5zVW1SKw9KmRQ1CIOboAVSFsXPM+3hRXA2kH1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zVwZth8NXMO8b+9mGaA5fgP25EbPZF6L2i+JLJFcXq5+XIE1AYCaoEWCwwto6ejRt
         iJrxXSW7bA7E58hADPZ40KaFzGo8YkpdcV9LtNAlhoYPHMJcZafuNN86hU/T0mBP5T
         j5iqC3vl0+jPfWQXNyGmPJvHFHR7XPwVAJXKVjug=
Date:   Mon, 9 Nov 2020 17:17:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Update calculation of group offset to
 be more readable
Message-ID: <20201109114755.GI3171@vkoul-mobl>
References: <160407294683.839093.10740868559754142070.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160407294683.839093.10740868559754142070.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-10-20, 08:49, Dave Jiang wrote:
> Create helper macros to make group offset calculation more readable.

Applied, thanks

-- 
~Vinod
