Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890163CFB43
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jul 2021 15:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhGTNNA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jul 2021 09:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239188AbhGTNI4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Jul 2021 09:08:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 973BC6113A;
        Tue, 20 Jul 2021 13:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626788974;
        bh=jT0TGDrbaqTjjYCZ0Nlu4Cvnm/2u0+UYmlAD8RzK66Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KC+9tSwFJvjrmNAokkgJlPneHd+UKgwtZ3JRd3Mmkkd/5D3LGF42LSwT+3dG5scsl
         KnAvnIUZQCIt/R8nEwryixQ1zQ0oBMJmzGG7Y3hX7JXYCG11jaF7NXI2XUlhWjCYXJ
         hET0WUo1TuJmljGXAtmSsDjl1QPNydyL1B8+yaLj1X62OnKk2O0GTpUzvROv3TNKYz
         oeweeh8o9IGbtMhJsgo722uIqGM023xDKtCLdn0fySYUqdaw+oE9h2Ys3z1LuQ5PMD
         iN4x8PDbyyZadiJgZC/x4tF1XpCdhGzun2GLksK0lOFESdtolvvX9hU9LqlDuvh8Pe
         a0Ph/kqHWRRIQ==
Date:   Tue, 20 Jul 2021 19:19:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Willliams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 00/18] Fix idxd sub-drivers setup
Message-ID: <YPbUaqiDe22Vwm+J@matsya>
References: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-07-21, 11:43, Dave Jiang wrote:
> Vinod,
> The series did not encounter any issues pushed on top of the latest 'next'
> branch.

Applied, thanks

-- 
~Vinod
