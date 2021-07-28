Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34A03D8C33
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 12:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhG1KvR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 06:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231238AbhG1KvR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 06:51:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32BA560F9B;
        Wed, 28 Jul 2021 10:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627469476;
        bh=oloRDHGr70LSWn6f1PlAcuRsloNxYbQUaJ/h2SL/L8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iV0IDyqXDnlR4pJhEs1pbE3uw8P84dBCt0bFqeEXNz5VIPKSlhrygm1IaKj6LDzfV
         tXHdtC/mjmjgtS15zTKcU/xUUVZUgkX0ecZpKQS546kxzVJnZgN1zFjnVQe55+uDmS
         H+J+VRf6RCU5R4hr8UuytKZNM/ug4h9L+Rt7YWrhIAmoZyg0Sgkl5znkF6DISBx6qc
         6ffg/pI9UyidaSuDvptkJ7QCzyhrdwIIeOEMpiuU8/8dhQnrTAOmgyKRXjvO4e6EPp
         /8gnWPjTDTS3sbB+3+WG7Ff23sY6UU87SlGCefz4wIqf8stH6sR18c4tSfgLfLQ+Ez
         TD2c9n0ceUyOw==
Date:   Wed, 28 Jul 2021 16:21:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: at_xdmac: use platform_driver_register
Message-ID: <YQE2m3ywZpJVY3tq@matsya>
References: <20210728094607.50589-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210728094607.50589-1-clement.leger@bootlin.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-07-21, 11:46, Clément Léger wrote:
> When using SCMI clocks, the clocks are probed later than subsys initcall
> level. This driver uses platform_driver_probe which is not compatible with
> deferred probing and won't be probed again later if probe function fails
> due to clocks not being available at that time.
> 
> This patch replaces the use of platform_driver_probe with
> platform_driver_register which will allow probing the driver later again
> when clocks will be available.

Applied, thanks

-- 
~Vinod
