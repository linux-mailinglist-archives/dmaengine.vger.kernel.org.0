Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428B81FBDBA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2020 20:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgFPSLt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jun 2020 14:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgFPSLt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Jun 2020 14:11:49 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C3EB2080D;
        Tue, 16 Jun 2020 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592331108;
        bh=N+j1E237R6pEOvszZnQh+T6SQwc8ETWHAbsYLHd39ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1cYCmDkCph8ZB3upC7V3nY9A6FkWDv1QBl66KQ6LHOEzhFdJ2PeXBcJxFwmj6vlyz
         kVe8kemce/LjXUiYuajXfbbj34+30oydsjKuhYv4XR1cJf9dsMADieBUYL6Q/SHxUg
         f3B0pYvVwnGvBESxhU+3FXQXe1F0uaYM9ehxXo7s=
Date:   Tue, 16 Jun 2020 23:41:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] dmaengine: dw-edma: use PCI_IRQ_MSI_TYPES  where
 appropriate
Message-ID: <20200616181144.GQ2324254@vkoul-mobl>
References: <20200602092025.31922-1-piotr.stankiewicz@intel.com>
 <20200616163104.GN2324254@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616163104.GN2324254@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-06-20, 22:01, Vinod Koul wrote:
> On 02-06-20, 11:20, Piotr Stankiewicz wrote:
> > Seeing as there is shorthand available to use when asking for any type
> > of interrupt, or any type of message signalled interrupt, leverage it.
> 
> Applied, thanks

Dropped now.. PCI_IRQ_MSI_TYPES is not upstream yet!

Feel free to take in PCI tree with my ack

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
