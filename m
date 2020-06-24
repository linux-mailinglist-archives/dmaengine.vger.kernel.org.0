Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FBE206D8E
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 09:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbgFXHYi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 03:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbgFXHYh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 03:24:37 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A43512073E;
        Wed, 24 Jun 2020 07:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592983477;
        bh=fQaJ9CmmabmQ5X235ZXaKltp1nYvG1Sgl8ab8nIvx3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O8v8VewXLIZv6GVdgOzQcbLscXjZ8nePtJXc2v/2WRJ1S/FUIE90OjRRFavxF+0ST
         NEdMAfeXPvBbUCY1iK1eYvPF7xeLWIz/SKh5dsKmhOolg9ETVp0KF5cud+JG8Rdc2Q
         JX8kbCoWCfxBx0F3vIi7I+MNjMwmqsn/cG6HVSig=
Date:   Wed, 24 Jun 2020 12:54:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add leading / for sysfspath in ABI
 documentation
Message-ID: <20200624072433.GJ2324254@vkoul-mobl>
References: <159225447176.68253.2922149693913698177.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159225447176.68253.2922149693913698177.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-06-20, 13:54, Dave Jiang wrote:
> Correct to standard convention. All sysfs paths seem to be missing leading
> /.
> 

Applied, thanks
-- 
~Vinod
