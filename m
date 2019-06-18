Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A5D4987C
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2019 06:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfFRE4W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 00:56:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfFRE4V (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 Jun 2019 00:56:21 -0400
Received: from localhost (unknown [122.178.226.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 639A12085A;
        Tue, 18 Jun 2019 04:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560833781;
        bh=p/1WgzjyDGLLUL8w56446SHwaaWDO2rQKvXQxt/cSOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLARzcNdUkEGgZ6QGRCy1f8/hT1C52+XCSQoCJtQofiim3IBDE61VXQboKn7OSnQB
         kl9r5cEauFP3BdsUQkFjXA9tz42XRh9QCI6hydwe+7mFnSxAy39pQskRuJfSc+Eo9X
         tHV3NswGQd/50ocwL2XpOHmRGf5i66vfC7zJt4LE=
Date:   Tue, 18 Jun 2019 10:23:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom-bam: fix circular buffer handling
Message-ID: <20190618045312.GK2962@vkoul-mobl>
References: <20190614142012.31384-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614142012.31384-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-06-19, 15:20, Srinivas Kandagatla wrote:
> For some reason arguments to most of the circular buffers
> macros are used in reverse, tail is used for head and vice versa.
> 
> This leads to bam thinking that there is an extra descriptor at the
> end and leading to retransmitting descriptor which was not scheduled
> by any driver. This happens after MAX_DESCRIPTORS (4096) are scheduled
> and done, so most of the drivers would not notice this, unless they are
> heavily using bam dma. Originally found this issue while testing
> SoundWire over SlimBus on DB845c which uses DMA very heavily for
> read/writes.

Applied and copied stable, thanks
-- 
~Vinod
