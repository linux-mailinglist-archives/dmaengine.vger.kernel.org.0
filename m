Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7412B7C0B
	for <lists+dmaengine@lfdr.de>; Wed, 18 Nov 2020 12:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgKRLBH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Nov 2020 06:01:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgKRLBH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Nov 2020 06:01:07 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C80F0221FB;
        Wed, 18 Nov 2020 11:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605697266;
        bh=87AtqepXzMfHjkY3wh4VeLjokOPuvtn3vK0COLEgwwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+gEUnDIrRyE6PH+eMT36gk1fs25r6HEI1O2Jr2WPSJN6HUKHHMyTwEQU5qQo7v0X
         VW+g9YZuUvt0QJNpRiRJGYj14wOyf4En3yZfw1cp/aQiYNMpGgdlfMiRkdOW0vulZW
         2g5sKjCHuViCxRDpxLRYN8JsDEz1GGgsCh/k2Rj4=
Date:   Wed, 18 Nov 2020 16:31:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     tiny.windzz@gmail.com, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [RESEND PATCH 04/19] dt-bindings: dma: allwinner,sun50i-a64-dma:
 Add A100 compatible
Message-ID: <20201118110102.GP50232@vkoul-mobl>
References: <cover.1604988979.git.frank@allwinnertech.com>
 <f15a18e9b8868e8853db1b5a3d1e411b0ac1c63a.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f15a18e9b8868e8853db1b5a3d1e411b0ac1c63a.1604988979.git.frank@allwinnertech.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-11-20, 14:26, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> Add a binding for A100's dma controller.

Applied, thanks

-- 
~Vinod
