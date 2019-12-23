Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7E8F129287
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 08:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfLWHvt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 02:51:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfLWHvs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Dec 2019 02:51:48 -0500
Received: from localhost (unknown [223.226.34.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EA992081E;
        Mon, 23 Dec 2019 07:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577087508;
        bh=oW2xxtRpv875kyNQhyqk3EKF34qFvDngT6PxUmGhQvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbNUWnyGzlxuavrEQZEjE+QUHOcaT4ZawKBP2KmIaMgFxiRvIm6LxqRbQDHzbkVMW
         N+Ygclbe51F/AwjA2e4Ps6keyWe+IjCnmimn09dsHtOvou3cQblRN05+vhoadF7NJ8
         oZV8LXmZRW7JhOb4NQUL1+MxVjAxgs4d9c5gSBP8=
Date:   Mon, 23 Dec 2019 13:21:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, ryan@edited.us,
        aserbinski@gmail.com, dmaengine@vger.kernel.org
Subject: Re: [PATCH] k3dma: Avoid null pointer traversal
Message-ID: <20191223075143.GC2536@vkoul-mobl>
References: <20191218190906.6641-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218190906.6641-1-john.stultz@linaro.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-12-19, 19:09, John Stultz wrote:
> In some cases we seem to submit two transactions in a row, which
> causes us to lose track of the first. If we then cancel the
> request, we may still get an interrupt, which traverses a null
> ds_run value.
> 
> So try to avoid starting a new transaction if the ds_run value
> is set.
> 
> While this patch avoids the null pointer crash, I've had some
> reports of the k3dma driver still getting confused, which
> suggests the ds_run/ds_done value handling still isn't quite
> right. However, I've not run into an issue recently with it
> so I think this patch is worth pushing upstream to avoid the
> crash.

Applied after adding dmaengine tag, thanks

-- 
~Vinod
