Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE509ECFC6
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2019 17:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfKBQd0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 2 Nov 2019 12:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfKBQd0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 2 Nov 2019 12:33:26 -0400
Received: from localhost (unknown [106.206.20.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A26E21726;
        Sat,  2 Nov 2019 16:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572712405;
        bh=pm2+bu4uEIGueYuZhTNNzrPvH1/wCA/hvRIau0o2OC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SjBb4mr+aBSOAr2wtZKe2avThyo5NnLOpUlf8jR2nqLinXXRbeC1vrz3N69M7Od3e
         MwRg8yD5m+PnADaLIvMcsbYr4PJtWfVcGJuZcRX+u8zuTTVmnf0pbUUuV6ZZI3PFY7
         pkCNzYBZEBFqRwFGV2OHIe88LylxjO3ZYw2gIZ3M=
Date:   Sat, 2 Nov 2019 22:03:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Peng Ma <peng.ma@nxp.com>, Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH -next] dmaengine: fsl-dpaa2-qdma: Remove unnecessary
 local variables in DPDMAI_CMD_CREATE macro
Message-ID: <20191102163319.GD2695@vkoul-mobl.Dlink>
References: <20191022171648.37732-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022171648.37732-1-natechancellor@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-10-19, 10:16, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/dma/fsl-dpaa2-qdma/dpdmai.c:148:25: warning: variable 'cfg' is
> uninitialized when used within its own initialization [-Wuninitialized]
>         DPDMAI_CMD_CREATE(cmd, cfg);
>         ~~~~~~~~~~~~~~~~~~~~~~~^~~~
> drivers/dma/fsl-dpaa2-qdma/dpdmai.c:42:24: note: expanded from macro
> 'DPDMAI_CMD_CREATE'
>         typeof(_cfg) (cfg) = (_cfg); \
>                       ~~~     ^~~~
> 1 warning generated.
> 
> Looking at the preprocessed source, we can see that this is true.
> 
> int dpdmai_create(struct fsl_mc_io *mc_io, u32 cmd_flags,
>                   const struct dpdmai_cfg *cfg, u16 *token)
> {
>         struct fsl_mc_command cmd = { 0 };
>         int err;
> 
>         cmd.header = mc_encode_cmd_header((((0x90E) << 4) | 0), cmd_flags, 0);
>         do {
>                 typeof(cmd)(cmd) = (cmd);
>                 typeof(cfg)(cfg) = (cfg);
>                 ((cmd).params[0] |= mc_enc((8), (8), (cfg)->priorities[0]));
>                 ((cmd).params[0] |= mc_enc((16), (8), (cfg)->priorities[1]));
>         } while (0);
> 
> I cannot see a good reason to create another version of cfg when the
> parameter one will work perfectly fine and cmd can just be used as is.
> Remove them to fix this warning.

Applied, thanks

-- 
~Vinod
