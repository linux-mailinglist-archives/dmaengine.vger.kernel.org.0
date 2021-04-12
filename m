Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F309735C57F
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 13:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhDLLoj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 07:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237792AbhDLLoj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Apr 2021 07:44:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75E2B6102A;
        Mon, 12 Apr 2021 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618227861;
        bh=C0Zz1X5LRso6hZ9yckSPSWmRyIpm21I8AUMnjr62TjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOqPFDhbRnC0vH6vKc/t3yks+PdGJ3pij8OTRJerAGDHQUtx0FZKOtzPqrdrNb8U8
         D1Pt3vs5xZmSzoeh3pU2VHWjs1C8NlHGSSoPjP8ZdcwxilLiy34V+0jbIoH1JgTjaF
         1cMiAQ3mjMWT8m2i6ttwr1eYnSLz5p1PGG2BcUZnZZwYpxY1xHhxo0spfMp7D/vb5G
         qxADghAIOve14LtiCplWehBo0MlbjJ0WWdFoA1+i6JVaX0Ro7CAncld1Dgi3caj5lM
         rZ1+GBVNNtQVfN9OpY7iKEaHacTQBICo1gqHh7ssJo24gGEyvkL5jY2UhgUmQFtAgu
         TEW9IyLGOsZPg==
Date:   Mon, 12 Apr 2021 17:14:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     okaya@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom_hidma: remove unused code
Message-ID: <YHQykQa1fyxcpGJl@vkoul-mobl.Dlink>
References: <1617270816-36400-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617270816-36400-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-04-21, 17:53, Jiapeng Chong wrote:
> Fix the following clang warning:
> 
> drivers/dma/qcom/hidma.c:94:20: warning: unused function 'to_hidma_desc'
> [-Wunused-function].

Applied, thanks

-- 
~Vinod
