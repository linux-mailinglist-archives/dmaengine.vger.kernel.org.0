Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9370395464
	for <lists+dmaengine@lfdr.de>; Mon, 31 May 2021 06:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhEaETU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 May 2021 00:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhEaETT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 May 2021 00:19:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 649226120E;
        Mon, 31 May 2021 04:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622434660;
        bh=/66UekHtYsNbjmVcZiKckD/0YRjNQl/NXsv9GwKkpmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1iKGI2X/wzNMu6RuJOToWwN/6BG+UfXXMINpHGEcFblPzB5FYkvCCrpJKXU4m7mu
         To85AaDPgV5HBlywiFb40p3EzIuwPYwXccgcdK4p8CNIhAxTBQf2I6K2Bgf7rJr5gm
         S6Jiek5jKy9bAplIhdB4xBHV3jLQJOXt5wxu76AGLVHmL+gBJQGLkJxBB3ZNc6+1Bl
         yqboh4BsHWhTlqt2+H3lWeB5x+XXb2ZBDtuJW5/gBC9MARK5dREO3K4otQMun8vbhT
         9zyw8BN1M+8kB6T/o0EYA62tnTX6bSjF51BmVhMtOzhrYWXgP6KUzUOWCzOPu/DIE3
         XMj0oRD/MBVRQ==
Date:   Mon, 31 May 2021 09:47:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org
Subject: Re: [PATCH -next] dmaengine: stedma40: add missing iounmap() on
 error in d40_probe()
Message-ID: <YLRjYJuAod0JcUiI@vkoul-mobl.Dlink>
References: <20210518141108.1324127-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518141108.1324127-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-05-21, 22:11, Yang Yingliang wrote:
> Add the missing iounmap() before return from d40_probe()
> in the error handling case.

Applied, thanks

-- 
~Vinod
