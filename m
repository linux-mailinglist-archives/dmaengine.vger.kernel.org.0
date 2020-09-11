Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292EC265F5B
	for <lists+dmaengine@lfdr.de>; Fri, 11 Sep 2020 14:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgIKMOs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Sep 2020 08:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgIKMOn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Sep 2020 08:14:43 -0400
Received: from localhost (unknown [122.171.196.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC1B21D40;
        Fri, 11 Sep 2020 12:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599826483;
        bh=YbB78ax7OnazJB/OSVmlyRGyxwji+VWDwwd7nhaBEzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zi3c3OoBgDllK0hFql+iM6RP/vYNH1WyLhxyTxzDmYPpy8/1kr6YTQUhH5j/7SXIY
         EBJE0MNEJ1J5tc64E3VGpLDWKoPaySfJmHZWQxPdaYPjcOC91Jvu+pWJawPYNkRyz4
         oYK7ug5sVwbU9JHfWdQejVar9nTS0UMaDzHOttsc=
Date:   Fri, 11 Sep 2020 17:44:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1] dmaengine: dmatest: Print error codes as signed value
Message-ID: <20200911121435.GA77521@vkoul-mobl>
References: <20200907101306.61824-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907101306.61824-1-andriy.shevchenko@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-09-20, 13:13, Andy Shevchenko wrote:
> When we got an error from DMA mapping API we convert a negative value
> to unsigned long type and hence make user confused:
> 
>   result #1: 'src mapping error' with src_off=0x19a72 dst_off=0xea len=0xccf4 (18446744073709551604)
> 
> Change this to print error codes as signed values.

Applied, thanks

-- 
~Vinod
