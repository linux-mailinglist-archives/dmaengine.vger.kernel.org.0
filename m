Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54107395459
	for <lists+dmaengine@lfdr.de>; Mon, 31 May 2021 06:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhEaELH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 May 2021 00:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhEaELG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 May 2021 00:11:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73744611CA;
        Mon, 31 May 2021 04:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622434167;
        bh=+96H0DiwYnLTSciM+R0oUuL+G2kj34SB/CV5Rl21cqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mtIfzjUnkbdIwFzyEuJP1kvYfHO7nBBLXklpKDS/YZtsWHm/q787HZgZ+oXmNkutO
         /qvzmv5Ej382Lor4O42/lOddMjhlo2jYQYJDxZKL3wT2dnKH4/hOBRfLM2BHrHxpyy
         U+4zvI/5HrOhjqXQMjuPFKiYwHTZhaW4ayVLVcEVxdMtIS42CrnAwDHOmXQx2NWMjB
         XXP34MmZtjAYupwUvcRdcqC+XuU5h6tXfXywmjIg/ZnR4SPAM/VzupQy5K2ae/MlDe
         haeK695P2w3nhtLTLbZMUyTT2k79fspKDhE/NJSDTuMFrpQDcqB5DfFpG4yX+3mGof
         bQoEpXiojWBoQ==
Date:   Mon, 31 May 2021 09:39:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Nikhil Rao <nikhil.rao@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Add missing cleanup for early error out
 in probe call
Message-ID: <YLRhc2cCQWSPEBMV@vkoul-mobl.Dlink>
References: <162197061707.392656.15760573520817310791.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162197061707.392656.15760573520817310791.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-05-21, 12:23, Dave Jiang wrote:
> The probe call stack is missing some cleanup when things fail in the
> middle. Add the appropriate cleanup routines to make sure we exit
> gracefully.

Applied, thanks

-- 
~Vinod
