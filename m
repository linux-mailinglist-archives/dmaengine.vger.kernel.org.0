Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42B515C13A
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2020 16:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgBMPTZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Feb 2020 10:19:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:54150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMPTZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 13 Feb 2020 10:19:25 -0500
Received: from localhost (unknown [106.201.58.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F07624686;
        Thu, 13 Feb 2020 15:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607164;
        bh=HwqrF3cTwsqwsopzg8IfFSN+MY/x+nrcyF0A9h3OwJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m23c4tYdooZ2ZS0uQUnzlGRRuarAFl1A/stuLa53CkZRTuWevlPozyNWsSboL4kU5
         f9kgLvJMYWql0PXAdu2brlj/az2mUFJJGD9eAi4EswHiYHS1HZRrHPPiE3sc+GsYsi
         Q4aHE1sjtCLHtkwISR9CYkPmzXbwXeJX37owU13E=
Date:   Thu, 13 Feb 2020 20:49:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     qiwuchen55@gmail.com
Cc:     dan.j.williams@intel.com, allison@lohutok.net,
        peter.ujfalusi@ti.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, wenwen@cs.uga.edu, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] dma: ti: dma-crossbar: convert to
 devm_platform_ioremap_resource()
Message-ID: <20200213151919.GQ2618@vkoul-mobl>
References: <1580189746-2864-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580189746-2864-1-git-send-email-qiwuchen55@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-01-20, 13:35, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Use a new API devm_platform_ioremap_resource() to simplify code.

Subsystem name is 'dmaengine' pls use that tag instead.
Applied after fixing the tag, thanks

-- 
~Vinod
