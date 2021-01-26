Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEA2304BC6
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 22:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbhAZVw0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 16:52:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbhAZR3s (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Jan 2021 12:29:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4D7A22795;
        Tue, 26 Jan 2021 17:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611682147;
        bh=l4bwtGIcQS7UjrkXD/wBnpPa72hMJnzodlSlvXmSoBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lvmyhw+4d6QygVffknt7PE3OsOppwM2abrpBegs6meg1tz5KmtAiMk85b+42H0UrT
         p8Q/MfeQ8HRq9LFoXPjl+53jTmUagvvyHdxZeILBAS4bzWFyQBQ80dfuG0GaB4JAJ3
         ErLaTcOD70QhdsNgHvtZ+SIpcCxaBm0RHWOxgBcgGBj0WyyF/J2z8KrSBvhS4y7KXM
         ZL2xHFjD/biC8wNKNMLq18YQHucCaUZqllCl8G3G6b17Isr+wJ8oABtRl0/FfvCXCd
         b2oHjR76rGEB+ZL/SDdUOoRzHwpAu6Zx7+AvbZ5IhZMunXb46WqsU9EAzHFRAO3uXf
         SkP5acBb8PTaw==
Date:   Tue, 26 Jan 2021 22:59:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: add module parameter to force
 disable of SVA
Message-ID: <20210126172903.GX2771@vkoul-mobl>
References: <161134110457.4005461.13171197785259115852.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161134110457.4005461.13171197785259115852.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-01-21, 11:46, Dave Jiang wrote:
> Add a module parameter that overrides the SVA feature enabling. This keeps
> the driver in legacy mode even when intel_iommu=sm_on is set. In this mode,
> the descriptor fields must be programmed with dma_addr_t from the Linux DMA
> API for source, destination, and completion descriptors.

Applied, thanks

-- 
~Vinod
