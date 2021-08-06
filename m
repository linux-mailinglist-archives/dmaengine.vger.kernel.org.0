Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6109D3E2E42
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 18:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhHFQUa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 12:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhHFQU3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 12:20:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24258606A5;
        Fri,  6 Aug 2021 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628266814;
        bh=Wi9kvoI2TXYRcVTKblumNS0h1xgvusWiKZacZQ36kSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WURJO8woPWvtdxmNaMgAm7Xnf8D1HV3ZEskpbxlKBMUii2EiuG1NCPE0JbnnVBxo6
         2EgxdrSSZKJlaeEsWkMSc6PVQL0jn1gCoYNq3nXWvzqgEWP3kLJw/px5W1euipZzcK
         IEbltxIuriPMbQOrM7sP87tgLvXHFEQVmhuvawExCLW48VXOZBqoc0QUpv7x618SPN
         mhgZ/0eWOax95HQ3FUzrv1tG+IsH3gBxJ3umwy9W6tNdhUD1pBemK/4hh8LAQPH2OY
         njtClNB6/2CNvQ8p2TJRckKMxhBT0ZAB3hyrZ3KwHBw2XIjjVj8cO+XPBnjFN+i7ZD
         k05RsYeanz4cg==
Date:   Fri, 6 Aug 2021 21:50:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: remove interrupt flag for completion
 list spinlock
Message-ID: <YQ1hOTj1YErjHa+k@matsya>
References: <162826417450.3454650.3733188117742416238.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162826417450.3454650.3733188117742416238.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-08-21, 08:36, Dave Jiang wrote:
> The list lock is never acquired in interrupt context. Therefore there is no
> need to disable interrupts. Remove interrupt flags for lock operations.

Applied, thanks

-- 
~Vinod
