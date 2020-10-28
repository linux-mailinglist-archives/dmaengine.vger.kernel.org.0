Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E17229DEA7
	for <lists+dmaengine@lfdr.de>; Thu, 29 Oct 2020 01:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgJ2Azx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Oct 2020 20:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731668AbgJ1WRk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:40 -0400
Received: from localhost (unknown [122.171.163.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 301EB2224A;
        Wed, 28 Oct 2020 05:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603863183;
        bh=Q5PR0wLT1H2AcknQT63o0IF3Mnaw82WXKZ0oGBO+vRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRWz1CXgaqh+JnC0I8GTAB1SYcrMszwibufzqfCVGUF9fYP4X/NyhfxbjDooZx3Af
         6jHFnhXJAcJ7fp/AIqPqrVuPfnG/ZK8fWJGwVKAUfoAnTawD8ZBcch81gHTYh7EDFJ
         Kv5HzOeCEMP2ETwZnznT9fhgu+N7lV7FGuafz4Bc=
Date:   Wed, 28 Oct 2020 11:02:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix wq config registers offset
 programming
Message-ID: <20201028053258.GF3550@vkoul-mobl>
References: <160383444959.48058.14249265538404901781.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160383444959.48058.14249265538404901781.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-10-20, 14:34, Dave Jiang wrote:
> DSA spec v1.1 [1] updated to include a stride size register for WQ
> configuration that will specify how much space is reserved for the WQ
> configuration register set. This change is expected to be in the final
> gen1 DSA hardware. Fix the driver to use WQCFG_OFFSET() for all WQ
> offset calculation and fixup WQCFG_OFFSET() to use the new calculated
> wq size.

Applied, thanks

-- 
~Vinod
