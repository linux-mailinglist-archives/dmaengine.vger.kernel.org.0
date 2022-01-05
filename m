Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F6F484ED3
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jan 2022 08:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbiAEHnt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jan 2022 02:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiAEHns (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jan 2022 02:43:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E9AC061761
        for <dmaengine@vger.kernel.org>; Tue,  4 Jan 2022 23:43:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1791D60FBC
        for <dmaengine@vger.kernel.org>; Wed,  5 Jan 2022 07:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFCEC36AE3;
        Wed,  5 Jan 2022 07:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641368627;
        bh=3xjTyJCbriqTAU3nIcBxbOE+YPI8ZE9xpr7yqpLp63I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VUvgGgjoYuTcNbvZPrPj4wcvejj854BPpx3X3GEhG5YRciB0flEbg6CWqQq2UXayE
         qgrV9QUmxVl5VcfKAFMmbrwfpc7WMDcqOlRG3UkwW4uZcvD9K5nU8f19NXulHd1Emd
         dkHA8sxXOPjJi1GhDSmYZG4BKw0QiwT6USkTNmBvOBK3zqSNPKy1V5EM3XV/AiVx1m
         7M6v7D3GMs+ytqnF0ecG/K3xMUZOSjFUSoMcAalpMslnROUrReyNQaEUVOs77545qS
         kYlK4hErQmDEzNR8a/HK87v9bNs90VjgDswkOs0KP1hOmdzhZh/+i/8a5eFAN+29Z3
         2AUpWFolLy0JA==
Date:   Wed, 5 Jan 2022 13:13:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Lucas Van <lucas.van@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix wq settings post wq disable
Message-ID: <YdVMLzsOjwI9RAhP@matsya>
References: <163951291732.2987775.13576571320501115257.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163951291732.2987775.13576571320501115257.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-12-21, 13:15, Dave Jiang wrote:
> By the spec, wq size and group association is not changeable unless device
> is disabled. Exclude clearing the shadow copy on wq disable/reset. This
> allows wq type to be changed after disable to be re-enabled.
> 
> Move the size and group association to its own cleanup and only call it
> during device disable.

Applied, thanks

-- 
~Vinod
