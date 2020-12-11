Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A39E2D76B8
	for <lists+dmaengine@lfdr.de>; Fri, 11 Dec 2020 14:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgLKNiQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Dec 2020 08:38:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733208AbgLKNho (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Dec 2020 08:37:44 -0500
Date:   Fri, 11 Dec 2020 19:06:59 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607693823;
        bh=awziwZMQnKm3HUEwINQikBW2m8m7Wd6pkNVMAa6kxOs=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=kg4Y00OHMOZqZBgM6UghxN8p6L1jIzrv801aC3G8O5AIjBeBL6tA/VWy4wVk/3ELn
         p6v5CFj4jpqRjm3wYgi+H6id5sX5tOckCZlXy5SiGxhKmMLyiYwWD7PfoEQGyIz3wV
         4o8ZRtLseEWDhPoQI9hUR82utZTWynFZiGVOQHMCgx1bnwBO3AF0y9Zk8Fj3POZqBE
         kCNMMyNXsxRSrwgFsPL7juvdg1zdzKNl3HtuGd7FjPr7st1fuJ0FjGbWm0kwPRjhpm
         KbU+gJPE4E4cYiKCqEuRB7m80GRYTKZCcSAnJ1VgVLb44m2auzvfqfnvV/jk/NDhyx
         qveoFFzgPC0nw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: Fix ADM driver kerneldoc markup
Message-ID: <20201211133659.GU8403@vkoul-mobl>
References: <20201126184602.GA1008@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126184602.GA1008@earth.li>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-11-20, 18:46, Jonathan McDowell wrote:
> Update the kerneldoc function headers to fix build warnings:
> 
> drivers/dma/qcom/qcom_adm.c:180: warning: Function parameter or member 'chan' not described in 'adm_free_chan'
> drivers/dma/qcom/qcom_adm.c:190: warning: Function parameter or member 'burst' not described in 'adm_get_blksize'
> drivers/dma/qcom/qcom_adm.c:466: warning: Function parameter or member 'chan' not described in 'adm_terminate_all'
> drivers/dma/qcom/qcom_adm.c:466: warning: Excess function parameter 'achan' description in 'adm_terminate_all'
> drivers/dma/qcom/qcom_adm.c:503: warning: Function parameter or member 'achan' not described in 'adm_start_dma'

Applied, thanks

-- 
~Vinod
