Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440BB1FB8AB
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2020 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbgFPP57 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jun 2020 11:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732096AbgFPPyi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Jun 2020 11:54:38 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B951021702;
        Tue, 16 Jun 2020 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322878;
        bh=7y0EhNTwXO/6Kymke+ZDTKpOhPaXNzPHCQdGhoS0LcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sju0fwwvQj9QnrX7uSFaWPn9HwsKGe7+vRtIFG5G06Moehdx4qeGlfxubYBTw2He4
         7eXzzTUnJPItQZ3mhjCrbr2m0RCFkyGxqG9yVfpFSIwjQSsXe42KWBjKf2qCCmtULJ
         WArneRslvN3GZWbdzSxjlRklGRyMmobSJFBfzlBo=
Date:   Tue, 16 Jun 2020 21:24:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Use correct node to read
 "ti,udma-atype"
Message-ID: <20200616155434.GI2324254@vkoul-mobl>
References: <20200527065357.30791-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527065357.30791-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-05-20, 09:53, Peter Ujfalusi wrote:
> The "ti,udma-atype" property is expected in the UDMA node and not in the
> parent navss node.
> 
> Fixes: 0ebcf1a274c5 ("dmaengine: ti: k3-udma: Implement support for atype (for virtualization)")
> 

No empty line b/w fixes and s-o-b please

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Fixed it up while applying

-- 
~Vinod
