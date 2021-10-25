Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A83438FA2
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhJYGnk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhJYGnk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 02:43:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BACC60EFE;
        Mon, 25 Oct 2021 06:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635144078;
        bh=SQ/wzwscheYstIyR1dmQ0uAEaXgUPZG3vaPygcq0SBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b8A8pGlrUqWgo9FSnAKiyhRLyJ/u8rSCtUUq2WnR/cMsoeurFIEo+XGeptMiwoIAY
         WcEIYXjwf2Kujw8s0Z6UKxvGHUzcnLI6aMKiqqeIJyDt4Od1NZ419UQm0AtShNnQMB
         1R3CKedBaktzGa4qcPvlQML0EhDOiNBAnCVOB4Wd1XyPyQhmte5+BVGxvz1CHMFShV
         2wSd16mnnPYig313r4z7Mi17sOIL6bvV/iTRr7hcvJfnjlDleL1FnxABd5vqTMtZHK
         H/EOnMgv2cpzxS2LX/J9X92VpwMKB1r8O6DzMjvZj8iE0ETIfU35ZPwyNKVxXqMjz9
         ygVYDm+dlqVQA==
Date:   Mon, 25 Oct 2021 12:11:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: reconfig device after device reset
 command
Message-ID: <YXZRimMWybR68RJ7@matsya>
References: <163054188513.2853562.12077053294595278181.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163054188513.2853562.12077053294595278181.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-09-21, 17:18, Dave Jiang wrote:
> Device reset clears the MSIXPERM table and the device registers. Re-program
> the MSIXPERM table and re-enable the error interrupts post reset.

Applied, thanks

-- 
~Vinod
