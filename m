Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C140C70234
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 16:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfGVOXD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 10:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbfGVOXC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jul 2019 10:23:02 -0400
Received: from localhost (unknown [223.226.98.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24CC2217D6;
        Mon, 22 Jul 2019 14:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563805381;
        bh=cmeknv+ms+SGcXgCwrtlqmuRDH1GTIq39zwqMIJiiXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zAewChpdqo3yoTZoj5XSDwyLeuv1n5gaKyp4cDy0ltGITn+FHZ0MpF8OK+fz3nihW
         +vPDYEMZ46I9chAcK0gBR2BzCmVnnaGfnAlx6SC43iEPJJGHPjAImLjqLEPHoTFO4p
         G8CY35nRdFh95P1EArFDL4KcrOuDAC/kHgdlyb6U=
Date:   Mon, 22 Jul 2019 19:51:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <jpinto@synopsys.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] [v2] dmaengine: dw-edma: fix unnecessary stack usage
Message-ID: <20190722142149.GU12733@vkoul-mobl.Dlink>
References: <20190722124457.1093886-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722124457.1093886-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-07-19, 14:44, Arnd Bergmann wrote:
> Putting large constant data on the stack causes unnecessary overhead
> and stack usage:
> 
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:285:6: error: stack frame size of 1376 bytes in function 'dw_edma_v0_debugfs_on' [-Werror,-Wframe-larger-than=]
> 
> Mark the variable 'static const' in order for the compiler to move it
> into the .rodata section where it does no such harm.

Applied all, thanks

Please do note the link was pointing to older rev, I have updated them
to this revision.

-- 
~Vinod
