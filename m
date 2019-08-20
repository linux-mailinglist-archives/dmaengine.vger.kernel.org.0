Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F00D95D8F
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2019 13:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfHTLiK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Aug 2019 07:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729421AbfHTLiK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Aug 2019 07:38:10 -0400
Received: from localhost (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC2620C01;
        Tue, 20 Aug 2019 11:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566301089;
        bh=AciBUPAu82B05NczuPVQfEs6Tmsa+FH1VhYXzvvho/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zF8X7uV6Hg53HHI9pdfroR8XXMuq0Q6El9vcBuwaMcYwes4jW79F273FbuFLKZ0iq
         VSHWNVD/sWh4lPihmtX9tRHsunPmkp+6VDLFIP3k8cUJ5Vo0LkvLEiSV2RYrtLe8RG
         GmQTd9h7GGcqNAXS5fcOTA236lOWgYk/KE/7N7ck=
Date:   Tue, 20 Aug 2019 17:06:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] dmaengine: mv_xor_v2: Fix -Wshift-negative-value
Message-ID: <20190820113657.GV12733@vkoul-mobl.Dlink>
References: <CAKwvOdkAJcOCGvveBYaDD2kf4vx7m=b+Nxyn3_n=9aCBapzDcw@mail.gmail.com>
 <20190813173448.109859-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813173448.109859-1-nhuck@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-08-19, 10:34, Nathan Huckleberry wrote:
> Clang produces the following warning
> 
> drivers/dma/mv_xor_v2.c:264:40: warning: shifting a negative signed value
> 	is undefined [-Wshift-negative-value]
>         reg &= (~MV_XOR_V2_DMA_IMSG_THRD_MASK <<
> 	MV_XOR_V2_DMA_IMSG_THRD_SHIFT);
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
> drivers/dma/mv_xor_v2.c:271:46: warning: shifting a negative signed value
> 	is undefined [-Wshift-negative-value]
>         reg &= (~MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK <<
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
> 
> Upon further investigation MV_XOR_V2_DMA_IMSG_THRD_SHIFT and
> MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT are both 0. Since shifting by 0 does
> nothing, these variables can be removed.

Applied, thanks

-- 
~Vinod
