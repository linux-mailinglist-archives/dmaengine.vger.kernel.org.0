Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA803F87ED
	for <lists+dmaengine@lfdr.de>; Thu, 26 Aug 2021 14:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhHZMtw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Aug 2021 08:49:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241859AbhHZMtv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Aug 2021 08:49:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B4ED610A1;
        Thu, 26 Aug 2021 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629982144;
        bh=8wIVTJgGwcbKuade1E5wbFIS8YhW8MoBvnFOpWooLfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HdsSy22dTUU5BM66lr41flZFt0IsVUhiXxUx3O/54sephFFGialmqvuwuSi91Lwd7
         /8zAVnbMH7/h9Ss2jFNY4uWD95TEC58EkdJpBasx/YtvsJ4VXcrFlQQjzNe0Pf6zl9
         PwAIRnGySWyCL40i72BH2HEGiHrq+Vo3Ka4tZxQFi9bwXFo9qQCb1g7I8JoCSUk0Jm
         Tt1twdulGAsGJdubC1mvhbOxsiXY58x5XlcTsSkkCtNxxwl3RVVE9gRml8UvWpyKhN
         uD6H+/7N9kdtvLXFUKW4H4hwaiLqkS7o2KNemwmIW7BQnz6tnOAMUXOoUCBLfFq0pg
         18XJD358aSGjA==
Date:   Thu, 26 Aug 2021 18:19:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v12 0/3] Add support for AMD PTDMA controller driver
Message-ID: <YSeNvB4LoLk9rQ+L@matsya>
References: <1629208559-51964-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629208559-51964-1-git-send-email-Sanju.Mehta@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-08-21, 08:55, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> This patch series add support for AMD PTDMA controller which
> performs high bandwidth memory-to-memory and IO copy operation,
> performs DMA transfer through queue based descriptor management.
> 
> AMD Processor has multiple ptdma device instances with each controller
> having single queue. The driver also adds support for for multiple PTDMA
> instances, each device will get an unique identifier and uniquely
> named resources.

Applied, thanks

-- 
~Vinod
