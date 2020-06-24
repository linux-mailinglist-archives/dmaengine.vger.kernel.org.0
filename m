Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D97C206D8D
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 09:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbgFXHYU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 03:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387871AbgFXHYT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 03:24:19 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A89207DD;
        Wed, 24 Jun 2020 07:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592983459;
        bh=T65NFsE+OD4JxBvcB/cB5l7j/Hl5oDKWSv4j64lsTPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NcTbr6cAkBbFlqAFOoT/K334d+vngIkXH7ZM50+jYDlB1EpPTuGR/Lxy+rE9qWs7F
         f6oQRZ45XGE5wWFYuU3xpKDI6DSBXD8xO9rOrmboc1LoPJXGrkq+Tn/7mHwi59FpEc
         9419lp5sNSR9MCSOmTKDjegGvtK4sKhEXwujgbXU=
Date:   Wed, 24 Jun 2020 12:54:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: move submission to sbitmap_queue
Message-ID: <20200624072415.GI2324254@vkoul-mobl>
References: <159225446631.68253.8860709181621260997.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159225446631.68253.8860709181621260997.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-06-20, 13:54, Dave Jiang wrote:
> Kill the percpu-rwsem for work submission in favor of an sbitmap_queue.

Applied, thanks

-- 
~Vinod
