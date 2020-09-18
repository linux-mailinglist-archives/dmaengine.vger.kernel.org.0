Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3DA26F66C
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 09:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIRHBQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Sep 2020 03:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgIRHA5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 18 Sep 2020 03:00:57 -0400
Received: from localhost (unknown [136.185.124.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20631204FD;
        Fri, 18 Sep 2020 07:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600412441;
        bh=DR/d94USmid17D/5Ui/gy2mcnKyjZ3cMMfW53ylxKBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qwuPG4EDI/9DviJLgbMVKsWyM3kiAE5+LUJANRbx0sUzDcaMrWpqR6lcvb7Nu0Nn+
         HbZFaP5Kc+RA6B+AaT2kouYG4fkQWd8ZtrO8TuQNNiaOJvY7ZbZzjUpZUTVXRSylMy
         zLI8OE0oIAPIVIvNNOw0KF1BZ/kfENmA+gXQPhuY=
Date:   Fri, 18 Sep 2020 12:30:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org, Green Wan <green.wan@sifive.com>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] dmaengine: sf-pdma: remove unused 'desc'
Message-ID: <20200918070037.GG2968@vkoul-mobl>
References: <20200914055302.22962-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914055302.22962-1-vkoul@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-09-20, 11:23, Vinod Koul wrote:
> 'desc' variable is now defined but not used in sf_pdma_donebh_tasklet(),
> causing this warning:
> 
> drivers/dma/sf-pdma/sf-pdma.c: In function 'sf_pdma_donebh_tasklet':
> drivers/dma/sf-pdma/sf-pdma.c:287:23: warning: unused variable 'desc' [-Wunused-variable]
> 
> Remove this unused variable

Applied, thanks

-- 
~Vinod
