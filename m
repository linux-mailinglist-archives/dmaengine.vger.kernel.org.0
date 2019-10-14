Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1D5D5CB2
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfJNHwr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 03:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfJNHwr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 03:52:47 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB69B20854;
        Mon, 14 Oct 2019 07:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571039566;
        bh=JSWw0MG1zhOv2LF9Y5gVdGsg3ajvM/sUAFV4xu8ey5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjBy7oQwSrI6iB5Skbc/NvXxuVOSZHnCRV6aLMxsAkT7rduYJne12wOP5ljb5FgNA
         XFXyjnBIQtvE2iv5wTr1iQiVu9cDWEC3KgtEnhyu0ISHKyKZ6Jrz3aTqAwW4D+XhJg
         f6FlPvtKxR+5TbBHf9y6ODcqzcWsYSNVycKj90P8=
Date:   Mon, 14 Oct 2019 13:22:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: owl: Use devm_platform_ioremap_resource() in
 owl_dma_probe()
Message-ID: <20191014075242.GH2654@vkoul-mobl>
References: <d36b6a6c-2e3d-8d68-6ddc-969a377ca3b2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d36b6a6c-2e3d-8d68-6ddc-969a377ca3b2@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-09-19, 13:30, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Sep 2019 13:23:54 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.

Applied, thanks

-- 
~Vinod
