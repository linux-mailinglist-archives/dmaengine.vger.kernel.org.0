Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C896D7C686
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jul 2019 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfGaP3Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Jul 2019 11:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfGaP3Q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 31 Jul 2019 11:29:16 -0400
Received: from localhost (unknown [171.76.116.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B577206A3;
        Wed, 31 Jul 2019 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564586955;
        bh=+BRKzUwM8OwruXRsxUuLWu4ziaD3FNKMFe2NrmJpS6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pliu9DlraLieV4H56poR/05eLtgrQXF2E550yCD/1BqkY5J8a4LBlP0GQ3TUz5W+R
         MySUdpCGd0XuxIluW9RFS9kEIlqodJ6wKmzRenzG17xQaoBMaHXde4mAhZC/NhuU08
         c2tn4Qxy41GvYxCrBRol7OFAuj+nVN21IMbUMwFQ=
Date:   Wed, 31 Jul 2019 20:58:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 10/57] dmaengine: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190731152802.GW12733@vkoul-mobl.Dlink>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-11-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730181557.90391-11-swboyd@chromium.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-07-19, 11:15, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
> 
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
> 
> While we're here, remove braces on if statements that only have one
> statement (manually).

I would have preferred a patch per driver, but that does become insane
for treewide work, so I am taking this as is

Applied, thanks

-- 
~Vinod
