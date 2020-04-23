Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087801B5566
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2020 09:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgDWHPW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Apr 2020 03:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgDWHPW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Apr 2020 03:15:22 -0400
Received: from localhost (unknown [49.207.59.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF1120736;
        Thu, 23 Apr 2020 07:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587626121;
        bh=1519+u/O1psy9Ki9fQPIu3CaRE2VyNu6zy8FfJD5RU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7V/BsFGGeTdHIHuV8rAf0BtwzyRVEJzfD19lnFRg+gO1BaG4tErnLAwAy0o0abpl
         w7wOPPxISIpMndBRWVGDpWAD+NdWQ2yL1UhJsc/vHulpZFlMOH0z6/swW60XWwud8w
         p6HtcolqchHu1Ifcxbw8+ZO9NB48VGYW9cXI1oKM=
Date:   Thu, 23 Apr 2020 12:45:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] dmaengine: mmp_tdma: Log an error if channel is in
 wrong state
Message-ID: <20200423071517.GA72691@vkoul-mobl>
References: <20200419164912.670973-1-lkundrak@v3.sk>
 <20200419164912.670973-6-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419164912.670973-6-lkundrak@v3.sk>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-04-20, 18:49, Lubomir Rintel wrote:
> Let's log an error if the channel can't be prepared because it is in an
> unexpected state.

Applied, thanks

-- 
~Vinod
