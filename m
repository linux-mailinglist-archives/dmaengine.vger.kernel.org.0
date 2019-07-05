Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A72D6010F
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2019 08:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfGEGeY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jul 2019 02:34:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfGEGeY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Jul 2019 02:34:24 -0400
Received: from localhost (unknown [122.167.76.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 340D1218BB;
        Fri,  5 Jul 2019 06:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562308463;
        bh=pIkefuW8jVPgeWT6Ugxuhm2IUtdP84GsvaopEo5owGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WH3O6JRlnbIBf0O57bdS0Il5QOg5F78gM+PAq0sRTLTe3lpgIAYW/tnzzF/Bsy4Xf
         Q83KXjmEktHMXyKfrdzgJWqiBEHbC9vDdUu+Ta3r7otZBO69iYtidJFrysvCxIkwoe
         /rJi1w+E5gEvPtYhFJGbCrP3DjVstmL3eDpWgzV4=
Date:   Fri, 5 Jul 2019 12:01:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH] dmaengine: tegra210-adma: Don't program FIFO threshold
Message-ID: <20190705063110.GX2911@vkoul-mobl>
References: <20190620075424.14795-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620075424.14795-1-jonathanh@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-06-19, 08:54, Jon Hunter wrote:
> From: Jonathan Hunter <jonathanh@nvidia.com>
> 
> The Tegra210 ADMA supports two modes for transferring data to a FIFO
> which are ...
> 
> 1. Transfer data to/from the FIFO as soon as a single burst can be
>    transferred.
> 2. Transfer data to/from the FIFO based upon FIFO thresholds, where
>    the FIFO threshold is specified in terms on multiple bursts.
> 
> Currently, the ADMA driver programs the FIFO threshold values in the
> FIFO_CTRL register, but never enables the transfer mode that uses
> these threshold values. Given that these have never been used so far,
> simplify the ADMA driver by removing the programming of these threshold
> values.

This fails to apply for me, please rebase and send

-- 
~Vinod
