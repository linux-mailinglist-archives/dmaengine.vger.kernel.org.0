Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0912124DB
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 15:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgGBNgo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 09:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbgGBNgo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 09:36:44 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 186BB207CD;
        Thu,  2 Jul 2020 13:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593697003;
        bh=sq5UqoYdlq/TW5H1F/EieH5J/kbOZ8Zcsvm4t11nuq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQ8djoDXG0hr8HEZEq+5UatlIktLK/iinjEvwzYRiDu0fl/9Eqs2DlDc/LD1u+rBn
         P0YA2uw2RH6fpECqJZ5J54DyZFm8C04p/APo/5PzbkWbZwZmGvua92PkIgYDpgL6CK
         SCOzN6+rf0kmUsu8JpvLY8lTCTAk2TVYkx0r6Rs4=
Date:   Thu, 2 Jul 2020 19:06:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Yixin Zhang <yixin.zhang@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: cleanup workqueue config after
 disabling
Message-ID: <20200702133640.GE273932@vkoul-mobl>
References: <159311264246.1198.11955791213681679428.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159311264246.1198.11955791213681679428.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-06-20, 12:17, Dave Jiang wrote:
> After disabling a device, we should clean up the internal state for
> the wqs and zero out the configuration registers. Without doing so can cause
> issues when the user reprogram the wqs.

Applied, thanks

-- 
~Vinod
