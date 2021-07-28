Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2173D8809
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 08:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbhG1GfY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 02:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233670AbhG1GfU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 02:35:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18103601FE;
        Wed, 28 Jul 2021 06:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627454119;
        bh=/F4quowviUqBgU6xUZEdvyD7ZkAGro7MOFqKiLTxMiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TSR44dGrzPJWGOIVySOQTfpJ7rtSUyoDou208+49rDQbkFjlBbMSGKqL114eZlBnO
         lUwCSG6hGbjQx/fmk81zxszmjXTp9HDUSqpMBnGXRAKdlgZhwfngX3zj6IAuSMWN19
         H7zFS8jK/RgYPICpipsrY4wuG0jJ3mWQArDYup1Ezd6IecdZ5lqSk/BeZayBQiF7zm
         EI9dAwVpCZCchNlyOAocQkVu+yVcqsMSqvMzQ0XJvZNd6oGWTButXU67evOc8H47P/
         8Bxfxr6YWQyeUmKOpHpPsvhG5G9XBjq5GaOgKLeijc7WDDBryGWSuZ8I0+v+O8GX5v
         V473H4NuRDEJg==
Date:   Wed, 28 Jul 2021 12:05:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Shravya Kumbham <shravya.kumbham@xilinx.com>,
        Matthew Murrian <matthew.murrian@goctsi.com>,
        Romain Perier <romain.perier@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Allen Pais <allen.lkml@gmail.com>, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, yangjihong1@huawei.com, yukuai3@huawei.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] dmaengine: xilinx_dma: Use list_move_tail instead
 of list_del/list_add_tail
Message-ID: <YQD6oediFBgOuW7l@matsya>
References: <20210608030905.2818831-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608030905.2818831-1-libaokun1@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-06-21, 11:09, Baokun Li wrote:
> Using list_move_tail() instead of list_del() + list_add_tail().

Applied, thanks

-- 
~Vinod
