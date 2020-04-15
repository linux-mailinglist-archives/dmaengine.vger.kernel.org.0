Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5924E1AAD9E
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 18:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415204AbgDOQQK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 12:16:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415030AbgDOQQI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Apr 2020 12:16:08 -0400
Received: from localhost (unknown [106.201.106.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37523206F9;
        Wed, 15 Apr 2020 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586967368;
        bh=QB4mrJlnOHdWx6xcWQ3bgKLDC0djAowm6CN2swhUgAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CUA5ezWyshgzOZhu8futGHv425Kc4sK7tph+I65jlqCAnNOBN27id/xh4f9c0+iTk
         cC427/zhcBlwWTuupq6M3+4ovf2dUx+vCFCLk0xaEwBL2+BKV8CBh3NCehpKMKxD4n
         2EQKEchO5L8JGeI9gcvFZ5LsWbke8LwC6kX7BRnI=
Date:   Wed, 15 Apr 2020 21:45:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Maciej Grochowski <maciek.grochowski@gmail.com>
Cc:     dan.j.williams@intel.com,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/linux/dmaengine: Typos fixes in API documentation
Message-ID: <20200415161559.GZ72691@vkoul-mobl>
References: <20200414041703.6661-1-maciek.grochowski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414041703.6661-1-maciek.grochowski@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-04-20, 00:17, Maciej Grochowski wrote:
> From: Maciej Grochowski <maciej.grochowski@pm.me>

Applied, thanks

-- 
~Vinod
