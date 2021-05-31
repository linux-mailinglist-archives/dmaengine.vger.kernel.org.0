Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFCC395460
	for <lists+dmaengine@lfdr.de>; Mon, 31 May 2021 06:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhEaEST (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 May 2021 00:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhEaEST (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 May 2021 00:18:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16A4660FF0;
        Mon, 31 May 2021 04:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622434599;
        bh=WrrNcXLSHGAxtkDaYh0sooXVPLQWlfDXREfK1i3H/5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSNt6RNUzsFj9QqGharZZ/5OVOErMq24NUVJUMA3vcK9ZQIk2vk0cRcPTSD5Kz5hq
         LqMKAcCXBv2DaYPPefCkKDSfEuqesQUAwmHpqZT0fzecNe1OlS9kBfWSjftgezJL7R
         X0hJwwvahOCLHA2euDqqvAdkNGO1Cg/QvEUXpU5fLNyfg5zgZBry5snamtdexI5qCM
         att6IndNwPQgS5b/rTtayW+ISR9zx3HSgSx7vDdL052nfx/Z+G7mrdVvdXKZCzzW98
         Yw6QeGZcNc4BLYOJ+anmQk3aEV7TDphNwmE2d5HALkwgJgjgxZWOl/xGNXw1JIsabD
         usLUFzXJfDAwQ==
Date:   Mon, 31 May 2021 09:46:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] dmaengine: fix PM reference leak
Message-ID: <YLRjJFN96NGHS9Rj@vkoul-mobl.Dlink>
References: <1621601902-33697-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621601902-33697-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-05-21, 20:58, Zou Wei wrote:
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.

Please rebase and submit per driver.. I have already applied few fixes
for this and rejected few

-- 
~Vinod
