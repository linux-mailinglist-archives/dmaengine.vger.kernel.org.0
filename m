Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E673CF97D
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jul 2021 14:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbhGTLms (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jul 2021 07:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:32938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235407AbhGTLmH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Jul 2021 07:42:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9668861164;
        Tue, 20 Jul 2021 12:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626783765;
        bh=YRLjcBlqPGxnu3xGSqaltTSQ92aKXDwWqXW2BW/djd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPZ4cfCH2/QnEkLnTe8nyWmaJD9PRK01bggfFSdcQBzmdqrKZEkJs84HG06yA+Qwd
         epd5Q81sv2+8nfQ9/P5i4cQ/bBWC3FLNbfQbR7Fo1KrAxojWJJoXDZh0L3ElTxDZVh
         aa5nNQ+9uzOCULt8kH4XhVBQXyNJyy+Rvtvo5KT5FJtfPD5MU3ygCZgau6i7WNY0OY
         U3zWyFLnzawiOAflK1CGrptof3SA1JPp+HLDML80ZxG5r/sXGbKHjp3NznQRW5qglh
         ReVpCNq8ETRcQVJVaYAPUrOyCY/RZMZM3Jzxg1zTsAXyhn+oc5T5fDs3u3ok9GETtW
         m6kTbN5xFADeQ==
Date:   Tue, 20 Jul 2021 17:52:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Robin Gong <yibin.gong@nxp.com>, broonie@kernel.org,
        shawnguo@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, robh+dt@kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com
Subject: Re: [PATCH v16 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Message-ID: <YPbAEbcOzBrK2KfB@matsya>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
 <8f8a307a2dc99ca3beab2767ac3188b4ba1a394f.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f8a307a2dc99ca3beab2767ac3188b4ba1a394f.camel@pengutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-07-21, 11:05, Lucas Stach wrote:
> Hi Vinod, Mark, Shawn,
> 
> with this revision I think this series is ready to be picked up, at
> least I couldn't spot any blockers anymore.
> 
> How would you like to deal with this? While the complete series is
> needed to fix the issues and restore proper DMA functionality on
> unaffected SoCs, there are no dependencies between the patches
> targeting different subsystems.
> Do you prefer to pick dma/spi/dt patches from this series in your
> respective trees, or do you want the whole series to go through the imx
> tree? AFAICS all dma and spi patches are already acked, so taking them
> through one tree would be possible, I think.

Sure, since you have acks, feel free to merge thru imx6 tree

-- 
~Vinod
