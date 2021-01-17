Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152F62F9129
	for <lists+dmaengine@lfdr.de>; Sun, 17 Jan 2021 07:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbhAQGww (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 17 Jan 2021 01:52:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbhAQGws (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 17 Jan 2021 01:52:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F015225AB;
        Sun, 17 Jan 2021 06:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610866327;
        bh=SaG1+NxYeVj8PNT7jqzAPByoMosUBcfmP9G9jGJYYn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f092Wvp9gxHyKmMitaYxOe4NAs4x3nBhUbINd+reGrIOqZQBDGStfy0AG0p09zg6g
         UcDdQG1iynFRJvWgPcxM/9DRnU7AJgl2iqEw9knTClrEXVPvdpYhSpT+l+rPlzta2q
         Od/VQXj5W45Buh0WZLImnkV4wAKPLJke/2rUrBXxHBtQpCqdES64rGR1OCwek9Pkni
         KJj6tuMfN/+RQRyurM8N3Me8D0TJWmRp5dkYB1b2hN6gF6tcq1U/f6b1ZTmVaU13qG
         B9KFgXpOnMIw0yU4onpcYD1chxfHPiq24+m5fx+YTYFlPbIqkkgzrwElXGA0IdrKC+
         UPI5oAxQkcjYw==
Date:   Sun, 17 Jan 2021 12:22:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Srinijia Kambham <srinija.kambham@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: set DMA channel to be private
Message-ID: <20210117065202.GO2771@vkoul-mobl>
References: <161074758743.2184057.3388557138816350980.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161074758743.2184057.3388557138816350980.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-01-21, 14:53, Dave Jiang wrote:
> Add DMA_PRIVATE attribute flag to idxd DMA channels. The dedicated WQs are
> expected to be used by a single client and not shared. While doing NTB
> testing this mistake was discovered, which prevented ntb_transport from
> requesting DSA wqs as DMA channels via dma_request_channel().

Applied, thanks

-- 
~Vinod
