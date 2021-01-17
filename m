Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6D62F9110
	for <lists+dmaengine@lfdr.de>; Sun, 17 Jan 2021 07:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbhAQGZ6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 17 Jan 2021 01:25:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:59906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbhAQGZz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 17 Jan 2021 01:25:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C5DD2311F;
        Sun, 17 Jan 2021 06:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610864714;
        bh=uWAJLOJaN7q3tn+DvzuqtKlIS0CE8YiVdmBQkmjkmdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDH/l0adRgYMZF+r2rQg2RAKUXm7kfwDFv4Ut7svwebBZwellolapiG1/C/2tqZBY
         jW88ebB8DoOBg+wSmVUDSuOQLU7ZzbZ9zglYY1Wjkg+r1zrS9GmTxaScMbdPM0jAuv
         4MU2EzWzQJyjFyfI+kwGEO1P3X+KIlE8/9+vghE6t0qJ4Te6V4w2XDKQioskkhayBg
         eDS9OK2ckEA0+6SrYcn3fmsUV2en1TfJJIJh1SZaRvM0GF4iG/BMsI/8FNWm2mPwUo
         rPSxTrxrH7qngzcCRtqAsiRc988if7xHAfwchGUE2E9vl7NGxSfglSNGt02GTpAE8C
         CIVzdICuyMQsg==
Date:   Sun, 17 Jan 2021 11:55:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: gpi: Remove unneeded semicolon
Message-ID: <20210117062509.GK2771@vkoul-mobl>
References: <20210115100040.33364-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115100040.33364-1-vulab@iscas.ac.cn>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-01-21, 10:00, Xu Wang wrote:
> fix semicolon.cocci warning:
> drivers/dma/qcom/gpi.c:1703:2-3: Unneeded semicolon

Applied, thanks

-- 
~Vinod
