Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FEE25BB3D
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 08:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgICGvu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 02:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgICGvt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Sep 2020 02:51:49 -0400
Received: from localhost (unknown [122.171.179.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3D3C2071B;
        Thu,  3 Sep 2020 06:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599115909;
        bh=zFFH5ijjXx/9/g9VnmjQZzmuX1E42UObUA1luskXeVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mk2etaz+5KErHJgg8iv9HxYh97mxJCiyFiXckORgFiV1I9wrwUWey3RuE+WQEA8n7
         HKG6wf8vrifwJ+Semcv2CbnKr0nH1PmsSrKFEZgRJE1JZEQAjlCjdwNTixibUGnnJk
         2+zM5AHSgsgXAQN1WZ6OAfWpb8/vvwDVdTbNGnlw=
Date:   Thu, 3 Sep 2020 12:21:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH] dmaengine: Mark dma_request_slave_channel() deprecated
Message-ID: <20200903065145.GF2639@vkoul-mobl>
References: <20200828110507.22407-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828110507.22407-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-08-20, 14:05, Peter Ujfalusi wrote:
> New drivers should use dma_request_chan() instead
> dma_request_slave_channel()
> 
> dma_request_slave_channel() is a simple wrapper for dma_request_chan()
> eating up the error code for channel request failure and makes deferred
> probing impossible.
> 
> Move the dma_request_slave_channel() into the header as inline function,
> mark it as deprecated.

Applied, thanks

-- 
~Vinod
