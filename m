Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61D821520E
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2020 07:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgGFFPL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jul 2020 01:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgGFFPK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Jul 2020 01:15:10 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FEC320715;
        Mon,  6 Jul 2020 05:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594012510;
        bh=7oYqWOK3unlNz4/VMag6g5z3WFeLpZqQl6YLrcWIT6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUbq8r0M29FIz8UvlUac9YyxnU57N5vh6vIJuYe7iewriu1IP5SBaSvN684LLMgz9
         GG2nFx3EDiUzE79KK44Flb7Z8tG5p3j14Kwy77F67Xayq8bn2bG/UkErJd9xiEmWMg
         Bl2HiFvm/nU0SVslj5qQ277vQFdpQ1C3qWZFupZg=
Date:   Mon, 6 Jul 2020 10:45:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     dmaengine@vger.kernel.org, peng.ma@nxp.com, maowenan@huawei.com,
        yibin.gong@nxp.com, festevam@gmail.com,
        kbuild test robot <lkp@intel.com>
Subject: Re: [RESEND v2] dmaengine: fsl-edma: fix wrong tcd endianness for
 big-endian cpu
Message-ID: <20200706051506.GG633187@vkoul-mobl>
References: <20200701225205.1674463-1-angelo.dureghello@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701225205.1674463-1-angelo.dureghello@timesys.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-07-20, 00:52, Angelo Dureghello wrote:
> Due to recent fixes in m68k arch-specific I/O accessor macros, this
> driver is not working anymore for ColdFire. Fix wrong tcd endianness
> removing additional swaps, since edma_writex() functions should already
> take care of any eventual swap if needed.
> 
> Note, i could only test the change in ColdFire mcf54415 and Vybrid
> vf50 / Colibri where i don't see any issue. So, every feedback and
> test for all other SoCs involved is really appreciated.

Applied, thanks

-- 
~Vinod
