Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB84B11A91C
	for <lists+dmaengine@lfdr.de>; Wed, 11 Dec 2019 11:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfLKKmZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Dec 2019 05:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfLKKmZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Dec 2019 05:42:25 -0500
Received: from localhost (unknown [171.76.100.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08AF92054F;
        Wed, 11 Dec 2019 10:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576060944;
        bh=nsJ4bE9wDwdi05WetCiVOr9Mbc94g8Oku8eeY/1k/hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2n/1zKCb5xTIvx/XgOJ+xKHW21guNHHnKoF6ZtSMurBofQSDTG3n6nsE4phArjIcb
         Y3PbZFAQ/wHYBxeV1sBq/7ZUlLwelz6OE88jRYWv3/vhUDukhm1Kp9tyIDyJKCvr0Z
         2SeqE864qmTRUbJaoHhevvpwnmSSMBltwbSyom9Y=
Date:   Wed, 11 Dec 2019 16:12:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: axi-dmac: add a check for
 devm_regmap_init_mmio
Message-ID: <20191211104220.GF2536@vkoul-mobl>
References: <20191209085711.16001-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209085711.16001-1-hslester96@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-12-19, 16:57, Chuhong Yuan wrote:
> The driver misses checking the result of devm_regmap_init_mmio().
> Add a check to fix it.

Applied, thanks

-- 
~Vinod
