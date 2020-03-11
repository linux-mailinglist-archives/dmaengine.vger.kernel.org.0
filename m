Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B68181524
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2020 10:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgCKJjW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Mar 2020 05:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKJjW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Mar 2020 05:39:22 -0400
Received: from localhost (unknown [106.201.105.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA52D2146E;
        Wed, 11 Mar 2020 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583919561;
        bh=/LRiph60URpGfe2dBdVz+L3xl44yNut/zMZ2qYpXMrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wyIS9TPnhw3y4zEgP+xph0aC6+rpytI/DiTrR3k67D5Qxlf17vU+G7Q5CJejHvi1M
         4CJAYL3IoWdz60oLQ30y0/LJ1aphRqqqje4wzJzTSigruImLOcT0/RblM8sKIgfZYs
         SHMYuseufsYyYRXEvmEuGzXor/UIh/cfMhiA6tzw=
Date:   Wed, 11 Mar 2020 15:09:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: reflect shadow copy of traffic class
 programming
Message-ID: <20200311093916.GP4885@vkoul-mobl>
References: <158386263076.10898.4586509576813094559.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158386263076.10898.4586509576813094559.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-03-20, 10:50, Dave Jiang wrote:
> The traffic class are set to -1 at initialization until the user programs
> them. If the user choose not to, the driver will program appropriate
> defaults. The driver also needs to update the shadowed copies of the values
> after doing the programming.

Applied, thanks

-- 
~Vinod
