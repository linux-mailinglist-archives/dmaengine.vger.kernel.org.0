Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E78BE7853A
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2019 08:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfG2Guw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jul 2019 02:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfG2Guw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Jul 2019 02:50:52 -0400
Received: from localhost (unknown [122.178.221.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 723802073F;
        Mon, 29 Jul 2019 06:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564383051;
        bh=7EIM/UdJcMdkBEpYL/2lqKx3znF0JoheFSPt0gtaius=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=utZbpH0utAK7Pcs9kxBWH9OmIzm/OcTo1xoYGsYMaWWgblC4G3Sc5HVHQ9LKutdcT
         9IhaKCcq0nZLN2dFeZoZRQlKvaRht2DPypeYtiekkPmlh/F1+7k74jMIHMwFakGZAz
         9PSBcUVNDoMfqOIlju89+2kvtPUs+pjf4Ehi70n0=
Date:   Mon, 29 Jul 2019 12:19:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: Add YAML schemas for the
 generic DMA bindings
Message-ID: <20190729064939.GH12733@vkoul-mobl.Dlink>
References: <20190720092607.31095-1-maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190720092607.31095-1-maxime.ripard@bootlin.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-07-19, 11:26, Maxime Ripard wrote:
> The DMA controllers and consumers have a bunch of generic properties that
> are needed in a device tree. Add a YAML schemas for those.

Applied after changinge subsystem name to dmaengine in patch title

thanks
-- 
~Vinod
