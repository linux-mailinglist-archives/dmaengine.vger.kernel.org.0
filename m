Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D111BA9CA
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2020 18:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgD0QIl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Apr 2020 12:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgD0QIl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Apr 2020 12:08:41 -0400
Received: from localhost (unknown [171.76.79.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBAAE205C9;
        Mon, 27 Apr 2020 16:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588003720;
        bh=Fht19I4+eezxy5GovEcjy5M55vqSuUXkK9sZ7M4yS2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wsy7jmWO9YhGIFy8m+h/Pj5RwoL2HpGQYSA2W2RNN6F4+zdNlshGddo6y/wM+ZGsm
         jRPfuiim4i5JJbZcWsyBAv+Fdh6HgVvjAkXUxWNtklBjxLKjV/RyEOfHxePjR3Z+Vt
         Bq28GQ86+r0qPVFxAS41PTQ0cdJ4K7m45IosxJm4=
Date:   Mon, 27 Apr 2020 21:38:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     okaya@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom_hidma: Simplify error handling path in
 hidma_probe
Message-ID: <20200427160836.GI56386@vkoul-mobl.Dlink>
References: <20200427111043.70218-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427111043.70218-1-christophe.jaillet@wanadoo.fr>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-04-20, 13:10, Christophe JAILLET wrote:
> There is no need to call 'hidma_debug_uninit()' in the error handling
> path. 'hidma_debug_init()' has not been called yet.

Applied, thanks

-- 
~Vinod
