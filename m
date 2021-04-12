Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FC135C5E7
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbhDLMGe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 08:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240276AbhDLMGd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Apr 2021 08:06:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1936061278;
        Mon, 12 Apr 2021 12:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618229175;
        bh=mWviPQ2dve7cGDhWeT4B5Kc7Abe7lwqsdj7F6aqUZDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljRzg2MEzCe5F3BLTlxLdh9d4RsBmom/tbL2VoJPnOusDm8w4UYNAYGLWpt9hJPXa
         1dCfTHyJzd/FOdiGTiIoTBfVTRl2pFP2wyaigHMPn1PI8o8iVQhrqAAyYdR0Kwet8D
         5T6emcflxpRtmutLUB4xM9Hv38UELr4oOKaxIJ8TmJe11AoIjJ0fYnxuR+gg98wynC
         ZUOveIXbLMixsXKW3/nkrTKM1Plo+/kPGmVLRhvSpeZY0bM4G1tBLw1b/bVKvTHTN3
         S5sb6oV72NOfzhkaUQNb5X/QvoThfZ6u4kRGEp+J60Gt6FQDS9xLnB2vqYhWJ1HBOb
         ICiW0mvMeYovA==
Date:   Mon, 12 Apr 2021 17:36:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Hao Fang <fanghao11@huawei.com>
Cc:     mchehab@kernel.org, zhangfei.gao@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        prime.zeng@hisilicon.com
Subject: Re: [PATCH v2] dmaengine: k3dma: use the correct HiSilicon copyright
Message-ID: <YHQ3sjGWGSzkmj3W@vkoul-mobl.Dlink>
References: <1617277820-26971-1-git-send-email-fanghao11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617277820-26971-1-git-send-email-fanghao11@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-04-21, 19:50, Hao Fang wrote:
> s/Hisilicon/HiSilicon/g.
> It should use capital S, according to the official website.

Applied, thanks

-- 
~Vinod
