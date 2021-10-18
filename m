Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02CE430E7C
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 06:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbhJREF1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 00:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhJREF1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Oct 2021 00:05:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 810CB61054;
        Mon, 18 Oct 2021 04:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634529796;
        bh=jewLg1cgisrfTHaez3TAQYJf07QGaNNGftflKGHgUGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGVN/grjDPyWMB8BMeucEQitIByWJ/180kHdJBvGaMWDaZWpdmU7dhNTMhUYXXgkQ
         UnHy/lSvWDd312Ad8ebQUrTMG0il/ISbOKnxa5sG8Rb6Jc7Ghj0lv7RLs+tZPIgpaF
         TBy7wgH0VdANwQD/KsDZgF5iD4Xevw0fpwokEsGJTKob/7oKbcghUfvz0D9b/pNTyC
         5L9M4kkPyK48XnEoKcXelsgaMS+ygqfX7zynor/q2t6TxWE/SAGZwAj/xTU3JqCRHC
         UqBptYtr3wLofhdEx93MCQLcicB/DMeU1F0JF9ru3NcamY9NjPesI7QEhC77b3qHiy
         imVCAq/S0ZGWQ==
Date:   Mon, 18 Oct 2021 09:33:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     jonathanh@nvidia.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/3] Few Tegra210 ADMA fixes
Message-ID: <YWzyAKgxUua0fR5/@matsya>
References: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-09-21, 21:37, Sameer Pujar wrote:
> Following are the fixes in the series:
>  - Couple of minor fixes (non functional fixes)
> 
>  - ADMA FIFO size fix: The slave ADMAIF channels have different default
>    FIFO sizes (ADMAIF FIFO is actually a ring buffer and it is divided
>    amongst all available channels). As per HW recommendation the sizes
>    should match with the corresponding ADMA channels to which ADMAIF
>    channel is mapped to at runtime. Thus program ADMA channel FIFO sizes
>    accordingly. Otherwise FIFO corruption is observed.

The patches are semantically and doing the right thing by ordering. But
that does not really make it a 'fix' imo. I am applying these to next

Thanks and apologies for delay

-- 
~Vinod
