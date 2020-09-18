Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB3526F66E
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 09:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgIRHDE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Sep 2020 03:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgIRHDE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 18 Sep 2020 03:03:04 -0400
Received: from localhost (unknown [136.185.124.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 497A721534;
        Fri, 18 Sep 2020 07:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600412584;
        bh=7dCO+MgzUJBfhAuxZ7aK0yShgDW6KFq+EN2MVT6l+lM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vdyWkWcjuyPX1kQxOIZE6DsYreOwnYJYVh2KRLhmSIVa1U4QOWmiipjDEiLgaiH6w
         c9Gpai48JfitOAosliHC3HlP0vC7PKNKIDEMKAaM3Z40Ga1aT+6j30kDnB8fUzNak5
         1TcNES3E9w8grkVlnPHOM0hFR9F/t8RYBRFj/WRE=
Date:   Fri, 18 Sep 2020 12:33:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: mediatek: simplify the return
 expression of mtk_uart_apdma_runtime_resume()
Message-ID: <20200918070300.GH2968@vkoul-mobl>
References: <20200915032622.1772309-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915032622.1772309-1-liushixin2@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-09-20, 11:26, Liu Shixin wrote:
> Simplify the return expression.
> 

Applied, thanks

-- 
~Vinod
