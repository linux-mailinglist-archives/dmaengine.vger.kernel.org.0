Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B71122E894
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jul 2020 11:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgG0JOR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jul 2020 05:14:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgG0JOR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Jul 2020 05:14:17 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5166020714;
        Mon, 27 Jul 2020 09:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595841257;
        bh=o5jOp/8zQ9YbOxHw+LsaOEzaSAyW1H9Jsr8CqOR6FzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSNUenWfQbksNx8nHR6QVZ4TJ1iF8At5KwYT6Ku/S1RJ+ktV1EEvsB3EGJ8Po1Yrz
         Xn7/vrLXLj7YX1fqCY48lWyjyfDOJGar2rZMHjCI68fUmdA5lHnB5k9GlvMAezG5om
         c0hK7M0R0HuFxuPS8j+J7QrijIfVjYS1LuPQO33Y=
Date:   Mon, 27 Jul 2020 14:44:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, dan.j.williams@intel.com,
        cristian.ciocaltea@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v7 03/10] dmaengine: Actions: Add support for S700 DMA
 engine
Message-ID: <20200727091413.GR12965@vkoul-mobl>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
 <1595180527-11320-4-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595180527-11320-4-git-send-email-amittomer25@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-07-20, 23:12, Amit Singh Tomar wrote:
> DMA controller present on S700 SoC is compatible with the one on S900
> (as most of registers are same), but it has different DMA descriptor
> structure where registers "fcnt" and "ctrlb" uses different encoding.
> 
> For instance, on S900 "fcnt" starts at offset 0x0c and uses upper 12
> bits whereas on S700, it starts at offset 0x1c and uses lower 12 bits.
> 
> This commit adds support for DMA controller present on S700.

Applied, thanks

-- 
~Vinod
