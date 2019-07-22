Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0F470243
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 16:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfGVOZ7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 10:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfGVOZ6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jul 2019 10:25:58 -0400
Received: from localhost (unknown [223.226.98.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 623302171F;
        Mon, 22 Jul 2019 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563805558;
        bh=wuhTsZIObGWDG2QzWvOgk7IFTgkRJ2Atch9ilONi/HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=roEaUJSgM2YJgzNoyPsqezUm4dic3X2NV9saH90TLvV0rPQj8PbmHyLhvcEMzafLT
         Hk8pK8aLzQsEQGfsN4cr+47FuIMEzSlhs9LsUGGWeZq7EhDDIOdPvKvxUDWGK4Olk+
         0bjK+thA1SDg8vh99WIJ/AYSYY5qjPLsuW0fvdpg=
Date:   Mon, 22 Jul 2019 19:54:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] dma: ste_dma40: fix unneeded variable warning
Message-ID: <20190722142445.GV12733@vkoul-mobl.Dlink>
References: <20190712091357.744515-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712091357.744515-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-07-19, 11:13, Arnd Bergmann wrote:
> clang-9 points out that there are two variables that depending on the
> configuration may only be used in an ARRAY_SIZE() expression but not
> referenced:
> 
> drivers/dma/ste_dma40.c:145:12: error: variable 'd40_backup_regs' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> static u32 d40_backup_regs[] = {
>            ^
> drivers/dma/ste_dma40.c:214:12: error: variable 'd40_backup_regs_chan' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> static u32 d40_backup_regs_chan[] = {
> 
> Mark these __maybe_unused to shut up the warning.

Applied, thanks

-- 
~Vinod
