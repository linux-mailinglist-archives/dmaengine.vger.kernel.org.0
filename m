Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B84222337E
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 08:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgGQGR5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 02:17:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgGQGR5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Jul 2020 02:17:57 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 599CE2071A;
        Fri, 17 Jul 2020 06:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594966677;
        bh=Ha36sRbzwPkg4ASd4IsKyizg6S8AsQu7pAyLmNKtPaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L0+hW6Np8uzZv05h6SQouGzF7hfgzMskXMHjI0gKIjhcFmbFGHecmEi5C26INROmw
         Vq7WMftEDlG5qs4VYNLFHbqP6bAJO50UB7DBMg41Vg96PjObQxxP82aDGhYLyEa8ob
         OXAt7AikN7i44BJ68HLLqjWONZTcwwtd6+GbplR8=
Date:   Fri, 17 Jul 2020 11:47:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     tudor.ambarus@microchip.com, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH v2] MAINTAINERS: dma: Microchip: add Tudor Ambarus as
 co-maintainer
Message-ID: <20200717061753.GF82923@vkoul-mobl>
References: <20200716071524.25642-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716071524.25642-1-ludovic.desroches@microchip.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-07-20, 09:15, Ludovic Desroches wrote:
> Add Tudor Ambarus as co-maintainer for both Microchip DMA drivers and
> take the opportunity to merge both entries.

Applied after changing dma->dmaengine, thanks
I have conflict while applying, please check

-- 
~Vinod
