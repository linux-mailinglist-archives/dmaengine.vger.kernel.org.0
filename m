Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8B73D880D
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 08:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbhG1Ggj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 02:36:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233670AbhG1Ggi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 02:36:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00DA3601FF;
        Wed, 28 Jul 2021 06:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627454197;
        bh=Hbb4plRo2egXjbxS1EK3zkp2wf78Bd/+AuCOX5PPZTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oiEzzqQY7+nHE8rNu1h6zfhQTmTsvyKm+Fu/lFveiwDzoFlTYXGiGvzCMYBrF4MgR
         RvLBZbmkztM179bxrtEKilofYVA5TgDic8xLnJcmbCmLLGGDRUEXDvCpBkgjT/SEEA
         E7KvldfcwrVXf1LQEhrylR1Do4WG4EdUcHkQ6Wx2m6fP16ZhYGYlZCqVfyA9rxWuil
         RalAII3kwGhljBxTIQ6Y25opSgyJDj8Fz8WBFUmwFlo7LYKEjJkkutR9sggqoZkD3h
         YItfO8edbX9b7raaqGYG64XdDykhZab640OxW4VcGFs1hw0M0yHoP31BGZsZmCxXte
         2q6Kkt/cBgWsQ==
Date:   Wed, 28 Jul 2021 12:06:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, yangjihong1@huawei.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next v2] dmaengine: zynqmp_dma: Use list_move_tail
 instead of list_del/list_add_tail
Message-ID: <YQD68bP1E/yQmbGi@matsya>
References: <20210609071349.1336853-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609071349.1336853-1-libaokun1@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-06-21, 15:13, Baokun Li wrote:
> Using list_move_tail() instead of list_del() + list_add_tail().

Applied, thanks

-- 
~Vinod
