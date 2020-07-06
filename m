Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828A921521D
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2020 07:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgGFFTE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jul 2020 01:19:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgGFFTC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Jul 2020 01:19:02 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7523C20715;
        Mon,  6 Jul 2020 05:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594012742;
        bh=l/3SWBfqpGtE5dZNa/GolLP57ayRYFrPWuRtcUTlBts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HBzl0ioFoQEzJ23c5FOteCUgsCEU97fUnI1LYzCp4aYDJ7xCDQjdD+biOfroILFt9
         +RRVdqbWuRy0PqzJksFNyy0/6vAEF/ytvXFixSv8G0ndhRf3nEWvLK8lYTgNnUV63d
         JEAxKpHDm02vcJKgmUXkV8bhRZ2Guh50QO7pEAwE=
Date:   Mon, 6 Jul 2020 10:48:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     leonid.ravich@dell.com
Cc:     dmaengine@vger.kernel.org, lravich@gmail.com,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: ioat setting ioat timeout as module
 parameter
Message-ID: <20200706051858.GH633187@vkoul-mobl>
References: <20200701140849.8828-1-leonid.ravich@dell.com>
 <20200701184816.29138-1-leonid.ravich@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701184816.29138-1-leonid.ravich@dell.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-07-20, 21:48, leonid.ravich@dell.com wrote:
> From: Leonid Ravich <Leonid.Ravich@emc.com>
> 
> DMA transaction time to completion  is a function of
> PCI bandwidth,transaction size and a queue depth.

space after , pls

> So hard coded value for timeouts might be wrong
> for some scenarios.

I ahve fixed above and applied

-- 
~Vinod
