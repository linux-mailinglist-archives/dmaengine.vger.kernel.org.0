Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61CC48510A
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jan 2022 11:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbiAEKU2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jan 2022 05:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiAEKU2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jan 2022 05:20:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4830CC061761;
        Wed,  5 Jan 2022 02:20:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A767B819BA;
        Wed,  5 Jan 2022 10:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC78C36AEB;
        Wed,  5 Jan 2022 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641378022;
        bh=KZcJg8KuvpaTUJcqLW65TxIZO3msIAc6Lqn+Qz7yrXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3O3TsjyhzH8pJtz2M5FsGy02V7We5RVXEgGZODU0CqJngzt5N9Jq17PC9m43Xw0E
         Us5U4DWUpu7cNKuxL3jEA1IOgsbA7twitCBxXbArVPJHSCuM7DiXPVvdrM90byELq4
         NM5HZ9hfxO722djIcVGjQG8m/0TqMQyMWTPBl96hzGGyf60FVGsYiR7pWekXQVROtN
         dRq3TEVIJtWN6oIkZGWp3Tzyk/nmhkuHRbgFjgpixrt3rm4a8b0MNaJkptqyNOPI5e
         cMJN+iWMFDkMF7CitHDfEZY1QRQ3fsUSF1+VORESozr6X3NVt/QYf0zezsCXoh+GsP
         HVsiEjqd53QqQ==
Date:   Wed, 5 Jan 2022 15:50:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] dmaengine: at_xdmac: Various fixes
Message-ID: <YdVw4f4y44iRUM5z@matsya>
References: <20211215110115.191749-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215110115.191749-1-tudor.ambarus@microchip.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-12-21, 13:01, Tudor Ambarus wrote:
> Bugs identified when debugging a hang encountered when operating
> an octal DTR SPI NOR memory. The culprit was the flash, not the
> DMA driver, so all these bugs are not experienced in real life,
> they are all theoretical fixes. Nevertheless the bugs are there
> and I think they should be squashed.
> 
> Tested the serial with DMA on sama5d2_xplained. Tested QSPI with DMA on
> sama7g5ek. All went well.

Applied all, thanks

-- 
~Vinod
