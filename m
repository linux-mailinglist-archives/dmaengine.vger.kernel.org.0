Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059E2229D38
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jul 2020 18:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGVQgz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jul 2020 12:36:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgGVQgz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 Jul 2020 12:36:55 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE518206F5;
        Wed, 22 Jul 2020 16:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595435814;
        bh=j5W92jjNOL+k0PEAdcD3bXPHE+MydX1o+cietG3Uqd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kuYgWlLbYpm/wZ0SUYy7/helbkBKZ6OpFO7BOnxFPjiZC46jbeg+TeO5cLL2qMYk9
         7CcAcr79E/x2kgURJd4q4Sz26CR/2UwJqznQ87fcdpIT3Or2wMTcRv9YaAstxRiDoa
         9pDbhRdO9SrpIAAVt09ML7hsyv7vKFKydO1lhdcM=
Date:   Wed, 22 Jul 2020 22:06:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] dmaengine: xilinx: dpdma: Fix kerneldoc warning
Message-ID: <20200722163650.GT12965@vkoul-mobl>
References: <20200722161747.30048-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722161747.30048-1-laurent.pinchart@ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-07-20, 19:17, Laurent Pinchart wrote:
> Document the struct xilinx_dpdma_chan desc field to fix a kerneldoc
> undocumented member warning (which can be reproduced by compiling with
> W=1).

Applied, thanks

-- 
~Vinod
