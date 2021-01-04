Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAA12E9505
	for <lists+dmaengine@lfdr.de>; Mon,  4 Jan 2021 13:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbhADMje (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Jan 2021 07:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbhADMjd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 Jan 2021 07:39:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6173220770;
        Mon,  4 Jan 2021 12:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609763933;
        bh=f9vH4s6nGLOCyjCDAv3bQ9hxb7whPAr9ymDwtadt9rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQm8a3HrUId/o2cW49pQ6VhM2Vk4dbE7iycJPorBcaU1uIVWjaXrF9uHz5lIVuOja
         0tm6U0LY1x/t4uyU7ciw1XYnT/h4/1NKfxysumdHRKPAR+nPUtBg9qShp6bwZakhzs
         ULwD79jWVD8ogl/HOVnysperkJLaZovi9fslEyd+ODPrNDhqhrOlyFgAPXXL7hRXQk
         PT2nq6OjJiCU5RyLf5qxMFNCY0Lng/tJ03rl4DuVEWE/cFNSqS2OsizOxtPkrkYx6H
         fhVkDgmXwAO5EB5b63WOoC7zJRMpenhEYmgnnlIGMzm9bz9UnPzDSffoKvP/z0v079
         9RdF8b3o5dI3g==
Date:   Mon, 4 Jan 2021 18:08:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: fix gpi undefined behavior
Message-ID: <20210104123848.GG120946@vkoul-mobl>
References: <20210103135738.3741123-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103135738.3741123-1-arnd@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-01-21, 14:57, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc points out an incorrect error handling loop:
> 
> drivers/dma/qcom/gpi.c: In function 'gpi_ch_init':
> drivers/dma/qcom/gpi.c:1254:15: error: iteration 2 invokes undefined behavior [-Werror=aggressive-loop-optimizations]
>  1254 |  struct gpii *gpii = gchan->gpii;
>       |               ^~~~
> drivers/dma/qcom/gpi.c:1951:2: note: within this loop
>  1951 |  for (i = i - 1; i >= 0; i++) {
>       |  ^~~
> 
> Change the loop to correctly walk backwards through the
> initialized fields rather than off into the woods.

Applied, thanks

-- 
~Vinod
