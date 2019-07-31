Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1F37C5ED
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jul 2019 17:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfGaPS6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Jul 2019 11:18:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbfGaPSz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:55 -0400
Received: from localhost (unknown [171.76.116.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2027B208E3;
        Wed, 31 Jul 2019 15:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564586334;
        bh=ABb5W23/d/0WsnxPRf5eaP4RdoSwy6OHVPgcDaHsNaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XH3BFnnsRE+OgJsxwNqARW7fTsBtNH2yQpopWn6siVPYzAzBDq+7uFY6KoPBVbRCT
         YHmPtpTgA38nysnqFwRJ6KWG0Svm/VUTr0bwYKICor42Iwr+i301RdzpRomJ6pYOrV
         yZ8JzJ7ab66y89PNCZjyXoiKafHcxbM1dKNLJpOA=
Date:   Wed, 31 Jul 2019 20:47:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH RESEND] dmaengine: tegra210-adma: Don't program FIFO
 threshold
Message-ID: <20190731151741.GU12733@vkoul-mobl.Dlink>
References: <20190731101639.22755-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731101639.22755-1-jonathanh@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-07-19, 11:16, Jon Hunter wrote:
> From: Jonathan Hunter <jonathanh@nvidia.com>
> 
> The Tegra210 ADMA supports two modes for transferring data to a FIFO
> which are ...
> 
> 1. Transfer data to/from the FIFO as soon as a single burst can be
>    transferred.
> 2. Transfer data to/from the FIFO based upon FIFO thresholds, where
>    the FIFO threshold is specified in terms on multiple bursts.
> 
> Currently, the ADMA driver programs the FIFO threshold values in the
> FIFO_CTRL register, but never enables the transfer mode that uses
> these threshold values. Given that these have never been used so far,
> simplify the ADMA driver by removing the programming of these threshold
> values.

Applied, thanks

-- 
~Vinod
