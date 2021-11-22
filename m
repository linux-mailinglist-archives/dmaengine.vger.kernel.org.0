Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8ED458981
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 07:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhKVHC1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 02:02:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232801AbhKVHCZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 02:02:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B15760F24;
        Mon, 22 Nov 2021 06:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637564359;
        bh=RNBKnrCb8o5Nim0sFueXlmYdbeXWfo/A58XEhthX+l0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6j2olQhNewhBRhXk7aZXmjfw6qrq/KKESDETtHZQoGT/j2i+6QrULuW2bzhU1yZO
         GY2UkcOFcPG5bhBHl8u0bflWkSVRGPY8iAZxmDiL8Zx34s/zo4ZSWeTOawdRgePYxk
         LiP4aVZDg+/6d9ZfX6uNUluUdaVWzS3SyDNT/zg/SLncNV8XpTJGfGBJvwwx23rwfR
         j/KZ0LC6fsfXSw+oobIu9yHPNk9MpIgUh13SlDAkXaSpKd+j4AWgNye2FInEsrTMFG
         YfvWj0rZTvf8BAVpjWGf0S17JbYAC1sCsxjZclnKlVr8J9T3CASBQVqPjuZgCYqiPh
         vIzWKt5V6PuNg==
Date:   Mon, 22 Nov 2021 12:29:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: gpi: Remove unnecessary print function
 dev_err()
Message-ID: <YZs/wq+orcaS+9UK@matsya>
References: <20211116013306.784-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116013306.784-1-vulab@iscas.ac.cn>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-11-21, 01:33, Xu Wang wrote:
> The print function dev_err() is redundant because
> platform_get_irq() already prints an error.

Applied, thanks

-- 
~Vinod
