Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3153347213E
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 07:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhLMGwV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 01:52:21 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45224 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhLMGwV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 01:52:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B5F64CE0DB6
        for <dmaengine@vger.kernel.org>; Mon, 13 Dec 2021 06:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129EDC00446;
        Mon, 13 Dec 2021 06:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639378337;
        bh=G05Agxkyfjy6KiGKcV/J9HGRw/CiqLHHcS3nXjWYnpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9mUqKaLlVc4TOx3EboOqEbbwmGTC2UVqZoEPYdPs5yM6MCxmiNRNJmsmVr8jEd9l
         cMDOo0mpaZqJLlyaFOaH1SD04pU9rlray2pG3KZFNnKrpMtFj/igjpIrf/jh+WQP8M
         hGp6gCYZIKyMLmgEzqiWPzMU8j5a7uqssTNDRyThREGYP6OF/Monm+a8HIialyBQkS
         AJBIL3hLWtTiv7aDMOG/kqpIA6Q4Lxdsxv58SIMPRKb1ypEravpNn4xHGfzMffYyvD
         ihWbPzYdsWQsqSl3Xb4v34Un9MdvQmNWyKUpi0PMF/+WnSj5nokX3KruGyCcY9E7Oe
         6jEvHis+IHGoQ==
Date:   Mon, 13 Dec 2021 12:22:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: set defaults for wq configs
Message-ID: <YbbtnoU12xamU6i1@matsya>
References: <163528473483.3926048.7950067926287180976.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163528473483.3926048.7950067926287180976.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-10-21, 14:45, Dave Jiang wrote:
> Add default values for wq size, max_xfer_size and max_batch_size. These
> values should provide a general guidance for the wq configuration when
> the user does not specify any specific values.

Applied, thanks

-- 
~Vinod
