Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F77F3E98
	for <lists+dmaengine@lfdr.de>; Fri,  8 Nov 2019 04:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfKHDyk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Nov 2019 22:54:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:46042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbfKHDyk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 7 Nov 2019 22:54:40 -0500
Received: from localhost (unknown [106.200.194.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D58214DB;
        Fri,  8 Nov 2019 03:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573185279;
        bh=MIIXRJaBYrNEXOYhmNyw15hFAChncCB29PqU5uPxEfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glynSCKHMYu10EcMhBORu0ErVBKrUcV98fhZ85ehrkiuejf16AuHEIuP6/tgXO7Xm
         R+mpks1IK23r3mS/Lj+B9ra8S7pqE+j4peTTVcxubI5Ui8tSR8/zjslW/6iqSFoqKi
         3VS1n5/WKhODgXPpJ8t1Z0vY/WwCCYnolu4VCC6c=
Date:   Fri, 8 Nov 2019 09:24:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dma-jz4780: add missed clk_disable_unprepare
 in remove
Message-ID: <20191108035435.GR952516@vkoul-mobl>
References: <20191104161622.11758-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104161622.11758-1-hslester96@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-11-19, 00:16, Chuhong Yuan wrote:
> The remove misses to disable and unprepare jzdma->clk.
> Add a call to clk_disable_unprepare to fix it.

Applied, thanks

-- 
~Vinod
