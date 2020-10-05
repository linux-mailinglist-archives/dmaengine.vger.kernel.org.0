Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C92282FB2
	for <lists+dmaengine@lfdr.de>; Mon,  5 Oct 2020 06:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgJEEn7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Oct 2020 00:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgJEEn7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 5 Oct 2020 00:43:59 -0400
Received: from localhost (unknown [171.61.67.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E5162080C;
        Mon,  5 Oct 2020 04:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601873039;
        bh=NyIPq2qrlKxq27v9Ess1X+z0nqi4ab82aLZbHW2g8q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qTnVsaMxt+bOICcR8V3/KsWckd7VF61FQv3S/NUP9VVvdXL92UxnYpAIEVZyVAu5R
         Pit35+Toc0wG5f7muOaHi3jX4lEj93uktUzENeuW9AZsP27if8ojKKqHyBMrKYl8JC
         HxpiP9RqUqp+jfpz0SkaRdjojEKcoEH10P4/rNcY=
Date:   Mon, 5 Oct 2020 10:13:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Qilong Zhang <zhangqilong3@huawei.com>
Cc:     dan.j.williams@intel.com, peter.ujfalusi@ti.com,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH -next v2] dmaengine: ti: k3-udma: use
 devm_platform_ioremap_resource_byname
Message-ID: <20201005044354.GH2968@vkoul-mobl>
References: <20200921093701.102208-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921093701.102208-1-zhangqilong3@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-09-20, 17:37, Qilong Zhang wrote:
> From: Zhang Qilong <zhangqilong3@huawei.com>
> 
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately.

Applied, thanks

-- 
~Vinod
