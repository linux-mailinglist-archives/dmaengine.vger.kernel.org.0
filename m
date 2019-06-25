Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A676B5221D
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2019 06:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfFYEg5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Jun 2019 00:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfFYEg5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Jun 2019 00:36:57 -0400
Received: from localhost (unknown [106.201.40.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A1EE20656;
        Tue, 25 Jun 2019 04:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561437416;
        bh=SvVn8LnfBh5pTFcwqtDE2hTF/uLgKV+aA3v8+JjVZh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RG1l3U3g3o+uSULUcTwuAP+ux/cIX5hVAljSvsFmGxBs+NaiiszBxs6oryV+8Ui9T
         rw6GAuvlrQXniJJ5SgykNw7pK5JLM8n+HscmjPuxCgkDtf/i7p7kl65DF/hDC3fqMm
         mrsED3fHFcMZKQxCCLHrP8UE4cuybUNeA3XNDpLM=
Date:   Tue, 25 Jun 2019 10:03:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1] dmaengine: dw: Enable iDMA 32-bit on Intel Elkhart
 Lake
Message-ID: <20190625043346.GJ2962@vkoul-mobl>
References: <20190621131914.38855-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621131914.38855-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-06-19, 16:19, Andy Shevchenko wrote:
> Intel Elkhart Lake OSE (Offload Service Engine) provides few DMA controllers
> to the host. Enable them in the driver.

Applied, thanks

-- 
~Vinod
