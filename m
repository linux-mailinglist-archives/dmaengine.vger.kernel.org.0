Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728A33131D5
	for <lists+dmaengine@lfdr.de>; Mon,  8 Feb 2021 13:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhBHMJi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 Feb 2021 07:09:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233601AbhBHMHW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 8 Feb 2021 07:07:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C062B64EA4;
        Mon,  8 Feb 2021 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612785973;
        bh=iM4sD59nAL3TH/ES7dW5ahl8yFxFRvaZxZ+noqQ3iZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iha0jX3AZ6wrsIsaRZEC7ahlTFVpcOmLjcdiNRN9HCqgg6+5MGLC4ExRijPrQhuru
         9iNJ1BVSBfwV/hJy8cCOIKKYNeIEKIY+lmiONkjA5+iVVwoTYPEougQkvttmRY6lw5
         mheav3daAo9TxY+KkmEZdx+aTwTOuFWuVlScE2xrgd+3g98Bnxw6w94FHh/jof6S8s
         AHL4x5ls7VmJdm7FUlrVxcCT4CrtPK611N3C4BAlFUNtzjnxOrAHIcBgrsGdbePgTA
         QQ8In6LewujoNpLLZlsPQ4nkv43X8JwCxGMbAFnoPhw2w/3kC55WWdtIiqm6h6kQqm
         sY5CLBiPyX7UQ==
Date:   Mon, 8 Feb 2021 17:36:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, andriy.shevchenko@linux.intel.com,
        vireshk@kernel.org
Subject: Re: [PATCH v2] Revert "dmaengine: dw: Enable runtime PM"
Message-ID: <20210208120609.GC879029@vkoul-mobl.Dlink>
References: <20210203191924.15706-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203191924.15706-1-cezary.rojewski@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-02-21, 20:19, Cezary Rojewski wrote:
> This reverts commit 842067940a3e3fc008a60fee388e000219b32632.
> For some solutions e.g. sound/soc/intel/catpt, DW DMA is part of a
> compound device (in that very example, domains: ADSP, SSP0, SSP1, DMA0
> and DMA1 are part of a single entity) rather than being a standalone
> one. Driver for said device may enlist DMA to transfer data during
> suspend or resume sequences.
> 
> Manipulating RPM explicitly in dw's DMA request and release channel
> functions causes suspend() to also invoke resume() for the exact same
> device. Similar situation occurs for resume() sequence. Effectively
> renders device dysfunctional after first suspend() attempt. Revert the
> change to address the problem.

Reverts also need proper tagging, so pls ensure that is done. I have
added the subsystem and driver tags and applied

-- 
~Vinod
