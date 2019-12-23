Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9298D12925E
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 08:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfLWHoV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 02:44:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfLWHoV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Dec 2019 02:44:21 -0500
Received: from localhost (unknown [223.226.34.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFE69206CB;
        Mon, 23 Dec 2019 07:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577087060;
        bh=kPjCbh8YQ/u75m8hPE0XtPPZuQwgrrgX09NSbRjpULM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pXYGleqb4/QEzRZqF/huE45xNvJmLOKREZlYSZ+aNic4dNL1jLcXFqgot/posh1Zv
         NKq8kWk5HP6J5eoGaChiOJ/gx+oSKHBH71DYpU3LFubDPW/cu9I6eR26EoT9Nfl8Y1
         nJH7mi9E6qKFD3fWDhbNAtoFvZKAg+69j5PPaslk=
Date:   Mon, 23 Dec 2019 13:14:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 09/14] dmaengine: ti: omap-dma: Configure global priority
 register directly
Message-ID: <20191223074416.GY2536@vkoul-mobl>
References: <20191217001925.44558-1-tony@atomide.com>
 <20191217001925.44558-10-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217001925.44558-10-tony@atomide.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-12-19, 16:19, Tony Lindgren wrote:
> We can move the global priority register configuration to the dmaengine
> driver and configure it based on the of_device_id match data.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
