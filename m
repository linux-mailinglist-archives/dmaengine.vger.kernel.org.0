Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC12472103
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 07:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhLMGWl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 01:22:41 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:60358 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhLMGWk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 01:22:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D908FCE0DDA;
        Mon, 13 Dec 2021 06:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232EFC00446;
        Mon, 13 Dec 2021 06:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639376557;
        bh=lXQk8DuzTcWO7+mYniXCjQRwf3MAXuhib/Ultl23U/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RF9r/PY36KFBoA6phg62nsHrctdXgAZw/+VyoRobtOWdVWZmPna2IfsVivf/eeH2S
         8XD7RStCk5xoQYds2ZXdwajgpccJGnZyFOeSDRGqQcXMJY6PXr1EJFD/2xReyHSXAg
         2dVihIqFAj19Su+f0NKg57tWX3Ntf5W/c277KQMRWvdk26Yjd4iuuimHI5opjEDDgH
         DX6xUiCDngaY1vd7iNbir1qee0Er9jVNJvBD6it/BVkykekoGnoOJPWpaiM/s7ENow
         FIiAZ76i9xYJ4ZoD9j1A+vzxa1mSx1uy5QekIUOPjSZ/WeqD7deHK+kUpMeOjHu2+X
         Ax/QPOmbo2vaQ==
Date:   Mon, 13 Dec 2021 11:52:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>, list@opendingux.net,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 0/6] dmaengine: jz4780: Driver updates v2
Message-ID: <YbbmqI6MHSwZTfIc@matsya>
References: <20211206174259.68133-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206174259.68133-1-paul@crapouillou.net>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-12-21, 17:42, Paul Cercueil wrote:
> Hi Vinod,
> 
> A small set of updates to the dma-jz4780 driver.
> 
> It adds support for the MDMA/BDMA engines in the JZ4760(B) and JZ4770
> SoCs, which are just regular cores with less channels.
> 
> It also adds support for bidirectional channels, so that devices that
> only do half-duplex transfers can request a single DMA channel for both
> directions.

Applied, thanks

-- 
~Vinod
