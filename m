Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3FB2204E1
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 08:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgGOGV3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 02:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgGOGV3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 02:21:29 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B77C20663;
        Wed, 15 Jul 2020 06:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594794089;
        bh=RuDwdOfaL/hDmHszGSnIA2cOoBO9bDvIVG5JJE5Y3Uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sH14JJzRo9u/bM/OiqB9hQKVKjgGsGLdHuOGYOClJj5dJMQdT/nHC6+N/OeIz1996
         GE8mQ0oFWxi6b34jX5NJePaRKgk+lr5WZEup20b2rdK/kHOU0DqCrI9+S2a9jw18Mi
         ALqNeKHh2KHFgazg/mPYSGczaG182gI/EftEHK4g=
Date:   Wed, 15 Jul 2020 11:51:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: ti: k3-udma: Use struct_size() in
 kzalloc()
Message-ID: <20200715062125.GB34333@vkoul-mobl>
References: <20200619224334.GA7857@embeddedor>
 <20200624055535.GX2324254@vkoul-mobl>
 <3a5514c9-d966-c332-84ba-f418c26fa74c@embeddedor.com>
 <98426221-8bff-25df-a062-9ec1ca4e8f26@ti.com>
 <20200626132944.GA26003@embeddedor>
 <04a5fb89-37eb-2cf7-d085-aaa4c9ed284d@ti.com>
 <20200710182512.GB21202@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710182512.GB21202@embeddedor>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-07-20, 13:25, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?

Applied now

-- 
~Vinod
