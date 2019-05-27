Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB6D2B666
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 15:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfE0N1p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 09:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfE0N1p (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 May 2019 09:27:45 -0400
Received: from localhost (unknown [171.61.91.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED6842075E;
        Mon, 27 May 2019 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558963664;
        bh=5LGQZbcDiGADtRy7nX7CzuVlxf33jXUOVsnEJ3zPY0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUXx9qkdl3PVY7xkVd58jgCJb3Lp8OiMlxFqQAZ1sXvFApYBGITyi/UALTTG1JNUy
         b4OWejyk5gOFmczJsWLyvzX/xMHkG9aA+Gs4E2Yyer9SEsRVyYUwwjJhI9jtNeZVmJ
         yENXghH6AMpxYO/JJtw0k+PYaBdMKfJNOOojTcVI=
Date:   Mon, 27 May 2019 18:57:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     dan.j.williams@intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: use to_platform_device()
Message-ID: <20190527132739.GJ15118@vkoul-mobl>
References: <20190526071324.15307-1-houweitaoo@gmail.com>
 <20190527064303.GG15118@vkoul-mobl>
 <CAK98mP9teTxZn9mMZ_yXSmC7h8gimgN14kX=GT0Q43O58zC-rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK98mP9teTxZn9mMZ_yXSmC7h8gimgN14kX=GT0Q43O58zC-rw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Weitao,

On 27-05-19, 21:10, Weitao Hou wrote:
> Hi,Vinod
>     Need I add the stm32 driver tag and resend v2 patch?

Please do not top post!

As below says, the patch is applied and I corrected the tag and added
stm32 while applying, so no change or v2 required.

> Vinod Koul <vkoul@kernel.org> 于2019年5月27日周一 下午2:43写道：
> 
> > On 26-05-19, 15:13, Weitao Hou wrote:
> > > Use to_platform_device() instead of open-coding it.
> >
> > Applied after adding stm32 driver tag, thanks
> >
> > --
> > ~Vinod
> >

-- 
~Vinod
