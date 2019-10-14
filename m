Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAAAFD5CA6
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 09:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbfJNHvl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 03:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730020AbfJNHvl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 03:51:41 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3F1120673;
        Mon, 14 Oct 2019 07:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571039500;
        bh=Dv/55fBWmc8UO08TEI1giHXrERpLs2X/e9BIJ8S1P5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wJbKl07wDgbgnjvgcl/EdoHHaUSwYp8OtkvpupMo5QWAIBPHDmNGsxYIsfTiFzYfl
         /Q+nEsWXaI5qw+7LwB2nj6yrQo1Sc+51FdlhLcMiBXJYsxZiSy4FORX+KDYpwHmQVs
         EEHI3TLcPv6HSPyxugsi46Nr9Lkyw7QF3+mh+Hyw=
Date:   Mon, 14 Oct 2019 13:21:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: k3dma: Use devm_platform_ioremap_resource()
 in k3_dma_probe()
Message-ID: <20191014075136.GE2654@vkoul-mobl>
References: <aaed7862-49bb-e368-3e7b-5cc2c3d915b1@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaed7862-49bb-e368-3e7b-5cc2c3d915b1@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-09-19, 12:09, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Sep 2019 11:36:18 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.

Applied, thanks

-- 
~Vinod
