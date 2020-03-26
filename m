Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E000193906
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2020 07:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgCZGyM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Mar 2020 02:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgCZGyL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Mar 2020 02:54:11 -0400
Received: from localhost (unknown [106.201.104.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A2B1206F8;
        Thu, 26 Mar 2020 06:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585205651;
        bh=nTe18uYXZP0lY5YmZ2IjKNaRt0YZlqMI1L9JcoX+9so=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0rG1kVzZQBW/pBOmv/BD5MWk8LYb+uoYov7jGmZOX5zEZyMfmUwCB2yDlFFkfkx1
         dS0GS+TE3L6WqvBPSoTPbaOSYWDjgPPdKC+7CE66qYk+PwBj+Vs/YaBrQ5YKMmDxYs
         sBNN7Eq4kofiHeUaKJLWb+V9Z8lLGxJ9tAwbTILo=
Date:   Thu, 26 Mar 2020 12:24:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] dmaengine: uniphier-xdmac: Remove redandant error log
 for platform_get_irq
Message-ID: <20200326065406.GW72691@vkoul-mobl>
References: <20200323171928.424223-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323171928.424223-1-vkoul@kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-03-20, 22:49, Vinod Koul wrote:
> platform_get_irq prints the error on failure, so there is no need to
> have caller add a log.
> Remove the log in uniphier_xdmac_probe() for platform_get_irq() failure

Applied, thanks

-- 
~Vinod
