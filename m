Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765FF3E2BFC
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 15:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhHFNx7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 09:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233639AbhHFNx7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 09:53:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9D6761158;
        Fri,  6 Aug 2021 13:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628258023;
        bh=w1g74eKbOZ+FdCQflnzNWLWkmzFsN+xxKQTRIeMuUWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSVPpt71xeb+vj8sqk6c5CTXB9mih441kFfhQg8MrOy46WbWVKmH2wZ89sBRbBcju
         lR1MZ0wN0lA3Fp3+Y0WvX/bohV6OMQNBodUbD+g7+N7guA+XOuCSXRlcgdXjzSLYGJ
         kobdxzfETKundeRWQs3ri457G3DJmH0XXpMsgbth+w68xKCoWl/6ygdz3AmAmCZqC7
         bJv+ip6ZYsAtgD+eT+ZmhWpwASp6Q7RNBgDJu5SAFLnSBe4ua4RtBYJe/YdnL1Y/MI
         Mv8lPZFw7o2+H7zwjXAshSa7BcMgdzZLSvGE6HyQv9n1yRJbAGLO3jDzWk3AmJ0AZo
         vjx3IoTB++lAQ==
Date:   Fri, 6 Aug 2021 19:23:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add capability check for 'block on
 fault' attribute
Message-ID: <YQ0+42ApLAoOC688@matsya>
References: <162802992615.3084999.12539468940404102898.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162802992615.3084999.12539468940404102898.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-08-21, 15:32, Dave Jiang wrote:
> The device general capability has a bit that indicate whether 'block on
> fault' is supported. Add check to wq sysfs knob to check if cap exists
> before allowing user to toggle.

Applied, thanks

-- 
~Vinod
