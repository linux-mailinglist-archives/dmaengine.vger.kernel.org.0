Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14302862F5
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2019 15:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389802AbfHHNVH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Aug 2019 09:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389742AbfHHNVG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Aug 2019 09:21:06 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86F822184E;
        Thu,  8 Aug 2019 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565270465;
        bh=pKLQbY8ZBQyzxEsdTm5FHa/kLb/f0AIFzt4rPEN/W5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KRl8J3LnLXldScl+++Xg2vjbhZtj4029ePX4xes/Vly+TtN2kTo1GxEDNnXb6O6GB
         60yq5sLdsge4xRBy546bpBFqJi4uWWhVDllr28dAGjIK4ctMdQUBpRgNA5dbP5pZR9
         Lnp+RtSw2HsjmoD86qxTCJ0GWym2nwDtmWmhB9no=
Date:   Thu, 8 Aug 2019 18:49:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl330: use the same attributes when freeing
 pl330->mcode_cpu
Message-ID: <20190808131953.GY12733@vkoul-mobl.Dlink>
References: <20190726105947.25342-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726105947.25342-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-07-19, 18:59, Fuqian Huang wrote:
> In function dmac_alloc_resources(), pl330->mcode_cpu is allocated using
> dma_alloc_attrs() but freed with dma_free_coherent().
> Use the correct dma_free_attrs() function to free pl330->mcode_cpu.

Applied, thanks

-- 
~Vinod
