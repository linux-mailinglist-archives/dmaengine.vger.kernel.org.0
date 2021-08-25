Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769943F7781
	for <lists+dmaengine@lfdr.de>; Wed, 25 Aug 2021 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbhHYOfZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Aug 2021 10:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241768AbhHYOfY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Aug 2021 10:35:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 425B16120A;
        Wed, 25 Aug 2021 14:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629902079;
        bh=lX8CX9raFyTVp1JQfMKaYurhPfDroeeifE+u2ZHqAoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eerlF4X4O7dohEHbuOnfI+oDYvk++ZHV2O73JfSIFzquKeevtLCdRZM1001hPZpeq
         OLC22wEthPo3BWGy8rJbWe2FB3WuJG0wdYYJQ9ZI6JH5erg7bWYAPSvG9ipzsIOvWZ
         SBPQICzLSOHU7l/YCb3jrHe1BdcYvOieUwO0Ahoqf4xfIIneRuroTujJMAKGUe+P3b
         aivGTO9UK02fEYG5Ijl3maT15nCwShcYSqt3CEiJls66DoxH7+Gu3YeGno2etsdeV8
         TM96sivtyqFteKzh84NfpM40hrO4aWwVL86DwEYEa6BIqgq8IaH4f/odxFks8iwxEr
         y3ckPJ/5oldjA==
Date:   Wed, 25 Aug 2021 20:04:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
Message-ID: <YSZU++9/M9M9ISXu@matsya>
References: <20210819110106.31409-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819110106.31409-1-p.yadav@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-08-21, 16:31, Pratyush Yadav wrote:
> The CSI2RX subsystem on J721E is serviced by UDMA via PSI-L to transfer
> frames to memory. It can have up to 32 threads per instance. J721E has
> two instances of the subsystem, so there are 64 threads total. Add them
> to the endpoint map.

Applied, thanks

-- 
~Vinod
