Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46723C7ED0
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 08:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhGNG6g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 02:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237948AbhGNG6f (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 02:58:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 021606100C;
        Wed, 14 Jul 2021 06:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626245744;
        bh=6jgc0Nz5yx/wHPOmaUo8ELg83tVNv/YYkxm40mJEVQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSUufH5l4/YM2dS9mg7/bYniwrAjfRfT9XJB151r2okeg7cBu4f/a279saUHmTo8C
         47HdotoXpi9Py/zn5FNSgcWqmFZrVs48X54smhnGGy3wCxaU95Kp3ugWu+JRl2/xoJ
         8d8aAP0kpj1XKxaHNq1xzoH1fTGDeBHuv9s4JPpwLkt19OY0rySpGAjU126ULRPbQN
         CshrxDMcICfxm9b54ksGrAshwPlHW0IrcTWXMJuB5CpUWUKl0H9NKpoLyrQJm3Df38
         gCk7IlB0yHyQTs64+OhUuD2XeZZJNl9Awp6ZzD1pFhbQgWknu5JGC3VcXf3yCg4l0P
         rRRCMTAjrEfcg==
Date:   Wed, 14 Jul 2021 12:25:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: remove fault processing code
Message-ID: <YO6KbbISs6bCYH7e@matsya>
References: <162275778388.1857326.6348833334923107311.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162275778388.1857326.6348833334923107311.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-06-21, 15:03, Dave Jiang wrote:
> Kernel memory are pinned and will not cause faults. Since the driver
> does not support interrupts for user descriptors, no fault errors are
> expected to come through the misc interrupt. Remove dead code.

This fails to apply, i think it needs rebase

-- 
~Vinod
