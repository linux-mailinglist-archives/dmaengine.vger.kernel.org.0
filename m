Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A291C3226
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 07:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgEDFRW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 01:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgEDFRW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 May 2020 01:17:22 -0400
Received: from localhost (unknown [171.76.84.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D60206C0;
        Mon,  4 May 2020 05:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588569441;
        bh=QMJaka9hkhKe4HxTAFmPhcwoBGA57avDfNSylKuJzJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qoo6s9hVzV239jyyhraX2UMI5kCViUyWSntUjdK7NowF27m9UImXLl//09mvREfg4
         KraSsk65WoEknSXOgEObB4z3BzbvD6Dvbw1O8kKBZUPDbcLt6aBvmPVS9TNuP1RPeT
         Yw0rvrfwc7fzoIiebHLSDfMULSzim2kmG6eoeu4Q=
Date:   Mon, 4 May 2020 10:47:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, sanjay.k.kumar@intel.com
Subject: Re: [PATCH v2] dmaengine: idxd: fix interrupt completion after
 unmasking
Message-ID: <20200504051717.GF1375924@vkoul-mobl>
References: <158834641769.35613.1341160109892008587.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158834641769.35613.1341160109892008587.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-05-20, 08:21, Dave Jiang wrote:
> The current implementation may miss completions after we unmask the
> interrupt. In order to make sure we process all competions, we need to:
> 1. Do an MMIO read from the device as a barrier to ensure that all PCI
>    writes for completions have arrived.
> 2. Check for any additional completions that we missed.

Applied, thanks

-- 
~Vinod
