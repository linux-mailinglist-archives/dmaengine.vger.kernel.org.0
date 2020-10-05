Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD15282F9E
	for <lists+dmaengine@lfdr.de>; Mon,  5 Oct 2020 06:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgJEE3j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Oct 2020 00:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgJEE3i (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 5 Oct 2020 00:29:38 -0400
Received: from localhost (unknown [171.61.67.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1F092080C;
        Mon,  5 Oct 2020 04:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601872178;
        bh=TTebaQ0BqbFl5Dz2cFAe1np5j2lZu7ai/obAxyVWTko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfcIA3mjxwbCuClZAjwwCN28GhRML6d4KIr/gOejWYmLxZDVJSVWxKemFZbMRWWmF
         0jjhMPQZuBMBcmGgYQvzGjBYn2p5QlooBrFz8P9KYy21pRbkg+ThLFt96VShhxVFrT
         M8B3fI5+1ny1IsOu4QR6eIWEGijg+qmCGdvVVoOY=
Date:   Mon, 5 Oct 2020 09:59:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Romain Perier <romain.perier@gmail.com>,
        Allen Pais <allen.lkml@gmail.com>
Subject: Re: [PATCH] dmaengine: fsl: remove bad channel update
Message-ID: <20201005042934.GD2968@vkoul-mobl>
References: <20201001164740.178977-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001164740.178977-1-vkoul@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-10-20, 22:17, Vinod Koul wrote:
> Commit 59cd818763e8 ("dmaengine: fsl: convert tasklets to use new
> tasklet_setup() API") broke this driver by not removing the old channel
> update method.
> 
> Fix this by remove the offending call as channel is queried from
> tasklet structure.

Applied, thanks

-- 
~Vinod
