Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAF76DDEC8
	for <lists+dmaengine@lfdr.de>; Sun, 20 Oct 2019 16:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfJTOFx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Oct 2019 10:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfJTOFx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 20 Oct 2019 10:05:53 -0400
Received: from localhost (unknown [106.51.108.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6654E218BA;
        Sun, 20 Oct 2019 14:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571580352;
        bh=U933TxoQrEvEqmsssmgD3G/Fg8+/vhTubrytkuZvyRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKNPdxdy1+dpHw4IeDpb5QmttdOuwwXJtb1Qz0IDzJX1CJHLL4aD1RX9vvD6cCNzJ
         hLhpnqsY8f4XdE5AA9rnXEFbn2DXlkD9qySXAYbSzBsrTf6psK7ISomReDKX+p2271
         i8ECSX7hcBflF2w6SIqdqwTBQLEDIQCcb5KxiPL4=
Date:   Sun, 20 Oct 2019 19:35:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        nick.graumann@gmail.com, andrea.merello@gmail.com,
        appana.durga.rao@xilinx.com, mcgrof@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next 0/7] dmaengine: xilinx_dma: AXI DMA driver
 improvements
Message-ID: <20191020140543.GV2654@vkoul-mobl>
References: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-10-19, 20:18, Radhey Shyam Pandey wrote:
> This patchset adds callback result, descriptor residue
> calculation and some regression fixes.

Applied, thanks

-- 
~Vinod
