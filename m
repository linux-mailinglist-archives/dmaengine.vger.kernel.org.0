Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBE2472099
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 06:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhLMFkz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 00:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhLMFkz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 00:40:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15228C06173F
        for <dmaengine@vger.kernel.org>; Sun, 12 Dec 2021 21:40:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4100B80B71
        for <dmaengine@vger.kernel.org>; Mon, 13 Dec 2021 05:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69FAC00446;
        Mon, 13 Dec 2021 05:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639374052;
        bh=/aLd7ijtdEHeUK0iulkoaWUHcc/9c8HSiE8547KtkPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOG0AHdR0tolJy8wDVLLNOfxPPWNeOMJngVvRxvFVA0tmkTEcl2iBxPN80ezHyrSI
         yUBbNVEV1BHrf/q1JqwIEj5m0l2WZcWztEzjxiZe3Rq8oiNfZrdUTXPIEtiaedxhoQ
         VQOAjo8LstOn8qafmOjXrGpiovYiCKn8+iFF/xZHCTreXmVh/QKUlKFSWT700r4sJY
         22R6u6VxkqwqFkkgfUOl984X1Ou1c4M+Lu0WoGmyh7eYGOjCQVg0t1auwOqQQMvZ9T
         9amm3Iu+zO0ghaFm7RQVMNpzd3phXm/mtpWpo3TZ4+4jCCS+a+D698Kwxq94T+gS4u
         IynKXqHKKEurQ==
Date:   Mon, 13 Dec 2021 11:10:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Ming Li <ming4.li@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix missed completion on abort path
Message-ID: <Ybbc4GgoWegrJ4Lh@matsya>
References: <163898288714.443911.16084982766671976640.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163898288714.443911.16084982766671976640.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-12-21, 10:01, Dave Jiang wrote:
> Ming reported that with the abort path of the descriptor submission, there
> can be a window where a completed descriptor can be missed to be completed
> by the irq completion thread:
> 
> CPU A				CPU B
> Submit (successful)
> 
> Submit (fail)
> 				irq_process_work_list() // empty
> 
> llist_abort_desc()
> // remove all descs from pending list
> 
> 				irq_process_pending_llist() // empty
> 				exit idxd_wq_thread() with no processing
> 
> Add opportunistic descriptor completion in the abort path in order to
> remove the missed completion.

Applied, thanks

-- 
~Vinod
