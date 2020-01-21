Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D151437CF
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 08:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgAUHmc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 02:42:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgAUHmc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 02:42:32 -0500
Received: from localhost (unknown [171.76.119.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5CCB2253D;
        Tue, 21 Jan 2020 07:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579592551;
        bh=z0iKasSaDhTi7+F0plTQzE2JIf4RhD0ex4jeT4N6YTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BCsn4lfrFfdVfMSBV8KxWz/q4g9hxiZqxPk2EjwV4MjJA+JQFB7wBb9QbKTqn3aN7
         RypFRDlJP8drL+XlYAZ/40cXcrg4yjFy1l+4yDWsLPzxfj84riT3rClwZRZqZhmcxj
         XWXZCNTkgtK3S4NGjBZx1HoynNLb2McnzDZEx9cQ=
Date:   Tue, 21 Jan 2020 13:12:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, grygorii.strashko@ti.com
Subject: Re: [PATCH] dmaengine: ti: k3-psil: Fix warnings with C=1 and W=1
Message-ID: <20200121074227.GC2841@vkoul-mobl>
References: <20200121070104.4393-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121070104.4393-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-01-20, 09:01, Peter Ujfalusi wrote:
> Fixes the following warnings:
> drivers/dma/ti/k3-psil-j721e.c:62:16: warning: symbol 'j721e_src_ep_map' was not declared. Should it be static?
> drivers/dma/ti/k3-psil-j721e.c:172:16: warning: symbol 'j721e_dst_ep_map' was not declared. Should it be static?
> drivers/dma/ti/k3-psil-j721e.c:216:20: warning: symbol 'j721e_ep_map' was not declared. Should it be static?
>   CC      drivers/dma/ti/k3-psil-j721e.o
> drivers/dma/ti/k3-psil-am654.c:52:16: warning: symbol 'am654_src_ep_map' was not declared. Should it be static?
> drivers/dma/ti/k3-psil-am654.c:127:16: warning: symbol 'am654_dst_ep_map' was not declared. Should it be static?
> drivers/dma/ti/k3-psil-am654.c:169:20: warning: symbol 'am654_ep_map' was not declared. Should it be static?

We dont use titles like this :(
A title should reflect the changes in the patch, I have updated this to
"dmaengine: ti: k3-psil: make symbols static"

and applied now

-- 
~Vinod
