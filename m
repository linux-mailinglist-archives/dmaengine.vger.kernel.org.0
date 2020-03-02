Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCA7C1756F1
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2020 10:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCBJYt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Mar 2020 04:24:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgCBJYs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Mar 2020 04:24:48 -0500
Received: from localhost (unknown [171.76.77.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 750B624695;
        Mon,  2 Mar 2020 09:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583141088;
        bh=sRxuK443/SmO92erZi2ineFAz+CJF5wRLU3TMFhkAdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TqHbqJVzGE3ypoqI0Dm2v+eJ5EdlyTfYQ9S11WElrwOIfwMPISzMpXBSLqTeTX9X/
         9d+Mwo/agmz+q7SuIDwXNM0cJHBqOJYrZLFt/EHUxfDW/SumFSc0Plhs2i+4wtq9Mk
         3MJmYWJ8nZwP3y39AelOyEMVtA+30omCU6Wgqfz8=
Date:   Mon, 2 Mar 2020 14:54:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [RESEND PATCH v4 0/2] dmaengine: Add UniPhier XDMAC driver
Message-ID: <20200302092444.GJ4148@vkoul-mobl>
References: <1582271550-3403-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582271550-3403-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-02-20, 16:52, Kunihiko Hayashi wrote:
> Add support for UniPhier external DMA controller (XDMAC), that is
> implemented in Pro4, Pro5, PXs2, LD11, LD20 and PXs3 SoCs.

Applied, thanks

-- 
~Vinod
