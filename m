Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B17D2124DF
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 15:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgGBNhA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 09:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbgGBNhA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 09:37:00 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F922088E;
        Thu,  2 Jul 2020 13:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593697019;
        bh=u7ZeJ/RuFWRwjUotw0enCK/Kt5oaQrqiHYn7EeH1D5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h6jx/Qpqpqe1svfqRmdMb3enHPo3s83fblx2xfMZHLs1IWACIR9xSw1SwbvNw+B6r
         wBxAviWLaJzMZK+2gNGn7gsI4oomh3QooxLNxYdtCKCe8hg6wM2rir70hCVTvhP/TW
         lSA3JjTHw5lGfqiqdZO05EReSsI0wMgte/6o9kZY=
Date:   Thu, 2 Jul 2020 19:06:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Swathi Kovvuri <swathi.kovvuri@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: check device and channel list for empty
Message-ID: <20200702133656.GF273932@vkoul-mobl>
References: <159319496403.69045.16298280729899651363.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159319496403.69045.16298280729899651363.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-06-20, 11:09, Dave Jiang wrote:
> Check dma device list and channel list for empty before iterate as the
> iteration function assume the list to be not empty. With devices and
> channels now being hot pluggable this is a condition that needs to be
> checked. Otherwise it can cause the iterator to spin forever.

Applied, thanks

-- 
~Vinod
