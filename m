Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A903278593
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2019 08:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfG2G44 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jul 2019 02:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfG2G44 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Jul 2019 02:56:56 -0400
Received: from localhost (unknown [122.178.221.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAC4F20644;
        Mon, 29 Jul 2019 06:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564383415;
        bh=rGJ85mz88QVmDCPNKDHcH6k8oz7KHUKpQy5h6NPTsl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ow5gVlPy3aS5R/DqQ+abR1UfGSm6WuySTKCh5JoHEm0Yqww+F6rhPFmqh+A62NeJP
         YpawhH1q6/Vs1ZbvFbjPo8Gmeaq9EIlAaOE4U0kWVh2uP8iIJ//BM2Lp2vFz7SNThy
         km3v8xvOs/QOwp5486H+CNKIn0chK/90Tnfc/MrY=
Date:   Mon, 29 Jul 2019 12:25:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v1 1/2] dmaengine: stm32-dmamux: Switch to use
 device_property_count_u32()
Message-ID: <20190729065543.GJ12733@vkoul-mobl.Dlink>
References: <20190723190757.67351-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723190757.67351-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-07-19, 22:07, Andy Shevchenko wrote:
> Use use device_property_count_u32() directly, that makes code neater.

Applied both, thanks

-- 
~Vinod
