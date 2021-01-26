Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA583304BBF
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 22:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbhAZVvV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 16:51:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388919AbhAZRNs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Jan 2021 12:13:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 313D12083E;
        Tue, 26 Jan 2021 17:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611681188;
        bh=zeRAXBPHyrYGlg8LWhVGGxP6IcIM9y3Qvyh+iK4YuXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWNGmAmi5q0/i3gKXnVIzQh33h82JBa8M/tote+cUaNzplCNnVzEZvySbI4txacLx
         y1K1xJ0g7gyi5+iagzX6GqmikmJvJ7RHipNJmjRLb1KoWUL82Ceq9iYrutFAsl3bSH
         6vvblgZ5CP0bDy7R1063+IPzAyaH6GoUZcX8uPML+OQPvlCIcOCVlRIZ74KcXmSmZx
         yOEKoAaYYeR7Fh4xDQ7PUYWOnAec8aonaxhAbUiXe91fzV0P6vFziEhZ2uNkPgJWSr
         B/Yt9iiRHLDZ3Nd0/8eK2MC7Gj06H2LW0jjf/9+4f3f0gJYdTHl8Wyp5j7DcGjMGTV
         ALL3S/zH1OGSg==
Date:   Tue, 26 Jan 2021 22:43:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     shawnguo@kernel.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: imx-sdma: Remove platform data support
Message-ID: <20210126171303.GQ2771@vkoul-mobl>
References: <20210118121549.1625217-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118121549.1625217-1-festevam@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-01-21, 09:15, Fabio Estevam wrote:
> Since 5.10-rc1, i.MX has been converted to a devicetree-only platform.
> 
> The platform data support in this driver was only used for non-DT
> platforms.
> 
> Remove the platform data support as it has no more users.

Applied both, thanks

-- 
~Vinod
