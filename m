Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10ED7438F9E
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhJYGnF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhJYGnF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 02:43:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 894CD60EE3;
        Mon, 25 Oct 2021 06:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635144043;
        bh=HmciNwUjNQsLVm5p4hbdYC9XYTU4foPEhTLhvcaReqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5EA80IBy8bXgoaSDLynZFrfs46O8yaDIdJG9aY8CZKYucM/JW0UEA3lmxw6PznaI
         Otz6FSAhHdXym/19CwFBBTj/Loaeqpq43R1v0YkTmYwDWyjnMiwQw4b6otHEtlLPMp
         M383Igli+c79PKd6le48WQH3kJIL2JkC8M8G4eQIK/sVsNoPliKan6rxCart+C3mGa
         t2FurW56m5B1N7CXQ6zHv69nP7wS0CTsM2zyYzb1ullk05Px6kJbjIzChShU1nGryg
         QwUAbcEy1wbvi5rD5sX/25gW/+fzzmzCYYTrTifJCIZC7DAYwjMpf1VhydI8Z5U0+R
         TG5Z5/mv0I+fw==
Date:   Mon, 25 Oct 2021 12:10:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sa11x0: Make use of the helper macro
 SET_NOIRQ_SYSTEM_SLEEP_PM_OPS()
Message-ID: <YXZRZx/LwseoEXuT@matsya>
References: <20210828090117.1814-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828090117.1814-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-08-21, 17:01, Cai Huoqing wrote:
> Use the helper macro SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() instead of the
> verbose operators ".suspend_noirq /.resume_noirq/.freeze_noirq/
> .thaw_noirq/.poweroff_noirq/.restore_noirq", because the
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() is a nice helper macro that could
> be brought in to make code a little clearer, a little more concise.

Applied, thanks

-- 
~Vinod
