Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB63C3E2BF9
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 15:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhHFNxs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 09:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232548AbhHFNxs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 09:53:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94EA961158;
        Fri,  6 Aug 2021 13:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628258012;
        bh=lSmfbc2AI2P+N2RYQ/6GD2F8UCGftmX0YgcBiY6AWB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyWcnKR+DHVq2GP6diI3r5EXISRJuQpxGs6L2cQKXQbyu7ME5+2NtcJsCyJxC+tPs
         SuLUcl1GgXVHCBZlwAZH5YZoY5+t/UuxsBXnWyyiUQ3PJJzfyzYSJWiJn2I4g+JV9t
         836LZ043DhxF6n8LYAshcZQ6NCiXACxRnBgnXnzRb7+yCIhcveWZSpJ7D6hMlssnJR
         0EXxPRyLlFwyOD+Sy5Pz019AA9F7Bo/temFim+X6MDVl9c45C8Fh78kcD6u68CUhf3
         vXejCSXYyVThbwCXlsz/uN0u83V/cUCc6H04n1lpYJ5o1SnkpQ5JbArU5EnWKIS19Y
         avshzx8f+R0Fg==
Date:   Fri, 6 Aug 2021 19:23:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: make I/O interrupt handler one shot
Message-ID: <YQ0+2CrYst+LZA+c@matsya>
References: <162802977005.3084234.11836261157026497585.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162802977005.3084234.11836261157026497585.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-08-21, 15:29, Dave Jiang wrote:
> The interrupt thread handler currently loops forever to process outstanding
> completions. This causes either an "irq X: nobody cared" kernel splat or
> the NMI watchdog kicks in due to running too long in the function. The irq
> thread handler is expected to run again after exiting if there are
> interrupts fired while the thread handler is running. So the handler code
> can process all the completed I/O in a single pass and exit without losing
> the follow on completed I/O.
> 

Applied, thanks

-- 
~Vinod
