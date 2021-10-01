Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B288441ECA8
	for <lists+dmaengine@lfdr.de>; Fri,  1 Oct 2021 13:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354145AbhJAL7k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Oct 2021 07:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhJAL7k (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 1 Oct 2021 07:59:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 868EF61A6F;
        Fri,  1 Oct 2021 11:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633089476;
        bh=Vjg+dy9vAItiQLb0Oo9y0H4LZgIlPk1bRan5HVpoMuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IitrVAZnOU4Uo+Ex9E30ZIidfe6/9XfmwIeYentyjgXVa+pusXNob5qilym+i5fLk
         zD1180QRkSemZpWEZhOYzBb8PCF4fNtCKV3MMqLi+GHgTwgAkD2Ycn1ClslVu58M88
         +oo5JaY1742r8E8UzGME4tL+D/44FzeBPufS4veMDHGDGPiVZQOpKTHIBwjKcKSFqq
         ZPDWQE1IPkWlSyiLa7vJBHy+FO4Mf3yaR3KXVQMiVwcse96GLsh2f+5WSQZWlWqZdR
         zUESFd8AYy9cq+gu2SjE25hFJI+PAdxNCKRMOL8wZEqlPnUXh4H5BIOEvQV3qrD5E6
         0iIApfM2vAZGA==
Date:   Fri, 1 Oct 2021 17:27:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: stm32-mdma: Use struct_size() helper in
 devm_kzalloc()
Message-ID: <YVb3wADDQuoynu1W@matsya>
References: <20210929222922.GA357509@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929222922.GA357509@embeddedor>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-09-21, 17:29, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worse scenario, could lead to heap overflows.

Applied, thanks

-- 
~Vinod
