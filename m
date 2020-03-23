Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBCB918EFC1
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2020 07:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgCWGVc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Mar 2020 02:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgCWGVc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Mar 2020 02:21:32 -0400
Received: from localhost (unknown [171.76.96.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F348220714;
        Mon, 23 Mar 2020 06:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584944491;
        bh=nwYvUT6fexgXAVeMCR+yqs2u6NvtJAyuwCaqcKagjLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbiySSaCSlKwEeE3846W6e7DvF27amo8+3rA76cUOcBE1xP8YBgE9XFZL1RFfRE3p
         R3yPsKfRakplh3RH4F229ipmlw3Dz9oLUtMd/GKvUfHrTXln3QiUQp5aKpVRk52RNz
         iPBTRElCPpJBqFaHNGaT4ahwfgULXcQKM2HRbrzQ=
Date:   Mon, 23 Mar 2020 11:51:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.j.williams@intel.com, peter.ujfalusi@ti.com,
        grygorii.strashko@ti.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH V2] dmaengine: ti: k3-udma-glue: Fix an error handling
 path in 'k3_udma_glue_cfg_rx_flow()'
Message-ID: <20200323062127.GF72691@vkoul-mobl>
References: <20200318191209.1267-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318191209.1267-1-christophe.jaillet@wanadoo.fr>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-03-20, 20:12, Christophe JAILLET wrote:
> All but one error handling paths in the 'k3_udma_glue_cfg_rx_flow()'
> function 'goto err' and call 'k3_udma_glue_release_rx_flow()'.
> 
> This not correct because this function has a 'channel->flows_ready--;' at
> the end, but 'flows_ready' has not been incremented here, when we branch to
> the error handling path.
> 
> In order to keep a correct value in 'flows_ready', un-roll
> 'k3_udma_glue_release_rx_flow()', simplify it, add some labels and branch
> at the correct places when an error is detected.
> 
> Doing so, we also NULLify 'flow->udma_rflow' in a path that was lacking it.

Applied, thanks

-- 
~Vinod
