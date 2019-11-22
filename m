Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A08105F95
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2019 06:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfKVFWP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Nov 2019 00:22:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfKVFWP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 22 Nov 2019 00:22:15 -0500
Received: from localhost (unknown [171.61.94.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3743220707;
        Fri, 22 Nov 2019 05:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574400135;
        bh=knjKR698WQ5h0B1QBoSsF491OzN3i8ggmCSyPUHo/FA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zMRwb/7fHHnf9jv8hnpDuPQxlcWFdVXve1eyYwPcoscIMoA8lRln50zeGxLr1L+L3
         uCs3Ql1OEG24FSotSrRDs4Y88u6nLRoORhwluy7nnNpEokCq+6aLV49Hb9EVBjajSd
         IEMcy+K4BROeVks11iSXGcEcYsAokrZG6Hl+tiRM=
Date:   Fri, 22 Nov 2019 10:52:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: mmp_tdma: add missed
 of_dma_controller_free
Message-ID: <20191122052210.GP82508@vkoul-mobl>
References: <20191115083100.12220-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115083100.12220-1-hslester96@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-11-19, 16:31, Chuhong Yuan wrote:
> The driver calls of_dma_controller_register in probe but does not free
> it in remove.
> Add the call to fix it.

Applied both, thanks.

-- 
~Vinod
