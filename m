Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0ADBF47
	for <lists+dmaengine@lfdr.de>; Fri, 18 Oct 2019 10:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504707AbfJRIDA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Oct 2019 04:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbfJRIDA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 18 Oct 2019 04:03:00 -0400
Received: from localhost (unknown [106.200.243.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 333362089C;
        Fri, 18 Oct 2019 08:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571385780;
        bh=H2AnPxP61DdUfGRZbiKUE6pyvKjTw7ttUbZaaO0THK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2yb586hMDXEfwkIlvEuj++GZhMRqXLx3ZdvUfWus68wwjWYsZ+0Z95CifSzhGI+N
         ueu6LuewQu/PjpAS/hld8Cw7yfkjOgPb0NLbzPxpe/xgv8N5Fl5LaWhyiD8Rn8hxK0
         KbjBksjjcFs2kbK9WIkmqNS7+zvX4ENh6cQO1wRA=
Date:   Fri, 18 Oct 2019 13:32:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     jassisinghbrar@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, masami.hiramatsu@linaro.org,
        orito.takao@socionext.com, Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v4 0/2] Add support for AHB DMA controller on Milbeaut
 series
Message-ID: <20191018080256.GR2654@vkoul-mobl>
References: <20191015033301.14791-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015033301.14791-1-jassisinghbrar@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-10-19, 22:33, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> The following series adds AHB DMA (HDMAC) controller support on Milbeaut series.
> This controller is capable of Mem<->MEM and DEV<->MEM transfer. But only DEV<->MEM
> is currently supported.

Applied, thanks

-- 
~Vinod
